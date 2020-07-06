<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Upload with Ajax</h1>

<div class='uploadDiv'>
	<input type='file' name='uploadFile' multiple>
</div>

<div class ='bigPictureWrapper'>
	<div class='bigPicture'>
	</div>
</div>


<div class='uploadResult'>
	<ul>
	</ul>
</div>


<button id='uploadBtn'>Upload</button>

<script
  src="https://code.jquery.com/jquery-3.5.1.min.js"
  integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
  crossorigin="anonymous"></script>
  
<script>

function showImage(fileCallPath)
{
	//alert(fileCallPath);
	$(".bigPictureWrapper").css("display", "flex").show();
	$(".bigPicture")
	.html("<img src='/display?fileName="+encodeURI(fileCallPath)+"'>")
	.animate({width:'100%', height:'100%'}, 500);
}


$(document).ready(function(){
	var regex = new RegExp("(.*?)\.(jpg|png|img)$");
	var maxSize = 5242880;
	
	var cloneObj = $(".uploadDiv").clone();
	var uploadResult = $(".uploadResult ul");
	
	$(".uploadResult").on("click", "span", function(e){
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		console.log(targetFile);
		
		$.ajax({
			url: '/deleteFile',
			data: {fileName: targetFile, type:type},
			dataType : 'text',
			type: 'Post',
			success:function(result){
				alert(result);
			}
		
		});
		
	});
	
	function showUploadedFile(uploadResultArr)
	{
		var str = "";
		$(uploadResultArr).each(function(i,obj){
			
			if(!obj.image)
			{
			}else
			{
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				
				var originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
				
				originPath = originPath.replace(new RegExp(/\\/g),"/");
				
				//str += "<li><img src='/display?fileName="+fileCallPath+"'><li>";
				str += "<li><a href=\"javascript:showImage(\'"+originPath+"\')\"><img src='/display?fileName="+fileCallPath+"'></a>"+
						"<span data-file=\'"+fileCallPath+"\' data-type='image'>x</span>"+"</li>";
			}
		});
		uploadResult.append(str);
	}
	
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
	
	$(".bigPictureWrapper").on("click",function(e){
		$(".bigPicture").animate({width:'0%', height:'0%'},500);
		setTimeout(()=>{
			$(this).hide();
		},500);
	});
	
	$("#uploadBtn").on("click", function(e){
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']"); 
		var files = inputFile[0].files;
		console.log(files);
		
		for(var i=0; i<files.length; i++)
		{
			if(!checkExtenstion(files[i].name, files[i].size)){
				return false;
			}
			formData.append("uploadFile", files[i]);		
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
				console.log(result);
				showUploadedFile(result);
				$(".uploadDiv").html(cloneObj.html());
			}
		});
		
	});
});
</script> 
</body>
</html>