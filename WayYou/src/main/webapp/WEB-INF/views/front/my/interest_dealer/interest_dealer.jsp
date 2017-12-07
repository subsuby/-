<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
	<div>
		<ul class="dealerList">
			<li ng-repeat="dealer in list">
				<span class="heartSetS">
					<input type="checkbox" ng-if="sessUserInfo.division == -1" id="h_1{{$index}}" ng-checked="true" ng-click="onClick('INST_DEALER', dealer)" onClick="return false;"/>
					<input type="checkbox" ng-if="sessUserInfo.division == 'N' || sessUserInfo.division == 'D'" id="h_1{{$index}}" ng-checked="true" ng-click="onClick('INST_DEALER', dealer)" />
					<label for="h_1{{$index}}"><!--찜하기--></label>
				</span>
				<a href="javascript:;" class="dealerProfile" ng-click="openPopup(dealer)">
					<div class="fixWidth">
						<span class="thumProfile">
							<img src="<c:url value="/front/images/thumbnail/profile2.png"/>" alt="">
						</span>
					</div>
					<div class="autoWidth">
						<span class="levelBadge level{{dealer.gradeDealer}}"><strong>{{dealer.userName}}</strong><i>딜러</i></span>
						<div class="rating rating-s" data-rateit-readonly="true" data-rateit-value="{{dealer.evalAvg}}" ng-init="$last && rateitInit()"></div>
						<br/>
						<p>
							<span>{{shopCodeInfoMap[dealer.shopNo].danjifullname}}, {{shopCodeInfoMap[dealer.shopNo].danjicity}}</span><br/>
							<span>종사자번호 {{dealer.dealerLicenseNo}}</span><br/>
							<span>판매중 <em>{{dealer.saleCarCnt}}</em>대</span>
							<strong>누적판매 {{dealer.saleCnt}}대</strong>
						</p>
					</div>
				</a>
			</li>
		</ul>
		<div class="noRecord" ng-show="list && list.length === 0">관심딜러가 없습니다.</div> <!-- 2017-06-18 -->
	</div>
</section>