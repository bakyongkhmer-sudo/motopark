import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/+esm';

let supabase = null;
let motorRows = [];
let motorPage = 1;
let activeTab = 'motors';
const motorPageSize = 25;

const defaultSupabaseUrl = 'https://euzkccwlqewlikwezqsw.supabase.co';
const defaultSupabaseKey = 'sb_publishable_94BN8Ucao1HLGztDoCZSGg_sH_wp0Ws';
const $ = (id) => document.getElementById(id);
const status = (text) => $('status').textContent = text;
const today = new Date().toISOString().slice(0, 10);

$('reportDate').value = today;
$('expiry').value = `${new Date().getFullYear() + 1}-01-01`;
supabase = createClient(defaultSupabaseUrl, defaultSupabaseKey);

$('loginButton').onclick = login;
$('logoutButton').onclick = logout;
$('tabMotors').onclick = () => setActiveTab('motors');
$('tabReport').onclick = () => setActiveTab('report');
$('openRegister').onclick = openRegisterModal;
$('closeRegister').onclick = closeRegisterModal;
$('registerModal').onclick = (event) => {
  if (event.target.id === 'registerModal') closeRegisterModal();
};
$('plate').onkeydown = (event) => {
  if (event.key === 'Enter') $('addMotor').click();
};
$('loginPassword').onkeydown = (event) => {
  if (event.key === 'Enter') login();
};

initAuth();

$('refreshMotors').onclick = refreshMotors;
$('refreshReport').onclick = refreshReport;
$('reportDate').onchange = refreshReport;
$('motorSearch').oninput = () => {
  motorPage = 1;
  renderMotors();
};
$('prevMotors').onclick = () => {
  if (motorPage > 1) {
    motorPage -= 1;
    renderMotors();
  }
};
$('nextMotors').onclick = () => {
  motorPage += 1;
  renderMotors();
};

$('addMotor').onclick = async () => {
  if (!await requireSession()) return;
  const companyName = $('company').value.trim();
  const plate = normalizePlate($('plate').value);
  if (!companyName || !plate || !$('expiry').value || !$('brand').value.trim() || !$('model').value.trim()) {
    return status('Company, plate, expiry, brand and model are required.');
  }

  let { data: company, error: companyError } = await supabase
    .from('companies')
    .upsert({ name: companyName }, { onConflict: 'name' })
    .select('id,name')
    .single();
  if (companyError) return status(companyError.message);

  const payload = {
    company_id: company.id,
    ref: $('ref').value.trim(),
    no: $('no').value.trim(),
    type: 'FOC',
    months: Number($('months').value || 12),
    expiry_date: $('expiry').value,
    brand: $('brand').value.trim(),
    model: $('model').value.trim(),
    plate,
  };
  const { error } = await supabase.from('registered_motors').upsert(payload, { onConflict: 'plate' });
  if (error) return status(error.message);
  status(`Saved ${plate}`);
  $('plate').value = '';
  closeRegisterModal();
  await refreshMotors();
};

async function refreshMotors() {
  if (!await requireSession()) return;
  status('Loading registered motors...');
  const { data, error } = await supabase
    .from('registered_motors')
    .select('id,ref,no,type,months,expiry_date,brand,model,plate,companies(name)')
    .order('plate');
  if (error) return status(error.message);
  motorRows = data || [];
  motorPage = 1;
  renderMotors();
  status(`Loaded ${motorRows.length} registered motors.`);
}

function renderMotors() {
  const query = $('motorSearch').value.trim().toLowerCase();
  const rows = motorRows.filter((row) => {
    const company = row.companies?.name || '';
    return !query || row.plate.toLowerCase().includes(query) || company.toLowerCase().includes(query);
  });
  const totalPages = Math.max(1, Math.ceil(rows.length / motorPageSize));
  motorPage = Math.min(Math.max(1, motorPage), totalPages);
  const start = (motorPage - 1) * motorPageSize;
  const pageRows = rows.slice(start, start + motorPageSize);
  $('motors').innerHTML = pageRows.length ? pageRows.map((row) => `
    <tr>
      <td>${escapeHtml(row.ref || '')}</td>
      <td>${escapeHtml(row.no || '')}</td>
      <td>${escapeHtml(row.companies?.name || '')}</td>
      <td>${escapeHtml(row.type || 'FOC')}</td>
      <td>${row.months || 12}</td>
      <td>${formatDate(row.expiry_date)}</td>
      <td>${escapeHtml(row.brand || '')}</td>
      <td>${escapeHtml(row.model || '')}</td>
      <td><strong>${escapeHtml(row.plate || '')}</strong></td>
      <td><button class="danger" data-delete="${row.id}">Delete</button></td>
    </tr>
  `).join('') : '<tr><td colspan="10"><div class="empty">No registered motors found.</div></td></tr>';
  const first = rows.length ? start + 1 : 0;
  const last = Math.min(start + pageRows.length, rows.length);
  $('motorPageInfo').textContent = `${first}-${last} of ${rows.length} · page ${motorPage}/${totalPages}`;
  $('prevMotors').disabled = motorPage <= 1;
  $('nextMotors').disabled = motorPage >= totalPages;

  document.querySelectorAll('[data-delete]').forEach((button) => {
    button.onclick = async () => {
      if (!confirm('Delete this registered motor?')) return;
      const { error } = await supabase.from('registered_motors').delete().eq('id', button.dataset.delete);
      if (error) return status(error.message);
      await refreshMotors();
    };
  });
}

