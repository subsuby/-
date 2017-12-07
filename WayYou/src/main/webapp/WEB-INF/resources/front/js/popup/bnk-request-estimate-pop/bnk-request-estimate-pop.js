/**
 *  견적 신청을 위한 동의 여부 팝업
 *
 * yj-kim
 *
 **/
angular.module('bnk-common.directive')
.directive('requestEstimatePop', function ($rootScope, $timeout) {

/* ####################################################################################
 * ## 팝업 상수설정														  				 ##
 * #################################################################################### */

	var PARENT_ID = 'wrap_back';				// 고정
	var TEMPLATE_ID = 'request-estimate-pop';	// 변경 <= 팝업ID(폴더,파일명)

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
		controller: function($scope,$http){

		/* ####################################################################################
		 * ## 멤버 초기값 설정													  				 ##
		 * #################################################################################### */

			// 팝업 초기화
			$scope.$this = {};	// 팝업객체
			$scope.templateInit = function(){
				$scope.$this = ITCButton.initPopup(angular.element('#'+TEMPLATE_ID).find('.popupsmallWrap'), 'default');
				ITCButton.setupTypePopup(angular.element('#'+TEMPLATE_ID).find('.popupsmallWrap'));
				$rootScope.$broadcast(TEMPLATE_ID, {});
			};

			$scope.req = {};
			$scope.req.agreeReq = '';


		/* ####################################################################################
		 * ## 이벤트 설정													  				 	 ##
		 * #################################################################################### */

			$scope.onClick = function(code){
				switch(code){
				case 'BTN_VISIT':			//방문견적 클릭 시
					if($scope.req.agreeReq != 'Y'){
						alert("일괄동의를 선택하여 주십시오.");
						return;
					}
					var visitPop = ITCButton.getPopup('.visitApp').open();
					visitPop.onCompleteHandle = function(){
						$scope.$this.close();
						$scope.req.agreeReq = '';
						$scope.$parent.getList();
					}

					break;
				case 'BTN_DEALER':			//딜러견적 클릭 시
					if($scope.req.agreeReq != 'Y'){
						alert("일괄동의를 선택하여 주십시오.");
						return;
					}

					alertify.confirm('딜러견적을 요청하시겠습니까?', function(){
						$http({
							url: BNK_CTX + '/front/my/estimateDealer'
							, method: 'POST'
								, async: false
								, headers: { 'Content-Type': 'application/json'}
						, data :JSON.stringify({
							mycarSeq  : $scope.oParams.mycarSeq
						})
						}).success(function(data, status, headers, config){
							//견적신청하지 않은 결과
							if(data.resCd == '00'){
								alertify.alert('견적요청이 완료되었습니다.',
		    						function(){
										$scope.$this.close();
										$scope.$this.complete();
		    						}
			    				);
							}else if(data.resCd == '99'){
								alertify.alert('견적요청 중 오류가 발생하였습니다.');

							}
						}).error(function(data, status, headers, config) {

						});

					});
					break;
				}
			}

		}
	};
});

