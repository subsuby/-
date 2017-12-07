/**
 * 딜러 프로필 상세
 *
 * hk-lee
 *
 **/
angular.module('bnk-common.directive')
.directive('dealerDetailPop', function ($timeout, $rootScope) {

/* ####################################################################################
 * ## 팝업 상수설정														  				 ##
 * #################################################################################### */

	var PARENT_ID = 'wrap_back';				// 고정
	var TEMPLATE_ID = 'dealer-detail-pop';	// 변경 <= 팝업ID(폴더,파일명)

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
			oParams: '=params'
			, onLoadCallback: '&onLoadCallback'
		},
		restrict: 'E',		// E : elements, A : attributes, C : class name (CSS), M : comments
		replace: true, 		// directive를 설정한 태그를 템플릿 태그로 교체하고자 할때 따라서 template 또는 templateUrl과 함께 사용한다
//		transclude: false,	// ngTransclude를 통하여 DOM에 transcluded DOM을 insert 할 수 있다
//							// transcluded DOM을 template에서 ngTransclude directive에 삽입한다
		link: function(scope, element, attrs) {
			scope.contentUrl = BNK_CTX + '/front/js/popup/bnk-'+ TEMPLATE_ID +'/bnk-'+ TEMPLATE_ID +'-template.html';
		},
		template: '<div id="'+TEMPLATE_ID+'" ng-include="contentUrl"></div>',
		controller: function($scope, $http, $util, $filter){

		/* ####################################################################################
		 * ## 멤버 초기값 설정													  				 ##
		 * #################################################################################### */

			// 팝업 초기화
			$scope.$this = {};	// 팝업객체
			$scope.templateInit = function(){
				$scope.$this = ITCButton.initPopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'), 'full');
				ITCButton.setupTypePopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'));
				ITCButton.setupTypeToggleAndTab();	// 탭 설정
				$scope.$this.onOpenHandle = function(){
					$scope.sessUserInfo = {};
					$scope.sessUserInfo = $scope.$parent.sessUserInfo;
					//평가 추가후 Callback 내용
					$scope.param.dealerEvalList = [];
					if($util.isNotEmpty($scope.oParams.user)){
						$scope.getList(1);
						$scope.getCarList();
						var shop = $scope.shopCodeInfoMap[$scope.oParams.user.shopNo].shop;
						var map = new naver.maps.Map('map', {
							center: new naver.maps.LatLng(shop.shopLocLat, shop.shopLocLng),
							zoom: 10
						});
						var marker = new naver.maps.Marker({
							position: new naver.maps.LatLng(shop.shopLocLat, shop.shopLocLng),
							map: map
						});
					}

					if($scope.$parent.car.tabIndex === 2){
						$scope.onClick('MOVE_TAB', 2);
					}else{
						$scope.onClick('MOVE_TAB', 0);
					}
				};

				angular.element('#infoRating').rateit();
				$rootScope.$broadcast(TEMPLATE_ID, {});
			};

			$scope.$on('onCodeReady', function (event, data) {
				$scope.evalDivCodeList = evalDivCodeList;
				$scope.shopCodeInfoMap=shopCodeInfoMap;
			});
			$scope.$on('dealer-eval-regist-pop', function (event, data) {

			});

			$scope.param={};
			$scope.param.dealerEvalList = [];
			$scope.param.curPage = 1;
			$scope.param.totPage = 0;

		/* ####################################################################################
		 * ## 이벤트 설정													  				 	 ##
		 * #################################################################################### */
			$scope.onClick = function(code, value){
				switch(code){
				case 'INST_DEALER':
					$util.getInterestDealer($scope.oParams.user);
					break;
				case 'LIST_MORE':
					$scope.param.curPage = $scope.param.curPage + 1;
					break;
				case 'DIBS_ON':		//찜하기
					$util.getDibsOnCar(value);
					break;
				case 'MOVE_TAB':		//찜하기
					$('.btn-toggle-wrapper .btn-toggle-switch:eq('+value+')').trigger('click');
					break;
				case 'BTN_RATING_ADD':
					$scope.$parent.isLogin({
						success: function(){
							var ratingPopup = ITCButton.getPopup('.ratingAdd').open();
							ratingPopup.onCompleteHandle = function(){
								$scope.param.dealerEvalList = [];
			 					$scope.param.curPage = 1;
								$scope.param.totPage = 0;
								$scope.getList(1);
							};
						},
						fail: function(){
							alertify.confirm('로그인이 필요한 페이지입니다.\n로그인하시겠습니까?', function(){ ITCButton.getPopup('.loginPop').open(); });
						}
					});
					break;
				}
			}
		/* #################################################################################### */


		/* ####################################################################################
		 * ## API 요청	  													  				 ##
		 * #################################################################################### */

			$scope.$watch('param.curPage', function(nv){
				if(nv > 1){
					$scope.getList(nv);
				}
			});
			$scope.getList = function(page){
				$scope.carList=[];

				var promise = $http({
					url: BNK_CTX + '/api/user/dealerEvalList'
					, method: 'POST'
					, data: JSON.stringify({
						userId: $scope.oParams.user.userId
						, curPage: page
						, pageListSize: 7
					})
				});
				promise.then(success, error);

				function success(json){
					if($util.isNotEmpty(json.data.user) && $util.isNotEmpty(json.data.user.dealerEvalList)){
						json.data.user.dealerEvalList.forEach(function(eval){
							$scope.param.dealerEvalList.push(eval);
						});

						$scope.oParams.user.dealerEvalList = json.data.user.dealerEvalList;
						$scope.oParams.user.evalAvg = json.data.user.evalAvg;
						$('#infoRating').rateit('value', json.data.user.evalAvg );
						$('#profileRateit').rateit('value', json.data.user.evalAvg);

					}
					$scope.param.totPage = json.data.totPage;
				}
				function error(){
					console.log('딜러 평가 리스트 가져오기 실패..');
				}
			}

			$scope.carList = [];		// 차량 리스트

			$scope.oPageInfo = {
					'data': {},
					'totListSize': 0,	// 전체 리스트 갯수
					'currentPageNo': 1,	// 현재 페이지 번호
					'bLoad': false, 	// 데이터 로딩 상태 여부
					'bHasMore': false	// 로드할 데이터 여부
				};
			$scope.bShowEmpty = false;	// 데이터 없음 여부

			// 매물 리스트 조회
			$scope.getCarList = function(){
				$scope.oPageInfo.bLoad = true;

				/* AJAX 통신 처리 */
				$http({
					method:'POST',
					url : BNK_CTX + "/api/car/list/dealerSellList",
					data: JSON.stringify({
						curPage : $scope.oPageInfo.currentPageNo
						, userId : $scope.oParams.user.userId
						, pageListSize: 50
					})
				})
				.success(function(oRes){
					/* 성공적으로 결과 데이터가 넘어 왔을 때 처리 */
					if(oRes.code == "00"){
						// 조회 리스트 추가
						$.merge($scope.carList, oRes.data.list);
						// 차량리스트가 없을 경우
						$scope.bShowEmpty = $scope.carList.length < 1 && $scope.oPageInfo.currentPageNo == 1 ? true : false;
						// 더보기
						$scope.oPageInfo.bLoad = false;
						$scope.oPageInfo.totListSize = oRes.data.totListSize;
						$scope.oPageInfo.bHasMore = oRes.data.hasMoreList;
					}
					/* 통신한 URL에서 데이터가 넘어오지 않았을 때 처리 */
					else{
						$scope.oPageInfo.bLoad = false;
					}
				})
				.error(function(data, status, headers, config) {
					/* 서버와의 연결이 정상적이지 않을 때 처리 */
					$scope.oPageInfo.bLoad = false;
					console.log(status);
				});

			};

		 	// 페이지정보 초기화
			$scope.pageInit = function(){
				$scope.carList = [];					// 차량 리스트
				$scope.oPageInfo.totListSize = 0;		// 전체 리스트 갯수
				$scope.oPageInfo.data = {};				// 검색조건 파라미터
				$scope.oPageInfo.currentPageNo = 1;		// 현재 페이지 번호
				$scope.oPageInfo.bLoad = false;			// 데이터 로딩 상태 여부
				$scope.oPageInfo.bHasMore = false;		// 로드할 데이터 여부
			};

			//아코디언 이벤트 바인딩, ng-repeat + ng-init 활용
			 $scope.setupAccordion = function(){
				 ITCommons.setupTypeAccordion();
			 }

			 //판매 매물 상세 이동
			 $scope.goDetail = function(idx){
				 location.href = BNK_CTX + "/front/category/mycar/buyDetail/" + idx;
			 }

			// 초기 메서드 실행
			var init = function(){
				$util.moveScroll(0);
			}
			init();

		/* #################################################################################### */

		}
	};
})
//딜러 평가평균점수
.filter('dealerScore',function(){
	return function(input){
		var out='0';
		if(angular.isArray(input)){
			var sum = 0;
			input.forEach(function(obj) {
				sum += obj.rating * 1;
			});
			out = sum/input.length;
		}
		return out;
	}
})
//딜러 평가평균점수 퍼센트화
.filter('dealerScorePer',function(){
	return function(input){
		var out='0%';
		if(angular.isNumber(input*1)){
			out = input / 5 * 100 + '%';
		}
		return out;
	}
});
