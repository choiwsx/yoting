<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ include file="../includes/tempnav.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인증 이메일  다시 보내기</title>
</head>
<body>
<h1>인증 이메일이 안왔나요?</h1>
<div id="message" style="height: 70px; color: red;">
<c:out value="${result }" default="" /> 
</div>


<form id="form" action="/user/resendEmail" method="post">
<input type="text" name="email" placeholder="가입 시 등록한 이메일을 입력해주세요." >
<button type="button" onclick="button();">인증 이메일 다시 보내기</button>
</form>
<br>
<br>
<%@ include file="../includes/footer.jsp"%>
<script>

$('input[type="text"]').keydown(function() {
	  if (event.keyCode === 13) {
	    event.preventDefault();
	    button();
	  };
	});
	
function button() {
    var str = "";
 
    if(!validateEmail()) {
       str += `이메일 형식을 올바르게 입력해주세요.\n`;
    }
    if(str==="") {
       $("#form").submit();
       return;
    }
    $("#message").html(str);      
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
</body>
</html>