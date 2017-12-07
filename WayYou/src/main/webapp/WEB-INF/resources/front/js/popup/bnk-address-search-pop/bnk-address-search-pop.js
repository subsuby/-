/**
 * 주소 검색 팝업
 *
 * hk-lee
 *
 **/
angular.module('bnk-common.directive')
.directive('addressSearchPop', function ($rootScope, $timeout, Upload, $http) {

/* ####################################################################################
 * ## 팝업 상수설정														  				 ##
 * #################################################################################### */

	var PARENT_ID = 'wrap_back';				// 고정
	var TEMPLATE_ID = 'address-search-pop';	// 변경 <= 팝업ID(폴더,파일명)

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
			onConfirmCallback: '&onConfirmCallback'
		},
		restrict: 'E',		// E : elements, A : attributes, C : class name (CSS), M : comments
		replace: true, 		// directive를 설정한 태그를 템플릿 태그로 교체하고자 할때 따라서 template 또는 templateUrl과 함께 사용한다
//		transclude: false,	// ngTransclude를 통하여 DOM에 transcluded DOM을 insert 할 수 있다
//							// transcluded DOM을 template에서 ngTransclude directive에 삽입한다
		link: function(scope, element, attrs) {
			scope.contentUrl = BNK_CTX + '/front/js/popup/bnk-'+ TEMPLATE_ID +'/bnk-'+ TEMPLATE_ID +'-template.html';
	    },
		template: '<div id="'+TEMPLATE_ID+'" ng-include="contentUrl"></div>',
		controller: function($scope, $util, $filter){

			// 팝업 초기화
			$scope.$this = {};	// 팝업객체
			$scope.templateInit = function(){
				$scope.$this = ITCButton.initPopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'), 'full');
				ITCButton.setupTypePopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'));
				$rootScope.$broadcast(TEMPLATE_ID, {});
			};

			/***********************************
						VARIABLE INIT
			*************************************/
			$scope.addr = {};
			$scope.addr.method = '';
			$scope.addr.step = 1;
			$scope.addr.list = [];
			$scope.addr.service = $util.addressService;
			$scope.addr.params = {};
			$scope.addr.params.keyword = '';
			$scope.addr.params.successCallback = function(data){
				console.log(data);
				var totSize = data.results.common.totalCount*1;
				var curPage = data.results.common.currentPage*1;
				var perPage = data.results.common.countPerPage*1;
				var totPage = parseInt(totSize/perPage) < 1 ? 1 : totSize%perPage==0?parseInt(totSize/perPage):parseInt(totSize/perPage)+1;

				if(curPage < totPage){
					$scope.addr.params.currentPage = curPage + 1;
				}
				if($scope.addr.method == 'more'){
					data.results.juso.forEach(function(juso){ $scope.addr.list.push(juso); });
				}else{
					$scope.addr.list = data.results.juso;
				}
				$scope.addr.totPage = totPage;
				$scope.addr.curPage = curPage;

			}

			$scope.addr.sendData = {};
			$scope.addr.sendData.zipNo = '';
			$scope.addr.sendData.roadAddr = '';
			$scope.addr.sendData.addrDtl = '';


			$scope.clear = function(){
				$scope.addr.method = '';
				$scope.addr.step = 1;
				$scope.addr.list = [];
				$scope.addr.params.keyword = '';
				$scope.addr.sendData.zipNo = '';
				$scope.addr.sendData.roadAddr = '';
				$scope.addr.sendData.addrDtl = '';
			}

			$scope.onClick = function(code, val, index){
				switch(code){
				case 'BTN_MORE':
					$scope.addr.method = 'more';
					$scope.addr.service.search($scope.addr.params);
					break;
				case 'BTN_SEARCH':
					$scope.addr.list = [];
					$scope.addr.params.currentPage = 1;
					$scope.addr.step = 2;
					$scope.addr.method = '';
					$scope.addr.sendData.zipNo = '';
					$scope.addr.sendData.roadAddr = '';
					$scope.addr.sendData.addrDtl = '';

					$scope.addr.service.search($scope.addr.params);
					break;
				case 'BTN_SELECT':
					$scope.addr.step = $scope.addr.step + 1;
					$scope.addr.sendData.addrObj = val;
					$scope.addr.sendData.zipNo = val.zipNo;
					$scope.addr.sendData.roadAddr = val.roadAddrPart1;
					break;
				case 'BTN_CONFIRM':
					if($util.isEmpty($scope.addr.sendData.roadAddr) && $util.isEmpty($scope.addr.sendData.zipNo)){
						alert("주소를 검색해주세요.");
						return;
					}
					$scope.$this.close();
					$scope.$this.complete($scope.addr.sendData);
					$scope.clear();
					break;
				case 'BTN_CANCEL':
					$scope.clear();
					$scope.$this.close();
					break;
				}
			}
		}
	};
});