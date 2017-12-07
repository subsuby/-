<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
    <div class="loginLayout">
        <h2 class="titleBnk">BNK</h2>
        <div class="loginForm">
            <form name="login_form" id="login_form" method="post">
            	<input type="hidden" value="" id="un" name="un" />
				<input type="hidden" value="" id="up" name="up" />
            </form> 
            <fieldset>  
                <input type="text" ng-model="login.un" placeholder="성명을 입력하세요." name="userName" />
                <input type="tel" ng-model="login.um" ng-blur="onBlur('INPUT_PHONE_NUMBER')" placeholder="휴대폰 번호를 입력하세요." name="phoneMobile" />
                <input type="password" ng-model="login.up" placeholder="비밀번호를 입력하세요." name="password" autocomplete="new-password"/>
                <div class="btnSet loginBtn">
                    <span><a href="#none" class="red" id="btn_loginChk" ng-click="onClick('BTN_LOGIN')">로그인</a></span>
                </div>
            </fieldset>
            <div class="keepsave">
                <span class="checkSet"><input type="checkbox" id="c_c1" ng-model="login.isNameAndPhoneSave" /><label for="c_c1">성명, 휴대폰번호 저장</label></span>
		        <span class="checkSet"><input type="checkbox" id="c_c2" ng-model="login.isPasswordSave" /><label for="c_c2">비밀번호 저장</label></span>
            </div>
            <div class="btnSet btnLogin">
                <span><a href="<c:url value="/front/common/pwResetBefore"/>" class="blackLine">비밀번호 찾기</a></span>
                <span><a href="<c:url value="/front/common/joinKind"/>" class="blackLine">회원가입</a></span>
            </div>
        </div>
    </div>
</section>