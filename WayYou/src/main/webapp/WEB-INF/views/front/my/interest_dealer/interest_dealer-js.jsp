<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
bnkApp.controller(CTRL_NAME, ['$scope', '$http', '$filter', '$util', '$timeout', function($scope, $http, $filter, $util, $timeout){
	$scope.list =[];
	$('.dealerList .rating').rateit()
	$scope.$on('onCodeReady', function (event, data) {
		$scope.shopCodeInfoMap=shopCodeInfoMap;
	});

	$scope.templateInit = function(){
		angular.element('#profileRateit').rateit();
		init();
	};

	$scope.oPageInfo = {
			'currentPageNo': 1,	// 현재 페이지 번호
			'bLoad': false, 	// 데이터 로딩 상태 여부
			'bHasMore': false	// 로드할 데이터 여부
		};
	$scope.bShowEmpty = false;	// 데이터 없음 여부


	$scope.rateitInit = function(){
		$timeout(function(){
			angular.element('.rating').rateit();
		});
	}


	// 리스트 가져오기
	var getList = function(){
		var url = '<c:url value="/front/my/interestDealer/ajax"/>';
		$http.get( url, {
			params: {curPage: $scope.oPageInfo.currentPageNo}
		})
		.success(function(oRes){
			console.log(oRes);
			/* 성공적으로 결과 데이터가 넘어 왔을 때 처리 */
			if(oRes.resCd == "00"){
				// 조회 리스트 추가
				$.merge($scope.list, oRes.list);
				angular.element('#profileRateit').rateit('value', $scope.list.evalAvg);
			}
			/* 통신한 URL에서 데이터가 넘어오지 않았을 때 처리 */
		})
		.error(function(data, status, headers, config) {
			/* 서버와의 연결이 정상적이지 않을 때 처리 */
			console.log(status);
		});

	};
	// 초기 메서드 실행
	var init = function(){
		getList();
	}
	init();

	// 관심딜러 등록 or 삭제
	$scope.onClick = function(code, dealer){
		switch(code){
		case 'INST_DEALER':
			$util.getInterestDealer(dealer);
			break;
		}
		window.location.reload();
	}

	$scope.car={};
	$scope.car.user = {};

	$scope.setDealerInfo = function(dealer){
		angular.merge($scope.car.user, dealer);
	}

	$scope.openPopup = function(dealer){
		angular.merge($scope.car.user, dealer);
		ITCButton.getPopup('.dealerDetail').open();
	}
}])
//딜러 평가평균점수
.filter('dealerScore',function(){
	return function(input){
		var out='0';
		if(angular.isArray(input)){
			var sum = 0;
			input.forEach(function(obj) {
				sum += obj.rating * 1;
			});
			out = sum/input.length;
		}
		return out;
	}
})
//딜러 평가평균점수 퍼센트화
.filter('dealerScorePer',function(){
	return function(input){
		var out='0%';
		if(angular.isNumber(input*1)){
			out = input / 5 * 100 + '%';
		}
		return out;
	}
})
</script>