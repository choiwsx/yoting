<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
Long userNo = null;
boolean loggedIn = false;
if(session!=null) {
 Object tmp = session.getAttribute("userNo");
 if(tmp!=null) {
	 userNo = (Long)tmp; 
	 loggedIn = true;
 }
}
%>

<nav>
<div style="
display: inline-block; position: relative;
    width: -webkit-fill-available;">
<h3 style="
    float: left;
    background-color: darkseagreen;
"><a href="/">먹스타그램</a></h3>
<div style="
position: relative;
    margin-top: 20px;
    margin-left: 150px;">
<%=loggedIn?"회원님 어서요세요.":"회원으로 가입하고 레시피를 올려주세요." %> &nbsp&nbsp&nbsp
  <b>회원 메뉴 : </b> 
  <%=loggedIn?"":"<a href="+"/user/registration"+">가입하기</a>" %> 
  <%=loggedIn?"<a href="+"/user/mkitchen"+">마이 페이지</a>":"" %>  
  <%=loggedIn?"<a href="+"/user/logout"+">로그아웃</a>":"<a href="+"/user/login"+">로그인</a>" %>
  <b>레시피 메뉴 : </b>
  <a href="/recipe/list">전체</a>
  <a href="/recipe/list?categoryNo=11">주식</a>
  <a href="/recipe/list?categoryNo=22">디저트</a>
  <a href="/recipe/list?categoryNo=33">반찬</a>
  &nbsp
  <a href="/recipe/hotkitchen">인기 주방장</a>
  <%=loggedIn?"<a href="+"/recipe/registration"+"><b>@레시피 등록</b></a>":"" %>
<%=loggedIn&&userNo.equals(1L)?"<li><h3>관리 페이지</h3><a href="+"/admin/userList"+">@유저 리스트</a>"
+"<a href="+"/admin/recipeList"+">@레시피 리스트</a></li>":"" %>
</div>
</div>
</nav>

<div style="text-align: center;">
<form id='searchForm' action="/search/result" method='get'>
	<select name='type'>
		<option value="A" <c:out value="${pageMaker.cri.type eq 'A' ? 'selected' : '' }"/>>통합검색</option>
		<option value="T" <c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : '' }"/>>제목</option>
		<option value="W" <c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : '' }"/>>작성자</option>
		<option value="Tag" <c:out value="${pageMaker.cri.type eq 'Tag' ? 'selected' : '' }"/>>태그</option>
	</select>
			
	<input type='text' name='keyword' id="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>' style='width: 70vw;'>
	<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
	<button class='btn btn-default'>Search</button>
</form>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script type="text/javascript">
  $(document).ready(function(){
	  console.log('<c:out value="${userNo}"/>');
     
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