<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
bnkApp.controller(CTRL_NAME, ['$scope', '$http','$util', function($scope, $http,$util){
    
    var userName = "${name}";
    var phoneMobile = "${phoneNo}";
    
    $("#userName").val(userName);
    $("#phoneMobile").val(phoneMobile);
	
    $('body').addClass('grayCase2');
    
    $scope.changePw = function(){
        if($scope.password != $scope.passwordChk){
            alertify.alert("비밀번호가 일치하지 않습니다.\n 다시 입력하여 주십시오.");
            $scope.password    = "";
            $scope.passwordChk = "";
            return false;
        }
        
        //비밀번호 정규식
        var pwReg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^~*+=-])(?=.*[0-9]).{10,20}$/;
        
        if(!pwReg.test($scope.password)){
            alertify.alert("비밀번호는 숫자와 영문자 조합으로 10~20자를 사용해야 합니다.");
            $scope.password     = "";
            $scope.passwordChk  = "";
            return false;
        }
        
        alertify.confirm('비밀번호를 변경 하시겠습니까?', function(){
        	var password    = $scope.password   ;     //비밀번호
            var params={
            		userName	: userName,
            		phoneMobile	: phoneMobile,
                    password    : password
                };
            $http({
                url: '<c:url value="/front/common/changePassword"></c:url>'
                , method: 'POST'
                , async: false
                , headers: { 'Accept': 'application/json','Content-Type': 'application/json; charset=UTF-8'}
                , data :JSON.stringify(params)
                , dataType : 'json'
            }).success(function(data, status, headers, config){
                if(data.rslt != '0'){
                    alertify.alert("비밀번호가 변경 되었습니다.");
                    location.href = '<c:url value="/session/front/login"></c:url>'
                }else{
                    alertify.alert("비밀번호 변경 실패 !");
                }
            }).error(function(data, status, headers, config) {
            });
        });
    }
}]);

</script>