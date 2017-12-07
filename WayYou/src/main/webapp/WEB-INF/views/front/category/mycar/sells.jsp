<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
	<form id="form">
		<input type="hidden" id="car" name="car"/>
	</form>
	<div>
		<div class="priceBefore">
			<div>
				<strong>내차의 시세를 확인하세요.</strong>
				간단한 차량정보를 입력하면<br/>
				내차 시세를 확인하실 수 있습니다.
			</div>
		</div>
		<div class="priceStep" style="display:none;">
			<div>
				<span ng-class="{on: car.makerLabel.length > 0}">{{car.makerLabelDtl.length > 0 ? car.makerLabelDtl : '제조사'}}</span> <!-- 모든정보는 5글자이상일 경우 말줄임 개발에서 적용해야 함 -->
				<span ng-class="{on: car.modelLabel.length > 0}">{{car.modelLabelDtl.length > 0 ? car.modelLabelDtl : '모델'}}</span>
				<span ng-class="{on: car.modelDtlLabel.length > 0}">{{car.modelDtlLabelDtl.length > 0 ? car.modelDtlLabelDtl : '세부모델'}}</span>
				<span ng-class="{on: car.gradeLabel.length > 0}">{{car.gradeLabelDtl.length > 0 ? car.gradeLabelDtl : '등급'}}</span>
				<span ng-class="{on: car.carRegYear.length > 0}">{{car.carRegYearDtl.length > 0 ? car.carRegYearDtl : '연식'}}</span>
				<span ng-class="{on: car.missionLabel.length > 0}">{{car.missionLabelDtl.length > 0 ? car.missionLabelDtl : '변속기'}}</span>
				<span ng-class="{on: car.useKm.str.length > 0}">{{car.useKm.strDtl.length > 0 ? car.useKm.strDtl : '주행거리'}}</span>
				<span ng-class="{on: car.extLabel.length > 0}">{{car.extLabelDtl.length > 0 ? car.extLabelDtl : '외관상태'}}</span>
				<span ng-class="{on: car.colorLabel.length > 0}">{{car.colorLabelDtl.length > 0 ? car.colorLabelDtl : '색상'}}</span>
				<span ng-class="{on: car.optionCds.length > 0}">{{car.optionCdsDtl.length > 0 ? car.optionCdsDtl : '옵션'}}</span>
				<span ng-class="{on: car.carPlateNum.length > 0}">{{car.carPlateNumDtl.length > 0 ? car.carPlateNumDtl : '차량번호'}}</span>
			</div>
		</div>
		<!---->
		<div class="btn-accordion-wrapper writeType mb10" data-toggle-on="true">
			<!---->
			<dl class="btn-accordion-switch accordionSet" ng-class="{on: car.focus.makerCd}" ng-click="onToggle('ACCD_MAKER')">
				<dt class="accordionTitle btn-accordion-switch-item">
					<strong class="col">
						<span class="dotToggle" ng-class="{on: car.makerLabel.length > 0}" >제조사 <sup>필수항목</sup></span><!-- 2017-07-20 by mj-cho -->
					</strong>
					<span class="col">
						<span>{{car.makerLabel.length > 0 ? car.makerLabel : '제조사를 선택하세요'}}</span>
					</span>
				</dt>
				<dd class="accordionData">
					<ul class="radioList">		<!-- 제조사 -->
						<li ng-repeat="(key, value) in makerList">
							<input type="radio" id="r_a{{$index}}" name="r_a" ng-model="car.makerCd" value="{{key}}" ng-click="onClick('ACCD_MAKER', $event, value)"/><label for="r_a{{$index}}">{{value}}</label>
						</li>
					</ul>
				</dd>
			</dl>
			<!---->
			<dl class="btn-accordion-switch accordionSet" ng-class="{on: car.focus.modelCd}" ng-click="onToggle('ACCD_MODEL')">
				<dt class="accordionTitle btn-accordion-switch-item">
					<strong class="col">
						<span class="dotToggle" ng-class="{on: car.modelLabel.length > 0}">모델 <sup>필수항목</sup></span><!-- 2017-07-20 by mj-cho -->
					</strong>
					<span class="col">
						<span>{{car.modelLabel.length > 0 ? car.modelLabel : '모델을 선택하세요'}}</span>
					</span>
				</dt>
				<dd class="accordionData">
					<ul class="radioList">		<!-- 모델명 -->
						<li ng-repeat="(key, value) in carCodeSearchMap[car.makerCd]">
							<input type="radio" id="r_b{{$index}}" name="r_b" ng-model="car.modelCd" value="{{key}}" ng-click="onClick('ACCD_MODEL', $event, value)"><label for="r_b{{$index}}">{{value}}</label>
						</li>
					</ul>
				</dd>
			</dl>
			<!---->
			<dl class="btn-accordion-switch accordionSet" ng-class="{on: car.focus.modelDtlCd}" ng-click="onToggle('ACCD_DTL_MODEL')">
				<dt class="accordionTitle btn-accordion-switch-item">
					<strong class="col">
						<span class="dotToggle" ng-class="{on: car.modelDtlLabel.length > 0}">세부모델 <sup>필수항목</sup></span><!-- 2017-07-20 by mj-cho -->
					</strong>
					<span class="col">
						<span>{{car.modelDtlLabel.length > 0 ? car.modelDtlLabel : '세부모델을 선택하세요'}}</span>
					</span>
				</dt>
				<dd class="accordionData">
					<ul class="radioList">		<!-- 상세모델명 -->
						<li ng-repeat="(key, value) in carCodeSearchMap[car.modelCd]">
							<input type="radio" id="r_c{{$index}}" name="r_c" ng-model="car.modelDtlCd" value="{{key}}" ng-click="onClick('ACCD_DTL_MODEL', $event, value)"><label for="r_c{{$index}}">{{value}}</label>
						</li>
					</ul>
				</dd>
			</dl>
			<!---->
			<dl class="btn-accordion-switch accordionSet" ng-class="{on: car.focus.gradeCd}" ng-click="onToggle('ACCD_GRADE')">
				<dt class="accordionTitle btn-accordion-switch-item">
					<strong class="col">
						<span class="dotToggle" ng-class="{on: car.gradeLabel.length > 0}">등급 <sup>필수항목</sup></span><!-- 2017-07-20 by mj-cho -->
					</strong>
					<span class="col">
						<span>{{car.gradeLabel.length > 0 ? car.gradeLabel : '등급을 선택하세요'}}</span>
					</span>
				</dt>
				<dd class="accordionData">
					<ul class="radioList">		<!-- 등급 -->
						<li ng-repeat="(key, value) in carCodeSearchMap[car.modelDtlCd]">
							<input type="radio" id="r_ee{{$index}}" name="r_ee" ng-model="car.gradeCd" value="{{key}}" ng-click="onClick('ACCD_GRADE', $event, value)"><label for="r_ee{{$index}}">{{value}}</label>
						</li>
					</ul>
				</dd>
			</dl>
			<!---->
			<dl class="btn-accordion-switch accordionSet" ng-click="doFocus($event)">
				<dt class="accordionTitle btn-accordion-switch-item">
					<strong class="col">
						<span class="dotToggle" ng-class="{on: car.carRegYear.length > 0}" >연식 <sup>필수항목</sup></span><!-- 2017-07-20 by mj-cho -->
					</strong>
					<span class="col">
						<span>{{car.carRegYear.length > 0 ? car.carRegYear : '연식을 입력하세요 (YYYY)'}}</span>
					</span>
				</dt>
				<dd class="accordionData">		<!-- 연식 -->
					<div class="pt12"><input type="text" name="carRegYear" maxlength="4" ng-model="car.carRegYear" ng-blur="toggleChk('nonClick','ACCD_REG_YEAR', car.carRegYear, $event)"></div>
				</dd>
			</dl>
			<!---->
			<dl class="btn-accordion-switch accordionSet" ng-click="doFocus($event)">
				<dt class="accordionTitle btn-accordion-switch-item">
					<strong class="col">
						<span class="dotToggle" ng-class="{on: car.missionLabel.length > 0}">변속기 <sup>필수항목</sup></span><!-- 2017-07-20 by mj-cho -->
					</strong>
					<span class="col">
						<span>{{car.missionLabel.length > 0 ? car.missionLabel : '변속기를 선택하세요'}}</span>
					</span>
				</dt>
				<dd class="accordionData"><!-- 변속기 -->
					<ul class="radioList">
						<li ng-repeat="gearType in missionTypeCodeList">
							<input type="radio" id="r_e{{$index}}" name="r_e" value="{{gearType.cdDtlNo}}" ng-model="car.carMission" ng-click="onClick('ACCD_MISSION', $event, gearType.cdDtlNm)" >
							<label for="r_e{{$index}}">{{gearType.cdDtlNm}}</label>
						</li>
					</ul>
				</dd>
			</dl>
			<!---->
			<dl class="btn-accordion-switch accordionSet" ng-click="doFocus($event)">
				<dt class="accordionTitle btn-accordion-switch-item">
					<strong class="col">
						<span class="dotToggle" ng-class="{on: car.useKm.str.length > 0}">주행거리 <sup>필수항목</sup></span><!-- 2017-07-20 by mj-cho -->
					</strong>
					<span class="col">
						<span>{{car.useKm.str.length > 0 ? car.useKm.str + ' km' : '주행거리를 입력하세요'}}</span>
					</span>
				</dt>
				<dd class="accordionData">		<!-- 주행거리 -->
					<div class="pt12"><input type="text" name="useKm" ng-model="car.useKm.str" ng-blur="toggleChk('nonClick','ACCD_USEKM', car.useKm.str, $event)"></div>
				</dd>
			</dl>
			<!---->
			<dl class="btn-accordion-switch accordionSet" ng-click="doFocus($event)">
				<dt class="accordionTitle btn-accordion-switch-item">
					<strong class="col">
						<span class="dotToggle" ng-class="{on: car.extLabel.length > 0}">외관상태 <sup>필수항목</sup></span><!-- 2017-07-20 by mj-cho -->
					</strong>
					<span class="col">
						<span>{{car.extLabel.length > 0 ? car.extLabel : '외관상태를 선택하세요'}}</span>
					</span>
				</dt>
				<dd class="accordionData">
					<ul class="radioList">
						<li ng-repeat="carExtStatus in carExtStatusCodeList">
							<input type="radio" id="r_i{{$index}}" name="r_i" ng-model="car.surfaceState" value="{{carExtStatus.cdDtlNo}}" ng-click="onClick('ACCD_EXTERNAL', $event, carExtStatus.cdDtlNm)"/>
							<label for="r_i{{$index}}">{{carExtStatus.cdDtlNm}}</label>
						</li>
					</ul>
				</dd>
			</dl>
			<!---->
			<dl class="btn-accordion-switch accordionSet" ng-click="doFocus($event)">
				<dt class="accordionTitle btn-accordion-switch-item">
					<strong class="col">
						<span class="dotToggle" ng-class="{on: car.colorLabel.length > 0}">색상 <sup>필수항목</sup></span><!-- 2017-07-20 by mj-cho -->
					</strong>
					<span class="col">
						<span>{{car.colorLabel.length > 0 ? car.colorLabel : '색상을 선택하세요'}}</span>
					</span>
				</dt>
				<dd class="accordionData">
					<ul class="radioList">		<!-- 색상 -->
						<li ng-repeat="colorType in colorTypeCodeList">
							<input type="radio" id="r_f{{$index}}" name="r_f" ng-model="car.carColor" value="{{colorType.cdDtlNo}}" ng-click="onClick('ACCD_COLOR', $event, colorType.cdDtlNm)"/>
							<label for="r_f{{$index}}">{{colorType.cdDtlNm}}</label>
						</li>
					</ul>
				</dd>
			</dl>
			<!---->
			<dl class="btn-accordion-switch accordionSet" ng-click="doFocus($event)">
				<dt class="accordionTitle btn-accordion-switch-item">
					<strong class="col">
						<span class="dotToggle" ng-class="{on: car.optionCds.length > 0}">옵션</span>
					</strong>
					<span class="col">
						<span>{{car.optionCds.length > 0 ? '' : '옵션을 선택하세요'}}</span>
					</span>
				</dt>
				<dd class="accordionData optionArea">
					<strong ng-repeat-start="optionType in optionTypeCodeList">
						<span class="checkSet">
							<input id="opt{{$index}}" type="checkbox" ng-model="checkAll" ng-click="checkRender()"/>
							<label for="opt{{$index}}">{{optionType.cdDtlNm}}</label>
						</span>
					</strong>
					<div ng-repeat-end>
						<span class="checkSet" ng-if="optionType.cdSubNo === option.cdNo" ng-repeat="option in optionCodeList">
							<input type="checkbox" id="opt_c{{$index}}" value="{{option.cdDtlNo}}" ng-click="onClick('ACCD_OPTION', $event)" ng-checked="checkAll || optionChecked(option.cdDtlNo)"><label for="opt_c{{$index}}">{{option.cdDtlNm}}</label>
						</span>
					</div>
				</dd>
			</dl>
			<!---->
			<dl class="btn-accordion-switch accordionSet" ng-click="doFocus($event)">
				<dt class="accordionTitle btn-accordion-switch-item">
					<strong class="col">
						<span class="dotToggle" ng-class="{on: car.carPlateNum.length > 0}">차량번호 <sup>필수항목</sup></span><!-- 2017-07-20 by mj-cho -->
					</strong>
					<span class="col">
						<span>{{car.carPlateNum.length > 0? car.carPlateNum:'차량번호를 입력하세요'}}</span>
					</span>
				</dt>
				<dd class="accordionData">		<!-- 차량번호 -->
					<div class="pt12"><input type="text" name="carPlateNum" maxlength="10" ng-model="car.carPlateNum" ng-required="true"  ng-blur="toggleChk('nonClick','ACCD_PLATE_NUM', car.carPlateNum, $event)"/></div>
				</dd>
			</dl>
		</div>
		<div class="btnSet pt12">
			<span><button class="red viewCase" ng-click="regist(form)"><strong>내차시세보기</strong></button></span>
		</div>
	</div>
</section>