<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
bnkApp.controller(CTRL_NAME, ['$scope', '$http', '$timeout', '$util', function($scope, $http, $timeout, $util){

	$scope.init = function(){
		$scope.oParams = {};
		$scope.oParams.reverAuctionInfo = null;
		$scope.$watch('sessUserInfo.userId', function(){
		});
			$scope.getInfo();

	}

	$scope.onOpenPopup = function(code){
		switch(code){
		case 'REG_POP' :
			$scope.isLogin({
				success: function(){
					ITCButton.getPopup('.likeRecord').open();
				},
				fail: function(){
					alertify.confirm('로그인이 필요한 페이지입니다.\n로그인하시겠습니까?', function(){ ITCButton.getPopup('.loginPop').open(); });
				}
			});
		}

	}

	//내게맞는매물 정보
	$scope.getInfo = function(){
		$http({
			url: BNK_CTX + '/front/my/reverseAuction/getInfo'
			, method: 'GET'
		}).then(successCallback, errorCallback);
		function successCallback(json){
			if(json.data.resCd=='00'){
				$scope.oParams.reverAuctionInfo = json.data.reverAuctionInfo;
			}
		}
		function errorCallback(data){

		}
	}
	//내게맞는매물정보 삭제
	$scope.delInfo = function(){
		alertify.confirm('내게맞는 매물정보를 삭제하시겠습니까?', function(){
			var params={
					makerCd : $scope.oParams.reverAuctionInfo.makerCd
					, modelCd : $scope.oParams.reverAuctionInfo.modelCd
					, detailModelCd : $scope.oParams.reverAuctionInfo.detailModelCd
				};
			$http({
				url: BNK_CTX + '/front/my/reverseAuction/delInfo'
				, method: 'POST'
				, data: JSON.stringify(params)
			}).then(successCallback, errorCallback);
			function successCallback(data){
				$scope.getInfo();
			}
			function errorCallback(data){

			}
		});
	}
}]);
</script>