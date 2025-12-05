<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Area表の一覧（全件）</title>
</head>
<%
Object obj = request.getAttribute("AREA");
List<String[]> List = (List<String[]>) obj;
%>
<body>
	<header>Area表の一覧（全件）</header>
	<main>
		<%
		if (List != null && !List.isEmpty()) {
		%>
		<div class="centerBlock">
			<table border=1>
				<tr>
					<td class="back1">エリアコード</td>
					<td class="back2">エリアネーム</td>
				</tr>
				<%
				for (String[] ss : List) {
				%>
				<tr>
					<td class="back1"><%=ss[0]%></td>
					<td class="back2"><%=ss[1]%></td>
				</tr>
				<%
				}
				%>
			</table>
		</div>
		<%
		} else {
		%>
		<p>表示するエリアデータはありません。</p>
		<%
		}
		%>
	</main>
</body>
</html>