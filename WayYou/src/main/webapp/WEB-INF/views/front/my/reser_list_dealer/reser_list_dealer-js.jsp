<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
bnkApp.controller(CTRL_NAME, ['$scope', '$http', '$util', '$timeout', '$filter', function($scope, $http, $util, $timeout, $filter){


	$scope.resList=[];
	$scope.oParams = {};

	$scope.getReserList = function(){
		$http({
			method: 'POST'
			, url: BNK_CTX+'/front/my/reserListDealer/ajax'
			, data: JSON.stringify({
				resUserId: '${sessUserInfo.userId}'
			})
		})
		.success(function(data){
			$scope.resList = data;
		})
		.error(function(){
			console.log('리스트 불러오기 중 오류');
		});
	}

	// 승인요청 버튼을 눌렀을 때
	$scope.acceptReserve = function(res){
		$scope.isLogin({
			success: function(){
				if(res.resStatus != '10'){
					alertify.alert('기 승인 또는 거절된 내역은\n재처리가 불가합니다.');
					return;
				}

				$scope.oParams.res = res;

				var timePop = ITCButton.getPopup('.reserTimeChoice').open();
				timePop.onCompleteHandle = function(data){
					$scope.resList=[];
					$scope.getReserList();
				};


				// 팝업을 띄운다.
				/* alertify.confirm('예약을 승인하시겠습니까?', function(){
					$http({
						method: 'POST'
						, url: BNK_CTX+'/api/user/requestCarReserve'
						, data: JSON.stringify({
							resHisSeq: res.resHisSeq
							, resKey: res.resKey
							, resType: res.resType
							, reqStatus: 'accept'
						})
					})
					.success(function(data){
						console.log('방문,시승,탁송 예약 승인 완료');
						$scope.getReserList();
					})
					.error(function(){
						console.log('방문,시승,탁송 예약 승인 중 오류');
					});
				}); */
			},
			fail: function(){
				alertify.confirm('로그인이 필요한 페이지입니다.\n로그인하시겠습니까?', function(){ ITCButton.getPopup('.loginPop').open(); });
			}
		});
	}
	$scope.rejectReserve = function(res){
		$scope.isLogin({
			success: function(){
				/* if(res.resStatus != '10'){
					alertify.alert('기 승인 또는 거절된 내역은\n재처리가 불가합니다.');
					return;
				} */
				alertify.confirm('예약을 거절하시겠습니까?', function(){
					$http({
						method: 'POST'
						, url: BNK_CTX+'/api/user/requestCarReserve'
						, data: JSON.stringify({
							resHisSeq: res.resHisSeq
							, resKey: res.resKey
							, reqStatus: 'reject'
						})
					})
					.success(function(data){
						console.log('방문,시승,탁송 예약 거절 완료');
						$scope.getReserList();
					})
					.error(function(){
						console.log('방문,시승,탁송 예약 거절 중 오류');
					});
				});
			},
			fail: function(){
				alertify.confirm('로그인이 필요한 페이지입니다.\n로그인하시겠습니까?', function(){ ITCButton.getPopup('.loginPop').open(); });
			}
		});
	}
	
	// 취소요청을 누를때
	$scope.cancelPop = function(){
		ITCButton.getPopup('.cancelPopup').open();
	}
	/* $scope.cancelReserve = function(res){
		console.log(res);
		$scope.isLogin({
			success: function(){
				res.resReqDate = $filter('date')(new Date(res.resReqDate), 'yyyyMMddHHmmss');
				$http({
					method: 'POST'
					, url: BNK_CTX+'/api/user/cancelCarReserve'
					, data: JSON.stringify({
						resHisSeq: res.resHisSeq
						, resType: res.resType
						, resKey: res.resKey
					})
				})
				.success(function(data){
					console.log('방문,시승,탁송 예약 취소 완료');
					$scope.getReserList();
				})
				.error(function(){
					console.log('방문,시승,탁송 예약 취소 중 오류');
				});
			},
			fail: function(){
				alertify.confirm('로그인이 필요한 페이지입니다.\n로그인하시겠습니까?', function(){ ITCButton.getPopup('.loginPop').open(); });
			}
		});
	} */


	$scope.getReserList();

}])
</script>