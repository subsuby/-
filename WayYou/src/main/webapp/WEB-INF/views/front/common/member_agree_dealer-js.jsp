<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
bnkApp.controller(CTRL_NAME, ['$scope', '$http', function($scope, $http){
    
    $scope.oParams = {'aaa':'aaa'};
    $scope.onLoadDealer=function(id, data){
    }
    
    $scope.onPopupOpen = function(){
        $scope.chkAgreeDealer();
    };
    
    $scope.divId = 'D';
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
        if($("input:checkbox[id='agreeD0"+agId+"']").is(":checked")){
            $('#agreeD0'+agId).val('Y');
            if($('#agreeD01').val() != '' && $('#agreeD02').val() != '' && $('#agreeD03').val() != '' && $('#agreeD04').val() != ''){
                $('#terms_chkall_dealer').prop('checked',true);
            }
        }else{
            $('#agreeD0'+agId).val('');
            if($('#terms_chkall_dealer').prop('checked')){
                $('#terms_chkall_dealer').prop('checked',false);
            }
        }
    }
    
    /*
    * 내용   : [BUTTON - 딜러] 휴대폰 인증 후 확인 클릭 시 !!
    * 개발자 : 김예지
    */
    $scope.chkAgreeDealer = function(){
        for(var i=1;i<4;i++){
            $scope.labText = $('#agreeD0'+i+'Lab').text();
            if($('#agreeD0'+i).val() == ''){
                alertify.alert($scope.labText+'는 필수 체크 입니다.');
                return false;
            }else if($('#agreeD01').val() != '' && $('#agreeD02').val() != '' && $('#agreeD03').val() != ''){
                $('#joinDealer').trigger('click');
            }
        }
    }
    
}])

$(document).ready(function() {
    
    $('#agreeFrm').on('submit', function(e){
        e.preventDefault();
    })
    /*
     * 내용   : [CHECK BOX] 딜러 - 일괄 동의 클릭 시 !!
     * 개발자 : 김예지
     */
    $('#terms_chkall_dealer').click(function(){
        if($('#terms_chkall_dealer').prop('checked')){
            for(var i=1;i<5;i++){
                $('#agreeD0'+i).prop('checked',true);
                $('#agreeD0'+i).val('Y');
            }
        }else{
            for(var i=1;i<5;i++){
                $('#agreeD0'+i).prop('checked',false);
                $('#agreeD0'+i).val('');
            }
        }
    })
});


function __closeCallback(data){
	location.href = BNK_CTX + "/front/common/memberJoinDealer?" + $.param(data);
}


</script>