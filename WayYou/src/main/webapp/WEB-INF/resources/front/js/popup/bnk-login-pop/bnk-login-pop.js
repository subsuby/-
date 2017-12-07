/**
 * 로그인 팝업
 *
 * jj-choi
 * 
 **/

angular.module('bnk-common.directive')
.directive('loginPop', function ($rootScope, $timeout) {
	
/* ####################################################################################	
 * ## 팝업 상수설정														  				 ##
 * #################################################################################### */

	var PARENT_ID = 'wrap_back';				// 고정 
	var TEMPLATE_ID = 'login-pop';	// 변경 <= 팝업ID(폴더,파일명)

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
			sessUserInfo: "=sessUserInfo"
		},
		
		restrict: 'E',		// E : elements, A : attributes, C : class name (CSS), M : comments 
		replace: true, 		// directive를 설정한 태그를 템플릿 태그로 교체하고자 할때 따라서 template 또는 templateUrl과 함께 사용한다
//		transclude: false,	// ngTransclude를 통하여 DOM에 transcluded DOM을 insert 할 수 있다
//							// transcluded DOM을 template에서 ngTransclude directive에 삽입한다
		link: function(scope, element, attrs) {
			scope.contentUrl = BNK_CTX + '/front/js/popup/bnk-'+ TEMPLATE_ID +'/bnk-'+ TEMPLATE_ID +'-template.html';
	       },
		template: '<div id="'+TEMPLATE_ID+'" ng-include="contentUrl"></div>',
		controller: function($scope, $http, $filter, $util, $localstorage){
			
		/* ####################################################################################	
		 * ## 멤버 초기값 설정													  				 ##
		 * #################################################################################### */
			
			// 팝업 초기화
			$scope.$this = {};	// 팝업객체
			$scope.templateInit = function(){
				$scope.$this = ITCButton.initPopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'), 'full');
				ITCButton.setupTypePopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'));
				$scope.$this.onOpenHandle = function(){
					$scope.onInit();
				};
				$scope.onInit();
				
				$rootScope.$broadcast(TEMPLATE_ID, {});
			};
			
			$scope.login = {};
			$scope.login.un = "";	// 아이디
			$scope.login.um = "";	// 핸드폰번호
			$scope.login.up = "";	// 비밀번호 
			
			$scope.login.isNameAndPhoneSave = false;
			$scope.login.isPasswordSave = false;
			
		/* #################################################################################### */
			
			
		/* ####################################################################################	
		 * ## 이벤트 설정													  				 	 ##
		 * #################################################################################### */
			
			$scope.onHrefClick = function(id){
				var hrefUrl = "";
				switch(id){
				case 'PASS':
					hrefUrl = "/front/common/pwResetBefore";
					break;
				case 'MEMBER':
					hrefUrl = "/front/common/joinKind";
					break;
				}
				
				location.href = BNK_CTX + hrefUrl;
			}
			
			$scope.onBlur = function(id){
				switch(id){
				case 'INPUT_PHONE_NUMBER':
					$scope.login.um = $filter('phoneHyphen')($scope.login.um.replace(/-/gi,''));
					break;
				}
			}
			
			$scope.onClick = function(id){
				switch(id){
				case 'POP_BTN_LOGIN':
//					if(!/^[가-힣]{2,4}$/.test($scope.login.un)){
//						alert('성명은 정확히 입력해주세요.');return false;
//					}
					if($util.isEmpty($scope.login.un)){
						alert('성명은 공백없이 입력해주세요.');return false;
					}
					if(!/\b\d{3}[-]?\d{3,4}[-]?\d{4}\b/.test($scope.login.um)){
						alert('휴대전화의 입력형식이 올바르지 않습니다.\n숫자만 입력해 주세요.');return false;
					}
					if($util.isEmpty($scope.login.up)){
						alert('비밀번호를 입력해주세요.');return false;
					}
					requestLogin();
					break;
				}
			};
			
			$scope.onInit = function(){
				$scope.login.un = "";	// 아이디
				$scope.login.um = "";	// 핸드폰번호
				$scope.login.up = "";	// 비밀번호 
				
				// 로컬스토리지 세선정보 조회
				$localstorage.get('sessInfo',{}).then(function(login){
					// 이름, 전화번호 자동입력 체크
					if(login && login.isNameAndPhoneSave){
						$scope.login.un = login.un;	// 아이디
						$scope.login.um = login.um;	// 핸드폰번호
						$scope.login.isNameAndPhoneSave = true;
					}
					// 비밀번호 자동입력 체크
					if(login && login.isPasswordSave){
						$scope.login.up = login.up;	// 비밀번호
						$scope.login.isPasswordSave = true;
					}
				});
				
				// 네이티브 디베이스 정보 로그인 폼에 셋팅
				location.href = "bnk://system.setLoginForm";
			};
			
		/* #################################################################################### */
		
			
		/* ####################################################################################	
		 * ## API 요청	  													  				 ##
		 * #################################################################################### */

			// 로그인 요청 
			var requestLogin = function(){
				/* AJAX 통신 처리 */
				$http({
					method: 'POST',
					headers:{'Content-Type': 'application/x-www-form-urlencoded'},
					url: BNK_CTX + '/session/front/customLogin',
					data: angular.element('#login_form').serialize()
				})
				.success(function(oRes){
					// 성공
					if(oRes.code == "00"){
						$scope.sessUserInfo = oRes.data.sessUserInfo;			// 세션유저정보 초기화
						$localstorage.set('sessInfo', $scope.login);			// 로컬스토리지 세션정보 설정
						$scope.onInit(); 					// 팝업 초기화
						$scope.$this.close();				// 팝업닫기
					}
					// 이름, 핸드폰 번호 불일치
					else if(oRes.code == "01"){
						alert("입력하신 정보와 일치하는 사용자가 존재하지 않습니다. \n다시 한번 확인해 주세요");
					}
					// 비밀번호 오류
					else if(oRes.code == "02"){
						alert("비밀번호를 잘못 입력하셨습니다.");
						// 비밀번호를 틀릴경우 비밀번호 저장 해제
						$scope.login.isPasswordSave = false;	// 비밀번호 저장 해제
						$scope.login.up = "";					// 비밀번호 
					}
				})
				.error(function(data, status, headers, config) {
					/* 서버와의 연결이 정상적이지 않을 때 처리 */
					console.log(status);
				});
			};
			
		/* #################################################################################### */
			
		}
	};
});

