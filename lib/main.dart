import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:excel/excel.dart' as xlsx;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const _supabaseUrl = String.fromEnvironment('SUPABASE_URL');
const _supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (_supabaseUrl.isNotEmpty && _supabaseAnonKey.isNotEmpty) {
    await Supabase.initialize(url: _supabaseUrl, anonKey: _supabaseAnonKey);
  }
  runApp(const MotoSheetApp());
}

const _bg = Color(0xFFF5F2EA);
const _surface = Colors.white;
const _ink = Color(0xFF0F172A);
const _muted = Color(0xFF64748B);
const _line = Color(0x140F172A);
const _accent = Color(0xFFFF7A1A);
const _plateBlue = Color(0xFF155CA8);
const _plateRed = Color(0xFFD9251D);
const _success = Color(0xFF10B981);
const _danger = Color(0xFFDC2626);

class MotoSheetApp extends StatelessWidget {
  const MotoSheetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MotoSheet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: _bg,
        colorScheme: ColorScheme.fromSeed(seedColor: _accent),
        fontFamily: 'Roboto',
      ),
      home: const MotoSheetHome(),
    );
  }
}

enum EntryStatus { parked, checkedOut }

enum ScanSession { morning, afternoon }

enum ScanClassification { company, visitor }

class RegisteredMotor {
  const RegisteredMotor({
    required this.ref,
    required this.no,
    required this.company,
    this.type = 'FOC',
    this.months = 12,
    required this.expiry,
    required this.brand,
    required this.model,
    required this.plate,
  });

  final String ref;
  final String no;
  final String company;
  final String type;
  final int months;
  final DateTime expiry;
  final String brand;
  final String model;
  final String plate;

  bool isActiveOn(DateTime date) => !expiry.isBefore(DateUtils.dateOnly(date));
  String get platePrefix => plate.split('-').first;
  String get plateNumber => plate.contains('-') ? plate.split('-').last : '';
}

class ParkingEntry {
  ParkingEntry({
    required this.id,
    required this.plate,
    required this.city,
    required this.company,
    required this.classification,
    required this.session,
    required this.brand,
    required this.model,
    required this.color,
    required this.slot,
    required this.timeIn,
    required this.scannedAt,
    required this.photoSeed,
    this.ref = '',
    this.no = '',
    this.type = '',
    this.months,
    this.expiry,
    this.status = EntryStatus.parked,
    this.timeOut,
    this.note = '',
  });

  final int id;
  String plate;
  String city;
  String company;
  ScanClassification classification;
  ScanSession session;
  String ref;
  String no;
  String type;
  int? months;
  DateTime? expiry;
  String brand;
  String model;
  String color;
  String slot;
  String timeIn;
  DateTime scannedAt;
  int photoSeed;
  EntryStatus status;
  String? timeOut;
  String note;
}

class PlateDetection {
  const PlateDetection({required this.plate, required this.city});

  final String plate;
  final String city;
}

class DailyReportRow {
  DailyReportRow({
    required this.ref,
    required this.no,
    required this.company,
    required this.type,
    required this.months,
    required this.expiry,
    required this.brand,
    required this.model,
    required this.plate,
    required this.morning,
    required this.afternoon,
  });

  factory DailyReportRow.fromEntry(ParkingEntry entry) {
    return DailyReportRow(
      ref: entry.ref,
      no: entry.no,
      company: entry.company,
      type: entry.type,
      months: entry.months,
      expiry: entry.expiry,
      brand: entry.brand,
      model: entry.model,
      plate: entry.plate,
      morning: entry.session == ScanSession.morning,
      afternoon: entry.session == ScanSession.afternoon,
    );
  }

  final String ref;
  final String no;
  final String company;
  final String type;
  final int? months;
  final DateTime? expiry;
  final String brand;
  final String model;
  final String plate;
  bool morning;
  bool afternoon;

  String get platePrefix => plate.split('-').first;
  String get plateNumber => plate.contains('-') ? plate.split('-').last : '';

  void mark(ScanSession session) {
    if (session == ScanSession.morning) morning = true;
    if (session == ScanSession.afternoon) afternoon = true;
  }
}

class MotoSheetBackend {
  MotoSheetBackend._();

  static bool get isConfigured =>
      _supabaseUrl.isNotEmpty && _supabaseAnonKey.isNotEmpty;
  static SupabaseClient? get _client =>
      isConfigured ? Supabase.instance.client : null;

  static Future<List<RegisteredMotor>> fetchRegisteredMotors() async {
    final client = _client;
    if (client == null) return const [];
    final rows = await client
        .from('registered_motors')
        .select(
          'ref,no,type,months,expiry_date,brand,model,plate,companies(name)',
        )
        .order('plate');
    return rows.map<RegisteredMotor>((row) {
      final company = row['companies'] is Map
          ? row['companies']['name'] as String?
          : null;
      return RegisteredMotor(
        ref: row['ref']?.toString() ?? '',
        no: row['no']?.toString() ?? '',
        company: company ?? 'UNKNOWN',
        type: row['type']?.toString() ?? 'FOC',
        months: row['months'] is int
            ? row['months'] as int
            : int.tryParse(row['months']?.toString() ?? '') ?? 12,
        expiry: DateTime.parse(row['expiry_date'].toString()),
        brand: row['brand']?.toString() ?? '',
        model: row['model']?.toString() ?? '',
        plate: row['plate']?.toString() ?? '',
      );
    }).toList();
  }

  static Future<List<ParkingEntry>> fetchScanRecords(DateTime date) async {
    final client = _client;
    if (client == null) return const [];
    final dateText = DateFormat('yyyy-MM-dd').format(date);
    final rows = await client
        .from('scan_records')
        .select(
          'classification,plate,city,company_name,ref,no,type,months,expiry_date,brand,model,scanned_at,scan_sessions!inner(scan_date,session_type)',
        )
        .eq('scan_sessions.scan_date', dateText)
        .order('scanned_at');

    var nextId = 1;
    return rows.map<ParkingEntry>((row) {
      final sessionRow = row['scan_sessions'] is Map
          ? row['scan_sessions'] as Map
          : const {};
      final scannedAt =
          DateTime.tryParse(row['scanned_at']?.toString() ?? '')?.toLocal() ??
          DateTime.now();
      final session = sessionRow['session_type']?.toString() == 'afternoon'
          ? ScanSession.afternoon
          : ScanSession.morning;
      final expiryText = row['expiry_date']?.toString();
      return ParkingEntry(
        id: nextId++,
        plate: row['plate']?.toString() ?? '',
        city: row['city']?.toString() ?? 'PHNOM PENH',
        company: row['company_name']?.toString() ?? 'VISITOR',
        classification: row['classification']?.toString() == 'visitor'
            ? ScanClassification.visitor
            : ScanClassification.company,
        session: session,
        ref: row['ref']?.toString() ?? '',
        no: row['no']?.toString() ?? '',
        type: row['type']?.toString() ?? '',
        months: row['months'] is int
            ? row['months'] as int
            : int.tryParse(row['months']?.toString() ?? ''),
        expiry: expiryText == null ? null : DateTime.tryParse(expiryText),
        brand: row['brand']?.toString() ?? '',
        model: row['model']?.toString() ?? '',
        color: '',
        slot: '',
        timeIn: DateFormat('HH:mm').format(scannedAt),
        scannedAt: scannedAt,
        photoSeed: nextId,
      );
    }).toList();
  }

  static Future<VisitorMotorDetails?> fetchKnownVisitor(String plate) async {
    final client = _client;
    if (client == null) return null;
    final row = await client
        .from('known_visitors')
        .select('brand,model')
        .eq('plate', plate)
        .maybeSingle();
    if (row == null) return null;
    final brand = row['brand']?.toString() ?? '';
    final model = row['model']?.toString() ?? '';
    if (brand.isEmpty || model.isEmpty) return null;
    return VisitorMotorDetails(brand: brand, model: model);
  }

  static Future<void> rememberKnownVisitor(ParkingEntry entry) async {
    final client = _client;
    if (client == null || entry.classification != ScanClassification.visitor) {
      return;
    }

    final existing = await client
        .from('known_visitors')
        .select('visit_count')
        .eq('plate', entry.plate)
        .maybeSingle();
    final currentCount = existing?['visit_count'] is int
        ? existing!['visit_count'] as int
        : int.tryParse(existing?['visit_count']?.toString() ?? '') ?? 0;

    await client.from('known_visitors').upsert({
      'plate': entry.plate,
      'city': entry.city,
      'brand': entry.brand,
      'model': entry.model,
      'last_seen_at': entry.scannedAt.toUtc().toIso8601String(),
      'visit_count': currentCount + 1,
    }, onConflict: 'plate');
  }

