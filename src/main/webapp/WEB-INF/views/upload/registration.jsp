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
	<form:form modelAttribute="recipe" action="/upload/registration" method="post">
	   
	
	    <fieldset><legend>레시피 내용</legend>
	
	    
		<form:hidden path="userNo" value="1" />
	
        <form:label
            path="categoryNo" cssErrorClass="invalid">카테고리</form:label>
        
        <form:select
            path="categoryNo" cssErrorClass="invalid ">
            <form:option value="0">카테고리</form:option>
            <form:option value="11">주식</form:option>
            <form:option value="22">디저트</form:option>
            <form:option value="33">반찬</form:option>
        </form:select>
       
       	<form:input path="thumbnail" placeholder="섬네일"/>
       	
       	<input type="file" name='uploadFile'>
		<form:input path="title" placeholder="제목"/>
		<form:input path="cookingTime" placeholder="소요시간"/>
		<form:input path="portion" placeholder="몇인분"/>
		<form:input path="difficulty" placeholder="난이도"/>
		

	    <div id="dl_list_0">
	    <c:forEach var="content" varStatus="vs" items="${recipe.contentList}">
	    <c:out value="${vs.count}" />번째 컨텐츠
	        <div class="content_<c:out value='${vs.index}' />">
	        
        <div class='uploadResult'>
       	<ul>
       	</ul>
       	</div>
       	
	        <div class="field">
	        <div class="label required"><form:label
	            path="contentList[${vs.index}].photoUrl" cssErrorClass="invalid">사진</form:label></div>
			<input type="file" name='uploadFile${vs.index}' class="testUpload" id="${vs.index}">
				
	        <div class="input"><form:input
	            path="contentList[${vs.index}].photoUrl" cssErrorClass="invalid " /><form:label
	            path="contentList[${vs.index}].photoUrl" cssErrorClass="icon invalid" /><form:errors
	            path="contentList[${vs.index}].photoUrl" cssClass="inline_invalid" /></div>
	        </div>
	
	        <div class="field">
	        <div class="label required"><form:label
	            path="contentList[${vs.index}].content" cssErrorClass="invalid">내용</form:label></div>
	        <div class="input"><form:textarea
	            path="contentList[${vs.index}].content" cssErrorClass="invalid " /><form:label
	            path="contentList[${vs.index}].content" cssErrorClass="icon invalid" />
	        <a href="#" class="remove_item icon minus">remove</a> <form:errors
	            path="contentList[${vs.index}].content" cssClass="invalid" /></div>
	        </div>
	
	        <hr />
	
	        </div>
	        <form:hidden path="contentList[${vs.index}].stepNo" cssErrorClass="invalid " value="${vs.index + 1 }"/>
	    </c:forEach>
	
	    <div class="field">
	    <div class="label"><a class="add_item icon plus" href="#">add</a></div>
	    </div>
	    </div>
	
	    <div class="field">
	    <div class="input"><input type="submit" class="button primary"
	        value="Save" /></div>
	    </div>
	
	    </fieldset>
	
	</form:form>

<script
  src="https://code.jquery.com/jquery-3.5.1.min.js"
  integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
  crossorigin="anonymous"></script>
  
<script>   
		
		
		var testArr = $(".testUpload");
		var event = {};
		console.log("@@@"+testArr.length);
	
		var uploadResult = $(".uploadResult ul");
		console.log(uploadResult.length);
	/*	$(document).ready(function(e){
		    var formObj = $("form[role='form']");
		    $("button[type='submit']").on("click", function(e){
		       e.preventDefault();
		       
		       var content = $(".uploadContent")
		       
		       var str = "";
		       
		       $(".uploadResult ul li").each(function(i, obj){
		          
		          var jobj = $(obj);
		          
		          console.log(jobj);
		          var photoUrl = "..\\..\\..\\resources\\upload\\"+jobj.data("path")+"\\"+jobj.data("uuid")+"_"+jobj.data("filename");
		          var thumbUrl = "..\\..\\..\\resources\\upload\\"+jobj.data("path")+"\\s_"+jobj.data("uuid")+"_"+jobj.data("filename");
		          console.log("PhotoUrl"+photoUrl);   
		          str += "<input type='hidden' name='thumbnail' value='"+thumbUrl+"'>";
		          str += "<input type='hidden' name='contentList["+i+"].stepNo' value='"+(i+1)+"'>";
		          str += "<input type='hidden' name='contentList["+i+"].photoUrl' value='"+photoUrl+"'>";
		          str += "<input type='hidden' name='contentList["+i+"].fileType' value='"+jobj.data("type")+"'>";
		          str += "<input type='hidden' name='contentList["+i+"].content' value='"+content[i].value+"'>";
		       });
		       
		       formObj.append(str).submit();
		    });
		*/
		var regex = new RegExp("(.*?)\.(jpg|png|img)$");
		var maxSize = 5242880;
		
		
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
		
		function showUploadedFile(uploadResultArr, idx)
	      {
	         var str = "";
	         console.log(uploadResultArr);
	         $(uploadResultArr).each(function(i,obj){
	            if(obj.image)
	            {
	               var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
	               console.log(fileCallPath);
	               str += "<li data-path='"+obj.uploadPath+"'";
	               str += " data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'";
	               str += "><div>";
	               str += "<span>"+obj.fileName+"</span>";
	               str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button></br>";
	               str += "<img src='/display?fileName="+fileCallPath+"'>";
	               str += "</div>";
	               str += "</li>";
	            }
	            else
	            {
	            }
	         });
	         uploadResult[idx].append(str);
	         
	      }
		var ttt;
		testArr.change(function(e){
			console.log(e);
			event = e;
			console.log("id==="+e.currentTarget.id);
			var arrNum = e.currentTarget.id;
			var formData = new FormData();
	        var inputFile = $("input[name='uploadFile"+arrNum+"']");
	        var files = event.target.files;
	        console.log("@@@@@"+files);
	        var uploadFileName = "uploadFile";
	        console.log("@@file=="+files[0]);
	        formData.append(uploadFileName, files[0]);
	        /*
	        for(let i=0; i<e.target.files.length; i++)
	        	{
	        	 	if(!checkExtenstion(files[i].name, files[i].size)){
	 	        		return false;
	         		}	 		
					formData.append(uploadFileName,files[i]);
	        		console.log("appendFile : " + files[i].name);
	        	}*/
	        console.log(formData);
	         $.ajax({
	            url : '/upload/uploadAjaxAction',
	            processData : false,
	            contentType : false,
	            data : formData,
	            type : 'POST',
	            dataType : 'json',
	            success : function(result)
	            {
	               console.log("@@@@result@@@@:"+result);
	               showUploadedFile(result, arrNum);
	               //$(".uploadDiv").html(cloneObj.html());
	            } 
	        		
		});
	  
      });
      
  
   </script>


</body>
</html>