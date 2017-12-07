<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script>
bnkApp.controller(CTRL_NAME, ['$scope', '$http', '$filter', '$util', '$localstorage', function($scope, $http, $filter, $util, $localstorage){
	
/* ####################################################################################	
 * ## 멤버 초기값 설정													  				 ##
 * #################################################################################### */
 
	$scope.carList = [];		// 차량 리스트
	$scope.oPageInfo = {
			'data': {},
			'totListSize': 0,	// 전체 리스트 갯수
			'currentPageNo': 1,	// 현재 페이지 번호 
			'bLoad': false, 	// 데이터 로딩 상태 여부
			'bHasMore': false	// 로드할 데이터 여부
		};
	$scope.bShowEmpty = false;	// 데이터 없음 여부
	$scope.bInitializing = true;// 초기화 여부 

	// 퀵검색
	$scope.oSearch = {};				// 퀵검색 객체
	$scope.oParams = {};				// 팝업 파라미터
	$scope.oParams.totListSize  = 0;	// 검색 조획 갯수
	$scope.$parent.type = "certify";
	$scope.$on('onCodeReady', function(){
		$scope.oSearch.oLoadData 	= carCodeQuickSearchList;	// 퀵검색 자동완성을 위한 차량정보
		init();
	});
	
/* #################################################################################### */
 

/* ####################################################################################	
 * ## 이벤트 핸들러 설정													  				 ##
 * #################################################################################### */
	
 	// 팝업 핸들러
	$scope.onPopHandler = function(id, data){
		$scope.oSearch.oConditions = data;				// 퀵검색 동기화
		$scope.pageInit();								// 페이지 초기화
		getList();										// 리스트 조회
	};
	
	// 더보기 이벤트
	$util.lastItem(function () {
		if ( !$scope.oPageInfo.bLoad && $scope.oPageInfo.bHasMore ) {
			$scope.oPageInfo.currentPageNo++;	// 페이지번호 증가
			getList();	// 리스트 조회
		}
	});
	
	// 퀵검색 정렬순서 이벤트
	$scope.oSearch.sortChange = function(){
		ITCButton.getPopup('.detailSearch').init();	// 팝업 검색조건 초기화 설정
		$scope.pageInit();							// 페이지정보 초기화
		getList();									// 리스트 조회
	};
	
	// 퀵검색 자동완성 핸들러
	$scope.onQuickSearchHandler = function(oData, oArr){
		var condition = angular.extend(oData.originalObject, {id:'SEARCH_WORD_CAR'});
		$scope.oSearch.oConditions.push(condition);	// 검색조건 추가
		$scope.pageInit();							// 페이지정보 초기화
		getList();									// 리스트 조회
	};
	
	// 퀵검색 초기화 핸들러
	$scope.onQuickInitHandler = function(){
		$scope.oSearch.oConditions = [];			// 퀵검색 초기화
		$scope.oSearch.sort = 'T1.CREATED_DATE DESC';	// 퀵검색 정렬순서
		$scope.pageInit();							// 페이지정보 초기화
		getList();									// 리스트 조회
	};
	
	// 퀵검색 단어삭제 핸들러
	$scope.onQuickDeleteHandler = function(idx){
		$scope.oSearch.oConditions.splice(idx,1);	// 검색조건 삭제
		$scope.pageInit();							// 페이지정보 초기화
		getList();									// 리스트 조회
	};
 
/* #################################################################################### */

 
/* ####################################################################################	
 * ## API 요청	  													  				 ##
 * #################################################################################### */
 
	// 매물 리스트 조회
	var getList = function(){
		$scope.oPageInfo.bLoad = true;
		
		// 파라미터 셋팅
		var oParams = {};										// 상세검색 조건
		oParams.curPage = $scope.oPageInfo.currentPageNo;		// 페이지 번호
		oParams.oConditions = $scope.oSearch.oConditions;		// 퀵검색 조건
		oParams.sortField = $scope.oSearch.sort;
		
		/* AJAX 통신 처리 */
		$http({
			method: 'POST',
			url: '<c:url value="/api/car/list/certify"/>',
			data: JSON.stringify(oParams)
		})
		.success(function(oRes){
			/* 성공적으로 결과 데이터가 넘어 왔을 때 처리 */
			if(oRes.code == "00"){
				// 조회 리스트 추가
				$.merge($scope.carList, oRes.data.list);
				// 차량리스트가 없을 경우
				$scope.bShowEmpty = $scope.carList.length < 1 && $scope.oPageInfo.currentPageNo == 1 ? true : false;
				// 더보기
				$scope.oPageInfo.totListSize = oRes.data.totListSize;
				$scope.oPageInfo.bHasMore = oRes.data.hasMoreList;
				// 상세검색
				$scope.oParams.totListSize  = $scope.oPageInfo.totListSize;	// 검색 조획 갯수
				$scope.oParams.oConditions = $scope.oSearch.oConditions;	// 상세검색 조건 동기화
				ITCButton.getPopup('.detailSearch').init();					// 팝업 검색조건 초기화 설정
				// 검색조건 로컬스토리지 저장 [검색조건, 정렬순서]
				$localstorage.set('oSearch', {oConditions: [], sort: $scope.oSearch.sort});
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

/* #################################################################################### */	


/* ####################################################################################	
 * ## Helper Function												  				 ##
 * #################################################################################### */
	
 	// 페이지정보 초기화
	$scope.pageInit = function(){
		$scope.carList = [];					// 차량 리스트
		$scope.oPageInfo.totListSize = 0;		// 전체 리스트 갯수
		$scope.oPageInfo.data = {};				// 검색조건 파라미터
		$scope.oPageInfo.currentPageNo = 1;		// 현재 페이지 번호	
		$scope.oPageInfo.bLoad = false;			// 데이터 로딩 상태 여부
		$scope.bInitializing = true;			// 초기화 여부
		$scope.oPageInfo.bHasMore = false;		// 로드할 데이터 여부
	};
 
/* #################################################################################### */

	// 초기 메서드 실행
	var init = function(){
		$localstorage.get('oSearch',{}).then(function(oSearch){
			angular.extend($scope.oSearch, oSearch);	// 퀵검색 객체
			$scope.oSearch.oConditions 	= []; 		// 퀵검색 검색조건 담을 배열
			//$scope.oSearch.sort			= $util.nvl($scope.oSearch.sort, 'T1.CREATED_DATE DESC');	// 퀵검색 정렬순서
			getList();
			$util.moveScroll(0);
		});	
	}
	
	// 찜하기
	$scope.onClick=function(code,car){
		switch(code){
			case 'BTN_DETAIL_POP':
				ITCButton.getPopup('.detailSearch').open();
				ITCButton.getPopup('.detailSearch').init();	// 팝업 검색조건 초기화 설정
				break;
			case 'DIBS_ON':
				$util.getDibsOnCar(car);
			break;
		}
	}
}]);
</script>