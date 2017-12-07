/**
 * My Page - 매물등록
 *
 * hk-lee
 *
 **/
angular.module('bnk-common.directive')
.directive('carSaleRegistPop', function ($localstorage, $rootScope, $timeout, Upload, $http) {

/* ####################################################################################
 * ## 팝업 상수설정														  				 ##
 * #################################################################################### */

	var PARENT_ID = 'wrap_back';				// 고정
	var TEMPLATE_ID = 'car-sale-regist-pop';	// 변경 <= 팝업ID(폴더,파일명)

/* #################################################################################### */

	return {

		/* [scope 옵션]
		 * 	 - scope : false -> 새로운 scope 객체를 생성하지 않고 부모가 가진 같은 scope 객체를 공유. (default 옵션)
		 * 	 - scope : true -> 새로운 scope 객체를 생성하고 부모 scope 객체를 상속.
		 * [binding 옵션]
		 *   - = : 부모 scope의 property와 디렉티브의 property를 data binding하여 부모 scope에 접근
		 *   - @ : 디렉티브의 attribute value를 {{}}방식(interpolation)을 이용해 부모 scope에 접근
		 *   - & : Two-way Binding 없이 각 Directive에서 사용하는 데이터를 상위 스코프로 전달할 수 있다.
		 */
		scope: {
			oParams: '=params',
			onLoadCallback: '&onLoadCallback'
		},
		restrict: 'E',		// E : elements, A : attributes, C : class name (CSS), M : comments
		replace: true, 		// directive를 설정한 태그를 템플릿 태그로 교체하고자 할때 따라서 template 또는 templateUrl과 함께 사용한다
//		transclude: false,	// ngTransclude를 통하여 DOM에 transcluded DOM을 insert 할 수 있다
//							// transcluded DOM을 template에서 ngTransclude directive에 삽입한다
		link: function(scope, element, attrs) {
			scope.contentUrl = BNK_CTX + '/front/js/popup/bnk-'+ TEMPLATE_ID +'/bnk-'+ TEMPLATE_ID +'-template.html';
	    },
		template: '<div id="'+TEMPLATE_ID+'" ng-include="contentUrl"></div>',
		controller: function($scope, $util){

			// 팝업 초기화
			$scope.$this = {};	// 팝업객체
			$scope.templateInit = function(){
				$scope.$this = ITCButton.initPopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'), 'full');
				ITCButton.setupTypePopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'));
				ITCButton.setupTypeAccordion();	//아코디언 초기화
				$scope.swiper=ITCommons.swiper($('.swiperTypeDefault'),{
					slidesPerColumn: 6
				});		//스와이퍼 초기화
				$scope.$this.onOpenHandle = function(){
					 if($scope.oParams.type == 'move'){
						 //$scope.initData();
						 //$scope.moveData();				//내차팔기에서 등록
					 }else if($scope.oParams.type == 'regist'){
						 $scope.initData();				//내차등록
					 }else if($scope.oParams.type == 'modify'){
						 $scope.initData();
						 $scope.loadData();				//내차수정
					 }
				};
				$rootScope.$broadcast(TEMPLATE_ID, {});
			};

			$scope.toLabel = function(code, codeList){
				var unit = codeList.find(function(obj){ return code == obj.cdDtlNo; });
				return $util.isNotEmpty(unit) ? unit.cdDtlNm : '';
			}
			$scope.loadData = function(){
				if(angular.isObject($scope.oParams)){

					//CAR CONTROL OBJECT [S]
					$scope.car.focus={};
					$scope.car.focus.makerCd=false;
					$scope.car.focus.modelCd=false;
					$scope.car.focus.modelDtlCd=false;
					$scope.car.focus.gradeCd=false;
					//아코디언 토글상태값 초기화(제조사,모델,세부모델,등급)
					$scope.car.focus.resetToggle=function(){
						$scope.car.focus.makerCd=false;
						$scope.car.focus.modelCd=false;
						$scope.car.focus.modelDtlCd=false;
						$scope.car.focus.gradeCd=false;
					}

					$scope.car.carPlateNum  = $scope.oParams.carPlateNum;     //차량번호
					$scope.car.carFrameNum  = $scope.oParams.carFrameNum;     //차대번호
					$scope.car.applyDay     = $scope.oParams.applyDay;        //등록일자
					$scope.car.carFullCode  = $scope.oParams.carFullCode;     //차량코드(제조사,모델,세부모델,등급 포함)
					$scope.car.carRegYear   = $scope.oParams.carRegYear;      //연식
					$scope.car.carColor     = $scope.oParams.carColor;        //색상
					$scope.car.unpaidTax    = $scope.oParams.unpaidTax;       //세금미납내역

					$scope.car.rentYn       = $scope.oParams.rentYn;          //렌터카사용이력
					$scope.car.rentLabel	= $scope.car.rentYn == 'Y' ? '있음' : '없음';

					$scope.car.carCheckNo	= $scope.oParams.carCheckNo		//성능점검번호
					$scope.car.sagoYn       = $scope.oParams.sagoYn;          //사고내역
					$scope.car.accLabel		= $scope.oParams.label.accLabel;

					$scope.car.surfaceState = $scope.oParams.surfaceState;    //외관상태
					$scope.car.extLabel		= $scope.oParams.label.extLabel;

					$scope.car.optionCds    = $scope.oParams.optionCdArr; //옵션코드리스트



					if($util.isEmpty($scope.oParams.carImageFileList)){
						$scope.oParams.carImageFileList = [];
					}
					var fileSeqs	= $scope.oParams.carImageFileList.map(function(file){ return file.fileSeq; });
					var indexs		= $scope.oParams.carImageFileList.map(function(file, index){ return index; });
					var exists		= $scope.oParams.carImageFileList.map(function(file, index){ return index; });
					var srcs		= $scope.oParams.carImageFileList.map(function(file){
						var carCode = $scope.oParams.carFullCode;
						var carSeq = $scope.$parent.sessUserInfo.division == 'D' ? $scope.oParams.carSeq : $scope.oParams.mycarSeq;
						var fileSeq = file.fileSeq;
						return '/image/car/'+carCode+'/'+carSeq+'/'+fileSeq+'_4.jpg';
					});

					//if(indexs.length < 20){indexs.push(indexs.length);}			//파일이 20개 미만일때 추가 가능하도록, 추가 안보이는 이슈로 인한 보류
					indexs.push(indexs.length);

					$scope.files            = {};                                   //**파일 등록정보**
					$scope.files.fileSeqs   = fileSeqs;                             //--파일시퀀스 리스트
					$scope.files.indexs     = indexs;                               //--파일순서 리스트
					$scope.files.exists     = exists;                               //--파일존재여부 리스트
					$scope.files.srcs       = srcs;                                 //--파일리소스 리스트
					$scope.files.delSeqs    = [];

					$scope.car.carGuarFruitlessYn    = $scope.oParams.carGuarFruitlessYn    //헛걸음
					$scope.car.carGuarRefundYn       = $scope.oParams.carGuarRefundYn       //환불
					$scope.car.carGuarTermYn         = $scope.oParams.carGuarTermYn;         //보증기간


					$scope.car.carDesc      = $scope.oParams.carDesc;         //상세설명
					$scope.car.carMission   = $scope.oParams.carMission;      //변속기
					$scope.car.carFuel      = $scope.oParams.carFuel;         //연료타입
					$scope.car.carVideoUrl  = $scope.oParams.carVideoUrl;     //동영상URL
					$scope.car.missionLabel = $scope.oParams.label.carMission;      //변속기(컬럼미생성)
					$scope.car.fuelLabel    = $scope.oParams.label.carFuel;         //연료타입

					if(typeof $scope.oParams.parkZip == 'undefined'){
						$scope.car.parkZip=$scope.$parent.sessUserInfo.zipCode;				//우편번호
						$scope.car.parkAddr1=$scope.$parent.sessUserInfo.addr1;				//주소
						$scope.car.parkAddr2= $scope.$parent.sessUserInfo.addr2;			//상세주소
					}else{
						$scope.car.parkZip      = $scope.oParams.parkZip;         //우편번호
						$scope.car.parkAddr1    = $scope.oParams.parkAddr1;       //주소
						$scope.car.parkAddr2    = $scope.oParams.parkAddr2;       //상세주소
					}
					$scope.car.useKm.set($scope.oParams.useKm);           //주행거리
					$scope.car.saleAmt.set($scope.oParams.saleAmt);         //판매가격

					$scope.car.mycarSeq     = $scope.oParams.mycarSeq ;       //일반사용자의 선택한 데이터의 sequence
					$scope.car.carSeq       = $scope.oParams.carSeq   ;       //딜러사용자의 선택한 데이터의 sequence
					$scope.car.userId       = $scope.oParams.userId   ;       //사용자 아이디

					$scope.car.makerCd      = $scope.oParams.carFullCode.substring(0,3);
					$scope.car.modelCd      = $scope.oParams.carFullCode.substring(0,5);
					$scope.car.modelDtlCd   = $scope.oParams.carFullCode.substring(0,6);
					$scope.car.gradeCd      = $scope.oParams.carFullCode.substring(0,10);
					$scope.car.makerLabel   = $scope.oParams.label.makerName;
					$scope.car.modelLabel   = $scope.oParams.label.modelName;
					$scope.car.modelDtlLabel= $scope.oParams.label.modelDtlName;
					$scope.car.gradeLabel   = $scope.oParams.label.gradeName;
					$scope.car.colorLabel   = $scope.oParams.label.carColor;

					$scope.car.estReqYn		= $scope.oParams.estReqYn;
				}
			};

			$scope.optionChecked = function(code){
				var optionCds = $util.isNotEmpty($scope.car) ? $scope.car.optionCds : [];
				var option = '';
				if(angular.isArray(optionCds)){
					option = optionCds.find(function(optionCd){ return code == optionCd; });
				}
				return $util.isNotEmpty(option);
			}


			//코드 초기화 [S]
			$scope.$on('onCodeReady', function (event, data) {
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


			//코드 초기화 [E]

			$scope.initData = function(){
				//Form Data 초기화 [S]
				$scope.car={};
				$scope.car.carPlateNum    = '';		//차량번호
				$scope.car.carFrameNum    ='';		//차대번호
				$scope.car.applyDay='';				//등록일자
				$scope.car.carFullCode='';			//차량코드(제조사,모델,세부모델,등급 포함)
				$scope.car.carRegYear='';			//연식
				$scope.car.carColor='';				//색상
				$scope.car.useKm=new Money();		//주행거리
				$scope.car.carFuel='';				//연료타입
				$scope.car.carMission='';			//변속기
				$scope.car.unpaidTax='';			//세금미납내역
				$scope.car.rentYn='';				//렌터카사용이력
				$scope.car.carCheckNo='';			//성능점검번호
				$scope.car.sagoYn='';				//사고내역
				$scope.car.surfaceState='';			//외관상태
				$scope.car.optionCdsArr=[];			//옵션코드리스트
				$scope.car.carDesc='';				//상세설명

				$scope.files={};					//**파일 등록정보**
				$scope.files.fileSeqs=[];			//--파일시퀀스 리스트
				$scope.files.indexs=[0,];			//--파일순서 리스트
				$scope.files.exists=[];				//--파일존재여부 리스트
				$scope.files.srcs=[];				//--파일리소스 리스트
				$scope.files.delSeqs=[];

				$scope.car.carVideoUrl='';			//동영상URL
				$scope.car.parkZip=$scope.$parent.sessUserInfo.zipCode;				//우편번호
				$scope.car.parkAddr1=$scope.$parent.sessUserInfo.addr1;				//주소
				$scope.car.parkAddr2= $scope.$parent.sessUserInfo.addr2;			//상세주소
				$scope.car.saleAmt=new Money();		//판매가격
				$scope.car.division = $scope.$parent.sessUserInfo.division;
				$scope.car.premConfYn = $scope.$parent.sessUserInfo.premConfYn;
				//form Data 초기화 [E]

				// 프리미엄 회원 여부 확인후 남은 개수 확인
				if($scope.car.division == 'D'){		// 딜러 일때
					//if($scope.car.premConfYn == 'Y'){		// 프리미엄 회원일 경우
						$http({
							method:'GET',
							url: BNK_CTX + "/front/common/searchPremInfo",
							params: {"userId": $scope.$parent.sessUserInfo.userId}
						}).success(function(oRes){
							if(oRes.resCd == "00"){
								$scope.userInfo = oRes.userInfo;

								// 회원이 소유하고 있는 환불보장 개수를 가져온다.
								// 화면에서 보여질 변수에도 환불보장 개수를 넣어준다.
								$scope.car.guarFruitlessCnt = oRes.userInfo.guarFruitlessCnt;
								$scope.car.guarFruitlessCntLabel = oRes.userInfo.guarFruitlessCnt;

								// 기존 차 정보에 환불보장이 선택이 되어 있을 경우
								if($scope.car.carGuarFruitlessYn == 'Y'){
									$("#mark1").addClass("markSet");
									$("#mark1").addClass("lC");
									$("#mark1").addClass("mark2");
									$('#r_aa1').prop('checked', true);
									$scope.car.carGuarFruitlessChk = 'Y';	// 기존에 체크되있는지 확인할 변수
								}else{
									$("#mark1").removeClass("markSet");
									$("#mark1").removeClass("lC");
									$("#mark1").removeClass("mark2");
									$('#r_aa1').prop('checked', false);
									$scope.car.carGuarFruitlessChk = 'N';	// 기존에 체크되있는지 확인할 변수
								}

								// 회원이 소유하고 있는 헛걸음보상 개수를 가져온다.
								// 화면에서 보여질 변수에도 헛걸음보상 개수를 넣어준다.
								$scope.car.guarRefundCnt = oRes.userInfo.guarRefundCnt;
								$scope.car.guarRefundCntLabel = oRes.userInfo.guarRefundCnt;

								// 기존 차 정보에 헛걸음보상이 선택이 되어 있을 경우
								if($scope.car.carGuarRefundYn == 'Y'){
									$("#mark2").addClass("markSet");
									$("#mark2").addClass("lC");
									$("#mark2").addClass("mark3");
									$('#r_aa2').prop('checked', true);
									$scope.car.carGuarRefundChk = 'Y';	// 기존에 체크되있는지 확인할 변수
								}else{
									$("#mark2").removeClass("markSet");
									$("#mark2").removeClass("lC");
									$("#mark2").removeClass("mark3");
									$('#r_aa2').prop('checked', false);
									$scope.car.carGuarRefundChk = 'N';	// 기존에 체크되있는지 확인할 변수
								}

								// 회원이 소유하고 있는 연증보증 개수를 가져온다.
								// 화면에서 보여질 변수에도 연증보증 개수를 넣어준다.
								$scope.car.guarTermCnt = oRes.userInfo.guarTermCnt;
								$scope.car.guarTermCntLabel = oRes.userInfo.guarTermCnt;

								// 기존 차 정보에 연증보증이 선택이 되어 있을 경우
								if($scope.car.carGuarTermYn == 'Y'){
									$("#mark3").addClass("markSet");
									$("#mark3").addClass("lC");
									$("#mark3").addClass("mark4");
									$('#r_aa3').prop('checked', true);
									$scope.car.carGuarTermChk = 'Y';	// 기존에 체크되있는지 확인할 변수
								}else{
									$("#mark3").removeClass("markSet");
									$("#mark3").removeClass("lC");
									$("#mark3").removeClass("mark4");
									$('#r_aa3').prop('checked', false);
									$scope.car.carGuarTermChk = 'N';	// 기존에 체크되있는지 확인할 변수
								}
							}
						})
					//}
				}

				//CAR LABEL [S]
				$scope.car.makerLabel='';
				$scope.car.modelLabel='';
				$scope.car.modelDtlLabel='';
				$scope.car.gradeLabel='';
				$scope.car.colorLabel='';
				$scope.car.fuelLabel='';
				$scope.car.missionLabel='';
				$scope.car.rentLabel='';
				$scope.car.accLabel='';
				$scope.car.extLabel='';
				//CAR LABEL [E]

				//CAR CONTROL OBJECT [S]
				$scope.car.focus={};
				$scope.car.focus.makerCd=false;
				$scope.car.focus.modelCd=false;
				$scope.car.focus.modelDtlCd=false;
				$scope.car.focus.gradeCd=false;
				//아코디언 토글상태값 초기화(제조사,모델,세부모델,등급)
				$scope.car.focus.resetToggle=function(){
					$scope.car.focus.makerCd=false;
					$scope.car.focus.modelCd=false;
					$scope.car.focus.modelDtlCd=false;
					$scope.car.focus.gradeCd=false;
				}
				//CAR CONTROL OBJECT [E]
				//Watch 초기화 [S]
				$scope.$parent.evtSetComma($scope,watchMoney);
				function watchMoney(s,o) {	// s:Watch String, o:Money Object
					$scope.$watch(s, function (nv, ov, scope) { o.set(nv); }, true);
				}
				$scope.$watch('car.applyDay', function (nv, ov, scope) {
					if($scope.$parent.sessUserInfo.division != 'N'){
						if($util.isNotEmpty(nv)){
							if(nv.replace(/[^0-9]/gi,'').length < 9){
								scope.car.applyDay = nv.replace(/[^0-9]/gi,'').replace(/([0-9]{4})([0-9]{2})([0-9]{2})/,'$1.$2.$3');
							}
						}else{
							scope.car.applyDay = nv;
						}
					}
				});
				//Watch 초기화 [E]

				$scope.title = $scope.oParams.title;
				$localstorage.get('tempParams',{}).then(function(param){
                	$scope.tempParams ={};
                	$scope.tempParams.type = '';
                	$scope.tempParams.title = '';
                	$localstorage.set('tempParams', {oCar: JSON.stringify($scope.tempParams)});
                });
                $scope.oParams.type = '';
                $scope.oParams.title = '';
			}

			$scope.doFocus=function($event){
				if ($event.stopPropagation) $event.stopPropagation();		//이벤트 버블링 해제
				var $dl = $($event.target).closest('dl');
				$dl.find('.accordionData input[type=text],textarea,input[type=radio]:eq(0)').focus();
			}
			//아코디언 토글 on / off
			$scope.onToggle=function(code, $event){
				switch(code){
				case "ACCD_MAKER":
					$scope.car.focus.resetToggle();
				    $scope.car.focus.makerCd=!$scope.car.focus.makerCd;
					break;
				case "ACCD_MODEL":
					$scope.car.focus.resetToggle();
					$scope.car.focus.modelCd=!$scope.car.focus.modelCd;
					break;
				case "ACCD_DTL_MODEL":
					$scope.car.focus.resetToggle();
					$scope.car.focus.modelDtlCd=!$scope.car.focus.modelDtlCd;
					break;
				case "ACCD_GRADE":
					$scope.car.focus.resetToggle();
					$scope.car.focus.gradeCd=!$scope.car.focus.gradeCd;
					break;
				}
			}
			//아코디언 특정 행 클릭시 이벤트 처리
			$scope.onClick=function(code, $event, label){
				if ($event && $event.stopPropagation) $event.stopPropagation();		//이벤트 버블링 해제
				switch(code){
				case "ACCD_MAKER":
					$scope.car.makerLabel=label;
					$scope.car.modelLabel='';
					$scope.car.modelDtlLabel='';
					$scope.car.gradeLabel='';
					$scope.car.focus.makerCd=false;
					$scope.car.focus.modelCd=true;
					$scope.car.focus.modelDtlCd=false;
					$scope.car.focus.gradeCd=false;
					$scope.car.modelCd='';
					$scope.car.modelDtlCd='';
					$scope.car.gradeCd='';
					break;
				case "ACCD_MODEL":
					$scope.car.modelLabel=label;
					$scope.car.modelDtlLabel='';
					$scope.car.gradeLabel='';
					$scope.car.focus.makerCd=false;
					$scope.car.focus.modelCd=false;
					$scope.car.focus.modelDtlCd=true;
					$scope.car.focus.gradeCd=false;
					$scope.car.modelDtlCd='';
					$scope.car.gradeCd='';
					break;
				case "ACCD_DTL_MODEL":
					$scope.car.modelDtlLabel=label;
					$scope.car.gradeLabel='';
					$scope.car.focus.makerCd=false;
					$scope.car.focus.modelCd=false;
					$scope.car.focus.modelDtlCd=false;
					$scope.car.focus.gradeCd=true;
					$scope.car.gradeCd='';
					break;
				case "ACCD_GRADE":
					$scope.car.gradeLabel=label;
					$scope.car.focus.makerCd=false;
					$scope.car.focus.modelCd=false;
					$scope.car.focus.modelDtlCd=false;
					$scope.car.focus.gradeCd=false;
					//gradeCd 선택시에는 차량코드10자리가 반환되기때문에 여기서 form data를 입력해야한다.
					$scope.car.carFullCode=$scope.car.gradeCd;
					break;
				case "ACCD_COLOR":
					$scope.car.colorLabel=label;
					break;
				case "ACCD_FUEL":
					$scope.car.fuelLabel=label;
					break;
				case "ACCD_MISSION":
					$scope.car.missionLabel=label;
					break;
				case "ACCD_RENT":
					$scope.car.rentLabel=label;
					break;
				case "ACCD_ACCIDENT":
					$scope.car.accLabel=label;
					break;
				case "ACCD_EXTERNAL":
					$scope.car.extLabel=label;
					break;
				case "ACCD_OPTION":
					$scope.car.optionCds = $('input[id*="opt_c"]:checked').map(function(){ return this.value; }).get().join();
					console.log($scope.car.optionCds);
					break;
				case 'ACCD_GUAR':
					if(label == 'r_aa1'){	// 환불보장을 선택했을때
						if(Number($scope.car.guarFruitlessCntLabel) != 0){	// 잔여개수가 0개가 아닐때
							if($('#r_aa1').prop('checked')){				// 체크박스 체크를 할때
								$scope.car.carGuarFruitlessYn = 'Y';
								$("#mark1").addClass("markSet");
								$("#mark1").addClass("lC");
								$("#mark1").addClass("mark2");
								$scope.car.guarFruitlessCntLabel = Number($scope.car.guarFruitlessCntLabel)-1;
							}else{											// 체크박스 체크를 해제할때
								if($scope.car.carGuarFruitlessChk != 'Y'){	// 최초 메물에 체크가 되어있지 않을때
									$scope.car.carGuarFruitlessYn = 'N';
									$("#mark1").removeClass("markSet");
									$("#mark1").removeClass("lC");
									$("#mark1").removeClass("mark2");
									$scope.car.guarFruitlessCntLabel = Number($scope.car.guarFruitlessCntLabel)+1;
								}else{	// 기존에 체크가 되어있을 때 풀리지 않게 한다.
									$('#r_aa1').prop('checked', true);
								}
							}
						}else{	// 잔여개수가 0개 일때
							if($scope.car.carGuarFruitlessChk != 'Y'){			// 최초 매물에 체크가 되어있지 않을때
								if(Number($scope.car.guarFruitlessCnt) > 0){	// 최초 딜러가 가지고 있던 값이 0이아닐때
									$scope.car.carGuarFruitlessYn = 'N';
									$("#mark1").removeClass("markSet");
									$("#mark1").removeClass("lC");
									$("#mark1").removeClass("mark2");
									$scope.car.guarFruitlessCntLabel = Number($scope.car.guarFruitlessCntLabel)+1;
								}else{	// 최초 딜러가 가지고 있는 값이 0일때(남은수량)
									$('#r_aa1').prop('checked', false);
								}
							}else{	// 기존에 체크가 되어있을 때 풀리지 않게 한다.
								$('#r_aa1').prop('checked', true);
							}
						}
					}else if(label == 'r_aa2'){	// 헛걸음보상을 선택했을때
						if(Number($scope.car.guarRefundCntLabel) != 0){
							if($('#r_aa2').prop('checked')){
								$scope.car.carGuarRefundYn = 'Y';
								$("#mark2").addClass("markSet");
								$("#mark2").addClass("lC");
								$("#mark2").addClass("mark3");
								$scope.car.guarRefundCntLabel = Number($scope.car.guarRefundCntLabel)-1;
							}else{
								if($scope.car.carGuarRefundChk != 'Y'){
									$scope.car.carGuarRefundYn = 'N';
									$("#mark2").removeClass("markSet");
									$("#mark2").removeClass("lC");
									$("#mark2").removeClass("mark3");
									$scope.car.guarRefundCntLabel = Number($scope.car.guarRefundCntLabel)+1;
								}else{
									$('#r_aa2').prop('checked', true);
								}
							}
						}else{
							if($scope.car.carGuarRefundChk != 'Y'){
								if(Number($scope.car.guarRefundCnt) > 0){
									$scope.car.carGuarRefundYn = 'N';
									$("#mark2").removeClass("markSet");
									$("#mark2").removeClass("lC");
									$("#mark2").removeClass("mark3");
									$scope.car.guarRefundCntLabel = Number($scope.car.guarRefundCntLabel)+1;
								}else{
									$('#r_aa2').prop('checked', false);
								}
							}else{
								$('#r_aa2').prop('checked', true);
							}
						}
					}else if(label == 'r_aa3'){
						if(Number($scope.car.guarTermCntLabel) != 0){
							if($('#r_aa3').prop('checked')){
								$scope.car.carGuarTermYn = 'Y';
								$("#mark3").addClass("markSet");
								$("#mark3").addClass("lC");
								$("#mark3").addClass("mark4");
								$scope.car.guarTermCntLabel = Number($scope.car.guarTermCntLabel)-1;
							}else{
								if($scope.car.carGuarTermChk != 'Y'){
									$scope.car.carGuarTermYn = 'N';
									$("#mark3").removeClass("markSet");
									$("#mark3").removeClass("lC");
									$("#mark3").removeClass("mark4");
									$scope.car.guarTermCntLabel = Number($scope.car.guarTermCntLabel)+1;
								}else{
									$('#r_aa3').prop('checked', true);
								}
							}
						}else{
							if($scope.car.carGuarTermChk != 'Y'){
								if(Number($scope.car.guarTermCnt) > 0){
									$scope.car.carGuarTermYn = 'N';
									$("#mark3").removeClass("markSet");
									$("#mark3").removeClass("lC");
									$("#mark3").removeClass("mark4");
									$scope.car.guarTermCntLabel = Number($scope.car.guarTermCntLabel)+1;
								}else{
									$('#r_aa3').prop('checked', false);
								}
							}else{
								$('#r_aa3').prop('checked', true);
							}
						}
					}
					break;
				case 'BTN_CANCEL':
					$scope.$this.close();
					break;
				case 'BTN_ADDR_CHANGE':
					var addrPopup = ITCButton.getPopup('.fullAddress2').open();
					addrPopup.onCompleteHandle = function(data){
						$scope.car.parkZip   = data.zipNo;
						$scope.car.parkAddr1 = data.roadAddr;
						$scope.car.parkAddr2 = data.addrDtl;
					};
					break;
				}
			}



			//파일 업로드 [S]
			$scope.remove = function(index){
				var fileSeq = $scope.files.fileSeqs.splice(index, 1);	//실제 인덱스로 등록된 파일 시퀀스 삭제
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
		    	var newIndex = index + 1;		//다음 추가할 파일의 인덱스
		    	if(indexs.indexOf(newIndex) === -1 && indexs.length < 20){
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

		        	$scope.files.exists.push(index);				//파일 등록처리
		    		$scope.files.fileSeqs.push(resp.data.fileSeq);	//파일 시퀀스 저장
		    		$scope.files.srcs.push(url);					//파일 업로드 전 미리보기 표출
		    		//TODO: 이부분에서 Swiper 길이 업데이트 필요

		        }, function (resp) {
		            console.log('Error status: ' + resp.status);

		        });
		    };
			//파일 업로드 [E]

		    //매물 등록 [S]
		    $scope.regist = function(form){
		    	$('.accordionSet').removeClass('on');

		    	//차량번호 형식 체크
		    	var regPlate = /^[0-9]{2}[\s]*[가-힣]{1}[\s]*[0-9]{4}/gi;
				var regFrame = /^[A-Za-z0-9]{11}[\s]*[0-9]{6}/gi;
		    	if($util.isNotEmpty($scope.car.carPlateNum) && $scope.car.carPlateNum.length == 7){
					if(!regPlate.test($scope.car.carPlateNum)){
						alert("잘못된 차량번호 형식입니다.");
						$('input[name=carPlateNum]').closest('.accordionSet').addClass('on').find('input[name=carPlateNum]').focus();
						return;
					}
				}

		    	//유효성체크 [S]
		    	if($util.isEmpty($scope.car.carPlateNum)){
		    		alert('차량번호는 필수 항목입니다.');
		    		$('input[name=carPlateNum]').closest('.accordionSet').addClass('on').find('input[name=carPlateNum]').focus();
		    		return;
		    	}
		    	if(!$scope.car.makerCd){
		    		alert('제조사는 필수 항목입니다.');
		    		$('input[name=r_a]').closest('.accordionSet').addClass('on').find('#r_a0').focus();
		    		return;
		    	}
		    	if(!$scope.car.modelCd){
		    		alert('모델은 필수 항목입니다.');
		    		$('input[name=r_b]').closest('.accordionSet').addClass('on').find('#r_b0').focus();
		    		return;
		    	}
		    	if(!$scope.car.modelDtlCd){
		    		alert('세부모델은 필수 항목입니다.');
		    		$('input[name=r_c]').closest('.accordionSet').addClass('on').find('#r_c0').focus();
		    		return;
		    	}
		    	if(!$scope.car.gradeCd){
		    		alert('등급은 필수 항목입니다.');
		    		$('input[name=r_ee]').closest('.accordionSet').addClass('on').find('#r_ee0').focus();
		    		return;
		    	}
		    	if(!$scope.car.carRegYear){
		    		alert('연식은 필수 항목입니다.');
		    		$('input[name=carRegYear]').closest('.accordionSet').addClass('on').find('input[name=carRegYear]').focus();
		    		return;
		    	}
		    	if(!$scope.car.carFuel){
		    		alert('연료타입은 필수 항목입니다.');
		    		$('input[name=r_z]').closest('.accordionSet').addClass('on').find('#r_z').focus();
		    		return;
		    	}
		    	if(!$scope.car.carMission){//3
		    		alert('변속기는 필수 항목입니다.');
		    		$('input[name=reee]').closest('.accordionSet').addClass('on').find('#r_e0').focus();
		    		return;
		    	}
		    	if(!$scope.car.useKm.str){
		    		alert('주행거리는 필수 항목입니다.');
		    		$('input[name=useKm]').closest('.accordionSet').addClass('on').find('input[name=useKm]').focus();
		    		return;
		    	}
		    	if(!$scope.car.carColor){
		    		alert('색상은 필수 항목입니다.');
		    		$('input[name=carColor]').closest('.accordionSet').addClass('on').find('#r_f0').focus();
		    		return;
		    	}
		    	if(!$scope.car.surfaceState){
		    		alert('외관상태는 필수 항목입니다.');
		    		$('input[name=ri]').closest('.accordionSet').addClass('on').find('#r_i0').focus();
		    		return;
		    	}

		    	if($scope.$parent.sessUserInfo.division == 'D'){
		    		if($util.isEmpty($scope.car.applyDay)){
		    			alert('등록일자는 필수 항목입니다.');
		    			$('input[name=applyDay]').closest('.accordionSet').addClass('on').find('input[name=applyDay]').focus();
		    			return;
		    		}
		    		if($util.isEmpty($scope.car.saleAmt.str) || $scope.car.saleAmt.val === 0){
		    			alert('판매가격은 필수 항목입니다.');
		    			$('input[name=saleAmt]').closest('.accordionSet').addClass('on').find('input[name=saleAmt]').focus();
		    			return;
		    		}
		    		if(!$scope.car.carCheckNo){//7
			    		alert('성능점검번호는 필수 항목입니다.');
			    		$('input[name=carCheckNo]').closest('.accordionSet').addClass('on').find('input[name=carCheckNo]').focus();
			    		return;
			    	}
		    	}
		    	//유효성체크 [E]



		    	var params={};


		    	angular.extend(params, $scope.car);

		    	params.fileSeqs		=	$scope.files.fileSeqs.join(',');
		    	params.applyDay		=	$util.nvl($scope.car.applyDay,'');
		    	params.useKm		=	$scope.car.useKm.val;
		    	params.saleAmt		=	$scope.car.saleAmt.val;
		    	params.applyDay		=	params.applyDay.replace(/[^0-9]/gi,'');
		    	params.mycarSeq		=	$scope.car.mycarSeq;
		    	params.userId		=	$scope.$parent.sessUserInfo.userId;
		    	params.shopNo		=	$scope.$parent.sessUserInfo.division == 'D' ? $scope.$parent.sessUserInfo.shopNo : '';

		    	if(angular.isArray(params.optionCds)){
		    		params.optionCds	=	params.optionCds.join();
		    	}
		    	console.log(params);

		    	$http({
		    		method:'POST',
		    		url: BNK_CTX + '/front/my/mycar/regist',
		    		data: JSON.stringify(params)
		    	}).success(function(data, status, headers, config){

		    		if(data.resCd == '00'){
		    			alertify.alert("등록 되었습니다.");
		    			$scope.oParams = data.car;

		    			if($scope.$parent.sessUserInfo.division == 'N' && $scope.car.estReqYn != 'Y'){
		    				alertify.confirm('입력한 내차정보로 실시간 견적요청을 하시겠습니까?',
		    						function(){ ITCButton.closePopup(); ITCButton.getPopup('.realtimeChoice').open(); },
		    						function(){ ITCButton.closePopup();}
		    				);
		    			}else{
		    				ITCButton.closePopup();
		    			}
		    			$scope.$this.complete();

		    		}else{
		    			alertify.alert("등록이 실패하였습니다.");
		    		}



		        }).error(function(data, status, headers, config) {
		        });
		    }
		    //매물 등록 [E]

		    $scope.checkRender = function(){
		    	$scope.car.optionCds	=	$('input[id*="opt_c"]:checked').map(function(){ return this.value; }).get().join();
		    }

		    $scope.moveData = function (){
                console.log(JSON.stringify($scope.oParams));

                $scope.car.carPlateNum  = $scope.oParams.carPlateNum;     //차량번호
                $scope.car.carFrameNum  = $scope.oParams.carFrameNum;     //차대번호
                $scope.car.applyDay     = $scope.oParams.applyDay;        //등록일자
                $scope.car.carFullCode  = $scope.oParams.carFullCode;     //차량코드(제조사,모델,세부모델,등급 포함)
                $scope.car.carRegYear   = $scope.oParams.carRegYear;      //연식
                $scope.car.carColor     = $scope.oParams.carColor;        //색상
                $scope.car.surfaceState = $scope.oParams.surfaceState;    //외관상태

                $scope.car.extLabel = $scope.oParams.extLabel;

                $scope.car.optionCds    = [];                                   //옵션코드리스트
                $scope.car.optionCds	= $util.nvl($scope.oParams.optionCds, '').split(',');
                $scope.car.carMission   = $scope.oParams.carMission;      //변속기(컬럼미생성)
                $scope.car.missionLabel = $scope.oParams.missionLabel;    //변속기(컬럼미생성)
                $scope.car.useKm.set($scope.oParams.useKm);           //주행거리
                $scope.car.userId       = $scope.oParams.userId   ;       //사용자 아이디

                $scope.car.makerCd      = $scope.oParams.carFullCode.substring(0,3);
                $scope.car.modelCd      = $scope.oParams.carFullCode.substring(0,5);
                $scope.car.modelDtlCd   = $scope.oParams.carFullCode.substring(0,6);
                $scope.car.gradeCd      = $scope.oParams.carFullCode.substring(0,10);
                $scope.car.makerLabel   = $scope.oParams.makerLabel;
                $scope.car.modelLabel   = $scope.oParams.modelLabel;
                $scope.car.modelDtlLabel= $scope.oParams.modelDtlLabel;
                $scope.car.gradeLabel   = $scope.oParams.gradeLabel;
                $scope.car.colorLabel   = $scope.oParams.colorLabel;

                $localstorage.get('tempParams',{}).then(function(param){
                	$scope.tempParams ={};
                	$scope.tempParams = JSON.parse(param.oCar);
                	$scope.tempParams.type = '';
                	$localstorage.set('tempParams', {oCar: JSON.stringify($scope.tempParams)});
                });
                $scope.oParams.type = '';
			}

		    //닫기버튼 클릭 시 초기화
		    $scope.closeRegi = function(){
		    	$scope.$this.close();
				$scope.$this.complete();
		    	$scope.car={};
		    }
		}
	};
})
.filter('getTitle', function($util){
	return function(input){
		var title = '';

		if($util.isNotEmpty(input)){
			title = input;
		}else{
			title = '내차 등록·수정';
		}
		return title;
	}
});
