<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section ng-init="loadLayerPopup()">
	<div class="mainLayout">
		<div class="mainSearch">
			<p class="infotxt">허위매물 없는 실매물 중심의 중고차<br>BNK오토모아의 특별한 서비스와 함께해보세요.</p>
			<div>
				<%--
					[angucomplete-alt 옵션 설명]
						참고: https://github.com/ghiden/angucomplete-alt
						- id*: 필드의 고유 ID
					 	- placeholder: 검색 필드의 자리 표시자
						- maxlength: 검색 필드의 Maxlength 속성
						- minlength: 검색 필드의 Minlength 속성
						- pause: 사용자가 새 문자를 입력 할 때 검색하기 전에 기다리는 시간 (밀리 초)
						- selected-object*: 선택된 객체 (selectedObject 또는 objectSelectedCallback)
						- selected-object-data: 선택된 객체 데이터
						- selected-object-data-init: '선택된 객체 데이터' 초기화 핸들러
						- local-data: 컨트롤러에서 사용할 로컬 데이터 변수(배열)
						- search-fields: 검색 할 지역 데이터의 필드 (쉼표로 구분). 각 필드는 중첩 된 속성에 액세스하기위한 점을 포함 할 수 있음
						- title-field*: 자동 완성 목록에 제목을 표시하는 데 사용해야하는 JSON 객체의 필드 이름
						- input-class: 입력 상자의 스타일을 지정하는 데 사용할 클래스
						- clear-selected: 항목을 선택할 때 입력 필드를 지우려면이 속성을 true로 설정
						- text-no-results: 일치하는 항목이 없을 때 표시 할 사용자 정의 문자열. 'false'로 설정하면 텍스트가 표시되지 않음
						- text-searching: 검색이 진행 중일 때 표시 할 사용자 정의 문자열. 'false'로 설정하면 텍스트가 표시되지 않음
				--%>
				<angucomplete-alt id="ex1"
					              placeholder="원하는 매물 정보를 입력하세요"
					              text-no-results="매물 정보를 찾을 수 없습니다"
					              text-searching="검색 중..."
					              pause="100"
					              selected-object="onQuickSearchHandler"
					              selected-object-data="oSearch.oConditions"
					              selected-object-data-init="onQuickInitHandler"
					              delete-object-handler="onQuickDeleteHandler"
					              local-data="oSearch.oLoadData"
					              search-fields="name"
					              title-field="name"
					              minlength="1"
					              input-class="wFull"
					              clear-selected="true"
					              search-class="searchText"
					              match-class="highlight"/>
			</div>
			<button class="btnSearch" ng-click="onClick('BTN_DETAIL_POP')"><em>상세조건 검색하기</em></button>
			<a href="#none" ng-click="onClick('BTN_SEARCH')">검색</a>
		</div>
		<div class="btn-toggle-wrapper">
			<div class="btnTab case1 grid2">
				<a href="" onclick="return false;" class="btn-toggle-switch on"><span>내차사기</span></a>
				<a href="" onclick="return false;" class="btn-toggle-switch" ><span>내차팔기</span></a>
			</div>
			<div class="btn-toggle-switch-target">
				<div class="thumLargeBack">
					<div class="swiperTypeCover" >
						<ul class="swiper-wrapper">
							<li class="swiper-slide">
								<strong class="icon6">사전예약서비스</strong>
								<span>내가 먼저 찜! 내 차를 예약하기</span>
								<p>
									마음에 드는 차량이 내가 도착하기 전에 팔리면 어쩌지?<br>
									고객님이 직접 차량을 확인하시기 전까지 차량 판매를<br>
									유보해드립니다
								</p>
							</li>
							<li class="swiper-slide">
								<strong class="icon7">시승·탁송 서비스</strong>
								<span>구매 전 시승하고 내 집에서 내 차 받기!</span>
								<p>
									원하시는 장소, 시간대에서 구매 전 차량을 시승해보고<br>
									구매한 차량을 원하는 곳에서 받아보세요!
								</p>
							</li>
						</ul>
						<div class="swiper-pagination"></div>
						<div class="btnSet pt12 pb0">
							<span><button class="red" onClick="location.href='<c:url value='/front/category/mycar/buyList'/>'">내차사기</button></span>
						</div>
					</div>
				</div>
			</div>
			<div class="btn-toggle-switch-target" style="display:none;">
				<div class="thumLargeBack">
					<div class="swiperTypeCover" >
						<ul class="swiper-wrapper">
							<li class="swiper-slide">
								<strong class="icon9">방문견적 서비스</strong>
								<span>내 차 판매를 내 집에서!</span>
								<p>
									내 차가 얼마인지 궁금하다면? 방문견적 서비스를 이용해보세요.<br>
									차량평가 전문가가 찾아가 차량을 평가해드립니다.
								</p>
							</li>
							<li class="swiper-slide">
								<strong class="icon8">MAKE-UP 서비스</strong>
								<span>차량 업그레이드로 더 높은 가격에!</span>
								<p>
									메이크업 전문가가 직접 방문하여<br>
									차량의 메이크업 토탈케어를 해드립니다.<br>
									차량  관리도 하고 더 높은 가격에 판매해보세요.
								</p>
							</li>
							<li class="swiper-slide">
								<strong class="icon10">위탁판매 서비스</strong>
								<span>번거로운 차량판매를 쉽게!</span>
								<p>
									차량판매가 번거로우신가요? 가격흥정에 질리셨나요?<br>
									BNK오토모아에 믿고 맡기신다면, 신속하고 높은 가격에<br>
									차량을 판매해드립니다.
								</p>
							</li>
						</ul>
						<div class="swiper-pagination"></div>
						<div class="btnSet pt12 pb0">
							<span><button class="red" ng-click="slideClick('/front/category/mycar/sells')">내차팔기</button></span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="linkService">
			<div>
				<a href="<c:url value='/front/category/service/special'/>">
					<strong>다양한 BNK오토모아 서비스</strong> <!-- 2017-07-24 -->
					<span>BNK오토모아에서만 만나볼 수 있는<br> 특별한 서비스들을 살펴보세요!</span>
				</a>
			</div>
			<div>
				<a ng-click="slideClick('/front/category/mycar/sells')">
					<strong>내차를 판매하고 싶을 때,</strong>
					<span>소유한 차량의 간단한 정보를 입력하고<br> BNK 시세를 확인하세요!</span>
				</a>
			</div>
		</div>
		<div class="btn-toggle-wrapper" data-on-class="on">
			<div class="listSort">
				<span class="left">
					<i class="logo">인증중고차</i>
				</span>
				<div class="right">
					<span class="listCase bar">
						<button class="case1 btn-toggle-switch on" data-on-class="grid2">앨범보기</button>
						<button class="case2 btn-toggle-switch" data-on-class="grid1">리스트보기</button>
					</span>
				</div>
			</div>
			<ul class="listType1 grid2 btn-toggle-switch-target">
				<li ng-repeat="car in carList" >
					<div class="thumBack">
						<a href="<c:url value="/front/category/mycar/buyDetail/"/>{{car.carSeq}}">
							<span class="markSet mark1" ng-show="car.bnkConfYn == 'Y'">인증</span>
							<span class="bookingCount" ng-show="car.resCnt > 0">예약 <strong>{{car.resCnt}}</strong>건</span>
							<div>
								<img check-img ng-lazy-src="{{car.itemImgInfo.mThumbPath}}" ng-model="car" alt="{{car.label.makerName}}{{car.label.modelDtlName}}" />
							</div>
						</a>
					</div>
					<div class="prBack">
						<a href="<c:url value="/front/category/mycar/buyDetail/"/>{{car.carSeq}}">
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
						</a>
						<span class="heartSet">
							<input ng-if="sessUserInfo.division == -1" type="checkbox" id="h_1{{$index}}" ng-click="onClick('DIBS_ON',car)" ng-checked="car.dibsYn === 'Y'" onclick="return false;"/>
							<input ng-if="sessUserInfo.division == 'N' || sessUserInfo.division == 'D'" type="checkbox" id="h_1{{$index}}" ng-checked="car.dibsYn === 'Y'" ng-click="onClick('DIBS_ON',car)"/>
							<label for="h_1{{$index}}"><!--찜하기--></label>
						</span>
					</div>
				</li>
			</ul>
			<div class="noRecord" ng-show="bShowEmpty">검색조건이 없습니다.</div>
		</div>
		<div style="width:100%" class="bnk_loading initializing" ng-show="bInitializing"></div>
		<div style="width:100%" class="bnk_loading more" ng-hide="oPageInfo.bHasMore == false || bShowEmpty == true"></div>
	</div>
