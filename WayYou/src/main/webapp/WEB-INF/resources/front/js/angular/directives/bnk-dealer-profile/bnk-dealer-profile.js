/**
 * BNK 딜러 프로필
 *
 * hk-lee
 *
 **/
angular.module('bnk-common.directive')
.directive('bnkDealerProfile', function ($timeout, $http, $rootScope) {

	var TEMPLATE_ID = 'bnk-dealer-profile';	// 변경 <= 팝업ID(폴더,파일명)
	/**
	 * oParams
	 *
	 * @param userId ( 딜러ID )
	 *
	 * */

	$timeout(function(){
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
			oParams: '=params'
		},
		restrict: 'E',		// E : elements, A : attributes, C : class name (CSS), M : comments
		replace: true, 		// directive를 설정한 태그를 템플릿 태그로 교체하고자 할때 따라서 template 또는 templateUrl과 함께 사용한다
//		transclude: false,	// ngTransclude를 통하여 DOM에 transcluded DOM을 insert 할 수 있다
//							// transcluded DOM을 template에서 ngTransclude directive에 삽입한다
		link: function(scope, element, attrs) {
			scope.contentUrl = BNK_CTX + '/front/js/angular/directives/'+ TEMPLATE_ID +'/'+ TEMPLATE_ID +'-template.html';

		},
		template: '<div id="'+TEMPLATE_ID+'" ng-include="contentUrl"></div>',
		controller: function($scope, $util, $filter){

			$scope.$on('onCodeReady', function (event, data) {
				$scope.shopCodeInfoMap=shopCodeInfoMap;
			});

			$scope.templateInit = function(){
				$scope.sessUserInfo = {};
				$scope.sessUserInfo = $scope.$parent.sessUserInfo;
				angular.element('#profileRateit').rateit();
				$scope.getDealerProfileInfo();
			};


		/* ####################################################################################
		 * ## 멤버 초기값 설정													  				 ##
		 * #################################################################################### */

			$scope.user = {};
			$scope.user.dealerEvalList = [];



		/* ####################################################################################
		 * ## 이벤트 설정													  				 	 ##
		 * #################################################################################### */
			$scope.onClick = function(code){
				switch(code){
				case 'INST_DEALER':
					$util.getInterestDealer($scope.user);
					break;
				case 'BTN_SELLER_INFO':
					$scope.$parent.car.tabIndex = 0;
					ITCButton.getPopup('.dealerDetail').open();
					break;
				case 'BTN_SELLER_INFO_LIST':
					$scope.$parent.car.tabIndex = 2;
					ITCButton.getPopup('.dealerDetail').open();
					break;
				}
			}


		/* ####################################################################################
		 * ## API 요청	  													  				 ##
		 * #################################################################################### */

			$scope.getDealerProfileInfo = function(){
				console.log('start');
				var promise = $http({
					url: BNK_CTX + '/api/user/dealerProfileInfo'
					, method: 'POST'
					, data: JSON.stringify({userId: $scope.oParams.userId})
				});

				promise.then(success, error);

				function success(json){
					$scope.user = json.data.user;
					$scope.oParams.user = json.data.user;
					angular.element('#profileRateit').rateit('value', $scope.user.evalAvg);
				}
				function error(){
					angular.element('#profileRateit').rateit();
					console.log('딜러 정보 가져오기 실패..');
				}
			}

		}
	};
})
//딜러 평가평균점수
.filter('dealerScore',function(){
	return function(input){
		var out='0';
		if(angular.isArray(input) && input.length > 0){
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