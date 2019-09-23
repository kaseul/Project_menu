<%@page import="java.util.Date"%>
<%@page import="mirim.hs.kr.LogonDBBean"%>
<%@page import="mirim.hs.kr.MenuBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	LogonDBBean db = LogonDBBean.getInstance();
	int no = Integer.parseInt(request.getParameter("no"));
	int amount = Integer.parseInt(request.getParameter("amount"));
	String url = request.getParameter("url");
	String id = (String)session.getAttribute("id");
	
	System.out.println(id + " " + no + " " + amount);
	if(amount == 1) {
		db.insertLikes(id, no);
	}
	else {
		db.deleteLikes(id, no);
	}
	db.updateLikes(no, amount);
	if(url != null) {
		response.sendRedirect("likes.jsp");
	}
	else {
		response.sendRedirect("index.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>9월 급식</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<body>
	
</body>
</html>