  static Future<void> pushScanRecord(ParkingEntry entry) async {
    final client = _client;
    if (client == null) return;

    final session = await client
        .from('scan_sessions')
        .upsert({
          'scan_date': DateFormat('yyyy-MM-dd').format(entry.scannedAt),
          'session_type': entry.session.name,
        }, onConflict: 'scan_date,session_type')
        .select('id')
        .single();

    await client.from('scan_records').upsert({
      'scan_session_id': session['id'],
      'classification': entry.classification == ScanClassification.company
          ? 'company'
          : 'visitor',
      'plate': entry.plate,
      'city': entry.city,
      'company_name': entry.company,
      'ref': entry.ref.isEmpty ? null : entry.ref,
      'no': entry.no.isEmpty ? null : entry.no,
      'type': entry.type.isEmpty ? null : entry.type,
      'months': entry.months,
      'expiry_date': entry.expiry == null
          ? null
          : DateFormat('yyyy-MM-dd').format(entry.expiry!),
      'brand': entry.brand,
      'model': entry.model,
      'scanned_at': entry.scannedAt.toUtc().toIso8601String(),
    }, onConflict: 'scan_session_id,plate');
  }
}

const _cambodianCities = [
  'PHNOM PENH',
  'BANTEAY MEANCHEY',
  'BATTAMBANG',
  'KAMPONG CHAM',
  'KAMPONG CHHNANG',
  'KAMPONG SPEU',
  'KAMPONG THOM',
  'KAMPOT',
  'KANDAL',
  'KEP',
  'KOH KONG',
  'KRATIE',
  'MONDULKIRI',
  'ODDAR MEANCHEY',
  'PAILIN',
  'PREAH SIHANOUK',
  'PREAH VIHEAR',
  'PREY VENG',
  'PURSAT',
  'RATANAKIRI',
  'SIEM REAP',
  'STUNG TRENG',
  'SVAY RIENG',
  'TAKEO',
  'TBONG KHMUM',
];

PlateDetection? extractPlateDetection(String text) {
  final plate = extractPlateNumber(text);
  if (plate == null) return null;
  return PlateDetection(
    plate: plate,
    city: extractPlateCity(text) ?? 'PHNOM PENH',
  );
}

