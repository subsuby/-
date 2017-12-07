<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
	<input type="hidden" id="userName" />
	<input type="hidden" id="phoneMobile" />
    <div class="loginLayout">
        <p class="pwReset">새로운 비빌번호를 입력하여 주세요.<br /> 사용하시던 비밀번호는 삭제처리 됩니다.</p>
        <div class="pwForm">
            <p class="grayTxt">영문, 숫자, 특수문자 조합 10~20자 이내</p>
            <form method="post" action="">
                <fieldset>
                    <input type="password" value="" name="password"    ng-model="password" placeholder="비밀번호를 입력하세요." />
                    <input type="password" value="" name="passwordChk" ng-model="passwordChk" placeholder="다시한번 비밀번호를 입력하세요." />
                </fieldset>
            </form>
            <div class="btnSet btn_pwreset">
                <span><button class="red" ng-click="changePw()">비밀번호 변경</button></span>
            </div>
        </div>
    </div>
</section>