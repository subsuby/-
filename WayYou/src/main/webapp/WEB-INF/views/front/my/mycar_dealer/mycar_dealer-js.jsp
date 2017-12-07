<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
bnkApp.controller(CTRL_NAME, ['$scope', '$http' , '$compile', 'Upload', '$timeout', '$localstorage', '$util', function($scope, $http, $complie, Upload, $timeout, $localstorage, $util){


	$scope.loaded  = false;
	$scope.oParams= {};

// 초기 메서드 실행
		$scope.init = function(){
			$localstorage.get('tempParams',{}).then(function(param){
				if($util.isNotEmpty(param.oCar)){
					$scope.oParams = JSON.parse(param.oCar);
					if($util.isNotEmpty($scope.oParams.title)){
						$timeout(function(){
							var loadPop = ITCButton.getPopup('.mycarRegist').open();
							loadPop.onCompleteHandle = function(){
								$scope.getList();
							}
						}, 200);
					}
				}
			});
			$scope.getList();
		}


		//매물 등록/수정 팝업
		$scope.onLoad = function(){
				console.log('callback!');
				$scope.getList();
		}
		//딜러 매물 가져오기 팝업
		$scope.onLoadSale = function(){
				console.log('callback!');
		}

		//팝업 오픈
		$scope.onClick=function(code){
			switch(code){
			case 'CD_REG':
		//$scope.oParams = $scope.car;
				$scope.oParams.type='regist';
				$timeout(function(){
					var regPop = ITCButton.getPopup('.mycarRegist').open();
					regPop.onCompleteHandle = function(){
						console.log('컴플리트 등록확인');
						$scope.getList();
					}
				});
				break;
			case 'CD_MOD':
				$scope.oParams = $scope.car;
				$scope.oParams.type='modify';
				$timeout(function(){
					var modPop = ITCButton.getPopup('.mycarRegist').open();
					modPop.onCompleteHandle = function(){
						console.log('컴플리트 수정확인');
						$scope.getList();
					}
				});
				break;
			case 'CD_LOAD':
				var getProPop = ITCButton.getPopup('.getPro').open();
				getProPop.onCompleteHandle = function(){
					$scope.getList();
				}
				break;
			case 'CD_MORE':
				location.href= BNK_CTX + '/front/category/mycar/buyDetail/' + $scope.selectedData.carSeq
				break;
			case 'CD_COMPLETE':
				alertify.confirm('판매완료 처리하시겠습니까?', function(){
					$http({
						url: BNK_CTX + "/front/my/mycar/complete"
						, data: JSON.stringify({carSeq: $scope.selectedData.carSeq})
						, method: 'POST'
						, async: false
						, headers: { 'Content-Type': 'application/json'}
					}).success(function(data, status, headers, config){
					if(data.resCd == "00"){
						alertify.alert('판매완료 처리 되었습니다.');
						console.log(data);
						$scope.getList();
					}else if(data.resCd == "99"){
					//TODO:상태값 변경이 실패했을경우
					}
					}).error(function(data, status, headers, config) {
					});
				});
				break;
			}
		}


$scope.carList =[];
$scope.getList = function(){
	$http({
		url: BNK_CTX + "/front/my/getCarList"
		, method: 'GET'
		, async: false
		, headers: { 'Content-Type': 'application/json'}
	}).success(function(data, status, headers, config){
		//검색한 리스트
		$scope.carList = data.carList;
		//리스트가 있을 시 무조건 첫번째 선택
		if(angular.isArray($scope.carList) && $scope.carList.length != 0){
				//리스트가 있을 시 무조건 첫번째 선택
				$scope.select(0);
		}
		$scope.loaded = true;
	}).error(function(data, status, headers, config) {
	});
}

//리스트가 있는지 없는지 확인하여 띄워줄 div 영역이 다르다.
$scope.isEmptyList = function(){
	return $scope.loaded && !(angular.isArray($scope.carList) && $scope.carList.length != 0);
}


//리트스에서 특정 li 를 선택했을 시
$scope.select = function(idx){
$scope.selectedData   = $scope.carList[idx];
$scope.car  = $scope.selectedData;
$scope.car.carFullCode  	= $scope.selectedData.carFullCode;			//차량코드
$scope.car.carRegYear   	= $scope.selectedData.carRegYear;			//차량연식
$scope.car.carPlateNum  	= $scope.selectedData.carPlateNum;			//차량번호
$scope.car.makerLabel   	= $scope.selectedData.label.makerLabel;		//제조사
$scope.car.modelLabel   	= $scope.selectedData.label.modelLabel;		//모델
$scope.car.modelDtlLabel	= $scope.selectedData.label.modelDtlLabel;	//세부모델
	$scope.car.mycarSeq			= $scope.selectedData.mycarSeq;				//매물고유번호
}
}]);
</script>