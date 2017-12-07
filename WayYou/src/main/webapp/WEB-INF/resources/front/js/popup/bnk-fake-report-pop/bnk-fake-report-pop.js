/**
 * 허위매물 신고 팝업
 *
 * yj-kim
 * 
 **/
angular.module('bnk-common.directive')
.directive('fakeReportPop', function ($rootScope, $timeout) {
	
/* ####################################################################################	
 * ## 팝업 상수설정														  				 ##
 * #################################################################################### */

	var PARENT_ID = 'wrap_back';				// 고정 
	var TEMPLATE_ID = 'fake-report-pop';	// 변경 <= 팝업ID(폴더,파일명)
	
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
				ITCButton.setupTypeAccordion();	//아코디언 초기화;
				
				$scope.$this.onOpenHandle = function(){
 					$scope.fake = $scope.$parent.fake;
 					$scope.fakeTypeCodeList = fakeTypeCodeList;
				};
				
				$scope.$on('onCodeReady', function (event, data) {
				});
				
				$rootScope.$broadcast(TEMPLATE_ID, {});
			};

			
		/* ####################################################################################	
		 * ## 멤버 초기값 설정													  				 ##
		 * #################################################################################### */
			$scope.fake ={};
			$scope.fake.falseType = '';
		/* #################################################################################### */
			
			
			
		/* ####################################################################################	
		 * ## 이벤트 설정													  				 	 ##
		 * #################################################################################### */
			
			/*$scope.cngVal = function(agId){
		        $scope.agId = agId;
		        if($("input:checkbox[id='fr_a"+agId+"']").is(":checked")){
		            $('#fr_a'+agId).val('Y');
		        }else{
		            $('#fr_a'+agId).val('');
		        }
		    }*/
			
			
			$scope.declare = function(){
				var falseType = $(':radio[name="rado_sample"]:checked').val();
				var params = {};
				
				params.carSeq = $scope.fake.carSeq;
				params.falseUserId = $scope.$parent.sessUserInfo.userId;
				params.falseUserNm = $scope.$parent.sessUserInfo.userName;
				params.falseUserTel = $scope.$parent.sessUserInfo.phoneMobile;
				params.carFullCode = $scope.fake.carFullCode;
				params.carPlateNum = $scope.fake.carPlateNum;
				params.saleAmt = $scope.fake.saleAmt;
				params.falseType = falseType;
				params.falseShopNo = $scope.fake.user.shopNo;
				params.falseDealerId = $scope.fake.user.userId;
				params.falseDealerNm = $scope.fake.user.userName;
				params.falseDealerTel = $scope.fake.user.phoneMobile;
				
				if(!$('input:radio[name="rado_sample"]').is(':checked')){
					alert('신고내용은 필수 값입니다.');
					return;
				}
				
				// 신고전에 이미 신고가 되어있는지 확인한다.
				var fakeUrl = BNK_CTX + "/api/user/selectFakeReport";
				$http({
					method : 'POST',
					url : fakeUrl,
					async: false, 
					data: JSON.stringify(params)
				})
				.success(function(oRes){
					/* 성공적으로 결과 데이터가 넘어 왔을 때 처리 */
					if(oRes.resCd == "00"){
						alert('이미 허위매물로 등록되어있습니다.');
						return;
					}else if(oRes.resCd == "99"){
						alert("허위매물 조회 중 에러가 발생하였습니다.");
						return;
					}else if(oRes.resCd == "11"){
						$scope.insFalse(params);
					}
				})
				.error(function(data, status, headers, config) {
					/* 서버와의 연결이 정상적이지 않을 때 처리 */
					console.log(status);
				});
				

			}
			
			$scope.insFalse = function(param){
				var url = BNK_CTX + "/api/user/insFakeReport";
				$http({
					method : 'POST',
					url : url,
					data: JSON.stringify(param)
				})
				.success(function(oRes){
					/* 성공적으로 결과 데이터가 넘어 왔을 때 처리 */
					if(oRes.resCd == "00"){
						alert('허위매물로 신고되었습니다.');
						$scope.$this.close();
					}else{
						alert("신고중 에러가 발생하였습니다.");
					}
				})
				.error(function(data, status, headers, config) {
					/* 서버와의 연결이 정상적이지 않을 때 처리 */
					console.log(status);
				});
			}
			
			$scope.cancelPop = function(){
				$scope.$this.close();
			}
			
			$scope.onClose = function(){
				// callback function 
				$scope.onLoadCallback({ 'id': TEMPLATE_ID, 'data': {} });
			};
			
		/* #################################################################################### */
			
			
			
		}
	};
});

