<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
<title>業者新規登録</title>
</head>
<body>

<h2>⑤ 新規業者登録</h2>

<%
String errorMsg = (String)request.getAttribute("errorMsg");
if (errorMsg != null) {
%>
<p style="color:red;"><%= errorMsg %></p>
<%
}
%>

<form action="RegistContra" method="post">

<p>
業者名<br>
<input type="text" name="contraName"
 value="<%= request.getParameter("contraName") != null
 ? request.getParameter("contraName") : "" %>">
</p>

<p>
連絡先<br>
<input type="text" name="tel"
 value="<%= request.getParameter("tel") != null
 ? request.getParameter("tel") : "" %>">
</p>

<p>
担当地域<br>
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
</p>

<p>
登録パスワード<br>
<input type="password" name="password">
</p>

<input type="submit" value="上記の内容で登録">

</form>

</body>
</html>