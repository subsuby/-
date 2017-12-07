/**
 * 비용계산기 입력
 *
 * jj-choi
 *
 **/

angular.module('bnk-common.directive')
.directive('costPop', function ($rootScope, $timeout) {

/* ####################################################################################
 * ## 팝업 상수설정														  				 ##
 * #################################################################################### */

	var PARENT_ID = 'wrap_back';				// 고정
	var TEMPLATE_ID = 'cost-pop';	// 변경 <= 팝업ID(폴더,파일명)

/* #################################################################################### */

	return {

		/* [scope 옵션]
		 * 	 - scope : false -> 새로운 scope 객체를 생성하지 않고 부모가 가진 같은 scope 객체를 공유. (default 옵션)
		 * 	 - scope : true -> 새로운 scope 객체를 생성하고 부모 scope 객체를 상속.
		 * [binding 옵션]
		 *   - = : 부모 scope의 property와 디렉티브의 property를 data binding하여 부모 scope에 접근
		 *   - @ : 디렉티브의 attribute value를 {{}}방식(interpolation)을 이용해 부모 scope에 접근
		 *   - & : Two-way Binding 없이 각 Directive에서 사용하는 데이터를 상위 스코프로 전달할 수 있다.
		 */
		scope: {
			oParams: '=params',
			onLoadCallback: '&onLoadCallback'
		},
		restrict: 'E',		// E : elements, A : attributes, C : class name (CSS), M : comments
		replace: true, 		// directive를 설정한 태그를 템플릿 태그로 교체하고자 할때 따라서 template 또는 templateUrl과 함께 사용한다
//		transclude: false,	// ngTransclude를 통하여 DOM에 transcluded DOM을 insert 할 수 있다
//							// transcluded DOM을 template에서 ngTransclude directive에 삽입한다
		link: function(scope, element, attrs) {
			scope.contentUrl = BNK_CTX + '/front/js/popup/bnk-'+ TEMPLATE_ID +'/bnk-'+ TEMPLATE_ID +'-template.html';
	       },
		template: '<div id="'+TEMPLATE_ID+'" ng-include="contentUrl"></div>',
		controller: function($scope, $util, $http, $localstorage){

			// 팝업 초기화
			$scope.$this = {};	// 팝업객체
			$scope.templateInit = function(){
				$scope.$this = ITCButton.initPopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'), 'full');
				ITCButton.setupTypePopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'));
				ITCButton.setupTypeAccordion();	//아코디언 초기화
				$scope.initCost();
				$rootScope.$broadcast(TEMPLATE_ID, {});
			};

			$scope.$parent.costParams = {};
			$scope.car = {};
			$scope.car.cost = {};
			$scope.car.cost.carStandTax = new Money();			// 과세표준(콤마)
			$scope.car.cost.carStandTax1 = new Money();			// 과세표준1(콤마)
			$scope.car.cost.carNewPrice = new Money();			// 신차가격(콤마)
			$scope.car.cost.carSalePrice = new Money();			// 구매금액(콤마)
			$scope.car.cost.carMortgage = new Money();			// 저당비용(콤마)
			$scope.car.cost.carRegAgency = new Money();			// 등록대행료(콤마)
			$scope.car.cost.carManageCost = new Money();		// 관리비용(콤마)
			$scope.car.cost.carRecognition = new Money();		// 인지대(콤마)
			$scope.car.cost.carStampCost = new Money();		// 증지대(콤마)
			$scope.car.cost.carNumberCost = new Money();		// 번호판교체비용(콤마)

			regAreaCodeCommList = [];
			carUseDivCodeCommList = [];
			carDivCodeCommList = [];
			carDetailDivCodeCommList = [];


			$scope.$on('onCodeReady', function (event, data) {
				//코드 초기화 [S]
				$scope.regAreaCodeCommList		=	regAreaCodeCommList;
				$scope.carUseDivCodeCommList	=	carUseDivCodeCommList;
				$scope.carDivCodeCommList		=	carDivCodeCommList;
				$scope.carDetailDivCodeCommList	=	carDetailDivCodeCommList;

			});


			$scope.searchClick = function(){
				$scope.initCost();

				var carPlateNum = $.trim($("#carPlateNum").val());
				if(carPlateNum == ""){
					alert("차량번호를 입력해주세요.");
					$("#carPlateNum").focus();
					return;
				}

				$http({
						method:'POST',
						url:BNK_CTX + '/api/car/costSearch',
						params: {"carPlateNum": carPlateNum}

	            }).success(function(data, status, headers, config){
	            	if(data.code == "99"){					// 차량정보가 없을때
	            		alert("차량정보가 없습니다.");
	            		return;
	            	}

	            	$scope.car.carFullCode = data.cost.carFullCode;						// 차량풀코드
	            	$scope.car.carMakerName = data.cost.carMakerName;					// 제조사
	            	$scope.car.carModelName = data.cost.carModelName;					// 모델
	            	$scope.car.carModelDetailName = data.cost.carModelDetailName;		// 상세모델
	            	$scope.car.carGradeName = data.cost.carGradeName;					// 등급
	            	$scope.car.carNationName = data.cost.carNationName;					// 국산수입구분(이름)
	            	$scope.car.carRegyear = data.cost.carRegyear;						// 연식
	            	$scope.car.carFuelName = data.cost.carFuelName;						// 연료(이름:한글) -ex :경유
	            	$scope.car.carFuelCode = data.cost.carFuelCode;						// 연료(코드)
	            	$scope.car.carNiceFuel = data.cost.carNiceFuel;						// 연료(이름:영문) -ex :디젤
	            	$scope.car.carCarkindName = data.cost.carCarkindName;				// 차종구분
	            	$scope.car.carRemainRate = data.cost.carRemainRate;					// 잔존율

	            	$scope.car.cost.carStandTax.set(data.cost.carStandTax);					// 과세표준
	            	$scope.car.cost.carStandTax1.set(data.cost.carStandTax);					// 과세표준 상단(값이 변하지 않게 하기위해)
	            	$scope.car.cost.carNewPrice.set(data.cost.carNewPrice);					// 신차가격
	            	$scope.car.cost.carSalePrice.set($util.ceil(data.cost.carStandTax,4));	// 차량구매가격

	            	$scope.car.cost.carMortgage.set(0);
	            	$scope.car.cost.carRegAgency.set(0);
	            	$scope.car.cost.carManageCost.set(0);
	            	$scope.car.cost.carRecognition.set(0);
	            	$scope.car.cost.carStampCost.set(0);
	            	$scope.car.cost.carNumberCost.set(0);

	            }).error(function(data, status, headers, config) {

	            });
			}

			$scope.initCost = function(){
				$scope.car.carFullCode = "";
				$scope.car.carMakerName = "";
        		$scope.car.carModelName = "";
        		$scope.car.carRegyear = "";
        		$scope.car.carNationName = "";
        		$scope.car.carCarkindName = "";
        		$scope.car.carRemainRate = "";
        		$scope.car.cost.carStandTax.str = "";
        		$scope.car.cost.carStandTax1.str = "";
        		$scope.car.cost.carNewPrice.str = "";
        		$scope.car.cost.carSalePrice.str = "";
        		$scope.car.cost.carMortgage.str = "";
        		$scope.car.cost.carRegAgency.str = "";
        		$scope.car.cost.carManageCost.str = "";
        		$scope.car.cost.carRecognition.str = "";
        		$scope.car.cost.carStampCost.str = "";
        		$scope.car.cost.carNumberCost.str = "";

        		$scope.car.carRegAreaLabel = "";
        		$scope.car.carRegArea = "";
        		$scope.car.carUseLabel = "";
        		$scope.car.carUse = "";
        		$scope.car.carDivLabel = "";
        		$scope.car.carDiv = "";
        		$scope.car.carDetailDivLabel = "";
        		$scope.car.carDetailDiv = "";
			}

			//Watch 초기화 [S]
			$scope.$parent.evtSetComma($scope,watchMoney);
			function watchMoney(s,o) {	// s:Watch String, o:Money Object
				//console.log(s,o);
				$scope.$watch(s, function (nv, ov, scope) { o.set(nv); }, true);
			}

			//아코디언 특정 행 클릭시 이벤트 처리
			$scope.onClick=function(code, $event, label){
				if ($event.stopPropagation) $event.stopPropagation();		//이벤트 버블링 해제
				switch(code){
				case "REG_AREA":
					$scope.car.carRegAreaLabel=label;
					break;
				case "USE":
					$scope.car.carUseLabel=label;
					break;
				case "DIV":
					$scope.car.carDivLabel=label;
					break;
				case "DETAIL_DIV":
					$scope.car.carDetailDivLabel=label;
					break;
				}
			}

			$scope.doFocus=function($event){
				if ($event.stopPropagation) $event.stopPropagation();		//이벤트 버블링 해제
				var $dl = $($event.target).closest('dl');
				$dl.find('.accordionData input[type=text],textarea,input[type=radio]:eq(0)').focus();
			}

			$scope.costClick = function(){
				if(!$scope.car.carFullCode){
		    		alert('차량번호로 검색을 먼저 해주세요.');
		    		$('#carPlateNum').closest('.accordionSet').addClass('on').find('#carPlateNum').focus();
		    		return;
		    	}
				if(!$scope.car.cost.carNewPrice.str){
		    		alert('신차가격은 필수 값입니다.');
		    		$('input[name=newPrice]').closest('.accordionSet').addClass('on').find('input[name=newPrice]').focus();
		    		return;
		    	}
				if(!$scope.car.cost.carStandTax.str){
		    		alert('과세표준은 필수 값입니다.');
		    		$('input[name=standTax]').closest('.accordionSet').addClass('on').find('input[name=standTax]').focus();
		    		return;
		    	}
				if(!$scope.car.cost.carSalePrice.str){
		    		alert('차량구매가격은 필수 값입니다.');
		    		$('input[name=salePrice]').closest('.accordionSet').addClass('on').find('input[name=salePrice]').focus();
		    		return;
		    	}
				if(!$scope.car.carRegArea){
		    		alert('등록지역은 필수 값입니다.');
		    		$('input[name=a1_c]').closest('.accordionSet').addClass('on').find('#a1_c0').focus();
		    		return;
		    	}
				if(!$scope.car.carUse){
		    		alert('용도구분은 필수 값입니다.');
		    		$('input[name=a2_c]').closest('.accordionSet').addClass('on').find('#a2_c0').focus();
		    		return;
		    	}
				if(!$scope.car.carDiv){
		    		alert('차종구분은 필수 값입니다.');
		    		$('input[name=a3_c]').closest('.accordionSet').addClass('on').find('#a3_c0').focus();
		    		return;
		    	}
				if(!$scope.car.carDetailDiv){
		    		alert('상세차량구분은 필수 값입니다.');
		    		$('input[name=a4_c]').closest('.accordionSet').addClass('on').find('#a4_c0').focus();
		    		return;
		    	}
				if(!$scope.car.cost.carMortgage.str){
		    		alert('저당비용은 필수 값입니다.');
		    		$('input[name=mortgage]').closest('.accordionSet').addClass('on').find('input[name=mortgage]').focus();
		    		return;
		    	}
				if(!$scope.car.cost.carRegAgency.str){
		    		alert('등록대행료는 필수 값입니다.');
		    		$('input[name=regAgency]').closest('.accordionSet').addClass('on').find('input[name=regAgency]').focus();
		    		return;
		    	}
				if(!$scope.car.cost.carManageCost.str){
		    		alert('관리비용은 필수 값입니다.');
		    		$('input[name=manageCost]').closest('.accordionSet').addClass('on').find('input[name=manageCost]').focus();
		    		return;
		    	}
				if(!$scope.car.cost.carManageCost.str){
		    		alert('인지대는 필수 값입니다.');
		    		$('input[name=recognition]').closest('.accordionSet').addClass('on').find('input[name=recognition]').focus();
		    		return;
		    	}
				if(!$scope.car.cost.carManageCost.str){
		    		alert('증지대는 필수 값입니다.');
		    		$('input[name=stampCost]').closest('.accordionSet').addClass('on').find('input[name=stampCost]').focus();
		    		return;
		    	}
				if(!$scope.car.cost.carManageCost.str){
		    		alert('번호판등록비용은 필수 값입니다.');
		    		$('input[name=numberCost]').closest('.accordionSet').addClass('on').find('input[name=numberCost]').focus();
		    		return;
		    	}

				$scope.car.carPlateNum = $("#carPlateNum").val();

				$scope.car.carNewPrice	= $scope.car.cost.carNewPrice.val +"";
				$scope.car.carStandTax	= $scope.car.cost.carStandTax.val +"";
				$scope.car.carSalePrice	= $scope.car.cost.carSalePrice.val +"";
				$scope.car.carMortgage	= $scope.car.cost.carMortgage.val +"";
				$scope.car.carRegAgency	= $scope.car.cost.carRegAgency.val +"";
				$scope.car.carManageCost= $scope.car.cost.carManageCost.val +"";
				$scope.car.carRecognition= $scope.car.cost.carRecognition.val +"";
				$scope.car.carStampCost= $scope.car.cost.carStampCost.val +"";
				$scope.car.carNumberCost= $scope.car.cost.carNumberCost.val +"";
				$scope.car.state = "cost";

				$scope.$parent.costParams = $scope.car;

				ITCButton.getPopup('.popWrapCost2').init();
				ITCButton.getPopup('.popWrapCost2').open();
			}

			$scope.onClose = function(){
				// callback function
				$scope.onLoadCallback({ 'id': TEMPLATE_ID, 'data': {} });
			};

		}
	};
});

