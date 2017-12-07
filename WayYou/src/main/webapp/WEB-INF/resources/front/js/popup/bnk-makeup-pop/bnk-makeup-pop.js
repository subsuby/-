/**
 * [일반]메이크업 등록 팝업
 *
 * yh-lee
 *
 **/
angular.module('bnk-common.directive')
.directive('makeupPop', function ($rootScope, $timeout, $http, $filter, $localstorage) {

/* ####################################################################################
 * ## 팝업 상수설정														  				 ##
 * #################################################################################### */

	var PARENT_ID = 'wrap_back';			// 고정
	var TEMPLATE_ID = 'makeup-pop';			// 변경 <= 팝업ID(폴더,파일명)

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
		controller: function($scope){

			// 팝업 초기화
			$scope.$this = {};	// 팝업객체
			$scope.templateInit = function(){
				$scope.$this = ITCButton.initPopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'), 'full');
				ITCButton.setupTypePopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'));
				$rootScope.$broadcast(TEMPLATE_ID, {});
			};

			// 서비스 옵션 코드
			$scope.$on('onCodeReady', function (event, data) {
				$scope.makeupTypeCodeList = makeupTypeCodeList;
			});

			$scope.init = function(){
				$scope.search.schValue='';

				$scope.carSeq = '';
				$scope.carPlateNum = '';
				$scope.reqItems = '';
				$scope.carColor = '';
				$scope.carRegDt = '';
				$scope.carRegYear = '';
				$scope.useKm = '';
				$scope.carMission = '';
				$scope.attachCnt = '';
				$scope.mortGageCnt = '';
				$scope.carFuel	= '';
				$scope.unpaidTax =	'';
				$scope.userId = '';
				$scope.reqRemark = ''
				$scope.formData = {};
				$scope.formData.req = '';

				$(".noReuslt").hide();
			}
			$scope.search = {};
			$scope.search.schValue='';

			$scope.carSeq = '';
			$scope.carPlateNum = '';
			$scope.reqItems = '';
			$scope.carColor = '';
			$scope.carRegDt = '';
			$scope.carRegYear = '';
			$scope.useKm = '';
			$scope.carMission = '';
			$scope.attachCnt = '';
			$scope.mortGageCnt = '';
			$scope.carFuel	= '';
			$scope.unpaidTax =	'';
			$scope.userId = '';
			$scope.reqRemark = ''
			$scope.formData = {};
			$scope.formData.req = '';

			$scope.onClick = function(code){
				switch(code){
				case 'BTN_SEARCH':
					$scope.search();
					break;
				case 'BTN_CLOSE':
					$scope.$this.close();
					$scope.init();
					break;
				case 'BTN_REGIST':
					$scope.regist();
					break;
				}
			}

			$scope.search = function(){
				$scope.getList();
			};

			// 자기차량 검색 결과 조회
			$scope.getList = function(){
				/* AJAX 통신 처리 */
				var url = BNK_CTX + "/front/my/makeup/search";
				$http({
					url: url
					, method : 'POST'
					, async: false
					, data : JSON.stringify({
						schValue: $scope.search.schValue
					})
				})
				.success(function(data){
					// 검색 결과과 있을 경우
					if(data != null){
						//신청 버튼 나오게
						$(".noReuslt").show();
						//검색 결과 데이터 주입
						$scope.carSeq		= data.mycarSeq;
						$scope.carPlateNum	= data.carPlateNum;
						$scope.carRegDay	= data.carRegDay;
						$scope.carColor 	= data.label.carColor;
						$scope.carRegYear 	= data.label.carRegYear;
						$scope.useKm		= data.label.useKm;
						$scope.carMission	= data.label.carMission;
						$scope.carFuel		= data.label.carFuel;
						$scope.attachCnt	= data.attachCnt;
						$scope.mortGageCnt	= data.mortGageCnt;
						$scope.unpaidTax	= data.unpaidTax;
					}else{
						alertify.alert("메이크업 신청은 마이카에 등록된 차량만 가능합니다.\n 현재 입력하신 차량번호 혹은 마이카에 등록된 차량번호를 다시 확인해주세요.");

					}
				})
				.error(function(data, status, headers, config) {
					console.log(status);
				});
			};


			//메이크업 등록
			$scope.regist = function(){

				//체크된 서비스 배열에 담고 문자열로 변환
				var arrayParam = [];

				$("input:checkbox[name=a]:checked").each(function(){
					arrayParam.push($(this).val());
					arrayParam.join(",");
				});

				alertify.confirm('메이크업 서비스를 \n신청하시겠습니까?', function(){
					//체크된 서비스가 없을시 처리
					if(arrayParam.length < 1){
						alert("요청 서비스를 1개이상 선택해 주세요.");
						return;
					}
					//등록 시작
					$http({
						method	: 'POST',
						url		: BNK_CTX + '/front/my/makeup/regist',
						contentType:'application/json',
						params	: {
							carSeq : 	$scope.carSeq,
							carPlateNum : $scope.carPlateNum,
							reqRemark	: $scope.formData.req,
							reqItems	: arrayParam
						}
					}).success(function(data){
						if(data.resCd == '00'){
							//검색 결과 초기화
							$(".noReuslt").hide();
							$scope.carSeq		= '';
							$scope.carPlateNum	= '';
							$scope.carRegDay	= '';
							$scope.carColor 	= '';
							$scope.carRegYear 	= '';
							$scope.useKm		= '';
							$scope.carMission	= '';
							$scope.carFuel		= '';
							$scope.attachCnt	= '';
							$scope.mortGageCnt	= '';
							$scope.unpaidTax	= '';
							$scope.search.schValue='';
							arrayParam = [];

							//핸들러 실행
							$scope.$this.close();
							$scope.$this.complete();
						}else if(data.resCd == '99'){
							alertify.alert("신청 도중 오류가 발생했습니다. \n잠시후에 다시 시도해 주세요.");
						}
					}).error(function(){});
				});
			};
		}
	};
});

