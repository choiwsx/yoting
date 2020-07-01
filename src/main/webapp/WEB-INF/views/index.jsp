<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
 
<%@page import="java.util.*"%>
<%
 
    request.setCharacterEncoding("UTF-8");
 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Recipe Index</title>
</head>
<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<form id='searchForm' action="/recipe/searchresult" method='get'>
   <select name='type'>
      <option value="A" <c:out value="${pageMaker.cri.type eq 'A' ? 'selected' : '' }"/>>통합검색</option>
      <option value="T" <c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : '' }"/>>제목</option>
      <option value="W" <c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : '' }"/>>작성자</option>
      <option value="Tag" <c:out value="${pageMaker.cri.type eq 'Tag' ? 'selected' : '' }"/>>태그</option>
   </select>
         
   <input type='text' name='keyword' id="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
   <input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
   <input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>'/>
   <button class='btn btn-default'>Search</button>
</form>




</body>

<script type="text/javascript">
$(document).ready(function(){
   
   var result = '<c:out value="${result}"/>';
   
   history.replaceState({},null,null);
   
   
   

   
   
   var searchForm = $("#searchForm");
   $("#searchForm button").on("click", function(e){
      if(!searchForm.find("option:selected").val()){
         alert("검색종류를 선택하세요.");
         return false;
      }
      
      if(!searchForm.find("input[name='keyword']").val())
      {
         alert("키워드를 입력하세요.");
         return false;
      }
      
      searchForm.find("input[name='pageNum']").val("1");
      e.preventDefault();
      searchForm.submit();
   });
});
</script>
</html>