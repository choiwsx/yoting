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



<h1>내 주방에서 공개될 정보를 입력해 주세요.</h1>
<div id="message" style="height: 70px;"></div>

<form id="form" action="/user/newprofile" method="POST" enctype="utf8">
    <div>
        <label>닉네임</label>
        <input type="text" name="nickName" maxlength="20"/>
        <label>최대 10자.</label>
    </div>
    <div>
        <label>프로필 사진</label>
        <div class='photo'>
        <ul>
        </ul>
        </div>
        <img class="OpenImgUpload" src="https://i.ibb.co/w7Yv1X6/pic.png" width="50" height="50" style="cursor:pointer" onerror="imgError(this);" >
	        <input type="file" class="fileUploader" style="display:none" id="file" />
	        <input type="text" id="profilePhoto" name="profilePhoto" style="display:none"/>
    </div>
    <div>
        <label>개인 홈페이지 주소</label>
        <input type="text" name="webUrl" maxlength="150"/>
        <label>최대 100자.</label>
    </div>
    <div>
        <label>소개글</label>
        <textarea name="bio" maxlength="300" ></textarea>
        <label>최대 300자.</label>
    </div>
    <!-- <div>
        <label>프로필공개여부</label>
        <input type="checkbox" name="privacy" />
        <input type="hidden" value="off" name="privacy"/>
    </div> -->

<button type="button" onclick="button();">주방장 프로필을 생성하고 가입 완료</button>
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
		var bio = $("textarea[name='bio']").val();
		if(uniLen(nickName)>10) {
			str += "닉네임이 10글자를 초과했습니다.";			
		}
		if(uniLen(webUrl)>100) {
			str += "홈페이지 주소가 100글자를 초과했습니다.";			
		}
		if(uniLen(bio)>300) {
			str += "소개 내용이 300글자를 초과했습니다.";			
		}
		if(!validateURL()) {
			str += "url 형식에 맞지않습니다.";
		}
		
		if(str==="") {
			$("#form").submit();
			return;
    }
    $("#message").html(str);      
 }

var regex = new RegExp("(.*?)\.(jpg|png|img)$");
var maxSize = 5242880;

var uploaderList = $(".fileUploader");

$(".OpenImgUpload").click(function(){
    $("#file").click();
 });

$(".photo").on("click", "button", function(e){
	var str="";
	var targetFile = $(this).data("file");
	var type = $(this).data("type");
	var targetLi = $(this).closest("li");
	$.ajax({
		url: '/deleteFile',
		data: {fileName: targetFile, type:type},
		dataType : 'text',
		type: 'Post',
		success:function(result){
			targetLi.remove();
			uploaderList[0].value=str;
		   	$("#profilePhoto").val(str);
		}
	
	});
});

$('input[type="file"]').change(function(e){
     var formData = new FormData();
       var uploadFileName = "uploadFile";
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
  
  var photoDiv = $(".photo");

  function setUploadedFile(uploadResultArr) {
     var str = "";
     var fileCallPath = "";
     $(uploadResultArr).each(function(i,obj){
         if(obj.image)
         {
            fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.fileName);
            str += "<li data-path='"+obj.uploadPath+"'";
            str += " data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'";
            str += "><div>";
            str += "<span>"+obj.showFileName+"</span>";
            str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button></br>";
            str += "<img src='/display?fileName="+fileCallPath+"' onerror='imgError(this);' >";
            str += "</div>";
            str += "</li>";
         }
         else
         {
         }
     photoDiv.get(0).innerHTML = str;
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