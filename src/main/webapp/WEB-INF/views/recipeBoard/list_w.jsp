<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
 
<%@page import="java.util.*"%>
<%
 
    request.setCharacterEncoding("UTF-8");
 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<form id='searchForm' action="/recipeBoard/list_w" method='get'>
	<select name='type'>
		<option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : '' }"/>>--</option>
		<option value="T" <c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : '' }"/>>제목</option>
		<option value="W" <c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : '' }"/>>작성자</option>
		<option value="Tag" <c:out value="${pageMaker.cri.type eq 'Tag' ? 'selected' : '' }"/>>태그</option>
		<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW' ? 'selected' : '' }"/>>제목 or 작성자</option>
	</select>
			
	<input type='text' name='keyword' id="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
	<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
	<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>'/>
	<button class='btn btn-default'>Search</button>
</form>

<table>
	<tr>
		<th>#번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
	</tr>
	<c:forEach items="${list_w}" var="recipe">
	<tr>
		<td><c:out value="${recipe.rno}"/></td>
		<td><c:out value="${recipe.title}"/></td>
		<td><c:out value="${recipe.userNo}"/></td>
		<td><c:out value="${recipe.regdate}"/></td>
	</tr>
	</c:forEach>
</table>
<table>
	<tr>
		<th>#유저번호</th>
		<th>유저이름</th>
		<th>닉네임</th>
	</tr>
	<c:forEach items="${list_user}" var="recipe">
	<tr>
		<td><c:out value="${recipe.userNo}"/></td>
		<td><c:out value="${recipe.userId}"/></td>
		<td><c:out value="${recipe.nickName}"/></td>
	</tr>
	</c:forEach>
</table>
<table>
	<tr>
		<th>게시물번호</th>
	</tr>
	<c:forEach items="${list_tag}" var="recipe">
	<tr>
		<td><c:out value="${recipe.rno}"/></td>
	</tr>
	</c:forEach>
</table>
<form id='actionForm' action="/recipeBoard/list_w" method='get'>
	<input type='hidden' name='pageNum' value = '${pageMaker.cri.pageNum }'>
	<input type='hidden' name='amount' value = '${pageMaker.cri.amount }'>
	<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type}"/>'>
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