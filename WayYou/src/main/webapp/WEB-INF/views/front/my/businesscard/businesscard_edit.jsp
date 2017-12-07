<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section ng-init="getNameCard()">
	<div class="innerLayout">
		<div class="dealerArea">
			<span class="thumProfile">
				<img src="<c:url value="/front/images/thumbnail/profile2.png"/>" alt="">
			</span>
			<div>
				<span class="levelBadge level3"><span><strong>{{user.userName}}</strong> 딜러</span></span><br/>
					<em>
						<i>종사원번호</i> {{user.dealerLicenseNo}}<br>
						{{user.dealerDanjiName}} {{user.dealerShopName}}
					</em>
					<p>{{user.dealerProfileDesc.length > 0 ? user.dealerProfileDesc : '등록된 메모가 없습니다.'}}</p>
					<a href="tel:{{user.dealerProfileTel}}">{{user.dealerProfileTel.length > 0 ? user.phoneNumMask : '등록된 연락처가 없습니다.'}}</a>
			</div>
		</div>
		<div class="btnSet">
			<span><a class="redLine" ng-click="modifyClick()" onclick="return false;">수정하기</a></span>
			<span><a href="" class="red" ng-click="sendClick()">전송하기</a></span>
		</div>
	</div>
</section>