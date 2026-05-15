<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Квитки — Кінотеатр</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 1100px; margin: 40px auto; padding: 0 20px; color: #333; }
        h1 { margin-bottom: 20px; }
        a.btn { background: #2563eb; color: #fff; padding: 8px 16px; border-radius: 6px; text-decoration: none; font-size: .9rem; }
        a.btn:hover { background: #1d4ed8; }
        .success { background: #d1fae5; border: 1px solid #6ee7b7; color: #065f46; padding: 10px 16px; border-radius: 6px; margin: 16px 0; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th { background: #f1f5f9; text-align: left; padding: 10px 12px; border-bottom: 2px solid #e2e8f0; font-size: .85rem; color: #64748b; }
        td { padding: 10px 12px; border-bottom: 1px solid #e2e8f0; font-size: .9rem; }
        tr:hover td { background: #f8fafc; }
        .badge { padding: 3px 10px; border-radius: 999px; font-size: .78rem; font-weight: bold; }
        .badge-sold { background: #fee2e2; color: #b91c1c; }
        .badge-free { background: #dcfce7; color: #15803d; }
        .btn-edit { background: #e0f2fe; color: #0369a1; padding: 5px 12px; border-radius: 6px; text-decoration: none; font-size: .85rem; }
        .btn-edit:hover { background: #bae6fd; }
        .btn-delete { background: #fee2e2; color: #b91c1c; padding: 5px 12px; border-radius: 6px; border: none; cursor: pointer; font-size: .85rem; }
        .btn-delete:hover { background: #fecaca; }
        .empty { text-align: center; padding: 60px; color: #94a3b8; }
    </style>
</head>
<body>

<h1>🎬 Список квитків</h1>
<a href="${pageContext.request.contextPath}/tickets?action=form" class="btn">+ Новий квиток</a>

<c:if test="${not empty param.success}">
    <div class="success">
        <c:choose>
            <c:when test="${param.success eq 'created'}">✓ Квиток успішно додано.</c:when>
            <c:when test="${param.success eq 'updated'}">✓ Квиток успішно оновлено.</c:when>
            <c:when test="${param.success eq 'deleted'}">✓ Квиток успішно видалено.</c:when>
        </c:choose>
    </div>
</c:if>

<c:choose>
    <c:when test="${empty tickets}">
        <div class="empty">Квитків ще немає. Додайте перший!</div>
    </c:when>
    <c:otherwise>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Фільм</th>
                    <th>Кінотеатр</th>
                    <th>Дата</th>
                    <th>Час</th>
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
                        <td>#${t.id}</td>
                        <td>${t.movieName}</td>
                        <td>${t.cinemaName}</td>
                        <td>${t.sessionDate}</td>
                        <td>${t.sessionTime}</td>
                        <td>${t.rowNumber}</td>
                        <td>${t.seatNumber}</td>
                        <td>${t.price} ₴</td>
                        <td>
                            <c:choose>
                                <c:when test="${t.sold}"><span class="badge badge-sold">Продано</span></c:when>
                                <c:otherwise><span class="badge badge-free">Вільно</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>${not empty t.ownerName ? t.ownerName : '—'}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/tickets?action=form&id=${t.id}" class="btn-edit">✎ Редагувати</a>
                            <form method="post" action="${pageContext.request.contextPath}/tickets" style="display:inline">
                                <input type="hidden" name="action" value="delete"/>
                                <input type="hidden" name="id" value="${t.id}"/>
                                <button type="submit" class="btn-delete" onclick="return confirm('Видалити квиток #${t.id}?')">🗑 Видалити</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:otherwise>
</c:choose>

</body>
</html>
