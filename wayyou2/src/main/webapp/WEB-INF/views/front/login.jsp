<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
	<title>BRT</title>
<!-- 	<link rel="shortcut icon" href="/resources/img/favicon.ico"> -->
	<link rel="stylesheet" type="text/css" href="/resources/css/custom-animations.css" />
	<link rel="stylesheet" type="text/css" href="/resources/css/style.css" />
	<script type="text/javascript" src="/resources/js/jquery-2.1.4.min.js?ver=1"></script>
	<script type="text/javascript" src="/resources/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/resources/js/jquery.validate.min.js"></script>
	<script type="text/javascript" src="/resources/js/toastr.min.js"></script>
	<script type="text/javascript" src="/resources/js/jquery.waypoints.min.js"></script>
	<script type="text/javascript" src="/resources/js/jquery.appear.js"></script>
	<script type="text/javascript" src="/resources/js/jquery.plugin.js"></script>
	<script type="text/javascript" src="/resources/js/jquery.countTo.js"></script>
	<script type="text/javascript" src="/resources/js/masonry.pkgd.min.js"></script>
	<script type="text/javascript" src="/resources/js/modal-box.js"></script>
	<script type="text/javascript" src="/resources/js/jquery-ui.min.js"></script>
</head>
<tiles:insertAttribute name="scripts"></tiles:insertAttribute>
<tiles:insertAttribute name="common"></tiles:insertAttribute>
<body>
	<div class="preloader-mask" style="display:none;">
		<div class="preloader"></div>
	</div>

<%-------------------------------------------- 메인화면 ------------------------------------------------------------ --%>
<section id="hero" class="hero-section bg-cover window-height light-text backG" style="padding-top:15%;">
	<div class="heading-block centered-block align-center">
		<div class="container">
			<img src="/resources/img/custom/logo.png" style="width:auto;max-width:60%;margin-bottom:40px;">
			<div class="btns-container">
				<a href="#none" class="btn btn-outline btn-md" class="login" onclick="LoginScript.goLogin()" style="font-size:16px; margin-bottom:4px;"><spring:message code="login.login"/></a>
				<br/>
				<a href="#none" class="btn btn-md" class="start" onclick="LoginScript.goSignUp()" style="font-size:16px; margin-bottom:4px;"><spring:message code="login.sign_in"/></a>
				<br/>
				<a href="#none" class="pinkColor" data-modal-link="findIdPw" style="text-decoration:underline;"><spring:message code="login.find_id_pwd"/></a>
				<br/>
				<br/>
				<span class="pinkColor" onclick="CommonScript.changeLocale('K')">한국어 /</span>
				<span class="pinkColor" onclick="CommonScript.changeLocale('J')"> 日本語</span>
			</div>
		</div>
	</div>
</section>
<%-------------------------------------------- 로그인 ------------------------------------------------------------ --%>
<section id="login" class="hero-section bg-cover window-height light-text backF" style="display:none;">
	<span class="close-btn icon icon-wayYou-back" onclick="LoginScript.goBack()"></span>
	<br/>
	<div>
		<img src="/resources/img/custom/logo.png"
		 style="width:auto;max-width:40%;display: block; margin-left:auto; margin-right:auto; padding-bottom: 100px !important;">
	</div>
<!-- 	<h5 class="align-center"><span class="highlight">Login</span></h5> -->
	<form class="form registration-form align-center" id="loginForm">
		<fieldset class="col-sm-12">
			<input name="userId" type="text" class="emailIn customInput" placeholder="<spring:message code='login.email'/>">
			<span class="underInputR" style="width:85%;display:block;margin-left:auto !important;margin-right:auto !important;"></span>
		</fieldset>
		<fieldset class="col-sm-12">
			<input name="password" type="password" class="pwIn customInput" placeholder="<spring:message code='login.password'/>">
			<span class="underInputR"></span>
		</fieldset>
		<br/>
		<br/>
		<div class="btns-container" style="padding:0px;">
			<input type="button" value="<spring:message code='login.login'/>" class="btn btn-outline btn-md" onclick="LoginScript.goMain()" style="font-size:16px;">
		</div>
	</form>