String? extractPlateNumber(String text) {
  final cleaned = text
      .toUpperCase()
      .replaceAll(RegExp(r'[\u2010-\u2015]'), '-')
      .replaceAll(RegExp(r'[^A-Z0-9\-\s]'), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
  if (cleaned.isEmpty) return null;

  final candidates = <String>[];
  final joined = cleaned.replaceAll(RegExp(r'[\s-]+'), '');

  for (final match in RegExp(
    r'\b([A-Z]{2,3})\s*-?\s*([A-Z])?\s*-?\s*([0-9OILSBGZ]{4})\b',
  ).allMatches(cleaned)) {
    final province = match.group(1)!;
    final series = match.group(2);
    final number = _normalizeOcrDigits(match.group(3)!);
    if (series == null) {
      candidates.add('$province-$number');
    } else {
      candidates.add('$province$series-$number');
    }
  }

  for (final match in RegExp(
    r'\b([0-9OIL][A-Z]{1,3})\s*-?\s*([0-9OILSBGZ]{4})\b',
  ).allMatches(cleaned)) {
    final prefix =
        '${_normalizeOcrDigits(match.group(1)![0])}${match.group(1)!.substring(1)}';
    final number = _normalizeOcrDigits(match.group(2)!);
    candidates.add('$prefix-$number');
  }

  for (final match in RegExp(
    r'([A-Z]{2,3})([A-Z]?)([0-9OILSBGZ]{4})',
  ).allMatches(joined)) {
    final province = match.group(1)!;
    final series = match.group(2);
    final number = _normalizeOcrDigits(match.group(3)!);
    candidates.add(
      series == null || series.isEmpty
          ? '$province-$number'
          : '$province$series-$number',
    );
  }

  for (final match in RegExp(
    r'([0-9OIL][A-Z]{1,3})([0-9OILSBGZ]{4})',
  ).allMatches(joined)) {
    final rawPrefix = match.group(1)!;
    final prefix =
        '${_normalizeOcrDigits(rawPrefix[0])}${rawPrefix.substring(1)}';
    final number = _normalizeOcrDigits(match.group(2)!);
    candidates.add('$prefix-$number');
  }

  if (candidates.isEmpty) return null;
  candidates.sort((a, b) => _plateScore(b).compareTo(_plateScore(a)));
  return candidates.first;
}

String? extractPlateCity(String text) {
  final normalized = text
      .toUpperCase()
      .replaceAll('0', 'O')
      .replaceAll(RegExp(r'[^A-Z\s]'), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
  if (normalized.isEmpty) return null;

  for (final city in _cambodianCities) {
    if (normalized.contains(city)) return city;
  }

  final lines = text
      .split(RegExp(r'[\r\n]+'))
      .map(
        (line) => line
            .toUpperCase()
            .replaceAll(RegExp(r'[^A-Z\s]'), ' ')
            .replaceAll(RegExp(r'\s+'), ' ')
            .trim(),
      )
      .where((line) => line.length >= 3 && !RegExp(r'\d').hasMatch(line))
      .toList();
  if (lines.isEmpty) return null;
  return lines.last;
}

String _normalizeOcrDigits(String value) {
  const replacements = {
    'O': '0',
    'I': '1',
    'L': '1',
    'S': '5',
    'B': '8',
    'G': '6',
    'Z': '2',
  };
  return value.split('').map((char) => replacements[char] ?? char).join();
}

int _plateScore(String plate) {
  var score = plate.length;
  if (plate.contains('-')) score += 2;
  if (RegExp(r'^\d[A-Z]{1,3}-\d{4}$').hasMatch(plate)) score += 4;
  if (RegExp(r'^[A-Z]{2,4}-\d{4}$').hasMatch(plate)) score += 2;
  return score;
}

DateTime _todayAt(String value) {
  final pieces = value.split(':');
  final now = DateTime.now();
  return DateTime(
    now.year,
    now.month,
    now.day,
    int.parse(pieces[0]),
    int.parse(pieces[1]),
  );
}

String _sessionLabel(ScanSession session) => switch (session) {
  ScanSession.morning => 'Morning',
  ScanSession.afternoon => 'Afternoon',
};

String _classificationLabel(ScanClassification classification) =>
    switch (classification) {
      ScanClassification.company => 'COMPANY',
      ScanClassification.visitor => 'VISITOR',
    };

class MotoSheetHome extends StatefulWidget {
  const MotoSheetHome({super.key});

  @override
  State<MotoSheetHome> createState() => _MotoSheetHomeState();
}

class _MotoSheetHomeState extends State<MotoSheetHome>
    with WidgetsBindingObserver {
  final _random = Random();
  ScanSession _selectedSession = ScanSession.morning;
  final _registeredMotors = <RegisteredMotor>[
    RegisteredMotor(
      ref: '2601',
      no: '004',
      company: 'SM Global',
      expiry: DateTime(2026, 12, 31),
      brand: 'Honda',
      model: 'Dream',
      plate: '1DC-1003',
    ),
    RegisteredMotor(
      ref: '2601',
      no: '005',
      company: 'SM Global',
      expiry: DateTime(2026, 12, 31),
      brand: 'Honda',
      model: 'Wave',
      plate: '1HH-4722',
    ),
    RegisteredMotor(
      ref: '2601',
      no: '006',
      company: 'Alpha Tower',
      expiry: DateTime(2026, 12, 31),
      brand: 'Yamaha',
      model: 'Fino',
      plate: '2K-6326',
    ),
    RegisteredMotor(
      ref: '2601',
      no: '007',
      company: 'Borey Office',
      expiry: DateTime(2025, 12, 31),
      brand: 'Honda',
      model: 'Click',
      plate: 'SHV-6789',
    ),
  ];
  final _entries = <ParkingEntry>[
    ParkingEntry(
      id: 1,
      plate: '1HH-4722',
      city: 'PHNOM PENH',
      company: 'SM Global',
      classification: ScanClassification.company,
      session: ScanSession.morning,
      ref: '2601',
      no: '005',
      type: 'FOC',
      months: 12,
      expiry: DateTime(2026, 12, 31),
      brand: 'Honda',
      model: 'Wave',
      color: '',
      slot: 'A-12',
      timeIn: '09:12',
      scannedAt: _todayAt('09:12'),
      photoSeed: 0,
    ),
    ParkingEntry(
      id: 2,
      plate: '2K-6326',
      city: 'PHNOM PENH',
      company: 'Alpha Tower',
      classification: ScanClassification.company,
      session: ScanSession.morning,
      ref: '2601',
      no: '006',
      type: 'FOC',
      months: 12,
      expiry: DateTime(2026, 12, 31),
      brand: 'Yamaha',
      model: 'Fino',
      color: '',
      slot: 'A-13',
      timeIn: '09:18',
      scannedAt: _todayAt('09:18'),
      photoSeed: 1,
    ),
    ParkingEntry(
      id: 3,
      plate: 'PP-1234',
      city: 'PHNOM PENH',
      company: 'VISITOR',
      classification: ScanClassification.visitor,
      session: ScanSession.morning,
      brand: 'Honda',
      model: 'Dream',
      color: '',
      slot: 'A-14',
      timeIn: '09:24',
      scannedAt: _todayAt('09:24'),
      photoSeed: 2,
    ),
    ParkingEntry(
      id: 4,
      plate: 'SHV-6789',
      city: 'PREAH SIHANOUK',
      company: 'VISITOR',
      classification: ScanClassification.visitor,
      session: ScanSession.morning,
      brand: 'Honda',
      model: 'Click',
      color: '',
      slot: 'A-15',
      timeIn: '09:31',
      scannedAt: _todayAt('09:31'),
      photoSeed: 3,
    ),
  ];

  String _query = '';
  String _filter = 'all';
  bool _isSyncingRegistry = false;
  final _knownVisitors = <String, VisitorMotorDetails>{};

  List<ParkingEntry> get _selectedSessionEntries =>
      _entries.where((entry) => entry.session == _selectedSession).toList();
  int get _visitorCount => _entries
      .where((entry) => entry.classification == ScanClassification.visitor)
      .length;
  int get _expiredCount => _registeredMotors
      .where((motor) => !motor.isActiveOn(DateTime.now()))
      .length;
  int get _pendingCount {
    final scanned = _selectedSessionEntries
        .map((entry) => _normalize(entry.plate))
        .toSet();
    return _registeredMotors
        .where((motor) => !scanned.contains(_normalize(motor.plate)))
        .length;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (MotoSheetBackend.isConfigured) {
      _entries.clear();
    }
    _loadRemoteRegistry();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadRemoteRegistry(showToast: false);
    }
  }

  Future<void> _loadRemoteRegistry({bool showToast = true}) async {
    if (!MotoSheetBackend.isConfigured) return;
    if (_isSyncingRegistry) return;
    setState(() => _isSyncingRegistry = true);
    try {
      final results = await Future.wait([
        MotoSheetBackend.fetchRegisteredMotors(),
        MotoSheetBackend.fetchScanRecords(DateTime.now()),
      ]);
      final motors = results[0] as List<RegisteredMotor>;
      final scanRecords = results[1] as List<ParkingEntry>;
      if (!mounted || motors.isEmpty) return;
      setState(() {
        _registeredMotors
          ..clear()
          ..addAll(motors);
        _entries
          ..clear()
          ..addAll(scanRecords);
      });
      if (showToast) {
        _toast(
          'Synced · ${motors.length} motors · ${scanRecords.length} scans today',
        );
      }
    } catch (_) {
      if (mounted) _toast('Registry sync failed');
    } finally {
      if (mounted) setState(() => _isSyncingRegistry = false);
    }
  }

  List<ParkingEntry> get _visibleEntries {
    final normalizedQuery = _normalize(_query);
    return _entries.where((entry) {
      if (_filter == 'scanned' && entry.session != _selectedSession) {
        return false;
      }
      if (_filter == 'visitor' &&
          entry.classification != ScanClassification.visitor) {
        return false;
      }
      if (_filter == 'expired' &&
          (entry.expiry == null ||
              !entry.expiry!.isBefore(DateUtils.dateOnly(DateTime.now())))) {
        return false;
      }
      if (normalizedQuery.isNotEmpty) {
        final searchable = _normalize(
          '${entry.plate} ${entry.company} ${entry.brand} ${entry.model} ${entry.ref} ${entry.no}',
        );
        if (!searchable.contains(normalizedQuery)) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  String _normalize(String value) =>
      value.toLowerCase().replaceAll(RegExp(r'[\s.]'), '');
  String _now() => DateFormat('HH:mm').format(DateTime.now());
  String? _scanTimeFor(String plate, ScanSession session) {
    for (final entry in _entries) {
      if (_normalize(entry.plate) == _normalize(plate) &&
          entry.session == session) {
        return entry.timeIn;
      }
    }
    return null;
  }

  RegisteredMotor? _lookupActiveMotor(String plate, DateTime date) {
    for (final motor in _registeredMotors) {
      if (_normalize(motor.plate) == _normalize(plate) &&
          motor.isActiveOn(date)) {
        return motor;
      }
    }
    return null;
  }

  String _nextSlot() {
    final used = _entries
        .map((entry) => RegExp(r'^B-(\d+)$').firstMatch(entry.slot))
        .whereType<RegExpMatch>()
        .map((match) => int.parse(match.group(1)!))
        .toList();
    final next = (used.isEmpty ? 0 : used.reduce(max)) + 1;
    return 'B-${next.toString().padLeft(2, '0')}';
  }

  Future<void> _openScanner() async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) =>
            ScanScreen(scannedCount: _entries.length, onSave: _saveDetection),
      ),
    );
  }

  Future<bool> _saveDetection(PlateDetection detection) async {
    final scannedAt = DateTime.now();
    final plate =
        extractPlateNumber(detection.plate) ?? detection.plate.toUpperCase();
    final registered = _lookupActiveMotor(plate, scannedAt);
    VisitorMotorDetails? visitorDetails;
    var repeatVisitor = false;
    if (registered == null) {
      visitorDetails = _knownVisitors[_normalize(plate)];
      if (visitorDetails == null && MotoSheetBackend.isConfigured) {
        try {
          visitorDetails = await MotoSheetBackend.fetchKnownVisitor(plate);
        } catch (_) {
          visitorDetails = null;
        }
      }
      repeatVisitor = visitorDetails != null;
      if (!mounted) return false;
      visitorDetails ??= await showDialog<VisitorMotorDetails>(
        context: context,
        builder: (_) => VisitorMotorDialog(plate: plate),
      );
      if (!mounted || visitorDetails == null) return false;
    }
    final entry = ParkingEntry(
      id: (_entries.map((e) => e.id).fold(0, max)) + 1,
      plate: plate,
      city: detection.city,
      company: registered?.company ?? 'VISITOR',
      classification: registered == null
          ? ScanClassification.visitor
          : ScanClassification.company,
      session: _selectedSession,
      ref: registered?.ref ?? '',
      no: registered?.no ?? '',
      type: registered?.type ?? '',
      months: registered?.months,
      expiry: registered?.expiry,
      brand: registered?.brand ?? visitorDetails!.brand,
      model: registered?.model ?? visitorDetails!.model,
      color: '',
      slot: _nextSlot(),
      timeIn: DateFormat('HH:mm').format(scannedAt),
      scannedAt: scannedAt,
      photoSeed: _random.nextInt(10),
    );
    if (!mounted) return false;
    if (entry.classification == ScanClassification.visitor) {
      _knownVisitors[_normalize(entry.plate)] = VisitorMotorDetails(
        brand: entry.brand,
        model: entry.model,
      );
    }
    setState(() => _entries.insert(0, entry));
    _toast(
      repeatVisitor
          ? 'Repeat visitor · ${entry.brand} ${entry.model}'
          : 'Added · ${entry.plate} → ${entry.slot}',
    );
    try {
      await MotoSheetBackend.pushScanRecord(entry);
      try {
        await MotoSheetBackend.rememberKnownVisitor(entry);
      } catch (_) {
        // Scan records are more important than the repeat-visitor cache.
      }
      if (mounted && MotoSheetBackend.isConfigured) {
        _toast('Synced · ${entry.plate}');
      }
    } catch (_) {
      if (mounted && MotoSheetBackend.isConfigured) {
        _toast('Saved locally · sync failed');
      }
    }
    return true;
  }

  Future<void> _openEntry(ParkingEntry entry) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DetailSheet(
        entry: entry,
        onCheckout: () {
          setState(() {
            entry.status = EntryStatus.checkedOut;
            entry.timeOut = _now();
          });
          Navigator.pop(context);
          _toast('Checked out · ${entry.plate}');
        },
        onDelete: () {
          setState(() => _entries.removeWhere((e) => e.id == entry.id));
          Navigator.pop(context);
          _toast('Entry removed');
        },
      ),
    );
  }

  Future<void> _openExportSheet() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ExportSheet(entries: _entries, onExport: _exportAndShare),
    );
  }

  Future<void> _confirmClearRecords() async {
    if (_entries.isEmpty) {
      _toast('No records to clear');
      return;
    }
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear all records?'),
        content: const Text(
          'All scanned parking records will be removed. This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: _danger,
              foregroundColor: Colors.white,
            ),
            child: const Text('Yes, clear'),
          ),
        ],
      ),
    );
    if (!mounted || confirmed != true) return;
    setState(() {
      _entries.clear();
      _filter = 'all';
      _query = '';
    });
    _toast('All records cleared');
  }

  Future<void> _exportAndShare(
    List<ParkingEntry> rows,
    Set<String> columns,
  ) async {
    if (rows.isEmpty) {
      _toast('No rows to export');
      return;
    }
    final dates = rows
        .map((entry) => DateFormat('yyyy-MM-dd').format(entry.scannedAt))
        .toSet();
    final datePart = dates.length == 1 ? dates.first : 'multiple_dates';
    final filename = 'motosheet_${datePart}_phnom_penh.xlsx';
    final excel = xlsx.Excel.createExcel();
    final sheet = excel['MotoSheet'];
    excel.delete('Sheet1');

    final reportRows = _buildDailyReportRows(rows);
    sheet.appendRow(
      columns.map((c) => xlsx.TextCellValue(_columnLabel(c))).toList(),
    );
    for (final row in reportRows) {
      sheet.appendRow(
        columns
            .map(
              (column) => xlsx.TextCellValue(_reportColumnValue(row, column)),
            )
            .toList(),
      );
    }

    final bytes = excel.encode();
    if (bytes == null) {
      _toast('Export failed');
      return;
    }
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    await SharePlus.instance.share(
      ShareParams(
        files: [
          XFile(
            file.path,
            mimeType:
                'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
          ),
        ],
        subject: 'MotoSheet export',
        text: 'MotoSheet parking list · ${rows.length} rows',
      ),
    );
    if (mounted) {
      Navigator.pop(context);
      _toast('Sheet shared · ${rows.length} rows');
    }
  }

  String _columnLabel(String key) => switch (key) {
    'plate' => 'Plate',
    'ref' => 'Ref',
    'no' => 'No.',
    'company' => 'Company',
    'type' => 'Type',
    'months' => 'Months',
    'expiry' => 'Expiry',
    'brand' => 'Brand',
    'model' => 'Model',
    'plate_prefix' => 'Plate Prefix',
    'plate_number' => 'Plate Number',
    'morning' => 'Morning',
    'afternoon' => 'Afternoon',
    _ => key,
  };

  List<DailyReportRow> _buildDailyReportRows(List<ParkingEntry> entries) {
    final rows = <String, DailyReportRow>{};
    for (final entry in entries) {
      final key =
          '${DateFormat('yyyy-MM-dd').format(entry.scannedAt)}:${entry.plate}';
      final existing = rows[key];
      if (existing == null) {
        rows[key] = DailyReportRow.fromEntry(entry);
      } else {
        existing.mark(entry.session);
      }
    }
    return rows.values.toList()..sort((a, b) {
      final companyCompare = a.company.compareTo(b.company);
      return companyCompare != 0 ? companyCompare : a.plate.compareTo(b.plate);
    });
  }

  String _reportColumnValue(DailyReportRow row, String key) => switch (key) {
    'ref' => row.ref,
    'no' => row.no,
    'company' => row.company,
    'type' => row.type,
    'months' => row.months?.toString() ?? '',
    'expiry' =>
      row.expiry == null ? '' : DateFormat('dd-MMM-yy').format(row.expiry!),
    'brand' => row.brand,
    'model' => row.model,
    'plate_prefix' => row.platePrefix,
    'plate_number' => row.plateNumber,
    'morning' => row.morning ? '✓' : '',
    'afternoon' => row.afternoon ? '✓' : '',
    _ => '',
  };

  void _toast(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: _success, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          backgroundColor: _ink,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.fromLTRB(18, 20, 18, 0),
          duration: const Duration(milliseconds: 2400),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final visible = _visibleEntries;
    final scannedCount = _selectedSessionEntries.length;
    final registeredCount = _registeredMotors.length;
    final roundTotal = max(registeredCount, scannedCount + _pendingCount);
    final progress = roundTotal == 0
        ? 0.0
        : (scannedCount / roundTotal).clamp(0.0, 1.0);
    final dateLabel = DateFormat('EEE d MMM').format(DateTime.now());
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RoundSwitcher(
                        selected: _selectedSession,
                        morningDone: _entries
                            .where(
                              (entry) => entry.session == ScanSession.morning,
                            )
                            .length,
                        afternoonDone: _entries
                            .where(
                              (entry) => entry.session == ScanSession.afternoon,
                            )
                            .length,
                        totalCount: registeredCount,
                        onChanged: (session) => setState(() {
                          _selectedSession = session;
                          if (_filter == 'pending') _filter = 'all';
                        }),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${_sessionLabel(_selectedSession)} round',
                                  style: const TextStyle(
                                    color: _ink,
                                    fontSize: 24,
                                    height: 1,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  dateLabel,
                                  style: const TextStyle(
                                    color: _muted,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (_isSyncingRegistry)
                            const StatusBadge(
                              icon: Icons.sync_rounded,
                              label: 'syncing',
                              color: _muted,
                            ),
                          if (!_isSyncingRegistry && _expiredCount > 0)
                            StatusBadge(
                              icon: Icons.circle,
                              label: '$_expiredCount expired',
                              color: _danger,
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 4,
                          backgroundColor: _ink.withValues(alpha: .08),
                          valueColor: const AlwaysStoppedAnimation(
                            Color(0xFFFFC400),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '$scannedCount/$roundTotal  ·  ${(progress * 100).round()}%',
                            style: const TextStyle(
                              color: _muted,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '$_pendingCount pending',
                            style: const TextStyle(
                              color: _muted,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: (value) =>
                                  setState(() => _query = value),
                              decoration: InputDecoration(
                                hintText: 'Search plate, company, model...',
                                prefixIcon: const Icon(
                                  Icons.search_rounded,
                                  color: _muted,
                                ),
                                filled: true,
                                fillColor: _surface,
                                contentPadding: EdgeInsets.zero,
                                enabledBorder: _inputBorder(),
                                focusedBorder: _inputBorder(color: _ink),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          _SquareButton(
                            icon: Icons.delete_outline_rounded,
                            color: _danger,
                            tooltip: 'Clear all records',
                            onTap: _confirmClearRecords,
                          ),
                        ],
                      ),
                      const SizedBox(height: 9),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            FilterChipButton(
                              label: 'All  ${_entries.length}',
                              active: _filter == 'all',
                              onTap: () => setState(() => _filter = 'all'),
                            ),
                            const SizedBox(width: 8),
                            FilterChipButton(
                              label: 'Scanned  $scannedCount',
                              active: _filter == 'scanned',
                              onTap: () => setState(() => _filter = 'scanned'),
                            ),
                            const SizedBox(width: 8),
                            FilterChipButton(
                              label: 'Pending',
                              active: _filter == 'pending',
                              onTap: () => setState(() => _filter = 'pending'),
                            ),
                            const SizedBox(width: 8),
                            FilterChipButton(
                              label: 'Visitor  $_visitorCount',
                              active: _filter == 'visitor',
                              onTap: () => setState(() => _filter = 'visitor'),
                            ),
                            const SizedBox(width: 8),
                            FilterChipButton(
                              label: 'Expired',
                              active: _filter == 'expired',
                              onTap: () => setState(() => _filter = 'expired'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _filter == 'pending'
                      ? PendingList(
                          motors: _registeredMotors
                              .where(
                                (motor) => !_selectedSessionEntries
                                    .map((entry) => _normalize(entry.plate))
                                    .contains(_normalize(motor.plate)),
                              )
                              .toList(),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(12, 10, 12, 112),
                          itemBuilder: (context, index) {
                            if (visible.isEmpty) return const EmptyState();
                            final entry = visible[index];
                            return EntryCard(
                              entry: entry,
                              morningTime: _scanTimeFor(
                                entry.plate,
                                ScanSession.morning,
                              ),
                              afternoonTime: _scanTimeFor(
                                entry.plate,
                                ScanSession.afternoon,
                              ),
                              onTap: () => _openEntry(entry),
                            );
                          },
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 10),
                          itemCount: visible.isEmpty ? 1 : visible.length,
                        ),
                ),
              ],
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    FilledButton.tonalIcon(
                      onPressed: _openExportSheet,
                      icon: const Icon(Icons.description_outlined, size: 18),
                      label: const Text('Report'),
                      style: FilledButton.styleFrom(
                        backgroundColor: _surface,
                        foregroundColor: _ink,
                        minimumSize: const Size(104, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: const BorderSide(color: _line),
                        ),
                        elevation: 8,
                        shadowColor: Colors.black.withValues(alpha: .18),
                      ),
                    ),
                    const Spacer(),
                    FilledButton.icon(
                      onPressed: _openScanner,
                      icon: const Icon(Icons.document_scanner_rounded),
                      label: const Text('Scan plate'),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC400),
                        foregroundColor: _ink,
                        minimumSize: const Size(166, 60),
                        textStyle: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 10,
                        shadowColor: const Color(
                          0xFFFFC400,
                        ).withValues(alpha: .45),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScanScreen extends StatefulWidget {
  const ScanScreen({
    super.key,
    required this.scannedCount,
    required this.onSave,
  });

  final int scannedCount;
  final Future<bool> Function(PlateDetection detection) onSave;

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String? _plate;
  String? _city;
  bool _flashOn = false;
  bool _isSaving = false;
  int _savedInSession = 0;
  bool _isStartingCamera = true;
  bool _isProcessingImage = false;
  bool _hasCameraPermission = false;
  String? _cameraError;
  DateTime _lastScan = DateTime.fromMillisecondsSinceEpoch(0);
  CameraController? _cameraController;
  CameraDescription? _camera;
  late final TextRecognizer _textRecognizer;

  @override
  void initState() {
    super.initState();
    _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    _startCamera();
  }

  @override
  void dispose() {
    _cameraController?.stopImageStream().catchError((_) {});
    _cameraController?.dispose();
    _textRecognizer.close();
    super.dispose();
  }

  Future<void> _startCamera() async {
    final permission = await Permission.camera.request();
    if (!mounted) return;
    if (!permission.isGranted) {
      setState(() {
        _hasCameraPermission = false;
        _isStartingCamera = false;
        _cameraError = 'Camera permission is needed to scan plates.';
      });
      return;
    }

    try {
      final cameras = await availableCameras();
      final backCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      final controller = CameraController(
        backCamera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.nv21,
      );

      await controller.initialize();
      await controller.setFocusMode(FocusMode.auto);
      await controller.setExposureMode(ExposureMode.auto);
      await controller.startImageStream(_processCameraImage);
      if (!mounted) {
        await controller.dispose();
        return;
      }
      setState(() {
        _camera = backCamera;
        _cameraController = controller;
        _hasCameraPermission = true;
        _isStartingCamera = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isStartingCamera = false;
        _cameraError = 'Could not start camera. Use manual entry for now.';
      });
    }
  }

  Future<void> _processCameraImage(CameraImage image) async {
    if (_isProcessingImage || _plate != null || _isSaving) return;
    final now = DateTime.now();
    if (now.difference(_lastScan).inMilliseconds < 450) return;
    _lastScan = now;
    _isProcessingImage = true;

    try {
      final inputImage = _inputImageFromCameraImage(image);
      if (inputImage == null) return;
      final recognizedText = await _textRecognizer.processImage(inputImage);
      final detection = _bestDetectionFromRecognizedText(recognizedText);
      if (detection != null &&
          mounted &&
          (detection.plate != _plate || detection.city != _city)) {
        setState(() {
          _plate = detection.plate;
          _city = detection.city;
        });
      }
    } catch (_) {
      // OCR frames can occasionally be malformed while camera analysis warms up.
    } finally {
      _isProcessingImage = false;
    }
  }

  PlateDetection? _bestDetectionFromRecognizedText(
    RecognizedText recognizedText,
  ) {
    final fragments = <String>[recognizedText.text];
    for (final block in recognizedText.blocks) {
      fragments.add(block.text);
      for (final line in block.lines) {
        fragments.add(line.text);
      }
      for (var i = 0; i < block.lines.length - 1; i++) {
        fragments.add('${block.lines[i].text}\n${block.lines[i + 1].text}');
      }
      for (var i = 0; i < block.lines.length - 2; i++) {
        fragments.add(
          '${block.lines[i].text}\n${block.lines[i + 1].text}\n${block.lines[i + 2].text}',
        );
      }
    }

    final detections = fragments
        .map(extractPlateDetection)
        .whereType<PlateDetection>()
        .toList();
    if (detections.isEmpty) return null;
    detections.sort(
      (a, b) => _plateScore(b.plate).compareTo(_plateScore(a.plate)),
    );
    return detections.first;
  }

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    final camera = _camera;
    if (camera == null) return null;
    final rotation = InputImageRotationValue.fromRawValue(
      camera.sensorOrientation,
    );
    if (rotation == null) return null;

    final format = switch (image.format.group) {
      ImageFormatGroup.nv21 => InputImageFormat.nv21,
      ImageFormatGroup.yuv420 => InputImageFormat.yuv_420_888,
      _ => null,
    };
    if (format == null) return null;

    final bytes = _cameraImageBytes(image);
    if (bytes == null) return null;

    return InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: format,
        bytesPerRow: image.planes.first.bytesPerRow,
      ),
    );
  }

  Uint8List? _cameraImageBytes(CameraImage image) {
    if (image.planes.length == 1) return image.planes.first.bytes;

    final allBytes = WriteBuffer();
    for (final plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _cameraController;
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0B),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: controller != null && controller.value.isInitialized
                  ? FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: controller.value.previewSize!.height,
                        height: controller.value.previewSize!.width,
                        child: CameraPreview(controller),
                      ),
                    )
                  : const ScannerBackground(),
            ),
            if (controller != null && controller.value.isInitialized)
              Positioned.fill(
                child: Container(color: Colors.black.withValues(alpha: .18)),
              ),
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Row(
                children: [
                  GlassButton(
                    icon: Icons.close_rounded,
                    onTap: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: _glassDecoration(),
                    child: Text(
                      _hasCameraPermission
                          ? '● Live OCR · ${widget.scannedCount + _savedInSession} today'
                          : '● ${widget.scannedCount + _savedInSession} scanned today',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Spacer(),
                  GlassButton(
                    icon: _flashOn
                        ? Icons.flash_on_rounded
                        : Icons.flash_off_rounded,
                    color: _flashOn ? _accent : Colors.white,
                    onTap: _toggleFlash,
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Viewfinder(plate: _plate, city: _city),
                  const SizedBox(height: 24),
                  Text(
                    _headlineText(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Text(
                      _subhintText(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: .62),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  if (_plate != null) ...[
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DetectionActionButton(
                          icon: Icons.close_rounded,
                          label: 'Cancel',
                          onTap: _clearDetection,
                        ),
                        const SizedBox(width: 14),
                        DetectionActionButton(
                          icon: Icons.more_horiz_rounded,
                          label: 'Edit',
                          onTap: () => _manualEntry(context),
                        ),
                        const SizedBox(width: 14),
                        DetectionActionButton(
                          icon: Icons.check_rounded,
                          label: _isSaving ? 'Saving' : 'Save',
                          highlight: true,
                          onTap: _isSaving ? null : _saveAndContinue,
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            if (_plate == null)
              Positioned(
                left: 0,
                right: 0,
                bottom: 44,
                child: Center(
                  child: GlassButton(
                    icon: Icons.edit_rounded,
                    onTap: () => _manualEntry(context),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggleFlash() async {
    final controller = _cameraController;
    if (controller == null || !controller.value.isInitialized) return;
    final next = !_flashOn;
    try {
      await controller.setFlashMode(next ? FlashMode.torch : FlashMode.off);
      if (mounted) setState(() => _flashOn = next);
    } catch (_) {
      if (mounted) setState(() => _flashOn = false);
    }
  }

  String _headlineText() {
    if (_plate != null && _city != null) return 'Plate and city detected';
    if (_plate != null) return 'Plate detected';
    if (_isStartingCamera) return 'Starting camera';
    if (_cameraError != null) return 'Manual entry available';
    return 'Aim at the plate';
  }

  String _subhintText() {
    if (_plate != null) {
      return _city == null
          ? 'City was not found yet; edit before saving'
          : 'Review, edit, or save and continue scanning';
    }
    if (_isStartingCamera) return 'Preparing camera and on-device OCR';
    if (_cameraError != null) return _cameraError!;
    return 'Hold the plate inside the frame while MotoSheet reads it';
  }

  Future<void> _manualEntry(BuildContext context) async {
    final value = await showDialog<PlateDetection>(
      context: context,
      builder: (_) => EditPlateDialog(
        initialPlate: _plate ?? '',
        initialCity: _city ?? 'PHNOM PENH',
      ),
    );
    if (!mounted || value == null || value.plate.isEmpty) return;
    setState(() {
      _plate = extractPlateNumber(value.plate) ?? value.plate.toUpperCase();
      _city = value.city;
    });
  }

  void _clearDetection() {
    setState(() {
      _plate = null;
      _city = null;
    });
  }

  Future<void> _saveAndContinue() async {
    final plate = _plate;
    if (plate == null) return;
    setState(() => _isSaving = true);
    final saved = await widget.onSave(
      PlateDetection(plate: plate, city: _city ?? 'PHNOM PENH'),
    );
    if (!mounted) return;
    setState(() {
      _isSaving = false;
      if (saved) {
        _savedInSession += 1;
        _plate = null;
        _city = null;
      }
    });
  }
}

class EditPlateDialog extends StatefulWidget {
  const EditPlateDialog({
    super.key,
    required this.initialPlate,
    required this.initialCity,
  });

  final String initialPlate;
  final String initialCity;

  @override
  State<EditPlateDialog> createState() => _EditPlateDialogState();
}

class _EditPlateDialogState extends State<EditPlateDialog> {
  late final TextEditingController _plateController = TextEditingController(
    text: widget.initialPlate,
  );
  late final TextEditingController _cityController = TextEditingController(
    text: widget.initialCity,
  );

  @override
  void dispose() {
    _plateController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit plate'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _plateController,
            textCapitalization: TextCapitalization.characters,
            decoration: const InputDecoration(
              labelText: 'Plate',
              hintText: '2KT-6326',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _cityController,
            textCapitalization: TextCapitalization.characters,
            decoration: const InputDecoration(
              labelText: 'City',
              hintText: 'PHNOM PENH',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(
            context,
            PlateDetection(
              plate: _plateController.text.trim(),
              city: _cityController.text.trim().isEmpty
                  ? 'PHNOM PENH'
                  : _cityController.text.trim().toUpperCase(),
            ),
          ),
          child: const Text('Use plate'),
        ),
      ],
    );
  }
}

class VisitorMotorDetails {
  const VisitorMotorDetails({required this.brand, required this.model});

  final String brand;
  final String model;
}

class VisitorMotorDialog extends StatefulWidget {
  const VisitorMotorDialog({super.key, required this.plate});

  final String plate;

  @override
  State<VisitorMotorDialog> createState() => _VisitorMotorDialogState();
}

class _VisitorMotorDialogState extends State<VisitorMotorDialog> {
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Visitor motor · ${widget.plate}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Enter once. This plate will be remembered for the next visit.',
            style: TextStyle(color: _muted),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _brandController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Brand',
              hintText: 'Honda',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _modelController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Model',
              hintText: 'Dream',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            final brand = _brandController.text.trim();
            final model = _modelController.text.trim();
            if (brand.isEmpty || model.isEmpty) return;
            Navigator.pop(
              context,
              VisitorMotorDetails(brand: brand, model: model),
            );
          },
          child: const Text('Save visitor'),
        ),
      ],
    );
  }
}

class ConfirmSheet extends StatefulWidget {
  const ConfirmSheet({
    super.key,
    required this.plate,
    required this.city,
    required this.suggestedSlot,
    required this.scannedAt,
    required this.photoSeed,
    required this.id,
  });

  final String plate;
  final String city;
  final String suggestedSlot;
  final DateTime scannedAt;
  final int photoSeed;
  final int id;

  @override
  State<ConfirmSheet> createState() => _ConfirmSheetState();
}

class _ConfirmSheetState extends State<ConfirmSheet> {
  late final TextEditingController _plate = TextEditingController(
    text: widget.plate,
  );
  late final TextEditingController _city = TextEditingController(
    text: widget.city,
  );
  final _brand = TextEditingController(text: 'Honda Wave');
  final _color = TextEditingController(text: 'Black');
  final _note = TextEditingController();
  late String _slot = widget.suggestedSlot;

  @override
  Widget build(BuildContext context) {
    final slotBase = int.tryParse(widget.suggestedSlot.split('-').last) ?? 1;
    final slots = List.generate(
      4,
      (i) => 'B-${(slotBase + i).toString().padLeft(2, '0')}',
    );
    return AppSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SheetHeader(
            eyebrow: '● Detected',
            title: 'Confirm details',
            onClose: () => Navigator.pop(context),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: _boxDecoration(16),
            child: Row(
              children: [
                BikePhoto(seed: widget.photoSeed, size: 80),
                const SizedBox(width: 14),
                Expanded(
                  child: PlateTextField(
                    controller: _plate,
                    cityController: _city,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FieldLabel(
            title: 'Scanned',
            subtitle: DateFormat(
              'dd MMM yyyy · HH:mm',
            ).format(widget.scannedAt),
          ),
          const SizedBox(height: 16),
          const FieldLabel(
            title: 'Suggested slot',
            subtitle: 'Based on next available',
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: slots
                .map(
                  (slot) => FilterChipButton(
                    label: slot,
                    active: _slot == slot,
                    onTap: () => setState(() => _slot = slot),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: AppTextField(label: 'Brand', controller: _brand),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: AppTextField(label: 'Color', controller: _color),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AppTextField(
            label: 'Note',
            controller: _note,
            hint: 'e.g. broken mirror, hot key...',
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: FilledButton.icon(
              onPressed: () => Navigator.pop(
                context,
                ParkingEntry(
                  id: widget.id,
                  plate: _plate.text.trim().isEmpty
                      ? widget.plate
                      : _plate.text.trim(),
                  city: _city.text.trim().isEmpty
                      ? 'PHNOM PENH'
                      : _city.text.trim().toUpperCase(),
                  company: 'VISITOR',
                  classification: ScanClassification.visitor,
                  session: ScanSession.morning,
                  brand: _brand.text.trim().isEmpty
                      ? 'Unknown'
                      : _brand.text.trim(),
                  model: _color.text.trim().isEmpty
                      ? 'Unknown'
                      : _color.text.trim(),
                  color: _color.text.trim().isEmpty
                      ? 'Unknown'
                      : _color.text.trim(),
                  slot: _slot,
                  timeIn: DateFormat('HH:mm').format(widget.scannedAt),
                  scannedAt: widget.scannedAt,
                  photoSeed: widget.photoSeed,
                  note: _note.text.trim(),
                ),
              ),
              icon: const Icon(Icons.check_rounded),
              label: const Text('Add to list'),
              style: FilledButton.styleFrom(
                backgroundColor: _ink,
                foregroundColor: _bg,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailSheet extends StatelessWidget {
  const DetailSheet({
    super.key,
    required this.entry,
    required this.onCheckout,
    required this.onDelete,
  });

  final ParkingEntry entry;
  final VoidCallback onCheckout;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final out = entry.status == EntryStatus.checkedOut;
    return AppSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SheetHeader(
            eyebrow: out ? '● Checked out' : '● Parked',
            title: 'Entry detail',
            eyebrowColor: out ? _muted : _success,
            onClose: () => Navigator.pop(context),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: _boxDecoration(16),
            child: Row(
              children: [
                BikePhoto(seed: entry.photoSeed, size: 80),
                const SizedBox(width: 14),
                PlateChip(
                  plate: entry.plate,
                  city: entry.city,
                  size: PlateSize.large,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            decoration: _boxDecoration(16),
            child: Column(
              children: [
                InfoRow(
                  icon: Icons.business_rounded,
                  label: 'Company',
                  value: entry.company,
                ),
                InfoRow(
                  icon: Icons.verified_user_rounded,
                  label: 'Class',
                  value: _classificationLabel(entry.classification),
                ),
                InfoRow(
                  icon: Icons.two_wheeler_rounded,
                  label: 'Motor',
                  value: '${entry.brand} ${entry.model}',
                ),
                InfoRow(
                  icon: Icons.badge_rounded,
                  label: 'Expiry',
                  value: entry.expiry == null
                      ? '-'
                      : DateFormat('dd-MMM-yy').format(entry.expiry!),
                ),
                InfoRow(
                  icon: Icons.calendar_today_rounded,
                  label: 'Scan date',
                  value: DateFormat('dd MMM yyyy').format(entry.scannedAt),
                ),
                InfoRow(
                  icon: Icons.schedule_rounded,
                  label: 'Time in',
                  value: entry.timeIn,
                ),
                InfoRow(
                  icon: Icons.logout_rounded,
                  label: 'Time out',
                  value: entry.timeOut ?? '-',
                ),
                InfoRow(
                  icon: Icons.pin_drop_rounded,
                  label: 'Slot',
                  value: entry.slot,
                ),
                InfoRow(
                  icon: Icons.location_city_rounded,
                  label: 'City',
                  value: entry.city,
                  last: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (!out)
            SizedBox(
              width: double.infinity,
              height: 54,
              child: FilledButton.icon(
                onPressed: onCheckout,
                icon: const Icon(Icons.check_circle_outline_rounded),
                label: const Text('Mark as checked-out'),
                style: FilledButton.styleFrom(
                  backgroundColor: _ink,
                  foregroundColor: _bg,
                ),
              ),
            ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: OutlinedButton.icon(
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline_rounded),
              label: const Text('Delete'),
              style: OutlinedButton.styleFrom(
                foregroundColor: _danger,
                side: const BorderSide(color: _line),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExportSheet extends StatefulWidget {
  const ExportSheet({super.key, required this.entries, required this.onExport});

  final List<ParkingEntry> entries;
  final Future<void> Function(List<ParkingEntry> rows, Set<String> columns)
  onExport;

  @override
  State<ExportSheet> createState() => _ExportSheetState();
}

class _ExportSheetState extends State<ExportSheet> {
  String _rowMode = 'all';
  DateTime? _selectedDate = DateUtils.dateOnly(DateTime.now());
  final _columns = <String>{
    'ref',
    'no',
    'company',
    'type',
    'months',
    'expiry',
    'brand',
    'model',
    'plate_prefix',
    'plate_number',
    'morning',
    'afternoon',
  };
  final _labels = const {
    'ref': 'Ref',
    'no': 'No.',
    'company': 'Company',
    'type': 'Type',
    'months': 'Months',
    'expiry': 'Expiry',
    'brand': 'Brand',
    'model': 'Model',
    'plate_prefix': 'Plate Prefix',
    'plate_number': 'Plate Number',
    'morning': 'Morning',
    'afternoon': 'Afternoon',
  };

  List<ParkingEntry> get _statusRows => switch (_rowMode) {
    'parked' =>
      widget.entries.where((e) => e.status == EntryStatus.parked).toList(),
    'out' =>
      widget.entries.where((e) => e.status == EntryStatus.checkedOut).toList(),
    _ => widget.entries,
  };

  List<ParkingEntry> get _rows {
    final selected = _selectedDate;
    if (selected == null) return _statusRows;
    return _statusRows
        .where((entry) => DateUtils.isSameDay(entry.scannedAt, selected))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final rows = _rows;
    final filename =
        'motosheet_${_selectedDate == null ? 'all_dates' : DateFormat('yyyy-MM-dd').format(_selectedDate!)}_phnom_penh.xlsx';
    return AppSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SheetHeader(
            eyebrow: 'Export · XLSX',
            title: "Today's sheet",
            onClose: () => Navigator.pop(context),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: _boxDecoration(14),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _success,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const Text(
                    'XLS',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        filename,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: _ink,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${rows.length} rows · ${_columns.length} cols · ready to share',
                        style: const TextStyle(color: _muted, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const FieldLabel(title: 'Filter by scan date'),
          const SizedBox(height: 8),
          Row(
            children: [
              FilterChipButton(
                label: 'All dates',
                active: _selectedDate == null,
                onTap: () => setState(() => _selectedDate = null),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: _pickDate,
                icon: const Icon(Icons.calendar_today_rounded, size: 16),
                label: Text(
                  _selectedDate == null
                      ? 'Choose date'
                      : DateFormat('dd MMM yyyy').format(_selectedDate!),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: _ink,
                  side: const BorderSide(color: _line),
                  shape: const StadiumBorder(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const FieldLabel(title: 'Include rows'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              FilterChipButton(
                label: 'All',
                active: _rowMode == 'all',
                onTap: () => setState(() => _rowMode = 'all'),
              ),
              FilterChipButton(
                label: 'Parked',
                active: _rowMode == 'parked',
                onTap: () => setState(() => _rowMode = 'parked'),
              ),
              FilterChipButton(
                label: 'Out',
                active: _rowMode == 'out',
                onTap: () => setState(() => _rowMode = 'out'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const FieldLabel(title: 'Columns'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _labels.entries.map((item) {
              final active = _columns.contains(item.key);
              return FilterChipButton(
                label: active ? '✓ ${item.value}' : item.value,
                active: active,
                onTap: () => setState(() {
                  if (active && _columns.length > 1) {
                    _columns.remove(item.key);
                  } else {
                    _columns.add(item.key);
                  }
                }),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          SpreadsheetPreview(
            rows: rows.take(5).toList(),
            columns: _columns.toList(),
            labels: _labels,
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: FilledButton.icon(
              onPressed: () => widget.onExport(rows, _columns),
              icon: const Icon(Icons.share_rounded),
              label: const Text('Export and share'),
              style: FilledButton.styleFrom(
                backgroundColor: _ink,
                foregroundColor: _bg,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (date != null && mounted) {
      setState(() => _selectedDate = DateUtils.dateOnly(date));
    }
  }
}

class EntryCard extends StatelessWidget {
  const EntryCard({
    super.key,
    required this.entry,
    required this.morningTime,
    required this.afternoonTime,
    required this.onTap,
  });

  final ParkingEntry entry;
  final String? morningTime;
  final String? afternoonTime;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final out = entry.status == EntryStatus.checkedOut;
    final expired =
        entry.expiry != null &&
        entry.expiry!.isBefore(DateUtils.dateOnly(DateTime.now()));
    return Opacity(
      opacity: out ? .55 : 1,
      child: Material(
        color: _surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: expired ? _danger.withValues(alpha: .38) : _line,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                PlateChip(plate: entry.plate, city: entry.city),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              entry.classification == ScanClassification.company
                                  ? entry.company
                                  : 'Visitor',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: _ink,
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          if (expired) const SizedBox(width: 6),
                          if (expired) const MiniExpiredBadge(),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${entry.brand} ${entry.model}${entry.ref.isEmpty ? '' : ' · #${entry.ref}${entry.no.isEmpty ? '' : entry.no}'}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _muted,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SessionTimeBadge(label: 'AM', time: morningTime),
                    const SizedBox(width: 5),
                    SessionTimeBadge(label: 'PM', time: afternoonTime),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RoundSwitcher extends StatelessWidget {
  const RoundSwitcher({
    super.key,
    required this.selected,
    required this.morningDone,
    required this.afternoonDone,
    required this.totalCount,
    required this.onChanged,
  });

  final ScanSession selected;
  final int morningDone;
  final int afternoonDone;
  final int totalCount;
  final ValueChanged<ScanSession> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _line),
      ),
      child: Row(
        children: [
          Expanded(
            child: RoundTab(
              session: ScanSession.morning,
              selected: selected == ScanSession.morning,
              done: morningDone,
              total: totalCount,
              onTap: () => onChanged(ScanSession.morning),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: RoundTab(
              session: ScanSession.afternoon,
              selected: selected == ScanSession.afternoon,
              done: afternoonDone,
              total: totalCount,
              onTap: () => onChanged(ScanSession.afternoon),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundTab extends StatelessWidget {
  const RoundTab({
    super.key,
    required this.session,
    required this.selected,
    required this.done,
    required this.total,
    required this.onTap,
  });

  final ScanSession session;
  final bool selected;
  final int done;
  final int total;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? _ink : _surface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              session == ScanSession.morning
                  ? Icons.wb_sunny_outlined
                  : Icons.nightlight_round,
              size: 14,
              color: selected ? _surface : _muted,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _sessionLabel(session),
                    style: TextStyle(
                      color: selected ? _surface : _ink,
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$done/$total  done',
                    style: TextStyle(
                      color: selected
                          ? _surface.withValues(alpha: .78)
                          : _muted,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .11),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 8, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class MiniExpiredBadge extends StatelessWidget {
  const MiniExpiredBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: _danger.withValues(alpha: .10),
        borderRadius: BorderRadius.circular(3),
      ),
      child: const Text(
        'EXPIRED',
        style: TextStyle(
          color: _danger,
          fontSize: 7,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class SessionTimeBadge extends StatelessWidget {
  const SessionTimeBadge({super.key, required this.label, required this.time});

  final String label;
  final String? time;

  @override
  Widget build(BuildContext context) {
    final scanned = time != null;
    return Container(
      width: 42,
      height: 38,
      decoration: BoxDecoration(
        color: scanned ? _success : _surface,
        border: Border.all(color: scanned ? _success : _line),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              color: scanned ? Colors.white : _muted,
              fontSize: 9,
              height: 1,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          SizedBox(
            width: 34,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                time ?? '—',
                maxLines: 1,
                style: TextStyle(
                  color: scanned ? Colors.white : _ink,
                  fontSize: 10,
                  height: 1,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PendingList extends StatelessWidget {
  const PendingList({super.key, required this.motors});

  final List<RegisteredMotor> motors;

  @override
  Widget build(BuildContext context) {
    if (motors.isEmpty) return const EmptyState();
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 112),
      itemBuilder: (context, index) {
        final motor = motors[index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: _surface,
            border: Border.all(color: _line),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              PlateChip(plate: motor.plate, city: 'PHNOM PENH'),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      motor.company,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _ink,
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${motor.brand} ${motor.model} · #${motor.ref}${motor.no}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _muted,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const StatusBadge(
                icon: Icons.schedule_rounded,
                label: 'pending',
                color: _muted,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemCount: motors.length,
    );
  }
}

enum PlateSize { medium, large }

class PlateChip extends StatelessWidget {
  const PlateChip({
    super.key,
    required this.plate,
    this.city,
    this.size = PlateSize.medium,
  });

  final String plate;
  final String? city;
  final PlateSize size;

  @override
  Widget build(BuildContext context) {
    final large = size == PlateSize.large;
    final cityText = (city == null || city!.isEmpty) ? 'PHNOM PENH' : city!;
    return Container(
      width: large ? 132 : 88,
      height: large ? 82 : 54,
      padding: EdgeInsets.fromLTRB(
        large ? 8 : 5,
        large ? 7 : 4,
        large ? 8 : 5,
        large ? 6 : 4,
      ),
      decoration: BoxDecoration(
        color: _surface,
        border: Border.all(color: _plateBlue, width: 2),
        borderRadius: BorderRadius.circular(7),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            offset: Offset(0, -2),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                plate,
                style: TextStyle(
                  color: _plateBlue,
                  height: 1,
                  fontSize: large ? 30 : 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(vertical: 2),
            color: const Color(0xFF0EA5E9),
          ),
          SizedBox(
            height: large ? 12 : 7,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                cityText,
                maxLines: 1,
                style: TextStyle(
                  color: _plateRed,
                  height: 1,
                  fontSize: large ? 13 : 8,
                  fontWeight: FontWeight.w900,
                  letterSpacing: .8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BikePhoto extends StatelessWidget {
  const BikePhoto({super.key, required this.seed, this.size = 64});

  final int seed;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.orange,
      Colors.blue,
      Colors.teal,
      Colors.purple,
      Colors.pink,
      Colors.amber,
      Colors.indigo,
      Colors.red,
      Colors.deepPurple,
      Colors.green,
    ];
    final color = colors[seed % colors.length];
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(colors: [color.shade100, color.shade400]),
      ),
      child: Icon(
        Icons.two_wheeler_rounded,
        color: color.shade900,
        size: size * .54,
      ),
    );
  }
}

class BrandMark extends StatelessWidget {
  const BrandMark({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: _ink,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.two_wheeler_rounded, color: _accent, size: 18),
    );
  }
}

class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.value,
    required this.label,
    required this.color,
  });

  final int value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value.toString().padLeft(2, '0'),
          style: TextStyle(
            fontSize: 26,
            height: 1,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: .4,
            color: _muted,
          ),
        ),
      ],
    );
  }
}

class FilterChipButton extends StatelessWidget {
  const FilterChipButton({
    super.key,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(label),
      onPressed: onTap,
      backgroundColor: active ? _ink : _surface,
      labelStyle: TextStyle(
        color: active ? _bg : _ink,
        fontWeight: FontWeight.w800,
        fontSize: 13,
      ),
      shape: StadiumBorder(
        side: BorderSide(color: active ? _ink : _line, width: active ? 1.5 : 1),
      ),
    );
  }
}

class _SquareButton extends StatelessWidget {
  const _SquareButton({
    required this.icon,
    required this.onTap,
    this.color = _ink,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color color;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: IconButton(
        onPressed: onTap,
        tooltip: tooltip,
        icon: Icon(icon),
        style: IconButton.styleFrom(
          backgroundColor: _surface,
          foregroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: _line),
          ),
        ),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 70),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.search_off_rounded, color: _muted, size: 48),
            SizedBox(height: 12),
            Text(
              'Nothing matches',
              style: TextStyle(fontWeight: FontWeight.w800, color: _ink),
            ),
          ],
        ),
      ),
    );
  }
}

class AppSheet extends StatelessWidget {
  const AppSheet({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
          decoration: const BoxDecoration(
            color: _bg,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 5,
                  decoration: BoxDecoration(
                    color: _muted.withValues(alpha: .35),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(height: 14),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SheetHeader extends StatelessWidget {
  const SheetHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.onClose,
    this.eyebrowColor = _success,
  });

  final String eyebrow;
  final String title;
  final VoidCallback onClose;
  final Color eyebrowColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eyebrow.toUpperCase(),
                style: TextStyle(
                  color: eyebrowColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                title,
                style: const TextStyle(
                  color: _ink,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        IconButton.filledTonal(
          onPressed: onClose,
          icon: const Icon(Icons.close_rounded),
          style: IconButton.styleFrom(
            backgroundColor: _surface,
            foregroundColor: _ink,
          ),
        ),
      ],
    );
  }
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
  });

  final String label;
  final TextEditingController controller;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: _surface,
        enabledBorder: _inputBorder(),
        focusedBorder: _inputBorder(color: _ink),
      ),
    );
  }
}

class PlateTextField extends StatelessWidget {
  const PlateTextField({
    super.key,
    required this.controller,
    required this.cityController,
  });

  final TextEditingController controller;
  final TextEditingController cityController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          textCapitalization: TextCapitalization.characters,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: _plateBlue,
          ),
          decoration: InputDecoration(
            labelText: 'Plate number',
            filled: true,
            fillColor: _surface,
            enabledBorder: _inputBorder(color: _plateBlue),
            focusedBorder: _inputBorder(color: _plateBlue),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: cityController,
          textCapitalization: TextCapitalization.characters,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: _plateRed,
          ),
          decoration: InputDecoration(
            labelText: 'City on plate',
            filled: true,
            fillColor: _surface,
            enabledBorder: _inputBorder(),
            focusedBorder: _inputBorder(color: _plateRed),
          ),
        ),
      ],
    );
  }
}

class FieldLabel extends StatelessWidget {
  const FieldLabel({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: _ink, fontWeight: FontWeight.w800),
        ),
        if (subtitle != null)
          Text(subtitle!, style: const TextStyle(color: _muted, fontSize: 12)),
      ],
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.last = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: last ? Colors.transparent : _line),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: _bg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: _ink),
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(color: _ink, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(color: _ink, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class SpreadsheetPreview extends StatelessWidget {
  const SpreadsheetPreview({
    super.key,
    required this.rows,
    required this.columns,
    required this.labels,
  });

  final List<ParkingEntry> rows;
  final List<String> columns;
  final Map<String, String> labels;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: _boxDecoration(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowHeight: 32,
              dataRowMinHeight: 30,
              dataRowMaxHeight: 30,
              columns: columns
                  .map(
                    (c) => DataColumn(
                      label: Text(
                        labels[c]!,
                        style: const TextStyle(
                          fontSize: 10,
                          color: _muted,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              rows: rows
                  .map(
                    (entry) => DataRow(
                      cells: columns
                          .map(
                            (c) => DataCell(
                              Text(
                                _previewValue(entry, c),
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  )
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6, bottom: 4),
            child: Text(
              'first ${rows.length} rows',
              style: const TextStyle(color: _muted, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  String _previewValue(ParkingEntry e, String c) => switch (c) {
    'ref' => e.ref,
    'no' => e.no,
    'company' => e.company,
    'type' => e.type,
    'months' => e.months?.toString() ?? '',
    'expiry' =>
      e.expiry == null ? '' : DateFormat('dd-MMM-yy').format(e.expiry!),
    'brand' => e.brand,
    'model' => e.model,
    'plate_prefix' => e.plate.split('-').first,
    'plate_number' => e.plate.contains('-') ? e.plate.split('-').last : '',
    'morning' => e.session == ScanSession.morning ? '✓' : '',
    'afternoon' => e.session == ScanSession.afternoon ? '✓' : '',
    _ => '',
  };
}

class ScannerBackground extends StatelessWidget {
  const ScannerBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: ScannerPainter());
  }
}

class ScannerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const RadialGradient(
        colors: [Color(0xFF293241), Color(0xFF0A0A0B)],
        radius: 1.1,
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, paint);
    final dot = Paint()..color = Colors.white.withValues(alpha: .05);
    for (double x = 0; x < size.width; x += 18) {
      for (double y = 0; y < size.height; y += 18) {
        canvas.drawCircle(Offset(x, y), 1, dot);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Viewfinder extends StatefulWidget {
  const Viewfinder({super.key, this.plate, this.city});

  final String? plate;
  final String? city;

  @override
  State<Viewfinder> createState() => _ViewfinderState();
}

class _ViewfinderState extends State<Viewfinder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 168,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(size: const Size(280, 168), painter: CornerPainter()),
          AnimatedBuilder(
            animation: _controller,
            builder: (_, _) => Positioned(
              top: 18 + (_controller.value * 128),
              left: 26,
              right: 26,
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  color: _accent,
                  boxShadow: [
                    BoxShadow(
                      color: _accent.withValues(alpha: .8),
                      blurRadius: 12,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (widget.plate != null)
            Transform.scale(
              scale: 1.08,
              child: PlateChip(
                plate: widget.plate!,
                city: widget.city,
                size: PlateSize.large,
              ),
            ),
        ],
      ),
    );
  }
}

class CornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = _accent
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    const l = 28.0;
    canvas.drawLine(Offset.zero, const Offset(l, 0), p);
    canvas.drawLine(Offset.zero, const Offset(0, l), p);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width - l, 0), p);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, l), p);
    canvas.drawLine(Offset(0, size.height), Offset(l, size.height), p);
    canvas.drawLine(Offset(0, size.height), Offset(0, size.height - l), p);
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width - l, size.height),
      p,
    );
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width, size.height - l),
      p,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class GlassButton extends StatelessWidget {
  const GlassButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.color = Colors.white,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 52,
        height: 52,
        decoration: _glassDecoration(),
        child: Icon(icon, color: color),
      ),
    );
  }
}

class DetectionActionButton extends StatelessWidget {
  const DetectionActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.highlight = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 60,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: highlight ? _accent : Colors.white.withValues(alpha: .12),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: highlight ? _accent : Colors.white.withValues(alpha: .12),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: highlight ? _ink : Colors.white),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: highlight ? _ink : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

BoxDecoration _glassDecoration() => BoxDecoration(
  color: Colors.white.withValues(alpha: .12),
  borderRadius: BorderRadius.circular(18),
  border: Border.all(color: Colors.white.withValues(alpha: .10)),
);
BoxDecoration _boxDecoration(double radius) => BoxDecoration(
  color: _surface,
  borderRadius: BorderRadius.circular(radius),
  border: Border.all(color: _line),
  boxShadow: const [
    BoxShadow(color: Color(0x0F000000), blurRadius: 12, offset: Offset(0, 4)),
  ],
);
OutlineInputBorder _inputBorder({Color color = _line}) => OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: BorderSide(color: color),
);
