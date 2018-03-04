<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<h3 class="menuTitle" style="color:#edc3c3;"><spring:message code="mypage.mypage"/></h3>
<section id="start" class="section schedule-section align-center" style="min-height:350px;">
	<form class="form registration-form align-center" id="signForm">
		<fieldset class="col-sm-12">
			<input name="userId" type="text" class="emailIn customInput" placeholder="<spring:message code='mypage.email'/>" maxlength="50" readonly
			style="display: inline-block !important;margin-left: 7% !important;border-bottom:none !important;">
		</fieldset>
		<fieldset class="col-sm-12">
			<input name="userName" type="text" class="nameIn customInput" placeholder="<spring:message code='mypage.name_nickname'/>" maxlength="20">
			<span class="underInputR"></span>
		</fieldset>
		<fieldset class="col-sm-12">
			<input name="birth" type="text" class="birthIn customInput" placeholder="<spring:message code='mypage.birth'/>" maxlength="8" readonly style="border-bottom:none !important;">
		</fieldset>
		<fieldset class="col-sm-12">
			<input name="phone" type="text" class="phoneIn customInput" placeholder="<spring:message code='mypage.phone'/>" maxlength="20" onblur="CommonScript.blurPhone(this)">
			<span class="underInputR"></span>
		</fieldset>
	</form>
	<input type="button" value="<spring:message code='mypage.modified'/>" class="btn btn-outline btn-md" onclick="MyInfoScript.changeInfo()" style="
    margin-bottom: 50px; width:100%; font-size:16px;">
</section>