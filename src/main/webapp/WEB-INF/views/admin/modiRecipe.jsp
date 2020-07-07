<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/tempnav.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recipe List</title>
</head>
<body>
<div>
<h1>관리자 모드:<c:out value="${user.userId }" />님의 정보 수정</h1>

<form action="/admin/modiRecipe" method="post">
<div>

<label>게시글 넘버</label>
 <input type="text" name="rno" value="<c:out value="${recipe.rnoo }"/>" readonly="true" />
 </div>
 <div>
        <label>유저 넘버</label>
        <input type="text" name="userNo" value="<c:out value="${recipe.userNo }"/>" />
    </div>
    <div>
        <label>카테고리 넘버</label>
        <input type="text" name="categoryNo" value="<c:out value="${recipe.categoryNo }"/>" />
    </div>
    <div>
    	<select name="categoryNo">
            <option value="0">카테고리</option>
            <option value="11">주식</option>
            <option value="22">디저트</option>
            <option value="33">반찬</option>
            <option value="44">외국주식</option>
            <option value="55">한식주식</option>
            <option value="66">한식디젓</option>
            <option value="77">외국디젓</option>
            <option value="88">야채반찬</option>
            <option value="99">고기반찬</option>
        </select>
    </div>
    <div>
    	<label>이메일</label>
        <input type="text" name="email" value="<c:out value="${recipe.email }"/>" />
    </div>
    <div>
    	<label>이메일 인증여부</label>
        <input type="checkbox" name="emailAuth" <c:if test="${user.emailAuth==true }"> checked </c:if> />
        <input type="hidden" value="off" name="emailAuth"/>
    </div>
    <div>
    	<label>닉네임</label>
        <input type="text" name="nickName" value="<c:out value="${user.nickName }"/>" />
    </div>
        <div>
    	<label>썸네일</label>
    	
    <button type="submit">submit</button>

</form>

</div>
	<table>
		<thead>
			<tr>
				<th>게시물 번호</th>
				<th>제목</th>
				<th>썸네일</th>
				<th>작성자No</th>
				<th>작성일</th>
				<th>수정일</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		</thead>
		<c:forEach items="${list}" var="recipe">
			<tr>
				<td><c:out value="${recipe.rno }" /></td>
				<td><a class='move' href='<c:out value="${recipe.rno }"/>'>
						<c:out value="${recipe.title }" />
				</a></td>
				<td><img src="<c:out value='${recipe.thumbnail }'/>" width=30px height=30px></td>
				<td><c:out value="${recipe.userNo }" /></td>
				<td><fmt:formatDate pattern="yyyy-MM-dd"
						value="${recipe.regDate }" /></td>
				<td><fmt:formatDate pattern="yyyy-MM-dd"
						value="${recipe.updateDate }" /></td>
				<td><a href='/admin/modiRecipe?rno=<c:out value="${recipe.rno }"/>'>수정</a></td>						
				<td><a href='/admin/delRecipe?rno=<c:out value="${recipe.rno }"/>'>삭제</a></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>