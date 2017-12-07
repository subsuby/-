<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div><change-password-pop       params="oParams" on-load-callback="onLoad(id, data)"        /></div>    <%-- 비밀번호 변경 팝업 --%>
<div><dealer-group-search-pop   params="oParams" on-load-callback="onLoadGrp(id, data)"     /></div>    <%-- 소속단체 팝업 --%>
<div><dealer-firm-search-pop    params="oParams" on-load-callback="onLoadFirm(id, data)"    /></div>    <%-- 소속상사 팝업 --%>
<div><dealer-no-change-pop      params="oParams" on-load-callback="onLoadDealerNo(id, data)"/></div>    <%-- 종사자번호 변경 팝업 --%>
<div><address-search-pop	params="{}"		on-confirm-callback="onConfirm(data)" /></div> <%-- 주소 변경 팝업 --%>
