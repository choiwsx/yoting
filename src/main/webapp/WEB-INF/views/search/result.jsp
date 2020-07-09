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
<title>검색결과</title>
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
	<c:if test="${where == user or where==null}">
	<div class="userlist">
	<hr>
	<h3>유저 리스트</h3>
	<div style="text-align: center; width: auto;  max-width: 700px; height: 150px; border: 1px solid gray; margin-left: 13%; margin-right: 13%;">
	<c:if test="${empty list_user}">
				<label>
			 	검색 값이 없습니다.
				</label>
			 	</c:if>
			<c:forEach items="${list_user}" var="recipe">
				<div style="border: 1px solid; margin: 10px; float: left;">
					 <div>
					 <a href='/user/profile?userId=<c:out value="${recipe.userId}"/>'><img src="<c:out value='${recipe.profilePhoto}'/>" width=85px
					height=85px>
					<br><c:out value="${recipe.userId}"/>
					<br><c:out value="${recipe.nickName}"/>
					</a></div>
					</div>
			</c:forEach>


			<br><c:if test="${list_user.size()>=6}">
						<a class="more_button" href="user">더보기</a>
					</c:if>
	</div>
	</c:if>
	</div>
	<div class="recipelist">
	<hr>
	<h3>레시피 리스트</h3>
		<label>
			총
			<c:out value="${fn:length(list)}  " />
			개있습니다.
		</label>
		<c:if test="${list.size()>=5 and where==null}">
					<a class="more_button" href="recipe">더보기</a>
				</c:if>
		<br>
		
		<c:forEach items="${category}" var="category">
				<h5 style="float:left"><a class="categorySelect" id=<c:out value="${category.categoryNo}" />
					href="<c:out value="${category.categoryNo}" />"> #<c:out
						value="${category.categoryName}" /></a></h5>
		</c:forEach>
				<h5 style="float:left"><a class="init" href="#"> [초기화]</a></h5> <br><br><br>
				
<div style="width: 1420px; height: 880px; border: 1px solid gray; margin-left: 4.5%; margin-right: 4.5%;">
		<tr>
			<td><c:if test="${empty list}">
			 	검색 값이 없습니다.
			</c:if></td>
				
			<c:forEach items="${list}" var="recipe">
		<div data-category="<c:out value="${recipe.categoryNo }" />" style="display: inline-block;">
				<a class="content" href="/recipe/detail?rno=${recipe.rno}">
					<div
						style="text-align: center; border: 1px solid; width: 280px; height: 370px; margin: 33px; float: left;">
						<div>
							<img src="<c:out value='${recipe.thumbnail }'/>" width=280px
								height=280px>
						</div>
						<div style="margin-top: 10px;">
							<c:out value="${recipe.title }" />
						</div>
						<div>
							by
							<c:out value="${recipe.userNo }" />
						</div>
						카테고리코드:
						<c:out value="${recipe.categoryNo }" />
						<div>
							<fmt:formatDate pattern="yyyy-MM-dd"
								value="${recipe.updateDate }" />
						</div>
					</div>
				</a>
		</div>
			</c:forEach>
		</div>
</div>

<div class="taglist">
	<c:if test="${where == tag or where==null}">
	<hr>
<h3>태그 포함 리스트</h3>
		<c:if test="${empty list_tag}">
			 	검색 값이 없습니다.
			</c:if>
			<c:if test="${not empty list_tag}">
				<c:forEach items="${list_tag}" var="recipe">
			<div style="border: 1px solid; width: 330px; height: 200px; padding: 15px; margin: 33px; float: left;">
	<div style="float:left;"><a href="/recipe/detail?rno=${recipe.rno}"><img src="<c:out value="${recipe.thumbnail }"/>"
					width="200" height="200" /></a></div>
						<div style="padding: 15px;"><c:out value="${recipe.title}" /></div>
						<div><c:out value="${recipe.userNo}" /></div>
						</div>
				</c:forEach>
					<c:if test="${list_tag.size()>=3}">
							<a class="more_button" href="tag">더보기</a>
						</c:if>
			</c:if>
			
	</c:if>
</div>
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
		var typeV = $('input[name=type]').val();
		console.log(typeV);
		if(typeV=='W'){
			$(".recipelist").hide();	
			$(".taglist").hide();	
		}else if(typeV=='T'){
			$(".userlist").hide();
			$(".taglist").hide();	
		}else if(typeV=='Tag'){
			$(".userlist").hide();
			$(".recipelist").hide();	
		}
		let category = document.querySelectorAll("[data-category]");
		
		$('.init').on("click",function(e){
			e.preventDefault();
			 for(i=0;i<category.length;i++){
				 category[i].style.display='block';
			 }
		});
		
		$('.categorySelect').on("click", function(e) {
			e.preventDefault();
			var categoryNo = $(this).attr("id");
			
			for(i=0;i<category.length;i++){
				category[i].style.display='none';
			var a = category[i].getAttribute("data-category");
			if(a==categoryNo){
				category[i].style.display='block';
			}
		}
				
			
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