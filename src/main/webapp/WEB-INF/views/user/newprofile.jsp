<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../includes/tempnav.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새 프로필</title>
</head>
<body>



<h1>나의 주방에서 공개될 정보를 입력해주세요.</h1>
<div id="message" style="height: 70px;"></div>

<form id="form" action="/user/newprofile" method="POST" enctype="utf8">
    <div>
        <label>닉네임</label>
        <input type="text" name="nickName" />
        <label>최대 20바이트.</label>
    </div>
    <div>
        <label>프사</label>
        <div id='photo'>
        </div>
        <img class="OpenImgUpload" src="https://recipe1.ezmember.co.kr/img/pic_none2.gif" width="50" height="50" style="cursor:pointer" onerror="imgError(this);" >
	        <input type="file" class="fileUploader" style="display:none" id="file" />
	        <input type="text" id="profilePhoto" name="profilePhoto" style="display:none"/>
    </div>
    <div>
        <label>개인홈피주소</label>
        <input type="text" name="webUrl" />
        <label>최대 200바이트.</label>
    </div>
    <div>
        <label>소개글</label>
        <input type="text" name="bio" />
        <label>최대 500바이트.</label>
    </div>
    <!-- <div>
        <label>프로필공개여부</label>
        <input type="checkbox" name="privacy" />
        <input type="hidden" value="off" name="privacy"/>
    </div> -->

<button type="button" onclick="button();">프로필 생성하고 가입 완료</button>
</form>
 
 
 <script>
 
 $('input[type="text"]').keydown(function() {
      if (event.keyCode === 13) {
        event.preventDefault();
        button();
      };
    });
 
 function button() {
    var str = "";
    var nickName = $("input[name='nickName']").val();
    var webUrl = $("input[name='webUrl']").val();
    var bio = $("input[name='bio']").val();
    if(uniLen(nickName)>20) {
       str += `닉네임이 20바이트를 초과했습니다. (`+uniLen(nickName)+`/20 바이트)\n`;         
    }
    if(uniLen(webUrl)>200) {
       str += `닉네임이 200바이트를 초과했습니다. (`+uniLen(webUrl)+`/200 바이트)\n`;         
    }
    if(uniLen(bio)>500) {
       str += `닉네임이 500바이트를 초과했습니다. (`+uniLen(bio)+`/500 바이트)\n`;         
    }
    if(!validateURL()) {
       str += `url 형식에 맞지않습니다.\n`;
    }
    
    if(str==="") {
       $("#form").submit();
       return;
    }
    $("#message").html(str);      
 }

var regex = new RegExp("(.*?)\.(jpg|png|img)$");
var maxSize = 5242880;

$(".OpenImgUpload").click(function(){
    $("#file").click();
 });

$('input[type="file"]').change(function(e){
     var formData = new FormData();
       var uploadFileName = "uploadFile";
       console.log(e.target.files[0].name);
       if(!checkExtenstion(e.target.files[0].name, e.target.files[0].size)){
           return false;
       }          
           formData.append(uploadFileName,e.target.files[0]);
        $.ajax({
           url : '/upload/uploadAjaxAction',
           processData : false,
           contentType : false,
           data : formData,
           type : 'POST',
           dataType : 'json',
           success : function(result)
           {
              setUploadedFile(result);
           } 
  });

  });

  function setUploadedFile(uploadResultArr) {
     var str = "";
     var fileCallPath = "";
     $(uploadResultArr).each(function(i,obj){
         if(obj.image)
         {
            fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
            console.log(fileCallPath);
            str += "<ul><li data-path='"+obj.uploadPath+"'";
            str += " data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'";
            str += "><div>";
            str += "<span>"+obj.fileName+"</span>";
            str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'>x</i></button></br>";
            str += "<img src='/display?fileName="+fileCallPath+" onerror='imgError(this);' >";
            str += "</div>";
            str += "</li></ul>";
         }
         else
         {
         }
     $("#photo").html(str);
     $("#profilePhoto").val("/display?fileName="+fileCallPath);
     
  });
  };
 
 function checkExtenstion(fileName, fileSize){
     if(fileSize >= maxSize){
        alert("파일 사이즈 초과");
        return false;
     }
     if(!regex.test(fileName))
     {
        alert("해당 종류의 파일은 업로드할 수 없습니다.");
        return false;
     }
     return true;
  }
 
 function validateURL() {
    var url = $("input[name='webUrl']").val();
    if(url=="") return true;
    const re = /[a-z0-9-\.]+\.[a-z]{2,4}\/?([^\s<>\#%"\,\{\}\\|\\\^\[\]`]+)?$/;
    return re.test(url);
 }
 

 function uniLen(s) {
     return [...s].length
 }
 
</script>
</body>
</html>