async function refreshReport() {
  if (!await requireSession()) return;
  const date = $('reportDate').value || today;
  status(`Loading report for ${date}...`);
  $('report').innerHTML = '';
  const { data, error } = await supabase
    .from('daily_scan_report')
    .select('*')
    .eq('scan_date', date)
    .order('company')
    .order('plate_prefix')
    .order('plate_number');
  if (error) return status(error.message);
  const rows = (data || []).filter((row) => String(row.scan_date).slice(0, 10) === date);
  $('report').innerHTML = rows.length ? rows.map((row) => `
    <tr>
      <td>${escapeHtml(row.ref || '')}</td>
      <td>${escapeHtml(row.no || '')}</td>
      <td>${escapeHtml(row.company || '')}</td>
      <td>${escapeHtml(row.type || '')}</td>
      <td>${row.months || ''}</td>
      <td>${formatDate(row.expiry)}</td>
      <td>${escapeHtml(row.brand || '')}</td>
      <td>${escapeHtml(row.model || '')}</td>
      <td>${escapeHtml(row.plate_prefix || '')}</td>
      <td>${escapeHtml(row.plate_number || '')}</td>
      <td>${row.morning ? '✓' : ''}</td>
      <td>${row.afternoon ? '✓' : ''}</td>
    </tr>
  `).join('') : '<tr><td colspan="12"><div class="empty">No scan records for this date.</div></td></tr>';
  status(`Loaded ${rows.length} report rows for ${date}.`);
}

async function initAuth() {
  const { data } = await supabase.auth.getSession();
  setSignedIn(data.session);
  if (data.session) {
    await loadDashboard();
  }
  supabase.auth.onAuthStateChange(async (_event, session) => {
    setSignedIn(session);
    if (session) {
      await loadDashboard();
    }
  });
}

async function loadDashboard() {
  status('Loading data...');
  await refreshMotors();
  await refreshReport();
  setActiveTab(activeTab);
}

async function login() {
  const email = $('loginEmail').value.trim();
  const password = $('loginPassword').value;
  if (!email || !password) return status('Enter user email and password.');
  status('Signing in...');
  const { error } = await supabase.auth.signInWithPassword({ email, password });
  if (error) return status(error.message);
  $('loginPassword').value = '';
}

async function logout() {
  await supabase.auth.signOut();
  motorRows = [];
  $('motors').innerHTML = '';
  $('report').innerHTML = '';
  $('motorPageInfo').textContent = '0 records';
  status('Signed out.');
}

async function requireSession() {
  const { data } = await supabase.auth.getSession();
  if (data.session) return true;
  status('Please login first.');
  setSignedIn(null);
  return false;
}

function setSignedIn(session) {
  const signedIn = Boolean(session);
  $('loginPanel').classList.toggle('hidden', signedIn);
  $('appTabs').classList.toggle('hidden', !signedIn);
  $('sessionPill').textContent = signedIn ? session.user.email : 'Building management';
  if (!signedIn) {
    closeRegisterModal();
    $('motorsPanel').classList.add('hidden');
    $('reportPanel').classList.add('hidden');
  } else {
    setActiveTab(activeTab);
  }
  status(signedIn ? 'Logged in.' : 'Sign in with your building management account.');
}

function setActiveTab(tab) {
  activeTab = tab;
  const showMotors = tab === 'motors';
  $('motorsPanel').classList.toggle('hidden', !showMotors);
  $('reportPanel').classList.toggle('hidden', showMotors);
  $('tabMotors').classList.toggle('active', showMotors);
  $('tabReport').classList.toggle('active', !showMotors);
}

function openRegisterModal() {
  $('registerModal').classList.remove('hidden');
  $('company').focus();
}

function closeRegisterModal() {
  $('registerModal').classList.add('hidden');
}

function normalizePlate(value) {
  const raw = value.toUpperCase().replace(/[^A-Z0-9]/g, '');
  const match = raw.match(/^([0-9]?[A-Z]{1,4})([0-9]{4})$/);
  return match ? `${match[1]}-${match[2]}` : value.toUpperCase().trim();
}

function formatDate(value) {
  if (!value) return '';
  const date = new Date(`${value}T00:00:00`);
  return date.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: '2-digit' }).replace(/ /g, '-');
}

function escapeHtml(value) {
  return String(value).replace(/[&<>"']/g, (char) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[char]));
}
