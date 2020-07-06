<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="../includes/tempnav.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recipe Register</title>
</head>
<body>
	<form:form modelAttribute="recipe" action="/recipe/registrationTest" method="post">
	   
	    <fieldset><legend>레시피 내용</legend>
	
		<form:hidden path="userNo" value="1" />
	
        <form:label
            path="categoryNo" cssErrorClass="invalid">카테고리</form:label>
        
        <form:select
            path="categoryNo" cssErrorClass="invalid ">
            <form:option value="0">카테고리</form:option>
            <form:option value="11">주식</form:option>
            <form:option value="22">디저트</form:option>
            <form:option value="33">반찬</form:option>
        </form:select>
       
       	<form:input path="thumbnail" placeholder="섬네일"/>
		<form:input path="title" placeholder="제목"/>
		<form:input path="cookingTime" placeholder="소요시간" value=""/>
		<form:input path="portion" placeholder="몇인분"/>
		<form:input path="difficulty" placeholder="난이도"/><br>
		<form:textarea rows="4" path='reContent' placeholder="레시피를 소개해보세요!"></form:textarea>
		

		    <div class="content-group">
	        <ul>
	        <div class='content' id="data-content-1">
	   		<h3>1번</h3>
	        <div class="label required">
	        <form:label path="contentList[0].photoUrl">사진</form:label></div>
	
	        <div class="input">
	        <form:input path="contentList[0].photoUrl"/>
	        <form:errors path="contentList[0].photoUrl" /></div>
	
	        <div class="field">
	        <div class="label required"><form:label path="contentList[0].content" >내용</form:label></div>
	        <div class="input"><form:textarea path="contentList[0].content"  />
	        <button type="button" id="add" name='add' onclick='addCon();'/>+
			<button type="button" id="del" name='del' onclick='delCon(0);' style='display:none'/>x
	        <form:errors path="contentList[0].content" /></div>
	        </div>
	        <form:hidden path="contentList[0].stepNo" value="1"/>
	        </div>
	        </ul>
	    </div>
	
	    <div class="field">
	    <div class="input"><input type="submit" value="레시피등록" /></div>
	    </div>
	
	    </fieldset>
	
	</form:form>
		<script
  src="https://code.jquery.com/jquery-3.5.1.min.js"
  integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
  crossorigin="anonymous"></script>
	<script type="text/Javascript">
let cnt = 1;
let index = 1;
let conGroup = $(".content-group ul");
let stepNo = 0;
let form = document.getElementById('data-content-'+cnt);

function addCon() {
	      stepNo = ++cnt;
		  let addbtns = document.getElementsByName('add');
		  let delbtns = document.getElementsByName('del');
		  let conChild = "";
		  
	      if(stepNo>10) {
	    	  alert("더 이상 순서를 추가할 수 없습니다.");
	    	  addbtns[9].style.display = 'none';
	    	  delbtns[9].style.display = '';
	    	  return;
	      }
	      
		  for(i=0; i<addbtns.length; i++){
			  addbtns[i].style.display = 'none';
			  delbtns[i].style.display = '';
		  }
		  // cnt : stepNo 쓰는거
		  // index : 배열에 값 넣을때 이미 0은 넣으니까 1번부터해야돼서
		  conChild = `<div class='content' id='data-content-` +cnt+ `'>
		  <h3>`+cnt+`번</h3>
          <div class='label required'>
          <label for='contentList`+index+`.photoUrl'>사진</label></div>
          <div class="input">
          <input id='contentList`+index+`.photoUrl' name='contentList[` +index+ `].photoUrl'/>
          <errors name='contentList.` +index+ `.photoUrl'/></div>
          <div class='field'>
          <div class='label required'><label for='contentList` +index+ `.content' >내용</label></div>
          <div class='input'><textarea id='contentList` +index+ `.content' name='contentList[`+index+`].content'></textarea>
          <button type='button' id='add' name='add' onclick='addCon();'/>+</button>
          <button type='button' id='del' name='del' onclick='delCon(`+index+`);' style='display:none'/>x</button>
          <errors name='contentList,`+index+`.content' /></div>
          </div><type='hidden' id="contentList`+index+`.stepNo" value="`+cnt+`"/>`;
          
          conGroup.append(conChild);
          
          index++;

}

let contents = document.getElementsByClassName('content');

function delCon(delNum) {
	console.log(delNum);
	contents[--delNum].children[2].children[0].value = contents[++delNum].children[2].children[0].value;
	contents[--delNum].children[3].children[1].children[0].value = contents[++delNum].children[3].children[1].children[0].value;
	contents[delNum].remove();
	
	cnt = --cnt;
}
</script>
</body>
</html>