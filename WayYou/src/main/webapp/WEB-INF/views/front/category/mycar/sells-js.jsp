<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script>

bnkApp.controller(CTRL_NAME, ['$scope', '$http', '$filter', '$util', '$localstorage', function($scope, $http, $filter, $util, $localstorage){
	//ITCommons.button().setupTypeAccordion();		//아코디언 초기화
	$scope.$on('onCodeReady', function (event, data) {
		//코드 초기화 [S]
		$scope.optionTypeCodeList	=	optionTypeCodeList;			//옵션코드
		$scope.optionCodeList = [].concat(
				optionBasicCodeList
				, optionExternalCodeList
				, optionInternalCodeList
				, optionConvenienceCodeList
				, optionSafetyCodeList
				, optionMediaCodeList

		);	//옵션 코드 리스트(주요,외장,내장,편의,안전,미디어)

		$scope.fuelTypeCodeList		=	fuelTypeCodeList;
		$scope.missionTypeCodeList	=	missionTypeCodeList;
		$scope.colorTypeCodeList	=	colorTypeCodeList;
		$scope.carStatusCodeList	=	carStatusCodeList;
		$scope.carExtStatusCodeList	=	carExtStatusCodeList;
		$scope.carAccStatusCodeList	=	carAccStatusCodeList;
		$scope.carRentStatusCodeList=	carRentStatusCodeList;
		$scope.optionDefaultCodeList=	optionDefaultCodeList;

		$scope.carCodeSearchMap = carCodeSearchMap;
		$scope.makerList = carCodeSearchMap["makerList"];
	});

	$scope.optionChecked = function(code){
		var optionCds = $util.isNotEmpty($scope.car) ? $scope.car.optionCds : [];
		var option = '';
		if(angular.isArray(optionCds)){
			option = optionCds.find(function(optionCd){ return code == optionCd; });
		}
		return $util.isNotEmpty(option);
	}

	//코드 초기화 [E]

	//Form Data 초기화 [S]
	$scope.car={};

	$scope.car.carPlateNum='';			//차량번호
	$scope.car.carFullCode='';			//차량코드(제조사,모델,세부모델,등급 포함)
	$scope.car.carRegYear='';			//연식
	$scope.car.carMission='';			//변속기
	$scope.car.useKm=new Money();		//주행거리
	$scope.car.surfaceState='';			//외관상태
	$scope.car.carColor='';				//색상
	$scope.car.optionCdsArr=[];			//옵션코드리스트
	//form Data 초기화 [E]


	//CAR LABEL [S]
	$scope.car.makerLabel='';
	$scope.car.modelLabel='';
	$scope.car.modelDtlLabel='';
	$scope.car.gradeLabel='';
	$scope.car.colorLabel='';
	$scope.car.missionLabel='';
	$scope.car.extLabel='';
	//CAR LABEL [E]

	//CAR LABEL [S] 상단에 간략하게 보여줄 라벨
	$scope.car.makerLabelDtl='';		// 제조사
	$scope.car.modelLabelDtl='';		// 모델
	$scope.car.modelDtlLabelDtl='';		// 세부모델
	$scope.car.gradeLabelDtl='';		// 등급
	$scope.car.carRegYearDtl='';		// 연식
	$scope.car.missionLabelDtl='';		// 변속기
	$scope.car.useKm.strDtl='';			// 주행거리
	$scope.car.extLabelDtl='';			// 외관상태
	$scope.car.colorLabelDtl='';		// 색상
	$scope.car.optionCdsDtl='';			// 옵션
	$scope.car.carPlateNumDtl='';		// 차량번호
	//CAR LABEL [E]

	//CAR CONTROL OBJECT [S]
	$scope.car.focus={};
	$scope.car.focus.makerCd=false;
	$scope.car.focus.modelCd=false;
	$scope.car.focus.modelDtlCd=false;
	$scope.car.focus.gradeCd=false;
	//CAR CONTROL OBJECT [E]


	//Watch 초기화 [S]
	$scope.$parent.evtSetComma($scope,watchMoney);
	function watchMoney(s,o) {	// s:Watch String, o:Money Object
		console.log(s,o);
		$scope.$watch(s, function (nv, ov, scope) { o.set(nv); }, true);
	}

	// 연식
	$scope.$watch('car.carRegYear', function (nv, ov, scope) {
		scope.car.carRegYear = nv.replace(/[^0-9]/gi,'');	// 숫자만 입력
	});
	//Watch 초기화 [E]

	//아코디언 토글상태값 초기화(제조사,모델,세부모델, 등급)
	$scope.car.focus.resetToggle=function(){
		$scope.car.focus.makerCd=false;
		$scope.car.focus.modelCd=false;
		$scope.car.focus.modelDtlCd=false;
		$scope.car.focus.gradeCd=false;
	}

	// 체크박스 색변경
	$scope.checkRender = function(){
    	$scope.car.optionCds =	$('input[id*="c_c"]:checked').map(function(){ return this.value; }).get().join();
    }

	//아코디언 토글 on / off
	$scope.onToggle=function(code, $event){
		switch(code){
		case "ACCD_MAKER":
			$scope.car.focus.resetToggle();
		    $scope.car.focus.makerCd=!$scope.car.focus.makerCd;
			break;
		case "ACCD_MODEL":
			$scope.car.focus.resetToggle();
			$scope.car.focus.modelCd=!$scope.car.focus.modelCd;
			break;
		case "ACCD_DTL_MODEL":
			$scope.car.focus.resetToggle();
			$scope.car.focus.modelDtlCd=!$scope.car.focus.modelDtlCd;
			break;
		case "ACCD_GRADE":
			$scope.car.focus.resetToggle();
			$scope.car.focus.gradeCd=!$scope.car.focus.gradeCd;
			break;
		}
	}
	//아코디언 특정 행 클릭시 이벤트 처리
	$scope.onClick=function(code, $event, label){
		if ($event.stopPropagation) $event.stopPropagation();		//이벤트 버블링 해제
		switch(code){
			case "ACCD_MAKER":
				$scope.car.makerLabel=label;
				$scope.car.modelLabel='';
				$scope.car.modelDtlLabel='';
				$scope.car.gradeLabel='';
				$scope.car.focus.makerCd=false;
				$scope.car.focus.modelCd=true;
				$scope.car.focus.modelDtlCd=false;
				$scope.car.focus.gradeCd=false;
				$scope.car.modelCd='';
				$scope.car.modelDtlCd='';
				$scope.car.gradeCd='';
				break;
			case "ACCD_MODEL":
				$scope.car.modelLabel=label;
				$scope.car.modelDtlLabel='';
				$scope.car.gradeLabel='';
				$scope.car.focus.makerCd=false;
				$scope.car.focus.modelCd=false;
				$scope.car.focus.modelDtlCd=true;
				$scope.car.focus.gradeCd=false;
				$scope.car.modelDtlCd='';
				$scope.car.gradeCd='';
				break;
			case "ACCD_DTL_MODEL":
				$scope.car.modelDtlLabel=label;
				$scope.car.gradeLabel='';
				$scope.car.focus.makerCd=false;
				$scope.car.focus.modelCd=false;
				$scope.car.focus.modelDtlCd=false;
				$scope.car.focus.gradeCd=true;
				$scope.car.gradeCd='';
				break;
			case "ACCD_GRADE":
				$scope.car.gradeLabel=label;
				$scope.car.focus.makerCd=false;
				$scope.car.focus.modelCd=false;
				$scope.car.focus.modelDtlCd=false;
				$scope.car.focus.gradeCd=false;
				//gradeCd 선택시에는 차량코드10자리가 반환되기때문에 여기서 form data를 입력해야한다.
				$scope.car.carFullCode=$scope.car.gradeCd;
				break;
			case "ACCD_MISSION":
				$scope.car.missionLabel=label;
				break;
			case "ACCD_EXTERNAL":
				$scope.car.extLabel=label;
				break;
			case "ACCD_COLOR":
				$scope.car.colorLabel=label;
				break;
			case "ACCD_OPTION":
				$scope.car.optionCds = $('input[id*="c_c"]:checked').map(function(){ return this.value; }).get().join();
				break;
		}
		// 클릭함수 이후에 선택한 값이 있는지 확인하는 함수 호출
		$scope.toggleChk('click', code, label,  $event);
	}
	//아코디언 클릭한 인풋 자동 포커싱
	$scope.doFocus=function($event){
		if ($event.stopPropagation) $event.stopPropagation();		//이벤트 버블링 해제
		var $dl = $($event.target).closest('dl');
		$dl.find('.accordionData input[type=text],textarea,input[type=radio]:eq(0)').focus();
	}
	// 선택한 값이 있는지 체크하는 함수(클릭여부, 코드, 라벨, 이벤트)
	$scope.toggleChk = function(state, code, label, $event){		// 직접 입력한 경우 호출되는 함수
		if ($event.stopPropagation) $event.stopPropagation();		// 이벤트 버블링 해제

		var totToggleLength = $(".dotToggle.on").length;			// 선택한 개수 확인
		if(state == "click"){
			totToggleLength = totToggleLength +1;
		}

		if(totToggleLength > 0){
			$(".priceBefore").hide();	// 상단에 글씨영역 숨긴다.
			$(".priceStep").show();		// 옵션 영역을 보여준다.

			if(typeof label !== 'undefined'){
				if(label.length > 5){
					label = label.replace(',','');
					label = label.substring(0,4)+'..';
				}
			}

			switch(code){
				case "ACCD_MAKER":
					$scope.car.makerLabelDtl=label;
					break;
				case "ACCD_MODEL":
					$scope.car.modelLabelDtl=label;
					break;
				case "ACCD_DTL_MODEL":
					$scope.car.modelDtlLabelDtl=label;
					break;
				case "ACCD_GRADE":
					$scope.car.gradeLabelDtl=label;
					break;
				case "ACCD_REG_YEAR":
					$scope.car.carRegYearDtl=label;
					break;
				case "ACCD_MISSION":
					$scope.car.missionLabelDtl=label;
					break;
				case "ACCD_USEKM":
					$scope.car.useKm.strDtl=label;
					break;
				case "ACCD_EXTERNAL":
					$scope.car.extLabelDtl=label;
					break;
				case "ACCD_COLOR":
					$scope.car.colorLabelDtl=label;
					break;
				case "ACCD_OPTION":
					$scope.car.optionCdsDtl=label;
					break;
				case "ACCD_PLATE_NUM":
					$scope.car.carPlateNumDtl=label;
					break;
				}
		}else{
			$(".priceBefore").show();
			$(".priceStep").hide();
		}
	};

	//매물 등록 [S]
    $scope.regist = function(form){
    	$('.accordionSet').removeClass('on');

    	//유효성체크 [S]
    	if(!$scope.car.makerCd){
    		alertify.alert('제조사는 필수 값입니다.');
    		$('input[name=r_a]').closest('.accordionSet').addClass('on').find('#r_a0').focus();
    		return;
    	}
    	if(!$scope.car.modelCd){
    		alertify.alert('모델은 필수 값입니다.');
    		$('input[name=r_b]').closest('.accordionSet').addClass('on').find('#r_b0').focus();
    		return;
    	}
    	if(!$scope.car.modelDtlCd){
    		alertify.alert('세부모델은 필수 값입니다.');
    		$('input[name=r_c]').closest('.accordionSet').addClass('on').find('#r_c0').focus();
    		return;
    	}
    	if(!$scope.car.gradeCd){
    		alertify.alert('등급은 필수 값입니다.');
    		$('input[name=r_ee]').closest('.accordionSet').addClass('on').find('#r_ee0').focus();
    		return;
    	}
    	if(!$scope.car.carRegYear){
    		alertify.alert('연식은 필수 값입니다.');
    		$('input[name=carRegYear]').closest('.accordionSet').addClass('on').find('input[name=carRegYear]').focus();
    		return;
    	}
    	if(!$scope.car.carMission){
    		alertify.alert('변속기는 필수 값입니다.');
    		$('input[name=r_e]').closest('.accordionSet').addClass('on').find('#r_e0').focus();
    		return;
    	}
    	if(!$scope.car.carPlateNum){
    		alertify.alert('차량번호는 필수 값입니다.');
    		$('input[name=carPlateNum]').closest('.accordionSet').addClass('on').find('input[name=carPlateNum]').focus();
    		return;
    	}


    	var carPlateNum = $('input[name=carPlateNum]').val();		//차량번호

    	//차량번호 형식 체크
    	var regPlate = /^[0-9]{2}[\s]*[가-힣]{1}[\s]*[0-9]{4}/gi;
    	if(carPlateNum.length == 7){
			if(!regPlate.test(carPlateNum)){
				alertify.alert("잘못된 차량번호 형식입니다.");
				$('input[name=carPlateNum]').closest('.accordionSet').addClass('on').find('input[name=carPlateNum]').focus();
				return;
			}
		}
    	//유효성체크 [E]

    	var params={};
    	var url = '<c:url value="/front/category/mycar/sellsResult"/>';
    	angular.extend(params, $scope.car);
    	//params.division		=	'car';
    	params.useKm		=	$scope.car.useKm.val+"";
    	//$("#car").val(JSON.stringify(params));
    	// 내차팔기정보 로컬스토리지 저장
		$localstorage.set('tempParams', {oCar: JSON.stringify(params)});

    	location.href = url;
    }
    //매물 등록 [E]
}]);

</script>