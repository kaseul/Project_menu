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
<link href='fullcalendar/core/main.css' rel='stylesheet' />
<link href='fullcalendar/daygrid/main.css' rel='stylesheet' />

<script src='fullcalendar/core/main.js'></script>
<script src='fullcalendar/daygrid/main.js'></script>
<style>
	html, body {
		width: 100%;
		height: 100%;
		margin: 0 auto;
	}
	#calendar {
		height: 400px;
	}
</style>
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
        alert('Clicked ' + eventObj.title + " " + eventObj.extendedProps.menu);
      }
    },
    defaultDate: '2019-09-15',
    events: [
    	<c:forEach items="${menus}" var="menu">
			{
				title: '${menu.part}',
				menu: '${menu.menu}',
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
</script>
</head>
<body>
	<div id="calendar"></div>
</body>
</html>