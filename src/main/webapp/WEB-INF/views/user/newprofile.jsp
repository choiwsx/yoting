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
        <label>필수. 최대 80바이트.</label>
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
    </div>
    <div>
        <label>소개글</label>
        <input type="text" name="bio" />
    </div>
    <div>
        <label>프로필공개여부</label>
        <input type="checkbox" name="privacy" />
        <input type="hidden" value="off" name="privacy"/>
    </div>

<button type="button" onclick="button();">프로필 생성하고 가입 완료</button>
</form>
 

 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 
 <script>
 
	function button() {
		var str = "";
		var nickName = $("input[name='nickName']").val();
		if(nickName==="") {
			str += `닉네임은 필수입니다.\n`;	
		} else if(getTextLength(nickName)>80) {
			str += `닉네임이 80바이트를 초과했습니다.\n`;			
		}
		if(str==="") {
			$("#form").submit();
			return;
		}
		$("#message").html(str).wrap('<pre />');		
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
	           str += "<img src='/display?fileName="+fileCallPath+"'>";
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
	
	function getTextLength(str) {
        var len = 0;
        for (var i = 0; i < str.length; i++) {
            if (escape(str.charAt(i)).length == 6) {
                len++;
            }
            len++;
        }
        return len;
    }

	
 </script>

</body>
</html>