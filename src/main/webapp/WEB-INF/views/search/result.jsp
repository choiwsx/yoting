<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix='fn'%>
<%@page import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ include file="../includes/tempnav.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<style>
a {
	text-decoration: none;
	color: #000000
}
</style>
</head>
<body>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

	<table>
		<tr>
			<td><c:if test="${empty list}">
			 	검색 값이 없습니다.
			</c:if></td>
		</tr>
		<label>
			총
			<c:out value="${fn:length(list)}  " />
			개있습니다.
		</label><br>
		<c:forEach items="${category}" var="category">
			<tr>
				<a class="categoryCheck" id=<c:out value="${category.categoryNo}" />
					href="<c:out value="${category.categoryNo}" />"> #<c:out
						value="${category.categoryName}" /></a>
		</c:forEach>
			</tr>
				<a class="init" href="#"> [초기화]</a>

			<c:forEach items="${list}" var="recipe">
		<div class="code<c:out value="${recipe.categoryNo }" />" style="margin-left: 10%; margin-right: 10%;">
				<a class="content" href="/recipe/detail?rno=${recipe.rno}">
					<span
						style="text-align: center; border: 1px solid; width: 280px; height: 370px; margin: 33px; float: left;">
						<span>
							<img src="<c:out value='${recipe.thumbnail }'/>" width=280px
								height=280px>
						</span>
						<span style="margin-top: 10px;">
							<c:out value="${recipe.title }" />
						</span>
						<span>
							by
							<c:out value="${recipe.userNo }" />
						</span>
						카테고리코드:
						<c:out value="${recipe.categoryNo }" />
						<span>
							<fmt:formatDate pattern="yyyy-MM-dd"
								value="${recipe.updateDate }" />
						</span>
					</span>
				</a>
		</div>
			</c:forEach>
		<tr>
			<td><c:if test="${list.size()>=5 and where==null}">
					<a class="more_button" href="recipe">더보기</a>
				</c:if></td>
		</tr>
	</table>




	<c:if test="${where == user or where==null}">
		<table>
			<tr>
				<th>#유저번호</th>
				<th>유저ID</th>
				<th>닉네임</th>
			</tr>
			<tr>
				<td><c:if test="${empty list_user}">
			 	검색 값이 없습니다.
			</c:if></td>
			</tr>
			<c:forEach items="${list_user}" var="recipe">
				<tr>
					<td><c:out value="${recipe.userNo}" /></td>
					<td><a
						href='/user/profile?userId=<c:out value="${recipe.userId}"/>'><c:out
								value="${recipe.userId}" /></a></td>
					<td><c:out value="${recipe.nickName}" /></td>
				</tr>
			</c:forEach>
			<tr>
				<td><c:if test="${list_user.size()>=5}">
						<a class="more_button" href="user">더보기</a>
					</c:if></td>
			</tr>
		</table>
	</c:if>


	<c:if test="${where == tag or where==null}">
		<table>
			<tr>
				<th>게시물번호</th>
			</tr>
			<tr>
				<td><c:if test="${empty list_tag}">
			 	검색 값이 없습니다.
			</c:if></td>
			</tr>
			<c:if test="${not empty list_tag}">
				<c:forEach items="${list_tag}" var="recipe">
					<tr>
						<td><c:out value="${recipe.rno}" /></td>
						<td><c:out value="${recipe.title}" /></td>
						<td><c:out value="${recipe.userNo}" /></td>
						<td><c:out value="${recipe.regDate}" /></td>
					</tr>
				</c:forEach>
				<tr>
					<td><c:if test="${list_tag.size()>=5}">
							<a class="more_button" href="tag">더보기</a>
						</c:if></td>
				</tr>
			</c:if>
		</table>
	</c:if>

	<form id='actionForm' action="/search/result" method='get'>
		<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
		<input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
		<input type='hidden' name='type'
			value='<c:out value="${pageMaker.cri.type}"/>'> <input
			type='hidden' name='where'
			value='<c:out value="${pageMaker.cri.where}"/>'> <input
			type='hidden' name='keyword'
			value='<c:out value="${pageMaker.cri.keyword}"/>'>
	</form>

	<form id="morelistForm" action="/search/detail" method='get'>
		<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
		<input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
		<input type='hidden' name='type'
			value='<c:out value="${pageMaker.cri.type}"/>'> <input
			type='hidden' name='keyword'
			value='<c:out value="${pageMaker.cri.keyword}"/>'> <input
			type='hidden' name='where' value=''>
	</form>
</body>

<script type="text/javascript">
	$(document).ready(function() {
		$('.init').on("click",function(e){
			e.preventDefault();
			 $("div").css('display','block');
		});
		
		$('.categoryCheck').on("click", function(e) {
			e.preventDefault();
			var categoryNo = $(this).attr("id");
			console.log(categoryNo);
				 $("div").css('display','none');
				var pick = document.getElementsByClassName("code"+categoryNo);
				 jQuery(pick).show();  
		});

		var result = '<c:out value="${result}"/>';

		history.replaceState({}, null, null);

		var actionForm = $("#actionForm");
		$(".paginate_button a").on("click", function(e) {
			e.preventDefault();
			console.log('click');
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});

		var moreListForm = $("#morelistForm");
		$(".more_button").on("click", function(e) {
			e.preventDefault();
			console.log('click-더보기');
			moreListForm.find("input[name='where']").val($(this).attr("href"));
			//actionForm.submit();
			moreListForm.submit();
		});

		var searchForm = $("#searchForm");
		$("#searchForm button").on("click", function(e) {
			if (!searchForm.find("option:selected").val()) {
				alert("검색종류를 선택하세요.");
				return false;
			}

			if (!searchForm.find("input[name='keyword']").val()) {
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