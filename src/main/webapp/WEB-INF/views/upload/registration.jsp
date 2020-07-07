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
   <form:form role="form" modelAttribute="recipe" action="/upload/registrationTest" method="post">
      
   
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
       
          <div class='thumbUpload'>
          <ul>
          </ul>
          </div>
          <!--<form:input path="thumbnail" class="thumbnail" placeholder="섬네일"/>-->
          <input type="file" class="thumbFile" name='thumbFile'/>
      <form:input path="title" placeholder="제목"/>
      <form:input path="cookingTime" placeholder="소요시간"/>
      <form:input path="portion" placeholder="몇인분"/>
      <form:input path="difficulty" placeholder="난이도"/>
      <form:input path="reContent" placeholder="레시피소개"/>

       <div class="content-group">
                  
       <div class='content' id='data-content-1'>
       <ul class='content'>
       <h3>1번</h3>
       
        <div class='uploadResult'>
          <ul>
          </ul>
          </div>
          
           <div class="field">
           <div class="label required">
           <form:label path="contentList[0].photoUrl">사진</form:label></div>
         <input type="file" name='uploadFile0' class="testUpload" id="0">
           <div class="field">
           <div class="label required"><form:label path="contentList[0].content" >내용</form:label></div>
           <div class="input"><form:textarea path="contentList[0].content"/>
           <button type="button" id="add" name='add' onclick='addCon();'/>+
         <button type="button" id="del" name='del' onclick='delCon(0);' style='display:none'/>x
           <form:errors path="contentList[0].content" /></div>
           </div>
           <hr/>
   
           </div>
           <form:hidden path="contentList[0].stepNo" value="1"/>
           </div>
           </ul>
       </div>
   
       <div class="field">
       <div class="input"><input type="submit" value="레시피등록" /></div>
       <div class="input"><button onclick=''>확인</button></div>
       </div>
   
       </fieldset>
   
   </form:form>

<script
  src="https://code.jquery.com/jquery-3.5.1.min.js"
  integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
  crossorigin="anonymous"></script>
  
<script>   
      // 지호 추가 시작
      
      let cnt = 1;
let index = 1;
let conGroup = $(".content-group ul.content");
let stepNo = 0;
let form = document.getElementById('data-content-'+cnt);
var uploadResult = $(".uploadResult");

      let testArr = $(".testUpload");
      console.log(testArr.length);
