/**
 * 딜러 종사자번호 변경
 *
 * yj-kim
 * 
 **/
angular.module('bnk-common.directive')
.directive('dealerNoChangePop', function ($rootScope,$timeout,$http) {
	
/* ####################################################################################	
 * ## 팝업 상수설정														  				 ##
 * #################################################################################### */

	var PARENT_ID = 'wrap_back';				// 고정 
	var TEMPLATE_ID = 'dealer-no-change-pop';	// 변경 <= 팝업ID(폴더,파일명)

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
		controller: function($scope,$util){
			
		/* ####################################################################################	
		 * ## 멤버 초기값 설정													  				 ##
		 * #################################################################################### */
			
			// 팝업 초기화
			$scope.$this = {};	// 팝업객체
			$scope.templateInit = function(){
				$scope.$this = ITCButton.initPopup(angular.element('#'+TEMPLATE_ID).find('.popWrapPwChange2'), 'full');
				ITCButton.setupTypePopup(angular.element('#'+TEMPLATE_ID).find('.popWrapPwChange2'));
				$rootScope.$broadcast(TEMPLATE_ID, {});
			};
			
			$scope.dealerNo = {};
			$scope.dno = {};
				
		/* #################################################################################### */
			
			
			
		/* ####################################################################################	
		 * ## 이벤트 설정													  				 	 ##
		 * #################################################################################### */
			
			$scope.onCompleteF = function(){
				// callback function 
				$scope.onLoadCallback({ 'id': TEMPLATE_ID, 'data': angular.copy($scope.dealerNo) });
				$scope.$this.close();
			};
			
		/* #################################################################################### */
			
			//종사자번호 변경
			$scope.chkDealerNo = function(){
				$scope.dno.dealerNoCurrent = $scope.dno.dealerNoCurrent;
				$scope.dno.dealerNo        = $scope.dno.dealerNo;
				$scope.dno.dealerNoChk     = $scope.dno.dealerNoChk;
				$scope.userId              = angular.element("#userUpdForm input[name=userId]").val();
				$scope.userName            = angular.element("#userUpdForm input[name=userName]").val();
				
				//종사자번호 변경 시 유효성 체크
				if($util.isEmpty($scope.dno.dealerNoCurrent)){
					alert("현재 종사자번호는 필수 입력입니다.");
					return false;
				}
				if($util.isEmpty($scope.dno.dealerNo)){
					alert("새로운 종사자번호는 필수 입력입니다.");
					return false;
				}
				if($util.isEmpty($scope.dno.dealerNoChk)){
					alert("새로운 종사자번호 확인은 필수 입력입니다.");
					return false;
				}
				if($scope.dno.dealerNo != $scope.dno.dealerNoChk){
					alert("입력하신 종사자번호가 일치하지 않습니다.");
					return;
				}
				
				var params={
						dealerNoCurrent : $scope.dno.dealerNoCurrent,
						dealerLicenseNo : $scope.dno.dealerNo, 
						userId          : $scope.userId,
						userName        : $scope.userName
			    	};
				var url = BNK_CTX + '/front/common/changeDealerNo';
				$http({
					url: url
					, method: 'POST'
					, async: false
					, headers: { 'Content-Type': 'application/json'}
					, data :JSON.stringify(params)
				}).success(function(data, status, headers, config){
					if(data.rsltDealer == 'N'){
						$scope.dno.dealerNoCurrent 	= "";
						$scope.dno.dealerNo 		= "";
						$scope.dno.dealerNoChk 		= "";
						alert("유효하지않은 종사자번호 입니다.");
						return false;
					}
					if(data.chkDealer == '1'){
						$scope.dno.dealerNoCurrent 	= "";
						$scope.dno.dealerNo 		= "";
						$scope.dno.dealerNoChk 		= "";
						alert("이미 등록 된 종사자번호 입니다.");
						return false;
					}
					if(data.resCd == '99'){
						$scope.dno.dealerNoCurrent 	= "";
						$scope.dno.dealerNo 		= "";
						$scope.dno.dealerNoChk 		= "";
						alert("입력하신 종사자번호가 현재 종사자번호와 다릅니다.");
						return false;
					}
					if(data.resCd == '00'){
						alert("종사자번호가 변경되었습니다.");
						$scope.dno.dealerNoCurrent 	= "";
						$scope.dno.dealerNo 		= "";
						$scope.dno.dealerNoChk 		= "";
						ITCButton.closePopup();
					}
				}).error(function(data, status, headers, config) {
				});
				
				
			}
			
		}
	};
});

