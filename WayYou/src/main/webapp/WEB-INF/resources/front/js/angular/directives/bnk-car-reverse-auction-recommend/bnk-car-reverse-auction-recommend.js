/**
 * 내게맞는매물 추천차량
 *
 * yh-lee
 *
 **/
angular.module('bnk-common.directive')
.directive('bnkCarReverseAuctionRecommend', function ($timeout, $http, $filter, $util, $rootScope) {

/* ####################################################################################
 * ## 팝업 상수설정														  				 ##
 * #################################################################################### */

	var TEMPLATE_ID = 'bnk-car-reverse-auction-recommend';	// 변경 <= 팝업ID(폴더,파일명)

/* #################################################################################### */

	$timeout(function(){
		uiModules.swiperUpdate();
		$rootScope.$broadcast(TEMPLATE_ID+"init",{});
	});
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
			scope.contentUrl = BNK_CTX + '/front/js/angular/directives/'+ TEMPLATE_ID +'/'+ TEMPLATE_ID +'-template.html';

		},
		template: '<div id="'+TEMPLATE_ID+'" ng-include="contentUrl"></div>',
		controller: function($scope){

		/* ####################################################################################
		 * ## 멤버 초기값 설정													  				 ##
		 * #################################################################################### */

			$scope.$on(TEMPLATE_ID+"init", function (event, data) {
				$scope.init();
			});


			$scope.carList = [];		// 차량 리스트
			$scope.oPageInfo = {
					'data': {},
					'totListSize': 0,	// 전체 리스트 갯수
					'currentPageNo': 1,	// 현재 페이지 번호
					'bLoad': false, 	// 데이터 로딩 상태 여부
					'bHasMore': false	// 로드할 데이터 여부
				};
			$scope.bShowEmpty = false;	// 데이터 없음 여부

			// 초기 메서드 실행
			$scope.init = function() {
				$scope.sessUserInfo = {};
				$scope.sessUserInfo = $scope.$parent.sessUserInfo;
				//$scope.getList();
			};


		/* #################################################################################### */


		/* ####################################################################################
		 * ## 이벤트 핸들러 설정													  				 ##
		 * #################################################################################### */

			// 더보기 이벤트
			$util.lastItem(function () {
				if ( !$scope.oPageInfo.bLoad && $scope.oPageInfo.bHasMore ) {
					$scope.oPageInfo.currentPageNo++;	// 페이지번호 증가
					$scope.getList();	// 리스트 조회
				}
			});

			$scope.$watch('oParams.modelCd', function(){
				$scope.getList();
			});
		/* #################################################################################### */


		/* ####################################################################################
		 * ## API 요청	  													  				 ##
		 * #################################################################################### */

			// 매물 리스트 조회
			$scope.getList = function(){
				$scope.oPageInfo.bLoad = true;

				// 파라미터 셋팅
				var oParams = {};										// 상세검색 조건
				oParams.modelCd = $scope.oParams.modelCd;				// 모델코드
				oParams.detailModelCd = $scope.oParams.detailModelCd;	// 상세모델코드
				oParams.useKm = $scope.oParams.useKm;				// 주행거리
				oParams.carRegYear = $scope.oParams.carRegYear;		// 연식
				oParams.carColor = $scope.oParams.carColor;			// 색상
				oParams.curPage = $scope.oPageInfo.currentPageNo;	// 페이지 번호

				// url 셋팅
				var url = BNK_CTX + "/api/car/list/reauction";

				/* AJAX 통신 처리 */
				$http({
					method : 'POST',
					url : url,
					data: JSON.stringify(oParams)
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

		/* #################################################################################### */


		/* ####################################################################################
		 * ## 이벤트 설정													  				 	 ##
		 * #################################################################################### */

			// 찜하기
			$scope.onClick	=	function(code, car){
				switch(code){
				case 'ITEM_RECOMM_CAR':
					location.href = BNK_CTX + "/front/category/mycar/buyDetail/" + car.carSeq;	// 차량 상세페이지 이동
					break;
				case 'DIBS_ON':
					$util.getDibsOnCar(car);
					break;
				}
			}

		/* #################################################################################### */
		}
	};
});
