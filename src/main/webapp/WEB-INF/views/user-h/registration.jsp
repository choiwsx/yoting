<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저 등록</title>
</head>
<body>

<h1>form</h1>
<form action="/user-h/registration" method="POST" enctype="utf8">
    <div>
        <label>아이디</label>
        <input type="text" name="userId" />

    </div>
    <div>
        <label>비번1</label>
        <input type="password" name="userPwd" />
    </div>
    <div>
        <label>비번2</label>
        <input type="password" name="pwd2" />
    </div>
    <div>
        <label>이메일</label>
        <input type="text" name="email" />
    </div>
    <div>
        <label>이멜소식</label>
        <input type="checkbox" name="emailSub" value="1" />
    </div>
    <div>
        <label>약관동의</label>
        <input type="checkbox" name="tmp" value="yyy" />
    </div>
    <button type="submit">submit</button>
</form>
 

</body>
</html>