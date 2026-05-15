<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="uk">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Квитки — Кінотеатр</title>
  <style>
    /* ── Reset & Base ───────────────────────────────────────── */
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root {
      --bg:        #0d0d14;
      --surface:   #16161f;
      --border:    #2a2a3d;
      --accent:    #e63946;
      --accent2:   #f4a261;
      --text:      #e8e8f0;
      --muted:     #7a7a9a;
      --sold-bg:   #1a0a0a;
      --free-bg:   #0a1a0f;
      --radius:    10px;
      --font:      'Georgia', serif;
      --mono:      'Courier New', monospace;
    }
    body {
      background: var(--bg);
      color: var(--text);
      font-family: var(--font);
      min-height: 100vh;
    }

    /* ── Header ─────────────────────────────────────────────── */
    header {
      background: var(--surface);
      border-bottom: 2px solid var(--accent);
      padding: 1.2rem 2rem;
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 1rem;
    }
    .logo {
      display: flex;
      align-items: center;
      gap: .7rem;
      text-decoration: none;
    }
    .logo-icon {
      width: 36px; height: 36px;
      background: var(--accent);
      border-radius: 50%;
      display: flex; align-items: center; justify-content: center;
      font-size: 1.1rem;
    }
    .logo-text {
      font-size: 1.4rem;
      font-weight: bold;
      color: var(--text);
      letter-spacing: .05em;
    }
    .logo-text span { color: var(--accent); }

    /* ── Main ───────────────────────────────────────────────── */
    .container { max-width: 1200px; margin: 0 auto; padding: 2rem; }

    .page-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 1.5rem;
      flex-wrap: wrap;
      gap: 1rem;
    }
    .page-title {
      font-size: 1.8rem;
      letter-spacing: .04em;
    }
    .page-title span { color: var(--accent); }

    /* ── Alert ──────────────────────────────────────────────── */
    .alert {
      padding: .75rem 1.2rem;
      border-radius: var(--radius);
      margin-bottom: 1.2rem;
      font-size: .95rem;
      border-left: 4px solid;
    }
    .alert-success { background: #0a1f14; border-color: #2ecc71; color: #2ecc71; }

    /* ── Btn ────────────────────────────────────────────────── */
    .btn {
      display: inline-flex;
      align-items: center;
      gap: .4rem;
      padding: .55rem 1.1rem;
      border-radius: var(--radius);
      font-family: var(--font);
      font-size: .9rem;
      font-weight: bold;
      cursor: pointer;
      text-decoration: none;
      border: none;
      transition: opacity .2s, transform .1s;
    }
    .btn:active { transform: scale(.97); }
    .btn-primary { background: var(--accent); color: #fff; }
    .btn-edit    { background: #1a3a5c; color: #7ecfff; }
    .btn-delete  { background: var(--sold-bg); color: var(--accent); border: 1px solid var(--accent); }
    .btn:hover { opacity: .85; }

    /* ── Table ──────────────────────────────────────────────── */
    .table-wrap {
      overflow-x: auto;
      border-radius: var(--radius);
      border: 1px solid var(--border);
    }
    table {
      width: 100%;
      border-collapse: collapse;
      font-size: .93rem;
    }
    thead tr {
      background: var(--surface);
      border-bottom: 2px solid var(--accent);
    }
    th {
      padding: .85rem 1rem;
      text-align: left;
      color: var(--muted);
      font-size: .8rem;
      letter-spacing: .08em;
      text-transform: uppercase;
      font-family: var(--mono);
    }
    tbody tr { border-bottom: 1px solid var(--border); transition: background .15s; }
    tbody tr:hover { background: #1a1a28; }
    tbody tr:last-child { border-bottom: none; }
    td { padding: .75rem 1rem; vertical-align: middle; }

    /* ── Status badges ──────────────────────────────────────── */
    .badge {
      display: inline-block;
      padding: .25rem .7rem;
      border-radius: 999px;
      font-size: .78rem;
      font-weight: bold;
      font-family: var(--mono);
      letter-spacing: .05em;
    }
    .badge-sold { background: #3d0a0a; color: #ff6b6b; border: 1px solid #6b1a1a; }
    .badge-free { background: #0a2a14; color: #4ade80; border: 1px solid #1a5a2a; }

    /* ── Price ──────────────────────────────────────────────── */
    .price { color: var(--accent2); font-family: var(--mono); font-weight: bold; }

    /* ── Movie name ─────────────────────────────────────────── */
    .movie { font-weight: bold; }
    .cinema-sub { font-size: .8rem; color: var(--muted); margin-top: .15rem; }

    /* ── Empty state ────────────────────────────────────────── */
    .empty {
      text-align: center;
      padding: 4rem 2rem;
      color: var(--muted);
    }
    .empty-icon { font-size: 3rem; margin-bottom: 1rem; }
    .empty-text { font-size: 1.1rem; }

    /* ── Actions cell ───────────────────────────────────────── */
    .actions { display: flex; gap: .5rem; }

    /* ── Delete confirm dialog ──────────────────────────────── */
    .modal-overlay {
      display: none;
      position: fixed; inset: 0;
      background: rgba(0,0,0,.75);
      z-index: 1000;
      align-items: center; justify-content: center;
    }
    .modal-overlay.active { display: flex; }
    .modal {
      background: var(--surface);
      border: 1px solid var(--border);
      border-top: 3px solid var(--accent);
      border-radius: var(--radius);
      padding: 2rem;
      max-width: 400px;
      width: 90%;
    }
    .modal h2 { margin-bottom: .75rem; }
    .modal p  { color: var(--muted); margin-bottom: 1.5rem; font-size: .95rem; }
    .modal-actions { display: flex; gap: .75rem; justify-content: flex-end; }
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
  <div class="page-header">
    <h1 class="page-title">Квитки <span>/ список</span></h1>
    <a href="${pageContext.request.contextPath}/tickets/form" class="btn btn-primary">
      ＋ Новий квиток
    </a>
  </div>

  <!-- Success alert -->
  <c:if test="${not empty param.success}">
    <div class="alert alert-success">
      <c:choose>
        <c:when test="${param.success eq 'created'}">✓ Квиток успішно додано.</c:when>
        <c:when test="${param.success eq 'updated'}">✓ Квиток успішно оновлено.</c:when>
        <c:when test="${param.success eq 'deleted'}">✓ Квиток успішно видалено.</c:when>
      </c:choose>
    </div>
  </c:if>

  <div class="table-wrap">
    <c:choose>
      <c:when test="${empty tickets}">
        <div class="empty">
          <div class="empty-icon">🎟</div>
          <div class="empty-text">Квитків ще немає. Додайте перший!</div>
        </div>
      </c:when>
      <c:otherwise>
        <table>
          <thead>
            <tr>
              <th>ID</th>
              <th>Фільм / Кінотеатр</th>
              <th>Сеанс</th>
              <th>Ряд</th>
              <th>Місце</th>
              <th>Ціна</th>
              <th>Статус</th>
              <th>Власник</th>
              <th>Дії</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="t" items="${tickets}">
              <tr>
                <td><span style="color:var(--muted);font-family:var(--mono)">#${t.id}</span></td>
                <td>
                  <div class="movie">${t.movieName}</div>
                  <div class="cinema-sub">${t.cinemaName}</div>
                </td>
                <td style="font-family:var(--mono);font-size:.85rem">
                  ${t.sessionDate}<br/>${t.sessionTime}
                </td>
                <td style="font-family:var(--mono)">${t.rowNumber}</td>
                <td style="font-family:var(--mono)">${t.seatNumber}</td>
                <td><span class="price">${t.price} ₴</span></td>
                <td>
                  <c:choose>
                    <c:when test="${t.sold}">
                      <span class="badge badge-sold">Продано</span>
                    </c:when>
                    <c:otherwise>
                      <span class="badge badge-free">Вільно</span>
                    </c:otherwise>
                  </c:choose>
                </td>
                <td>${not empty t.ownerName ? t.ownerName : '—'}</td>
                <td>
                  <div class="actions">
                    <a href="${pageContext.request.contextPath}/tickets/form?id=${t.id}"
                       class="btn btn-edit">✎ Редагувати</a>
                    <button class="btn btn-delete"
                            onclick="confirmDelete(${t.id})">🗑 Видалити</button>
                  </div>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<!-- Delete modal -->
<div class="modal-overlay" id="deleteModal">
  <div class="modal">
    <h2>Видалити квиток?</h2>
    <p>Цю дію неможливо скасувати.</p>
    <div class="modal-actions">
      <button class="btn" onclick="closeModal()"
              style="background:var(--border);color:var(--text)">Скасувати</button>
      <form id="deleteForm" method="post"
            action="${pageContext.request.contextPath}/tickets" style="display:inline">
        <input type="hidden" name="action" value="delete"/>
        <input type="hidden" name="id" id="deleteId"/>
        <button type="submit" class="btn btn-delete">Видалити</button>
      </form>
    </div>
  </div>
</div>

<script>
  function confirmDelete(id) {
    document.getElementById('deleteId').value = id;
    document.getElementById('deleteModal').classList.add('active');
  }
  function closeModal() {
    document.getElementById('deleteModal').classList.remove('active');
  }
  document.getElementById('deleteModal').addEventListener('click', function(e){
    if (e.target === this) closeModal();
  });
</script>
</body>
</html>
