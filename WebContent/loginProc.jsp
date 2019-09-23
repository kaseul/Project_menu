<%@page import="mirim.hs.kr.LogonDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	request.setCharacterEncoding("UTF-8");
	LogonDBBean db = LogonDBBean.getInstance();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
<%
String id = request.getParameter("id");
String password = request.getParameter("password");

int check = db.userCheck(id, password);
if(check == 1) { %>
	alert(id + '님 반갑습니다.');
<%
	session.setAttribute("id", id);
	response.sendRedirect("index.jsp");
}
else if(check == 0) {
	%>
		alert("비밀번호가 틀렸습니다.");
		location.href = "loginForm.jsp";
	<%
}
else if(check == -1) { %>
	alert("등록되지 않은 ID입니다.");
	location.href = "joinForm.jsp";	
<%}%>
</script>
</head>
<body>

</body>
</html>