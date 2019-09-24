<%@page import="mirim.hs.kr.LogonDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="mirim.hs.kr.MenuBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
	<jsp:useBean id="menu" class="mirim.hs.kr.MenuBean"/>
	<jsp:setProperty property="*" name="menu"/>
<%	
	out.println(menu.getMenu());
	LogonDBBean db = LogonDBBean.getInstance();
	db.updateMenu(menu);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
alert('급식이 수정되었습니다');
location.href="index.jsp";
</script>
</head>
<body>

</body>
</html>