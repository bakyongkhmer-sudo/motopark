import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/+esm';

const SUPABASE_URL = 'https://euzkccwlqewlikwezqsw.supabase.co';
const SUPABASE_KEY = 'sb_publishable_94BN8Ucao1HLGztDoCZSGg_sH_wp0Ws';
const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);
const app = document.getElementById('app');
const modalRoot = document.getElementById('modalRoot');
const today = '2026-05-29';

const seedCompanies = [
  { id: 'C01', code: 'SMG', name: 'Sokimex Global', floor: 'L12', contact: 'Chea Sopheaktra', phone: '+855 12 345 678', motorCount: 12 },
  { id: 'C02', code: 'NXT', name: 'Nexlogix Cambodia', floor: 'L08', contact: 'Sok Bopha', phone: '+855 17 224 668', motorCount: 18 },
  { id: 'C03', code: 'BRA', name: 'Brava Architects', floor: 'L05', contact: 'Lim Vannak', phone: '+855 92 776 442', motorCount: 7 },
  { id: 'C04', code: 'KMD', name: 'Kameda Trading', floor: 'L15', contact: 'Yamada Kenji', phone: '+855 81 998 100', motorCount: 9 },
  { id: 'C05', code: 'FRN', name: 'Fern Capital', floor: 'L18', contact: 'Pich Dara', phone: '+855 96 553 901', motorCount: 5 },
  { id: 'C06', code: 'ONP', name: 'Onpoint Studio', floor: 'L03', contact: 'Heng Thida', phone: '+855 78 318 477', motorCount: 4 },
];

const seedMotors = [
  ['2601', '001', 'Sokimex Global', 'Honda', 'Wave', '1A', '1234', '2026-12-31'],
  ['2602', '002', 'Sokimex Global', 'Honda', 'Dream', '1B', '1003', '2026-12-31'],
  ['2603', '003', 'Sokimex Global', 'Yamaha', 'Sirius', '1C', '8842', '2026-12-31'],
  ['2604', '004', 'Sokimex Global', 'Honda', 'Vision', '1D', '2345', '2026-12-31'],
  ['2605', '005', 'Sokimex Global', 'Honda', 'SH 150', '1E', '4567', '2026-12-31'],
  ['2701', '001', 'Nexlogix Cambodia', 'Honda', 'Air Blade', '1G', '3456', '2026-12-31'],
  ['2702', '002', 'Nexlogix Cambodia', 'Yamaha', 'NVX', '1H', '6789', '2026-12-31'],
  ['2705', '005', 'Nexlogix Cambodia', 'Yamaha', 'Exciter', '1L', '9012', '2026-01-15'],
  ['2803', '003', 'Brava Architects', 'Yamaha', 'Grande', '1R', '4126', '2026-02-28'],
  ['2901', '001', 'Kameda Trading', 'Honda', 'PCX', '5A', '2248', '2026-12-31'],
  ['3002', '002', 'Fern Capital', 'Yamaha', 'Fino', '2B', '6326', '2026-12-31'],
  ['3101', '001', 'Onpoint Studio', 'Honda', 'Wave Alpha', '2C', '9981', '2026-12-31'],
].map(([ref, no, company, brand, model, prefix, number, expiry], index) => ({
  id: `M${ref}`, ref, no, company, type: 'FOC', months: 12, expiry, brand, model, plate: `${prefix}-${number}`,
}));

const state = {
  route: localStorage.getItem('vtrust.auth') ? 'dashboard' : 'login',
  settings: 'general',
  motors: [],
  report: [],
  companies: seedCompanies,
  motorPage: 1,
  motorSearch: '',
  companyFilter: 'all',
  statusFilter: 'all',
  reportDate: today,
  reportFilter: 'all',
  selectedCompany: seedCompanies[0].id,
};

function h(strings, ...values) {
  return strings.reduce((out, str, i) => out + str + (values[i] ?? ''), '');
}

