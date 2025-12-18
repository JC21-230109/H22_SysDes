<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>業者新規登録</title>

<style>
body {
    background-color: #f7efe3;
    font-family: "Meiryo", sans-serif;
}

h2 {
    text-align: center;
    margin-top: 20px;
}

.box {
    width: 520px;
    margin: 20px auto;
    padding: 25px;
    background-color: #eef6f3;
    border-radius: 15px;
}

.item {
    margin-bottom: 18px;
}

.label {
    font-weight: bold;
    margin-bottom: 5px;
}

.example {
    font-size: 13px;
    color: #555;
    margin-bottom: 3px;
}

input[type="text"],
input[type="password"],
select {
    width: 100%;
    padding: 6px;
    font-size: 14px;
}

.error {
    color: red;
    text-align: center;
    font-weight: bold;
}

.btn-area {
    text-align: center;
    margin-top: 20px;
}

button {
    width: 160px;
    padding: 8px;
    font-size: 14px;
    border-radius: 8px;
}
</style>
</head>

<body>

<h2>⑤ 新規業者登録</h2>

<%
String errorMsg = (String)request.getAttribute("errorMsg");
if (errorMsg != null) {
%>
<p class="error"><%= errorMsg %></p>
<%
}
%>

<div class="box">

<form action="RegistContra" method="post">

<div class="item">
    <div class="label">業者名</div>
    <div class="example">例：〇〇運輸（全角）</div>
    <input type="text" name="contraName"
        value="<%= request.getParameter("contraName") != null
        ? request.getParameter("contraName") : "" %>">
</div>

<div class="item">
    <div class="label">連絡先</div>
    <div class="example">例：09012345678（ハイフンなし半角数字）</div>
    <input type="text" name="tel"
        value="<%= request.getParameter("tel") != null
        ? request.getParameter("tel") : "" %>">
</div>

<div class="item">
    <div class="label">担当地域</div>
    <select name="DELAREA_CODE">
        <option value="">-- 選択してください --</option>
<%
java.util.List<java.util.Map<String, String>> delareaList =
    (java.util.List<java.util.Map<String, String>>)request.getAttribute("delareaList");
String selected = request.getParameter("DELAREA_CODE");

if (delareaList != null) {
    for (java.util.Map<String, String> area : delareaList) {
%>
        <option value="<%= area.get("code") %>"
            <%= area.get("code").equals(selected) ? "selected" : "" %>>
            <%= area.get("name") %>
        </option>
<%
    }
}
%>
    </select>
</div>

<div class="item">
    <div class="label">登録パスワード</div>
    <div class="example">例：abc123（半角英数字6桁）</div>
    <input type="password" name="password">
</div>

<div class="btn-area">
    <button type="button" onclick="history.back()">戻る</button>
    <button type="submit">上記の内容で登録</button>
</div>

</form>
</div>

</body>
</html>