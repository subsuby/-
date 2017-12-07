<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
<form method="post" id="pwFrm" name="pwFrm" action="">
	<input type="hidden" name="tr_cert" id="tr_cert"/>
	<input type="hidden" name="tr_url" id="tr_url"/>
	<input type="hidden" name="tr_add" value="N"/>
	<input type="hidden" name="name" id="tr_name" value=""/>
	<input type="hidden" name="phoneNo" id="tr_phoneNo" value=""/>
</form>
	<div class="loginLayout">
		<p class="pwReset">비밀번호 재설정을 위해 <br/>로그인 정보를 입력해 주시기 바랍니다.</p>
		<div class="loginForm">
			<form method="post" action="">
				<fieldset>
					<input type="text" id="userName"  value="" placeholder="성명을 입력하세요." />
					<input type="number" id="phoneNum" maxlength="11" value="" placeholder="휴대폰 번호를 입력하세요." />
				</fieldset>
			</form>
			<div class="btnSet btn_pwreset">
				<span><button class="red" href="#" ng-click="beforePw()">확인</button></span>
			</div>
		</div>
	</div>
</section>
