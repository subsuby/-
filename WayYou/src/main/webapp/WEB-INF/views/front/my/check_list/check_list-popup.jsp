<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 체크리스트 팝업 -->
<div>
<!-- <check-pop params="oParams" on-load-callback="onPopHandler(id, data)" /> -->
<check-dealer-pop params="oParams" on-load-callback="onPopHandler(id, data)" /><%-- 체크리스트 팝업 --%>
</div>
<!-- 구매비용 팝업 -->
<div><cost-result-pop params="oParams" on-load-callback="onPopHandlerCost(id, data)" /></div>
