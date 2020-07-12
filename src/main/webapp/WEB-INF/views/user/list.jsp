<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix='fn'%>
<%@ include file="../includes/tempnav.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
<title>주방장들 리스트</title>
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
</head>
<body>
<c:if test="${not empty simpleProfileList }">
	
	<table>
	<div> <h3>먹스타그램에는 현재 총<c:out value="${fn:length(simpleProfileList)} " />명의 주방장이 있습니다.</h3></div>
	<br>
		<c:forEach items="${simpleProfileList}" var="user">
		<div style="height: 150px">
			<a href='/user/profile?userId=<c:out value="${user.userId }" />' class="profileUrl" >
				<img src="<c:out value="${user.profilePhoto}"/>" width="140" height="120" onerror="imgError(this);" style='float: left'/>
				id:<c:out value="${user.userId}" /><br>
				닉넴:<c:out value="${user.nickName}" /><br>
				레시피 개수:<c:out value="${user.recipeCount}" />개<br>
				구독자:<c:out value="${user.followers}" />명<br>
				구독중:<c:out value="${user.followings}" />명 </a>
				<br>
				</div>
		</c:forEach>
	</table>
	</c:if>
	<c:if test="${empty simpleProfileList }"><h3>먹스타그램에 아직 주방장이 없습니다. 주방장으로 가입해서 레시피를 올려주세요! </h3></c:if>
</body>

<script type="text/javascript">
$("#userKeyword").autocomplete({
	source : function(request, response) {
		$.ajax({
			url : "/user/autocomplete",
			type : "post",
			dataType : "json",
			data : request,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",				
			success : function(data) {
				var result = data;
				response(result);
			},
			error : function(data) {
				alert("에러가 발생하였습니다.")
			}
		});
	}
});

</script>
</html>