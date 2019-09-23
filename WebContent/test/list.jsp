<%@page import="mirim.hs.kr.LogonDBBean"%>
<%@page import="mirim.hs.kr.MenuBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	LogonDBBean db = LogonDBBean.getInstance();
	List<MenuBean> menus = db.selectAllMenu();
	request.setAttribute("menus", menus); //JSP 데이터 전달
	// out.println(menus.size());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="searchProc.jsp" method="post">
		<input type="date" name="days" min="2019-09-01" max="2019-09-30">
		<button>검색</button>
	</form>
	<table>
		<c:forEach items="${menus}" var="menu">
			<tr>
				<td>${menu.no}</td>
				<td><f:formatDate value="${menu.days}" pattern="yyyy-MM-dd"/></td>
				<td>${menu.part}</td>
				<td>
					<c:forTokens items="${menu.menu}" delims="," var="food">
						${food}<br>
					</c:forTokens>
				</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>