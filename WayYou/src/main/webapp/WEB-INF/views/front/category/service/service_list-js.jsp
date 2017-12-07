<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script>
bnkApp.controller(CTRL_NAME, ['$scope', '$http', '$filter', '$util', '$localstorage', '$timeout', function($scope, $http, $filter, $util, $localstorage, $timeout){

/* ####################################################################################
 * ## 멤버 초기값 설정													  				 ##
 * #################################################################################### */

	$scope.carList = [];		// 차량 리스트
	$scope.userDealerList = [];
	$scope.danjiNo = '';
	$scope.oPageInfo = {
			'data': {},
			'totListSize': 0,	// 전체 리스트 갯수
			'currentPageNo': 1,	// 현재 페이지 번호
			'bLoad': false, 	// 데이터 로딩 상태 여부
			'bHasMore': false	// 로드할 데이터 여부
		};
	$scope.bShowEmpty = false;	// 데이터 없음 여부
	$scope.bInitializing = true;// 초기화 여부
	$timeout(function(){$scope.bInitializing = false;},3000);

	// 퀵검색
	$scope.oSearch = {};				// 퀵검색 객체
	$scope.oParams = {};				// 팝업 파라미터
	$scope.oParams.totListSize  = 0;	// 검색 조획 갯수
	$scope.$parent.type = "serviceList";
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
		$scope.$parent.danjiNo = $scope.danjiNo;				// 위치서비스의 가장 가까운 단지정보로 조회
		oParams.danjiNo = $scope.danjiNo;
		oParams.curPage = $scope.oPageInfo.currentPageNo;		// 페이지 번호
		oParams.oConditions = $scope.oSearch.oConditions;		// 퀵검색 조건
		oParams.sortField = $scope.oSearch.sort;

		/* AJAX 통신 처리 */
		$http({
			method: 'POST',
			url: '<c:url value="/api/car/list/serviceList"/>',
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
		//$scope.location = false;	// 임시로 위치서비스 켜기 끄기(true:켜기, false:끄기)
		//$scope.danjiNo = "${sessUserInfo.danjiNo}";

		$localstorage.get('oSearch',{}).then(function(oSearch){
			angular.extend($scope.oSearch, oSearch);	// 퀵검색 객체
			$scope.oSearch.oConditions 	= []; 		// 퀵검색 검색조건 담을 배열
			//$scope.oSearch.sort			= $util.nvl($scope.oSearch.sort, 'T1.CREATED_DATE DESC');	// 퀵검색 정렬순서
			$util.moveScroll(0);
		});
	}

	// 위치서비스가 켜져있는 지  여부를 확인한다.
	$scope.locationChk = function(lat, long){
		if($scope.location){	// 위치서비스가 켜져있을때
			// 확인은 새로고침, 취소는 내차사기로 이동
		    $http({
            	url: "<c:url value='/api/user/dealerProfileList'></c:url>"
            	, method: 'POST'
            	, async: true
            	, headers: { 'Content-Type': 'application/json'}
            	, params:{'lat' : lat, 'lag' : long}
        	}).success(function(oRes){
            	if(oRes.resCd == "00"){
            		$scope.danjiSido = oRes.data.danjiSido;
            		$scope.danjiCity = oRes.data.danjiCity;
            		$scope.danjiFullName = oRes.data.danjiFullName;
            		$scope.userDealerList = oRes.data.list;
            		$scope.danjiNo = oRes.data.danjiNo;

					$("#contents").removeClass("qSCaseNone");
					$("#contents").addClass("qSCase");
					$(".locationOn").show();
					$(".locationOff").hide();

					if($scope.userDealerList.length == 0){
						$("#contents").css("padding-top" , "82px");
					}
					getList();
            	}
        	}).error(function(data, status, headers, config) {
        	});

		}else{			// 위치서비스가 꺼져있을때
			$("#contents").addClass("qSCaseNone");
			$("#contents").removeClass("qSCase");
			$(".locationOn").hide();
			$(".locationOff").show();
			getList();
		}
	}

	$scope.dealerOpen = function(userId){
		if(typeof userId == 'undefined'){
			return;
		}
		var promise = $http({
			url: BNK_CTX + '/api/user/dealerProfileInfo'
			, method: 'POST'
			, data: JSON.stringify({userId: userId})
		});

		promise.then(success, error);

		function success(json){
			$scope.oParams.user = json.data.user;
			ITCButton.getPopup('.dealerDetail').open();
		}
		function error(){
			console.log('딜러 정보 가져오기 실패..');
		}
	}

	// 위치서비스 켜기 버튼을 눌렀을때
	$scope.locationOn = function(){
		$scope.carList = [];
		/* $("#contents").removeClass("qSCaseNone");
		$("#contents").addClass("qSCase");
		$(".locationOn").show();
		$(".locationOff").hide(); */

		// 안드로이드 위치서비스 설정 호출
		if($util.getOS() == 'android'){
			AndroidInterface.gpsChk();
		}
		// 아이폰 위치서비스 설정 호출
		else if($util.getOS() == 'ios'){
			location.href = 'bnk://system.locationStatus';
		}

		// 위치서비스를 정상적으로 켠 후
		// 현재 위치와 가장 가까운 딜러를 찾아서 새롭게 리스트를 뿌려줘야함.
		// * 2017-07-04 CJJ 임시로 4명의 딜러 보여주게 세팅 '208','241','297','314'

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

	$scope.reloadBtn = function(){
		$scope.carList = [];
		window.location.href = '<c:url value="/front/category/service/serviceList"/>';
	}

}]);

// 안드로이드에서 gps가 연결되어있지 않을때 호출하는 함
function getServiceList(){
	//console.log("getServiceList ******************");
	var vm = angular.element(document.getElementById('wrap')).scope();
	vm.location = false;
	vm.locationChk(0, 0);
	vm.$apply();
}

function locationOk(lat, long){
	//console.log("lat ******************" + lat);
	//console.log("long ******************" + long);
	if(lat == 0){
		alertify.confirm("gps 위치가 확인 되지 않습니다..\n다시 시도하시겠습니까?", function (e) {
		    if (e) {
		    	window.location.reload();	// user clicked "ok"
		    } else {
		    	window.location.href = '<c:url value="/front/mycar/buyList"/>';
		    }
		});
	}else{
		var vm = angular.element(document.getElementById('wrap')).scope();
		vm.location = true;
		vm.locationChk(lat, long);
		vm.$apply();
	}
}
</script>