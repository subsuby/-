<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
bnkApp.controller(CTRL_NAME, ['$scope', '$http', function($scope, $http){
    
    $scope.oParams = {};
    $scope.onLoad = function(id, data){ };
    
    /*
     * 내용   : [CHECK BOX] SMS 수신동의 클릭 시 !!
     * 개발자 : 김예지
     */
    $scope.smsChk = function(smsChk){
        $scope.sms = smsChk;
        if($scope.sms == "cc_c1"){
            $("#cc_c1").prop("checked",true).val("Y");
            $("#cc_c2").prop("checked",false).val("");
        }else{
            $("#cc_c2").prop("checked",true).val("N");
            $("#cc_c1").prop("checked",false).val("");
        }
    }
    
    //임시 이전 페이지 이동
    $scope.hisBack = function(){
        history.go(-1);
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
     
	$scope.addrClick = function(){
		var addrPopup = ITCButton.getPopup('.fullAddress2').open();
		addrPopup.onCompleteHandle = function(data){
			$scope.zipCode   = data.zipNo;
			$scope.addr1 = data.roadAddr;
			$scope.addr2 = data.addrDtl;
		};
	}
    
    
    $scope.modify = function(){
    	alertify.confirm('회원정보를 수정 하시겠습니까?', function(){
    		var smsChk;
            var pushChk;
            if($("input:checkbox[id='cc_c1']").is(":checked")){
                smsChk = 'Y'
            }else if($("input:checkbox[id='cc_c2']").is(":checked")){
                smsChk = 'N'
            }
            if($("input:checkbox[id='c_c3']").is(":checked")){
                pushChk = 'Y'
            }else if($("input:checkbox[id='c_c4']").is(":checked")){
                pushChk = 'N'
            }
            var actualPhoneMobile   = $("input[name=actualPhoneMobile]").val();     //사용중 휴대폰
            var emailId             = $("input[name=emailId]").val();               //이메읿 1 (아이디)
            var emailDo             = $("input[name=emailDo]").val();               //이메읿 2 (주소)
            var division            = $("input[name=division]").val();              //구분
            var userId              = $("input[name=userId]").val();                //사용자아이디
            var agreeSmsYn          = smsChk;            //SMS 수신 동의
            var agreePushYn         = pushChk;           //PUSH 수신 동의
            var email               = emailId + "@" + emailDo;
            var zipCode             = $("#zipCode").val();                			//우편번호
            var addr1               = $("#addr1").val();                			//주소
            var addr2               = $("#addr2").val();                			//상세주소
            var params={
                    actualPhoneMobile   : actualPhoneMobile,
                    email               : email,
                    division            : division,
                    userId              : userId,
                    agreeSmsYn          : agreeSmsYn,
                    agreePushYn         : agreePushYn,
                    zipCode         	: zipCode,
                    addr1         		: addr1,
                    addr2         		: addr2
                };
            
            $http({
                url: '<c:url value="/front/common/updateUser"></c:url>'
                , method: 'POST'
                , async: false
                , headers: { 'Content-Type': 'application/json'}
                , data :JSON.stringify(params)
                , dataType : 'json'
            }).success(function(data, status, headers, config){
                alertify.alert("수정 되었습니다.");
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
			$("#agreeFrm").attr("action" , "https://www.kmcert.com/kmcis/web/kmcisReq.jsp");
			$("#agreeFrm").submit();
		}
    };
}]);


$(document).ready(function() {
    $('#userUpdForm').on('submit', function(e){
        e.preventDefault();
    })
    
    var userName           = "${sessUserInfo.userName}";
    var phoneMobile        = "${sessUserInfo.phoneMobile}";
    var actualPhoneMobile  = "${userInfo.actualPhoneMobile}";
    var email              = "${userInfo.email}";
    var zipCode            = "${userInfo.zipCode}";
    var addr1              = "${userInfo.addr1}";
    var addr2              = "${userInfo.addr2}";
    var agreeSmsYn         = "${userInfo.agreeSmsYn}";
    var agreePushYn        = "${userInfo.agreePushYn}";
    var userId             = "${sessUserInfo.userId}";
    
    var emailArr = email.split("@");
    
    $("#userName"         ).val(userName);
    $("#phoneMobile"      ).val(phoneMobile.replaceHyphen());
    $("#actualPhoneMobile").val(actualPhoneMobile.replaceHyphen());
    $("#emailId"          ).val(emailArr[0]);
    $("#emailDo"          ).val(emailArr[1])
    $("#userId"           ).val(userId);
    $("#zipCode"          ).val(zipCode);
    $("#addr1"            ).val(addr1);
    $("#addr2"            ).val(addr2);
    
    if(agreeSmsYn == "Y"){
        $("#cc_c1").prop('checked',true);
    }else{
        $("#cc_c2").prop('checked',true);
    }
    
    if(agreePushYn == 'Y'){
        $("#c_c3").prop('checked',true);
    }else{
        $("#c_c4").prop('checked',true);
    }
    
    
});

function __closeCallback(data){
	$('#actualPhoneMobile').val(util.phoneHyphen(data.phoneNo));
}
</script>