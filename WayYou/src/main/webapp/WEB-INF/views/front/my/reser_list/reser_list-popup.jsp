<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div><dealer-detail-pop				params="car"		on-load-callback="onLoad()" /></div><%-- 딜러 프로필 상세 팝업 --%>
<div><view-map-pop					params="car"		on-load-callback="onLoad()" /></div><%-- 매매상사위치 팝업 --%>
<div><dealer-eval-regist-pop		params="car"		on-load-callback="onLoad(id, data)" /></div><%-- 딜러 평가 등록 팝업 --%>
<div><reser-time-con-pop params="oParams"  on-load-callback="onLoad(id, data)" /></div><%--예약시간 승인요청 팝업 --%>
<div><reser-call-pop params="car"		on-load-callback="onLoad()" /></div><%-- 취소불가 팝업 --%>