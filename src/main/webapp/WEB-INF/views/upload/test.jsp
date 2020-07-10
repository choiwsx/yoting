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
	<form:form modelAttribute="recipe" action="/recipe/registrationTest" method="post">
	   
	
	    <fieldset><legend>레시피 내용</legend>
	
	    
		<form:hidden path="userNo" value="1" />
	
        <form:label
            path="categoryNo" >카테고리</form:label>
        
        <form:select
            path="categoryNo" >
            <form:option value="0">카테고리</form:option>
            <form:option value="11">주식</form:option>
            <form:option value="22">디저트</form:option>
            <form:option value="33">반찬</form:option>
        </form:select>
       
        <div class='photo 0'>
          <ul>
          </ul>
        </div>
		<input type="file" class="fileUploader" id="0"/>
		<form:input path="thumbnail" id="thumbnail0" />
		<form:input path="title" placeholder="제목"/>
		<form:input path="cookingTime" placeholder="소요시간"/>
		<form:input path="portion" placeholder="몇인분"/>
		<form:input path="difficulty" placeholder="난이도"/>
		<form:textarea path="reContent" placeholder="내용"/>

	    <div id="dl_list_0">
	    <c:forEach var="content" varStatus="vs" items="${recipe.contentList}">
	    <div>
	    <c:out value="${vs.count}" />번째 컨텐츠
	        <div class="photo <c:out value='${vs.count}' />">
	        </div>
	        <div>
	        <input type="file" class="fileUploader" id="<c:out value='${vs.count}' />" />
	        <form:input
	            path="contentList[${vs.index}].photoUrl" id="thumbnail${vs.count}"  />
	        
	        <form:textarea
	            path="contentList[${vs.index}].content"  />
	            
	        <a href="#" class="remove_item icon minus">remove</a>
	
	        <hr />
	
	        </div>
	        <form:hidden path="contentList[${vs.index}].stepNo" value="${vs.count }"/>
	        </div>
	    </c:forEach>
	
	    
	<a class="add_item icon plus" href="#">add</a></div>
	    <form:button>저장</form:button>
	    
	
	    </fieldset>
	
	</form:form>


<script>

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