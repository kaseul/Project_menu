<%@page import="mirim.hs.kr.MenuBean"%>
<%@page import="java.util.List"%>
<%@page import="mirim.hs.kr.LogonDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	LogonDBBean db = LogonDBBean.getInstance();
	List<MenuBean> menus = db.selectAllMenu();
	
	request.setAttribute("menus", menus); //JSP 데이터 전달
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

        // alert('Clicked ' + eventObj.title + " " + eventObj.extendedProps.menu);
        var days = eventObj.start;
        var menu = eventObj.extendedProps.menu;
        days = days.getFullYear() + "년 " + (days.getMonth() + 1) + "월 " + days.getDate() + "일";
        menu = menu.replace(/,/g, '<br>');
        
        document.getElementById("modal_heading").innerHTML = days + " " + eventObj.title;
        document.getElementById("modal_content").innerHTML = menu + '<p> <center><button id="likes" type="button" style="margin: 0 auto;" class="btn btn-dark" onclick="go(' + eventObj.extendedProps.no + ')">수정</button></center>';
        	
        
        // document.getElementById("likes").innerHTML = "★" + eventObj.extendedProps.likes;
        document.getElementById("btn_modal").click();
    },
    locale: 'ko',
    defaultDate: '2019-09-15',
    events: [
    	<c:forEach items="${menus}" var="menu">
			{
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
		</c:forEach>
    ]
  });

  calendar.render();
});

function go(no) {
	
		var check = confirm("급식 메뉴를 수정하시겠습니까?");
		if(check) {
			location.href = "updateMenu.jsp?no=" + no;	
		}
		
	
}
</script>
</head>
<body>
	<div class="container" style="margin-top: 10%;">
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