</section>
<!-- 2017-07-17 -->
<div class="mainEvent swiper-container-horizontal swiper-container-autoheight" ng-class="{off: !showPopup}">
	<strong ng-click="onClick('BTN_CLOSE')"><img src="<c:url value="/front/images/sub/openEvent_3.png"/>" alt=""></strong>
	<div>
		<p><span class="checkSet"><input type="checkbox" ng-model="popCookie" id="pop_c1"><label for="pop_c1">하루동안 보지 않기</label></span></p>
		<img src="<c:url value="/front/images/sub/openEvent_1.png"/>" alt="">
	</div>
	<a href="http://www.bnkcapital.co.kr/mobile/bnkautomoa/event.html" target="_blank" style="display:block;"><img src="<c:url value="/front/images/sub/openEvent_2.png"/>" alt="" ng-click="onClick('BTN_CLOSE')"></a>
</div>
<div class="eventBak" ng-class="{off: !showPopup}"></div>
<style>
	.mainEvent {position:fixed;top:30px;left:30px;right:30px;z-index:5000;}
	.mainEvent strong {position:absolute;top:0;right:0;z-index:5;display:inline-block;width:10%;}
	.mainEvent strong img {width:100%;}
	.mainEvent a img {width:100%;display:block;}
	.mainEvent div {position:relative;}
	.mainEvent div p {position:absolute;bottom:10px;left:10px;}
	.mainEvent div img {width:100%;display:block;}
	.eventBak {position:fixed;left:0;top:0;bottom:0;display:block;width:100%;z-index:3001;background:#000;
				-ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=75)";
				filter: alpha(opacity=75);
				opacity: .75;}
	.mainEvent.off, .eventBak.off{display:none;}
</style>
<!-- 2017-07-17 -->
