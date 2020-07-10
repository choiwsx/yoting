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
<title>Recipe 수정</title>
</head>
<body>
<h1><c:out value="${recipe.title }" /> 수정 페이지</h1>
	<form:form modelAttribute="recipe" action="/recipe/modiRecipe" method="post" id="form-id">
	    <fieldset><legend>레시피 내용</legend>
		 
	    
		<form:hidden path="userNo" value="${recipe.userNo}" />
		<form:hidden path="rno" value="${recipe.rno}" />
	
        <form:label
            path="categoryNo" >카테고리</form:label>
        
        <form:select
            path="categoryNo" >
            <form:option class="options" value="0">카테고리</form:option>
            <form:option class="options" value="11">주식</form:option>
            <form:option class="options" value="22">디저트</form:option>
            <form:option class="options" value="33">반찬</form:option>
            <form:option class="options" value="44">외국주식</form:option>
            <form:option class="options" value="55">한식주식</form:option>
            <form:option class="options" value="66">한식디젓</form:option>
            <form:option class="options" value="77">외국디젓</form:option>
            <form:option class="options" value="88">야채반찬</form:option>
            <form:option class="options" value="99">고기반찬</form:option>
        </form:select>
       
        <div class='photo 0'>
          <ul style="list-style:none;">
		<li>          
	   <img src='<c:if test="${empty recipe.thumbnail }"><c:out value="/display?filename=default.jpg" /></c:if>
    	<c:if test="${not empty recipe.thumbnail }"><c:out value="${recipe.thumbnail}" /></c:if>' 
    	width="140" height="120" onerror="imgError(this);" />
		</li>
          </ul>
        </div>
		<img class="OpenImgUpload" id="0" src="https://recipe1.ezmember.co.kr/img/pic_none2.gif" width="50" height="50" style="cursor:pointer" onerror="imgError(this);" >
		<input type="file" class="fileUploader" id="0" style="display:none"/>
		<form:input path="thumbnail" id="thumbnail0" value="${recipe.thumbnail }" style="display:none"/>
		<br>
		<form:input path="title" placeholder="제목" value="${recipe.title }" id="mainTitle"/>
		<br>
		<form:input path="cookingTime" placeholder="소요시간" value="${recipe.cookingTime }" />
		<br>
		<form:input path="portion" placeholder="몇인분" value="${recipe.portion }" />
		<br>
		<form:input path="difficulty" placeholder="난이도" value="${recipe.difficulty }" />
		<br>
		<form:textarea path="reContent" placeholder="내용" value="${recipe.reContent }" style="height:160px; width:430px;"/>
		<br>
		<hr/>
	    <div id="dl_list_0">
	    <c:forEach var="content" varStatus="vs" items="${recipe.contentList}">
	    <div>
	    <c:out value="${vs.count}" />번째 컨텐츠
	        <div class="photo <c:out value='${vs.count}' />">
	        <img <c:if test="${empty content.photoUrl}"><c:out value="src='/display?filename=default.jpg'" /></c:if>
    	<c:if test="${not empty content.photoUrl }"><c:out value="src='${content.photoUrl}'" /></c:if>
    	width="140" height="120" onerror="imgError(this);" />
	        </div>
	        <div>
	      	 <img class="OpenImgUpload" id="${vs.count}" src="https://recipe1.ezmember.co.kr/img/pic_none2.gif" width="50" height="50" style="cursor:pointer" onerror="imgError(this);" >
	        <input type="file" class="fileUploader" style="display:none" id="<c:out value='${vs.count}' />" />
	         <form:input
	            path="contentList[${vs.index}].photoUrl" id="thumbnail${vs.count}" value="${content.photoUrl }" class="thumbList" style="display:none;" />
	        
	        <form:textarea
	            path="contentList[${vs.index}].content" value="${content.content }" class="contentList" style="height:160px; width:430px;" />
	            
	
	        <hr />
	
	        </div>
	        <form:hidden path="contentList[${vs.index}].stepNo" value="${vs.count }"/>
	        <form:hidden path="contentList[${vs.index}].rno" value="${recipe.rno }"/>
	        </div>
	
	    </c:forEach>
	</div>
	    
	     <form:button type="button" id="btn-id">저장</form:button>
	
	    </fieldset>
	
	</form:form>
	<script
  src="https://code.jquery.com/jquery-3.5.1.min.js"
  integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
  crossorigin="anonymous"></script>

<script>

$(document).ready(function(){

	  $(".options").each(function(){

	    if($(this).val()=='<c:out value="${recipe.categoryNo }"/>'){

	      $(this).prop("selected","selected"); // attr적용안될경우 prop으로 
	    }
	  });
	});

var regex = new RegExp("(.*?)\.(jpg|png|img)$");
var maxSize = 5242880;

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
  	
  	if(mainTitle[0].value=="")
  	{
  		flag = true;
  		alert("메인 제목을 입력해주세요.");
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
   });
   photoList.get(idx).innerHTML = str;
   $("#thumbnail"+idx).val("/display?fileName="+fileCallPath);
}



</script>
</body>
</html>