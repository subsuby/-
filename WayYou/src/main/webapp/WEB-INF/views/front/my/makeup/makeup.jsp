<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
	<div class="myLayout">
	<div  ng-show="list && list.length !== 0">
		<h3>등록차량리스트</h3>
		<dl class="carList">
			<dt>
				<span>차량번호</span>
				<span>접수일자</span><!-- 2017-07-17 -->
				<span>진행단계</span>
				<span>보기</span>
			</dt>
			<dd>
				<ul>
					<li class="gridSet" ng-repeat="car in list" ng-click="makeupView($index)" ng-class="{on: car === selectedData}">
						<span class="gridItem">{{car.carPlateNum}}</span>
						<span class="gridItem">{{car.createdDate}}</span>
						<span class="gridItem">{{car.label.makeupState}}</span>
						<span ng-if="car.makeupState=='10'" class="gridItem">고객센터 문의(1644-6598) </a></span>
						<span ng-if="car.makeupState!='10'" class="gridItem">{{car.visitorNm}} <a href="tel:{{car.visitorTel}}">{{car.visitorTel}}</a></span>
					</li>
				</ul>
			</dd>
		</dl>
		<h3>서비스 계약현황</h3>
		<ul class="contractStatus">
			<li><em>차량번호 :</em>{{list.carPlateNum}}</li>
			<li><em>방문(예정)일자 :</em>{{list.visitDay}}</li>
<!-- 		<li class="longTxt"><em>방문지 주소 :</em>{{list.visitAddr}}</li> -->
			<li><em>방문지 주소 :</em>{{list.visitAddr}}</li>
			<li><em>서비스담당자 :</em> {{list.visitorNm}}{{list.visitorTel}}</li>
		</ul>
		<h3> 요청 서비스</h3>
		<div class="checkGroup">
			<span class="checkSet" ng-repeat="opts in makeupTypeCodeList">
				<input type="checkbox" id="c_c1_{{opts.cdDtlNo}}" ng-checked="enableOptionCd(opts.cdDtlNo)" disabled />
				<label for="c_c1_{{opts.cdDtlNo}}">{{opts.cdDtlNm}}</label>
			</span>
		</div>
		<h3>기타 요청사항</h3>
		<textarea cols="10" rows="5" class="txtArea" readonly>{{list.reqRemark}}</textarea>
		</div>
		<div class="noRecord" ng-show="list && list.length === 0">신청내역이 없습니다.</div> <!-- 2017-06-18 -->
		<div class="btnSet">
			<span><a href="" class="red" ng-click='onClick()'>신규신청</a></span>
<!-- 			<span><a href="" class="red btn-popup-full" data-pop-opts='{"target": ".makeupWrite"}'>신규신청</a></span> -->
		</div>
	</div>
</section>