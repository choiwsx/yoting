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
<h1>관리자 모드:<c:out value="${recipe.rno }" />번 레시피 수정</h1>

<form action="/admin/modiRecipe" method="post">

<div>
	<label>게시글 넘버(수정 불가)</label>
	<input type="text" name="rno" value="<c:out value="${recipe.rno }"/>" readonly="true" />
	</div>
 <div>
    <label>제목</label>
    <input type="text" name="title" value="<c:out value="${recipe.title }"/>" />
 </div>
 <div>
        <label>유저 넘버</label>
        <input type="text" name="userNo" value="<c:out value="${recipe.userNo }"/>" />
    </div>
        
    <div>
    	<label>썸네일</label>
    	<img src="<c:if test="${recipe.thumbnail eq null }">/img/default.jpg</c:if>
    	<c:if test="${recipe.thumbnail ne null }"><c:out value="${recipe.thumbnail}" /></c:if>
    	" width="140" height="120" onerror="imgError(this);"/>
    	<input type="text" name="profilePhoto" value="<c:out value="${recipe.thumbnail }"/>" />
    	
    </div>
    
    
    <div>
    
        <label>카테고리 </label>
    </div>
    <div>
    	<select name="categoryNo">
            <option class="options" value="0">카테고리</option>
            <option class="options" value="11">주식</option>
            <option class="options" value="22">디저트</option>
            <option class="options" value="33">반찬</option>
            <option class="options" value="44">외국주식</option>
            <option class="options" value="55">한식주식</option>
            <option class="options" value="66">한식디젓</option>
            <option class="options" value="77">외국디젓</option>
            <option class="options" value="88">야채반찬</option>
            <option class="options" value="99">고기반찬</option>
        </select>
    </div>
    <div>
    	<label>난이도</label>
        <input type="text" name="difficulty" value="<c:out value="${recipe.difficulty }"/>" />
    </div>
    <div>
    	<label>몇인분</label>
        <input type="text" name="portion" value="<c:out value="${recipe.portion }"/>" />
    </div>
    <div>
    	<label>조리시간</label>
        <input type="text" name="cookingTime" value="<c:out value="${recipe.cookingTime }"/>" />
    </div>
    <div>
    <label>내용</label>
        <input type="text" name="reContent" value="<c:out value="${recipe.reContent }"/>" />
    </div>

    	
    <button type="submit">submit</button>

</form>

</div>
	
	
	<script
  src="https://code.jquery.com/jquery-3.5.1.min.js"
  integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
  crossorigin="anonymous"></script>
	<script>


	$(document).ready(function(){

	  $(".options").each(function(){

	    if($(this).val()=="<c:out value="${recipe.categoryNo }"/>"){

	      $(this).prop("selected","selected"); // attr적용안될경우 prop으로 

	    }

	  });

	});

	</script>
	
</body>
</html>