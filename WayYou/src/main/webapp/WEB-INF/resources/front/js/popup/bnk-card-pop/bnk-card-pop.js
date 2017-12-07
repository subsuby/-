/**
 * 명함 조회 팝업
 *
 * jj-choi
 *
 **/

angular.module('bnk-common.directive')
.directive('cardPop', function ($rootScope, $timeout) {

/* ####################################################################################
 * ## 팝업 상수설정														  				 ##
 * #################################################################################### */

	var PARENT_ID = 'wrap_back';				// 고정
	var TEMPLATE_ID = 'card-pop';	// 변경 <= 팝업ID(폴더,파일명)

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
		controller: function($scope, $util, $http){

			// 팝업 초기화
			$scope.$this = {};	// 팝업객체
			$scope.templateInit = function(){
				$scope.$this = ITCButton.initPopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'), 'full');
				ITCButton.setupTypePopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'));

				$scope.$this.onOpenHandle = function(){
					$scope.getNameCard();
				};

				$rootScope.$broadcast(TEMPLATE_ID, {});
			};

			$scope.oParams = {};
			$scope.user = {};

			$scope.getNameCard = function(){
				$http({method:'POST', url:BNK_CTX + '/api/user/nameCardProfileInfo'})
				.success(function(data){
					if(data.resCd == '00'){
						var oUser = $util.nvl(data.user, {});
						$scope.user.userId = oUser.userId;
						$scope.user.userName = oUser.userName;
						$scope.user.dealerLicenseNo = oUser.dealerLicenseNo;
						$scope.user.dealerProfileFileSeq = oUser.dealerProfileFileSeq;
						$scope.user.dealerProfileDesc = oUser.dealerProfileDesc;
						$scope.user.dealerProfileTel = oUser.dealerProfileTel;
						$scope.user.dealerDanjiName = oUser.dealerDanjiName;
						$scope.user.dealerShopName = oUser.dealerShopName;
						$scope.user.phoneMobile = oUser.phoneMobile;

					}else if(data.resCd == '99'){
						//alert('명함정보 전송중 오류가 발생했습니다. \n잠시후에 다시 시도해주세요.');
					}
				})
				.error(function(){
				});
			};

			$scope.modifyClick = function (){
				$scope.$parent.cardParams = $scope.user;
				ITCButton.getPopup('.businesscard2').init();
				var cardPopup = ITCButton.getPopup('.businesscard2').open();
				cardPopup.onCompleteHandle = function(){
					$scope.getNameCard();
				};
			}

			$scope.sendClick = function(){
				// 푸시전송 하기전 어떤 화면에서 넘어왔는지 값을 전달한다.
				$("#type").val("N");			// N: 명함
				var cardSendPopup = ITCButton.getPopup('.popSend').open();
				cardSendPopup.onCompleteHandle = function(data){
					$scope.$this.close();
				};
			};

			$scope.onClose = function(){
				// callback function
				$scope.onLoadCallback({ 'id': TEMPLATE_ID, 'data': {} });
			};

		}
	};
});

