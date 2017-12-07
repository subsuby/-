<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- 비용계산기 팝업 --%>
<div><cost-pop params="oParams" on-load-callback="onPopHandler(id, data)" /></div>
<%-- 비용계산기 결과 팝업--%>
<div><cost-result-pop params="oParams" on-load-callback="onPopHandler(id, data)" /></div>
<!-- 체크리스트 팝업 -->
<div><check-pop params="oParams" on-load-callback="onPopHandler(id, data)" /></div>
<!-- 명함발송 팝업 -->
<div><card-pop params="oParams" on-load-callback="onPopHandler(id, data)" /></div>
<!-- 명함수정 팝업 -->
<div><card-modify-pop params="oParams" on-load-callback="onPopHandler(id, data)" /></div>
<!-- 차량번호검색1 팝업 -->
<div><car-number-search-pop params="oParams" on-load-callback="onPopHandler(id, data)" /></div>
<!-- 전송하기 팝업 -->
<div><push-send-pop params="oParams" on-load-callback="onPopHandler(id, data)" /></div>
<!-- 상세검색 팝업 -->
<div><car-detail-search-pop params="oParams" on-load-callback="onPopHandler(id, data)" /></div>
<!-- 중고차활용팁 팝업 -->
<div><tip-pop params="oParams" on-load-callback="onPopHandler(id, data)" /></div>
<!-- 올바른 중고차고르기 팝업 -->
<div><right-tip-pop params="oParams" on-load-callback="onPopHandler(id, data)" /></div>
<!-- 중고차 필수구비서류 팝업 -->
<div><document-tip-pop params="oParams" on-load-callback="onPopHandler(id, data)" /></div>
<!-- 중고차 무사고기준 팝업 -->
<div><accident-free-tip-pop params="oParams" on-load-callback="onPopHandler(id, data)" /></div>
<!-- 딜러 상세 프로필 팝업 -->
<div><dealer-detail-pop params="oParams" on-load-callback="onPopHandler(id, data)" /></div>



