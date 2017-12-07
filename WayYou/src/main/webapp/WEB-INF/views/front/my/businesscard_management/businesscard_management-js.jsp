<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
bnkApp.controller(CTRL_NAME, ['$scope', '$http', '$util', '$timeout', function($scope, $http, $util, $timeout){

	$scope.$on('onCodeReady', function (event, data) {
		$scope.shopCodeInfoMap=shopCodeInfoMap;
	});

	$scope.list =[];
	$scope.search = {};
	$scope.search.schValue='';

	$scope.resInit = function(){
		$timeout(function(){
			ITCButton.setupTypeAccordion();	// 아코디언 초기화
// 			ITCButton.setupTypePopup();		// 팝업 설정
		},500);
	}

	// 리스트 가져오기
	$scope.getList = function(){
		$http({
			url : BNK_CTX + "/front/my/businesscardManagement/list",
			method : 'POST',
			data : JSON.stringify({
				schValue : $scope.search.schValue
			})
		}).success(function(data){
			if(data.resCd == "00"){
				$.merge($scope.list, data.list)
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
	$scope.onClick = function(code, value){
		switch(code){
		case 'BTN_SEARCH':
			$scope.search();
			break;
		case 'BTN_DELETE':
			alertify.confirm("명함을 삭제하시겠습니까?", function(){
				$scope.deleteCard(value);
			});
			break;
		}
	}


	$scope.deleteCard = function(dealer){
		$http({
			url : BNK_CTX + "/front/my/businesscardManagement/delete",
			method : 'POST',
			data : JSON.stringify({
				nameCardSeq : dealer.nameCardSeq
			})
		}).success(function(data){
			if(data.resCd == "00"){
				//TODO:성공
				$scope.list =[];
				$scope.getList();
			}else{
				alertify.alert("데이터를 가져오는중 오류가 발생하였습니다.")
			}
		}).error(function(data){
			alertify.alert("데이터를 가져오는중 오류가 발생하였습니다.")
		});
	}
	$scope.search = function(){
		$scope.list =[];
		$scope.getList();
	};

}]);
</script>