<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="uk">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>${mode eq 'edit' ? 'Редагування' : 'Новий квиток'} — Кінотеатр</title>
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root {
      --bg:      #0d0d14;
      --surface: #16161f;
      --border:  #2a2a3d;
      --accent:  #e63946;
      --accent2: #f4a261;
      --text:    #e8e8f0;
      --muted:   #7a7a9a;
      --radius:  10px;
      --font:    'Georgia', serif;
      --mono:    'Courier New', monospace;
    }
    body {
      background: var(--bg);
      color: var(--text);
      font-family: var(--font);
      min-height: 100vh;
    }

    header {
      background: var(--surface);
      border-bottom: 2px solid var(--accent);
      padding: 1.2rem 2rem;
      display: flex;
      align-items: center;
      gap: .7rem;
    }
    .logo { display: flex; align-items: center; gap: .7rem; text-decoration: none; }
    .logo-icon {
      width: 36px; height: 36px;
      background: var(--accent);
      border-radius: 50%;
      display: flex; align-items: center; justify-content: center;
      font-size: 1.1rem;
    }
    .logo-text { font-size: 1.4rem; font-weight: bold; color: var(--text); letter-spacing: .05em; }
    .logo-text span { color: var(--accent); }

    .container { max-width: 680px; margin: 0 auto; padding: 2rem; }

    .breadcrumb {
      display: flex; align-items: center; gap: .5rem;
      margin-bottom: 1.5rem;
      font-size: .9rem; color: var(--muted);
    }
    .breadcrumb a { color: var(--accent); text-decoration: none; }
    .breadcrumb a:hover { text-decoration: underline; }

    .page-title { font-size: 1.8rem; margin-bottom: 2rem; letter-spacing: .04em; }
    .page-title span { color: var(--accent); }

    /* ── Card ─────────────────────────────────────────────── */
    .card {
      background: var(--surface);
      border: 1px solid var(--border);
      border-top: 3px solid var(--accent);
      border-radius: var(--radius);
      padding: 2rem;
    }

    /* ── Form ─────────────────────────────────────────────── */
    .form-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 1.2rem;
    }
    .form-group { display: flex; flex-direction: column; gap: .4rem; }
    .form-group.full { grid-column: 1 / -1; }

    label {
      font-size: .8rem;
      letter-spacing: .08em;
      text-transform: uppercase;
      color: var(--muted);
      font-family: var(--mono);
    }

    input[type="text"],
    input[type="number"],
    select {
      background: var(--bg);
      border: 1px solid var(--border);
      border-radius: var(--radius);
      color: var(--text);
      font-family: var(--mono);
      font-size: 1rem;
      padding: .65rem .9rem;
      transition: border-color .2s;
      width: 100%;
    }
    input:focus, select:focus {
      outline: none;
      border-color: var(--accent);
    }
    select option { background: var(--surface); }

    /* ── Checkbox ─────────────────────────────────────────── */
    .checkbox-row {
      display: flex;
      align-items: center;
      gap: .75rem;
      padding: .9rem;
      background: var(--bg);
      border: 1px solid var(--border);
      border-radius: var(--radius);
      cursor: pointer;
      transition: border-color .2s;
    }
    .checkbox-row:hover { border-color: var(--accent); }
    .checkbox-row input[type="checkbox"] {
      width: 18px; height: 18px;
      accent-color: var(--accent);
      cursor: pointer;
      flex-shrink: 0;
    }
    .checkbox-label { font-size: .95rem; }

    /* ── Owner field (shown only when sold) ───────────────── */
    #ownerGroup { transition: opacity .3s; }
    #ownerGroup.hidden { opacity: .35; pointer-events: none; }

    /* ── Divider ──────────────────────────────────────────── */
    .divider {
      border: none;
      border-top: 1px solid var(--border);
      margin: 1.5rem 0;
    }

    /* ── Buttons ──────────────────────────────────────────── */
    .form-actions {
      display: flex; gap: .75rem; justify-content: flex-end;
      margin-top: 1.5rem; flex-wrap: wrap;
    }
    .btn {
      display: inline-flex; align-items: center; gap: .4rem;
      padding: .65rem 1.4rem;
      border-radius: var(--radius);
      font-family: var(--font);
      font-size: 1rem;
      font-weight: bold;
      cursor: pointer;
      text-decoration: none;
      border: none;
      transition: opacity .2s, transform .1s;
    }
    .btn:active { transform: scale(.97); }
    .btn-primary { background: var(--accent); color: #fff; }
    .btn-cancel  { background: var(--border); color: var(--text); }
    .btn:hover   { opacity: .85; }

    /* ── Info box (view mode) ─────────────────────────────── */
    .info-box {
      background: var(--bg);
      border: 1px solid var(--border);
      border-radius: var(--radius);
      padding: 1rem 1.2rem;
      margin-bottom: 1.5rem;
      font-size: .9rem;
      color: var(--muted);
    }
    .info-box strong { color: var(--accent2); }

    @media (max-width: 520px) {
      .form-grid { grid-template-columns: 1fr; }
      .form-group.full { grid-column: 1; }
    }
  </style>
</head>
<body>

<header>
  <a href="${pageContext.request.contextPath}/" class="logo">
    <span class="logo-icon">🎬</span>
    <span class="logo-text">Кіно<span>Каса</span></span>
  </a>
</header>

<div class="container">

  <div class="breadcrumb">
    <a href="${pageContext.request.contextPath}/tickets">← Список квитків</a>
    <span>/</span>
    <span>${mode eq 'edit' ? 'Редагування #'.concat(ticket.id) : 'Новий квиток'}</span>
  </div>

  <h1 class="page-title">
    <c:choose>
      <c:when test="${mode eq 'edit'}">Редагування <span>квитка #${ticket.id}</span></c:when>
      <c:otherwise>Новий <span>квиток</span></c:otherwise>
    </c:choose>
  </h1>

  <!-- Info about session (edit mode) -->
  <c:if test="${mode eq 'edit' and not empty ticket}">
    <div class="info-box">
      🎬 <strong>${ticket.movieName}</strong> &nbsp;|&nbsp;
      🏛 ${ticket.cinemaName} &nbsp;|&nbsp;
      📅 ${ticket.sessionDate} о ${ticket.sessionTime}
    </div>
  </c:if>

  <div class="card">
    <form method="post" action="${pageContext.request.contextPath}/tickets/form">

      <!-- hidden id for edit mode -->
      <c:if test="${mode eq 'edit'}">
        <input type="hidden" name="id" value="${ticket.id}"/>
      </c:if>

      <div class="form-grid">

        <!-- Сеанс -->
        <div class="form-group full">
          <label for="sessionId">Сеанс</label>
          <select id="sessionId" name="sessionId" required>
            <option value="">— оберіть сеанс —</option>
            <c:forEach var="s" items="${sessions}">
              <option value="${s.id}"
                <c:if test="${mode eq 'edit' and ticket.sessionId eq s.id}">selected</c:if>>
                #${s.id} | ${s.movieName} | ${s.sessionDate} ${s.sessionTime} | ${s.cinemaName}
              </option>
            </c:forEach>
          </select>
        </div>

        <!-- Ряд -->
        <div class="form-group">
          <label for="rowNumber">Ряд (1–10)</label>
          <input type="number" id="rowNumber" name="rowNumber"
                 min="1" max="10" required
                 value="${mode eq 'edit' ? ticket.rowNumber : ''}"/>
        </div>

        <!-- Місце -->
        <div class="form-group">
          <label for="seatNumber">Місце (1–20)</label>
          <input type="number" id="seatNumber" name="seatNumber"
                 min="1" max="20" required
                 value="${mode eq 'edit' ? ticket.seatNumber : ''}"/>
        </div>

        <!-- Ціна -->
        <div class="form-group full">
          <label for="price">Ціна (₴)</label>
          <input type="number" id="price" name="price"
                 min="0.01" step="0.01" required
                 value="${mode eq 'edit' ? ticket.price : ''}"/>
        </div>

      </div>

      <hr class="divider"/>

      <!-- Продано -->
      <div class="form-group" style="margin-bottom:1rem">
        <label class="checkbox-row" for="isSold">
          <input type="checkbox" id="isSold" name="isSold"
                 onchange="toggleOwner(this)"
                 ${mode eq 'edit' and ticket.sold ? 'checked' : ''}/>
          <span class="checkbox-label">Квиток продано</span>
        </label>
      </div>

      <!-- Власник -->
      <div class="form-group full" id="ownerGroup"
           class="${mode eq 'edit' and ticket.sold ? '' : 'hidden'}">
        <label for="ownerName">Ім'я власника</label>
        <input type="text" id="ownerName" name="ownerName"
               placeholder="Прізвище та ім'я покупця"
               value="${mode eq 'edit' ? ticket.ownerName : ''}"/>
      </div>

      <div class="form-actions">
        <a href="${pageContext.request.contextPath}/tickets" class="btn btn-cancel">
          Скасувати
        </a>
        <button type="submit" class="btn btn-primary">
          ${mode eq 'edit' ? '💾 Зберегти зміни' : '＋ Додати квиток'}
        </button>
      </div>

    </form>
  </div>
</div>

<script>
  // show/hide owner field depending on "sold" checkbox
  function toggleOwner(checkbox) {
    const group = document.getElementById('ownerGroup');
    if (checkbox.checked) {
      group.classList.remove('hidden');
    } else {
      group.classList.add('hidden');
      document.getElementById('ownerName').value = '';
    }
  }

  // init on page load
  (function() {
    const cb = document.getElementById('isSold');
    const group = document.getElementById('ownerGroup');
    if (!cb.checked) group.classList.add('hidden');
  })();
</script>
</body>
</html>
