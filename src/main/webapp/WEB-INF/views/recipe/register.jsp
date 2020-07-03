<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/tempnav.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recipe Register</title>
</head>
<body>
   <form id="recipeCon" role="form" action="/recipe/register" method="post" >
      <input type='hidden' name='userNo' value='1'> <!-- value="${user.userNo}" -->

      <div class="form-group">
      <!-- 
      <input type=file name='thumbnail'><br> 
       -->
      <input name='thumbnail' placeholder="사진"><br>
         <select name='categoryNo'>
            <option value='null'>카테고리</option>
            <option value='11'>주식</option>
            <option value='22'>디저트</option>
            <option value='33'>반찬</option>
         </select> <input class="form-control" name='title' placeholder="제목을 입력하세요">
      </div>
      <div class="form-group">
         <textarea rows="4" name='content' placeholder="레시피를 소개해보세요!"></textarea>
      </div>
      
      <div class="form-group">
         <input class="form-control" name='cookingTime' placeholder="소요시간?">
      </div>
      
      <div class="form-group">
      <input class="form-control" name='portion' placeholder="몇인분?"><br>
      <input class="form-control" name='difficulty' placeholder="난이도" style="width=40px;">
      </div><br>
      
      <!-- 재료매퍼 어케 할건지
      <div class="form-group">
      <label>재료</label><br>
      <input class="form-control" name='ingredient' placeholder="재료 추가">
      <button onclick="">+</button>
      </div><br>
      -->
      
      <label>요리과정</label>
      <form:form commandName="ContentVO" action="/recipe/register" method="post">
      <div id='ContentGroup'>
      <input type='hidden' name='userNo' value='1'> <!-- value="${user.userNo}" -->
      <h3 name='stepNo' id='stepNo' value='1'>1</h3>
      <!--
      <input type=file name='photoUrl'>
       -->
      <input name='photoUrl' placeholder="사진">
      <br>
      <textarea rows="2" name='content' placeholder="요리 순서를 작성해보세요!"></textarea>
      </form:form>
      <button id="plus" type="button" onclick='addCon();'>+</button>
      <br>
      </div>
   </form>
      <input type="submit" value="레시피 등록">
   
<script type="text/Javascript">
   let cnt = 1;
   function addCon() {
	      let stepNo = ++cnt;
	      if(stepNo>20) {
	    	  alert("더 이상 순서를 추가할 수 없습니다.");
	    	  return;
	      }
	      
	      let form = document.getElementById('ContentGroup');
	      
	      console.log(stepNo);
	      let addForm =`<div id='ContentGroup'>
	          <form:form commandName="ContentVO" action="/recipe/register" method="post">
	          <input type='hidden' name='userNo' value='1'> <!-- value="${user.userNo}" -->
	          <h3 name='stepNo' id='stepNo' value=${stepNo}>${stepNo}</h3>
	          <!--
	          <input type=file name='photoUrl'>
	           -->
	          <input name='photoUrl' placeholder="사진">
	          <br>
	          <textarea rows="2" name='content' placeholder="요리 순서를 작성해보세요!"></textarea>
	          </form:form>
	          <button id="plus" type="button" onclick='addCon();'>+</button>
	          <br>
	          </div> 
	       </form>`;
	    	  
	      console.log(addForm);
	      
	      form.innerHTML += addForm;
   }
   </script>
</body>
</html>