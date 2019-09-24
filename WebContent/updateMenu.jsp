<%@page import="mirim.hs.kr.MenuBean"%>
<%@page import="mirim.hs.kr.LogonDBBean"%>
<%@page import="mirim.hs.kr.LogonDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	int no = Integer.parseInt(request.getParameter("no"));
	LogonDBBean db = LogonDBBean.getInstance();
	MenuBean menu = db.selectMenu(no);
	
	request.setAttribute("menu", menu);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container" style="margin-top: 10%;">
		<form action="updateMenuProc.jsp" method="post">
		<div class="form-group">
		    <label for="days">날짜:</label>
		    <input type="text" class="form-control" disabled="disabled" value='<f:formatDate value="${menu.days}" pattern="yyyy년 MM월 dd일"/>' required>
		    <input type="hidden" class="form-control" id="no" name="no" disabled="disabled" value="${menu.no}" required>
	    </div>
	    <div class="form-inline">
		    <label for="part">파트:</label>
		    <input type="text" class="form-control" id="part" name="part" disabled="disabled" value="${menu.part}" required disabled="disabled">
	    </div>
		  <div class="form-group">
		    <label for="menu">메뉴:</label>
		    <textarea name="menu" style="resize: none; width: 100%;" placeholder=",로 메뉴를 구분해주세요" required>${menu.menu}</textarea>
		  </div>
		  <button type="submit" class="btn btn-dark">급식 수정</button>
		</form>
	</div>
</body>
</html>