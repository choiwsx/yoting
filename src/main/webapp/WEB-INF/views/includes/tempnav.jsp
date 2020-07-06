<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<ul>
<li>
  <h3><a href="/">인덱스</a></h3>
</li>
<li>
  <h3>유저</h3> 

  <a href="/user/registration">가입하기</a>
  
</li>

<li>
  <h3>레시피</h3>

  <a href="/recipe/list">전체 리스트</a>

  <a href="/recipe/category">카테고리 별</a>

  <a href="/recipe/register">등록</a>
  
</li>

<li>
  <h3>검색</h3>

  <a href="/search/user">유저검색</a>

</li>

<li>
	<h3>관리 페이지</h3>
	
	 <a href="/admin/userList">유저 리스트</a>
</li>

</ul>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<form id='searchForm' action="/search/result" method='get'>
	<select name='type'>
		<option value="A" <c:out value="${pageMaker.cri.type eq 'A' ? 'selected' : '' }"/>>통합검색</option>
		<option value="T" <c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : '' }"/>>제목</option>
		<option value="W" <c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : '' }"/>>작성자</option>
		<option value="Tag" <c:out value="${pageMaker.cri.type eq 'Tag' ? 'selected' : '' }"/>>태그</option>
	</select>
			
	<input type='text' name='keyword' id="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
	<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
	<button class='btn btn-default'>Search</button>
</form>

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