/**
 * 휴대폰인증 팝업
 *
 * yj-kim
 * 
 **/
angular.module('bnk-common.directive')
.directive('phoneVerifyDealerPop', function ($rootScope,$timeout,$http) {
	
/* ####################################################################################	
 * ## 팝업 상수설정														  				 ##
 * #################################################################################### */

	var PARENT_ID = 'wrap_back';				// 고정 
	var TEMPLATE_ID = 'phone-verify-dealer-pop';	// 변경 <= 팝업ID(폴더,파일명)

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
		controller: function($scope, $util){
			
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
			
			$scope.mod = {};
			
		/* #################################################################################### */
			
			
			
		/* ####################################################################################	
		 * ## 이벤트 설정													  				 	 ##
		 * #################################################################################### */
			
			$scope.dealerJoin = function(){
				var params = {};
				params.tr_cert = $("#tr_cert").val();
				params.tr_url = $("#tr_url").val();
				params.tr_add = 'N';
				
				if(isAppGubun()){
					var requestURL = "https://www.kmcert.com/kmcis/web/kmcisReq.jsp?" + $.param(params);
					location.href = 'bnk://popup?title=본인인증&viewUrl='+encodeURIComponent(requestURL);
				}else{
					$("#agreeDealerFrm").attr("action" , "https://www.kmcert.com/kmcis/web/kmcisReq.jsp");
					$("#agreeDealerFrm").submit();
				}
			}
		/* #################################################################################### */
			
		}
	};
});
