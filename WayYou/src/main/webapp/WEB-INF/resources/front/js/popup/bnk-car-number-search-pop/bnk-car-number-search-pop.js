/**
 * 실매물체크
 *
 * jj-choi
 * 
 **/

angular.module('bnk-common.directive')
.directive('carNumberSearchPop', function ($rootScope, $timeout) {
	
/* ####################################################################################	
 * ## 팝업 상수설정														  				 ##
 * #################################################################################### */

	var PARENT_ID = 'wrap_back';				// 고정 
	var TEMPLATE_ID = 'car-number-search-pop';	// 변경 <= 팝업ID(폴더,파일명)

/* #################################################################################### */	
	
	$timeout(function(){ 
		ITCButton.setupTypePopup();		// 팝업 설정
	},500);
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
		controller: function($scope, $http){
			
			// 팝업 초기화
			$scope.$this = {};	// 팝업객체
			$scope.templateInit = function(){
				$scope.$this = ITCButton.initPopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'), 'full');
				ITCButton.setupTypePopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'));
				$rootScope.$broadcast(TEMPLATE_ID, {});
			};
			
			$scope.car = {};
			$scope.car.carUsekm = new Money();
			
			$scope.carSearchClick = function(){
				var searchTxt = $.trim($("#searchCarTxt").val());
				
				if(searchTxt == ""){
					$("#searchCarTxt").focus();
					alert("차량번호를 입력하세요.");
					return;
				}
				
				$http({
					method:'POST', 
					url:BNK_CTX + '/api/car/carNumSearch',
					params: {"carPlateNum": searchTxt}
			
	            }).success(function(data, status, headers, config){
	            	if(data.code == "99"){					// 차량정보가 없을때
	            		$(".carInfo").hide();
	            		$(".infotxt").show();
	            		alert("차량정보가 없습니다.");
	            		return;
	            		
	            	}
	            	$(".infotxt").hide();
	            	$(".carInfo").show();
	            	
	            	$scope.car.carPlateNum = searchTxt;						// 차량번호
	            	$scope.car.carRegyear = data.cost.carRegyear;			// 연식
	            	$scope.car.carUsekm.set(data.cost.carUsekm);			// 주행거리
	            	$scope.car.carNiceMission = data.cost.carNiceMission;	// 변속기
	            	$scope.car.carNiceFuel = data.cost.carNiceFuel;			// 연료
	            	$scope.car.carColor = data.cost.carColor;				// 색상
	            	$scope.car.userName = data.cost.userName;				// 판매자명
	            	$scope.car.danjiSido = data.cost.danjiSido;				// 단지지역
	            	$scope.car.danjiFullName = data.cost.danjiFullName;		// 단지명
	            	
	            }).error(function(data, status, headers, config) {
	            	
	            });
			}
			
			$scope.onClose = function(){
				// callback function 
				$scope.onLoadCallback({ 'id': TEMPLATE_ID, 'data': {} });
			};
		}
	};
});

