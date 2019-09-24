<%@page import="java.util.Date"%>
<%@page import="mirim.hs.kr.MenuBean"%>
<%@page import="mirim.hs.kr.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="mirim.hs.kr.LogonDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String days = request.getParameter("days");
	int no = Integer.parseInt(request.getParameter("no"));
	LogonDBBean db = LogonDBBean.getInstance();
	List<BoardBean> boards = db.selectBoards(no);
	MenuBean menu = db.selectMenu(no);
	
	request.setAttribute("days", days);
	request.setAttribute("boards", boards);
	request.setAttribute("menu", menu);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link href='fullcalendar/core/main.css' rel='stylesheet' />
<link href='fullcalendar/daygrid/main.css' rel='stylesheet' />
<script src='fullcalendar/core/main.js'></script>
<script src='fullcalendar/daygrid/main.js'></script>
<script src='fullcalendar/core/locales/ko.js'></script>
<script>
</script>
</head>
<body>
	<div class="jumbotron jumbotron-fluid">
	  <div class="container">
	    <h1>9월 급식 조회</h1>      
	  </div>
	</div>
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark sticky-top" style="margin-bottom: 20px;">
	  <ul class="navbar-nav">
	  	<li class="nav-item">
	      <a class="nav-link" href="index.jsp">Home</a>
	    </li>
	  	<c:choose>
	  		<c:when test="${empty id}">
	  			<li class="nav-item">
			      <a class="nav-link" href="joinForm.jsp">회원가입</a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" href="loginForm.jsp">로그인</a>
			    </li>
	  		</c:when>
	  		<c:when test="${id == 'admin'}">
	  			<li class="nav-item">
			      <a class="nav-link" href="logout.jsp">로그아웃</a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" href="insertMenu.jsp">급식 등록</a>
			    </li>
	  			<li class="nav-item">
			      <a class="nav-link" href="graph.jsp">메뉴 통계</a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" href="board.jsp">급식 의견</a>
			    </li>
	  		</c:when>
	  		<c:otherwise>
	  			<li class="nav-item">
			      <a class="nav-link" href="logout.jsp">로그아웃</a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" href="searchMenuProc.jsp">메뉴검색</a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" href="likes.jsp">즐겨찾기</a>
			    </li>
	  		</c:otherwise>
	  	</c:choose>
	  </ul>
	</nav>
	
	<div class="container">
		<div class="card">
			<div class="card-header">
				${days}의 급식 의견
			</div>
			<div class="card-body">
				<c:forTokens items="${menu.menu}" delims="," var="food">
					${food}<br>
				</c:forTokens>
			</div>
		</div>
		<c:forEach items="${boards}" var="board">
			<hr>
			<span style="font-weight: bold">${board.id}</span><br>
			${board.content}
		</c:forEach>
	</div>
	<center>
		<button class="btn btn-dark" onclick="history.go(-1)">뒤로가기</button>
	</center>
</body>
</html>