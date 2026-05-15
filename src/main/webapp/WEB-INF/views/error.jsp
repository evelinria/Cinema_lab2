<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Помилка — Кінотеатр</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 600px;
            margin: 40px auto;
            padding: 0 20px;
            color: #333;
            background: #f8fafc;
        }
        .error-card {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-top: 4px solid #ef4444;
            border-radius: 8px;
            padding: 36px 32px;
            margin-top: 60px;
            text-align: center;
        }
        .error-icon {
            font-size: 3rem;
            margin-bottom: 16px;
        }
        h1 {
            font-size: 1.4rem;
            color: #ef4444;
            margin-bottom: 10px;
        }
        .error-message {
            color: #64748b;
            font-size: .95rem;
            line-height: 1.6;
            margin-bottom: 16px;
        }
        .error-detail {
            background: #fef2f2;
            border: 1px solid #fecaca;
            border-radius: 6px;
            padding: 10px 14px;
            font-family: 'Courier New', monospace;
            font-size: .85rem;
            color: #b91c1c;
            text-align: left;
            margin-bottom: 28px;
            word-break: break-word;
        }
        .btn {
            display: inline-block;
            background: #2563eb;
            color: #fff;
            padding: 9px 22px;
            border-radius: 6px;
            text-decoration: none;
            font-size: .95rem;
        }
        .btn:hover { background: #1d4ed8; }
    </style>
</head>
<body>
<div class="error-card">
    <div class="error-icon">⚠️</div>
    <h1>${not empty errorMessage ? errorMessage : 'Помилка в опрацюванні запиту'}</h1>
    <p class="error-message">
        Під час виконання операції сталася помилка.<br/>
        Спробуйте ще раз або поверніться до списку квитків.
    </p>
    <c:if test="${not empty errorDetail}">
        <div class="error-detail">${errorDetail}</div>
    </c:if>
    <a href="${pageContext.request.contextPath}/tickets" class="btn">← Повернутись до списку</a>
</div>
</body>
</html>
