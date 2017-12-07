<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
bnkApp.controller(CTRL_NAME, ['$scope', '$http','$util', function($scope, $http,$util){
    
    
    $scope.password     = "";
    $scope.passwordChk  = "";
    $scope.agreeSmsYn   = "";
    $scope.agreePushYn  = "";
    $scope.c_c1         = "";
    $scope.c_c2         = "";
    $scope.c_c3         = "";
    $scope.c_c4         = "";
    $scope.division     = angular.element("input[name=division]").val();
    $scope.emailId      = "";
    $scope.emailDo      = "";
    $scope.email        = "";
    $scope.userName     = "";
    $scope.userName     = "${name}";
    $scope.phoneMobile  = "";
    $scope.phoneMobile  = "${phoneNo}";
    
    $('body').addClass('grayCase2');
    
    /*
     * 내용   : [CHECK BOX] SMS 수신동의 클릭 시 !!
     * 개발자 : 김예지
     */
    $scope.smsChk = function(smsChk){
        $scope.sms = smsChk;
        if($scope.sms == "c_c1"){
            $("#c_c1").prop("checked",true).val("Y");
            $("#c_c2").prop("checked",false).val("");
        }else{
            $("#c_c2").prop("checked",true).val("N");
            $("#c_c1").prop("checked",false).val("");
        }
    }
     
    /*
     * 내용   : [CHECK BOX] PUSH 수신동의 클릭 시 !!
     * 개발자 : 김예지
     */
    $scope.pushChk = function(pushChk){
        $scope.push = pushChk;
        if($scope.push== "c_c3"){
            $("#c_c3").prop("checked",true).val("Y");
            $("#c_c4").prop("checked",false).val("");
        }else{
            $("#c_c4").prop("checked",true).val("N");
            $("#c_c3").prop("checked",false).val("");
        }
    }
     
	$scope.memberJoin = function(){
		$scope.emailId      = $scope.emailId;
        $scope.emailDo      = $scope.emailDo;
        $scope.password     = $scope.password;
        $scope.passwordChk  = $scope.passwordChk;
        $scope.c_c1  = $scope.c_c1;
        $scope.c_c2  = $scope.c_c2;
        $scope.c_c3  = $scope.c_c3;
        $scope.c_c4  = $scope.c_c4;
        
        //필수값 체크 
        if($util.isEmpty($scope.password)){
            alertify.alert("비밀번호는 필수 입력입니다.");
            angular.element('#password').focus();
            return false;
        }
        if($util.isEmpty($scope.passwordChk)){
            alertify.alert("비밀번호 확인은 필수 입력입니다.");
            $('#passwordChk').focus();
            return false;
        }
        if($util.isEmpty($scope.emailId)){
            alertify.alert("이메일은 필수 입력입니다.");
            $('#email').focus();
            return false;
        }
        if($util.isEmpty($scope.emailDo)){
            alertify.alert("이메일주소는 필수입니다.");
            $('#email').focus();
            return false;
        }
        if($scope.c_c1 == "" && $scope.c_c2 == ""){
            alertify.alert("SMS 수신동의는 필수 선택입니다.");
            return false;
        }
        if($scope.c_c3 == "" && $scope.c_c4 == ""){
            alertify.alert("PUSH 수신동의는 필수 선택입니다.");
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
        var pwReg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^~*+=-])(?=.*[0-9]).{10,20}$/;
        
        if(!pwReg.test($scope.password)){
            alertify.alert("비밀번호는 숫자와 영문자, 특수문자 조합으로 10~20자를 사용해야 합니다.");
            $scope.password     = "";
            $scope.passwordChk  = "";
            return false;
        }
        
        alertify.confirm('회원가입을 하시겠습니까?', function(){
        	var userName    = $scope.userName   ;     //사용자 이름
            var phoneMobile = $scope.phoneMobile;     //핸드폰번호
            var password    = $scope.password   ;     //비밀번호
            var division    = $scope.division   ;     //일반 구분값
            var email       = angular.element("input[name=email]"         ).val();     //이메일
            var agreeSmsYn  = angular.element("input[name=agreeSmsYn]"    ).val();     //SMS 수신동의
            var agreePushYn = angular.element("input[name=agreePushYn]"   ).val();     //PUSH 수신동의
            var params={
                    userName    : userName,
                    phoneMobile : phoneMobile,
                    password    : password,
                    email       : email,
                    agreeSmsYn  : agreeSmsYn,
                    agreePushYn : agreePushYn,
                    division    : division
                };
            $http({
                url: '<c:url value="/front/common/insertUser"></c:url>'
                , method: 'POST'
                , async: false
                , headers: { 'Accept': 'application/json','Content-Type': 'application/json; charset=UTF-8'}
                , data :JSON.stringify(params)
                , dataType : 'json'
            }).success(function(data, status, headers, config){
                if(data.result == '1'){
                    alertify.alert("중복된 사용자 입니다.");
                    return;
                }else{
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
}]);

</script>