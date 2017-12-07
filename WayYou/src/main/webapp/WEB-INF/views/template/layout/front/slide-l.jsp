<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<aside class="c-menu c-menu--slide-left">
	<div class="snbBack back">
		<div class="asideLeftMenu">
			<div class="logo"><a href="<c:url value="/front/main"/>"><em>BNK홈</em></a></div>
			<ul>
				<li><a ng-click="slideClick('/front/category/service/serviceList')" href="#">현장서비스</a></li>
				<li><a ng-click="slideClick('/front/category/service/special')">BNK오토모아<br/>서비스</a></li>
				<li><a ng-click="slideClick('/front/category/certify/certifyList')">인증중고차</a></li>
				<li><a ng-click="slideClick('/front/category/mycar/buyList')">내차사기</a></li>
				<li><a ng-click="slideClick('/front/category/mycar/sells')">내차팔기</a></li>
			</ul>
		</div>
	</div>
</aside>