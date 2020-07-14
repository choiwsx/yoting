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

<c:if test="${moreList.size()>0}">

	<c:if test="${pageMaker.cri.where eq 'recipe'}">
	<hr>
	<h3>레시피 리스트</h3>
		</c:if>
<c:if test="${pageMaker.cri.where eq 'tag'}">
	<hr>
	<h3>태그 포함 레시피 리스트</h3>
		</c:if>
<div style="width: 1420px; height: 880px; border: 1px solid gray; margin-left: 4.5%; margin-right: 4.5%;">
			
			<c:forEach items="${moreList}" var="recipe">
		<div data-category="<c:out value="${recipe.categoryNo }" />" style="display: inline-block;">
				<a class="content" href="/recipe/detail?rno=${recipe.rno}">
					<div
						style="text-align: center; border: 1px solid; width: 280px; height: 370px; margin: 33px; float: left;">
						<div>
							<img src="<c:out value='${recipe.thumbnail }'/>" width=280px
								height=280px onerror="imgError(this);">
						</div>
						<div style="margin-top: 10px;">
<c:choose>
	<c:when test="${fn:length(recipe.title) > 15}">
      ${fn:substring(recipe.title,0,14)}...
   </c:when>
  <c:otherwise>
     ${recipe.title}
  </c:otherwise>
</c:choose>
						</div>
						<div>
							by
							<c:out value="${recipe.nickName }" />
						</div>
						<!-- 카테고리코드:
						<c:out value="${recipe.categoryNo }" /> -->
						<div>
							<fmt:formatDate pattern="yyyy-MM-dd"
								value="${recipe.regDate }" />
						</div>
					</div>
				</a>
		</div>
			</c:forEach>
		</div>
</c:if>

<c:if test="${pageMaker.cri.where eq 'user'}">
		<hr>
	<h3>유저 리스트</h3>
		
<div style="text-align: center; width: auto;  max-width: 645px; height: 150px; border: 1px solid gray; margin-left: 13%; margin-right: 13%;">
	<c:if test="${empty moreList_u}">
				<label>
			 	검색 값이 없습니다.
				</label>
			 	</c:if>
			 	</c:if>

<c:if test="${moreList_u.size()>0}">
			<c:forEach items="${moreList_u}" var="recipe">
				<div style="border: 1px solid; margin: 10px; float: left;">
					 <div>
					 <a href='/user/profile?userId=<c:out value="${recipe.userId}"/>'><img src="<c:out value='${recipe.profilePhoto}'/>" width=85px
					height=85px onerror="imgError(this);">
					<br><c:out value="${recipe.userId}"/>
					<br><c:out value="${recipe.nickName}"/>
					</a></div>
					</div>
			</c:forEach>
					</div>
</c:if>

<form id='actionForm' action="/search/detail" method='get'>
	<input type='hidden' name='pageNum' value = '${pageMaker.cri.pageNum }'>
	<input type='hidden' name='amount' value = '${pageMaker.cri.amount }'>
	<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type}"/>'>
	<input type='hidden' name='where' value='<c:out value="${pageMaker.cri.where}"/>'>
	<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>'>
</form>
<div class='pull-right' style="float:right; margin-right:100px; font-size:15px">
<div>
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
</div>
<%@ include file="../includes/footer.jsp"%>
</body>

<script type="text/javascript">
function showImage(fileCallPath)
{
	//alert(fileCallPath);
	$(".bigPictureWrapper").css("display", "flex").show();
	$(".bigPicture")
	.html("<img src='/display?fileName="+encodeURI(fileCallPath)+"' onerror='imgError(this);'>")
	.animate({width:'100%', height:'100%'}, 500);
}

$(".bigPictureWrapper").on("click",function(e){
	$(".bigPicture").animate({width:'0%', height:'0%'},500);
	setTimeout(()=>{
		$(this).hide();
	},500);
});


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
	
	
});
</script>
</html>