/**
 * 비용계산결과
 *
 * jj-choi
 * 
 **/

angular.module('bnk-common.directive')
.directive('costResultPop', function ($rootScope, $timeout) {
	
/* ####################################################################################	
 * ## 팝업 상수설정														  				 ##
 * #################################################################################### */

	var PARENT_ID = 'wrap_back';				// 고정 
	var TEMPLATE_ID = 'cost-result-pop';	// 변경 <= 팝업ID(폴더,파일명)

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
		controller: function($scope, $util, $http, $timeout){
			
			// 팝업 초기화
			$scope.$this = {};	// 팝업객체
			
			$scope.templateInit = function(){
				$scope.$this = ITCButton.initPopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'), 'full');
				ITCButton.setupTypePopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'));
				ITCButton.setupTypeAccordion();	//아코디언 초기화
				$scope.$this.onOpenHandle = function(){
					$scope.check = {};
					$scope.check.state = "";
					$scope.check.state = $scope.oParams.state;
					
					if($scope.check.state == "mycar" || $scope.check.state == "mycar1"){	// 비용계산 발송관리에서 넘어온경우
						$scope.open($scope.oParams);	
					}else{
						$scope.check.state = "cost";
						$scope.open1($scope.$parent.costParams);
					}
				};
				$rootScope.$broadcast(TEMPLATE_ID, {});
			};
			
			$scope.open = function(param){
				$scope.check.chkListSeq = param.chkListSeq;
				$scope.check.state = param.state;				
				$scope.searchDetail();
			}
			
			$scope.open1 = function(param){
				$scope.car = param;
            	$scope.car.cost.etcCostSum = new Money();		// 부대비용 합계
    			$scope.car.cost.moveCostSum = new Money();		// 이전비용 합계
    			$scope.car.cost.allSum = new Money();			// 전체 합계
    			$scope.car.cost.fundCost = new Money();			// 공채할인비
    			$scope.car.cost.regCost = new Money();			// 취등록세
				$http({
					method:'POST', 
					url:BNK_CTX + '/api/car/costResultSearch',
					data: JSON.stringify($scope.car)
			
	            }).success(function(data, status, headers, config){
	    			
	            	// 공채할인비
	            	$scope.car.cost.fundCost.set(data.cost.CAR_FUND_COST);
	            	// 취등록세
	            	$scope.car.cost.regCost.set(data.cost.CAR_REG_COST);
	            	
	            	var etcCostSum = Number($scope.car.carMortgage) + Number($scope.car.carRegAgency) + Number($scope.car.carManageCost);
	            	var moveCostSum = Number(data.cost.CAR_REG_COST) + Number(data.cost.CAR_FUND_COST) + Number($scope.car.carRecognition)+Number($scope.car.carStampCost)+Number($scope.car.carNumberCost);
	            	var allSum = Number($scope.car.carSalePrice) + etcCostSum + moveCostSum;

	            	$scope.car.cost.etcCostSum.set(etcCostSum);
	            	$scope.car.cost.moveCostSum.set(moveCostSum);
	            	$scope.car.cost.allSum.set(allSum);
	            	
	            }).error(function(data, status, headers, config) {
	            	
	            });
				
			}
			
			$scope.costSendClick = function(){
				// 푸시전송 하기전 어떤 화면에서 넘어왔는지 값을 전달한다.
				$("#type").val("B");			// B: 비용계산
				$scope.$parent.costParams = $scope.car;
				$scope.$parent.costParams.fundCost = $scope.car.cost.fundCost.val;
				$scope.$parent.costParams.regCost = $scope.car.cost.regCost.val;
				$scope.$parent.costParams.etcCostSum = $scope.car.cost.etcCostSum.val;
				$scope.$parent.costParams.moveCostSum = $scope.car.cost.moveCostSum.val;
				$scope.$parent.costParams.allSum = $scope.car.cost.allSum.val;
				
				ITCButton.getPopup('.popSend').init();
				ITCButton.getPopup('.popSend').open();
			}
			
			$scope.searchDetail = function(){
				$http({
		            url:  BNK_CTX + '/front/my/searchCostDeatil'
		            , method: 'POST'
		            , async: false
		            , headers: { 'Content-Type': 'application/json'}
	            	, data :JSON.stringify({costingSeq : $scope.check.chkListSeq})
		        }).success(function(data){
		        	console.log(JSON.stringify(data.getCostDetail));
		        	$scope.getCar = data.getCostDetail;
		        	$scope.setValue();
		        	
		        }).error(function(data, status, headers, config) {
		        });
			}
			
			$scope.setValue = function(){
				$scope.car = {}
				$scope.car.cost = {}
				$scope.car.cost.etcCostSum = new Money();		// 부대비용 합계
    			$scope.car.cost.moveCostSum = new Money();		// 이전비용 합계
    			$scope.car.cost.allSum = new Money();			// 전체 합계
    			$scope.car.cost.carStandTax = new Money();		// 과세표준
    			$scope.car.cost.carNewPrice = new Money();		// 신차가격
    			$scope.car.cost.carSalePrice = new Money();		// 구매가격
    			$scope.car.cost.fundCost = new Money();			// 공채할인비
    			$scope.car.cost.regCost = new Money();			// 취등록세
    			$scope.car.cost.carRecognition = new Money();	// 인지대
    			$scope.car.cost.carStampCost = new Money();		// 증지대
    			$scope.car.cost.carNumberCost = new Money();	// 번호판교체
    			$scope.car.cost.carMortgage = new Money();		// 저당비용
    			$scope.car.cost.carRegAgency = new Money();		// 등록대행료
    			$scope.car.cost.carManageCost = new Money();	// 관리비용
    			
    			$scope.car.userName = $scope.getCar.userName;
    			$scope.car.createdDate = $scope.getCar.createdDate;
				$scope.car.carPlateNum = $scope.getCar.carPlateNum;
				$scope.car.carMakerName = $scope.getCar.carMakerName;
				$scope.car.carModelName = $scope.getCar.carModelName;
				$scope.car.carRegyear = $scope.getCar.carRegyear;
				$scope.car.carNationName = $scope.getCar.carNationName;
				$scope.car.carCarkindName = $scope.getCar.carDivName;
				$scope.car.carRemainRate = $scope.getCar.carRemainRate;
				
				$scope.car.carRegAreaLabel = $scope.getCar.carRegAreaName;
				$scope.car.carUseLabel = $scope.getCar.carUseName;
				$scope.car.carDivLabel = $scope.getCar.carDivName;
				$scope.car.carDetailDivLabel = $scope.getCar.carDetailDivName;
				
				$scope.car.cost.etcCostSum.set($scope.getCar.etcCostSum);
				$scope.car.cost.moveCostSum.set($scope.getCar.moveCostSum);
				$scope.car.cost.allSum.set($scope.getCar.allSum);
				$scope.car.cost.carStandTax.set($scope.getCar.carStandTax);
				$scope.car.cost.carNewPrice.set($scope.getCar.carNewPrice);
				$scope.car.cost.carSalePrice.set($scope.getCar.carSalePrice);
				$scope.car.cost.fundCost.set($scope.getCar.fundCost);
				$scope.car.cost.regCost.set($scope.getCar.regCost);
				$scope.car.cost.carRecognition.set($scope.getCar.carRecognition);
				$scope.car.cost.carStampCost.set($scope.getCar.carStampCost);
				$scope.car.cost.carNumberCost.set($scope.getCar.carNumberCost);
				$scope.car.cost.carMortgage.set($scope.getCar.carMortgage);
				$scope.car.cost.carRegAgency.set($scope.getCar.carRegAgency);
				$scope.car.cost.carManageCost.set($scope.getCar.carManageCost);
			}
			
			
			
			$scope.onClose = function(){
				// callback function 
				$scope.onLoadCallback({ 'id': TEMPLATE_ID, 'data': {} });
			};
		}
	};
});

