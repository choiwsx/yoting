<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!--<%@ include file="../includes/tempnav.jsp" %>-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recipe Register</title>
<style>
.bigPictureWrapper{
   position : absolute;
   display : none;
   justify-content : center;
   align-items : center;
   top : 0%;
   width : 100%;
   height : 100%;
   background-color : gray;
   z-index : 100;
   background : rgba(255,255,255,0.5);
}
.bigPicture{
   position : relative;
   display : flex;
   justify-content : center;
   align-items: center;
}

.bigPicture img{
   width : 600px;
}

</style>

</head>
<body>
 <div class="row">
    
                <div class="col-lg-12">
                    <h1 class="page-header">Board Register</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Board Register
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                           <form role="form" action="/upload/register" method="post">
                              <input type='hidden' name='userNo' value='1'> <!-- value="${user.userNo}" -->

      <div class="form-group">
       
      <!--  <input type=file name='thumbnail'>--><br>   
       
       <!--  <input name='thumbnail'> -->
       <br>
         <select name='categoryNo'>
            <option value='null'>카테고리</option>
            <option value='11'>주식</option>
            <option value='22'>디저트</option>
            <option value='33'>반찬</option>
         </select> <input class="form-control" name='title' placeholder="제목을 입력하세요">
      </div>
      <div class="form-group">
         <textarea rows="4" name='reContent' placeholder="레시피를 소개해보세요!"></textarea>
      </div>
      
      <div class="form-group">
         <input class="form-control" name='cookingTime' placeholder="소요시간?">
      </div>
      
      <div class="form-group">
      <input class="form-control" name='portion' placeholder="몇인분?">
      <input class="form-control" name='difficulty' placeholder="난이도" style="width=40px;">
      </div><br>

                        <button type="submit" class="btn btn-default">Submit Button</button>
                        <button type="reset" class="btn btn-default">Reset Button</button>
                           </form>
                        
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
            </div>
            <!-- /.row -->
   
   <div class="form-group uploadDiv">
      <input type ="file" name='uploadFile'>
   </div>
   <div class='uploadResult'>
   <ul>
   
   </ul>
   </div>
   <input class="uploadContent" name='content'>
   
<script
  src="https://code.jquery.com/jquery-3.5.1.min.js"
  integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
  crossorigin="anonymous"></script>
  
<script>   
   var uploadResult = $(".uploadResult ul");
   
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
      
      function showUploadedFile(uploadResultArr)
      {
         var str = "";
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
         uploadResult.append(str);
      }
      
      $("input[type='file']").change(function(e){
         var formData = new FormData();
         var inputFile = $("input[name='uploadFile']");
         var files = inputFile[0].files;
         console.log(inputFile[0].files);
         for(var i=0; i<files.length; i++)
         {
            if(!checkExtenstion(files[i].name, files[i].size)){
               return false;
            }
            console.log("@@@file=="+files[i]);
            formData.append("uploadFile",files[i]);
	         console.log(formData);
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
               console.log("@@@@result@@@@:"+result);
               showUploadedFile(result);
               //$(".uploadDiv").html(cloneObj.html());
            }
         });
      
      });
      
   

      
   });
   </script>
</body>
</html>