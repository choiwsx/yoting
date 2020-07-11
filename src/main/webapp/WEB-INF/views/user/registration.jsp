<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../includes/tempnav.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
</head>
<body>



<h1>회원 가입</h1>

<div id="message" style="height: 70px; color: red;">
<c:out value="${result }" default="" /> 
</div>
<div class="form">
<form name="form" action="/user/registration" method="POST" enctype="utf8">
<div>모두 필수 입력 항목입니다.</div>
    <div>
        <label>아이디</label>
        <input type="text" name="userId" autocomplete="on" value="<c:out value="${user.userId }" default=""  />"  />
        <label>※영문 알파벳과 숫자를 조합해 3~12자로 구성. 대,소문자 구분 없음.</label>
    </div>
    <div>
        <label>비번</label>
        <input type="password" name="userPwd" autocomplete="off"/>
        <label>※영문 대문자, 소문자, 숫자, 특수 문자를 최소한 하나 씩 조합해 8~16자로 구성.</label>
    </div>
    <div>
        <label>비번 확인</label>
        <input type="password" name="pwd2" autocomplete="off"/>
    </div>
    <div>
        <label>이메일</label>
        <input type="text" name="email" autocomplete="on" value="<c:out value="${user.email }" default=""  />" />
        <label>※이메일 인증을 위해 정확한 메일 주소를 입력해 주세요.</label>
    </div>
    <div>
        <label>이메일로 먹스타그램 소식 받기</label>
        <input type="checkbox" name="emailSub" />
    </div>
    <button type="button" onclick="button();">회원 가입</button>
</form>
</div>
<br><br>
<div> 
회원 가입을 했는데 이메일이 안왔나요? 

<a href="/user/resendEmail">인증 이메일 다시 보내기</a>
</div>
<br>
<br>
<script>
	$('input[type="text"]').keydown(function() {
	  if (event.keyCode === 13) {
	    event.preventDefault();
	    button();
	  };
	});
	
   var form = $("form[name='form']");
   
   function button() {
      var str = "";
      if(!validateId()) {
         str += `아이디가 형식에 맞지 않습니다.\n`;         
      }
      if(!validatePassword()) {
         str += `비밀 번호가 형식에 맞지 않습니다.\n`;
      } else if(!validateSecondPassword()) {
         str += `비밀 번호가 서로 일치하지 않습니다.\n`;
      }   
      if(!validateEmail()) {
         str += `이메일 형식을 올바르게 입력해주세요.\n`;
      }
      if(str==="") {
         form.submit();
         return;
      }
      $("#message").html(str).wrap('<pre />');      
   }
   
   function validateId() {
      var id = $("input[name='userId']").val();
      const re = /^[a-zA-Z0-9]{3,12}$/;
      return re.test(id);
   }
   
   function validatePassword() {
      var pwd = $("input[name='userPwd']").val();
      const re = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,16}$/;
      return re.test(pwd);
   }

   function validateSecondPassword() {
      var pwd = $("input[name='userPwd']").val();
      var pwd2 = $("input[name='pwd2']").val();
      return pwd===pwd2;
   }
   
   function validateEmail() {
	    var email = $("input[name='email']").val();
	   const re = /^\w+([-+.'][^\s]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
	   return re.test(email) && uniLen(email)<320;
	 }
	 
	function uniLen(s) {
	    return [...s].length
	}

</script>
<%@ include file="../includes/footer.jsp"%>
</body>
</html>