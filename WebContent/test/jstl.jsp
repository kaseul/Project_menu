<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% //DB 연동 대신 List 데이터
List<Map> allList = new ArrayList<Map>();
allList.clear();
 
HashMap<String, Object> hm = new HashMap<String, Object>();
hm.put("title", "셋");
hm.put("contents", "three");
hm.put("count", "87");
allList.add(hm);

hm = new HashMap<String, Object>();
hm.put("title", "둘");
hm.put("contents", "two");
hm.put("count", "99");
allList.add(hm);

hm = new HashMap<String, Object>();
hm.put("title", "하나");
hm.put("contents", "one");
hm.put("count", "100");
allList.add(hm);

request.setAttribute("allList", allList); //JSP 데이터 전달
out.print("list size:\t" + allList.size()); //List Size 출력
out.print("<br/>list :\t" + allList); //List 내용 출력
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>c:forEach test</title>
</head>
<body>
<table border="1">
<thead>
<tr>
<td>제목</td>
<td>조회수</td>
</tr>
</thead>
<tbody>
<c:forEach items="${allList }" var="item" varStatus="i">
<tr>
<td><c:out value="${item.title}"/></td>
<td><c:out value="${item.count}"/></td>
</tr>
</c:forEach>
</tbody>
</table>
</body>
</html>