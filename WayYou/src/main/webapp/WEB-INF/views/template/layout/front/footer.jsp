<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<c:choose>
	<c:when test="${(fn:containsIgnoreCase(context, 'category/service/serviceList'))}">
	<div id="footer" ng-class="{mb50 : sessUserInfo.division != -1}">
	</c:when>
	<c:when test="${(fn:containsIgnoreCase(context, 'category/mycar/buyDetail'))}">
	<div id="footer" ng-class="{mb50 : sessUserInfo.division != 'D'}">
	</c:when>
	<c:when test="${(fn:containsIgnoreCase(context, 'index'))}">
	<div id="footer" class="mainFooter">
	</c:when>
	<c:otherwise>
	<div id="footer">
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${(fn:containsIgnoreCase(context, 'index'))}">
	<footer>
		<!-- 2017-07-06 -->
		<span>11939 경기도 구리시 체육관로 47, B1 10호</span>
		<span>주식회사 : 카플랫폼</span>
		<span>대표이사 : 박인식, 박규웅</span>
		<span>사업자번호 : 793-81-00509</span>
		<span>문의번호 :  1644-6598</span>
		<span><a href="<c:url value='/front/common/privacy'/>">개인정보처리방침</a></span><!-- 2017-07-19 -->
		<!-- //2017-07-06 -->
		<address>COPYRIGHT 2017 BNK CAPITAL CO., LTD ALL RIGHTS RESERVED</address>
	</footer>
	</c:when>
	<c:otherwise>
	<footer>
		<address>COPYRIGHT 2017 BNK CAPITAL CO., LTD ALL RIGHTS RESERVED</address>
	</footer>
	</c:otherwise>
</c:choose>
</div>