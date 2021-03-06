<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix='fn'%>
<%@page import="java.util.*"%>
<%
   request.setCharacterEncoding("UTF-8");
%>
<%@ include file="includes/tempnav.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Index</title>
<style>
    /* 여기는 index CSS */

    .content_wrapper {
        display: grid;
        padding-top: 15px;
        grid-template-rows: repeat(2, 300px);
        grid-template-columns: repeat(3, 200px);
        grid-template-areas: 
        "a a a b b"
        "a a a b b"
        "c c c d d"
        "c c c f f"
        "c c c f f"
        "e e e e e"
        ;
        grid-gap: 10px;
        
    }

    #main_recipe_info {
        display: inline-block;
    }

    .left-col {
        text-align: left;
        margin-left: 30px;
        margin-bottom: 14px;
    }

    </style>
<body>

<!--메인 화면-->
    <div class="content_wrapper" data-group="main">
            <c:if test="${!empty latestRecipe }">
    
        <div class="today_recipe"  style="grid-area: a; text-align: center;">
            <h3>방금 업데이트 된 따끈따끈한 요리!</h3>
            <div id="today_photo">
                <a href="/recipe/detail?rno=<c:out value='${latestRecipe.rno }'/>">
                <img src="<c:out value='${latestRecipe.thumbnail}'/>" style="width: 550px; height: 440px; padding-left: 15px; padding-top: 13px;" onerror="imgError(this);">
                </a>
            </div>
        <div id="today_info" style="margin-left: 50px; background-color:lightgoldenrodyellow; width:535px">
            <div id="today_date" style="float: left; width: 150px; height: 80px; " >
                <p><fmt:formatDate pattern="yyyy년 MM월 dd일" value="${latestRecipe.regDate}"/></p>
            </div>
            <div id="today_title" style="width: 400px; height: 80px; padding-top: 2px; text-align: left;">
                제목:<a href="/recipe/detail?rno=<c:out value='${latestRecipe.rno }'/>">

<c:choose>
   <c:when test="${fn:length(latestRecipe.title) > 15}">
      ${fn:substring(latestRecipe.title,0,14)}...
   </c:when>
  <c:otherwise>
     ${latestRecipe.title}
  </c:otherwise>
</c:choose>
</a><br>
                주방장:<a href="/user/profile?userId=<c:out value='${author.userId }'/>">
                <c:out value="${author.userId}"/><span><img src="<c:out value="${author.profilePhoto}"/>" onerror="imgError(this);" style="width: 19px; height: 18px;"></span>
                </a>
            </div>
        </div>
    </div>
   </c:if>
               <c:if test="${empty latestRecipe }">
               <img src="http://t1.daumcdn.net/cafeattach/1kt/67dd4a02ede4cdf345d3f45fd8c82a37756bbea9" style="width: 550px; height: 440px; padding-left: 15px; padding-top: 13px;" onerror="imgError(this);">
               
               </c:if>


        <c:if test="${!empty list }">
                <div id="side_banner" style="grid-area: b; background-color:white">
            <h3 style="text-align: center;">그 외 다양한 레시피!</h3>
             <c:forEach items="${list}" var="recipe">
            <div class="tieup_list">
                <div class="tieup_list_holder" data-ad-slot="pc-tieup-text" data-ad-capacity="15" data-ad-displayed="1" >
                    <div>
                          <ul>
                            <li class="clearfix">
                            <div class="left-col">
                                <a class="head-text" href="/recipe/detail?rno=<c:out value='${recipe.rno }'/>">
                                
                                <c:choose>
								   <c:when test="${fn:length(recipe.title) > 20}">
								      ${fn:substring(recipe.title,0,19)}...
								   </c:when>
								  <c:otherwise>
								     ${recipe.title}
								  </c:otherwise>
								</c:choose>
                                </a>
                              </div>
                            </li>
                          </ul>
                    </div>
				</div>
			</div>
</c:forEach>
                <div class="link_to_event" style="text-align: right; margin-right: 30px;">
                <a href="/recipe/list">더 보기</a>
                </div>
                </div>
        </c:if>
        </div>


        <div id="ranking_recipe" style="grid-area: c; background-color: orange;">
        </div>
        <div id="hot_recipe" style="grid-area: e; background-color: khaki;"></div>

<%@ include file="includes/footer.jsp"%>
</body>
</html>