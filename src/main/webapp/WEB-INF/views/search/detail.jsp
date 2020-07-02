<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
 
<%@page import="java.util.*"%>
<%
 
    request.setCharacterEncoding("UTF-8");
 
%>
<%@ include file="../includes/tempnav.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색:더보기</title>
</head>
<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<form id='searchForm' action="/search/result" method='get'>
	<select name='type'>
		<option value="A" <c:out value="${pageMaker.cri.type eq 'A' ? 'selected' : '' }"/>>통합검색</option>
		<option value="T" <c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : '' }"/>>제목</option>
		<option value="W" <c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : '' }"/>>작성자</option>
		<option value="Tag" <c:out value="${pageMaker.cri.type eq 'Tag' ? 'selected' : '' }"/>>태그</option>
	</select>
			
	<input type='text' name='keyword' id="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
	<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
	<button class='btn btn-default'>Search</button>
</form>
<c:if test="${moreList.size()>0}">
<table>
	<tr>
		<c:if test="${pageMaker.cri.where eq 'recipe'}">
			<th>#번호</th><th>제목</th><th>작성자</th><th>작성일</th>
		</c:if>
		<c:if test="${pageMaker.cri.where eq 'user'}">
			<th>#유저번호</th><th>유저이름</th><th>닉네임</th>
		</c:if>

	</tr>
	<c:forEach items="${moreList}" var="recipe">
	<tr>
		<td><c:out value="${recipe.rno}"/></td>
		<td><c:out value="${recipe.title}"/></td>
		<td><c:out value="${recipe.userNo}"/></td>
		<td><c:out value="${recipe.regDate}"/></td>
	</tr>
	</c:forEach>
	<tr>
	<td>
		<c:if test="${list_w.size()>=5 and where==null}">
			<a class="more_button" href="${where}recipe">더보기</a>
		</c:if>
	</td>
	</tr>
</table>
</c:if>

<c:if test="${moreList_u.size()>0}">
<table>
	<tr>
		<th>#유저번호</th><th>유저이름</th><th>닉네임</th>
	</tr>
	<c:forEach items="${moreList_u}" var="recipe">
	<tr>
		<td><c:out value="${recipe.userNo}"/></td>
		<td><c:out value="${recipe.userId}"/></td>
		<td><c:out value="${recipe.nickName}"/></td>
	</tr>
	</c:forEach>
		<tr>
	<td>
		<c:if test="${list_user.size()>=5}">
			<a class="more_button" href="${where}user">더보기</a>
		</c:if>
	</td>
	</tr>
</table>
</c:if>

<form id='actionForm' action="/search/detail" method='get'>
	<input type='hidden' name='pageNum' value = '${pageMaker.cri.pageNum }'>
	<input type='hidden' name='amount' value = '${pageMaker.cri.amount }'>
	<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type}"/>'>
	<input type='hidden' name='where' value='<c:out value="${pageMaker.cri.where}"/>'>
	<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>'>
</form>
<div class='pull-right'>
<ul>
	<c:if test="${pageMaker.prev}">
		<li class="paginate_button previous"><a href="${pageMaker.startPage-1}">Previous</a>
		</li>
	</c:if>
	
	<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
	<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active" : ""}"><a href="${num}">${num}</a></li></c:forEach>
	<c:if test="${pageMaker.next}">
		<li class="paginate_button next"><a href="${pageMaker.endPage+1}">Next</a>
		</li>
	</c:if>


</ul>
</div>
</body>

<script type="text/javascript">
$(document).ready(function(){
	
	var result = '<c:out value="${result}"/>';
	
	history.replaceState({},null,null);
	
	var actionForm = $("#actionForm");
	$(".paginate_button a").on("click", function(e){
		e.preventDefault();
		console.log('click');
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	$(".more_button").on("click", function(e){
		e.preventDefault();
		console.log('click-더보기');
		actionForm.find("input[name='where']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	
	var searchForm = $("#searchForm");
	$("#searchForm button").on("click", function(e){
		if(!searchForm.find("option:selected").val()){
			alert("검색종류를 선택하세요.");
			return false;
		}
		
		if(!searchForm.find("input[name='keyword']").val())
		{
			alert("키워드를 입력하세요.");
			return false;
		}
		
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		searchForm.submit();
	});
});
</script>
</html>