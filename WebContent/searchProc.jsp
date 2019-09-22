<%@page import="java.util.Date"%>
<%@page import="mirim.hs.kr.LogonDBBean"%>
<%@page import="mirim.hs.kr.MenuBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("UTF-8");
	List<MenuBean> menus = null;
	LogonDBBean db = LogonDBBean.getInstance();
	String days = request.getParameter("days");
	String part = request.getParameter("part");
	// out.println(days + " " + part);
	menus = db.selectMenuWithDays(days);
	/* if(part.equals("all")) {
		menus = db.selectMenuWithDays(days);
	}
	else {
		menus = db.selectMenuWithDaysAndPart(days, part);
	} */
	request.setAttribute("menus", menus); //JSP 데이터 전달
	request.setAttribute("days", days);
	request.setAttribute("part", part); //JSP 데이터 전달
	// out.println(menus.size());
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
	<div class="jumbotron jumbotron-fluid">
	  <div class="container">
	    <h1>${days}의 <c:if test="${part != 'all'}">${part}</c:if> 급식메뉴</h1>      
	  </div>
	</div>
	<table class="table table-striped">
		<c:choose>
			<c:when test="${empty menus}">
				<tr>
					<td>오늘 급식이 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<tr>
					<th>날짜</th>
					<th>조식/중식/석식</th>
					<th>메뉴</th>
				</tr>
				<c:set var="i" value="0"></c:set>
				<c:forEach items="${menus}" var="menu">
					<c:if test="${part == 'all' || menu.part == part}">
						<c:set var="i" value="1"></c:set>
						<tr>
							<%-- <td>${menu.no}</td> --%>
							<td><f:formatDate value="${menu.days}" pattern="yyyy-MM-dd (E)"/></td>
							<td>${menu.part}</td>
							<td>
								<c:forTokens items="${menu.menu}" delims="," var="food">
									${food}<br>
								</c:forTokens>
							</td>
						</tr>
					</c:if>
				</c:forEach>
				<c:if test="${i == 0}">
					<tr>
						<td>오늘 급식이 없습니다.</td>
					</tr>
				</c:if>
			</c:otherwise>
		</c:choose>
	</table>
	<div style="margin-top: 50px; width: 100%; text-align: center;">
		<button class="btn btn-dark" style="left: 50%; transform: translate(-50%)" onclick="history.go(-1)">뒤로가기</button>
	</div>
</body>
</html>