<%@page import="java.util.List"%>
<%@page import="beans.Area"%>
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
//List<String[]> List = (List<String[]>) obj;
List<Area> List = (List<Area>) obj;
%>
<body>
	<header>Area表の一覧（全件）</header>
	<main>
	<%//=List.getFirst().getAreaCode() %>
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
				//for (String[] ss : List) {
					for (Area ss : List) {
				%>
				<tr>
					<td class="back1"><%=ss.getAreaCode()%></td>
					<td class="back2"><%=ss.getAreaName()%></td>
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