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
	<form:form modelAttribute="recipe" action="registration" method="post" id="form-id">
	   
	        <h3>레시피 작성하기</h3>
	
	    <fieldset><legend>레시피 소개</legend>
	
	    
		<form:hidden path="userNo" value="<%=userNo%>" />
        <form:label
            path="categoryNo" >카테고리(필수)</form:label>
        
 <form:select
            path="categoryNo" id="categoryNo">
            <form:option class="options" value="0">카테고리</form:option>
            <!--<form:option class="options" value="11">주식</form:option>
            <form:option class="options" value="22">디저트</form:option>
            <form:option class="options" value="33">반찬</form:option>-->
            <form:option class="options" value="101">한식 주식</form:option>
            <form:option class="options" value="102">외국 주식</form:option>
            <form:option class="options" value="201">고기 반찬</form:option>
            <form:option class="options" value="202">야채 반찬</form:option>
            <form:option class="options" value="301">한식 디저트</form:option>
            <form:option class="options" value="302">외국 디저트</form:option>
        </form:select>
       
        <div class='photo 0'>
          <ul>
          </ul>
        </div>
        <img class="OpenImgUpload" id="0" src="https://i.ibb.co/w7Yv1X6/pic.png" width="50" height="50" style="cursor:pointer" onerror="imgError(this);" >
		<input type="file" class="fileUploader" id="0" style="display:none"/>
		<form:input path="thumbnail" id="thumbnail0" style="display:none" />
		<br>
		제목(필수)<form:input path="title" placeholder="제목" id="mainTitle"/>
		<br>
		소요 시간<form:input path="cookingTime" placeholder="소요 시간"/>
		<br>
		몇 인분<form:input path="portion" placeholder="몇 인분" maxlength="10"/>
		<br>
		난이도<form:input path="difficulty" placeholder="난이도"/>
		<br>
		소개<form:textarea path="reContent" placeholder="소개 내용" style="height:160px; width:430px;"/>
		<hr/>
	    <div id="dl_list_0">
	    	    <h3>레시피 세부 순서 작성하기</h3>
	    <pre><h4>
	            레시피의 세부 내용을 조리 순서 대로 작성해 주세요.  
	    <br>
	       10번 째 순서까지 작성할 수 있습니다.<br>
	       10번 째 순서까지 모두 작성할 필요는 없지만, 중간에 빈 순서가 있을 수는 없습니다. </h4></pre>
	    <c:forEach var="content" varStatus="vs" items="${recipe.contentList}">
	    <div>
	    <h4><c:out value="${vs.count}" />번 째 </h4>
	        <div class="photo <c:out value='${vs.count}' />">
	        <ul>
	        </ul>
	        </div>
	        <div>
	        <img class="OpenImgUpload" id="${vs.count}" src="https://i.ibb.co/w7Yv1X6/pic.png" width="50" height="50" style="cursor:pointer" onerror="imgError(this);" >
	        <input type="file" class="fileUploader" style="display:none" id="<c:out value='${vs.count}' />" />
	        <form:input
	            path="contentList[${vs.index}].photoUrl" id="thumbnail${vs.count}" class="thumbList" style="display:none"/>
	        
	       내용 <form:textarea
	            path="contentList[${vs.index}].content"  class="contentList" style="height:160px; width:430px;" maxlength="300"/>
	            
	        <!--  <a href="#" class="remove_item icon minus">remove</a>-->
	
	        <hr/>
	
	        </div>
	        <form:hidden path="contentList[${vs.index}].stepNo" value="${vs.count }"/>
	        </div>
	    </c:forEach>
	
	    
	<!--  <a class="add_item icon plus" href="#">add</a>--></div>
	    <form:button type="button" id="btn-id">저장</form:button>
	    <!--  <input type="submit" name="submit" value="save"/>-->
	    
	
	    </fieldset>
	
	</form:form>


<script>

var regex = new RegExp("(.*?)\.(jpg|png|img)$");
var maxSize = 5242880;

 
function submitCheck(){
	console.log("onclick");
}

$(".fileUploader").change(function(){
	upload(this);
 });


var uploaderList = $(".fileUploader");

$(".OpenImgUpload").click(function(){
	uploaderList[this.id].click();
});

