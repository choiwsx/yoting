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
	<meta charset="utf-8">
<title>Insert title here</title>
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
	<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>'/>
	<input type='hidden' name='where' value='<c:out value="${pageMaker.cri.where}"/>'/>
	<button class='btn btn-default'>Search</button>
</form>

<table>
	<tr>
		<th>#번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
	</tr>
	<tr>
		<td>
			<c:if test="${empty list}">
			 	검색 값이 없습니다.
			</c:if>
		</td>
	</tr>
	<c:forEach items="${list}" var="recipe">
	<tr>
		<td><c:out value="${recipe.rno}"/></td>
		<td><c:out value="${recipe.title}"/></td>
		<td><c:out value="${recipe.userNo}"/></td>
		<td><c:out value="${recipe.regDate}"/></td>
	</tr>
	</c:forEach>
	<tr>
	<td>
		<c:if test="${list.size()>=5 and where==null}">
			<a class="more_button" href="recipe">더보기</a>
		</c:if>
	</td>
	</tr>
</table>




<c:if test="${where == user or where==null}">
<table>
	<tr>
		<th>#유저번호</th>
		<th>유저이름</th>
		<th>닉네임</th>
	</tr>
	<tr>
		<td>
			<c:if test="${empty list_user}">
			 	검색 값이 없습니다.
			</c:if>
		</td>
	</tr>
	<c:forEach items="${list_user}" var="recipe">
	<tr>
		<td><c:out value="${recipe.userNo}"/></td>
		<td><c:out value="${recipe.userId}"/></td>
		<td><c:out value="${recipe.nickName}"/></td>
	</tr>
	</c:forEach>
		<tr>
	<td>
		<c:if test="${list_user.size()>=5}">
			<a class="more_button" href="user">더보기</a>
		</c:if>
	</td>
	</tr>
</table>
</c:if>


<c:if test="${where == tag or where==null}">
<table>
	<tr>
		<th>게시물번호</th>
	</tr>
	<tr>
		<td>
			<c:if test="${empty list_tag}">
			 	검색 값이 없습니다.
			</c:if>
		</td>
	</tr>
		<c:if test="${not empty list_tag}">
			<c:forEach items="${list_tag}" var="recipe">
				<tr>
					<td><c:out value="${recipe.rno}"/></td>
					<td><c:out value="${recipe.title}"/></td>
					<td><c:out value="${recipe.userNo}"/></td>
					<td><c:out value="${recipe.regDate}"/></td>
				</tr>
			</c:forEach>
		<tr>
			<td>
				<c:if test="${list_tag.size()>=5}">
					<a class="more_button" href="tag">더보기</a>
				</c:if>
			</td>
		</tr>
		</c:if>	
</table>
</c:if>

<form id='actionForm' action="/search/result" method='get'>
	<input type='hidden' name='pageNum' value = '${pageMaker.cri.pageNum }'>
	<input type='hidden' name='amount' value = '${pageMaker.cri.amount }'>
	<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type}"/>'>
	<input type='hidden' name='where' value='<c:out value="${pageMaker.cri.where}"/>'>
	 <input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>'>
</form>

<form id="morelistForm" action="/search/detail" method='get'>
	<input type='hidden' name='pageNum' value = '${pageMaker.cri.pageNum }'>
	<input type='hidden' name='amount' value = '${pageMaker.cri.amount }'>
	<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type}"/>'>
	<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>'>
	<input type='hidden' name='where' value=''>
</form>
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
	
	var moreListForm = $("#morelistForm");
	$(".more_button").on("click", function(e){
		e.preventDefault();
		console.log('click-더보기');
		moreListForm.find("input[name='where']").val($(this).attr("href"));
		//actionForm.submit();
		moreListForm.submit();
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