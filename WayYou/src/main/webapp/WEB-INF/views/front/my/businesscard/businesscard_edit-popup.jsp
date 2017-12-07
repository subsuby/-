<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 명함발송 팝업 -->
<div><card-pop params="oParams" on-load-callback="onPopHandler(id, data)" /></div>
<!-- 명함수정 팝업 -->
<div><card-modify-pop params="oParams" on-load-callback="onPopHandler(id, data)" /></div>
<!-- 전송하기 팝업 -->
<div><push-send-pop params="oParams" on-load-callback="onPopHandler(id, data)" /></div>