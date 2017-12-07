<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
bnkApp.controller(CTRL_NAME, ['$scope', '$http', function($scope, $http){

    $scope.oParams = {}
    $scope.oParams.dealerLicenseNo = "${userInfo.dealerLicenseNo}";


    //=====================DATA INIT=============================

    	$scope.user = {};
    	$scope.user.division           = $scope.sessUserInfo.division;
    	$scope.user.userId             = "${userInfo.userId}";
    	$scope.user.userName           = "${sessUserInfo.userName}";
    	$scope.user.phoneMobile        = "${sessUserInfo.phoneMobile}";
    	$scope.user.actualPhoneMobile  = "${userInfo.actualPhoneMobile}";
    	$scope.user.danjiFullName      = "${userInfo.dealerDanjiName}";
    	$scope.user.danjiNo            = "${userInfo.danjiNo}";
    	$scope.user.shopFullName       = "${userInfo.dealerShopName}";
    	$scope.user.shopNo             = "${userInfo.shopNo}";
    	$scope.user.shopEtc            = "${userInfo.shopEtc}";
    	$scope.user.dealerLicenseNo    = "${userInfo.dealerLicenseNo}";
    	$scope.user.email              = "${userInfo.email}";
    	$scope.user.zipCode            = "${userInfo.zipCode}";
    	$scope.user.addr1              = "${userInfo.addr1}";
    	$scope.user.addr2              = "${userInfo.addr2}";
    	var emailArr = $scope.user.email.split("@");
    	$scope.user.emailId = emailArr[0];
    	$scope.user.emailDo = emailArr[1];



    //=====================FUNCTIONS=============================
    //임시 이전 페이지 이동
    $scope.hisBack = function(){
        history.go(-1);
    }

    $scope.onOpenPopup = function(code){
    	switch(code){
    	case 'GROUP_POP':
	    	var grpPop = ITCButton.getPopup('.groupFind').open();
	    	grpPop.onCompleteHandle = function(data){
	    		$scope.user.danjiFullName = data.danjiFullName;
	            $scope.user.danjiNo = data.danjiNo;
	            $scope.user.shopFullName = '';
	            $scope.user.shopNo = '';
	    		$scope.oParams.danjiNo = data.danjiNo;
	    	}
    		break;
    	case 'FIRM_POP':
	    	var firmPop = ITCButton.getPopup('.firmFind').open();
	    	firmPop.onCompleteHandle = function(data){
	    		$scope.user.shopFullName = data.shopFullName;
	            $scope.user.shopNo = data.shopNo;
	    	}
    		break;
    	case 'ADDR_POP':
	    	var addrPopup = ITCButton.getPopup('.fullAddress2').open();
			addrPopup.onCompleteHandle = function(data){
				$scope.user.zipCode   = data.zipNo;
				$scope.user.addr1 = data.roadAddr;
				$scope.user.addr2 = data.addrDtl;
			};
    		break;
    	}
    };

    $scope.modify = function(){
    	alertify.confirm('회원정보를 수정 하시겠습니까?', function(){
    		//DATA Refactoring

            $scope.user.email = $scope.user.emailId + "@" + $scope.user.emailDo;

            $http({
                url: BNK_CTX + "/front/common/updateUser"
                , method: 'POST'
                , async: false
                , headers: { 'Content-Type': 'application/json'}
                , data :JSON.stringify($scope.user)
                , dataType : 'json'
            }).success(function(data, status, headers, config){

            	if(data.resCd == '00'){
	            	alertify.alert("수정 되었습니다.");
            	}else if(data.resCd =='10'){
	            	alertify.alert("종사자 번호가 일치하지않습니다.");
            	}else if(data.resCd =='99'){
	            	alertify.alert("알 수 없는 오류가 발생했습니다.");
            	}
            }).error(function(data, status, headers, config) {
            });
    	});
    }

    $scope.kmCert = function(){
    	var params = {};
		params.tr_cert = $("#tr_cert").val();
		params.tr_url = $("#tr_url").val();
		params.tr_add = 'N';

		if(isAppGubun()){
			var requestURL = "https://www.kmcert.com/kmcis/web/kmcisReq.jsp?" + $.param(params);
			location.href = 'bnk://popup?title=본인인증&viewUrl='+encodeURIComponent(requestURL);
		}else{
			$("#agreeDealerFrm").attr("action" , "https://www.kmcert.com/kmcis/web/kmcisReq.jsp");
			$("#agreeDealerFrm").submit();
		}
    };
}]);

function __closeCallback(data){
	$('#actualPhoneMobile').val(util.phoneHyphen(data.phoneNo));
}
</script>