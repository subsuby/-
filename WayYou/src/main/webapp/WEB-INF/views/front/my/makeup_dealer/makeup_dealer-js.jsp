<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
bnkApp.controller(CTRL_NAME, ['$scope', '$http', '$filter', '$util', '$localstorage', function($scope, $http, $filter, $util, $localstorage){

	// 서비스 옵션 코드
	$scope.$on('onCodeReady', function (event, data) {
		$scope.makeupStatusCodeList = makeupStatusCodeList;
		$scope.makeupTypeCodeList = makeupTypeCodeList;
	});

	// 멤버 초기값 설정
	$scope.list = [];

	// 매물 리스트 조회
	var getList = function(){
		/* AJAX 통신 처리 */
		$http.get('<c:url value="/front/my/makeupDealer/list"/>')
		.success(function(data){
			console.log(data);
			/* 성공적으로 결과 데이터가 넘어 왔을 때 처리 */
			if(data.resCd == "00"){
				// 조회 리스트 추가
				$.merge($scope.list, data.list);
				// 리스트가 있을시 첫번째 리스트 선택
				if($scope.list.length > 0){
					$scope.makeupView(0);
				}
			}
			/* 통신한 URL에서 데이터가 넘어오지 않았을 때 처리 */
			else{
				alertify.alert("데이터 전송도중 오류가 발생하였습니다.")
			}
		})
		.error(function(data, status, headers, config) {
			console.log(status);
		});
	};

	// 초기 메서드 실행
	var init = function(){
		getList();
		$util.moveScroll(0);
	}
	init();

	$scope.makeupView = function(idx){

		//선택 된 리스트 클래스 on
		$scope.selectedData = $scope.list[idx];

		//해당 리스트에 대한 데이터 출력
		$scope.list.carPlateNum = $scope.selectedData.carPlateNum;
		$scope.list.reqRemark 	= $scope.selectedData.reqRemark;
		$scope.list.visitDay 	= $scope.selectedData.visitDay;
		$scope.list.visitTime 	= $scope.selectedData.visitTime;
		$scope.list.visitAddr 	= $scope.selectedData.visitAddr;
		$scope.list.visitorNm 	= $scope.selectedData.visitorNm;
		$scope.list.visitorTel 	= $scope.selectedData.visitorTel;
		$scope.list.reqItemArr	= $scope.selectedData.reqItemArr;

		//체크박스 설정
		$scope.enableOptionCd = function(optCd){
			var enabled = false;
			var optList = $scope.list.reqItemArr;

			if($util.isNotEmpty(optList)){
				optList.forEach(function(opt){
					if(opt == optCd){
						enabled = true;
					}
				});
			}
			return enabled;
		}
	}

	$scope.onClick = function(){
		var makeupPopup = ITCButton.getPopup('.makeupWriteDealer').open();
		makeupPopup.onCompleteHandle = function(){
			$scope.list = [];
			init();
		}
	}
}]);
</script>