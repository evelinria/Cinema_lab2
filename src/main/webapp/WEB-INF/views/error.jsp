<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="uk">
<head>
  <meta charset="UTF-8"/>
  <title>Помилка — Кінотеатр</title>
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root {
      --bg: #0d0d14; --surface: #16161f; --border: #2a2a3d;
      --accent: #e63946; --text: #e8e8f0; --muted: #7a7a9a;
      --radius: 10px; --font: 'Georgia', serif; --mono: 'Courier New', monospace;
    }
    body { background: var(--bg); color: var(--text); font-family: var(--font);
           min-height: 100vh; display: flex; flex-direction: column; }
    header {
      background: var(--surface); border-bottom: 2px solid var(--accent);
      padding: 1.2rem 2rem; display: flex; align-items: center; gap: .7rem;
    }
    .logo { display: flex; align-items: center; gap: .7rem; text-decoration: none; }
    .logo-icon { width: 36px; height: 36px; background: var(--accent); border-radius: 50%;
                 display: flex; align-items: center; justify-content: center; font-size: 1.1rem; }
    .logo-text { font-size: 1.4rem; font-weight: bold; color: var(--text); }
    .logo-text span { color: var(--accent); }

    .container {
      flex: 1; display: flex; align-items: center; justify-content: center;
      padding: 2rem;
    }
    .error-card {
      background: var(--surface);
      border: 1px solid var(--border);
      border-top: 4px solid var(--accent);
      border-radius: var(--radius);
      padding: 3rem 2.5rem;
      max-width: 520px; width: 100%;
      text-align: center;
    }
    .error-icon { font-size: 3.5rem; margin-bottom: 1.2rem; }
    .error-title { font-size: 1.6rem; margin-bottom: .75rem; color: var(--accent); }
    .error-message {
      color: var(--muted); font-size: 1rem; line-height: 1.6;
      margin-bottom: 1rem;
    }
    .error-detail {
      background: var(--bg);
      border: 1px solid var(--border);
      border-radius: var(--radius);
      padding: .75rem 1rem;
      font-family: var(--mono);
      font-size: .85rem;
      color: #ff9090;
      text-align: left;
      margin-bottom: 2rem;
      word-break: break-word;
    }
    .btn {
      display: inline-flex; align-items: center; gap: .4rem;
      padding: .65rem 1.5rem; border-radius: var(--radius);
      font-family: var(--font); font-size: 1rem; font-weight: bold;
      cursor: pointer; text-decoration: none; border: none;
      background: var(--accent); color: #fff; transition: opacity .2s;
    }
    .btn:hover { opacity: .85; }
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
  <div class="error-card">
    <div class="error-icon">⚠️</div>
    <h1 class="error-title">
      ${not empty errorMessage ? errorMessage : 'Помилка в опрацюванні запиту'}
    </h1>
    <p class="error-message">Під час виконання операції сталася помилка. Спробуйте ще раз або поверніться до списку.</p>
    <c:if test="${not empty errorDetail}">
      <div class="error-detail">${errorDetail}</div>
    </c:if>
    <a href="${pageContext.request.contextPath}/tickets" class="btn">
      ← Повернутись до списку
    </a>
  </div>
</div>
</body>
</html>
