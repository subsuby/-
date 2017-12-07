/**
 * 소속상사 변경
 *
 * yj-kim
 *
 **/
angular.module('bnk-common.directive')
.directive('dealerFirmSearchPop', function ($rootScope,$timeout,$http) {

/* ####################################################################################
 * ## 팝업 상수설정														  				 ##
 * #################################################################################### */

	var PARENT_ID = 'wrap_back';				// 고정
	var TEMPLATE_ID = 'dealer-firm-search-pop';	// 변경 <= 팝업ID(폴더,파일명)

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
			onLoadCallbackF: '&onLoadCallback'
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
				$scope.$this = ITCButton.initPopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'), 'full');
				ITCButton.setupTypePopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'));
				$scope.$this.onOpenHandle = function(){
					$scope.search.shopFullName = "";
					$scope.search.danjiNo = $scope.oParams.danjiNo;
					$scope.searchGrp();
				};
				$rootScope.$broadcast(TEMPLATE_ID, {});
			};

			$scope.selectedDataF = {};

			//검색 창 입력 박스가 닫기 클릭 시 초기화 되지 않는 이슈가 있어서 object 로 한번 더 감싸기 위함
			$scope.search = {};
			$scope.search.shopFullName = "";

		/* #################################################################################### */



		/* ####################################################################################
		 * ## 이벤트 설정													  				 	 ##
		 * #################################################################################### */

			$scope.onCompleteF = function(){
				if($util.isEmpty($scope.selectedDataF)){
					alert("소속상사를 먼저 선택해주세요");
					return false;
				}else{
					$scope.$this.complete(angular.copy($scope.selectedDataF));
					$scope.$this.close();
				}
			};

		/* #################################################################################### */


			$scope.searchGrp = function(){
				var url = BNK_CTX + '/front/common/searchFirm';
				$http({
					url: url
					, method: 'POST'
					, async: false
					, headers: { 'Content-Type': 'application/json'}
					, data :JSON.stringify({
						danjiNo: $scope.search.danjiNo					//소속단체코드
						, shopFullName: $scope.search.shopFullName	//소속상사
					})
				}).success(function(data, status, headers, config){
					//검색한 리스트
					$scope.carFirmList = data.carFirmList;
				}).error(function(data, status, headers, config) {
				});
			}

			//리스트에서 특정 li 를 선택했을 떄
			$scope.select = function(idx){
				$scope.selectedDataF = $scope.carFirmList[idx];
			}


		}
	};
});

