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
        margin-bottom: 20px;
    }

    .footer {
        width: 1000px;
        height: 200px;
        margin: 0px auto;
        padding-left: 20px;
        padding-right: 20px;
    }

    .info_banner {
        display: inline-block;
    }

    #name_footer {
        height: 80px;
        text-align: center;
        background-color: khaki;
        font-size: 25px;
        font-weight: bold;
    }

    .form_control {
        display: block;
        width: 310px;
    }

    </style>
<body>
   <div style="margin-left:470px">
   </div>

<!--메인 화면-->
    <div class="content_wrapper" data-group="main">
        <div class="today_recipe"  style="grid-area: a; text-align: center;">
            <h5>방금 업데이트 된 따끈따끈한 요리!</h5>
            <div id="today_photo">
                <a href="/recipe/detail?rno=<c:out value='${last.rno }'/>">
                <img src="<c:out value='${last.thumbnail}'/>" style="width: 550px; height: 440px; padding-left: 15px; padding-top: 13px;">
                </a>
            </div>
        <div id="today_info" style="margin-left: 40px;">
            <div id="today_date" style="float: left; width: 120px; height: 80px;" >
                <p><fmt:formatDate pattern="yyyy년 MM월 dd일" value="${last.regDate}"/></p>
            </div>
            <div id="today_title" style="width: 400px; height: 80px; padding-top: 2px; text-align: left;">
                <a href="/recipe/detail?rno=<c:out value='${last.rno }'/>"><p><c:out value="${last.title}"/></p></a>
                <a href="/user/profile?userId=<c:out value='${lastUser.userNo }'/>">
                <p><c:out value="${last.userNo}"/><span><img src="<c:out value="${lastUser.profilePhoto}"/>" style="width: 19px; height: 18px;"></span></p>
                </a>
            </div>
        </div>
    </div>

        <div id="side_banner" style="grid-area: b;">
            <h3 style="text-align: center;">매주 갱신 추천특집!</h3>
            <div class="tieup_list">
                <div class="tieup_list_holder" data-ad-slot="pc-tieup-text" data-ad-capacity="15" data-ad-displayed="1" >
                    <div>
                          <ul>
                            <li class="clearfix">
                            <div class="left-col">
                                <a class="head-text" href="#" rel="sponsored" target="_self">고등어 캔 ♪ 여름 간단한 반찬 레시피</a>
                              </div>
                            </li>
                          </ul>
                    </div>

                    <div>
                          <ul>
                            <li class="clearfix">
                              <div class="left-col">
                                <a class="head-text" href="#" rel="sponsored" target="_self">더위를 극복 여름 밥 레시피 ◎</a>
                              </div>
                            </li>
                          </ul>
                    </div>

                    <div>
                          <ul>
                            <li class="clearfix">
                              <div class="left-col">
                                <a class="head-text" href="#" rel="sponsored" target="_self">집에서! 본격 라떼 만드는 법</a>
                              </div>
                            </li>
                          </ul>
                        </div>
                        </div>
                        
                    <div>
                      <ul>
                        <li class="clearfix">
                          <div class="left-col">
                            <a class="head-text" href="#" rel="sponsored" target="_self">더위 방지 ◎ 체력 준비</a>
                          </div>
                        </li>
                      </ul>
                    </div>
                    
                    <div>
                        <ul>
                          <li class="clearfix">
                            <div class="left-col">
                              <a class="head-text" href="#" rel="sponsored" target="_self">더위를 극복 여름 밥 레시피 ◎</a>
                            </div>
                          </li>
                        </ul>
                  </div>
                  
                  <div>
                    <ul>
                      <li class="clearfix">
                        <div class="left-col">
                          <a class="head-text" href="#" rel="sponsored" target="_self">더위를 극복 여름 밥 레시피 ◎</a>
                        </div>
                      </li>
                    </ul>
              </div>
              
              <div>
                <ul>
                  <li class="clearfix">
                    <div class="left-col">
                      <a class="head-text" href="#" rel="sponsored" target="_self">더위를 극복 여름 밥 레시피 ◎</a>
                    </div>
                  </li>
                </ul>
          </div>
                <div>
                    <ul>
                        <li class="clearfix">
                        <div class="left-col">
                          <a class="head-text" href="#" rel="sponsored" target="_self">더위를 극복 여름 밥 레시피 ◎</a>
                        </div>
                      </li>
                    </ul>
              </div>
              <div>
                <ul>
                  <li class="clearfix">
                    <div class="left-col">
                      <a class="head-text" href="#" rel="sponsored" target="_self">더위를 극복 여름 밥 레시피 ◎</a>
                    </div>
                  </li>
                </ul>
          </div>
          <div>
            <ul>
              <li class="clearfix">
                <div class="left-col">
                  <a class="head-text" href="#" rel="sponsored" target="_self">더위를 극복 여름 밥 레시피 ◎</a>
                </div>
              </li>
            </ul>
        </div>
                    <div>
                        <ul>
                          <li class="clearfix">
                            <div class="left-col">
                              <a class="head-text" href="#" rel="sponsored" target="_self">더위를 극복 여름 밥 레시피 ◎</a>
                            </div>
                          </li>
                        </ul>
                    </div>
                    <div>
                        <ul>
                          <li class="clearfix">
                            <div class="left-col">
                              <a class="head-text" href="#" rel="sponsored" target="_self">10분안에 만드는 간단한 반찬</a>
                            </div>
                          </li>
                        </ul>
                    </div>
                <div class="link_to_event" style="text-align: right; margin-right: 30px;">
                <a href="#">더보기</a>
                </div>
                </div>
        </div>


        <div id="ranking_recipe" style="grid-area: c; background-color: orange;">
        </div>
        <div id="hot_recipe" style="grid-area: e; background-color: khaki;"></div>
    </div>

    <!--푸터-->
    <div class="footer_wrapper">
    <footer>
        <div class="footer" id="info_footer">
            <div class="info_inner">
                <div class="info_banner" style="width:440px; padding-left:45px">
                    <p class="info_link">
                        <a href="/info/CookInfo.jsp" target="_blank">회사소개</a><span>|</span>
                        <a href="#" target="_blank">광고문의</a><span>|</span>
                        <a href="#" target="_blank">개인정보처리방침</a><span>|</span>
                        <a href="#" target="_blank">이용약관 </a><span>|</span>
                        <a href="#">고객센터</a>
                    </p>
                    
                    <p class="info_link">대표 : 최원석 / E : help@Cookstagram.com<br>
                        주소 : 서울 종로구 종로 69 서울YMCA빌딩 <br>
                        문의전화(운영시간 평일 9:30~6:20)<br>
                        쇼핑문의(쿡스타그램) : 02-1234-1234<br>
                        서비스 이용문의 : 070-1234-1234
                    </p>

                    <p class="info_link">Copyright <b>©Cookstagram</b> Inc. All Rights Reserved</p>
                </div>
                <div class="info_banner" style="padding-left:140px">
                    <textarea id="customerSend" name="board_txt" class="form-control" rows="8" cols="40" placeholder="불편사항이나 제안사항  이 있으신가요?      쿡스타그램에 전하고 싶은 의견을 남겨주세요."></textarea>
                    <button class="form_control" >의견제출</button>
                    <p class="noti">개별회신을 원하시면 <a href="#" style="text-decoration:underline; color:#666;">여기</a>에 문의하세요.</p>
                </div>
            </div>
        </div>
        <div class="footer" id="name_footer">
            <p style="padding-top: 17px;">Cookstagram Since 2020</p>
        </div>
    </footer>
</div>
</body>
</html>