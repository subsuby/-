<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script>
bnkApp.controller(CTRL_NAME, ['$scope', '$http', '$filter', '$util', '$localstorage', '$timeout', function($scope, $http, $filter, $util, $localstorage, $timeout){

	/* ####################################################################################
	 * ## 멤버 초기값 설정													  				 ##
	 * #################################################################################### */
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

		$scope.onBlur = function(id){
			switch(id){
			case 'INPUT_PHONE_NUMBER':
				$scope.login.um = $filter('phoneHyphen')($scope.login.um.replace(/-/gi,''));
				break;
			}
		}

		$scope.onClick = function(id){
			switch(id){
			case 'BTN_LOGIN':
				if($util.isEmpty($scope.login.un)){
					alertify.alert('성명은 공백없이 입력해주세요.');return false;
				}
				if(!/\b\d{3}[-]?\d{3,4}[-]?\d{4}\b/.test($scope.login.um)){
					alertify.alert('휴대전화의 입력형식이 올바르지 않습니다.\n숫자만 입력해 주세요.');return false;
				}
				if($util.isEmpty($scope.login.up)){
					alertify.alert('비밀번호를 입력해주세요.');return false;
				}
				requestLogin();
				break;
			}
		};

		$scope.onInit = function(){
			// {c: fail}이면 비밀번호 잘못 입력
			if($util.getQueryStringValue('c')){
				alertify.alert('비밀번호를 잘못 입력하셨습니다.');
				// 비밀번호를 틀릴경우 비밀번호 저장 해제
				$localstorage.get('sessInfo',{}).then(function(login){
					login.isPasswordSave = false;				// 비밀번호 저장 해제
					$localstorage.set('sessInfo', login);		// 로컬스토리지 세션정보 설정
				});
				// 로그인 페이지로 이동
				//location.replace('<c:url value="/session/front/login"/>');
			}
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
				url: '<c:url value="/session/front/loginChk"/>',
				data: JSON.stringify({userName: $scope.login.un, phoneMobile: $scope.login.um, password: $scope.login.up})
			})
			.success(function(oRes){
				// 성공
				if(oRes.code == "00"){
					$scope.sessUserInfo = oRes.data.sessUserInfo;			// 세션유저정보 초기화
					$localstorage.set('sessInfo', $scope.login);			// 로컬스토리지 세션정보 설정
					angular.element('#un').val(oRes.data.userId);
        			angular.element('#up').val($scope.login.up);
        			angular.element('#login_form').submit();

				}
				// 이름, 핸드폰 번호 불일치
				else if(oRes.code == "01"){
					alertify.alert("입력하신 정보와 일치하는 사용자가 존재하지 않습니다. \n다시 한번 확인해 주세요");
				}
				// 비밀번호 오류
				else if(oRes.code == "02"){
					alertify.alert("입력하신 정보와 일치하는 사용자가 존재하지 않습니다. \n다시 한번 확인해 주세요");
				}
			})
			.error(function(data, status, headers, config) {
				/* 서버와의 연결이 정상적이지 않을 때 처리 */
				console.log(status);
			});
		};

	/* #################################################################################### */

		$scope.onInit();


}]);
</script>