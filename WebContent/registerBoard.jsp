<%@page import="java.util.List"%>
<%@page import="mirim.hs.kr.LogonDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="board" class="mirim.hs.kr.BoardBean"/>
<jsp:setProperty property="*" name="board"/>
<%
	LogonDBBean db = LogonDBBean.getInstance();
	db.insertBoard(board);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	window.onload = function() {
		alert('급식에 대한 의견을 등록하였습니다!');
		location.href="index.jsp";
	}
</script>
</head>
<body>

</body>
</html>