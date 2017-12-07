/**
 * 견적 신청 팝업
 *
 * yj-kim
 *
 **/
angular.module('bnk-common.directive')
.directive('requestVisitPop', function ($rootScope,$timeout,$http,$util,$filter) {

/* ####################################################################################
 * ## 팝업 상수설정														  				 ##
 * #################################################################################### */

	var PARENT_ID = 'wrap_back';				// 고정
	var TEMPLATE_ID = 'request-visit-pop';	// 변경 <= 팝업ID(폴더,파일명)

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
		controller: function($scope, $util, $filter){


		/* ####################################################################################
		 * ## 멤버 초기값 설정													  				 ##
		 * #################################################################################### */

			// 팝업 초기화
			$scope.$this = {};	// 팝업객체
			$scope.templateInit = function(){
				$scope.$this = ITCButton.initPopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'), 'full');
				ITCButton.setupTypePopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'));
				ITCButton.setupTypeAccordion();
				$rootScope.$broadcast(TEMPLATE_ID, {});

				$scope.$this.onOpenHandle= function(){
					var $c = $scope.oParams;
					$scope.visit.mycarSeq           = $c.mycarSeq;
					$scope.visit.estReqYn			= "Y";
					$scope.visit.visitType			= '1';
					$scope.visit.visitCarFullCode   = '';	//차량코드
					$scope.visit.visitUserTel       = $util.nvl($scope.$parent.sessUserInfo.actualPhoneMobile, '');	//연락처
					$scope.visit.danjiNo            = '';	//그룹번호
					$scope.visit.shopNo             = '';	//상사번호
					$scope.visit.visitZip			= $util.nvl($scope.$parent.sessUserInfo.zipCode, '');	//우편번호
					$scope.visit.visitAddr1			= $util.nvl($scope.$parent.sessUserInfo.addr1, '');	//주소
					$scope.visit.visitAddr2			= $util.nvl($scope.$parent.sessUserInfo.addr2, '');	//상세주소
					/*$scope.visit.visitZip           = '';	//우편번호
					$scope.visit.visitAddr          = '';	//주소
					$scope.visit.visitAddrDetail    = '';	//상세주소
*/					$scope.visit.reqDanjiNo			= '';	//소속그룹코드
					$scope.visit.reqDanjiName		= '';	//소속그룹명
					$scope.visit.reqShopNo			= '';	//소속단체코드
					$scope.visit.reqShopName		= '';	//소속단체명
					//$scope.visit.year				= $filter('date')(new Date(),'yyyy');	//년
					//$scope.visit.month				= $filter('date')(new Date(),'MM');		//월
					//$scope.visit.day				= $filter('date')(new Date(),'dd');		//일
					$scope.visit.visitResDate		= $filter('date')(new Date(),'yyyyMMdd');		//예약날짜
					$scope.visit.consignYn			= 'N';	//소속단체명
					$scope.visit.makeupYn			= 'N';	//소속단체명
				}
			};

			$scope.visit                    = {};


		/* ####################################################################################
		 * ## 이벤트 설정													  				 	 ##
		 * #################################################################################### */

			$scope.onOpenPopup = function(code){
				switch(code){
				case 'ADDR_POP':
					var addrPopup = ITCButton.getPopup('.fullAddress2').open();
					addrPopup.onCompleteHandle = function(data){
						$scope.visit.visitZip   = data.zipNo;
						$scope.visit.visitAddr1 = data.roadAddr;
						$scope.visit.visitAddr2 = data.addrDtl;
					};
					break;
				case 'DANJI_POP':
					var danjiPop = ITCButton.getPopup('.groupFind').open();
					danjiPop.onCompleteHandle = function(data){
						$scope.visit.reqDanjiNo			= data.danjiNo;			//소속단지코드
						$scope.visit.reqDanjiName		= data.danjiFullName;	//소속단지명
						$scope.oParams.danjiNo 			= data.danjiNo;			//소속단체에 넘길 소속단지코드
					}
					break;
				case 'SHOP_POP':
					if($util.isEmpty($scope.visit.reqDanjiNo)){
						alertify.alert('소속 단체를 먼저 입력해주세요.');
						return;
					}
					var shopPop = ITCButton.getPopup('.firmFind').open();
					shopPop.onCompleteHandle = function(data){
						$scope.visit.reqShopNo			= data.shopNo;
						$scope.visit.reqShopName		= data.shopFullName;
					}
					break;
				}
			}

			$scope.doFocus=function($event){
				if ($event.stopPropagation) $event.stopPropagation();		//이벤트 버블링 해제
				var $dl = $($event.target).closest('dl');
				$dl.find('.accordionData input[type=text],input[type=checkbox]').focus();
			}
			$scope.initDate = function(){
				var now = new Date();
				var year = $scope.visit.year		= $filter('date')(new Date(), 'yyyy');
				var month = 1;
				var day = 1;

				if(year == now.getFullYear()){
					month = now.getMonth() + 1;
				}
				if(month == now.getMonth() + 1){
					day = now.getDate();
				}

				$scope.date = {};
				$scope.date.years = $util.range(now.getFullYear()+2, now.getFullYear());
				$scope.date.months = $util.range( 12 + 1, month);
				$scope.date.days = $util.range(new Date( year , ( month + 1 ), 0).getDate()+1, day);

				$scope.visit.month		= $filter('date')(new Date(), 'M');
				$scope.visit.day		= $filter('date')(new Date(), 'dd');

			}
			$scope.onChange = function(code, value){
				switch(code){
				case 'YEAR':
					var now = new Date();
					var month = 1;
					var day = 1;

					// 선택한 값이 현재 연도와 같을 경우
					if(value == now.getFullYear()){
						month = now.getMonth() + 1;
						$scope.visit.month	= $filter('date')(new Date(), 'M');
						$scope.visit.day		= $filter('date')(new Date(), 'dd');
					}else{
						$scope.visit.month	= '1';
						$scope.visit.day		= '1';
					}
					// 선택한 값이 현재 월과 같을 경우
					if(month == now.getMonth() + 1){
						day = now.getDate();
					}

					$scope.date.years = $util.range(now.getFullYear()+2, now.getFullYear());
					$scope.date.months = $util.range( 12 + 1, month);
					$scope.date.days = $util.range(new Date(value, month , 0).getDate()+1, day);

					return;
				case 'MONTH':
					var now = new Date();
					var day = 1;

					// 선택한 값이 현재 연도, 월과 같을 경우
					if(value == now.getMonth() + 1 && $scope.visit.year == now.getFullYear()){
						day = now.getDate();
						$scope.visit.day		= $filter('date')(new Date(), 'dd');
					}else{
						$scope.visit.day		= '1';
					}

					$scope.date.days = $util.range(new Date($scope.visit.year, value , 0).getDate()+1, day);

					break;
				}
			}
			$scope.initDate();
			$scope.onClick=function(code){
				var visit = $scope.visit;
				visit.visitResDate = $filter('date')(new Date(visit.year,visit.month-1,visit.day), 'yyyyMMdd');

				switch(code){
				case 'BTN_APPLY':
					if(visit.visitUserTel.length === 0){
						alertify.alert("연락처를 입력해주세요.");
						$('input[name=visitUserTel]').closest('.accordionSet').addClass('on').find('input[name=visitUserTel]').focus();
						return;
					}
					if(visit.visitType == '2' && visit.visitZip.length === 0){
						alertify.alert("주소를 입력해주세요.", function(){
							$scope.onOpenPopup('ADDR_POP');
						});
						return;
					}

					alertify.confirm('견적요청을 하시겠습니까?',function(){
						//TODO: validate
                        $http({
                            url: BNK_CTX + '/front/my/applyVisitReq'
                            , method: 'POST'
                            , async: false
                            , headers: { 'Content-Type': 'application/json'}
                            , data :JSON.stringify(visit)
                            , dataType : 'json'
                        }).success(function(data, status, headers, config){
                        	if($scope.visit.visitType == '1'){
                        		alertify.alert("직접방문으로 견적요청 하셨습니다.");
                        	}else if($scope.visit.visitType == '2'){
                        		alertify.alert("방문요청으로 견적요청 하셨습니다.");
                        	}
                            ITCButton.closePopup();
                            $scope.$this.complete();
                        }).error(function(data, status, headers, config) {

                        });
					});
					break;
				case 'BTN_CANCEL':
	                ITCButton.closePopup();
					break;
				}
			}


		/* #################################################################################### */



		}
	};
});
