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
	<form id="jiho" role="form" action="/recipe/register" method="post" >
		<input type='hidden' name='userNo' value='1'> <!-- value="${user.userNo}" -->

		<div class="form-group">
		 
		<!--  <input type=file name='thumbnail'>--><br>	
		 
		 <input name='thumbnail'>
		 <br>
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
		<input class="form-control" name='portion' placeholder="몇인분?">
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
		<div id="contentGroup">
		<form:form commandName="ContentVO" action="/recipe/register" method="post">
		<input type='hidden' name='userNo' value='1'> <!-- value="${user.userNo}" -->
		<h3 name='stepNo' id='stepNo' value='2'>1.</h3>
		
		<!-- <input type=file name='photoUrl'>-->
		 
		<input name='photoUrl'>
		<br>
		<textarea rows="2" name='content' placeholder="요리 순서를 작성해보세요!"></textarea>
		</form:form>
		<button id="plus" type="button" onclick='addCon();'>+</button>
		<br>
		</div>
		<input type="submit" value="레시피 등록">
	</form>
	
<script type="text/Javascript">   
   var cnt = 1;
   function addCon() {

      var step = document.getElementById('stepNo');
      var stepNo = step.value;
      var itm = document.getElementById('contentGroup');
      var cln = itm.cloneNode(true);
      var form = document.getElementById('jiho');
      
      //step.value=++cnt;
      //console.log(step.value);
      stepNo=++cnt;
      console.log(stepNo);
      
      cln.setAttribute('name', "stepNo");
      cln.setAttribute('value', stepNo);
      console.log(cln);
      
      form.appendChild(cln);
      document.body.appendChild(form);
   }
   </script>
</body>
</html>