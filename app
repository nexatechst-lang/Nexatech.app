<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>CRM Pro System</title>

  <!-- Chart.js -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js" defer></script>

  <!-- FullCalendar -->
  <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js" defer></script>

  <style>
    :root{
      --primary:#2563eb;
      --primary-600:#1e40af;
      --bg:#f4f6f9;
      --card:#ffffff;
      --muted:#64748b;
      --dark:#0f1724;
      --success:#16a34a;
      --danger:#dc2626;
      --glass: rgba(255,255,255,0.6);
      --radius:12px;
      --shadow: 0 6px 18px rgba(16,24,40,0.08);
      --max-width:1200px;
      --transition:200ms ease;
      font-family: Inter, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial;
    }

    *{box-sizing:border-box}
    html,body{height:100%}
    body{
      margin:0;
      background:linear-gradient(180deg,#f7fafc 0%,var(--bg) 100%);
      color:var(--dark);
      display:flex;
      min-height:100vh;
      align-items:flex-start;
      justify-content:center;
      padding:20px;
      -webkit-font-smoothing:antialiased;
      -moz-osx-font-smoothing:grayscale;
    }

    .app{
      width:100%;
      max-width:var(--max-width);
      display:grid;
      grid-template-columns:260px 1fr;
      gap:20px;
      align-items:start;
    }

    /* SIDEBAR */
    .sidebar{
      background:linear-gradient(180deg,var(--dark),#0b1220);
      color:#fff;
      padding:20px;
      border-radius:var(--radius);
      box-shadow:var(--shadow);
      min-height:calc(100vh - 40px);
      position:sticky;
      top:20px;
    }
    .brand{
      display:flex;
      gap:12px;
      align-items:center;
      margin-bottom:18px;
    }
    .brand .logo{
      width:44px;height:44px;border-radius:10px;background:var(--primary);display:flex;align-items:center;justify-content:center;font-weight:700;color:#fff;
    }
    .brand h1{font-size:18px;margin:0}
    .nav{margin-top:10px;display:flex;flex-direction:column;gap:6px}
    .nav button{
      background:transparent;border:0;color:#e6eef8;padding:10px;border-radius:8px;text-align:left;cursor:pointer;display:flex;align-items:center;gap:10px;font-weight:600;
      transition:background var(--transition),transform var(--transition);
    }
    .nav button:hover{background:rgba(255,255,255,0.04);transform:translateX(4px)}
    .nav button.active{background:rgba(255,255,255,0.06);box-shadow:inset 0 0 0 1px rgba(255,255,255,0.02)}
    .sidebar .footer{margin-top:auto;font-size:12px;color:#cbd5e1}

    /* MAIN */
    .main{
      min-height:calc(100vh - 40px);
      padding:20px;
      border-radius:var(--radius);
      background:transparent;
    }

    .header{
      display:flex;
      justify-content:space-between;
      align-items:center;
      gap:12px;
      margin-bottom:16px;
    }
    .header h2{margin:0;font-size:20px}
    .controls{display:flex;gap:8px;align-items:center}

    .card{
      background:var(--card);
      padding:18px;
      border-radius:12px;
      box-shadow:var(--shadow);
      margin-bottom:16px;
    }

    .kpis{display:flex;gap:16px;flex-wrap:wrap}
    .kpi{flex:1;min-width:160px;padding:14px;border-radius:10px;background:linear-gradient(180deg,#fff,#fbfdff);text-align:center}
    .kpi h3{margin:0;font-size:20px}
    .kpi p{margin:6px 0 0;color:var(--muted);font-size:13px}

    /* forms */
    .form-grid{display:grid;grid-template-columns:repeat(2,1fr);gap:10px}
    .form-grid .full{grid-column:1/-1}
    input,select,textarea{
      width:100%;padding:10px;border-radius:8px;border:1px solid #e6eef8;background:#fff;outline:none;font-size:14px;
    }
    input:focus,select:focus,textarea:focus{box-shadow:0 6px 18px rgba(37,99,235,0.08);border-color:var(--primary-600)}

    .btn{display:inline-flex;align-items:center;gap:8px;padding:8px 12px;border-radius:8px;border:0;cursor:pointer}
    .btn.primary{background:var(--primary);color:#fff}
    .btn.ghost{background:transparent;border:1px solid #e6eef8}
    .btn.danger{background:var(--danger);color:#fff}

    table{width:100%;border-collapse:collapse;font-size:14px}
    th,td{padding:10px;border-bottom:1px solid #f1f5f9;text-align:left}
    th{color:var(--muted);font-weight:600}

    /* Kanban */
    .kanban{display:flex;gap:12px;overflow:auto;padding-bottom:8px}
    .column{
      background:#f8fafc;padding:12px;border-radius:10px;min-width:220px;max-width:280px;flex:0 0 260px;
      display:flex;flex-direction:column;gap:8px;height:420px;overflow:auto;
    }
    .column h4{margin:0 0 6px 0;font-size:14px}
    .lead-card{
      background:#fff;padding:10px;border-radius:8px;box-shadow:0 4px 12px rgba(2,6,23,0.04);cursor:grab;border:1px solid #eef2ff;
    }
    .lead-card:active{cursor:grabbing}
    .lead-meta{display:flex;justify-content:space-between;align-items:center;gap:8px}

    /* responsive */
    @media (max-width:980px){
      .app{grid-template-columns:1fr; padding:12px}
      .sidebar{position:relative;min-height:auto;display:flex;flex-direction:row;gap:12px;align-items:center;padding:12px}
      .nav{flex-direction:row;gap:6px;overflow:auto}
      .nav button{padding:8px;font-size:13px}
      .main{padding:12px}
      .form-grid{grid-template-columns:1fr}
      .kanban{height:auto}
    }

    /* small UI */
    .search{display:flex;gap:8px;align-items:center}
    .toast{position:fixed;right:20px;bottom:20px;background:#111827;color:#fff;padding:12px 16px;border-radius:8px;box-shadow:var(--shadow);opacity:0;transform:translateY(12px);transition:all 300ms ease}
    .toast.show{opacity:1;transform:translateY(0)}
    .modal-backdrop{position:fixed;inset:0;background:rgba(2,6,23,0.5);display:none;align-items:center;justify-content:center;padding:20px}
    .modal{background:#fff;padding:18px;border-radius:12px;max-width:720px;width:100%;box-shadow:var(--shadow)}
    .modal.show{display:block}
    .sr-only{position:absolute;width:1px;height:1px;padding:0;margin:-1px;overflow:hidden;clip:rect(0,0,0,0);white-space:nowrap;border:0}

    /* comments */
    .comments-list{max-height:240px;overflow:auto;border:1px solid #eef2ff;padding:8px;border-radius:8px;background:#fbfdff}
    .comment-item{padding:8px;border-radius:8px;background:#fff;margin-bottom:8px;border:1px solid #f1f5f9}
    .comment-meta{font-size:12px;color:var(--muted);margin-bottom:6px}
  </style>
</head>
<body>
  <div class="app" id="app">
    <!-- SIDEBAR -->
    <aside class="sidebar" aria-label="Navegação principal">
      <div class="brand">
        <div class="logo" aria-hidden="true">CP</div>
        <div>
          <h1>CRM Pro</h1>
          <div style="font-size:12px;color:#cbd5e1">Painel de vendas</div>
        </div>
      </div>

      <nav class="nav" role="navigation" aria-label="Seções do sistema">
        <button type="button" data-section="dashboard" class="active" aria-pressed="true">Dashboard</button>
        <button type="button" data-section="clients">Clientes</button>
        <button type="button" data-section="leads">Leads</button>
        <button type="button" data-section="calendar">Agenda</button>
        <button type="button" data-section="team">Equipe</button>
        <button type="button" data-section="reports">Relatórios</button>
        <button type="button" data-section="integrations">Integrações</button>
      </nav>

      <div class="footer" aria-hidden="true">
        Versão 1.1 • <span id="userGreeting">Olá</span>
      </div>
    </aside>

    <!-- MAIN -->
    <main class="main" id="main" role="main">
      <div class="header">
        <h2 id="pageTitle">Dashboard</h2>
        <div class="controls">
          <div class="search" role="search" aria-label="Busca global">
            <input id="globalSearch" type="search" placeholder="Buscar clientes, leads..." aria-label="Buscar" />
            <button type="button" class="btn ghost" id="clearSearch" title="Limpar busca">Limpar</button>
          </div>
          <button type="button" class="btn primary" id="newLeadBtn">Novo Lead</button>
        </div>
      </div>

      <!-- DASHBOARD -->
      <section id="dashboard" class="section card" aria-labelledby="pageTitle">
        <div class="kpis" aria-hidden="false">
          <div class="kpi" aria-live="polite">
            <h3 id="kpiSales">0</h3>
            <p>Vendas</p>
          </div>
          <div class="kpi">
            <h3 id="kpiLeads">0</h3>
            <p>Leads</p>
          </div>
          <div class="kpi">
            <h3 id="kpiConv">0%</h3>
            <p>Conversão</p>
          </div>
        </div>

        <div class="card" style="margin-top:12px">
          <canvas id="salesChart" height="120" aria-label="Gráfico de vendas" role="img"></canvas>
        </div>
      </section>

      <!-- CLIENTES -->
      <section id="clients" class="section" hidden>
        <h3>Clientes</h3>

        <div class="card" aria-label="Formulário de cliente">
          <form id="clientForm" novalidate>
            <div class="form-grid">
              <div>
                <label class="sr-only" for="clientName">Nome</label>
                <input id="clientName" name="name" placeholder="Nome" required />
              </div>
              <div>
                <label class="sr-only" for="clientEmail">Email</label>
                <input id="clientEmail" name="email" type="email" placeholder="Email" required />
              </div>
              <div>
                <label class="sr-only" for="clientPhone">Telefone</label>
                <input id="clientPhone" name="phone" placeholder="Telefone" />
              </div>
              <div>
                <label class="sr-only" for="clientCompany">Empresa</label>
                <input id="clientCompany" name="company" placeholder="Empresa" />
              </div>
              <div>
                <label class="sr-only" for="clientRole">Cargo</label>
                <input id="clientRole" name="role" placeholder="Cargo" />
              </div>
              <div class="full">
                <label class="sr-only" for="clientAddress">Endereço</label>
                <input id="clientAddress" name="address" placeholder="Endereço" />
              </div>
            </div>

            <div style="margin-top:10px;display:flex;gap:8px">
              <button type="submit" class="btn primary">Salvar Cliente</button>
              <button type="button" id="resetClient" class="btn ghost">Limpar</button>
            </div>
          </form>
        </div>

        <div style="margin-top:12px" class="card">
          <input id="searchClient" placeholder="Buscar clientes..." aria-label="Buscar clientes" />
          <table aria-label="Tabela de clientes" style="margin-top:10px">
            <thead>
              <tr><th>Nome</th><th>Email</th><th>Empresa</th><th>Ações</th></tr>
            </thead>
            <tbody id="clientTable"></tbody>
          </table>
        </div>
      </section>

      <!-- LEADS -->
      <section id="leads" class="section" hidden>
        <h3>Pipeline</h3>

        <div class="card" aria-label="Formulário de lead">
          <form id="leadForm" novalidate>
            <div style="display:flex;gap:8px;flex-wrap:wrap">
              <input id="leadName" name="leadName" placeholder="Nome do Lead" required />
              <select id="leadSource" name="leadSource" aria-label="Fonte do lead">
                <option value="Site">Site</option>
                <option value="Instagram">Instagram</option>
                <option value="Indicação">Indicação</option>
                <option value="Evento">Evento</option>
              </select>
              <select id="leadOwner" name="leadOwner" aria-label="Responsável">
                <option value="">Sem responsável</option>
              </select>
              <button class="btn primary" type="submit">Adicionar Lead</button>
            </div>
          </form>
        </div>

        <div class="card" style="margin-top:12px">
          <div class="kanban" id="kanban" aria-label="Quadro Kanban">
            <div class="column" data-stage="Novo Lead" ondragover="event.preventDefault()">
              <h4>Novo Lead</h4>
              <div class="dropzone" data-stage="Novo Lead"></div>
            </div>
            <div class="column" data-stage="Qualificação" ondragover="event.preventDefault()">
              <h4>Qualificação</h4>
              <div class="dropzone" data-stage="Qualificação"></div>
            </div>
            <div class="column" data-stage="Proposta" ondragover="event.preventDefault()">
              <h4>Proposta</h4>
              <div class="dropzone" data-stage="Proposta"></div>
            </div>
            <div class="column" data-stage="Negociação" ondragover="event.preventDefault()">
              <h4>Negociação</h4>
              <div class="dropzone" data-stage="Negociação"></div>
            </div>
            <div class="column" data-stage="Fechado" ondragover="event.preventDefault()">
              <h4>Fechado</h4>
              <div class="dropzone" data-stage="Fechado"></div>
            </div>
          </div>
        </div>
      </section>

      <!-- CALENDAR -->
      <section id="calendar" class="section" hidden>
        <h3>Agenda</h3>
        <div class="card">
          <div id="calendarView" style="min-height:420px"></div>
        </div>
      </section>

      <!-- TEAM -->
      <section id="team" class="section" hidden>
        <h3>Equipe</h3>
        <div class="card">
          <form id="userForm">
            <div style="display:flex;gap:8px;flex-wrap:wrap">
              <input id="userName" placeholder="Nome" required />
              <select id="userRole">
                <option value="admin">Admin</option>
                <option value="vendedor">Vendedor</option>
                <option value="suporte">Suporte</option>
              </select>
              <button class="btn primary" type="submit">Adicionar</button>
            </div>
          </form>
        </div>

        <div class="card">
          <ul id="teamList" aria-label="Lista de membros"></ul>
        </div>
      </section>

      <!-- REPORTS -->
      <section id="reports" class="section" hidden>
        <h3>Relatórios</h3>
        <div class="card">
          <div style="display:flex;gap:8px;flex-wrap:wrap">
            <button type="button" class="btn primary" id="exportCSV">Exportar CSV</button>
            <button type="button" class="btn ghost" id="downloadJSON">Baixar JSON</button>
          </div>
        </div>
      </section>

      <!-- INTEGRATIONS -->
      <section id="integrations" class="section" hidden>
        <h3>Integrações</h3>
        <div class="card">
          <p>Integração com Email (simulado)</p>
          <button type="button" class="btn primary" id="connectEmail">Conectar Email</button>
        </div>
        <div class="card">
          <p>Integração com WhatsApp (simulado)</p>
          <button type="button" class="btn primary" id="connectWhats">Conectar WhatsApp</button>
        </div>
      </section>
    </main>
  </div>

  <!-- Modal (edição cliente) -->
  <div class="modal-backdrop" id="modalBackdrop" aria-hidden="true">
    <div class="modal" role="dialog" aria-modal="true" aria-labelledby="modalTitle">
      <h4 id="modalTitle">Editar Cliente</h4>
      <form id="modalForm">
        <div style="display:grid;gap:8px">
          <input id="modalName" placeholder="Nome" required />
          <input id="modalEmail" type="email" placeholder="Email" />
          <div style="display:flex;gap:8px;justify-content:flex-end;margin-top:8px">
            <button type="button" class="btn ghost" id="modalCancel">Cancelar</button>
            <button type="submit" class="btn primary">Salvar</button>
          </div>
        </div>
      </form>
    </div>
  </div>

  <!-- Lead Comments Modal -->
  <div class="modal-backdrop" id="leadModalBackdrop" aria-hidden="true">
    <div class="modal" role="dialog" aria-modal="true" aria-labelledby="leadModalTitle">
      <h4 id="leadModalTitle">Comentários do Lead</h4>

      <div id="leadDetails" style="margin-bottom:12px;font-size:14px;color:var(--muted)"></div>

      <div class="comments-list" id="commentsList" aria-live="polite"></div>

      <form id="commentForm" style="margin-top:12px">
        <div style="display:grid;gap:8px">
          <input id="commentAuthor" placeholder="Seu nome" />
          <textarea id="commentText" placeholder="Escreva um comentário..." rows="3"></textarea>
          <div style="display:flex;gap:8px;justify-content:flex-end">
            <button type="button" class="btn ghost" id="closeLeadModal">Fechar</button>
            <button type="submit" class="btn primary">Adicionar Comentário</button>
          </div>
        </div>
      </form>
    </div>
  </div>

  <!-- Toast -->
  <div id="toast" class="toast" role="status" aria-live="polite"></div>

  <!-- Templates -->
  <template id="clientRowTpl">
    <tr>
      <td class="c-name"></td>
      <td class="c-email"></td>
      <td class="c-company"></td>
      <td>
        <button type="button" class="btn ghost edit-client">Editar</button>
        <button type="button" class="btn danger delete-client">Excluir</button>
      </td>
    </tr>
  </template>

  <template id="leadCardTpl">
    <div class="lead-card" draggable="true" tabindex="0" role="article" aria-grabbed="false">
      <div class="lead-title" style="font-weight:600"></div>
      <div class="lead-meta">
        <div style="font-size:12px;color:var(--muted)"></div>
        <div style="display:flex;gap:6px">
          <button type="button" class="btn ghost small edit-lead">Comentários</button>
          <button type="button" class="btn ghost small rename-lead">Renomear</button>
          <button type="button" class="btn danger small remove-lead">Remover</button>
        </div>
      </div>
    </div>
  </template>

  <script>
    'use strict';

    const qs = (sel, ctx=document) => ctx.querySelector(sel);
    const qsa = (sel, ctx=document) => Array.from(ctx.querySelectorAll(sel));
    const sanitize = (str='') => String(str).replace(/[<>]/g, '');

    const STORAGE_KEYS = {
      CLIENTS: 'crm_clients_v1',
      LEADS: 'crm_leads_v1',
      USERS: 'crm_users_v1',
      EVENTS: 'crm_events_v1'
    };

    let state = {
      clients: JSON.parse(localStorage.getItem(STORAGE_KEYS.CLIENTS) || '[]'),
      leads: JSON.parse(localStorage.getItem(STORAGE_KEYS.LEADS) || '[]'),
      users: JSON.parse(localStorage.getItem(STORAGE_KEYS.USERS) || '[]'),
      events: JSON.parse(localStorage.getItem(STORAGE_KEYS.EVENTS) || '[]')
    };

    // simple persist helpers
    const saveClients = () => localStorage.setItem(STORAGE_KEYS.CLIENTS, JSON.stringify(state.clients));
    const saveLeads = () => localStorage.setItem(STORAGE_KEYS.LEADS, JSON.stringify(state.leads));
    const saveUsers = () => localStorage.setItem(STORAGE_KEYS.USERS, JSON.stringify(state.users));
    const saveEvents = () => localStorage.setItem(STORAGE_KEYS.EVENTS, JSON.stringify(state.events));

    const toastEl = qs('#toast');
    const showToast = (msg, ms=3000) => {
      toastEl.textContent = msg;
      toastEl.classList.add('show');
      setTimeout(()=>toastEl.classList.remove('show'), ms);
    };

    const debounce = (fn, wait=300) => {
      let t;
      return (...args) => {
        clearTimeout(t);
        t = setTimeout(()=>fn(...args), wait);
      };
    };

    /* Navigation */
    const navButtons = qsa('.nav button');
    const sections = qsa('.section');

    const setActiveSection = (id) => {
      navButtons.forEach(b=>{
        const active = b.dataset.section === id;
        b.classList.toggle('active', active);
        b.setAttribute('aria-pressed', active ? 'true' : 'false');
      });
      sections.forEach(s=>{
        if(s.id === id){
          s.hidden = false;
          qs('#pageTitle').textContent = s.querySelector('h3')?.textContent || 'Dashboard';
        } else {
          s.hidden = true;
        }
      });
    };

    navButtons.forEach(btn=>{
      btn.addEventListener('click', ()=> setActiveSection(btn.dataset.section));
    });

    /* CLIENTS */
    const clientForm = qs('#clientForm');
    const clientTable = qs('#clientTable');
    const clientTpl = qs('#clientRowTpl');

    const renderClients = (filter='') => {
      clientTable.innerHTML = '';
      const q = (filter || '').trim().toLowerCase();
      state.clients.forEach((c, i) => {
        if(q && !(c.name||'').toLowerCase().includes(q) && !(c.email||'').toLowerCase().includes(q) && !(c.company||'').toLowerCase().includes(q)) return;
        const row = clientTpl.content.cloneNode(true);
        row.querySelector('.c-name').textContent = c.name;
        row.querySelector('.c-email').textContent = c.email;
        row.querySelector('.c-company').textContent = c.company || '-';
        const editBtn = row.querySelector('.edit-client');
        const delBtn = row.querySelector('.delete-client');

        editBtn.addEventListener('click', ()=> openEditClientModal(i));
        delBtn.addEventListener('click', ()=> {
          if(confirm(`Excluir cliente "${c.name}"?`)){
            state.clients.splice(i,1);
            saveClients();
            renderClients(qs('#searchClient')?.value || '');
            showToast('Cliente excluído');
          }
        });

        clientTable.appendChild(row);
      });
    };

    clientForm.addEventListener('submit', (e)=>{
      e.preventDefault();
      const name = sanitize(qs('#clientName').value.trim());
      const email = sanitize(qs('#clientEmail').value.trim());
      if(!name || !email){
        showToast('Nome e email são obrigatórios');
        return;
      }
      const client = {
        id: Date.now(),
        name, email,
        phone: sanitize(qs('#clientPhone').value),
        company: sanitize(qs('#clientCompany').value),
        role: sanitize(qs('#clientRole').value),
        address: sanitize(qs('#clientAddress').value)
      };
      state.clients.push(client);
      saveClients();
      e.target.reset();
      renderClients();
      showToast('Cliente salvo');
    });

    qs('#resetClient').addEventListener('click', ()=> clientForm.reset());
    qs('#searchClient').addEventListener('input', debounce((e)=> renderClients(e.target.value), 250));

    /* Modal edit client */
    const modalBackdrop = qs('#modalBackdrop');
    const modalForm = qs('#modalForm');
    let editingClientIndex = null;

    const openEditClientModal = (index) => {
      editingClientIndex = index;
      const c = state.clients[index];
      qs('#modalName').value = c.name;
      qs('#modalEmail').value = c.email;
      modalBackdrop.style.display = 'flex';
      modalBackdrop.setAttribute('aria-hidden','false');
      qs('#modalName').focus();
    };

    qs('#modalCancel').addEventListener('click', ()=> {
      modalBackdrop.style.display = 'none';
      modalBackdrop.setAttribute('aria-hidden','true');
      editingClientIndex = null;
    });

    modalForm.addEventListener('submit', (e)=>{
      e.preventDefault();
      if(editingClientIndex === null) return;
      state.clients[editingClientIndex].name = sanitize(qs('#modalName').value.trim());
      state.clients[editingClientIndex].email = sanitize(qs('#modalEmail').value.trim());
      saveClients();
      renderClients();
      modalBackdrop.style.display = 'none';
      modalBackdrop.setAttribute('aria-hidden','true');
      showToast('Cliente atualizado');
      editingClientIndex = null;
    });

    /* LEADS */
    const leadForm = qs('#leadForm');
    const leadOwnerSelect = qs('#leadOwner');
    const leadTpl = qs('#leadCardTpl');

    const defaultStages = ['Novo Lead','Qualificação','Proposta','Negociação','Fechado'];

    const renderLeads = () => {
      qsa('.dropzone').forEach(dz => dz.innerHTML = '');
      state.leads.forEach((l, i) => {
        // ensure comments array exists
        if(!Array.isArray(l.comments)) l.comments = l.comments || [];
        const card = leadTpl.content.cloneNode(true);
        const el = card.querySelector('.lead-card');
        el.dataset.index = i;
        el.querySelector('.lead-title').textContent = l.name;
        const meta = el.querySelector('.lead-meta > div');
        const commentsCount = (l.comments && l.comments.length) ? ` • ${l.comments.length} comentário(s)` : '';
        meta.textContent = `${l.source} • ${l.owner || 'Sem responsável'}${commentsCount}`;

        el.addEventListener('dragstart', (ev)=>{
          ev.dataTransfer.setData('text/plain', i);
          el.setAttribute('aria-grabbed','true');
        });
        el.addEventListener('dragend', ()=> el.setAttribute('aria-grabbed','false'));

        el.addEventListener('keydown', (ev)=>{
          if(ev.key === 'Delete'){ removeLead(i); }
        });

        el.querySelector('.remove-lead').addEventListener('click', ()=> removeLead(i));
        el.querySelector('.rename-lead').addEventListener('click', ()=> editLeadInline(i));
        el.querySelector('.edit-lead').addEventListener('click', ()=> openLeadComments(i));

        const stage = l.stage || 'Novo Lead';
        const dropzone = qs(`.dropzone[data-stage="${stage}"]`);
        if(dropzone) dropzone.appendChild(el);
      });
      updateKPIs();
      updateChart();
    };

    qsa('.column').forEach(col=>{
      col.addEventListener('drop', (ev)=>{
        ev.preventDefault();
        const idx = ev.dataTransfer.getData('text/plain');
        const stage = col.dataset.stage;
        if(typeof state.leads[idx] !== 'undefined'){
          state.leads[idx].stage = stage;
          saveLeads();
          renderLeads();
          showToast(`Lead movido para "${stage}"`);
        }
      });
    });

    const addLead = (lead) => {
      // ensure comments array
      lead.comments = lead.comments || [];
      state.leads.push(lead);
      saveLeads();
      renderLeads();
      showToast('Lead adicionado');
    };

    leadForm.addEventListener('submit', (e)=>{
      e.preventDefault();
      const name = sanitize(qs('#leadName').value.trim());
      const source = sanitize(qs('#leadSource').value);
      const owner = sanitize(qs('#leadOwner').value);
      if(!name) { showToast('Nome do lead é obrigatório'); return; }
      addLead({ id: Date.now(), name, source, owner, stage: 'Novo Lead', createdAt: new Date().toISOString(), comments: [] });
      leadForm.reset();
    });

    const removeLead = (index) => {
      if(!confirm('Remover lead?')) return;
      state.leads.splice(index,1);
      saveLeads();
      renderLeads();
      showToast('Lead removido');
    };

    const editLeadInline = (index) => {
      const l = state.leads[index];
      const newName = prompt('Editar nome do lead', l.name);
      if(newName !== null){
        state.leads[index].name = sanitize(newName.trim());
        saveLeads();
        renderLeads();
        showToast('Lead atualizado');
      }
    };

    /* Lead Comments Modal Logic */
    const leadModalBackdrop = qs('#leadModalBackdrop');
    const commentsListEl = qs('#commentsList');
    const commentForm = qs('#commentForm');
    const commentAuthor = qs('#commentAuthor');
    const commentText = qs('#commentText');
    const leadDetails = qs('#leadDetails');
    const closeLeadModalBtn = qs('#closeLeadModal');

    let activeLeadIndex = null;

    const formatDateTime = (iso) => {
      try {
        const d = new Date(iso);
        return d.toLocaleString();
      } catch {
        return iso;
      }
    };

    const renderCommentsForLead = (index) => {
      commentsListEl.innerHTML = '';
      const lead = state.leads[index];
      if(!lead || !Array.isArray(lead.comments) || lead.comments.length === 0){
        commentsListEl.innerHTML = '<div style="color:var(--muted)">Nenhum comentário ainda.</div>';
        return;
      }
      // newest first
      const items = [...lead.comments].sort((a,b)=> new Date(b.createdAt) - new Date(a.createdAt));
      items.forEach(c => {
        const div = document.createElement('div');
        div.className = 'comment-item';
        const meta = document.createElement('div');
        meta.className = 'comment-meta';
        meta.textContent = `${c.author || 'Anônimo'} • ${formatDateTime(c.createdAt)}`;
        const text = document.createElement('div');
        text.textContent = c.text;
        div.appendChild(meta);
        div.appendChild(text);
        commentsListEl.appendChild(div);
      });
    };

    const openLeadComments = (index) => {
      activeLeadIndex = index;
      const lead = state.leads[index];
      leadDetails.textContent = `${lead.name} — ${lead.source} — ${lead.owner || 'Sem responsável'}`;
      renderCommentsForLead(index);
      commentAuthor.value = '';
      commentText.value = '';
      leadModalBackdrop.style.display = 'flex';
      leadModalBackdrop.setAttribute('aria-hidden','false');
      qs('#commentAuthor').focus();
    };

    const closeLeadComments = () => {
      activeLeadIndex = null;
      leadModalBackdrop.style.display = 'none';
      leadModalBackdrop.setAttribute('aria-hidden','true');
    };

    closeLeadModalBtn.addEventListener('click', (e)=>{
      e.preventDefault();
      closeLeadComments();
    });

    commentForm.addEventListener('submit', (e)=>{
      e.preventDefault();
      if(activeLeadIndex === null) return;
      const author = sanitize(commentAuthor.value.trim()) || 'Anônimo';
      const text = sanitize(commentText.value.trim());
      if(!text){ showToast('Comentário vazio'); return; }
      const comment = { id: Date.now(), author, text, createdAt: new Date().toISOString() };
      state.leads[activeLeadIndex].comments = state.leads[activeLeadIndex].comments || [];
      state.leads[activeLeadIndex].comments.push(comment);
      saveLeads();
      renderCommentsForLead(activeLeadIndex);
      renderLeads(); // update counts on cards
      commentAuthor.value = '';
      commentText.value = '';
      showToast('Comentário adicionado');
    });

    /* USERS */
    const userForm = qs('#userForm');
    const teamList = qs('#teamList');

    const renderUsers = () => {
      teamList.innerHTML = '';
      state.users.forEach((u,i)=>{
        const li = document.createElement('li');
        li.textContent = `${u.name} — ${u.role}`;
        const del = document.createElement('button');
        del.className = 'btn ghost';
        del.textContent = 'Remover';
        del.addEventListener('click', ()=>{
          if(confirm('Remover usuário?')){
            state.users.splice(i,1);
            saveUsers();
            renderUsers();
            populateOwners();
            showToast('Usuário removido');
          }
        });
        li.appendChild(del);
        teamList.appendChild(li);
      });
    };

    userForm.addEventListener('submit', (e)=>{
      e.preventDefault();
      const name = sanitize(qs('#userName').value.trim());
      const role = sanitize(qs('#userRole').value);
      if(!name) { showToast('Nome é obrigatório'); return; }
      state.users.push({ id: Date.now(), name, role });
      saveUsers();
      userForm.reset();
      renderUsers();
      populateOwners();
      showToast('Usuário adicionado');
    });

    const populateOwners = () => {
      leadOwnerSelect.innerHTML = '<option value="">Sem responsável</option>';
      state.users.forEach(u=>{
        const opt = document.createElement('option');
        opt.value = u.name;
        opt.textContent = u.name;
        leadOwnerSelect.appendChild(opt);
      });
    };

    /* KPIs & Chart */
    const kpiSales = qs('#kpiSales');
    const kpiLeads = qs('#kpiLeads');
    const kpiConv = qs('#kpiConv');

    const updateKPIs = () => {
      const totalLeads = state.leads.length;
      const closed = state.leads.filter(l=>l.stage === 'Fechado').length;
      kpiSales.textContent = closed;
      kpiLeads.textContent = totalLeads;
      const conv = totalLeads ? ((closed/totalLeads)*100).toFixed(1) : 0;
      kpiConv.textContent = `${conv}%`;
    };

    let salesChart;

    const initChart = () => {
      const ctx = qs('#salesChart').getContext('2d');
      salesChart = new Chart(ctx, {
        type: 'bar',
        data: {
          labels: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
          datasets: [{
            label: 'Vendas (Fechado)',
            backgroundColor: 'rgba(37,99,235,0.8)',
            data: Array(12).fill(0)
          }]
        },
        options: {
          responsive:true,
          maintainAspectRatio:false,
          plugins:{legend:{display:false}}
        }
      });
      updateChart();
    };

    const updateChart = () => {
      if(!salesChart) return;
      const months = Array(12).fill(0);
      state.leads.filter(l=>l.stage === 'Fechado').forEach(l=>{
        const d = l.closedAt ? new Date(l.closedAt) : new Date(l.createdAt || Date.now());
        months[d.getMonth()] += 1;
      });
      salesChart.data.datasets[0].data = months;
      salesChart.update();
    };

    /* CALENDAR */
    let calendar;
    const initCalendar = () => {
      const calendarEl = qs('#calendarView');
      calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        selectable: true,
        headerToolbar: { left: 'prev,next today', center: 'title', right: 'dayGridMonth,timeGridWeek' },
        events: state.events || [],
        select: function(info){
          const title = prompt('Nome da tarefa:');
          if(title){
            const ev = { id: Date.now().toString(), title: sanitize(title), start: info.startStr, allDay: true };
            calendar.addEvent(ev);
            state.events.push(ev);
            saveEvents();
            showToast('Evento criado');
          }
        },
        eventClick: function(info){
          if(confirm(`Remover evento "${info.event.title}"?`)){
            info.event.remove();
            state.events = state.events.filter(e => e.id !== info.event.id);
            saveEvents();
            showToast('Evento removido');
          }
        }
      });
      calendar.render();
    };

    /* EXPORT / IMPORT */
    qs('#exportCSV').addEventListener('click', ()=>{
      let csv = 'Tipo,Nome,Email,Empresa,Origem,Estágio,Responsável\n';
      state.clients.forEach(c => {
        csv += `Cliente,${c.name || ''},${c.email || ''},${c.company || ''},,,\n`;
      });
      state.leads.forEach(l => {
        csv += `Lead,${l.name || ''},, ,${l.source || ''},${l.stage || ''},${l.owner || ''}\n`;
      });
      const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
      const url = URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = 'crm_export.csv';
      a.click();
      URL.revokeObjectURL(url);
      showToast('CSV gerado');
    });

    qs('#downloadJSON').addEventListener('click', ()=>{
      const data = { clients: state.clients, leads: state.leads, users: state.users, events: state.events };
      const blob = new Blob([JSON.stringify(data, null, 2)], { type: 'application/json' });
      const url = URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = 'crm_export.json';
      a.click();
      URL.revokeObjectURL(url);
      showToast('JSON gerado');
    });

    /* INTEGRATIONS (simulated) */
    qs('#connectEmail').addEventListener('click', async ()=>{
      showToast('Conectando ao serviço de email...');
      await new Promise(r=>setTimeout(r,800));
      showToast('Email conectado (simulado)');
    });

    qs('#connectWhats').addEventListener('click', async ()=>{
      showToast('Conectando ao WhatsApp...');
      await new Promise(r=>setTimeout(r,800));
      showToast('WhatsApp conectado (simulado)');
    });

    /* GLOBAL SEARCH */
    const globalSearch = qs('#globalSearch');
    const clearSearch = qs('#clearSearch');

    const handleGlobalSearch = debounce((e)=>{
      const q = e.target.value.trim().toLowerCase();
      renderClients(q);
      const leadMatch = state.leads.find(l => (l.name||'').toLowerCase().includes(q) || (l.source||'').toLowerCase().includes(q));
      if(leadMatch && q) setActiveSection('leads');
    }, 300);

    globalSearch.addEventListener('input', handleGlobalSearch);
    clearSearch.addEventListener('click', ()=> {
      globalSearch.value = '';
      renderClients();
    });

    /* BOOTSTRAP */
    const updateGreeting = () => {
      const name = state.users[0]?.name || 'Usuário';
      qs('#userGreeting').textContent = `Olá, ${name}`;
    };

    const bootstrap = () => {
      // initialize chart first so renderLeads can update it
      initChart();

      renderClients();
      renderUsers();
      populateOwners();
      renderLeads();
      updateGreeting();
      initCalendar();

      qs('#newLeadBtn').addEventListener('click', ()=> {
        setActiveSection('leads');
        qs('#leadName').focus();
      });

      document.addEventListener('keydown', (e)=>{
        if((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === 'k'){
          e.preventDefault();
          globalSearch.focus();
        }
      });

      if(state.users.length === 0){
        state.users.push({ id:1, name:'Admin', role:'admin' });
        saveUsers();
        populateOwners();
        renderUsers();
      }
      if(state.leads.length === 0 && state.clients.length === 0){
        state.leads.push({ id:Date.now()+1, name:'Empresa X', source:'Site', owner:'Admin', stage:'Novo Lead', createdAt:new Date().toISOString(), comments: [] });
        saveLeads();
      }
    };

    window._crm = { state, renderClients, renderLeads };

    window.addEventListener('load', bootstrap);
  </script>
</body>
</html>
