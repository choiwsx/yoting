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
	<form id='recipeCon' role='form' action='/recipe/register'
		method='post'>
		<input type='hidden' name='userNo' value='1'>
		<!-- value="${user.userNo}" -->

		<div class='form-group'>
			<input name='thumbnail' placeholder="사진"><br> <select
				name='categoryNo'>
				<option value=''>카테고리</option>
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
			<input class="form-control" name='difficulty' placeholder="난이도"
				style="">
		</div>
		<br>

		<!-- 재료매퍼 어케 할건지
      <div class="form-group">
      <label>재료</label><br>
      <input class="form-control" name='ingredient' placeholder="재료 추가">
      <button onclick="">+</button>
      </div><br>
      -->

		<label>요리과정</label>
		<form:form commandName="ContentVO" action="/recipe/register"
			method="post">
			<input type='hidden' name='userNo' value='1'>
			<div class='content-group' id='data-content-1'>
				<ul>
					<h3 name='stepNo' id='stepNo' value='1'>1</h3>
					<input name='photoUrl' placeholder="사진">
					<br>
					<textarea rows="2" name='content' placeholder="요리 순서를 작성해보세요!"></textarea>
		</form:form>
		<input type="button" id="add" name='add' onclick='addCon();' value="+">
		<input type="button" id="del" name='del' onclick='delCon();' value="x" style='display:none'>
		</ul>
		</div>
	</form>
	<button type="submit">레시피 등록</button>

	<script
  src="https://code.jquery.com/jquery-3.5.1.min.js"
  integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
  crossorigin="anonymous"></script>  
<script type="text/Javascript">
   let cnt = 1;
   let conGroup = $(".content-group ul");
   function addCon() {
	      
	      let form = document.getElementById('data-content-'+cnt);
	      console.log(form);
	      
	      let stepNo = ++cnt;
	      if(stepNo>15) {
	    	  alert("더 이상 순서를 추가할 수 없습니다.");
	    	  return;
	      }
	      
		  let addbtns = document.getElementsByName('add');
		  let delbtns = document.getElementsByName('del');
		  for(i=0; i<addbtns.length; i++){
			  addbtns[i].style.display = 'none';
			  delbtns[i].style.display = '';
		  }
	      console.log(addbtns);

	let conChild = "";
	conChild = `<form:form commandName='ContentVO' action='/recipe/register' method='post'>
			<input type='hidden' name='userNo' value='1'>
			<div class='content-group' id='data-content-`+cnt+`'>
			<h3 name='stepNo' id='stepNo' value='`+cnt+`'>`+cnt+`</h3>
			<input name='photoUrl' placeholder="사진"><br>
			<textarea rows='2' name='content' placeholder='요리 순서를 작성해보세요!'></textarea>
			</form:form>
			<input type='button' id='add' name='add' onclick='addCon();' value="+">
			<input type='button' id='del' name='del' onclick='delCon();' value="x" style='display:none'>
			</div>`;
		
		conGroup.append(conChild);

	}

	function delCon() {
		// form 지우고 cnt 숫자 -1로 바꾸게 하기
	}
</script>
</body>
</html>