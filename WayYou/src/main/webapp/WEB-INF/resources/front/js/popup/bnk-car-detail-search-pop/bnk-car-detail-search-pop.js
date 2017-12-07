/**
 * 차량정보 상세검색
 *
 * jy-seo
 *
 **/
angular.module('bnk-common.directive')
.directive('carDetailSearchPop', function ($timeout, $http, $util, $rootScope) {

/* ####################################################################################
 * ## 팝업 상수설정														  				 ##
 * #################################################################################### */

	var PARENT_ID = 'wrap_back';				// 고정
	var TEMPLATE_ID = 'car-detail-search-pop';	// 변경 <= 팝업ID(폴더,파일명)

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

		/* ####################################################################################
		 * ## 멤버 초기값 설정													  				 ##
		 * #################################################################################### */

			//TODO: jy-seo 데이터 확인
			$scope.test = false;

			// 팝업 초기화
			$scope.$this = {};	// 팝업객체
			$scope.templateInit = function(){
				$scope.$this = ITCButton.initPopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'), 'full');
				ITCButton.setupTypePopup(angular.element('#'+TEMPLATE_ID).find('.popupWrap'));
				ITCButton.setupTypeAccordion();	//아코디언 초기화
				// 초기화 이벤트 설정
				$scope.$this.onOpenHandle= function(){
					$scope.init();
				};
				// 팝업 초기 데이터 설정
				$timeout(function(){
					seekBarInit();
					$scope.init();
				});
				$rootScope.$broadcast(TEMPLATE_ID, {});
			};

			$scope.$on('onCodeReady', function(){
				$scope.accordion.carCodeMap = carCodeSearchMap;			// 차량매물
				$scope.accordion.colorCodeList = colorTypeCodeList;		// 색상종류
				$scope.accordion.areaList = eighteenAreaList;			// 18개 지역
				$scope.oSearch.oLoadData 	= carCodeQuickSearchList;	// 퀵검색 자동완성을 위한 차량정보
			});

			// 시크바 검색조건 최소,최대 범위 설정
			$scope.seekbar = {};
			// 시크바 검색조건 최소,최대 범위 설정
			$scope.seekbar.selectedPriceVal = '';			// 선택한 최대가격
			$scope.seekbar.selectedMileageVal = '';			// 선택한 최대 주행거리
			$scope.seekbar.minPriceInRange = '100';			// 최소가격 범위 설정
			$scope.seekbar.maxPriceInRange = '10000';		// 최대가격 범위 설정
			$scope.seekbar.minMileageInRange = '1000';		// 최소 주행거리 범위 설정
			$scope.seekbar.maxMileageInRage = '300000';		// 최대 주행거리 범위 설정

			// 아코디언 코드 데이터
			$scope.accordion = {};
			$scope.accordion.promotionCodeMap = {}; 				// 매매구분
			$scope.accordion.carCodeMap = {};						// 차량매물
			$scope.accordion.colorCodeList = [];					// 색상종류
			$scope.accordion.areaList = [];							// 18개 지역
			$scope.accordion.marketList = [];						// 매매단지

			// 검색 조건
			$scope.oSearch = {};
			$scope.oSearch.oLoadData 	= [];			// 퀵검색 자동완성을 위한 차량정보
			$scope.oSearch.totListSize  = new Money();	// 검색 조획 갯수
			$scope.oSearch.words 		= [];			// 퀵검색 검색조건 담을 배열
			$scope.oSearch.price 		= '';			// 선택한 최대가격
			$scope.oSearch.mileage 		= '';			// 선택한 최대 주행거리
			$scope.oSearch.country 		= '';
			$scope.oSearch.countrys 	= [];
			$scope.oSearch.promotions	= [];
			$scope.oSearch.makers 		= [];
			$scope.oSearch.models 		= [];
			$scope.oSearch.modelDtls 	= [];
			$scope.oSearch.modelYear 	= '';
			$scope.oSearch.colors 		= [];
			$scope.oSearch.areas 		= [];
			$scope.oSearch.danjis 		= [];
			$scope.oSearch.carNumber 	= '';


			$scope.init = function() {
				// 시크바 검색조건 최소,최대 범위 설정
				angular.element('#BAR_PRICE').val($scope.seekbar.maxPriceInRange).change();		// 선택한 최대가격
				angular.element('#BAR_MILEAGE').val($scope.seekbar.maxMileageInRage).change();	// 선택한 최대 주행거리

				// 아코디언 코드 데이터
				$scope.accordion.promotionCodeMap = {'A': '프리미엄','B':'인증중고차'}; // 매매구분
				$scope.accordion.marketList = [];						// 매매단지

				// 검색 조건
				$scope.oSearch.totListSize.set($util.nvl($scope.oParams.totListSize,0)); // 검색 조획 갯수
				$scope.oSearch.words 		= []; 								// 퀵검색 검색조건 담을 배열
				$scope.oSearch.price 		= $scope.seekbar.maxPriceInRange;	// 선택한 최대가격
				$scope.oSearch.mileage 		= $scope.seekbar.maxMileageInRage;	// 선택한 최대 주행거리
				$scope.oSearch.country = '';
				$scope.oSearch.countrys = [];
				$scope.oSearch.promotions = [];
				$scope.oSearch.makers = [];
				$scope.oSearch.models = [];
				$scope.oSearch.modelDtls = [];
				$scope.oSearch.modelYear = '';
				$scope.oSearch.colors = [];
				$scope.oSearch.areas = [];
				$scope.oSearch.danjis = [];
				$scope.oSearch.carNumber = '';

				// 현장서비스 단지정보
				$scope.danjiNo ='';
				$scope.danjiNo = $scope.$parent.danjiNo;

				// 체크박스 초기화
				angular.element('[id^=countryKind]').prop('checked',false);

				// 아코디언 닫기
				accordionAllClose();

				// 퀵검색 동기화
				if($util.isNotEmpty($scope.oParams)){
					angular.forEach(angular.copy($scope.oParams.oConditions), function(data, key){
						if(data.id == 'SEARCH_WORD_PRICE'){
							angular.element('#BAR_PRICE').val(data.code).change();
						}else if(data.id == 'SEARCH_WORD_MILEAGE'){
							angular.element('#BAR_MILEAGE').val(data.code).change();
						}else if(data.id == 'SEARCH_WORD_COUNTRY'){
							if(data.code == 'A')angular.element('#countryKind1').prop('checked',true);
							if(data.code == 'B')angular.element('#countryKind2').prop('checked',true);
						}
						setWords(data);
					});
				}
			};

		/* #################################################################################### */


		/* ####################################################################################
		 * ## 이벤트 설정													  				 	 ##
		 * #################################################################################### */


			//아코디언 클릭한 인풋 자동 포커싱
			$scope.doFocus=function($event){
				if ($event.stopPropagation) $event.stopPropagation();		//이벤트 버블링 해제
				var $dl = $($event.target).closest('dl');
				$dl.find('.accordionData input[type=text],textarea,input[type=radio]:eq(0)').focus();
			}
			// 퀵검색 자동완성 핸들러
			$scope.onQuickSearchHandler = function(oData, oArr){
				setWords(angular.extend(oData.originalObject, {id:'SEARCH_WORD_CAR'}));
			};
			// 퀵검색 초기화 핸들러
			$scope.onQuickInitHandler = function(){
				$scope.oParams.oConditions = [];
				$scope.init();
				// 아코디언 닫기
				angular.element('.btn-accordion-switch.on').removeClass('on');
			};
			// 퀵검색 단어삭제 핸들러
			$scope.onQuickDeleteHandler = function(idx){
				var data = $scope.oSearch.words[idx];
				// seekbar 검색단어 삭제 분기처리
				if(data.id == 'SEARCH_WORD_PRICE'){
					$scope.seekbar.selectedPriceVal = $scope.seekbar.maxPriceInRange;
					$scope.onChange({id:data.id}); // seekbar를 검색조건에서 삭제할 경우 그룹 아이디로 삭제한다.
				}else if(data.id == 'SEARCH_WORD_MILEAGE'){
					$scope.seekbar.selectedMileageVal = $scope.seekbar.maxMileageInRage;
					$scope.onChange({id:data.id}); // seekbar를 검색조건에서 삭제할 경우 그룹 아이디로 삭제한다.
				}else if(data.id == 'SEARCH_WORD_COUNTRY'){
					if(data.code == 'A')angular.element('#countryKind1').prop('checked',false);
					if(data.code == 'B')angular.element('#countryKind2').prop('checked',false);
					delWords(data);
				}else{
					delWords(data);
				}
				// 아코디언 닫기
				angular.element('.btn-accordion-switch.on').removeClass('on');
			};

			$scope.onClick = function(type){
				switch(type){
				case 'BTN_DETAIL_SEARCH':
					// callback function
					$scope.onLoadCallback({ 'id': TEMPLATE_ID, 'data': angular.copy($scope.oSearch.words) });
					ITCButton.closePopup();
					break;
				}
			};

			$scope.onToggle = function(data){
				switch(data.id){
				case 'SEARCH_WORD_COUNTRY':
//					var isChecked = !isCodeInWords(data.id, data.code);
//					delWords({id:data.id});	// 전체삭제
//					if(isChecked){
//						setWords(data);
//					}
					if(!isCodeInWords(data.id, data.code)){
						setWords(data);
					}else{
						delWords(data);
					}
					break;
				case 'SEARCH_WORD_PROMOTION':
					if(!isCodeInWords(data.id, data.code)){
						setWords(data);
					}else{
						delWords(data);
					}
					break;
				case 'SEARCH_WORD_CAR':
					if(!isCodeInWords(data.id, data.code)){
						setWords(data);
					}else{
						delWords(data);
					}
					break;
				case 'SEARCH_WORD_MODEL_YEAR':
					delWords({id:data.id});	// 전체삭제
					setWords(data);
					break;
				case 'SEARCH_WORD_COLOR':
					if(!isCodeInWords(data.id, data.code)){
						setWords(data);
					}else{
						delWords(data);
					}
					break;
				case 'SEARCH_WORD_AREA':
					if(!isCodeInWords(data.id, data.code)){
						setWords(data);
					}else{
						delWords(data);
					}
					if($scope.oSearch.areas.length == 1){
						getMarketList($scope.oSearch.areas[0]); 	// 매매단지 리스트 조회
					}
					break;
				case 'SEARCH_WORD_DANJI':
					if(!isCodeInWords(data.id, data.code)){
						setWords(data);
					}else{
						delWords(data);
					}
					break;
				case 'SEARCH_WORD_CAR_NUMBER':
					delWords({id:data.id});	// 전체삭제
					setWords(data);
					break;
				}
			};

			$scope.filterCountry = function(items) {
				var result = {};
				var countryCd = '';
				if($scope.oSearch.countrys.length == 1){
					angular.forEach(items, function(v, k){
						if(k.indexOf($scope.oSearch.countrys[0]) == 0){
							result[k] = v;
						}
					});
				}else{
					result = items;
				}
				return result;
			};

			$scope.filterContainCodeByWords = function(id, code, domId) {
				angular.element('#'+domId).prop('checked', isCodeInWords(id, code));
			};

			$scope.filterContainCodesByWords = function(id, arr) {
				return arr.findIndex(function(d){return isCodeInWords(id, d);}) > -1;
			};

			$scope.onChange = function(data) {
				switch(data.id){
				case 'SEARCH_WORD_PRICE':
					// 최대값이 아닌경우 검색단어 노출
					if($scope.seekbar.selectedPriceVal != $scope.seekbar.maxPriceInRange){
						data.code = $scope.seekbar.selectedPriceVal;
						data.name = $scope.seekbar.selectedPriceVal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '만원';
						setWords(data);
					}else{
						angular.element('#BAR_PRICE').val($scope.seekbar.maxPriceInRange).change();
						delWords(data); // seekbar를 검색조건에서 삭제할 경우 그룹 아이디로 삭제한다.
					}
					break;
				case 'SEARCH_WORD_MILEAGE':
					// 최대값이 아닌경우 검색단어 노출
					if($scope.seekbar.selectedMileageVal != $scope.seekbar.maxMileageInRage){
						data.code = $scope.seekbar.selectedMileageVal;
						data.name = $scope.seekbar.selectedMileageVal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + 'km';
						setWords(data);
					}else{
						angular.element('#BAR_MILEAGE').val($scope.seekbar.maxMileageInRage).change();
						delWords(data); // seekbar를 검색조건에서 삭제할 경우 그룹 아이디로 삭제한다.
					}
					break;
				}
			};

		/* #################################################################################### */


		/* ####################################################################################
		 * ## API 요청	  													  				 ##
		 * #################################################################################### */

			// 아코디언 - 매매단지 리스트 조회
			var getMarketList = function(areaNm){
				/* AJAX 통신 처리 */
				$scope.accordion.marketList = [];
				$http.get(BNK_CTX + '/api/market/region/list', {
					params: {danjisido: areaNm}
				})
				.success(function(oRes){
					/* 성공적으로 결과 데이터가 넘어 왔을 때 처리 */
					if(oRes.code == "00"){
						// 조회 리스트 추가
						$scope.accordion.marketList = oRes.data.list;
					}
				})
				.error(function(data, status, headers, config) {
					/* 서버와의 연결이 정상적이지 않을 때 처리 */
					alert("데이터 통신상태가 원활하지 않습니다.");
					console.log(status);
				});
			};

			// 매물 리스트 조회
			var getList = function(){
				// 분기
				var type = $scope.$parent.type;

				// 파라미터 셋팅
				var oParams = {};			// 상세검색 조건
				oParams.pageListSize = 0;	// 페이지 사이즈
				oParams.oConditions = $scope.oSearch.words;		// 상세검색 조건
				
				if(type == "serviceList"){	// 현장서비스 단지정보
					oParams.danjiNo = $scope.$parent.danjiNo;
				}
				
				/* AJAX 통신 처리 */
				$http({
					method: 'POST',
					url: BNK_CTX + '/api/car/list/'+type,
					data: JSON.stringify(oParams)
				})
				.success(function(oRes){
					/* 성공적으로 결과 데이터가 넘어 왔을 때 처리 */
					if(oRes.code == "00"){
						
						// 20170717 jy-seo KFC 요청사항
						if($util.isNotEmpty($scope.oParams.dummy) && oRes.data.totListSize > 3000){
							if((isCodeInWords('SEARCH_WORD_COUNTRY', 'A') || isCodeInWords('SEARCH_WORD_COUNTRY', 'B'))
									&& !(isCodeInWords('SEARCH_WORD_COUNTRY', 'A') && isCodeInWords('SEARCH_WORD_COUNTRY', 'B'))){
								oRes.data.totListSize += (isCodeInWords('SEARCH_WORD_COUNTRY', 'A')? ($scope.oParams.dummy - 3000) : 3000);
							}else{
								oRes.data.totListSize += $scope.oParams.dummy;
							} 
						}
						
						// 검색 조획 갯수
						$scope.oSearch.totListSize.set(oRes.data.totListSize);
					}
				})
				.error(function(data, status, headers, config) {
					/* 서버와의 연결이 정상적이지 않을 때 처리 */
					console.log(status);
				});
			};

		/* #################################################################################### */

		/* ####################################################################################
		 * ## Helper Function												  				 ##
		 * #################################################################################### */

			// 아코디언 - 차량 토글 제어 클래스 초기화
			var carToggleClassInit = function() {
				$scope.accordion.toggleClassMaker = '';			// 토글 제어 클래스 제조사
				$scope.accordion.toggleClassModel = '';			// 토글 제어 클래스 모델
				$scope.accordion.toggleClassModelDtl = '';		// 토글 제어 클래스 세부모델
			};

			// 아코디언 - 매매단지 토글 제어 클래스 초기화
			var marketToggleClassInit = function() {
				$scope.accordion.toggleClassArea = '';			// 토글 제어 클래스 지역
				$scope.accordion.toggleClassDanji = '';			// 토글 제어 클래스 매매단지
			};

			var accordionAllClose = function(){
				angular.element('.btn-accordion-switch.on').each(
						function(i,v){ angular.element(v).removeClass('on'); });
			};

			// 아코디언 - 모델연식 배열 생성
			var makeModelYear = function() {
				var yearArr = [];
				var MIN = 2010;
				var MAX = new Date().getFullYear();
				for(var i=MIN; i <= MAX; i++){
					yearArr.push(i);
				}
				return yearArr;
			};

			//검색단어 추가
			var setWords = function(data){
				// seekbar 검색단어 추가 분기처리
				if((data.id == 'SEARCH_WORD_PRICE' || data.id == 'SEARCH_WORD_MILEAGE') && getGroupIdCodesInWords(data.id).length > 0){
					angular.extend(getGroupIdCodesInWords(data.id)[0], data);
					appendSearchWord(data);
				}else if(data.code.length > 0){
					$scope.oSearch.words.push(data);
					appendSearchWord(data);
				}
				getList();
			};
			//검색단어 제외
			var delWords = function(data){
				// 단일삭제
				if(data.code){
					var idx = getCodeIdxInWords(data.id, data.code);
					popSearchWord($scope.oSearch.words.splice(idx,1)[0]);
				}
				// 그룹아이디로 삭제
				else{
					var i = 0;
					while(i < $scope.oSearch.words.length && getCodeIdxInWords(data.id) > -1){
						var idx = getCodeIdxInWords(data.id);
						popSearchWord($scope.oSearch.words.splice(idx,1)[0]);
					}
				}
				getList();
			};

			//검색단어 추가
			function appendSearchWord(data){
				switch(data.id){
				// 검색단어 - 가격
				case 'SEARCH_WORD_PRICE':
					$scope.oSearch.price = data.code;
					break;
				// 검색단어 - 주행거리
				case 'SEARCH_WORD_MILEAGE':
					$scope.oSearch.mileage = data.code;
					break;
				// 검색단어 - 국가
				case 'SEARCH_WORD_COUNTRY':
//					$scope.oSearch.country = data.code;
					if($scope.oSearch.countrys.indexOf(data.code) == -1)
						$scope.oSearch.countrys.push(data.code);
					break;
				// 검색단어 - 프로모션
				case 'SEARCH_WORD_PROMOTION':
					if($scope.oSearch.promotions.indexOf(data.code) == -1)
						$scope.oSearch.promotions.push(data.code);
					break;
				// 검색단어 - 차량
				case 'SEARCH_WORD_CAR':
					// 제조사 추가
					if(data.code.length >= 3 && $scope.oSearch.makers.indexOf(data.code.substring(0,3)) == -1)
						$scope.oSearch.makers.push(data.code.substring(0,3));
					// 모델 추가
					if(data.code.length >= 5 && $scope.oSearch.models.indexOf(data.code.substring(0,5)) == -1)
						$scope.oSearch.models.push(data.code.substring(0,5));
					// 세부모델 추가
					if(data.code.length >= 6 && $scope.oSearch.modelDtls.indexOf(data.code.substring(0,6)) == -1)
						$scope.oSearch.modelDtls.push(data.code.substring(0,6));
					break;
				// 검색단어 - 색상
				case 'SEARCH_WORD_MODEL_YEAR':
					$scope.oSearch.modelYear = data.code;
					break;
				// 검색단어 - 색상
				case 'SEARCH_WORD_COLOR':
					if($scope.oSearch.colors.indexOf(data.code) == -1)
						$scope.oSearch.colors.push(data.code);
					break;
				// 검색단어 - 지역
				case 'SEARCH_WORD_AREA':
					// 지역 추가
					if($scope.oSearch.areas.indexOf(data.code) == -1)
						$scope.oSearch.areas.push(data.code);
					break;
				// 검색단어 - 매매단지
				case 'SEARCH_WORD_DANJI':
					// 매매단지 추가
					if($scope.oSearch.danjis.indexOf(data.code) == -1)
						$scope.oSearch.danjis.push(data.code);
					break;
				// 검색단어 - 차량번호
				case 'SEARCH_WORD_CAR_NUMBER':
					// 매매단지 추가
					$scope.oSearch.carNumber = data.code;
					break;
				}
			}

			//검색단어 제외
			function popSearchWord(data){
				// 배열안에 코드가 포함되어있는지 확인
				function isCodeInArr(arr, code){
					return arr.findIndex(function(d){return d.indexOf(code) == 0}) > -1;
				}
				// 배열안에 코드를 제외한다.
				function popCodeInArr(arr, code){
					var idx = arr.findIndex(function(d){return d == code;});
					if(idx > -1)arr.splice(idx, 1);
				}
				switch(data.id){
				// 검색단어 - 가격
				case 'SEARCH_WORD_PRICE':
					$scope.oSearch.price = $scope.seekbar.maxPriceInRange;
					break;
				// 검색단어 - 주행거리
				case 'SEARCH_WORD_MILEAGE':
					$scope.oSearch.mileage = $scope.seekbar.maxMileageInRage;
					break;
				// 검색단어 - 국가
				case 'SEARCH_WORD_COUNTRY':
//					$scope.oSearch.country = '';
					popCodeInArr($scope.oSearch.countrys, data.code);
					break;
				// 검색단어 - 프로모션
				case 'SEARCH_WORD_PROMOTION':
					popCodeInArr($scope.oSearch.promotions, data.code);
					break;
				// 검색단어 - 차량
				case 'SEARCH_WORD_CAR':
					// 제조사 제외
					if(data.code.length == 3){
						// 1. 모델들, 세부모델들에 제조사차량이 있는지 확인한다.
						if(!isCodeInArr($scope.oSearch.models, data.code) && !isCodeInArr($scope.oSearch.modelDtls, data.code)){
							// 1.1. 제조사차량이 없다면 제조사들에서 제외한다.
							popCodeInArr($scope.oSearch.makers, data.code);
						}
					}
					// 모델 제외
					else if(data.code.length == 5){
						// 1. 세부모델들에 모델이 있는지 확인한다.
						if(!isCodeInArr($scope.oSearch.modelDtls, data.code)){
							// 1.1. 모델이 없다면 모델들에서 제외한다.
							popCodeInArr($scope.oSearch.models, data.code);
						}
						// 2. 모델들, 검색어들에 제조사가 있는지 확인한다.
						if(!isCodeInArr($scope.oSearch.models, data.code.substring(0,3)) && !isCodeInWords(data.id, data.code.substring(0,3))){
							// 2.1. 제조사가 없다면 제조사들에서 제외한다.
							popCodeInArr($scope.oSearch.makers, data.code.substring(0,3));
						}
					}
					// 세부모델 제외
					else if(data.code.length == 6){
						// 1. 세부모델들에서 제외한다.
						popCodeInArr($scope.oSearch.modelDtls, data.code);
						// 2. 세부모델들, 검색어들에서 모델이 있는지 확인한다.
						if(!isCodeInArr($scope.oSearch.modelDtls, data.code.substring(0,5)) && !isCodeInWords(data.id, data.code.substring(0,5))){
							// 2.1. 모델이 없다면 모델들에서 제외한다.
							popCodeInArr($scope.oSearch.models, data.code.substring(0,5));
						}
						// 3. 모델들, 검색어들에서 제조사가 있는지 확인한다.
						if(!isCodeInArr($scope.oSearch.models, data.code.substring(0,3)) && !isCodeInWords(data.id, data.code.substring(0,3))){
							// 3.1. 제조사가 없다면 제조사들에서 제외한다.
							popCodeInArr($scope.oSearch.makers, data.code.substring(0,3));
						}
					}
					break;
				// 검색단어 - 연식
				case 'SEARCH_WORD_MODEL_YEAR':
					$scope.oSearch.modelYear = '';
					break;
				// 검색단어 - 색상
				case 'SEARCH_WORD_COLOR':
					popCodeInArr($scope.oSearch.colors, data.code);
					break;
				// 검색단어 - 지역
				case 'SEARCH_WORD_AREA':
					// 지역 추가
					popCodeInArr($scope.oSearch.areas, data.code);
					break;
				// 검색단어 - 매매단지
				case 'SEARCH_WORD_DANJI':
					// 매매단지 추가
					popCodeInArr($scope.oSearch.danjis, data.code);
					break;
				// 검색단어 - 차량번호
				case 'SEARCH_WORD_CAR_NUMBER':
					// 매매단지 추가
					$scope.oSearch.carNumber = '';
					break;
				}
			}

			/** SUB FUNCTION **/
			// 검색배열안에 코드가 포함되어있는지 확인
			function isCodeInWords(id, code){
				return $scope.oSearch.words.findIndex(function(d){return d.id == id && d.code == code}) > -1;
			}
			// 검색배열안에서 코드 순번을 구한다.
			function getCodeIdxInWords(id, code){
				if(code){
					return $scope.oSearch.words.findIndex(function(d){return d.id == id && d.code == code});
				}else{
					return $scope.oSearch.words.findIndex(function(d){return d.id == id});
				}
			}
			// 검색배열안에서 그룹아이디 코드들을 구한다.
			function getGroupIdCodesInWords(id){
				return $scope.oSearch.words.filter(function(d){return d.id == id});
			}

		/* #################################################################################### */

		}
	};
});


function seekBarInit(){
	var $document = $(document);
    var selector = '[data-rangeslider]';
    var $element = $(selector);

    // For ie8 support
    var textContent = ('textContent' in document) ? 'textContent' : 'innerText';

    // Example functionality to demonstrate a value feedback
    function valueOutput(element) {
        var value = element.value;
        var output = element.parentNode.getElementsByTagName('output')[0] || element.parentNode.parentNode.getElementsByTagName('output')[0];
        // 2017-07-31 상세검색 결과에 콤마찍기
        output[textContent] = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    $document.on('input', 'input[type="range"], ' + selector, function(e) {
        valueOutput(e.target);
    });

    // Basic rangeslider initialization
    $element.rangeslider({

        // Deactivate the feature detection
        polyfill: false,

        // Callback function
        onInit: function() {
            valueOutput(this.$element[0]);
        }
    });
}