</section>
<%-------------------------------------------- 회원가입 ------------------------------------------------------------ --%>
<section id="start" class="hero-section bg-cover window-height light-text backF" style="display:none;">
	<span class="close-btn icon icon-wayYou-back" onclick="LoginScript.goBack()"></span>
	<br/>
	<div>
		<img src="/resources/img/custom/logo.png"
		 style="width:auto;max-width:40%;display: block; margin-left:auto; margin-right:auto; padding-botton: 100px;">
	</div>
	<form class="form registration-form align-center" id="signForm">
		<fieldset class="col-sm-12">
			<input name="userId" type="text" class="emailIn customInput" placeholder="<spring:message code='login.email'/>" maxlength="50"
			style="width:60% !important;display: inline-block !important;margin-left: 7% !important;" onchange="LoginScript.resetDup();">
<!-- 			<img src="/resources/img/custom/duplicate.png" class="schImgBtn" onclick="LoginScript.checkDuplicate();"> -->
			<input type="button" value="<spring:message code='login.duplicate_check'/>" onclick="LoginScript.checkDuplicate();"
			style="display: inline-block;width: 25%;height: 39px;background-color: #edc3c3;border: 0px !important;color: #405470;border-radius: 18%;">
			<span class="underInputR"></span>
			<input type="hidden" id="checkDup" value="N">
		</fieldset>
		<fieldset class="col-sm-12">
			<input name="password" type="password" class="pwIn customInput" placeholder="<spring:message code='login.password'/>" maxlength="16">
			<span class="underInput"><spring:message code="login.msg.password_format"/></span>
		</fieldset>
		<fieldset class="col-sm-12">
			<input name="passwordConfirm" type="password" class="pwIn customInput" placeholder="<spring:message code='login.password_confirm'/>" maxlength="16">
			<span class="underInputR"></span>
		</fieldset>
		<fieldset class="col-sm-12">
			<input name="userName" type="text" class="nameIn customInput" placeholder="<spring:message code='login.name_nickname'/>" maxlength="20">
			<span class="underInput"></span>
		</fieldset>
		<fieldset class="col-sm-12">
			<input name="birth" type="text" class="birthIn customInput" placeholder="<spring:message code='login.birth'/>" maxlength="8">
			<span class="underInput"><spring:message code="login.msg.birth_format"/></span>
		</fieldset>
		<fieldset class="col-sm-12">
			<input name="phone" type="text" class="phoneIn customInput" placeholder="<spring:message code='login.phone_number'/>" maxlength="20" onblur="CommonScript.blurPhone(this)">
			<span class="underInput"><spring:message code="login.msg.phone_format"/></span>
		</fieldset>
	</form>
	<input type="button" value="<spring:message code='login.go_sign_in'/>" class="btn btn-outline btn-md" onclick="LoginScript.submit()" style="
    margin-bottom: 50px; width:100%; font-size:16px;">
</section>
<%-------------------------------------------- 회원가입 결과 ------------------------------------------------------------ --%>
<div class="modal-window signResult open" data-modal="signResult" style="background-color: #405470; display: none;">
	<div class="modal-box small animated zoomIn" data-animation="zoomIn" data-duration="700" 
	style="top: 0px; animation-delay: 0ms; animation-duration: 0.7s;margin-top:50%;margin-bottom:50%;">
		<span class="close-btn icon icon-office-52"></span>
		<h5 class="align-center"><span class="pinkColor"><spring:message code="login.sign_in"/></span></h5>
		<br/><br/>
		<h7 class="align-center"><span class="pinkColor"><spring:message code="login.msg.please_confirm_email"/></span></h7>
	</div>
</div>
<%-------------------------------------------- ID/PW 찾기 ------------------------------------------------------------ --%>
<div class="modal-window open" data-modal="findIdPw" style="background-color: #405470; display: none;">
	<div class="modal-box small animated zoomIn" data-animation="zoomIn" data-duration="700" 
	style="top: 0px; animation-delay: 0ms; animation-duration: 0.7s;" onclick="LoginScript.resetInput();">
		<span class="close-btn icon icon-office-52"></span>
		<h5 class="align-center" style="margin-top:20px;"><span class="pinkColor"><spring:message code="login.find_id_pwd"/></span></h5>
		<br/><br/>
		<a href="#none" class="btn btn-outline btn-md" class="login" style="display: block; margin-left:auto; margin-right:auto;font-size:16px"
		data-modal-link="findId">
			<spring:message code="login.find_id"/>
		</a>
		<br/><br/>
		<a href="#none" class="btn btn-md" class="start" style="display: block; margin-left:auto; margin-right:auto;font-size:16px;"
		data-modal-link="findPw">
			<spring:message code="login.find_pwd"/>
		</a>
		<br/>
	</div>
