/**
 * 매물 가져오기 팝업
 *
 * yj-kim
 *
 **/
angular.module('bnk-common.directive')
.directive('getCarSalePop', function ($rootScope, $timeout, Upload, $http) {

/* ####################################################################################
 * ## 팝업 상수설정                                                                           ##
 * #################################################################################### */

    var PARENT_ID = 'wrap_back';                // 고정
    var TEMPLATE_ID = 'get-car-sale-pop';    // 변경 <= 팝업ID(폴더,파일명)

/* #################################################################################### */

    return {

        /* [scope 옵션]
         *      - scope : false -> 새로운 scope 객체를 생성하지 않고 부모가 가진 같은 scope 객체를 공유. (default 옵션)
         *      - scope : true -> 새로운 scope 객체를 생성하고 부모 scope 객체를 상속.
         * [binding 옵션]
         *   - = : 부모 scope의 property와 디렉티브의 property를 data binding하여 부모 scope에 접근
         *   - @ : 디렉티브의 attribute value를 {{}}방식(interpolation)을 이용해 부모 scope에 접근
         *   - & : Two-way Binding 없이 각 Directive에서 사용하는 데이터를 상위 스코프로 전달할 수 있다.
         */
        scope: {
            oParams: '=params',
            onLoadCallback: '&onLoadCallback'
        },
        restrict: 'E',        // E : elements, A : attributes, C : class name (CSS), M : comments
        replace: true,         // directive를 설정한 태그를 템플릿 태그로 교체하고자 할때 따라서 template 또는 templateUrl과 함께 사용한다
//        transclude: false,    // ngTransclude를 통하여 DOM에 transcluded DOM을 insert 할 수 있다
//                            // transcluded DOM을 template에서 ngTransclude directive에 삽입한다
        link: function(scope, element, attrs) {
            scope.contentUrl = BNK_CTX + '/front/js/popup/bnk-'+ TEMPLATE_ID +'/bnk-'+ TEMPLATE_ID +'-template.html';
           },
        template: '<div id="'+TEMPLATE_ID+'" ng-include="contentUrl"></div>',
        controller: function($scope,$util,$localstorage){


        /* ####################################################################################
         * ## 멤버 초기값 설정                                                                   ##
         * #################################################################################### */

        	// 팝업 초기화
			$scope.$this = {};	// 팝업객체
			$scope.templateInit = function(){
				$scope.$this = ITCButton.initPopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'), 'full');
				ITCButton.setupTypePopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'));
				ITCButton.setupTypeAccordion();    	//아코디언 초기화
		        uiModules.swiperUpdate();        	//스와이퍼 초기화
				$rootScope.$broadcast(TEMPLATE_ID, {});
			};

            //코드 초기화 [S]
        	$scope.$on('onCodeReady', function (event, data) {
                $scope.optionTypeCodeList    =    optionTypeCodeList;            //옵션코드
                $scope.optionCodeList = [].concat(
                        optionBasicCodeList
                        , optionExternalCodeList
                        , optionInternalCodeList
                        , optionConvenienceCodeList
                        , optionSafetyCodeList
                        , optionMediaCodeList

                );    //옵션 코드 리스트(주요,외장,내장,편의,안전,미디어)

                $scope.fuelTypeCodeList        =    fuelTypeCodeList;
                $scope.missionTypeCodeList    =    missionTypeCodeList;
                $scope.colorTypeCodeList    =    colorTypeCodeList;
                $scope.carStatusCodeList    =    carStatusCodeList;
                $scope.carExtStatusCodeList    =    carExtStatusCodeList;
                $scope.carAccStatusCodeList    =    carAccStatusCodeList;
                $scope.carRentStatusCodeList=    carRentStatusCodeList;
                $scope.optionDefaultCodeList=    optionDefaultCodeList;

                $scope.carCodeSearchMap = carCodeSearchMap;
                $scope.makerList = carCodeSearchMap["makerList"];
            });

			$scope.onConfirm = function(data){
				console.log(data);
				$scope.carSaleInfo.parkZip   = data.zipNo;
				$scope.carSaleInfo.parkAddr1 = data.roadAddr;
				$scope.carSaleInfo.parkAddr2 = data.addrDtl;
			}


            $scope.carCodeSearchMap = carCodeSearchMap;
            $scope.makerList = carCodeSearchMap["makerList"];
            //코드 초기화 [E]

            $scope.carSaleInfo = {};


            $scope.carSaleInfo.carPlateNum  = "";            //차량번호
            $scope.carSaleInfo.carFrameNum  = "";            //차대번호
            $scope.carSaleInfo.CarRegDay    = "";            //차대번호
            $scope.carSaleInfo.makerCd      = "";

            //Form Data 초기화 [S]

            $scope.init = function(){
            	$scope.carSaleInfo={};

                $scope.carSaleInfo.carPlateNum       = '';           //차량번호
                $scope.carSaleInfo.carFrameNum       = '';           //차대번호
                $scope.carSaleInfo.applyDay          = '';           //등록일자
                $scope.carSaleInfo.carFullCode       = '';           //차량코드(제조사,모델,세부모델,등급 포함)
                $scope.carSaleInfo.carRegYear        = '';           //연식
                $scope.carSaleInfo.carSaleInfoColor  = '';           //색상
                $scope.carSaleInfo.useKm             = new Money();  //주행거리
                $scope.carSaleInfo.carFuel           = '';           //연료타입
                $scope.carSaleInfo.carMission        = '';           //변속기(컬럼미생성)
                $scope.carSaleInfo.unpaidTax         = '';           //세금미납내역
                $scope.carSaleInfo.rentYn            = '';           //렌터카사용이력
                                                                     //성능점검번호(컬럼미생성)
                $scope.carSaleInfo.sagoYn            = '';           //사고내역
                $scope.carSaleInfo.surfaceState      = '';           //외관상태
                $scope.carSaleInfo.optionCds         = [];           //옵션코드리스트
                $scope.carSaleInfo.optionCdsArr      = [];           //옵션코드리스트
                $scope.carSaleInfo.carDesc           = '';           //상세설명

                $scope.files                         = {};           //**파일 등록정보**
                $scope.files.fileSeqs                = [];           //--파일시퀀스 리스트
                $scope.files.indexs                  = [0,];         //--파일순서 리스트
                $scope.files.exists                  = [];           //--파일존재여부 리스트
                $scope.files.srcs                    = [];           //--파일리소스 리스트
                $scope.files.delSeqs=[];

                $scope.carSaleInfo.carVideoUrl       = '';           //동영상URL
                $scope.carSaleInfo.parkZip           = '';           //우편번호
                $scope.carSaleInfo.parkAddr1         = '';           //주소
                $scope.carSaleInfo.parkAddr2         = '';           //상세주소
                $scope.carSaleInfo.saleAmt           = new Money();  //판매가격
                $scope.carSaleInfo.division          = $scope.oParams.division;
                //form Data 초기화 [E]


                //CAR LABEL [S]
                $scope.carSaleInfo.makerLabel        ='';
                $scope.carSaleInfo.modelLabel        ='';
                $scope.carSaleInfo.modelDtlLabel     ='';
                $scope.carSaleInfo.gradeLabel        ='';
                $scope.carSaleInfo.colorLabel        ='';
                $scope.carSaleInfo.fuelLabel         ='';
                $scope.carSaleInfo.missionLabel      ='';
                $scope.carSaleInfo.rentLabel         ='';
                $scope.carSaleInfo.accLabel          ='';
                $scope.carSaleInfo.extLabel          ='';
                //CAR LABEL [E]

                //CAR CONTROL OBJECT [S]
                $scope.carSaleInfo.focus             = {};
                $scope.carSaleInfo.focus.makerCd     = false;
                $scope.carSaleInfo.focus.modelCd     = false;
                $scope.carSaleInfo.focus.modelDtlCd  = false;
                $scope.carSaleInfo.focus.gradeCd     = false;
                //CAR CONTROL OBJECT [E]

            }

            $scope.carSaleInfo={};

            $scope.carSaleInfo.carPlateNum       = '';           //차량번호
            $scope.carSaleInfo.carFrameNum       = '';           //차대번호
            $scope.carSaleInfo.applyDay          = '';           //등록일자
            $scope.carSaleInfo.carFullCode       = '';           //차량코드(제조사,모델,세부모델,등급 포함)
            $scope.carSaleInfo.carRegYear        = '';           //연식
            $scope.carSaleInfo.carSaleInfoColor  = '';           //색상
            $scope.carSaleInfo.useKm             = new Money();  //주행거리
            $scope.carSaleInfo.carFuel           = '';           //연료타입
            $scope.carSaleInfo.carMission        = '';           //변속기(컬럼미생성)
            $scope.carSaleInfo.unpaidTax         = '';           //세금미납내역
            $scope.carSaleInfo.rentYn            = '';           //렌터카사용이력
                                                                 //성능점검번호(컬럼미생성)
            $scope.carSaleInfo.sagoYn            = '';           //사고내역
            $scope.carSaleInfo.surfaceState      = '';           //외관상태
            $scope.carSaleInfo.optionCds         = [];           //옵션코드리스트
            $scope.carSaleInfo.optionCdsArr      = [];           //옵션코드리스트
            $scope.carSaleInfo.carDesc           = '';           //상세설명

            $scope.files                         = {};           //**파일 등록정보**
            $scope.files.fileSeqs                = [];           //--파일시퀀스 리스트
            $scope.files.indexs                  = [0,];         //--파일순서 리스트
            $scope.files.exists                  = [];           //--파일존재여부 리스트
            $scope.files.srcs                    = [];           //--파일리소스 리스트
            $scope.files.delSeqs=[];

            $scope.carSaleInfo.carVideoUrl       = '';           //동영상URL
            $scope.carSaleInfo.parkZip           = '';           //우편번호
            $scope.carSaleInfo.parkAddr1         = '';           //주소
            $scope.carSaleInfo.parkAddr2         = '';           //상세주소
            $scope.carSaleInfo.saleAmt           = new Money();  //판매가격
            $scope.carSaleInfo.division          = $scope.oParams.division;
            //form Data 초기화 [E]


            //CAR LABEL [S]
            $scope.carSaleInfo.makerLabel        ='';
            $scope.carSaleInfo.modelLabel        ='';
            $scope.carSaleInfo.modelDtlLabel     ='';
            $scope.carSaleInfo.gradeLabel        ='';
            $scope.carSaleInfo.colorLabel        ='';
            $scope.carSaleInfo.fuelLabel         ='';
            $scope.carSaleInfo.missionLabel      ='';
            $scope.carSaleInfo.rentLabel         ='';
            $scope.carSaleInfo.accLabel          ='';
            $scope.carSaleInfo.extLabel          ='';
            //CAR LABEL [E]

            //CAR CONTROL OBJECT [S]
            $scope.carSaleInfo.focus             = {};
            $scope.carSaleInfo.focus.makerCd     = false;
            $scope.carSaleInfo.focus.modelCd     = false;
            $scope.carSaleInfo.focus.modelDtlCd  = false;
            $scope.carSaleInfo.focus.gradeCd     = false;
            //CAR CONTROL OBJECT [E]

            //Watch 초기화 [S]
            $scope.$parent.evtSetComma($scope,watchMoney);
            function watchMoney(s,o) {    // s:Watch String, o:Money Object
                $scope.$watch(s, function (nv, ov, scope) { o.set(nv); }, true);
            }
            $scope.$watch('carSaleInfo.applyDay', function (nv, ov, scope) {

                if($util.isNotEmpty(nv)){
                    if(nv.replace(/[^0-9]/gi,'').length < 9){
                        scope.carSaleInfo.applyDay = nv.replace(/[^0-9]/gi,'').replace(/([0-9]{4})([0-9]{2})([0-9]{2})/,'$1.$2.$3');
                    }
                }else{
                    scope.carSaleInfo.applyDay = nv;
                }
            });

            //Watch 초기화 [E]
            //아코디언 토글상태값 초기화(제조사,모델,세부모델,등급)
            $scope.carSaleInfo.focus.resetToggle = function(){
                $scope.carSaleInfo.focus.makerCd     = false;
                $scope.carSaleInfo.focus.modelCd     = false;
                $scope.carSaleInfo.focus.modelDtlCd  = false;
                $scope.carSaleInfo.focus.gradeCd     = false;
            }

            $scope.doFocus=function($event){
                if ($event.stopPropagation) $event.stopPropagation();        //이벤트 버블링 해제
                var $dl = $($event.target).closest('dl');
                $dl.find('.accordionData input[type=text],textarea,input[type=radio]:eq(0)').focus();
            }

            //아코디언 토글 on / off
            $scope.onToggle=function(code, $event){
                switch(code){
                case "ACCD_MAKER":
                    $scope.carSaleInfo.focus.resetToggle();
                    $scope.carSaleInfo.focus.makerCd = !$scope.carSaleInfo.focus.makerCd;
                    break;
                case "ACCD_MODEL":
                    $scope.carSaleInfo.focus.resetToggle();
                    $scope.carSaleInfo.focus.modelCd = !$scope.carSaleInfo.focus.modelCd;
                    break;
                case "ACCD_DTL_MODEL":
                    $scope.carSaleInfo.focus.resetToggle();
                    $scope.carSaleInfo.focus.modelDtlCd = !$scope.carSaleInfo.focus.modelDtlCd;
                    break;
                case "ACCD_GRADE":
                    $scope.carSaleInfo.focus.resetToggle();
                    $scope.carSaleInfo.focus.gradeCd = !$scope.carSaleInfo.focus.gradeCd;
                    break;
                }
            }

            //아코디언 특정 행 클릭시 이벤트 처리
            $scope.onClick=function(code, $event, label){
                if ($event && $event.stopPropagation) $event.stopPropagation();        //이벤트 버블링 해제
                switch(code){
                case "ACCD_MAKER":
                    $scope.carSaleInfo.makerLabel         = label    ;
                    $scope.carSaleInfo.modelLabel         = ''       ;
                    $scope.carSaleInfo.modelDtlLabel      = ''       ;
                    $scope.carSaleInfo.gradeLabel         = ''       ;
                    $scope.carSaleInfo.focus.makerCd      = false    ;
                    $scope.carSaleInfo.focus.modelCd      = true     ;
                    $scope.carSaleInfo.focus.modelDtlCd   = false    ;
                    $scope.carSaleInfo.focus.gradeCd      = false    ;
                    $scope.carSaleInfo.modelCd            = ''       ;
                    $scope.carSaleInfo.modelDtlCd         = ''       ;
                    $scope.carSaleInfo.gradeCd            = ''       ;
                    break;
                case "ACCD_MODEL":
                    $scope.carSaleInfo.modelLabel         = label    ;
                    $scope.carSaleInfo.modelDtlLabel      = ''       ;
                    $scope.carSaleInfo.gradeLabel         = ''       ;
                    $scope.carSaleInfo.focus.makerCd      = false    ;
                    $scope.carSaleInfo.focus.modelCd      = false    ;
                    $scope.carSaleInfo.focus.modelDtlCd   = true     ;
                    $scope.carSaleInfo.focus.gradeCd      = false    ;
                    $scope.carSaleInfo.modelDtlCd         = ''       ;
                    $scope.carSaleInfo.gradeCd            = ''       ;
                    break;
                case "ACCD_DTL_MODEL":
                    $scope.carSaleInfo.modelDtlLabel      = label    ;
                    $scope.carSaleInfo.gradeLabel         = ''       ;
                    $scope.carSaleInfo.focus.makerCd      = false    ;
                    $scope.carSaleInfo.focus.modelCd      = false    ;
                    $scope.carSaleInfo.focus.modelDtlCd   = false    ;
                    $scope.carSaleInfo.focus.gradeCd      = true     ;
                    $scope.carSaleInfo.gradeCd            = ''       ;
                    break;
                case "ACCD_GRADE":
                    $scope.carSaleInfo.gradeLabel         = label    ;
                    $scope.carSaleInfo.focus.makerCd      = false    ;
                    $scope.carSaleInfo.focus.modelCd      = false    ;
                    $scope.carSaleInfo.focus.modelDtlCd   = false    ;
                    $scope.carSaleInfo.focus.gradeCd      = false    ;
                    //gradeCd 선택시에는 차량코드10자리가 반환되기때문에 여기서 form data를 입력해야한다.
                    $scope.carSaleInfo.carFullCode        = $scope.carSaleInfo.gradeCd;
                    break;
                case "ACCD_COLOR":
                    $scope.carSaleInfo.colorLabel         = label    ;
                    break;
                case "ACCD_FUEL":
                    $scope.carSaleInfo.fuelLabel          = label    ;
                    break;
                case "ACCD_MISSION":
                    $scope.carSaleInfo.missionLabel       = label    ;
                    break;
                case "ACCD_RENT":
                    $scope.carSaleInfo.rentLabel          = label    ;
                    break;
                case "ACCD_ACCIDENT":
                    $scope.carSaleInfo.accLabel           = label    ;
                    break;
                case "ACCD_EXTERNAL":
                    $scope.carSaleInfo.extLabel           = label    ;
                    break;
                case "ACCD_OPTION":
                    $scope.carSaleInfo.optionCds          = $('input[id*="opt_cc"]:checked').map(function(){ return this.value; }).get().join();
                    break;
                case 'BTN_ADDR_CHANGE':
					var addrPopup = ITCButton.getPopup('.fullAddress2').open();
					addrPopup.onCompleteHandle = function(data){
						$scope.carSaleInfo.parkZip   = data.zipNo;
						$scope.carSaleInfo.parkAddr1 = data.roadAddr;
						$scope.carSaleInfo.parkAddr2 = data.addrDtl;
					};
                }
            }

        /* #################################################################################### */



        /* ####################################################################################
         * ## 이벤트 설정                                                                            ##
         * #################################################################################### */

          //파일 업로드 [S]
            $scope.remove = function(index){
                var indexs      = $scope.files.indexs;                             //인덱스 배열
                var removeIndex = indexs.indexOf(index);                           //임의로 지정한 인덱스가 아닌 배열 실제 인덱스 구하기
                var fileSeq     = $scope.files.fileSeqs.splice(removeIndex, 1);    //실제 인덱스로 등록된 파일 시퀀스 삭제
                $scope.files.indexs.splice(index, 1);	//실제 인덱스로 등록된 인덱스 삭제
				$scope.files.exists.splice(index, 1);	//실제 인덱스로 등록된 인덱스 삭제
				$scope.files.srcs.splice(index, 1);	//실제 인덱스로 등록된 인덱스 삭제
				$scope.files.delSeqs.push(fileSeq);

				if($scope.files.indexs.length === 0){
					$scope.files.indexs.push(0);
				}
            }
            $scope.upload = function (file, index) {
                var indexs = $scope.files.indexs;
                if(file.length === 0){
                    throw 'file is not found.';
                }
                var newIndex = index + 1;        //다음 추가할 파일의 인덱스
                if(indexs.indexOf(newIndex) === -1 && indexs.length <= 20){
                    //파일의 인덱스는 중복되지 않는다.
                    //파일은 최대 20개까지만 올릴 수 있다.
                    $scope.files.indexs.push(newIndex);

                }

                Upload.upload({
                    url: BNK_CTX + '/front/my/mycar/fileUpload',
                    data: {file: file}
                }).then(function (resp) {
                    var blob=new Blob(file, {type: "octet/stream"});
                    var url = URL.createObjectURL(blob);

                    $scope.files.exists.push(index);                //파일 등록처리
                    $scope.files.fileSeqs.push(resp.data.fileSeq);  //파일 시퀀스 저장
                    $scope.files.srcs.push(url);                    //파일 업로드 전 미리보기 표출

                }, function (resp) {
                    console.log('Error status: ' + resp.status);

                });
            };
            //파일 업로드 [E]

            //매물 검색
            $scope.searchCar = function(){
                var srchCarNum     = $scope.carSaleInfo.srchCarNum  ;  //차량 Full Code
                if(!$util.isNotEmpty(srchCarNum)){
                    alertify.alert("차량번호를 입력하세요.");
                    return false;
                }

                if(angular.isArray($scope.$parent.carList)){
                	var res = $scope.$parent.carList.find(function(car){ return car.carPlateNum == srchCarNum; });
                	if(angular.isObject(res)){
                		alertify.alert("이미 등록된 차량은 검색할 수 없습니다.");
                		return;
                	}

                }
                $http({
                    url: BNK_CTX + '/front/my/getCarInfo'
                    , method: 'POST'
                    , async: false
                    , headers: { 'Content-Type': 'application/json'}
                    , data :JSON.stringify({
                    	carPlateNumber: srchCarNum
                        , dealerLicenseNo: $scope.$parent.sessUserInfo.dealerLicenseNo
                    })
                    , dataType : 'json'
                }).success(function(data, status, headers, config){
                    console.log(data);
                    if(data.resCd == '00'){
                    	$scope.setValue(data.car);
                    }

                }).error(function(data, status, headers, config) {

                });
            }

            //가져온 매물 화면에 매핑
            $scope.setValue = function(car){
            	if(!angular.isObject(car)){
            		alertify.alert("검색 결과가 없습니다.");
            		return;
            	}
            		$scope.carSaleInfo.carFullCode  = car.carFullCode;      			//차량코드10자리
            		$scope.carSaleInfo.carFrameNum  = car.carFrameNum;      			//차대번호
            		$scope.carSaleInfo.carPlateNum  = car.carPlateNum;  				//차량번호
            		$scope.carSaleInfo.applyDay     = car.carRegDay;       				//차량최초등록일
            		$scope.carSaleInfo.useKm.set(car.useKm);           					//주행거리
            		$scope.carSaleInfo.carCheckNo   = car.carCheckNo;      				//성능점검번호
            		$scope.carSaleInfo.carRegYear   = car.carRegYear;      				//차량연식
            		$scope.carSaleInfo.makerCd      = car.carFullCode.substring(0,3);	//제조사 코드
            		$scope.carSaleInfo.modelCd      = car.carFullCode.substring(0,5);	//모델 코드
            		$scope.carSaleInfo.modelDtlCd   = car.carFullCode.substring(0,6);	//상세모뎅 코드
            		$scope.carSaleInfo.gradeCd      = car.carFullCode.substring(0,10);	//등급 코드
            		$scope.carSaleInfo.option       = car.option;          				//옵션
            		$scope.carSaleInfo.carMission   = car.carMission;      				//미션
            		$scope.carSaleInfo.carFuel      = car.carFuel;         				//연료
            		$scope.carSaleInfo.carColor     = car.carColor;        				//색상
            		$scope.carSaleInfo.sagoYn       = car.sagoYn;          				//사고여부
            		$scope.carSaleInfo.optionCds = $util.isNotEmpty(car.optionCdArr) ? car.optionCdArr : [];	//옵션 코드묶음

            		$scope.carSaleInfo.makerLabel		= car.label.makerName;			//[라벨]제조사명
            		$scope.carSaleInfo.modelLabel		= car.label.modelName;			//[라벨]모델명
            		$scope.carSaleInfo.modelDtlLabel	= car.label.modelDtlName;		//[라벨]상세모델명
            		$scope.carSaleInfo.gradeLabel		= car.label.gradeName;			//[라벨]등급명
            		$scope.carSaleInfo.missionLabel		= car.label.carMission;			//[라벨]변속기
            		$scope.carSaleInfo.fuelLabel		= car.label.carFuel;			//[라벨]연료
            		$scope.carSaleInfo.colorLabel		= car.label.carColor;			//[라벨]색상
            		$scope.carSaleInfo.accLabel			= car.label.sagoYn;				//[라벨]사고여부 재설정필요


            		var fileSeqs	= car.carImageFileList.map(function(file){ return file.fileSeq; });
            		var indexs		= car.carImageFileList.map(function(file, index){ return index; });
            		var exists		= car.carImageFileList.map(function(file, index){ return index; });
            		var srcs		= car.carImageFileList.map(function(file){
						var carCode = car.carFullCode;
						var carSeq = car.carSeq;
						var fileSeq = file.fileSeq;
						return file.logiThumbPath;
					});
            		if(indexs.length < 20){indexs.push(indexs.length);}			//파일이 20개 미만일때 추가 가능하도록

            		$scope.files            = {};                                   //**파일 등록정보**
            		$scope.files.fileSeqs   = fileSeqs;                             //--파일시퀀스 리스트
            		$scope.files.indexs     = indexs;                               //--파일순서 리스트
            		$scope.files.exists     = exists;                               //--파일존재여부 리스트
            		$scope.files.srcs       = srcs;                                 //--파일리소스 리스트
            		$scope.files.delSeqs    = [];
            }

            $scope.optionChecked = function(code){
				var optionCds = $util.isNotEmpty($scope.car) ? $scope.car.optionCds : [];
				var option = '';
				if(angular.isArray(optionCds)){
					option = optionCds.find(function(optionCd){ return code == optionCd; });
				}
				return $util.isNotEmpty(option);
			}

            $scope.closePop = function(){
            	$scope.$this.close();
            };

            //매물 등록 [S]
            $scope.updateGetCar = function(){
                $('.accordionSet').removeClass('on');
                var params={
                	carFullCode			: $scope.carSaleInfo.carFullCode,
                    carPlateNum         : $scope.carSaleInfo.carPlateNum,
                    carFrameNum         : $scope.carSaleInfo.carFrameNum,
                    applyDay            : $scope.carSaleInfo.applyDay,
                    carGuarFruitlessYn  : $scope.carSaleInfo.carGuarFruitlessYn,
                    carGuarRefundYn     : $scope.carSaleInfo.carGuarRefundYn,
                    carGuarTermYn       : $scope.carSaleInfo.carGuarTermYn,
                    makerCd             : $scope.carSaleInfo.makerCd,
                    modelCd             : $scope.carSaleInfo.modelCd,
                    modelDtlCd          : $scope.carSaleInfo.modelDtlCd,
                    gradeCd             : $scope.carSaleInfo.gradeCd,
                    carRegYear          : $scope.carSaleInfo.carRegYear,
                    carColor            : $scope.carSaleInfo.carColor,
                    useKm               : $scope.carSaleInfo.useKm.val,
                    carFuel             : $scope.carSaleInfo.carFuel,
                    carMission          : $scope.carSaleInfo.carMission,
                    unpaidTax           : $scope.carSaleInfo.unpaidTax,
                    rentYn              : $scope.carSaleInfo.rentYn,
                    carCheckNo          : $scope.carSaleInfo.carCheckNo,
                    sagoYn              : $scope.carSaleInfo.sagoYn,
                    surfaceState        : $scope.carSaleInfo.surfaceState,
                    //옵션 : $scope.carSaleInfo.carDesc,
                    carDesc             : $scope.carSaleInfo.carDesc,
                    carVideoUrl         : $scope.carSaleInfo.carVideoUrl,
                    optionCds	        : $scope.carSaleInfo.optionCds

                };

                params.fileSeqs    = $scope.files.fileSeqs.join(',');
                params.applyDay    = $util.nvl($scope.carSaleInfo.applyDay,'');
                params.useKm       = $scope.carSaleInfo.useKm.val;
                params.saleAmt     = $scope.carSaleInfo.saleAmt.val;
                params.applyDay    = params.applyDay.replace(/[^0-9]/gi,'');
                params.mycarSeq    = $scope.carSaleInfo.mycarSeq;
                params.userId      = $scope.carSaleInfo.userId;
                if(angular.isArray(params.optionCds)){
		    		params.optionCds	=	params.optionCds.join();
		    	}

                $http({
                    method:'POST',
                    url: BNK_CTX + '/front/my/updateGetCarInfo',
                    data: JSON.stringify(params)
                }).success(function(data, status, headers, config){

                	if(data.resCd == '00'){
                		alertify.alert("등록 되었습니다.");
                		$scope.$this.close();
                		$scope.$this.complete();
                		$scope.init();
                	}else{

                	}
                }).error(function(data, status, headers, config) {
                });
            }
            //매물 등록 [E]


        /* #################################################################################### */



        }
    };
});
