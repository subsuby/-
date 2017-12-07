<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
bnkApp.controller(CTRL_NAME, ['$scope', '$http', '$util', '$timeout', function($scope, $http, $util, $timeout){

	// 체크리스트 데이터를 가져온다.

	$scope.checkList ={};
	$scope.oParams = {};

	$scope.onClick = function(items,userName,createdDate){
        //체크리스트
            $scope.oParams.division     = "${sessUserInfo.division}";
            $scope.oParams.items        = items;
            $scope.oParams.userName     = userName;
            $scope.oParams.createdDate  = createdDate;
            ITCButton.getPopup('.popCheckDealerList').open();
    }

	$scope.getList = function(){
        $http({
            url: "<c:url value='/front/my/checkDealer/ajax'></c:url>"
            , method: 'POST'
            , async: false
            , headers: { 'Content-Type': 'application/json'}
            , data :JSON.stringify({schValue : $scope.schValue})
        }).success(function(oRes){
            if(oRes.resCd == "00"){
                $scope.checkList = oRes.data;
                console.log(JSON.stringify($scope.checkList));
            }
        }).error(function(data, status, headers, config) {
        });
    }

    // 초기 메서드 실행
    var init = function(){
        $scope.getList();

    }

    angular.element(document).ready(function(){
            init();
    });



}]);
</script>