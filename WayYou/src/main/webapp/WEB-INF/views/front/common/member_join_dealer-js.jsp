<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
bnkApp.controller(CTRL_NAME, ['$scope', '$http', '$util', function($scope, $http, $util){

    $scope.oParams          = {'aaa':'aaa'};
    $scope.group            = {};
    $scope.danjiFullName    = "";
    $scope.shopFullSrchFirm = "";


    $scope.password     = "";
    $scope.passwordChk  = "";
    $scope.emailId      = "";
    $scope.agreeSmsYn   = "";
    $scope.agreePushYn  = "";
    $scope.division     = angular.element("input[name=division]").val();
    $scope.emailId      = "";
    $scope.emailDo      = "";
    $scope.email        = "";
    $scope.userName     = "";
    $scope.userName     = "${name}";
    $scope.phoneMobile  = "";
    $scope.phoneMobile  = "${phoneNo}";
    $scope.danjiFullName= "";
    $scope.danjiNoAdd   = "";
    $scope.shopFullName = "";
    $scope.shopNoAdd    = "";
    $scope.shopEtc      = "";
    $scope.dealerNo     = "";

    $('body').addClass('grayCase2');


    $scope.onOpenPopup = function(code){
    	switch(code){
    	case 'GROUP_POP':
	    	var grpPop = ITCButton.getPopup('.groupFind').open();
	    	grpPop.onCompleteHandle = function(data){
	    		$scope.danjiFullName = data.danjiFullName;
	            $scope.danjiNoAdd = data.danjiNo;
	    		$scope.oParams.danjiNo = data.danjiNo;
	    	}
    		break;
    	case 'FIRM_POP':
	    	var firmPop = ITCButton.getPopup('.firmFind').open();
	    	firmPop.onCompleteHandle = function(data){
	    		$scope.shopFullName = data.shopFullName;
	            $scope.shopNoAdd = data.shopNo;
	    	}
    		break;
    	}
    };

    $scope.memberJoin = function(){
    	$scope.emailId      = $scope.emailId    ;
        $scope.password     = $scope.password   ;
        $scope.passwordChk  = $scope.passwordChk;

        //필수값 체크
        if($util.isEmpty($scope.password)){
            alertify.alert("비밀번호는 필수 입력입니다.");
            angular.element('#password').focus();
            return false;
        }
        if($util.isEmpty($scope.passwordChk)){
            alertify.alert("비밀번호 확인은 필수 입력입니다.");
            angular.element('#passwordChk').focus();
            return false;
        }
        if($util.isEmpty($scope.emailId)){
            alertify.alert("이메일은 필수 입력입니다.");
            angular.element('#email').focus();
            return false;
        }
        if($util.isEmpty($scope.emailDo)){
            alertify.alert("이메일주소는 필수입니다.");
            angular.element('#email').focus();
            return false;
        }
        if($util.isEmpty($scope.danjiNoAdd)){
            alertify.alert("소속단체는 필수입니다."+$scope.danjiNoAdd);
            angular.element('#danjiNo').focus();
            return false;
        }
        if($util.isEmpty($scope.shopNoAdd)){
            alertify.alert("소속상사는 필수입니다."+$scope.shopNoAdd);
            angular.element('#shopNo').focus();
            return false;
        }
        //비밀번호 불일치 시
        if($scope.password != $scope.passwordChk){
            alertify.alert("비밀번호가 일치하지 않습니다.\n 다시 입력하여 주십시오.");
            $scope.password    = "";
            $scope.passwordChk = "";
            return false;
        }

        //비밀번호 정규식
        if(!/^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{10,20}$/.test($scope.password)){
            alertify.alert("비밀번호는 숫자와 영문자, 특수문자 조합으로 10~20자를 사용해야 합니다.");
            $scope.password     = "";
            $scope.passwordChk  = "";
            return false;
        }

        alertify.confirm('회원가입을 하시겠습니까?', function(){
        	var userName    = $scope.userName;     //사용자 이름
            var phoneMobile = $scope.phoneMobile;  //핸드폰 번호
            var password    = $scope.password;     //비밀번호
            var agreeSmsYn  = $scope.agreeSmsYn;   //SMS수신동의
            var agreePushYn = $scope.agreePushYn;  //PUSH수신동의
            var danjiNo     = $scope.danjiNoAdd;   //그룹번호
            var shopNo      = $scope.shopNoAdd;    //상사번호
            var shopEtc     = $scope.shopEtc;      //기타소속
            var division    = $scope.division;     //구분
            var email       = angular.element("input[name=email]").val();     //이메일
            var dealerLicenseNo= angular.element("input[name=dealerLicenseNo]").val();      //종사자번호
            var params={
                    userName        : userName,
                    phoneMobile     : phoneMobile,
                    email           : email,
                    password        : password,
                    agreeSmsYn      : agreeSmsYn,
                    agreePushYn     : agreePushYn,
                    danjiNo         : danjiNo,
                    shopNo          : shopNo,
                    shopEtc         : shopEtc,
                    dealerLicenseNo : dealerLicenseNo,
                    division        : division
                };

            $http({
                url: '<c:url value="/front/common/insertUser"></c:url>'
                , method: 'POST'
                , async: false
                , headers: { 'Content-Type': 'application/json'}
                , data :JSON.stringify(params)
                , dataType : 'json'
            }).success(function(data, status, headers, config){
                //검색한 리스트
                if(data.rsltDealer == 'N'){
                    alertify.alert("유효하지않은 종사자번호 입니다.");
                    return false;
                }
                if(data.chkDealer == '1'){
                    alertify.alert("이미 등록 된 종사자번호 입니다.");
                    return false;
                }
                if(data.resCd == '00'){
                    ITCButton.getPopup('.commonPopupJoin').open();
                }
            }).error(function(data, status, headers, config) {
            });
        });
    }

    /*
    * 내용   : [BUTTON] 확인 버튼 클릭 시 !!
    * 개발자 : 김예지
    */
    $scope.join = function(){
		var params={
				"userName"    : $scope.userName,
	    		"phoneMobile" : $scope.phoneMobile
			};

			$http({
	           url: '<c:url value="/front/common/searchUserInfo"></c:url>'
	            , method: 'POST'
	            , async: false
	            , headers: { 'Accept': 'application/json','Content-Type': 'application/json; charset=UTF-8'}
				, data :JSON.stringify(params)
				, dataType : 'json'
			}).success(function(data, status, headers, config){
				if(data.rslt != '0'){
					alertify.alert("이미 가입된 사용자 입니다.");
	           	}else{
	           		$scope.memberJoin();
	           	}
	       }).error(function(data, status, headers, config) {
	       });
    }
}])
</script>