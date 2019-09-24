<%@page import="mirim.hs.kr.MenuBean"%>
<%@page import="mirim.hs.kr.LikesBean"%>
<%@page import="java.util.List"%>
<%@page import="mirim.hs.kr.LogonDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	LogonDBBean db = LogonDBBean.getInstance();
	List<MenuBean> menus = db.selectAllMenu();
	List<LikesBean> likes = null;
	String id = (String)session.getAttribute("id");
	if(id != null) {
		likes = db.selectLikes(id);
	}
	request.setAttribute("menus", menus); //JSP 데이터 전달
	request.setAttribute("likes", likes);
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
document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');

  var calendar = new FullCalendar.Calendar(calendarEl, {
    plugins: [ 'dayGrid' ],
    eventClick: function(info) {
      var eventObj = info.event;

      if (eventObj.url) {
        alert(
          'Clicked ' + eventObj.title + '.\n' +
          'Will open ' + eventObj.url + ' in a new tab'
        );

        //window.open(eventObj.url);

        // info.jsEvent.preventDefault(); // prevents browser from following link in current tab.
      }
      else {
        // alert('Clicked ' + eventObj.title + " " + eventObj.extendedProps.menu);
        var days = eventObj.start;
        var menu = eventObj.extendedProps.menu;
        days = days.getFullYear() + "년 " + (days.getMonth() + 1) + "월 " + days.getDate() + "일";
        menu = menu.replace(/,/g, '<br>');
        
        document.getElementById("modal_heading").innerHTML = days + " " + eventObj.title;
        <c:choose>
        	<c:when test="${empty id}">
        		document.getElementById("modal_content").innerHTML = menu;
        	</c:when>
        	<c:when test="${id == 'admin'}">
	    		document.getElementById("modal_content").innerHTML = menu;
	    	</c:when>
        	<c:otherwise>
        		if(eventObj.extendedProps.liked) {
        			document.getElementById("modal_content").innerHTML = menu + '<p> <center><button id="likes" type="button" style="margin: 0 auto;" class="btn btn-primary" onclick="likesToggle(' + eventObj.extendedProps.no + ', '+ -1 +')">'+ "★" + eventObj.extendedProps.likes +'</button></center>';
        		}
        		else {
        			document.getElementById("modal_content").innerHTML = menu + '<p> <center><button id="likes" type="button" style="margin: 0 auto;" class="btn btn-light" onclick="likesToggle(' + eventObj.extendedProps.no + ', '+ 1 + ')">'+ "★" + eventObj.extendedProps.likes +'</button></center>';
        		}
        		document.getElementById("modal_content").innerHTML += '<br><form action="registerBoard.jsp" method="post">' + 
																		'<p>급식에 대한 의견을 입력해주세요!</p>' + 
														        		'<textarea name="content" style="resize: none; width: 100%;"></textarea>' +
														        		'<input type="hidden" name="id" value="${id}">' +
														        		'<input type="hidden" name="no" value="' + eventObj.extendedProps.no + '">' +
														        		'<center><button class="btn btn-dark">입력</button></center>' +
														        	'</form>';
        	</c:otherwise>
        </c:choose>
        
        // document.getElementById("likes").innerHTML = "★" + eventObj.extendedProps.likes;
        document.getElementById("btn_modal").click();
      }
    },
    locale: 'ko',
    defaultDate: '2019-09-15',
    events: [
    	<c:forEach items="${menus}" var="menu">
			<c:forEach items="${likes}" var="like">
				<c:if test="${menu.no == like.no}">
				{
					liked: 'true',
					title: '${menu.part}',
					menu: '${menu.menu}',
					no: ${menu.no},
					likes: ${menu.likes},
					start: '${menu.days}' + 
					<c:choose>
						<c:when test="${menu.part == '조식'}">
							'T07:00:00'
						</c:when>
						<c:when test="${menu.part == '중식'}">
							'T12:00:00'
						</c:when>
						<c:when test="${menu.part == '석식'}">
							'T17:00:00'
						</c:when>
					</c:choose>
				},
				</c:if>
			</c:forEach>
		</c:forEach>
    ]
  });

  calendar.render();
});

function likesToggle(no, amount) {
	//alert(no + " " + amount);
	
	location.href="likesProc.jsp?no=" + no + "&amount=" + amount + "&url=likes";
}
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
		<div id="calendar"></div>
	</div>
	<!-- Button to Open the Modal -->
	  <input type="hidden" id="btn_modal" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
	
	  <!-- The Modal -->
	  <div class="modal fade" id="myModal">
	    <div class="modal-dialog">
	      <div class="modal-content">
	      
	        <!-- Modal Header -->
	        <div class="modal-header">
	          <h4 id="modal_heading" class="modal-title">Modal Heading</h4>
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
	        
	        <!-- Modal body -->
	        <div class="modal-body">
	        	<div id="modal_content"></div>
	        </div>
	        
	        <!-- Modal footer -->
	        <!-- <div class="modal-footer">
	          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	        </div> -->
	        
	      </div>
	    </div>
	  </div>
</body>
</html>