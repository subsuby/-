<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
bnkApp.controller(CTRL_NAME, ['$scope', '$http', '$filter', '$util', function($scope, $http, $filter, $util){

	$scope.carList = [];
	$scope.oPageInfo = {
			'data': {},
			'totListSize': 0,	// 전체 리스트 갯수
			'currentPageNo': 1,	// 현재 페이지 번호 
			'bLoad': false, 	// 데이터 로딩 상태 여부
			'bHasMore': false	// 로드할 데이터 여부
		};
	$scope.bShowEmpty = false;	// 데이터 없음 여부
	$scope.bInitializing = true;// 초기화 여부 
	
	// 더보기 이벤트
	$util.lastItem(function () {
		if ( !$scope.oPageInfo.bLoad && $scope.oPageInfo.bHasMore ) {
			$scope.oPageInfo.currentPageNo++;	// 페이지번호 증가
			getList();	// 리스트 조회
		}
	});

	// 매물 리스트 조회
	var getList = function(){
		$scope.oPageInfo.bLoad = true;
		
		var oParams = {};
		oParams.curPage = $scope.oPageInfo.currentPageNo;
		
		$http({
			method: 'POST',
			url: '<c:url value="/api/car/list/interestCar"/>',
			data: JSON.stringify(oParams)
		})
		.success(function(data){
			console.log(data);
			/* 성공적으로 결과 데이터가 넘어 왔을 때 처리 */
			if(data.code == '00'){
				// 조회 리스트 추가
				$.merge($scope.carList, data.data.list);
				// 차량리스트가 없을 경우
				$scope.bShowEmpty = $scope.carList.length < 1 && $scope.oPageInfo.currentPageNo == 1 ? true : false;
				// 더보기
				$scope.oPageInfo.totListSize = data.data.totListSize;
				$scope.oPageInfo.bHasMore = data.data.hasMoreList;
			}
			$scope.oPageInfo.bLoad = false;
			$scope.bInitializing = false;
		})
		.error(function(data, status, headers, config) {
			/* 서버와의 연결이 정상적이지 않을 때 처리 */
			$scope.oPageInfo.bLoad = false;
			$scope.bInitializing = false;
			console.log(status);
		});
	};
	
	// 초기 메서드 실행
	var init = function(){
		getList();
		$util.moveScroll(0);
	}
	init();
	
	// 찜하기
	$scope.onClick=function(code,car){
		switch(code){
		case 'DIBS_ON':		//찜하기
			$util.getDibsOnCar(car);
			break;
		}
		window.location.reload();
	}
}]);
</script>