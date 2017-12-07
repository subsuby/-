<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
bnkApp.controller(CTRL_NAME, ['$scope', '$http', '$util', '$timeout', function($scope, $http, $util, $timeout){
	
	$scope.getList = function(){
		var carPlateNum = $.trim($("#carPlateNum").val());
		
        $http({
            url: "<c:url value='/front/my/costList/ajax'></c:url>"
            , method: 'POST'
            , async: false
            , headers: { 'Content-Type': 'application/json'}
            , params: {"carPlateNum": carPlateNum}
        }).success(function(oRes){
            if(oRes.resCd == "00"){
            	if(oRes.data.length == 0){
            		$(".noRecord").show();
            		$(".quotationList").hide();
            		return;
            	}
            	$(".noRecord").hide();
        		$(".quotationList").show();
        		
                $scope.costList = oRes.data;
            }
        }).error(function(data, status, headers, config) {
        });
    }
	
	$scope.carQuotationSearch = function(){
		$scope.getList();
	}
	
	$scope.searchDetail = function(seq){
        $scope.oParams.chkListSeq	= seq;
		$scope.oParams.state 		= "mycar";
		
		ITCButton.getPopup('.popWrapCost2').init();
		ITCButton.getPopup('.popWrapCost2').open();
	}
	
	
	   // 초기 메서드 실행
    var init = function(){
    	$scope.oParams = {};
    	$scope.costList = {};
        $scope.getList();
    }
    
    angular.element(document).ready(function(){
        init();
    });	
	
}]);
</script>