function addCon() {
         stepNo = ++cnt;
        let addbtns = document.getElementsByName('add');
        let delbtns = document.getElementsByName('del');
        let conChild = "";
        
         if(stepNo>10) {
            alert("더 이상 순서를 추가할 수 없습니다.");
            addbtns[9].style.display = 'none';
            delbtns[9].style.display = '';
            return;
         }
         
        for(i=0; i<addbtns.length; i++){
           addbtns[i].style.display = 'none';
           delbtns[i].style.display = '';
        }
        // cnt : stepNo 쓰는거
        // index : 배열에 값 넣을때 이미 0은 넣으니까 1번부터해야돼서
        
        conChild = `<div class='content' id='data-content-` +cnt+ `'>
        <input type='hidden' id='contentList`+index+`.rno' name='contentList[` +index+ `].rno' value='1' />
        <h3>`+cnt+`번</h3>
           <div class='uploadResult'>
             <ul>
             </ul>
             </div>
         <div class="label required">
         <label for='contentList` +index+ `.photoUrl'>사진</label></div>
        <input type="file" name='uploadFile`+index+`' class="testUpload" id="`+index+`" onChange="upload(this)">
          <div class='field'>
          <div class='label required'><label for='contentList` +index+ `.content' >내용</label></div>
          <div class='input'><textarea id='contentList` +index+ `.content' name='contentList[`+index+`].content'></textarea>
          <button type='button' id='add' name='add' onclick='addCon();'/>+</button>
          <button type='button' id='del' name='del' onclick='delCon(`+index+`);' style='display:none'/>x</button>
          <errors name='contentList,`+index+`.content' /></div>
          </div><type='hidden' id="contentList`+index+`.stepNo" value="`+cnt+`"/>`;
          testArr = $(".testUpload");

          conGroup.append(conChild);
          console.log("????"+testArr.length);
          index++;
          uploadResult = $(".uploadResult");

}
      
      // 지호 추가 마지막
      
      var thumb = $(".thumbFile");
      var event = {};
      var thumbTest = $(".thumbUpload");
      console.log(uploadResult.length);
       $(".uploadResult").on("click", "button", function(e){
            console.log("delete file");
            
            var targetFile = $(this).data("file");
            var type = $(this).data("type");
            
            var targetLi = $(this).closest("li");
            
            $.ajax({
               url : '/deleteFile',
               data : {fileName:targetFile, type:type},
               dataType : 'text',
               type : 'POST',
               success : function(result){
                  alert(result);
                  targetLi.remove();
               }
            });
         });

      
      
      $(document).ready(function(e){
          var formObj = $("form[role='form']");
          console.log("@@formObj"+formObj);
          $("input[type='submit']").on("click", function(e){
             e.preventDefault();
             
             var content = $(".uploadContent")
             
             var str = "";
             $(".thumbUpload ul li").each(function(i, obj){
               var jobj = $(obj);
                var thumbUrl = "..\\..\\..\\resources\\upload\\"+jobj.data("path")+"\\s_"+jobj.data("uuid")+"_"+jobj.data("filename");
                str += "<input type='hidden' name='thumbnail' value='"+thumbUrl+"'>";
                   
             });
             
             
             $(".uploadResult ul li").each(function(i, obj){
                
                var jobj = $(obj);
                
                console.log(jobj);
                var photoUrl = "..\\..\\..\\resources\\upload\\"+jobj.data("path")+"\\"+jobj.data("uuid")+"_"+jobj.data("filename");
                var thumbUrl = "..\\..\\..\\resources\\upload\\"+jobj.data("path")+"\\s_"+jobj.data("uuid")+"_"+jobj.data("filename");
                console.log("PhotoUrl"+photoUrl);   
                //str += "<input type='hidden' name='thumbnail' value='"+thumbUrl+"'>";
                str += "<input type='hidden' name='coWntentList["+i+"].stepNo' value='"+(i+1)+"'>";
                str += "<input type='hidden' name='contentList["+i+"].photoUrl' value='"+photoUrl+"'>";
                //str += "<input type='hidden' name='contentList["+i+"].fileType' value='"+jobj.data("type")+"'>";
               // str += "<input type='hidden' name='contentList["+i+"].content' value='"+content[i].value+"'>";
             });
             console.log(str);
             formObj.append(str).submit();
          });
      });
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
      
      function showUploadThumb(uploadResultArr)
      {
            var str = "";
               $(uploadResultArr).each(function(i,obj){
                  if(obj.image)
                  {
                     var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
                     console.log(fileCallPath);
                     str += "<ul><li data-path='"+obj.uploadPath+"'";
                     str += " data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'";
                     str += "><div>";
                     str += "<span>"+obj.fileName+"</span>";
                     str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button></br>";
                     str += "<img src='/display?fileName="+fileCallPath+"'>";
                     str += "</div>";
                     str += "</li></ul>";
                  }
                  else
                  {
                  }
               });
               //thumbTest.append(str);
               thumbTest[0].innerHTML = str;
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
            uploadResult[idx].innerHTML = str;
         }
      
      thumb.change(function(e){
         var formData = new FormData();
         var inputFile = $("input[name='thumbFile']");
         var files = inputFile[0].files;
         if(!checkExtenstion(files[0].name, files[0].size)){
            return false;
         }
         formData.append("uploadFile", files[0]);
            $.ajax({
                  url : '/upload/uploadAjaxAction',
                  processData : false,
                  contentType : false,
                  data : formData,
                  type : 'POST',
                  dataType : 'json',
                  success : function(result)
                  {
                     showUploadThumb(result);
                     //$(".uploadDiv").html(cloneObj.html());
                  } 
         });
      });
      
      
      
      
      
      function upload(e) {
         event = e;
         var arrNum = e.id;
         var formData = new FormData();
         console.log("input[name='uploadFile"+arrNum+"']");
           var inputFile = $("input[name='uploadFile"+arrNum+"']");
           var files = inputFile[0].files;
           var uploadFileName = "uploadFile";
           for(let i=0; i<e.files.length; i++)
              {
                  if(!checkExtenstion(files[i].name, files[i].size)){
                     return false;
                  }          
               formData.append(uploadFileName,files[i]);
              }
           ttt=formData;
            $.ajax({
               url : '/upload/uploadAjaxAction',
               processData : false,
               contentType : false,
               data : formData,
               type : 'POST',
               dataType : 'json',
               success : function(result)
               {
                  showUploadedFile(result, arrNum);
                  //$(".uploadDiv").html(cloneObj.html());
               } 
                 
      });
     
      };
      
  
   </script>


</body>
</html>