var form = document.getElementById("form-id");
var thumbList = $(".thumbList");
var contentList  = $(".contentList");
var mainTitle = $("#mainTitle");
document.getElementById("btn-id").addEventListener("click", function (e) {
	e.preventDefault();
  	let flag = false; // 빈칸 체크를 위한 flag
  	let blankIdx = 0; // 빈칸이 시작되는 인덱스
  	

  	if($("#categoryNo option:selected").val() == 0)
  	{
  		alert("카테고리를 선택해주세요!");
  		return;
  	}
  	
  	if(mainTitle[0].value=="")
  	{
  		flag = true;
  		alert("레시피의 제목을 입력해주세요.");
  		return;
  	}	
  	if(uniLen(mainTitle[0].value)>302) {
  		alert("레시피의 제목이 너무 깁니다.(한글 최대 약 100자)");
  		return;
  	}
  	if(uniLen($('input[name ="cookingTime"]').val())>32) {
  		alert("레시피의 '소요 시간'에 작성된 내용이 너무 깁니다.(한글 최대 약 10자)");
  		return;
  	}
  	if(uniLen($('input[name ="portion"]').val())>32)  {
  		alert("레시피의 '몇 인분'에 작성된 내용이 너무 깁니다.(한글 최대 약 10자)");
  		return;
  	}
  	if(uniLen($('input[name ="difficulty"]').val())>32) {
  		alert("레시피의 '난이도'에 작성된 내용이 너무 깁니다.(한글 최대 약 10자)");
  		return;
  	}
  	if(uniLen($('textarea[name ="reContent"]').val())>902) {
  		alert("레시피의 '소개'에 작성된 내용이  너무 깁니다.(한글 최대 약 300자)");
  		return;
  	}

  	for(let i=0; i<10; i++)
  	{
  		if((thumbList[i].value==""||thumbList[i].value==null)
  				&&(contentList[i].value==""||contentList[i].value==null)) // 사진과 내용이 빈칸이면 flag변수를 true로 변경
			{
  					blankIdx = i;
  					break;
			}
  		if(uniLen(contentList[i].value)>902) {
  			alert(i+"번 째 세부 순서에 작성된 내용이  너무 깁니다.(한글 최대 약 300자)");
  	  		return;
  		}
 	}
  	for(let i=blankIdx; i<10; i++)
  	{
  		if(thumbList[i].value!=""
  				||contentList[i].value!="") 
			{
  					flag =  true;
			}
  	}	
  	if(flag)
  	{
  		alert("순서에 빈 칸을 채우세요.");
 	}
  	else
  	{
		form.submit();
  	}
});
 
var filePath=$('input[type=file');
var photoList=$(".photo");

$(".photo").on("click", "button", function(e){
	var str="";
	var targetFile = $(this).data("file");
	var type = $(this).data("type");
	var targetLi = $(this).closest("li");
	var idx = targetLi.data("id");	
	$.ajax({
		url: '/deleteFile',
		data: {fileName: targetFile, type:type},
		dataType : 'text',
		type: 'Post',
		success:function(result){
			targetLi.remove();
			uploaderList[idx].value=str;
		   	$("#thumbnail"+idx).val(str);
		}
	
	});
});
function upload(e) {
    var arrNum = e.id;
    var formData = new FormData();
      var files = filePath.get(arrNum).files;
      var uploadFileName = "uploadFile";
      for(let i=0; i<e.files.length; i++)
         {
             if(!checkExtenstion(files[i].name, files[i].size)){
                return false;
             }          
          formData.append(uploadFileName,files[i]);
         }
       $.ajax({
          url : '/upload/uploadAjaxAction',
          processData : false,
          contentType : false,
          data : formData,
          type : 'POST',
          dataType : 'json',
          success : function(result)
          {
             setUploadedFile(result, arrNum);
          } 
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
 
function setUploadedFile(uploadResultArr, idx)
{
   var str = "";
   var fileCallPath = "";
   console.log(uploadResultArr);
   $(uploadResultArr).each(function(i,obj){
      if(obj.image)
      {
         //fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
         fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.fileName);
         console.log(fileCallPath);
         str += "<li data-path='"+obj.uploadPath+"'";
         str += " data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'" + "data-id='"+idx+"'";
         str += "><div>";
         str += "<span>"+obj.showFileName+"</span>";
         str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' id='"+idx+"' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button></br>";
         str += "<img src='/display?fileName="+fileCallPath+"' onerror='imgError(this);' >";
         str += "</div>";
         str += "</li>";
      }
      else
      {
      }
   });
   photoList.get(idx).innerHTML = str;
   $("#thumbnail"+idx).val("/display?fileName="+fileCallPath);
   
}


function uniLen(s) {
    return [...s].length
}

</script>
</body>
</html>