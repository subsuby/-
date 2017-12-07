<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section ng-cloak ng-init="init()">
	<div class="myCarLayout" ng-show="!isEmptyList()">
		<div class="bgWrite">
			<h3>등록차량리스트
                <a class="btnEnroll" ng-click="onClick('CD_REG')">내차등록</a><!-- 2017-06-14 내차등록 위치이동 -->
            </h3>
			<div class="carList">
			    <ul class="ulCls">
                    <li class="gridSet" ng-repeat="item in carList" ng-click="select($index)" ng-class="{on: item === selectedData}">
                        <span class="gridItem">{{item.carPlateNum | isEmpty}}</span>
                        <span class="gridItem">{{item.label.makerName}}&nbsp;{{item.label.modelDtlName}}&nbsp;{{item.label.gradeName}}</span>
                        <span class="gridItem">{{item.carRegYear | isEmpty}}</span>
                        <span class="gridItem">{{item.label.carColor | isEmpty}}</span>
                    </li>
                </ul>
			</div>
		</div>
		<div class="myCarInfo">
			<div class="carName">
                <strong>{{selectedData.label.makerName}}&nbsp;{{selectedData.label.modelDtlName}}&nbsp;{{selectedData.label.grade}}</strong>
                <a ng-click="onClick('CD_MORE')">더보기</a>
            </div>
            <span class="infoTxt">
                <i>{{selectedData.carRegYear | isEmpty}}</i>
                <i>{{selectedData.useKm | number | suffix:'km 미만'}}</i>
                <i>{{selectedData.label.carColor | isEmpty}}</i>
                <i>{{selectedData.label.carMission | isEmpty}}</i>
                <i>{{selectedData.carPlateNum | isEmpty}}</i>
            </span>
			<span class="carMenu">
				<!-- 2017-06-14 내차등록 위치이동 -->
				<a class="btnModify" ng-click="onClick('CD_MOD')" >내차수정</a>
				<a class="btnBring" ng-click="onClick('CD_LOAD')">매물가져오기</a>
				<a class="btnEnd" ng-click="onClick('CD_COMPLETE')">판매완료</a> <!-- 2017-06-18 class 추가 -->
			</span>
		</div>
		<div class="btn-toggle-wrapper">
			<div class="btnTab case1 grid3">
				<a href="" onclick="return false;" class="btn-toggle-switch on"><span>내차시세</span></a>
			</div>
			<div class="btn-toggle-switch-target" style="display: block;">
				<div class="dataItem noLine">
					<!-- BNK 시세 -->
					<bnk-price-dealer params="car" />
				</div>
			</div>
		</div>
	</div>
    <div class="myCarLayout" ng-show="isEmptyList()">
        <div class="noList"><em class="blind">목록없음</em></div>
        <div class="btn-toggle-wrapper">
            <div class="btnTab case1 grid3">
                <a href="" onclick="return false;" class="btn-toggle-switch on"><span>내차시세</span></a>
            </div>
            <div class="btn-toggle-switch-target noList">
                <strong>등록된 차량·시세 정보가 없습니다.</strong>
                <span>내차팔기에서 회원님의 차량정보를 등록하시고<br>BNK 시세정보를 확인하세요.</span>
                <button type="button" class="btnEnroll" ng-click="onClick('CD_REG')">등록하기</button>
            </div>
        </div>
    </div>
</section>