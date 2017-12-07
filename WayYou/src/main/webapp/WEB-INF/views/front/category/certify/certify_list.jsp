<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
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
	<div>
		<div class="helpTxt">
			<strong>인증중고차란?</strong>
			<p>
				BNK오토모아 직영매매상사 매물로 Make-up서비스가 완료되었고 <br>
				중고차 성능을 무상으로 연장 보증합니다.
				<!-- BNK오토모아 자체 매물로 Makeup 서비스가 완료되었고,<br>2017-06-01 로고명변경
				매물의 품질보장을 제공합니다. 2017-07-24 -->
			</p>
			<button class="btn-popup-full" data-pop-opts='{"target": ".certifyCar"}'>인증중고차란?</button>
		</div>
		<div class="btn-toggle-wrapper" data-on-class="on">
			<div class="listSort">
				<span class="left">
					<a href="" class="btnDSearch" ng-click="onClick('BTN_DETAIL_POP')">상세검색<em>{{oPageInfo.totListSize | number}} 대</em></a>
				</span>
				<div class="right">
					<span class="ssback">
						<span class="selectSet">
							<select data-role="none" ng-model="oSearch.sort" ng-change="oSearch.sortChange()">
								<option value="T1.CREATED_DATE DESC">최근등록순</option>
								<option value="T1.PV_CNT">인기순</option>
								<option value="convert(T1.MAKER_NAME||T1.MODEL_NAME||T1.DETAIL_MODEL_NAME||T1.GRADE_NAME, 'ISO2022-KR')">상품명순</option>
								<option value="T1.SALE_AMT">낮은 가격순</option> <!-- 2017-06-14 -->
								<option value="T1.SALE_AMT DESC">높은 가격순</option> <!-- 2017-06-14 -->
							</select>
						</span>
					</span>
					<span class="listCase">
						<button class="case1 btn-toggle-switch on" data-on-class="grid2">앨범보기</button>
						<button class="case2 btn-toggle-switch" data-on-class="grid1">리스트보기</button>
					</span>
				</div>
			</div>
			<ul class="listType1 grid2 btn-toggle-switch-target">
				<!-- Loop -->
				<li ng-repeat="car in carList">
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
								<span class="markSet mark2" ng-show="car.carGuarRefundYn == 'Y' ">환불</span>
								<span class="markSet mark3" ng-show="car.carGuarFruitlessYn == 'Y' ">헛걸음</span>
								<span class="markSet mark4" ng-show="car.carGuarTermYn == 'Y' ">1년보증</span>
								<strong class="goodsPrice"><strong>{{car.saleAmt | number}}</strong>만원</strong>
							</span>
						</a>
						<span class="heartSet">
							<input ng-if="sessUserInfo.division == -1" type="checkbox" id="h_1_3{{$index}}" ng-click="onClick('DIBS_ON',car)" ng-checked="car.dibsYn === 'Y'" onclick="return false;"/>
							<input ng-if="sessUserInfo.division == 'N' || sessUserInfo.division == 'D'" type="checkbox" id="h_1_3{{$index}}" ng-checked="car.dibsYn === 'Y'" ng-click="onClick('DIBS_ON',car)"/>
							<label for="h_1_3{{$index}}"><!--찜하기--></label></span>
					</div>
				</li>
			</ul>
			<div class="noRecord" ng-show="bShowEmpty">검색조건이 없습니다.</div>
		</div>
		<div style="width:100%" class="bnk_loading initializing" ng-show="bInitializing"></div>
		<div style="width:100%" class="bnk_loading more" ng-hide="oPageInfo.bHasMore == false || bShowEmpty == true"></div>
	</div>
</section>