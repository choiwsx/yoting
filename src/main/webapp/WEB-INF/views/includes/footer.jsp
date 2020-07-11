<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix='fn'%> 

<style>
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
        <!--푸터-->
    <div class="footer_wrapper">
    <footer>
        <div class="footer" id="info_footer">
            <div class="info_inner">
                <div class="info_banner" style="width:440px; padding-left:45px">
                    <p class="info_link">
                        <a href="/cookInfo" target="_blank">회사소개</a><span>|</span>
                           광고문의<span>|</span>
                           개인정보처리방침<span>|</span>
                           이용약관 <span>|</span>
                           고객센터
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