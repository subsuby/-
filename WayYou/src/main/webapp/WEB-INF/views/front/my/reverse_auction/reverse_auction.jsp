<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section ng-init="init()">
	<!-- 2017-06-18 -->
	<div class="reAutoNoList" ng-show="oParams.reverAuctionInfo == null">
		<div>
			<strong>등록된 매물정보가 없습니다.</strong>
			<button type="button" ng-click="onOpenPopup('REG_POP')">등록하기</button>
		</div>
	</div>
	<!-- //2017-06-18 -->
	<div class="reAutoView"><!-- 2017-06-18 -->
		<dl class="reAutoList" ng-if="oParams.reverAuctionInfo != null">
			<dt><span>매물등록정보</span> <button id="deleteSample" ng-click="delInfo()">정보삭제</button></dt>
			<dd class="reAutoInfo">
				<ul>
					<li>제조사<span>{{oParams.reverAuctionInfo.label.makerName}}</span></li>
					<li>모델<span>{{oParams.reverAuctionInfo.label.modelName}}</span></li>
					<li>세부모델<span>{{oParams.reverAuctionInfo.label.modelDtlName}}</span></li>
					<li>주행거리<span>{{oParams.reverAuctionInfo.label.useKm | number | suffix:'km' }}</span></li>
					<li>연식<span>{{oParams.reverAuctionInfo.label.carRegYear | isEmpty}}</span></li>
					<li>색상<span>{{oParams.reverAuctionInfo.label.carColor | isEmpty}}</span></li>
				</ul>
			</dd>
		</dl>
		<!-- BNK 추천차량 디렉티브 2017-06-15 yh-lee -->
		<div ng-if="oParams.reverAuctionInfo != null">
			<bnk-car-reverse-auction-recommend params="oParams.reverAuctionInfo"/>
		</div>
		<!-- BNK 추천차량 디렉티브  끝-->
	</div>
</section>
