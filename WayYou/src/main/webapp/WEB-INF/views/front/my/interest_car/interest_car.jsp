<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
	<div>
		<ul class="listType1 grid2 btn-toggle-switch-target">
			<!-- Loop -->
			<li ng-repeat="car in carList">
				<a href="<c:url value='/front/category/mycar/buyDetail/{{car.carSeq}}'/>">
					<div class="thumBack">
						<span class="markSet mark1" ng-show="car.bnkConfYn == 'Y'">인증</span>
						<span class="bookingCount" ng-show="car.resCnt > 0">예약 <strong>{{car.resCnt}}</strong>건</span>
						<div>
							<img check-img ng-lazy-src="{{car.itemImgInfo.mThumbPath}}" ng-model="car" alt="{{car.label.makerName}}{{car.label.modelDtlName}}" />
						</div>
					</div>
					<div class="prBack">
						<div class="productInfo">
							<div><strong>{{car.label.makerName}}</strong><span>{{car.label.modelDtlName}}</span><span>{{car.label.gradeName}}</span></div>
							<p><span>{{car.label.carRegYear | isEmpty}}</span><em>{{car.carArea}}</em><em>{{car.label.useKm | number | suffix:'km'}}</em></p>
						</div>
						<span class="markGroup">
							<span class="markSet mark2" ng-show="car.carGuarRefundYn == 'Y'">환불</span>
							<span class="markSet mark3" ng-show="car.carGuarFruitlessYn == 'Y'">헛걸음</span>
							<span class="markSet mark4" ng-show="car.carGuarTermYn == 'Y'">1년보증</span>
							<strong class="goodsPrice"><strong>{{car.saleAmt | number}}</strong>만원</strong>
						</span>
						<span class="heartSet">
							<input ng-if="sessUserInfo.division == -1" type="checkbox" id="h_1{{$index}}" ng-click="onClick('DIBS_ON',car)" ng-checked="car.dibsYn === 'Y'" onclick="return false;"/>
							<input ng-if="sessUserInfo.division == 'N' || sessUserInfo.division == 'D'" type="checkbox" id="h_1{{$index}}" ng-checked="car.dibsYn === 'Y'" ng-click="onClick('DIBS_ON',car)"/>
							<label for="h_1{{$index}}"><!--찜하기--></label>
						</span>
					</div>
				</a>
			</li>
			<!-- //Loop -->
		</ul>
		<div class="noRecord" ng-show="carList && carList.length === 0">관심차량이 없습니다.</div> <!-- 2017-06-18 -->
	</div>
	<div style="width:100%" class="bnk_loading initializing" ng-show="bInitializing"></div>
	<div style="width:100%" class="bnk_loading more" ng-hide="oPageInfo.bHasMore == false || bShowEmpty == true"></div>
</section>