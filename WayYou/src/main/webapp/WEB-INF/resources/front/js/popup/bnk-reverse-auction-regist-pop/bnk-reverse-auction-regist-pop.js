/**
 * [매물상세]내게맞는매물 등록, 수정 팝업
 *
 * yh-lee
 *
 **/
angular.module('bnk-common.directive')
.directive('reverseAuctionRegistPop', function ($rootScope, $timeout, $http, $localstorage) {

/* ####################################################################################
 * ## 팝업 상수설정														  				 ##
 * #################################################################################### */

	var PARENT_ID = 'wrap_back';				// 고정
	var TEMPLATE_ID = 'reverse-auction-regist-pop';	// 변경 <= 팝업ID(폴더,파일명)

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
		controller: function($scope){

			// 팝업 초기화
			$scope.$this = {};	// 팝업객체
			$scope.templateInit = function(){
				$scope.$this = ITCButton.initPopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'), 'full');
				ITCButton.setupTypePopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'));
				ITCButton.setupTypeAccordion();	//아코디언 초기화
				uiModules.swiperUpdate();		//스와이퍼 초기화
				$rootScope.$broadcast(TEMPLATE_ID, {});
			};

			//코드값 설정
			$scope.$on('onCodeReady', function (event, data) {
				$scope.colorTypeCodeList	=	colorTypeCodeList;
				$scope.carCodeSearchMap		= carCodeSearchMap;
				$scope.makerList 			= carCodeSearchMap["makerList"];
			});

			//Form Data 초기화 [S]
			$scope.car={};
			$scope.car.useKm = '';
			$scope.car.carRegYear = '';
			$scope.car.carColor='';

			//CAR LABEL [S]
			$scope.car.makerLabel='';
			$scope.car.modelLabel='';
			$scope.car.modelDtlLabel='';
			$scope.car.colorLabel='';
			//CAR LABEL [E]

			//이미 내게맞는매물이 등록되어 있을 경우
			if($scope.oParams.reverAuctionInfo != null){
				console.log($scope.oParams.reverAuctionInfo);
				$scope.car.makerLabel		= $scope.oParams.reverAuctionInfo.label.makerName;
				$scope.car.modelLabel		= $scope.oParams.reverAuctionInfo.label.modelName;
				$scope.car.modelDtlLabel	= $scope.oParams.reverAuctionInfo.label.modelDtlName;
				$scope.car.useKm			= $scope.oParams.reverAuctionInfo.label.useKm;
				$scope.car.carRegYear		= $scope.oParams.reverAuctionInfo.carRegYear;
				$scope.car.colorLabel		= $scope.oParams.reverAuctionInfo.label.carColor;

				//코드값 일치시키기 위한 변수 처리
				var makerCd		= $scope.oParams.reverAuctionInfo.makerCd;
				var modelCd 	= $scope.oParams.reverAuctionInfo.modelCd;
				var modelDtlCd	= $scope.oParams.reverAuctionInfo.detailModelCd;

				$scope.oParams.reverAuctionInfo.modelCd = modelCd;
				$scope.oParams.reverAuctionInfo.detailModelCd = modelDtlCd;

				$scope.car.makerCd		= $scope.oParams.reverAuctionInfo.makerCd;
				$scope.car.modelCd		= $scope.oParams.reverAuctionInfo.modelCd;
				$scope.car.modelDtlCd	= $scope.oParams.reverAuctionInfo.detailModelCd;
				$scope.car.carColor		= $scope.oParams.reverAuctionInfo.carColor;
			}

			//CAR CONTROL OBJECT [S]
			$scope.car.focus={};
			$scope.car.focus.makerCd=false;
			$scope.car.focus.modelCd=false;
			$scope.car.focus.modelDtlCd=false;
			//CAR CONTROL OBJECT [E]

			//아코디언 토글상태값 초기화(제조사,모델,세부모델,등급)
			$scope.car.focus.resetToggle=function(){
				$scope.car.focus.makerCd=false;
				$scope.car.focus.modelCd=false;
				$scope.car.focus.modelDtlCd=false;

			}
			
			// 매물등록 내역을 초기화 한다.
			$scope.popClear = function(){
				$scope.car.makerLabel='';
				$scope.car.modelLabel='';
				$scope.car.modelDtlLabel='';
				$scope.car.makerCd='';
				$scope.car.modelCd='';
				$scope.car.modelDtlCd='';
				$scope.car.useKm='';
				$scope.car.carRegYear='';
				$scope.car.carColor='';
				$scope.car.colorLabel='';
			}

			$scope.doFocus=function($event){
				if ($event.stopPropagation) $event.stopPropagation();		//이벤트 버블링 해제
				var $dl = $($event.target).closest('dl');
				$dl.find('.accordionData input[type=text],input[type=radio]:eq(0)').focus();
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
				}
			}

			//아코디언 특정 행 클릭시 이벤트 처리
			$scope.onClick=function(code, $event, label){
				if ($event.stopPropagation) $event.stopPropagation();
				switch(code){
					case "ACCD_MAKER":
						$scope.car.makerLabel=label;
						$scope.car.modelLabel='';
						$scope.car.modelDtlLabel='';
						$scope.car.focus.makerCd=false;
						$scope.car.focus.modelCd=true;
						$scope.car.focus.modelDtlCd=false;
						$scope.car.modelCd='';
						$scope.car.modelDtlCd='';
						break;
					case "ACCD_MODEL":
						$scope.car.modelLabel=label;
						$scope.car.modelDtlLabel='';
						$scope.car.focus.makerCd=false;
						$scope.car.focus.modelCd=false;
						$scope.car.focus.modelDtlCd=true;
						$scope.car.modelDtlCd='';
						break;
					case "ACCD_DTL_MODEL":
						$scope.car.modelDtlLabel=label;
						$scope.car.focus.makerCd=false;
						$scope.car.focus.modelCd=false;
						$scope.car.focus.modelDtlCd=false;
						break;
					case "ACCD_COLOR":
						$scope.car.colorLabel=label;
						break;
				}
			}
			//내게맞는매물 정보
			$scope.getInfo = function(){
				$http({
					url: BNK_CTX + '/front/my/reverseAuction/getInfo'
					, method: 'GET'
				}).then(successCallback, errorCallback);
				function successCallback(json){
					if(json.data.resCd=='00'){
						$scope.oParams.reverAuctionInfo = json.data.reverAuctionInfo;
					}
				}
				function errorCallback(data){

				}
			}
			//내게맞는매물 등록
			$scope.regist = function(form){
				alertify.confirm('등록하시겠습니까?', function(){

					$('.accordionSet').removeClass('on');
					if(!$scope.car.makerCd){
						alert('제조사는 필수 값입니다.');
						$('input[name=r_a]').closest('.accordionSet').addClass('on').find('#r_a0').focus();
						return;
					}
					if(!$scope.car.modelCd){
						alert('모델은 필수 값입니다.');
						$('input[name=r_b]').closest('.accordionSet').addClass('on').find('#r_b0').focus();
						return;
					}
					if(!$scope.car.modelDtlCd){
						alert('세부모델은 필수 값입니다.');
						$('input[name=r_c]').closest('.accordionSet').addClass('on').find('#r_c0').focus();
						return;
					}

					var params={
						makerCd : $scope.car.makerCd
						, modelCd : $scope.car.modelCd
						, detailModelCd : $scope.car.modelDtlCd
						, carRegYear :$scope.car.carRegYear
						, useKm : $scope.car.useKm
						, carColor : $scope.car.carColor
					};

					$http({
						method:'POST',
						url: BNK_CTX + '/front/my/reverseAuction/regist',
						data: JSON.stringify(params)
					}).success(function(data){
						$scope.popClear();
						alert("내게맞는 매물의 등록이 완료되었습니다.");
						$scope.getInfo();
						ITCButton.closePopup();
					}).error(function(data, status, headers, config) {
						alert("등록에 실패하였습니다.");
					});
				});
			}
			//내게맞는매물 수정
			$scope.modify = function(form){
				alertify.confirm('수정하시겠습니까?', function(){
					$('.accordionSet').removeClass('on');
					if(!$scope.car.makerCd){
						alert('제조사는 필수 값입니다.');
						$('input[name=r_a]').closest('.accordionSet').addClass('on').find('#r_a0').focus();
						return;
					}
					if(!$scope.car.modelCd){
						alert('모델은 필수 값입니다.');
						$('input[name=r_b]').closest('.accordionSet').addClass('on').find('#r_b0').focus();
						return;
					}
					if(!$scope.car.modelDtlCd){
						alert('세부모델은 필수 값입니다.');
						$('input[name=r_c]').closest('.accordionSet').addClass('on').find('#r_c0').focus();
						return;
					}
					var params={
						makerCd : $scope.car.makerCd
						, modelCd : $scope.car.modelCd
						, detailModelCd : $scope.car.modelDtlCd
						, carRegYear :$scope.car.carRegYear
						, useKm : $scope.car.useKm
						, carColor : $scope.car.carColor
					};
					$http({
						method:'POST',
						url:  BNK_CTX + '/front/my/reverseAuction/modify',
						data: JSON.stringify(params)
					}).success(function(data){
						alert("내게맞는 매물의 수정이 완료되었습니다.");
						$scope.getInfo();
						ITCButton.closePopup();
					}).error(function(data, status, headers, config) {
						alert("수정에 실패하였습니다.");
					});
				});
			}
		}
	};
});