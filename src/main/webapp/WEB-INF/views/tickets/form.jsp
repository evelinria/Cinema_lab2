<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>${mode eq 'edit' ? 'Редагування квитка' : 'Новий квиток'} — Кінотеатр</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 600px; margin: 40px auto; padding: 0 20px; color: #333; }
        h1 { margin-bottom: 8px; }
        a { color: #2563eb; }
        .info { background: #f0f9ff; border: 1px solid #bae6fd; color: #0369a1; padding: 10px 16px; border-radius: 6px; margin: 16px 0; font-size: .9rem; }
        .card { background: #fff; border: 1px solid #e2e8f0; border-radius: 8px; padding: 24px; margin-top: 20px; }
        .form-group { margin-bottom: 16px; }
        label { display: block; font-size: .85rem; color: #64748b; margin-bottom: 4px; font-weight: bold; }
        input[type="text"], input[type="number"], select {
            width: 100%; padding: 8px 12px; border: 1px solid #e2e8f0;
            border-radius: 6px; font-size: .95rem; box-sizing: border-box;
        }
        input:focus, select:focus { outline: none; border-color: #2563eb; }
        .checkbox-row { display: flex; align-items: center; gap: 8px; cursor: pointer; }
        .checkbox-row input { width: auto; }
        .actions { display: flex; gap: 10px; margin-top: 20px; }
        .btn-submit { background: #2563eb; color: #fff; padding: 9px 20px; border: none; border-radius: 6px; font-size: 1rem; cursor: pointer; }
        .btn-submit:hover { background: #1d4ed8; }
        .btn-cancel { background: #f1f5f9; color: #333; padding: 9px 20px; border-radius: 6px; text-decoration: none; font-size: 1rem; }
        .btn-cancel:hover { background: #e2e8f0; }
    </style>
</head>
<body>

<h1>${mode eq 'edit' ? 'Редагування квитка #'.concat(ticket.id) : 'Новий квиток'}</h1>
<a href="${pageContext.request.contextPath}/tickets">← Список квитків</a>

<c:if test="${mode eq 'edit' and not empty ticket}">
    <div class="info">
        🎬 <strong>${ticket.movieName}</strong> |
        🏛 ${ticket.cinemaName} |
        📅 ${ticket.sessionDate} о ${ticket.sessionTime}
    </div>
</c:if>

<div class="card">
    <form method="post" action="${pageContext.request.contextPath}/tickets">

        <c:if test="${mode eq 'edit'}">
            <input type="hidden" name="id" value="${ticket.id}"/>
        </c:if>

        <div class="form-group">
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

        <div class="form-group">
            <label for="rowNumber">Ряд (1–10)</label>
            <input type="number" id="rowNumber" name="rowNumber"
                   min="1" max="10" required
                   value="${mode eq 'edit' ? ticket.rowNumber : ''}"/>
        </div>

        <div class="form-group">
            <label for="seatNumber">Місце (1–20)</label>
            <input type="number" id="seatNumber" name="seatNumber"
                   min="1" max="20" required
                   value="${mode eq 'edit' ? ticket.seatNumber : ''}"/>
        </div>

        <div class="form-group">
            <label for="price">Ціна (₴)</label>
            <input type="number" id="price" name="price"
                   min="0.01" step="0.01" required
                   value="${mode eq 'edit' ? ticket.price : ''}"/>
        </div>

        <div class="form-group">
            <label class="checkbox-row">
                <input type="checkbox" id="isSold" name="isSold"
                       onchange="toggleOwner(this)"
                       ${mode eq 'edit' and ticket.sold ? 'checked' : ''}/>
                Квиток продано
            </label>
        </div>

        <div class="form-group" id="ownerGroup">
            <label for="ownerName">Ім'я власника</label>
            <input type="text" id="ownerName" name="ownerName"
                   placeholder="Прізвище та ім'я покупця"
                   value="${mode eq 'edit' ? ticket.ownerName : ''}"/>
        </div>

        <div class="actions">
            <a href="${pageContext.request.contextPath}/tickets" class="btn-cancel">Скасувати</a>
            <button type="submit" class="btn-submit">
                ${mode eq 'edit' ? 'Зберегти зміни' : 'Додати квиток'}
            </button>
        </div>

    </form>
</div>

<script>
    function toggleOwner(checkbox) {
        document.getElementById('ownerGroup').style.display = checkbox.checked ? '' : 'none';
        if (!checkbox.checked) document.getElementById('ownerName').value = '';
    }
    (function() {
        const cb = document.getElementById('isSold');
        document.getElementById('ownerGroup').style.display = cb.checked ? '' : 'none';
    })();
</script>

</body>
</html>