<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
bnkApp.controller(CTRL_NAME, ['$scope', '$http', function($scope, $http){
    
    $scope.oParams = {'aaa':'aaa'};
    $scope.onLoad=function(id, data){
    }
    
    $scope.onPopupOpen = function(){
        $scope.chkAgree();
    };
    
    $scope.divId = 'N';
    $scope.division = function(divId){
        $scope.divId = divId;
    }
    
    var tr_cert = "${tr_cert}";
    var tr_url = "${tr_url}";
    
    $("#tr_cert").val(tr_cert);
    $("#tr_url").val(tr_url);
    
    $('body').addClass('grayCase2');
    
    /*
    * 내용   : [BUTTON] 필수 동의 클릭 시 !!
    * 개발자 : 김예지
    */
    $scope.cngVal = function(agId){
        $scope.agId = agId;
        if($("input:checkbox[id='agree0"+agId+"']").is(":checked")){
            $('#agree0'+agId).val('Y');
            if($('#agree01').val() != '' && $('#agree02').val() != '' && $('#agree03').val() != '' && $('#agree04').val() != ''){
                $('#terms_chkall').prop('checked',true);
            }
        }else{
            $('#agree0'+agId).val('');
            if($('#terms_chkall').prop('checked')){
                $('#terms_chkall').prop('checked',false);
            }
        }
    }
    
    /*
    * 내용   : [BUTTON - 일반] 휴대폰 인증 후 확인 클릭 시 !!
    * 개발자 : 김예지
    */
    $scope.chkAgree = function(){
        for(var i=1;i<4;i++){
            $scope.labText = $('#agree0'+i+'Lab').text();
            if($('#agree0'+i).val() == ''){
                alertify.alert($scope.labText+'는 필수 체크 입니다.');
                return false;
            }else if($('#agree01').val() != '' && $('#agree02').val() != '' && $('#agree03').val() != ''){
                ITCButton.getPopup('.phonePop').open();
            }
        }
    }
    
}])

$(document).ready(function() {
    
    $('#agreeFrm').on('submit', function(e){
    	//openKMCISWindow();       
    })
    
    /*
     * 내용   : [CHECK BOX] 일반 - 일괄 동의 클릭 시 !!
     * 개발자 : 김예지
     */
    $('#terms_chkall').click(function(){
        if($('#terms_chkall').prop('checked')){
            for(var i=1;i<5;i++){
                $('#agree0'+i).prop('checked',true);
                $('#agree0'+i).val('Y');
            }
        }else{
            for(var i=1;i<5;i++){
                $('#agree0'+i).prop('checked',false);
                $('#agree0'+i).val('');
            }
        }
    })
});


function __closeCallback(data){
	location.href = BNK_CTX + "/front/common/memberJoin?" + $.param(data);
}
</script>