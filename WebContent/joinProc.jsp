<%@page import="mirim.hs.kr.LogonDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	request.setCharacterEncoding("UTF-8");
	LogonDBBean db = LogonDBBean.getInstance();
%>
<jsp:useBean id="member" class="mirim.hs.kr.MemberBean" />
<jsp:setProperty property="*" name="member"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
<%
int check = db.idCheck(member.getId());
if(check == 0) {
	db.insertMember(member);
	%>
	alert("회원 가입이 되었습니다.");
	location.href="loginForm.jsp";
	<%
}
else { %>
alert("중복된 아이디는 사용할 수 없습니다.");
location.href="joinForm.jsp";
<%}%>
</script>
</head>
<body>

</body>
</html>