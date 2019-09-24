<%@page import="mirim.hs.kr.LogonDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="mirim.hs.kr.MenuBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("UTF-8");
	String days = request.getParameter("days");
	String part = request.getParameter("part");
	String food = request.getParameter("menu");
	
	MenuBean menu = new MenuBean();
	menu.setDays(new SimpleDateFormat("yyyy-MM-dd").parse(days));
	menu.setPart(part);
	menu.setMenu(food);

	LogonDBBean db = LogonDBBean.getInstance();
	MenuBean isMenu = db.selectMenuWithDaysAndPart(days, part);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
<%
if(isMenu == null) { 
	db.insertMenu(menu);
%>
	alert("급식이 등록되었습니다.");
	location.href="index.jsp";
<%
}
else {
%>
	alert("이미 급식이 존재하는 날짜입니다.");
	location.href="insertMenu.jsp";
<%
}
%>
</script>
</head>
<body>

</body>
</html>