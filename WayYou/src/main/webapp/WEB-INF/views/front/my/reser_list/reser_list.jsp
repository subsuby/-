<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
	<div class="quesLayout">
		<div class="reserSort">
			<div>
				<span class="checkSet" ng-repeat="condition in resConditions">
					<input type="checkbox"  id="qc_{{$index}}" ng-model="condition.checked" ng-click="test()"/><label for="qc_{{$index}}">{{condition.label}}</label>
				</span>
			</div>
		</div>
		<div class="btn-accordion-wrapper reserList" data-toggle-on="true"  ng-show="resList.length != 0">
			<dl class="btn-accordion-switch accordionSet" ng-repeat="res in resList" ng-init="$last && resInit()">
				<dt>
					<span>
						<i ng-class="{complete: res.resStatus == 20, waiting: res.resStatus == 10 || res.resStatus == 11, hold: res.resStatus == 90 || res.resStatus == 30 || res.resStatus == 91}">
							{{res.label.resStatus}}
						</i>
						<i>
							{{res.label.resType}}
						</i>
					</span>
					<em>{{shopCodeInfoMap[res.carInfo.shopNo].danjisido}} {{shopCodeInfoMap[res.carInfo.shopNo].danjicity}} {{shopCodeInfoMap[res.carInfo.shopNo].shop.shopfullname}}</em>
					<strong>{{res.carInfo.label.makerName}} {{res.carInfo.label.modelDtlName}} {{res.carInfo.label.gradeName}} {{res.carInfo.label.carFuel}} {{res.carInfo.label.carColor}}</strong>
					<!--  a href="<c:url value="/front/category/mycar/buyDetail/"/>{{res.carSeq}}">더보기</a --><!-- 2017-06-14 -->
					<button class="accordionTitle btn-accordion-switch-item">열고닫기</button>
				</dt>
				<dd class="accordionData">
					<ul>
						<li>
							<em>지역 및 상사</em>
							<p>{{shopCodeInfoMap[res.carInfo.shopNo].danjisido}} {{shopCodeInfoMap[res.carInfo.shopNo].danjicity}} {{shopCodeInfoMap[res.carInfo.shopNo].shop.shopfullname}}</p>
							<button type="button" class="btn-popup-full iconMap" ng-click="setDealerInfo(res)" data-pop-opts='{"target": ".popWrapMap"}'>지역 및 상사 아이콘</button>
						</li>
						<li>
							<em>판매자</em>
							<p><span class="levelBadge level{{res.carInfo.user.gradeDealer}}">등급아이콘</span>{{res.carInfo.user.userName}}</p>
							<button type="button" class="iconMan" ng-click="openPopup(res)" >판매자 아이콘</button>
						</li>
						<li>
							<em>예약일자</em>
							<p>{{res.resDate.substr(0,4)}}년 {{res.resDate.substr(4,2)}}월 {{res.resDate.substr(6,8)}}일
								<i ng-if="res.resAmpm == 'AM'">오전</i><i ng-if="res.resAmpm == 'PM'">오후</i>
								{{res.resTime}}<i ng-if="res.resTime.length > 0">시</i>
							</p>
						</li>
					</ul>
					<div class="btnSet">
						<span><a href="<c:url value="/front/category/mycar/buyDetail/"/>{{res.carSeq}}" class="red">차량상세정보</a></span>
						<span ng-if="res.resStatus != 91">
							<a class="redLine" ng-click="cancelReserve(res)" ng-if="res.resStatus == 10">예약취소</a>
							<a class="redLine " ng-click="confirmReserve(res)" ng-if="res.resStatus == 11">승인</a>
							<a class="redLine " ng-click="cancelPop()" ng-if="res.resStatus == 20">취소요청</a>
						</span>

					</div>
				</dd>
			</dl>
		</div>
		<div class="noRecord" ng-show="resList.length === 0">예약신청이 없습니다.</div> <!-- 2017-06-18 class 변경 -->
	</div>
</section>