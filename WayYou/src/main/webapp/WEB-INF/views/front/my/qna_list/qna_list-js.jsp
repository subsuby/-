<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
bnkApp.controller(CTRL_NAME, ['$scope', '$http', '$util', '$timeout', '$sce', function($scope, $http, $util, $timeout, $sce){

	$scope.list =[];

	$scope.resInit = function(){
		$timeout(function(){
			ITCButton.setupTypeAccordion();	//아코디언 초기화
// 			ITCButton.setupTypePopup();		// 팝업 설정
		},500);
	}

	$scope.totBlockSize = 0;

	$scope.oPageInfo = {
			'currentPageNo': 1,	// 현재 페이지 번호
			'bLoad': false, 	// 데이터 로딩 상태 여부
			'bHasMore': false	// 로드할 데이터 여부
	};

	$scope.bShowEmpty = false;

	//리스트 조회
	$scope.getList= function(){
		$scope.oPageInfo.bLoad = true;

		var url = '<c:url value="/front/my/qnaList/ajax"/>';
		$http({
			url: url
			, method: 'POST'
			, async: false
			, headers: { 'Content-Type': 'application/json'}
			, data : JSON.stringify({
				curPage	: $scope.oPageInfo.currentPageNo
			})
		}).success(function(data, status, headers, config){
			$scope.totBlockSize = data.qnaInfo.totBlockSize;
			// 조회 리스트 추가
			$.merge($scope.list, data.list);

			// 차량리스트가 없을 경우
			$scope.bShowEmpty = $scope.list.length < 1 && $scope.oPageInfo.currentPageNo == 1 ? true : false;

			// 더보기
			$scope.oPageInfo.bLoad = false;

// 			$scope.oPageInfo.bHasMore = data.hasMoreList;
			if($scope.oPageInfo.currentPageNo != $scope.totBlockSize){
				$scope.oPageInfo.bHasMore = data.hasMoreList;
			}else{
				data.hasMoreList = false;
				$scope.oPageInfo.bHasMore = data.hasMoreList;
			}

		}).error(function(data, status, headers, config) {
			$scope.oPageInfo.bLoad = false;
		});
	}

	$scope.temFn = function(){
		fn_CommonJS_isRunning = false;
		fn_CommonJS();
	}

	// 토글창 열고 닫기
	$scope.openToggle = function(no){
		var target = $(".accordionSet:nth-of-type("+(no.$index+1)+")");

		if(target.hasClass("on")){
			target.removeClass("on");
		}else{
			target.addClass("on");
		}
	}

	// 더보기 이벤트 핸들러 등록 (더보기 기능)
// 	$util.lastItem(function () {
// 		if ( !$scope.oPageInfo.bLoad && $scope.oPageInfo.bHasMore ) {
// 			$scope.oPageInfo.currentPageNo++;
// 			$scope.getList();
// 		}
// 	});
		$util.lastItem(function () {
		if($scope.oPageInfo.currentPageNo != $scope.totBlockSize){
			if ( !$scope.oPageInfo.bLoad && $scope.oPageInfo.bHasMore )
				$scope.oPageInfo.currentPageNo++;
				$scope.getList();
		}else{
			$scope.oPageInfo.bHasMore = false;
		}
	});

	// 초기 메서드 실행
	var init = function(){
		$scope.getList();
		$util.moveScroll(0);
	}
	init();

	$scope.onClick = function(){
		var qnaPopup = ITCButton.getPopup('.popWrapQWrite').open();
		qnaPopup.onCompleteHandle = function(){
			$scope.list = [];
			init();
		}
	}
}])
.filter('newLine', function($util, $sce){
	return function(input){
		var out = '';
		if($util.isNotEmpty(input)){
			out = $sce.trustAsHtml(input.replace(/\n/gi, '<br/>'));
		}
		return out;
	}
});
</script>