function esc(value) {
  return String(value ?? '').replace(/[&<>"']/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
}

function plateParts(plate) {
  const normalized = String(plate || '').replace(/\s+/g, '-');
  const [prefix, number] = normalized.split('-');
  return { prefix: prefix || '', number: number || '' };
}

function companyCode(name) {
  const found = state.companies.find((c) => c.name.toLowerCase() === String(name).toLowerCase());
  return found?.code || String(name || 'VIS').split(/\s+/).map((x) => x[0]).join('').slice(0, 3).toUpperCase();
}

function isExpired(motor) {
  return motor.expiry && motor.expiry < today;
}

function isSoon(motor) {
  if (!motor.expiry || isExpired(motor)) return false;
  return (new Date(motor.expiry) - new Date(today)) / 86400000 <= 60;
}

function plateChip(plate) {
  const { prefix, number } = plateParts(plate);
  return `<div class="plate"><span>${esc(prefix)}</span><b>${esc(number)}</b></div>`;
}

async function loadData() {
  try {
    const { data: motorRows, error } = await supabase
      .from('registered_motors')
      .select('id,ref,no,type,months,expiry_date,brand,model,plate,companies(name)')
      .order('plate');
    if (error) throw error;
    state.motors = (motorRows || []).map((row) => ({
      id: row.id,
      ref: row.ref || '',
      no: row.no || '',
      company: row.companies?.name || 'Unknown',
      type: row.type || 'FOC',
      months: row.months || 12,
      expiry: row.expiry_date,
      brand: row.brand || '',
      model: row.model || '',
      plate: row.plate || '',
    }));
    const names = [...new Set(state.motors.map((m) => m.company))];
    state.companies = names.map((name, index) => seedCompanies.find((c) => c.name === name) || {
      id: `C${index + 1}`,
      code: companyCode(name),
      name,
      floor: `L${String((index % 18) + 1).padStart(2, '0')}`,
      contact: 'Building admin',
      phone: '+855 -- --- ---',
      motorCount: state.motors.filter((m) => m.company === name).length,
    });
  } catch (_) {
    state.motors = seedMotors;
  }
  await loadReport();
}

async function loadReport() {
  try {
    const { data, error } = await supabase
      .from('daily_scan_report')
      .select('*')
      .eq('scan_date', state.reportDate)
      .order('company')
      .order('plate_prefix')
      .order('plate_number');
    if (error) throw error;
    state.report = (data || []).map((r) => ({
      ref: r.ref || '',
      no: r.no || '',
      company: r.company || 'VISITOR',
      type: r.type || '',
      months: r.months || '',
      expiry: r.expiry || '',
      brand: r.brand || '',
      model: r.model || '',
      platePrefix: r.plate_prefix || '',
      plateNumber: r.plate_number || '',
      morning: r.morning ? '✓' : '',
      afternoon: r.afternoon ? '✓' : '',
    }));
  } catch (_) {
    state.report = makeSeedReport(state.reportDate);
  }
}

function makeSeedReport(date) {
  return seedMotors.slice(0, 8).map((m, index) => {
    const { prefix, number } = plateParts(m.plate);
    return {
      ref: m.ref, no: m.no, company: m.company, type: m.type, months: m.months, expiry: m.expiry,
      brand: m.brand, model: m.model, platePrefix: prefix, plateNumber: number,
      morning: index < 6 ? `08:${42 + index}` : '', afternoon: index % 2 === 0 ? `14:${38 + index}` : '',
    };
  }).concat([
    { ref: '', no: '', company: 'VISITOR', type: '', months: '', expiry: '', brand: 'Yamaha', model: 'Fino', platePrefix: '3A', plateNumber: '6326', morning: '09:21', afternoon: '' },
    { ref: '', no: '', company: 'VISITOR', type: '', months: '', expiry: '', brand: 'Honda', model: 'Wave', platePrefix: '4B', plateNumber: '5418', morning: '09:25', afternoon: '15:08' },
  ]);
}

function navigate(route) {
  state.route = route;
  render();
}

function pageTitle() {
  return {
    dashboard: ['Dashboard', 'Vtrust Tower, Phnom Penh · Friday 29 May 2026'],
    motors: ['Motors', `${state.motors.length} registered motors across ${state.companies.length} tenants`],
    reports: ['Daily reports', 'Twice-daily scans · exportable to Excel'],
    companies: ['Companies', `${state.companies.length} tenants in the building`],
    settings: ['Settings', 'Scan windows, reminders, admin users'],
  }[state.route] || ['MotoSheet', 'Vtrust Tower'];
}

function render() {
  if (state.route === 'login') {
    app.innerHTML = loginView();
    bindLogin();
    return;
  }
  const [title, subtitle] = pageTitle();
  app.innerHTML = shell(title, subtitle, currentPage());
  bindShell();
}

function loginView() {
  return h`
    <main class="login">
      <section class="login-left">
        <div class="brand-row"><div class="brand-mark dark">☍</div><div class="brand-copy"><div class="eyebrow">MOTOSHEET</div><div class="title">Admin portal</div></div></div>
        <div class="login-form">
          <h1>Welcome back,<br>Sokha</h1>
          <p>Manage tenant motors, daily scan reports, and renewal reminders for Vtrust Tower, Phnom Penh.</p>
          <label class="field">Email<input class="input" id="email" value="phon.sokha@vtrusttower.com.kh"></label>
          <label class="field"><span class="field-row">Password <a class="muted">Forgot?</a></span><input class="input" id="password" type="password" value="motosheet"></label>
          <label class="check-row"><input type="checkbox" checked> Keep me signed in on this device</label>
          <button class="primary" id="signIn" style="width:100%">Sign in →</button>
        </div>
        <div class="muted">© 2026 MotoSheet · v2.4.1 · Vtrust Tower G/F Building Management</div>
      </section>
      <section class="login-right">
        <div class="live">● Live · 22 motors scanned today</div>
        <h2>One source of truth for every wheel in your basement.</h2>
        <p>Officers scan twice a day. The portal keeps the registry, renewals, and reports tidy.</p>
        <div class="float-card one">${plateChip('1A-1234')}<div><b>Sokimex Global</b><br><span class="muted">AM ✓ PM ✓</span></div></div>
        <div class="float-card two">${plateChip('1G-3456')}<div><b>Nexlogix</b><br><span class="muted">AM ✓</span></div></div>
      </section>
    </main>`;
}

function bindLogin() {
  document.getElementById('signIn').onclick = async () => {
    localStorage.setItem('vtrust.auth', '1');
    state.route = 'dashboard';
    await loadData();
    render();
  };
}

function shell(title, subtitle, content) {
  const nav = [
    ['dashboard', '☷', 'Dashboard', ''],
    ['motors', '☍', 'Motors', state.motors.length],
    ['reports', '▤', 'Daily reports', ''],
    ['companies', '⌖', 'Companies', state.companies.length],
    ['settings', '…', 'Settings', ''],
  ];
  return h`
    <div class="shell">
      <aside class="sidebar">
        <div class="side-brand brand-row"><div class="brand-mark">☍</div><div class="brand-copy"><div class="eyebrow">MOTOSHEET</div><div class="title" style="color:white">Vtrust Tower</div></div></div>
        <div class="side-main"><div class="side-label">MAIN</div>${nav.map(([id, icon, label, count]) => `<button class="nav-item ${state.route === id ? 'active' : ''}" data-nav="${id}"><span>${icon}</span>${label}<span class="nav-count">${count}</span></button>`).join('')}</div>
        <div class="renew-card"><span class="live">● Renewals</span><b>1 expired · 2 expiring</b><span class="muted">Send reminders to tenants today.</span></div>
        <div class="user-row"><div class="avatar">PS</div><div><b style="color:white">Phon Sokha</b><br><span class="muted">Building admin</span></div><button class="logout" id="logout">→</button></div>
      </aside>
      <main class="main">
        <header class="topbar"><div><h1>${title}</h1><div class="muted">${subtitle}</div></div><div style="display:flex;gap:18px;align-items:center"><input class="search" placeholder="⌕  Quick search..."><button class="bell">♧</button></div></header>
        <section class="content">${content}</section>
      </main>
    </div>`;
}

function bindShell() {
  document.querySelectorAll('[data-nav]').forEach((btn) => btn.onclick = () => navigate(btn.dataset.nav));
  document.getElementById('logout').onclick = () => {
    localStorage.removeItem('vtrust.auth');
    navigate('login');
  };
  if (state.route === 'motors') bindMotors();
  if (state.route === 'reports') bindReports();
  if (state.route === 'companies') bindCompanies();
  if (state.route === 'settings') bindSettings();
}

function currentPage() {
  if (state.route === 'dashboard') return dashboardPage();
  if (state.route === 'motors') return motorsPage();
  if (state.route === 'reports') return reportsPage();
  if (state.route === 'companies') return companiesPage();
  if (state.route === 'settings') return settingsPage();
  return dashboardPage();
}

function dashboardPage() {
  const am = state.report.filter((r) => r.morning).length;
  const pm = state.report.filter((r) => r.afternoon).length;
  const visitors = state.report.filter((r) => r.company === 'VISITOR').length;
  const expired = state.motors.filter(isExpired);
  return h`
    <div class="grid4">
      ${kpi('☍', 'Registered motors', state.motors.length, '+3 vs last month')}
      ${kpi('☼', 'Morning · today', `${am}/${state.motors.length}`, '73% checked-in', 'success')}
      ${kpi('◴', 'Afternoon · today', `${pm}/${state.motors.length}`, `${Math.max(0, state.motors.length - pm)} pending`, 'accent')}
      ${kpi('⌖', 'Visitors · today', visitors, '3 brands · 2 active', 'warn')}
    </div>
    <div class="split">
      <div class="card"><div class="card-pad"><div class="field-row"><div><h3 class="card-title">Today's scan progress</h3><span class="muted">Fri 29 May 2026 · Officer Bunna</span></div><button class="secondary" data-nav="reports">View report</button></div><div class="bars">${[8,9,10,11,12,13,14,15].map((hour, i) => `<div class="bar"><span style="height:${40 + i * 8}px;background:var(--success)"></span><span style="height:${i > 3 ? 30 + i * 7 : 8}px;background:var(--accent)"></span><small>${hour}</small></div>`).join('')}</div></div></div>
      <div class="card"><div class="card-pad"><div class="field-row"><h3 class="card-title">Renewal alerts</h3><button class="secondary">Send reminders</button></div></div>${expired.concat(state.motors.filter(isSoon)).slice(0,5).map((m) => `<div class="list-row"><span class="dot red"></span><div><b>${esc(m.company)}</b><br><span class="muted mono">${esc(m.plate)} · exp ${esc(m.expiry)}</span></div><span class="badge red">${isExpired(m) ? 'Expired' : 'Soon'}</span></div>`).join('')}</div>
    </div>
    <div class="split">
      <div class="card card-pad"><h3 class="card-title">Last 8 days</h3><div class="bars">${[18,20,19,22,21,18,20,19].map((v, i) => `<div class="bar"><span style="height:${v * 4}px;background:var(--success)"></span><span style="height:${(v - 3) * 4}px;background:var(--accent-dark)"></span><small>${22 + i}</small></div>`).join('')}</div></div>
      <div class="card"><div class="card-pad"><h3 class="card-title">Latest scans</h3></div>${state.report.slice(0,6).map((r) => `<div class="list-row">${plateChip(`${r.platePrefix}-${r.plateNumber}`)}<div><b>${esc(r.company)}</b><br><span class="muted">${esc(r.brand)} ${esc(r.model)}</span></div><span class="badge green">${r.morning ? 'AM' : 'PM'}</span></div>`).join('')}</div>
    </div>`;
}

function kpi(icon, label, value, caption, tone = '') {
  return `<div class="card card-pad"><div class="field-row"><div class="kpi-icon">${icon}</div><span>›</span></div><div class="caps">${label}</div><div class="kpi-value">${value}</div><div class="muted">${caption}</div></div>`;
}

function motorsFiltered() {
  const q = state.motorSearch.toLowerCase();
  return state.motors.filter((m) => {
    if (q && !`${m.plate} ${m.brand} ${m.model} ${m.company}`.toLowerCase().includes(q)) return false;
    if (state.companyFilter !== 'all' && m.company !== state.companyFilter) return false;
    if (state.statusFilter === 'expired' && !isExpired(m)) return false;
    if (state.statusFilter === 'soon' && !isSoon(m)) return false;
    if (state.statusFilter === 'active' && (isExpired(m) || isSoon(m))) return false;
    return true;
  });
}

function motorsPage() {
  const rows = motorsFiltered();
  const pages = Math.max(1, Math.ceil(rows.length / 10));
  state.motorPage = Math.min(state.motorPage, pages);
  const start = (state.motorPage - 1) * 10;
  const pageRows = rows.slice(start, start + 10);
  return h`
    <div class="toolbar">
      <input class="input" id="motorSearch" placeholder="⌕  Search plate, model, company..." value="${esc(state.motorSearch)}">
      <select class="select" id="companyFilter"><option value="all">All companies</option>${state.companies.map((c) => `<option ${state.companyFilter === c.name ? 'selected' : ''}>${esc(c.name)}</option>`).join('')}</select>
      <select class="select" id="statusFilter"><option value="all">All status</option><option value="active">Active</option><option value="soon">Expiring soon</option><option value="expired">Expired</option></select>
      <b>${rows.length}</b><span class="muted">of ${state.motors.length}</span><span style="margin-left:auto"></span><button class="secondary">Export</button><button class="primary" id="newMotor">New motor</button>
    </div>
    <div class="table-card"><table><thead><tr><th>□</th><th>Ref</th><th>No.</th><th>Company</th><th>Type</th><th>Months</th><th>Expiry</th><th>Brand</th><th>Model</th><th>Plate</th><th></th></tr></thead><tbody>${pageRows.map(motorRow).join('')}</tbody></table><div class="pager"><span>Showing <b>${rows.length ? start + 1 : 0}-${Math.min(start + 10, rows.length)}</b> of ${rows.length}</span><div>${Array.from({length: pages}, (_, i) => `<button class="page-btn ${state.motorPage === i + 1 ? 'active' : ''}" data-page="${i + 1}">${i + 1}</button>`).join('')}</div></div></div>`;
}

function motorRow(m) {
  const expired = isExpired(m);
  const soon = isSoon(m);
  return `<tr class="${expired ? 'expired' : ''}"><td>□</td><td class="mono">${esc(m.ref)}</td><td class="mono">${esc(m.no)}</td><td><div class="company-cell"><span class="tag">${companyCode(m.company)}</span><div><b>${esc(m.company)}</b><br><span class="muted">L12</span></div></div></td><td><span class="badge blue">${esc(m.type)}</span></td><td class="mono">${esc(m.months)}</td><td class="mono">${esc(m.expiry)} ${expired ? '<span class="badge red">EXP</span>' : soon ? '<span class="badge yellow">SOON</span>' : ''}</td><td>${esc(m.brand)}</td><td>${esc(m.model)}</td><td>${plateChip(m.plate)}</td><td>⋯</td></tr>`;
}

function bindMotors() {
  document.getElementById('motorSearch').oninput = (e) => { state.motorSearch = e.target.value; state.motorPage = 1; render(); };
  document.getElementById('companyFilter').onchange = (e) => { state.companyFilter = e.target.value; state.motorPage = 1; render(); };
  document.getElementById('statusFilter').onchange = (e) => { state.statusFilter = e.target.value; state.motorPage = 1; render(); };
  document.querySelectorAll('[data-page]').forEach((b) => b.onclick = () => { state.motorPage = Number(b.dataset.page); render(); });
  document.getElementById('newMotor').onclick = openMotorModal;
}

function reportsPage() {
  const dates = Array.from({ length: 6 }, (_, i) => {
    const d = new Date(today);
    d.setDate(d.getDate() - i);
    return d.toISOString().slice(0, 10);
  });
  const rows = state.report.filter((r) => {
    if (state.reportFilter === 'visitor') return r.company === 'VISITOR';
    if (state.reportFilter === 'expired') return r.expiry && r.expiry < today;
    if (state.reportFilter === 'am') return r.morning;
    if (state.reportFilter === 'pm') return r.afternoon;
    return true;
  });
  const companyRows = rows.filter((r) => r.company !== 'VISITOR');
  const visitorRows = rows.filter((r) => r.company === 'VISITOR');
  return h`
    <div class="reports-layout">
      <div class="card"><div class="card-pad"><h3 class="card-title">May 2026</h3><span class="muted">Pick a day to view</span></div>${dates.map((d) => `<div class="date-row ${state.reportDate === d ? 'active' : ''}" data-date="${d}"><b class="mono">${d}</b><br><span class="muted">AM 16 · PM 11 · V 3</span><span class="red-dot"></span></div>`).join('')}</div>
      <div class="card"><div class="report-head"><div><div class="caps">Daily report</div><div class="report-title">${state.reportDate} · Friday</div><div class="mini-stats"><span class="caps">AM <b style="color:var(--success)">${state.report.filter(r=>r.morning).length}</b></span><span class="caps">PM <b style="color:var(--accent-dark)">${state.report.filter(r=>r.afternoon).length}</b></span><span class="caps">Visitor <b style="color:var(--visitor)">${visitorRows.length}</b></span><span class="caps">Expired <b style="color:var(--danger)">${rows.filter(r=>r.expiry && r.expiry < today).length}</b></span></div></div><div><button class="secondary">Copy</button> <button class="primary" id="exportReport">Export XLSX</button></div></div><div class="filterbar"><span class="muted">Filter:</span>${['all','am','pm','visitor','expired'].map(f => `<button class="chip ${state.reportFilter === f ? 'active' : ''}" data-report-filter="${f}">${f.toUpperCase()}</button>`).join('')}<span style="margin-left:auto" class="muted">${rows.length} rows</span></div><div style="overflow:auto"><table><thead><tr><th>Ref</th><th>No.</th><th>Company</th><th>Type</th><th>Months</th><th>Expiry</th><th>Brand</th><th>Model</th><th>Plate Prefix</th><th>Plate Number</th><th>Morning</th><th>Afternoon</th></tr></thead><tbody>${reportRows(companyRows)}${visitorRows.length ? `<tr class="divider-row"><td colspan="12">Visitors (${visitorRows.length})</td></tr>${reportRows(visitorRows)}` : ''}</tbody></table></div></div>
    </div>`;
}

function reportRows(rows) {
  return rows.map((r) => `<tr class="${r.expiry && r.expiry < today ? 'expired' : ''}"><td class="mono">${esc(r.ref) || '—'}</td><td class="mono">${esc(r.no) || '—'}</td><td>${esc(r.company)}</td><td>${r.type ? `<span class="badge blue">${esc(r.type)}</span>` : '—'}</td><td class="mono">${esc(r.months) || '—'}</td><td class="mono">${esc(r.expiry) || '—'}</td><td>${esc(r.brand)}</td><td>${esc(r.model)}</td><td class="mono">${esc(r.platePrefix)}</td><td class="mono">${esc(r.plateNumber)}</td><td class="mono">${r.morning || '—'}</td><td class="mono">${r.afternoon || '—'}</td></tr>`).join('');
}

function bindReports() {
  document.querySelectorAll('[data-date]').forEach((row) => row.onclick = async () => { state.reportDate = row.dataset.date; await loadReport(); render(); });
  document.querySelectorAll('[data-report-filter]').forEach((b) => b.onclick = () => { state.reportFilter = b.dataset.reportFilter; render(); });
  document.getElementById('exportReport').onclick = exportReportCsv;
}

function companiesPage() {
  const selected = state.companies.find((c) => c.id === state.selectedCompany) || state.companies[0];
  const motors = state.motors.filter((m) => m.company === selected.name);
  return h`<div class="companies-layout"><div class="card"><div class="card-pad field-row"><div><h3 class="card-title">Tenants</h3><span class="muted">${state.companies.length} companies registered</span></div><button class="primary">+ Add</button></div>${state.companies.map((c) => `<div class="tenant-row ${selected.id === c.id ? 'active' : ''}" data-company="${c.id}"><span class="tag">${esc(c.code)}</span><div><b>${esc(c.name)}</b><br><span class="muted">${esc(c.floor)} · ${state.motors.filter(m=>m.company===c.name).length} motors</span></div></div>`).join('')}</div><div class="settings-content"><div class="card card-pad"><div class="company-cell"><span class="tag" style="width:72px;height:72px;font-size:22px">${esc(selected.code)}</span><div><div class="caps">Tenant · Floor ${esc(selected.floor)}</div><h2>${esc(selected.name)}</h2><span class="muted">${esc(selected.contact)} · <span class="mono">${esc(selected.phone)}</span></span></div></div></div><div class="grid4" style="grid-template-columns:repeat(3,1fr)">${kpi('☍','Registered motors',motors.length,'entries')}${kpi('◴','Expiring this year',motors.filter(isSoon).length,'watch list')}${kpi('!','Expired',motors.filter(isExpired).length,'needs renewal')}</div><div class="card"><div class="card-pad field-row"><div><h3 class="card-title">Motors registered to ${esc(selected.name)}</h3><span class="muted">${motors.length} entries</span></div><button class="secondary">Export</button></div><table><thead><tr><th>Ref</th><th>Brand · Model</th><th>Plate</th><th>Expiry</th><th>Status</th></tr></thead><tbody>${motors.map((m) => `<tr><td class="mono">${esc(m.ref)}</td><td>${esc(m.brand)} ${esc(m.model)}</td><td>${plateChip(m.plate)}</td><td class="mono">${esc(m.expiry)}</td><td><span class="badge ${isExpired(m) ? 'red' : isSoon(m) ? 'yellow' : 'green'}">${isExpired(m) ? 'Expired' : isSoon(m) ? 'Soon' : 'Active'}</span></td></tr>`).join('')}</tbody></table></div></div></div>`;
}

function bindCompanies() {
  document.querySelectorAll('[data-company]').forEach((row) => row.onclick = () => { state.selectedCompany = row.dataset.company; render(); });
}

function settingsPage() {
  const tabs = ['general', 'scan', 'reminders', 'admins', 'audit', 'integrations', 'billing'];
  return h`<div class="settings-layout"><div><div class="card-pad">${tabs.map((tab) => `<div class="settings-tab ${state.settings === tab ? 'active' : ''}" data-setting="${tab}">⋯ ${settingTitle(tab)}</div>`).join('')}</div><div class="muted" style="padding:120px 12px 0">MotoSheet v2.4.1<br>Building plan · G/F admin</div></div><div class="settings-content">${settingsContent(state.settings)}<div class="savebar"><span class="muted">● Unsaved changes</span><button class="secondary">Discard</button><button class="primary">✓ Save changes</button></div></div></div>`;
}

function settingTitle(tab) {
  return ({ general: 'General', scan: 'Scan windows', reminders: 'Reminders', admins: 'Admin users', audit: 'Audit log', integrations: 'Integrations', billing: 'Billing' })[tab];
}

function settingsContent(tab) {
  if (tab === 'scan') return cards(['Scan windows', 'Morning round 08:00-11:30 · Afternoon 14:00-17:30', 'Per-day overrides']);
  if (tab === 'reminders') return cards(['Renewal reminders', 'Notify when expiry is within · 30 days', 'Email template', 'Scheduled sends · next 7 days']);
  if (tab === 'admins') return cards(['People', 'Phon Sokha · Building admin', 'Hun Bunna · Parking officer', 'Roles & permissions']);
  if (tab === 'audit') return cards(['Activity log', 'Hun Bunna scanned 2C-9981', 'System exported daily report', 'Retention']);
  if (tab === 'integrations') return cards(['API & webhooks', 'Email & messaging', 'Storage & export', 'Accounting']);
  if (tab === 'billing') return cards(['Current plan · Building Pro', 'Payment method', 'Billing contact & tax', 'Invoices', 'Danger zone']);
  return cards(['Building', 'Name · Vtrust Tower', 'Locale · Asia/Phnom_Penh', 'Brand & appearance']);
}

function cards(items) {
  return items.map((item, index) => `<div class="card card-pad"><h3 class="card-title">${esc(item)}</h3><p class="muted">${index === 0 ? 'Configure this section for Vtrust Tower.' : 'Settings preview based on the design handoff.'}</p></div>`).join('');
}

function bindSettings() {
  document.querySelectorAll('[data-setting]').forEach((row) => row.onclick = () => { state.settings = row.dataset.setting; render(); });
}

function openMotorModal() {
  modalRoot.innerHTML = h`<div class="modal"><div class="dialog"><div class="dialog-head"><div><div class="caps">New entry</div><h2>Register a motor</h2></div><button class="secondary" id="closeModal">Close</button></div><div class="dialog-body"><label class="field">Company<select class="input" id="newCompany">${state.companies.map((c) => `<option>${esc(c.name)}</option>`).join('')}</select></label><div class="dialog-grid"><label class="field">Brand<input class="input" id="newBrand" placeholder="Honda"></label><label class="field">Model<input class="input" id="newModel" placeholder="Wave"></label></div><div class="dialog-grid"><label class="field">Plate prefix<input class="input mono" id="newPrefix" placeholder="1A"></label><label class="field">Plate number<input class="input mono" id="newNumber" placeholder="1234"></label></div><label class="field">Expiry<input type="date" class="input" id="newExpiry" value="2026-12-31"></label></div><div class="dialog-foot"><button class="secondary" id="cancelModal">Cancel</button><button class="primary" id="saveMotor">Save motor</button></div></div></div>`;
  document.getElementById('closeModal').onclick = closeModal;
  document.getElementById('cancelModal').onclick = closeModal;
  document.getElementById('saveMotor').onclick = () => {
    state.motors.unshift({
      id: `local-${Date.now()}`,
      ref: 'NEW',
      no: '—',
      company: document.getElementById('newCompany').value,
      type: 'FOC',
      months: 12,
      expiry: document.getElementById('newExpiry').value,
      brand: document.getElementById('newBrand').value || 'Unknown',
      model: document.getElementById('newModel').value || 'Unknown',
      plate: `${document.getElementById('newPrefix').value}-${document.getElementById('newNumber').value}`.toUpperCase(),
    });
    closeModal();
    render();
  };
}

function closeModal() {
  modalRoot.innerHTML = '';
}

function exportReportCsv() {
  const header = ['Ref','No.','Company','Type','Months','Expiry','Brand','Model','Plate Prefix','Plate Number','Morning','Afternoon'];
  const lines = [header, ...state.report.map((r) => [r.ref,r.no,r.company,r.type,r.months,r.expiry,r.brand,r.model,r.platePrefix,r.plateNumber,r.morning,r.afternoon])];
  const blob = new Blob([lines.map((r) => r.map((c) => `"${String(c ?? '').replace(/"/g, '""')}"`).join(',')).join('\n')], { type: 'text/csv' });
  const link = document.createElement('a');
  link.href = URL.createObjectURL(blob);
  link.download = `motosheet_${state.reportDate}.csv`;
  link.click();
}

await loadData();
render();
