<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<aside class="c-menu c-menu--slide-right">
	<div class="asideMyHead">
		<strong>{{sessUserInfo.userName }}
        <i ng-if="sessUserInfo.division == 'N'">회원님</i>
        <i ng-if="sessUserInfo.division == 'D'">딜러님</i>
        </strong>
   		<span ng-if="sessUserInfo.division == 'N'"><a ng-click="slideMemberClick('/front/common/memberModify', sessUserInfo.userId)" href="#">회원정보수정</a></span>
   		<span ng-if="sessUserInfo.division == 'D'"><a ng-click="slideMemberClick('/front/common/memberModifyDealer', sessUserInfo.userId)" href="#">회원정보수정</a></span>
	</div>
	<div class="infoTxt">
		<div>
			<strong> </strong>
			<i> </i>
		</div>
	</div>
	<ul class="myMenu" ng-if="sessUserInfo.division == 'N'">
		<!-- 일반 회원 -->
		<li ><a ng-click="slideClick('/front/my/interestCar')"><em>관심차량</em></a></li>
		<li ><a ng-click="slideClick('/front/my/interestDealer')"><em>관심딜러</em></a></li>
		<li ng-class="{iconNew : newDataInfo.readYnMycar == 'Y'}"><a ng-click="slideClick('/front/my/mycar')"><em>마이카</em></a></li>
		<li ng-class="{iconNew : newDataInfo.readYnMakeup == 'Y'}"><a ng-click="slideClick('/front/my/makeup')"><em>메이크업</em></a></li>
		<li ng-class="{iconNew : newDataInfo.readYnRes == 'Y'}"><a ng-click="slideClick('/front/my/reserList')"><em>방문·시승·탁송<br>예약</em></a></li>
		<li ng-class="{iconNew : newDataInfo.readYnQna == 'Y'}"><a ng-click="slideClick('/front/my/qnaList')"><em>문의내역관리</em></a></li>
		<li ng-class="{iconNew : newDataInfo.readYnRecomm == 'Y'}"><a ng-click="slideClick('/front/my/reverseAuction')"><em>내게맞는매물</em></a></li>
		<li ng-class="{iconNew : newDataInfo.readYnNameCard == 'Y'}"><a ng-click="slideClick('/front/my/businesscardManagement')"><em>명함관리</em></a></li>
		<li ng-class="{iconNew : newDataInfo.readYnCheck == 'Y'}"><a ng-click="slideClick('/front/my/checkList')"><em>수신함</em></a></li>
		<li ><a ng-click="slideClick('/session/front/logout-proc')"><em>로그아웃</em></a></li>
<%-- 		<li class="iconNew"><a href="<c:url value='/front/common/memberSecession'/>"><em>회원탈퇴신청</em></a></li> --%>
	</ul>
	<ul class="myMenu" ng-if="sessUserInfo.division == 'D'">
		<!-- 딜러 -->
		<li ng-class="{iconNew : newDataInfo.readYnMycar == 'Y'}"><a ng-click="slideClick('/front/my/mycarDealer')"><em>마이카</em></a></li>
		<li ng-class="{iconNew : newDataInfo.readYnRes == 'Y'}"><a ng-click="slideClick('/front/my/reserListDealer')"><em>방문·시승·탁송<br>예약관리</em></a></li>
		<li ng-class="{iconNew : newDataInfo.readYnNameCard == 'Y'}"><a ng-click="slideClick('/front/my/businesscard')"><em>명함발송관리</em></a></li>
		<li ><a ng-click="slideClick('/front/my/interestCar')"><em>관심차량관리</em></a></li>
		<li ><a ng-click="slideClick('/front/my/sendQuotation')"><em>비용계산 발송관리</em></a></li><!-- 2017-06-15 -->
		<li ng-class="{iconNew : newDataInfo.readYnMakeup == 'Y'}"><a ng-click="slideClick('/front/my/makeupDealer')"><em>메이크업</em></a></li>
		<li ><a ng-click="slideClick('/front/my/reverseAuction')"><em>내게맞는매물</em></a></li>
		<li ><a ng-click="slideClick('/front/my/checkDealer')"><em>체크리스트</em></a></li>
		<li ><a ng-click="slideClick('/front/my/businesscardEdit')"><em>명함관리</em></a></li>
		<li ><a ng-click="slideClick('/session/front/logout-proc')"><em>로그아웃</em></a></li>
	</ul>
</aside>