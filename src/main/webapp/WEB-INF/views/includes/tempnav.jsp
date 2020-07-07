<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
String userNo = null;
if(session!=null) {
 Object tmp = session.getAttribute("userNo");
 if(tmp!=null) {
	 userNo = tmp.toString(); 
 }
}
%>
<ul>
<li>
  <h3><a href="/">메인</a></h3>
</li>
<li>
  <h3>유저</h3> 
  <%=userNo==null?"비회원님":"회원님" %> 안녕하세요

  <%=userNo==null?"<a href="+"/user/registration"+">가입하기</a>":"" %>
 
  <%=userNo==null?"":"<a href="+"/user/myProfile"+">마이 페이지</a>" %>
  
  <%=userNo==null?"<a href="+"/user/login"+">로그인</a>":"<a href="+"/user/logout"+">로그아웃</a>" %>
  
</li>

<li>
  <h3>레시피</h3>
  <a href="/recipe/list"><img src="https://i.postimg.cc/kgHGnJbq/ALL.png" />전체</a>

  <a href="/recipe/list?categoryNo=11"><img
         src="https://i.postimg.cc/26R5Z0Gt/BanChan.png" />주식</a>
  
  <a href="/recipe/list?categoryNo=22"><img
         src="https://i.postimg.cc/Gps2tWFY/Desert.png" />디저트</a>
  
  <a href="/recipe/list?categoryNo=33"><img
         src="https://i.postimg.cc/C1GxHb6x/Jusik.png" />반찬</a>

  <%=userNo==null?"":"<a href="+"/recipe/registe"+">@레시피 등록</a>" %>
  
</li>


<%=userNo!=null&&userNo.equals("1")?"<li><h3>관리 페이지</h3><a href="+"/admin/userList"+">@유저 리스트</a>"
+"<a href="+"/admin/recipeList"+">@레시피 리스트</a></li>":"" %>


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