<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section ng-cloak ng-init="init()">
	<div class="myCarLayout" ng-show="!isEmptyList()">
		<div class="bgWrite">
			<h3>등록차량리스트
			    <a href="" class="btnEnroll" onclick="return false;" ng-click="onClick('CD_REG')">내차등록</a><!-- 2017-06-14 내차등록 위치이동 -->
			</h3>
			<div class="carList">
				<ul class="ulCls">
				    <li class="gridSet" ng-repeat="item in myCarList" ng-click="select($index)" ng-class="{on: item === selectedData}">
				        <span class="gridItem">{{item.carPlateNum | isEmpty}}</span>
				        <span class="gridItem">{{item.label.makerName}}&nbsp;{{item.label.modelDtlName}}&nbsp;{{item.label.grade}}</span>
				        <span class="gridItem">{{item.carRegYear | isEmpty}}</span>
				        <span class="gridItem">{{item.label.carColor | isEmpty}}</span>
				    </li>
				</ul>
			</div>
		</div>
		<div class="myCarInfo">
			<div class="carName">
                <strong>{{selectedData.label.makerName}}&nbsp;{{selectedData.label.modelDtlName}}&nbsp;{{selectedData.label.grade}}</strong>
            </div>
			<span class="infoTxt">
				<i>{{selectedData.carRegYear | isEmpty}}</i>
				<i>{{selectedData.useKm | number | suffix:'km 미만'}}</i>
				<i>{{selectedData.label.carColor | isEmpty}}</i>
				<i>{{selectedData.label.carMission | isEmpty}}</i>
				<i>{{selectedData.carPlateNum | isEmpty}}</i>
			</span>
			<span class="carMenu">
                <a href="" class="btnModify modifyBtn" ng-click="onClick('CD_MOD')" ng-if="selectedData" >내차수정</a>
                <a href="" class="btnRequest reqBtn" ng-click="onPopupOpenEsti()" ng-if="selectedData && selectedData.estCompleteYn != 'Y' && selectedData.estReqYn != 'Y'">견적요청</a>
                <a href="" class="btnCancel cnclReqBtn" ng-click="cnclReq(selectedData.label.estReqType)" ng-if="selectedData && selectedData.estCompleteYn != 'Y' && selectedData.estReqYn == 'Y'">견적요청취소({{selectedData.label.estReqType}})</a>
                <a href="" class="btnRequest reqBtn" ng-if="selectedData && selectedData.estCompleteYn == 'Y'">견적완료</a>
            </span>
		</div>
		<div class="btn-toggle-wrapper">
			<div class="btnTab case1 grid3">
				<a href="" onclick="return false;" class="btn-toggle-switch on"><span>내차시세</span></a>
				<a href="" onclick="return false;" class="btn-toggle-switch"><span>내차견적</span></a>
			</div>
			<div class="btn-toggle-switch-target" style="display: block;">
				<div class="dataItem noLine">
					<!-- BNK 시세 -->
					<div><bnk-price-normal params="car" /></div>
					<!-- 2017-07-27 -->
					<div class="estimateBtn" ng-if="estimateInfo.estAmt > 0">
						<div class="btnSet">
							<span><button type="button" class="red" ng-click="onClick('CD_EST_MAX')">해당 견적으로 내차 팔기</button></span>
						</div>
						* 다른 딜러의 견적내역을 보고 싶다면, '내차견적' 탭을 선택하세요.
					</div>
					<!-- //2017-07-27 -->
				</div>
			</div>
			<div class="btn-toggle-switch-target" style="display: none;">
				<dl class="estimateList">
					<dt>
						<span>딜러정보</span>
						<span>견적가격</span>
<!-- 						<span>전송날짜</span> -->
						<span>비고</span>
						<span>보기</span>
					</dt>
					<dd>
						<ul>
							<li class="gridItem" ng-if="car.estimateArr.length === 0"><span class="gridItem"><em>견적 결과가 없습니다.</em></span></li>
							<li class="gridSet" ng-repeat="est in car.estimateArr">
								<span class="gridItem">
									<em>{{est.estDealerNm}} 딜러</em>
									<em>{{est.estShopNm}}</em>
								</span>
								<span class="gridItem">{{est.estAmt | number:'0'}} 만원</span>
<!-- 								<span class="gridItem">2017-07-10</span> -->
								<span class="gridItem">{{est.estRemark}}</span>
								<span class="gridItem"><a ng-click="onClick('CD_EST_DEALER', est)">더보기</a></span>
							</li>
						</ul>
					</dd>
				</dl>
			</div>
		</div>
	</div>
    <div class="myCarLayout" ng-show="isEmptyList()">
        <div class="noList"><em class="blind">목록없음</em></div>
        <div class="btn-toggle-wrapper">
            <div class="btnTab case1 grid3">
                <a href="" onclick="return false;" class="btn-toggle-switch on"><span>내차시세</span></a>
                <a href="" onclick="return false;" class="btn-toggle-switch"><span>내차견적</span></a>
            </div>
            <div class="btn-toggle-switch-target noList">
                <strong>등록된 차량·시세 정보가 없습니다.</strong>
                <span>내차팔기에서 회원님의 차량정보를 등록하시고<br>BNK 시세정보를 확인하세요.</span>
                <button type="button" class="btnEnroll" ng-click="onClick('CD_REG')">등록하기</button>
            </div>
        </div>
    </div>
</section>
