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
	<form:form modelAttribute="recipe" action="/recipe/result" method="post">
	   <img src='<c:if test="${empty recipe.thumbnail }"><c:out value="/display?filename=default.jpg" /></c:if>
    	<c:if test="${not empty recipe.thumbnail }"><c:out value="${recipe.thumbnail}" /></c:if>' 
    	width="140" height="120" />
	
	    <fieldset><legend>레시피 내용</legend>
	
	    
		<form:hidden path="userNo" value="1" />
	
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
          <ul>
          </ul>
        </div>
		<input type="file" class="fileUploader" id="0"/>
		<form:input path="thumbnail" id="thumbnail0" value="${recipe.thumbnail }" />
		<form:input path="title" placeholder="제목" value="${recipe.title }" />
		<form:input path="cookingTime" placeholder="소요시간" value="${recipe.cookingTime }" />
		<form:input path="portion" placeholder="몇인분" value="${recipe.portion }" />
		<form:input path="difficulty" placeholder="난이도" value="${recipe.difficulty }" />
		<form:textarea path="reContent" placeholder="내용" value="${recipe.reContent }" />

	    <div id="dl_list_0">
	    <c:forEach var="content" varStatus="vs" items="${recipe.contentList}">
	    <div>
	    <c:out value="${vs.count}" />번째 컨텐츠
	        <div class="photo <c:out value='${vs.count}' />">
	        <img <c:if test="${empty content.photoUrl }"><c:out value="src='/display?filename=default.jpg'" /></c:if>
    	<c:if test="${not empty content.photoUrl }"><c:out value="src='${content.photoUrl}'" /></c:if>
    	width="140" height="120" />
	        </div>
	        <div>
	        <input type="file" class="fileUploader" id="<c:out value='${vs.count}' />" />
	        <form:input
	            path="contentList[${vs.index}].photoUrl" id="thumbnail${vs.count}" value="${content.photoUrl }" />
	        
	        <form:textarea
	            path="contentList[${vs.index}].content" value="${content.content }" />
	            
	        <a href="#" class="remove_item icon minus">remove</a>
	
	        <hr />
	
	        </div>
	        <form:hidden path="contentList[${vs.index}].stepNo" value="${vs.count }"/>
	        <form:hidden path="contentList[${vs.index}].rno" value="${recipe.rno }"/>
	        </div>
	    </c:forEach>
	
	    
	<a class="add_item icon plus" href="#">add</a></div>
	    <form:button type="button">저장</form:button>
	    
	
	    </fieldset>
	
	</form:form>
	<script
  src="https://code.jquery.com/jquery-3.5.1.min.js"
  integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
  crossorigin="anonymous"></script>

<script>

$(document).ready(function(){

	  $(.options).each(function(){

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