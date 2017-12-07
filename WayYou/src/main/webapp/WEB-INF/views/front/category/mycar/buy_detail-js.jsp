<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script>
if(!${empty car ? 'null' : car}){
	alertify.alert('판매 완료된 상품입니다.');
	location.href = BNK_CTX + '/front/index';
}

bnkApp.controller(CTRL_NAME, ['$scope', '$http', '$timeout', '$util', '$sce', function($scope, $http, $timeout, $util, $sce){

	$scope.$on('onCodeReady', function (event, data) {

		//코드 초기화 [S]
		$scope.optionDefaultCodeList = optionDefaultCodeList;		//기본옵션
		$scope.optionTypeCodeList	=	optionTypeCodeList;			//옵션코드
		$scope.optionCodeList = [].concat(
				optionBasicCodeList
				, optionExternalCodeList
				, optionInternalCodeList
				, optionConvenienceCodeList
				, optionSafetyCodeList
				, optionMediaCodeList

		);	//옵션 코드 리스트(주요,외장,내장,편의,안전,미디어)


		$scope.fuelTypeCodeList		=	fuelTypeCodeList;
		$scope.missionTypeCodeList	=	missionTypeCodeList;
		$scope.colorTypeCodeList	=	colorTypeCodeList;
		$scope.carStatusCodeList	=	carStatusCodeList;
		$scope.carExtStatusCodeList	=	carExtStatusCodeList;
		$scope.carAccStatusCodeList	=	carAccStatusCodeList;
		$scope.carRentStatusCodeList=	carRentStatusCodeList;
		$scope.optionDefaultCodeList=	optionDefaultCodeList;

		$scope.carCodeSearchMap = carCodeSearchMap;
		$scope.makerList = carCodeSearchMap["makerList"];

	});

	//페이지 로딩시 뷰카운트 증가
	angular.element(document).ready(function(){
		$util.incViewCnt($scope.car);
	});
	//======[데이터 초기화]=============
	$scope.car = ${empty car ? 'null' : car};			//매물정보
	$scope.car.detail = true;


	$scope.reverAuctionInfo = ${empty reverAuctionInfo ? '{}' : reverAuctionInfo};	// 내게맞는매물 정보
	$scope.oParams = { reverAuctionInfo : $scope.reverAuctionInfo};

	$scope.trustAsHtml=$sce.trustAsHtml($scope.car.label.carDesc);			//차량 상세설명
	$scope.trustAsYoutube=$sce.trustAsHtml($scope.car.label.carVideoUrl);	//차량 동영상(유튜브)

	$scope.onLoad = function(id, data){ };

	//======[데이터 초기화]=============

	$scope.moreToggle = false;
	$scope.enableOptionCd = function(optCd){
		var enabled = false;
		var optList = $scope.car.optionCdArr;

		if($util.isNotEmpty(optList)){
			optList.forEach(function(opt){
				if(opt == optCd){
					enabled = true;
				}
			});
		}

		return enabled;
	}

	$scope.onClick=function(code){
		switch(code){
		case 'DIBS_ON':		//찜하기
			$util.getDibsOnCar($scope.car);
			break;
		case 'CD_RESERVE':
			$scope.isLogin({
				success: function(){
					ITCButton.getPopup('.multiBooking').open();
				},
				fail: function(){
					alertify.confirm('로그인이 필요한 페이지입니다.\n로그인하시겠습니까?', function(){ ITCButton.getPopup('.loginPop').open(); });
				}
			});
			break;
		case 'CD_CONSIGN':
			$scope.isLogin({
				success: function(){
					ITCButton.getPopup('.valetBooking').open();
				},
				fail: function(){
					alertify.confirm('로그인이 필요한 페이지입니다.\n로그인하시겠습니까?', function(){ ITCButton.getPopup('.loginPop').open(); });
				}
			});
			break;
		case 'CD_FAKE':
			$scope.isLogin({
				success: function(){
					$scope.$parent.fake = $scope.car;
					ITCButton.getPopup('.fakeReport').open();
				},
				fail: function(){
					alertify.confirm('로그인이 필요한 페이지입니다.\n로그인하시겠습니까?', function(){ ITCButton.getPopup('.loginPop').open(); });
				}
			});
			break;
		}
	}

	$scope.onPopupOpen = function(){
		$scope.chkAgree();
	};

	$scope.showLoanLimit = function(){
		$('#frmBnkLoan').submit();
	};

	$scope.chkAgree = function(){
		$scope.isLogin({
			success: function(){
				ITCButton.getPopup('.likeRecord').open();
			},
			fail: function(){
				alertify.confirm('로그인이 필요한 페이지입니다.\n로그인하시겠습니까?', function(){ ITCButton.getPopup('.loginPop').open(); });
			}
		});

		for(var i=1;i<4;i++){
			$scope.labText = $('#agree0'+i+'Lab').text();
			if($('#agree0'+i).val() == ''){
				alertify.alert($scope.labText+'는 필수 체크 입니다.');
				return false;
			}else if($('#agree01').val() != '' && $('#agree02').val() != '' && $('#agree03').val() != ''){
				$('#joinMem').trigger('click');
			}
		}
	}

}]);
</script>