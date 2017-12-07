<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
bnkApp.controller(CTRL_NAME, ['$scope', '$http', '$util', '$timeout', function($scope, $http, $util, $timeout){



	$scope.user = {};
	$scope.getNameCard = function(){
		$http({method:'POST', url:BNK_CTX + '/api/user/nameCardProfileInfo'})
		.success(function(data){
			if(data.resCd == '00'){
				var oUser = $util.nvl(data.user, {});
				$scope.user.userId = oUser.userId;
				$scope.user.userName = oUser.userName;
				$scope.user.dealerLicenseNo = oUser.dealerLicenseNo;
				$scope.user.dealerProfileFileSeq = oUser.dealerProfileFileSeq;
				$scope.user.dealerProfileDesc = oUser.dealerProfileDesc;
				$scope.user.dealerProfileTel = oUser.dealerProfileTel;
				$scope.user.dealerDanjiName = oUser.dealerDanjiName;
				$scope.user.dealerShopName = oUser.dealerShopName;
				$scope.user.phoneNumMask = oUser.phoneNumMask;

			}else if(data.resCd == '99'){

			}
		})
		.error(function(){
		});
	};

	$scope.modifyClick = function (){
		$scope.$parent.cardParams = $scope.user;
		ITCButton.getPopup('.businesscard2').init();
		var cardPopup = ITCButton.getPopup('.businesscard2').open();
		cardPopup.onCompleteHandle = function(){
			$scope.getNameCard();
		};
	}

	$scope.sendClick = function(){
		// 푸시전송 하기전 어떤 화면에서 넘어왔는지 값을 전달한다.
		$("#type").val("N");			// N: 명함
		var cardSendPopup = ITCButton.getPopup('.popSend').open();
		cardSendPopup.onCompleteHandle = function(data){
			$scope.$this.close();
		};
	};
}]);
</script>