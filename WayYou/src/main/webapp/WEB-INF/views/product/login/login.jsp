<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- contents -->
<div class="contents">
    <section>
        <div class="loginLayout bgGrayCase">
            <h2 class="titleBnk"><em class="blind">BNK</em></h2>
            <div class="loginForm">
                <form method="post" id="login_form" method="post">
                    <fieldset>
                        <input type="text" id="userName" name="userName" placeholder="성명을 입력하세요.">
                        <input type="text" id="phoneMobile" name="phoneMobile" maxlength="11" placeholder="휴대폰 번호를 입력하세요.">
                        <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요." onkeypress="if(event.keyCode===13){login();}">
                        <div class="btnSet loginBtn">
                            <span><a href="javascript:void(0);" id="btnLogin" class="red">로그인</a></span>
                        </div>
                    </fieldset>
                </form>
                <div class="keepsave">
                    <span class="checkSet"><label for="ch1"><input type="checkbox" id="ch1" class="big" /> 성명, 휴대폰번호 저장</label></span>
                    <span class="checkSet"><label for="ch2"><input type="checkbox" id="ch2" class="big" /> 비밀번호 저장</label></span>
                </div>
                <div class="btnSet btnLogin">
                    <span><a href="javascript:void(0);" id="passBtn" class="redLine">비밀번호 찾기</a></span>
                    <span><a href="javascript:void(0);" id="joinBtn" class="redLine">회원가입</a></span>
                </div>
            </div>
        </div>
    </section>
</div>