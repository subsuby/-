<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
bnkApp.controller(CTRL_NAME, ['$scope', '$http' , '$util', 'Upload', '$timeout', '$localstorage', function($scope, $http, $util, Upload, $timeout, $localstorage){


	$scope.loaded			= false;
	$scope.group            = {};
    $scope.danjiFullName    = "";
    $scope.shopFullSrchFirm = "";

    $scope.car              = {};
    $scope.car.carFullCode  = "";
    $scope.car.carRegYear   = "";
    $scope.car.mycarSeq     = "";

    $scope.oParams			= {};

    // 초기 메서드 실행
    $scope.init = function(){

    	$scope.group            = {};
        $scope.danjiFullName    = "";
        $scope.shopFullSrchFirm = "";

        $scope.car              = {};
        $scope.car.carFullCode  = "";
        $scope.car.carRegYear   = "";
        $scope.car.mycarSeq     = "";

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
				}else{
					$timeout(function(){
		    		    $scope.getList();
					}, 200);
				}
	    	}else{
				$timeout(function(){
	    		    
				}, 200);
			}
		});
	   	
	   	$scope.getList();

    }

    $scope.$on('request-estimate-pop', function(){
    	var estPop = ITCButton.getPopup('.realtimeChoice');
    	estPop.onCompleteHandle = function(){
	    	$scope.getList();
	    }
    });
    $scope.onPopupOpenEsti = function(){		//견적요청팝업
    	var estPop = ITCButton.getPopup('.realtimeChoice').open();
    	estPop.onCompleteHandle = function(){
	    	$scope.getList();
	    }
    }

    //팝업 오픈
    $scope.onClick=function(code, value){
    	switch(code){
    	case 'CD_REG':
    		$scope.oParams = $scope.car;
    		$scope.oParams.type='regist';
    		$timeout(function(){
    			var regPop = ITCButton.getPopup('.mycarRegist').open();
    		    regPop.onCompleteHandle = function(){
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
    		    	$scope.getList();
    		    }
    		});
    		break;
    	case 'CD_EST_DEALER':
   			var estPop = ITCButton.getPopup('.estimatePop').open();
   			$scope.estimateInfo = value;
    		break;
    	case 'CD_EST_MAX':
   			var estPop = ITCButton.getPopup('.estimatePop').open();
    		break;
    	}
    }

    $scope.myCarList =[];
	$scope.getList = function(){
		console.log("리스트 요청");
        var params = {userId : $scope.sessUserInfo.userId};
        $http({
            url: BNK_CTX + '/front/my/getMyCarList'
            , method: 'POST'
            , async: false
            , headers: { 'Content-Type': 'application/json'}
            , data :JSON.stringify(params)
        }).success(function(data, status, headers, config){
            //검색한 리스트
            $scope.myCarList = data.myCarList;
            if(angular.isArray($scope.myCarList) && $scope.myCarList.length != 0){
                //리스트가 있을 시 무조건 첫번째 선택
            	if($util.isEmpty($scope.temp)){
	                $scope.select(0);
        	    }
            }

            $scope.loaded = true;
        }).error(function(data, status, headers, config) {
        });
	}

    //리스트가 있는지 없는지 확인하여 띄워줄 div 영역이 다르다.
    $scope.isEmptyList = function(){
        return $scope.loaded && !(angular.isArray($scope.myCarList) && $scope.myCarList.length != 0);
    }


	//리트스에서 특정 li 를 선택했을 시
	$scope.select = function(idx){
        $scope.selectedData = $scope.myCarList[idx];
        //bnk 시세를 위한 파라미터 넘기기.
        console.log($scope.selectedData);
        $scope.car = $scope.selectedData;
        $scope.car.carFullCode  	= $scope.selectedData.carFullCode;			//차량코드
	    $scope.car.carRegYear   	= $scope.selectedData.carRegYear;			//차량연식
		$scope.car.carPlateNum  	= $scope.selectedData.carPlateNum;			//차량번호
		$scope.car.makerLabel   	= $scope.selectedData.label.makerLabel;		//제조사
		$scope.car.modelLabel   	= $scope.selectedData.label.modelLabel;		//모델
		$scope.car.modelDtlLabel	= $scope.selectedData.label.modelDtlLabel;	//세부모델
	    $scope.car.mycarSeq			= $scope.selectedData.mycarSeq;				//매물고유번호
	    $scope.car.render			= Math.random();


	    $http({
			url: BNK_CTX +'/api/user/bnkPriceInfo'
			, method: 'POST'
			, data: JSON.stringify({
				mycarSeq: $scope.selectedData.mycarSeq
			})
		}).then(
			function(json){
			    $scope.estimateInfo = json.data.info.estInfo;
			}
			, function(){
				console.log('정보 가져오기 실패..');
			}
		);

    }

    $scope.cnclReq = function(label){

    	alertify.confirm("["+label+"]견적요청을 취소하겠습니까?", function(){
            $http({
                url: BNK_CTX + '/front/my/cnclReq'
                , method: 'POST'
                , async: false
                , headers: { 'Content-Type': 'application/json'}
                , data :JSON.stringify({
                    mycarSeq  : $scope.car.mycarSeq
                })
            }).success(function(data, status, headers, config){
                //검색한 리스트
                $scope.result = data.rslt;

                if($scope.result == 1){
                    alertify.alert("견적요청이 취소되었습니다.");
                    $scope.getList();
                }
            }).error(function(data, status, headers, config) {
            });

    	})
    }
}]);

</script>