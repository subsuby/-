<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script>
bnkApp.controller(CTRL_NAME, ['$rootScope', '$scope', '$http', '$filter', '$util', '$timeout', '$localstorage', function($rootScope, $scope, $http, $filter, $util, $timeout,$localstorage){
	
	$localstorage.get('tempParams',{}).then(function(param){
		$scope.car ={};
		$scope.car = JSON.parse(param.oCar);
		//BNK 시세 데이터 테스트 [S]
		$scope.priceParam = {};
		$scope.priceParam = $scope.car;
		$scope.priceParam.type = 'S';	// 내차팔기에서 넘어간경우
		//BNK 시세 데이터 테스트 [E]
	});	
	
	$scope.division = "";
	$scope.onLoad = function(id, data){
		
	}
	
	$scope.onClick = function(){
		// 내차정보 등록 버튼을 클릭했을때
		$scope.isLogin({
			success: function(){
				var url = "";
				if($scope.sessUserInfo.division == "N"){
					url = '<c:url value="/front/my/mycar"/>';	
				}else{
					url = '<c:url value="/front/my/mycarDealer"/>';
				}
				
				$timeout(function() {
					$scope.car.type='move';				//타입
					$localstorage.set('tempParams', {oCar: JSON.stringify($scope.car)});
					location.href = url;
	    		}, 500);
			},
			fail: function(){
				alertify.confirm('로그인이 필요한 페이지입니다.\n로그인하시겠습니까?', function(){ ITCButton.getPopup('.loginPop').open(); });
			}
		});
	}
	
}]);
</script>