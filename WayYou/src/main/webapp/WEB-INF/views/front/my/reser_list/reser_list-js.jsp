<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
bnkApp.controller(CTRL_NAME, ['$scope', '$http', '$util', '$timeout', '$filter', function($scope, $http, $util, $timeout, $filter){


	$scope.$on('onCodeReady', function (event, data) {
		$scope.shopCodeInfoMap		=	shopCodeInfoMap;
		$scope.resTypeCodeList		=	resTypeCodeList;
		$scope.resStatusCodeList	=	resStatusCodeList;
	});


	$scope.car = {};
	$scope.oParams = {};
	$scope.resList = [];
	$scope.resInit = function(){
		$timeout(function(){
			ITCButton.setupTypeAccordion();	//아코디언 초기화
// 			ITCButton.setupTypePopup();		// 팝업 설정
		},500);
	}

	$scope.setDealerInfo = function(res){
		angular.merge($scope.car, res.carInfo);
		ITCButton.getPopup('.popWrapMap').open();
	}
	$scope.openPopup = function(res){
		angular.merge($scope.car, res.carInfo);
		ITCButton.getPopup('.dealerDetail').open();
	}

	$scope.resConditions = [ {checked:false, label:'방문', value:'1'} , {checked:false, label:'시승',value:'2'} , {checked:false, label:'탁송', value:'3'}];
	$scope.schConditions = [];
	$scope.test= function(){
		$scope.schConditions = [];
		$scope.resConditions.forEach(function(condition){
			if(condition.checked){
				$scope.schConditions.push(condition.value);
			}
		});
		$scope.getReserList();
	}

	$scope.shopCodeInfoMap = shopCodeInfoMap;
	$scope.getReserList = function(){
		$http({
			method: 'POST'
			, url: BNK_CTX+'/front/my/reserList/ajax'
			, data: JSON.stringify({
				resUserId: '${sessUserInfo.userId}'
				, schConditions: $scope.schConditions
			})
		})
		.success(function(data){
			$scope.resList = data;
		})
		.error(function(){
			console.log('리스트 불러오기 중 오류');
		});
	}
	$scope.cancelReserve = function(res){
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
	}
	// 취소요청을 누를때
	$scope.cancelPop = function(){
		ITCButton.getPopup('.cancelPopup').open();
	}
	
	// 승인버튼을 누를때
	$scope.confirmReserve = function(res){
		$scope.isLogin({
			success: function(){
				
				$scope.oParams.res = res;
				
				var timePop = ITCButton.getPopup('.reserTimeConfirm').open();
				timePop.onCompleteHandle = function(data){
					$scope.getReserList();
				};
			},
			fail: function(){
				alertify.confirm('로그인이 필요한 페이지입니다.\n로그인하시겠습니까?', function(){ ITCButton.getPopup('.loginPop').open(); });
			}
		});
	}

	$scope.getReserList();

}])
</script>