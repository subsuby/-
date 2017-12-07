<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
bnkApp.controller(CTRL_NAME, ['$scope', '$http','$util', function($scope, $http,$util){
    
    var tr_cert = "${tr_cert}";
    var tr_url = "${tr_url}";
    
    $("#tr_cert").val(tr_cert);
    $("#tr_url").val(tr_url);
	
    $scope.beforePw = function(){
    	var userName = $.trim($("#userName").val());
    	var phoneNum = $.trim($("#phoneNum").val());
    	
    	if(userName == ""){
    		alertify.alert("성명을 입력하세요.");
    		$("#userName").focus();
    		return;
    	}
    	
    	if(phoneNum == ""){
    		alertify.alert("휴대폰번호를 입력하세요.");
    		$("#phoneNum").focus();
    		return;
    	}    	
        var params={
        		"userName"    : userName,
        		"phoneMobile"    : phoneNum
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
            	   
            	  	var params = {};
	   				params.tr_cert = $("#tr_cert").val();
	   				params.tr_url = $("#tr_url").val();
	   				params.tr_add = 'N';
	   				params.name = userName;
	   				params.phoneNo = phoneNum;
	   				$("#tr_name").val(userName);
	   				$("#tr_phoneNo").val(phoneNum);
   				
	   				if(isAppGubun()){
	   					
	   					var requestURL = "https://www.kmcert.com/kmcis/web/kmcisReq.jsp?" + $.param(params);
	   					location.href = 'bnk://popup?title=본인인증&viewUrl='+encodeURIComponent(requestURL);
	   				}else{
	   					$("#pwFrm").attr("action" , "https://www.kmcert.com/kmcis/web/kmcisReq.jsp");
	   					$("#pwFrm").submit();
	   				}
	   				/* $("#pwFrm").attr("action" , "https://www.kmcert.com/kmcis/web/kmcisReq.jsp");
					$("#pwFrm").submit(); */
               }else{
                   alertify.alert("입력한 정보의 사용자 정보가 없습니다.");
               }
           }).error(function(data, status, headers, config) {
           });
    	}
}]);

function __closeCallback(data){
	location.href = BNK_CTX + "/front/common/pwReset?" + $.param(data);
}

</script>