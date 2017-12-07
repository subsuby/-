/**
 * 방문 시승 신청 팝업
 *
 * hk-lee
 *
 **/
angular.module('bnk-common.directive')
.directive('carDriveReservePop', function ($rootScope, $timeout, Upload, $http) {

/* ####################################################################################
 * ## 팝업 상수설정														  				 ##
 * #################################################################################### */

	var PARENT_ID = 'wrap_back';				// 고정
	var TEMPLATE_ID = 'car-drive-reserve-pop';	// 변경 <= 팝업ID(폴더,파일명)

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

			// 팝업 초기화
			$scope.$this = {};	// 팝업객체
			$scope.templateInit = function(){
				$scope.$this = ITCButton.initPopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'), 'full');
				ITCButton.setupTypePopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'));
				$rootScope.$broadcast(TEMPLATE_ID, {});
			};

			$scope.shopCodeInfoMap=[];
			$scope.resTypeCodeList=[];
			$scope.$on('onCodeReady', function (event, data) {
				$scope.shopCodeInfoMap=shopCodeInfoMap;
				$scope.resTypeCodeList=resTypeCodeList;
			});

			/***********************************
						VARIABLE INIT
			*************************************/
			$scope.res = {};
			$scope.res.carPlateNum		= '';
			$scope.res.dealerLicenseNo	= '';
			$scope.res.resType			= '1';
			$scope.res.resAmpm			= 'AM';
			$scope.res.resStatus		= '';
			$scope.res.resDate			= '';
			$scope.res.resUserId		= '';
			$scope.res.resUserNm		= '';
			$scope.res.resUserTel		= '';

			$scope.res.reserve	= function(){
				$scope.res.resStatus = '1';
				$scope.res.resDate = $scope.res.year+$scope.res.month+$scope.res.day;
				$scope.res.dealerLicenseNo = $scope.oParams.user.dealerLicenseNo;
				$scope.res.carPlateNum = $scope.oParams.carPlateNum;
				$scope.res.resUserId = $util.nvl($scope.$parent.sessUserInfo.userId, '');
				$scope.res.resUserNm = $util.nvl($scope.$parent.sessUserInfo.userName, '');
				$scope.res.resUserTel = $util.nvl($scope.$parent.sessUserInfo.actualPhoneMobile, '');
				$scope.res.carSeq = $util.nvl($scope.oParams.carSeq, '');

				$scope.res.resDate = $filter('date')(new Date($scope.res.year,$scope.res.month-1,$scope.res.day), 'yyyyMMdd');

				$http({method:'POST', url: BNK_CTX+'/api/user/registCarReserve', data: JSON.stringify($scope.res)})
				.success(function(data){
					if(data.resCd == '00'){
						alertify.alert('방문·시승을 예약하였습니다.');
						$scope.$this.close();
					}else if(data.resCd == '10'){
						alertify.alert('해당 차량은 방문/시승/탁송의 예약건수가 많아서 신청이 불가능한 상태입니다.');
						location.href = BNK_CTX + '/front/my/reserList';
					}else if(data.resCd == '11'){
						alertify.alert('해당 차량은 예약 신청이 완료된 상태입니다.');
					}else if(data.resCd == '99'){
						alertify.alert('예약 도중 오류가 발생했습니다. \n잠시후에 다시 시도해주세요.');
					}
				})
				.error(function(){
					console.log('등록 중 네트워크 오류 발생');
				});
			};



			$scope.initDate = function(){
				var now = new Date();
				var year = $scope.res.year		= $filter('date')(new Date(), 'yyyy');
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

				$scope.res.month	= $filter('date')(new Date(), 'M');
				$scope.res.day		= $filter('date')(new Date(), 'dd');

				if(day == now.getDate()){
					if(now.getHours() > 11){
						$scope.date.ampm = ['PM'];
						$scope.res.resAmpm = 'PM';
					}else{
						$scope.date.ampm = ['AM','PM'];
						$scope.res.resAmpm = 'AM';
					}
				}

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
						$scope.res.month	= $filter('date')(new Date(), 'M');
						$scope.res.day		= $filter('date')(new Date(), 'dd');
					}else{
						$scope.res.month	= '1';
						$scope.res.day		= '1';
					}
					// 선택한 값이 현재 월과 같을 경우
					if(month == now.getMonth() + 1){
						day = now.getDate();
					}

					if(day == now.getDate()){
						if(now.getHours() > 11){
							$scope.date.ampm = ['PM'];
							$scope.res.resAmpm = 'PM';
						}else{
							$scope.date.ampm = ['AM','PM'];
							$scope.res.resAmpm = 'AM';
						}
					}else{
						$scope.date.ampm = ['AM','PM'];
						$scope.res.resAmpm = 'AM';
					}

					$scope.date.years = $util.range(now.getFullYear()+2, now.getFullYear());
					$scope.date.months = $util.range( 12 + 1, month);
					$scope.date.days = $util.range(new Date(value, month , 0).getDate()+1, day);

					return;
				case 'MONTH':
					var now = new Date();
					var day = 1;

					// 선택한 값이 현재 연도, 월과 같을 경우
					if(value == now.getMonth() + 1 && $scope.res.year == now.getFullYear()){
						day = now.getDate();
						$scope.res.day		= $filter('date')(new Date(), 'dd');
					}else{
						$scope.res.day		= '1';
					}

					if(day == now.getDate()){
						if(now.getHours() > 11){
							$scope.date.ampm = ['PM'];
							$scope.res.resAmpm = 'PM';
						}else{
							$scope.date.ampm = ['AM','PM'];
							$scope.res.resAmpm = 'AM';
						}
					}else{
						$scope.date.ampm = ['AM','PM'];
						$scope.res.resAmpm = 'AM';
					}

					$scope.date.days = $util.range(new Date($scope.res.year, value , 0).getDate()+1, day);

					break;
				case 'DAY':
					var now = new Date();

					if($scope.res.year == now.getFullYear()
							&& $scope.res.month == (now.getMonth() + 1)
							&& value == now.getDate()){
						if(now.getHours() > 11){
							$scope.date.ampm = ['PM'];
							$scope.res.resAmpm = 'PM';
						}else{
							$scope.date.ampm = ['AM','PM'];
							$scope.res.resAmpm = 'AM';
						}
					}else{
						$scope.date.ampm = ['AM','PM'];
						$scope.res.resAmpm = 'AM';
					}
					break;
				}
			}
			$scope.initDate();

			$scope.onClick = function(code, val){
				switch(code){
				case 'BTN_RESERVE':
					$scope.$parent.isLogin({
						success: function(){
							$scope.res.reserve();
						},
						fail: function(){
							alertify.confirm('로그인이 필요한 페이지입니다.\n로그인하시겠습니까?', function(){ ITCButton.getPopup('.loginPop').open(); });
						}
					});
					break;
				case 'BTN_CANCEL':
					$scope.$this.close();
					break;
				}
			};
		}
	};
});