<%@page import="mirim.hs.kr.LogonDBBean"%>
<%@page import="mirim.hs.kr.MenuBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	LogonDBBean db = LogonDBBean.getInstance();
	List<MenuBean> menus = db.selectAllMenu();
	request.setAttribute("menus", menus); //JSP 데이터 전달
	out.println(menus.size());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table>
		<c:forEach items="${menus}" var="menu">
			<tr>
				<td>${menu.no}</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>