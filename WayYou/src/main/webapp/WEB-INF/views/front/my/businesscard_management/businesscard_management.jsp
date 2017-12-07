<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
	<div class="busiCardLayout line">
		<div class="searchBar">
			<div class="searchArea">
				<input type="text" id="" ng-model="search.schValue" placeholder="딜러명 및 연락처를 입력하세요.">
				<label for="" class="dpn">전화번호 및 고객명</label>
				<button type="button" class="" ng-click="onClick('BTN_SEARCH')">검색</button>
			</div>
		</div>
	</div>
	<div class="quesLayout">
		<div class="btn-accordion-wrapper manageList" data-toggle-on="true">
			<dl class="btn-accordion-switch accordionSet" ng-repeat="dealer in list" ng-init="$last && resInit()">
				<dt class="accordionTitle btn-accordion-switch-item">
					<i class="complete">{{dealer.sendDate}}</i>
					<strong><em>{{dealer.userName}}</em>{{dealer.phoneMobile | securityPhon}}</strong>
					<input type="button" value="삭제" class="dealerDelete" ng-click="onClick('BTN_DELETE', dealer)">
				</dt>
				<dd class="accordionData">
					<div class="dealerArea">
						<span class="thumProfile">
							<img src="<c:url value="/front/images/thumbnail/profile2.png"/>" alt="">
						</span>
						<div>
							<span class="levelBadge level{{dealer.gradeDealer}}"><span><strong>{{dealer.userName}}</strong> 딜러</span></span>
							<em>{{shopCodeInfoMap[dealer.shopNo].danjifullname}} | {{shopCodeInfoMap[dealer.shopNo].danjicity}}</em>
							<a href="tel:{{dealer.dealerProfileTel}}">{{dealer.dealerProfileTel}}</a>
							<p>{{dealer.dealerProfileDesc}}</p>
						</div>
					</div>
				</dd>
			</dl>
		</div>
		<div class="noRecord" ng-show="list && list.length === 0">수신된 명함이 없습니다.</div> <!-- 2017-06-18 -->
	</div>
</section>