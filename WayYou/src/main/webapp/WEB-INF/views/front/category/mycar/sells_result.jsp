<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
	<form id="form">
		<input type="hidden" id="car" name="car" value="{{car}}"/>
		<input type="hidden" id="type" name="type" value="move"/>
	</form>
	<div class="priceResult">
		<h2>기본정보</h2>
		<div class="basicInfo">
			<!-- 2017-06-13 대표이미지 삭제 -->
			<strong>{{car.makerLabel}} {{car.modelLabel}} {{car.modelDtlLabel}} {{car.gradeLabel}}</strong>
			<span class="first">{{car.carRegYear}}</span>
			<span>{{car.useKm}}km미만</span>
			<span>{{car.colorLabel}}</span>
			<span>{{car.missionLabel}}</span>
			<span>{{car.carPlateNum}}</span>
		</div>
		<!-- BNK 시세 디렉티브 2017-06-08 hk-lee -->
		<h2>BNK 실시간 견적가</h2>
			<div class="dataSet priceGraph">
				<bnk-price params="priceParam" />
			</div>
		<!-- <div>
			<bnk-sell-price params="priceParam" />
		</div> -->
		<!-- BNK 시세 디렉티브  끝-->
		<div class="btnSet mb0">
			<span>
				<button class="red btn-popup-full" ng-click="onClick()" data-pop-opts='{"target": ".none", "display": "false"}'>내차정보 등록</button>
			</span>
		</div>
	</div>
</section>