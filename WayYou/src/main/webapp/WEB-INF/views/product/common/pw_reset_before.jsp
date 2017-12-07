<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- contents -->
<div class="contents">
	<section>
		<div class="form">
			<div class="innerLayout">
				<div class="dataSet">
					<h2>비밀번호 변경<em>비밀번호 재설정을 위해 로그인 정보를 입력해 주시기 바랍니다.</em></h2>
				</div>
			</div>
			<form method="post" id="frm" name="frm" action="">
				<div class="loginLayout bgGrayCase pt80">
					<div class="loginForm">
						<form method="post" action="">
							<fieldset>
								<input type="text" id="name" name="name" value="" class="bdbn mb0" placeholder="성명을 입력하세요.">
								<input type="text" id="phoneNo" name="phoneNo" oninput="onInput(this, 'PHONE_NO')" maxlength="11" placeholder="휴대폰 번호를 입력하세요.">
								<div class="btnSet loginBtn half mt40">
									<span><a href='<c:url value="/product/index" />' class="redLine">취소</a></span>
									<span><a href="#" onclick="return false;" id="btnAccr" class="red">본인인증</a></span> <!-- 본인인증 나옴-->
								</div>
							</fieldset>
						</form>
					</div>
				</div>
			</form>
		</div>
	</section>
</div>
<!-- 본인인증서비스 요청 form --------------------------->
<form id="reqKMCISForm" name="reqKMCISForm" method="post">
    <input type="hidden" id="tr_cert" name="tr_cert" value="${trCert}">
    <input type="hidden" id="tr_url" name="tr_url" value="${trUrl}">
    <input type="hidden" id="tr_add" name="tr_add" value="N">
</form>
<!-- //contents -->