</div>
<%-------------------------------------------- ID 찾기 ------------------------------------------------------------ --%>
<div class="modal-window open" data-modal="findId" style="background-color: #405470; display: none;">
	<div class="modal-box small animated zoomIn" data-animation="zoomIn" data-duration="700" 
	style="top: 0px; animation-delay: 0ms; animation-duration: 0.7s;">
		<span class="close-btn icon icon-office-52"></span>
		<h5 class="align-center"><span class="pinkColor"><spring:message code="login.find_id"/></span></h5>
		<br/>
		<form class="form registration-form align-center" id="findIdForm">
			<fieldset class="col-sm-12">
				<input name="userName" type="text" class="nameIn customInput" placeholder="<spring:message code='login.name_nickname'/>" style="width:100% !important;">
				<span class="underInput"></span>
			</fieldset>
			<fieldset class="col-sm-12">
				<input name="userBirth" type="text" class="birthIn customInput" placeholder="<spring:message code='login.birth'/>" style="width:100% !important;">
				<span class="underInput"><spring:message code="login.msg.birth_format"/></span>
			</fieldset>
			<fieldset class="col-sm-12">
				<input name="userPhone" type="text" class="phoneIn customInput" placeholder="<spring:message code='login.phone_number'/>" style="width:100% !important;" onblur="CommonScript.blurPhone(this)">
				<span class="underInput"><spring:message code="login.msg.phone_format"/></span>
			</fieldset>
			<br/>
			<input type="button" value="<spring:message code='login.find'/>" class="btn btn-outline btn-md" onclick="LoginScript.findId()" style="font-size:16px;">
		</form>
	</div>
</div>
<%-------------------------------------------- ID찾기 결과 ------------------------------------------------------------ --%>
<div class="modal-window idResult open" data-modal="idResult" style="background-color: #405470; display: none;">
	<div class="modal-box small animated zoomIn" data-animation="zoomIn" data-duration="700" 
	style="top: 0px; animation-delay: 0ms; animation-duration: 0.7s;margin-top:50%;margin-bottom:50%;">
		<span class="close-btn icon icon-office-52"></span>
		<h5 class="align-center"><span class="pinkColor"><spring:message code="login.find_id"/></span></h5>
		<br/><br/>
		<h7 class="align-center"><span class="pinkColor" id="idResult"></span></h7>
	</div>
</div>
<%-------------------------------------------- PW찾기 ------------------------------------------------------------ --%>
<div class="modal-window open" data-modal="findPw" style="background-color: #405470; display: none;">
	<div class="modal-box small animated zoomIn" data-animation="zoomIn" data-duration="700" 
	style="top: 0px; animation-delay: 0ms; animation-duration: 0.7s;">
		<span class="close-btn icon icon-office-52"></span>
		<h5 class="align-center"><span class="pinkColor"><spring:message code="login.find_pwd"/></span></h5>
		<br/>
		<form class="form registration-form align-center"  id="findPwdForm">
			<fieldset class="col-sm-12">
				<input name="userId" type="text" class="emailIn customInput" placeholder="<spring:message code='login.email'/>" style="width:100% !important;">
				<span class="underInput"></span>
			</fieldset>
			<fieldset class="col-sm-12">
				<input name="userName" type="text" class="nameIn customInput" placeholder="<spring:message code='login.name_nickname'/>" style="width:100% !important;">
				<span class="underInput"></span>
			</fieldset>
			<fieldset class="col-sm-12">
				<input name="userBirth" type="text" class="birthIn customInput" placeholder="<spring:message code='login.birth'/>" style="width:100% !important;">
				<span class="underInput"><spring:message code="login.msg.birth_format"/></span>
			</fieldset>
			<fieldset class="col-sm-12">
				<input name="userPhone" type="text" class="phoneIn customInput" placeholder="<spring:message code='login.phone_number'/>" style="width:100% !important;" onblur="CommonScript.blurPhone(this)">
				<span class="underInput"><spring:message code="login.msg.phone_format"/></span>
			</fieldset>
			<br/>
			<input type="button" value="<spring:message code='login.find'/>" class="btn btn-outline btn-md" style="font-size:16px;"onclick="LoginScript.findPw()">
		</form>
	</div>
