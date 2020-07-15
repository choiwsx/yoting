<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix='fn'%>
<style>
#primary_nav_wrap
{
	margin-top:15px;
	margin-left:20%;
}
#primary_nav_wrap ul
{
	list-style:none;
	position:relative;
	float:left;
	margin:0;
	padding:0
}
#primary_nav_wrap ul a
{
	display:block;
	color:#333;
	text-decoration:none;
	font-weight:700;
	font-size:12px;
	line-height:32px;
	padding:0 15px;
	font-family:"HelveticaNeue","Helvetica Neue",Helvetica,Arial,sans-serif
}
#primary_nav_wrap ul li
{
	position:relative;
	float:left;
	margin:0;
	padding:0
}
#primary_nav_wrap ul li.current-menu-item
{
	background:#ddd
}
#primary_nav_wrap ul li:hover
{
	background:#f6f6f6
}
#primary_nav_wrap ul li:hover > ul
{
	display:block
}
</style>
    <!-- 카테고리 목록에서 부모번호를 제외한 카테고리의 번호와 주소를 받아 출력, 번호값을 a 링크에 걸어서 이동 -->
<nav id="primary_nav_wrap">
<ul>
<c:forEach items="${category}" var="category">
<li>
<a href="list?categoryNo=<c:out value="${category.categoryNo}" />" >
<c:out value="${category.categoryName}" /></a>
</li>
</c:forEach>
<li>
      총
      <c:out value="${fn:length(list)}  " />
      개있습니다.
      </li>
</ul>
</nav>

