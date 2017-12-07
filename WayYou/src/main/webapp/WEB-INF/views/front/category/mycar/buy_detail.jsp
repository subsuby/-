<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
	<div class="carDetail">
		<!---->
		<div class="carSummary">
			<h2 class="dpn">매물정보</h2>
			<div class="thumLargeBack">
				<span class="markSet lC mark1" ng-show="car.user.bnkConfYn == 'Y'">인증</span>
				<span class="tagOk" ng-show="car.carExistYn == 'Y'">실매물확인완료</span>
				<div class="bcBack">
					<span class="bookingCount" ng-show="car.resCnt > 0"><strong>{{car.resCnt}}</strong>건</span>
				</div>
				<div class="swiperTypeNumber" >
					<ul class="swiper-wrapper">
						<li class="swiper-slide" ng-if="car.imgInfoList ==null || car.imgInfoList.length === 0">
							<img check-img ng-lazy-src="" style="width:100%;display:block;"/>
						</li>
						<li class="swiper-slide" ng-repeat="imgInfo in car.imgInfoList">
							<img check-img ng-lazy-src="{{imgInfo.pImgPath}}" style="width:100%;display:block;"/>
						</li>
					</ul>
					<!-- 이전 다음 버튼  -->
					<a href="#" class="swiper-btn swiper-button-prev"></a>
					<a href="#" class="swiper-btn swiper-button-next"></a>
					<div class="swiper-pagination"></div>
				</div>
			</div>
			<div class="priceLarge">
				<strong>{{car.saleAmt | number}} <em>만원</em></strong>
				<span>
					<a href="javascript:alertify.alert('준비중입니다')">보험료계산</a>
<!-- 					<a href="javascript:;" class="redLine viewCase" ng-click="showLoanLimit()">대출한도조회</a> -->
					<a href="<c:url value="/front/forward/bnkcapital/mobile?carSeq={{car.carSeq}}"/>" class="redLine viewCase" target="_blank">대출한도조회</a>
				</span>
			</div>
			<div class="prBack">
				<div class="productInfo">

					<div><strong>{{car.label.makerName}}</strong><span>{{car.label.modelDtlName}}</span><span>{{car.label.gradeName}}</span></div>
					<p><span>{{car.label.carRegYear | isEmpty}}</span><em>{{car.label.useKm | number | suffix:'km'}}</em><em>{{car.label.carColor | isEmpty}}</em><em>{{car.label.carFuel | isEmpty}}</em><em>{{car.label.carMission | isEmpty}}</em></p>
				</div>
				<span class="markGroup">
					<span ng-if="car.carGuarFruitlessYn === 'Y'" class="markSet lC mark2 btn-popup-full" onclick="return false;" data-pop-opts='{"target": ".popWrapRefund"}'>환불</span>
					<span ng-if="car.carGuarRefundYn === 'Y'" class="markSet lC mark3 btn-popup-full" onclick="return false;" data-pop-opts='{"target": ".popWrapSickness"}'>헛걸음</span>
					<span ng-if="car.carGuarTermYn ==='Y'" class="markSet lC mark4 btn-popup-full" onclick="return false;" data-pop-opts='{"target": ".popWrapYear"}'>1년보증</span>
				</span>
			</div>
		</div>
		<!---->
		<div class="dataSet bgGrayCase">
			<div class="gridSet rnl">
				<span class="gridItem gI-5">
					<a class="blackLine" ng-click="onClick('CD_FAKE')">허위매물신고</a>
				</span>
				<span class="gridItem gI-5">
					<span class="heartSetLarge">
						<input ng-if="sessUserInfo.division == -1" type="checkbox" id="h_1" ng-click="onClick('DIBS_ON')" ng-checked="car.dibsYn === 'Y'" onclick="return false;"/>
						<input ng-if="sessUserInfo.division == 'N' || sessUserInfo.division == 'D'" type="checkbox" id="h_1" ng-checked="car.dibsYn === 'Y'" ng-click="onClick('DIBS_ON')"/>
						<label for="h_1">찜하기<em><!--하트--></em></label>
					</span>
				</span>
			</div>
		</div>
		<!-- BNK 시세 디렉티브 2017-06-08 hk-lee -->
		<div class="dataSet bgGrayCase">
			<h2>BNK 시세</h2>
			<div class="dataItem">
				<bnk-price-common params="car" />
			</div>
		</div>
		<!-- BNK 시세 디렉티브  끝-->
		<!-- 차량정보 디렉티브  2017-06-08 hk-lee -->
		<div>
			<bnk-car-info params="car" />
		</div>
		<!-- 차량정보 디렉티브 끝-->
		<div class="dataSet bgGrayCase optionView">
			<h2>옵션정보</h2>
			<div class="dataItem">
				<ul>
					<li ng-class="{off:!enableOptionCd(optionDefault.cdDtlNo)}" ng-repeat="optionDefault in optionDefaultCodeList">{{optionDefault.cdDtlNm}}</li>
				</ul>
				<div class="btn-accordion-wrapper" data-toggle-on="true" data-multiple-on="true">
					<div class="btn-accordion-switch accordionSet">
						<div class="accordionData optionViewMore">
							<dl ng-repeat="optionType in optionTypeCodeList">
								<dt>{{optionType.cdDtlNm}}</dt>
								<dd>
									<ol>
										<li ng-class="{off:!enableOptionCd(option.cdDtlNo)}"
										ng-if="optionType.cdSubNo === option.cdNo" ng-repeat="option in optionCodeList">{{option.cdDtlNm}}</li>
									</ol>
								</dd>
							</dl>
						</div>
						<div class="btn-accordion-switch-item">
							<div class="btnSet">
								<span><a class="gray viewCase"><strong>상세옵션</strong> <em class="off">보기 +</em><em class="on">닫기 -</em></a></span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!---->
		<div class="dataSet bgGrayCase" ng-if="exists(car.label.carVideoUrl)">
			<h2>동영상보기</h2>
			<div class="dataItem">
				<div class="embedBack"><div class="embedContents" ng-bind-html="trustAsYoutube"></div></div>
			</div>
		</div>
		<!---->
		<div class="dataSet bgGrayCase" ng-if="exists(car.label.carDesc)">
			<h2>차량설명</h2>
			<div class="dataItem">
				<div class="moreArea" ng-class="{on : moreToggle}" ng-bind-html="trustAsHtml"><!-- carDesc -->
				</div>
				<div class="btnSet">
					<span><a class="gray viewCase moreToggle" ng-click="moreToggle = !moreToggle" ng-class="{on : moreToggle}"><strong>차량설명</strong> <em class="off">더보기 +</em><em class="on">접기</em></a></span>
				</div>
			</div>
		</div>
		<!-- 딜러 프로필 디렉티브  2017-06-13 hk-lee -->
		<div>
			<bnk-dealer-profile params="car"/>
		</div>
		<!-- 딜러 프로필 디렉티브 끝-->

		<!-- BNK 추천차량 디렉티브 2017-06-08 yh-lee -->
		<div>
			<bnk-car-recommend params="car" />
		</div>
		<!-- BNK 추천차량 디렉티브  끝-->

		<div class="myFavoriteAdd">
			<p>
				<strong>찾으시는 차량이 없나요?</strong>
				원하는 조건을 등록하시면 맞는 차량을 찾아 알림을 드립니다.
			</p>
			<a href="#" class="red" ng-click="onPopupOpen()">내게맞는매물 등록</a>
		</div>
		<!-- 2017-06-15 위치 이동 -->
	</div>
</section>