</div>
<%-------------------------------------------- PW찾기 결과 ------------------------------------------------------------ --%>
<div class="modal-window pwResult open" data-modal="pwResult" style="background-color: #405470; display: none;">
	<div class="modal-box small animated zoomIn" data-animation="zoomIn" data-duration="700" 
	style="top: 0px; animation-delay: 0ms; animation-duration: 0.7s;margin-top:50%;margin-bottom:50%;">
		<span class="close-btn icon icon-office-52"></span>
		<h5 class="align-center"><span class="pinkColor"><spring:message code="login.find_pwd"/></span></h5>
		<br/><br/>
		<h7 class="align-center"><span class="pinkColor"><spring:message code="login.msg.code_to_email"/><br/><spring:message code="login.msg.input_code"/></span></h7>
		<br/><br/>
		<fieldset class="col-sm-12">
			<input name="pwdFindCode" type="password" class="pwIn customInput" placeholder="<spring:message code='login.code'/>" style="width:100% !important">
			<span class="underInput"></span>
		</fieldset>
		<input type="button" value="<spring:message code='login.confirm'/>" class="btn btn-outline btn-md" style="font-size:16px;" onclick="LoginScript.pwReset()">
	</div>
</div>
<%-------------------------------------------- PW 재설정 ------------------------------------------------------------ --%>
<div class="modal-window pwReset open" data-modal="pwReset" style="background-color: #405470; display: none;">
	<div class="modal-box small animated zoomIn" data-animation="zoomIn" data-duration="700" 
	style="top: 0px; animation-delay: 0ms; animation-duration: 0.7s;margin-top:20%;display:block;">
		<span class="close-btn icon icon-office-52"></span>
		<h5 class="align-center"><span class="pinkColor"><spring:message code="login.reset_password"/></span></h5>
		<br/><br/>
		<h7 class="align-center"><span class="pinkColor"><spring:message code="login.msg.reset_password"/> <br/><spring:message code="login.msg.input_reset_password"/></span></h7>
		<br/><br/>
		<form id="pwdResetForm">
			<fieldset class="col-sm-12">
				<input name="password" type="password" class="pwIn customInput" placeholder="<spring:message code='login.password'/>" style="width:100% !important;">
				<span class="underInput"><spring:message code="login.msg.password_format"/></span>
			</fieldset>
			<fieldset class="col-sm-12">
				<input name="passwordConfirm" type="password" class="pwIn customInput" placeholder="<spring:message code='login.password_confirm'/>" style="width:100% !important;">
				<span class="underInput"></span>
			</fieldset>
		</form>
		<input type="button" value="<spring:message code='login.confirm'/>" class="btn btn-outline btn-md" style="font-size:16px;" onclick="LoginScript.pwResetConfirm()">
	</div>
</div>
<%-------------------------------------------- pw재설정 결과 ------------------------------------------------------------ --%>
<div class="modal-window pwResetResult open" data-modal="pwResetResult" style="background-color: #405470; display: none;">
	<div class="modal-box small animated zoomIn" data-animation="zoomIn" data-duration="700" 
	style="top: 0px; animation-delay: 0ms; animation-duration: 0.7s;margin-top:50%;margin-bottom:50%;">
		<span class="close-btn icon icon-office-52"></span>
		<h5 class="align-center"><span class="pinkColor"><spring:message code="login.reset_password"/></span></h5>
		<br/><br/>
		<h7 class="align-center">
			<span class="pinkColor">
				<spring:message code="login.msg.complete_reset_password"/>
			</span>
		</h7>
	</div>
</div>
</body>
</html>
	