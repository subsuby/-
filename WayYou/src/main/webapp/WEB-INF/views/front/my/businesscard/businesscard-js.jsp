<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
bnkApp.controller(CTRL_NAME, ['$scope', '$http', '$util', '$timeout', function($scope, $http, $util, $timeout){

	//데이터 초기화
	$scope.list =[];
	$scope.search = {};
	$scope.search.schValue='';

	// 리스트 가져오기
	$scope.getList = function(){
		$http({
			url : BNK_CTX + "/front/my/businesscard/list",
			method : 'POST',
			data : JSON.stringify({
				schValue : $scope.search.schValue
			})
		}).success(function(data){
			console.log(data);
			if(data.resCd == "00"){
				$.merge($scope.list, data.list);
			}else{
				alertify.alert("데이터를 가져오는중 오류가 발생하였습니다.")
			}
		}).error(function(data){
			alertify.alert("데이터를 가져오는중 오류가 발생하였습니다.")
		});
	};

	var init = function(){
		$scope.getList();
		$util.moveScroll(0);
	}

	// 리스트 호출
	init();

	//검색
	$scope.onClick = function(){
		$scope.search();
	}

	$scope.search = function(){
		$scope.list =[];
		$scope.getList();
	};

	//재발송 시작
	$scope.reSend = function(send){
		console.log(send);
/* 			$http({
				url : BNK_CTX + "/front/my/businesscard/reSend"
				, method : 'POST'
				, data : JSON.stringify({
					nameCardSeq : send.nameCardSeq
					, userId : send.userId
				})
			}).success(function(data){
				if(data.resCd == "00"){
					alertify.alert("재발송 되었습니다.");
				}else{
					alertify.alert("재발송 실패");
				}
			}).error(function(data){
				alertify.alert("요청 실패");
			}); */
		alertify.confirm('재발송 하시겠습니까?', function(){
			$http({
				method:'POST',
				url: BNK_CTX + "/front/my/namecard/register",
				data: JSON.stringify({
					userId : send.userId
				})
			}).success(function(data){
				alertify.alert("전송이 완료되었습니다.");
				$scope.list =[];
				$scope.getList();
			});
		});

	};
}]);
</script>