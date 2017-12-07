/**
 * 최상위 Angular Controller
 * body tag에 지정되어있는 Global Controller 입니다.
 */
bnkApp.controller('globalCtrl', ['$scope', '$rootScope', '$http' ,'$util', '$q', '$localstorage', '$window', '$timeout', function ($scope, $rootScope, $http, $util, $q, $localstorage,$window,$timeout) {


	/*
	=================================== Left Slide Menu [S] ===================================
	메뉴 버튼 토글시(=on됐을 경우)
	body = .has-active-menu
	mask = .is-active
	menu = .is-active (=aside)
	wrap = .has-slide-left
	*/
	window.slideLeft = new Menu({
		wrapper: '#wrap', // wrap 지정
		type: 'slide-left', // 타입 지정
		menuOpenerClass: '.c-button', // 메뉴 열기 버튼 클래스 지정 (실제 동작이 아니라 메뉴가 열렸을 때 이벤트 동작을 막기 위해 동일 클래스를 지정)
		maskId: '#c-mask', // Mask Id 지정
		//closeBtn: '.c-menu-close'
	});
	window.slideRight = new Menu({
		wrapper: '#wrap', // wrap 지정
		type: 'slide-right', // 타입 지정
		menuOpenerClass: '.c-button', // 메뉴 열기 버튼 클래스 지정 (실제 동작이 아니라 메뉴가 열렸을 때 이벤트 동작을 막기 위해 동일 클래스를 지정)
		maskId: '#c-mask', // Mask Id 지정
		//closeBtn: '.c-menu-close'
	});

	$scope.onBackClick = function(){
		$window.history.back();
	}

	$scope.onHSnbBtnClick = function(){
		slideLeft.open();
	};

	$scope.onHMypageBtnClick = function(){
		$scope.isLogin({
			success: function(){
				slideRight.open();
			},
			fail: function(){
				alertify.confirm('로그인이 필요한 페이지입니다.\n로그인하시겠습니까?', function(){ ITCButton.getPopup('.loginPop').open(); });
			}
		});
	};

	// 메뉴 링크
	$scope.slideClick = function(path){
		if(path == '/front/category/mycar/sells'){
			$scope.isLogin({
				success: function(){
					var url = "";
					if($scope.sessUserInfo.division == "N"){
						url = BNK_CTX + "/front/my/mycar";
					}else{
						url = BNK_CTX + "/front/my/mycarDealer";
					}
					$timeout(function() {
						$localstorage.set('tempParams', {oCar: JSON.stringify({type: 'regist', title:'내차팔기'})});
						$window.location.href = url;
		    		}, 500);
				},
				fail: function(){
					alertify.confirm('로그인이 필요한 페이지입니다.\n로그인하시겠습니까?', function(){
						try{
							ITCButton.getPopup('.loginPop').open();
						}catch(e){
							$window.location.href = BNK_CTX + "/session/front/login";
						}

					});
				}
			});
		}else{
			$window.location.href = BNK_CTX + path;
		}
	}

	// 회원정보 수정 링크
	$scope.slideMemberClick = function(path, userId){
		$window.location.href = BNK_CTX + path + "?userId="+userId;
	}

	/*
	=================================== Left Slide Menu [E] ===================================
	 */


	// 로그인 유저정보
	$scope.sessUserInfo = {division:-1};

	/**
	 * 작성일	: 2017-06-13
	 * 작성자	: 서재영
	 * 함수명	: 로그인 체크
	 * 설 명	: Session 정보를 체크하여 로그인 중인지 판단하여 로그인 되었으면 success를 호출, 로그인 되지 않았으면 fail를 호출한다.
	 */
	$scope.isLogin = function(options){
		options = $util.nvl(options, {});
		options.success = angular.isFunction(options.success) ? options.success : function(){};
		options.fail = angular.isFunction(options.fail) ? options.fail : function(){};
		/* AJAX 통신 처리 */
		$http.get(BNK_CTX + '/api/user/loginCheck',{async:false})
		.success(function(oRes){
			if(oRes.data.loginYn == 'Y'){
				$scope.sessUserInfo = oRes.data.sessUserInfo;
				$scope.newDataInfo = oRes.data.newDataInfo;
				options.success();
			}else{
				options.fail();
			}
		})
		.error(function(){});
	};

	/**
	 * 작성일	: 2017-06-12
	 * 작성자	: 서재영
	 * 함수명	: 플로팅 탑 버튼 클릭
	 * 설 명	: 탑 버튼 클릭 시 스크롤을 최상단으로 이동시킨다.
	 */
	$scope.onFloatingTopBtnClick = function(){
		$util.moveScroll(0);
	};

	/**
	 * 작성일	: 2016-12-13
	 * 작성자	: 서재영
	 * 함수명	: 금액 3자리 묶음 콤마 이벤트 셋팅
	 * 설 명	: 스코프 전체 Object를 순회하면서 Money 객체에 watch를 설정한다.
	 * 입 력	: $o:스코프,m:서브함수(Watch),v:key
	 * 비 고	: $$포함된 키는 Angular 객체로 순회하지 않는다.
	 * 		  최대 5depth까지 순회 가능
	 */
	$scope.evtSetComma = function($o,m,v){	// s:String, o:Money
		v = v != 'undefined' && v != 'null' && typeof v === 'string' ? v : '';
		if(v.split('.').length > 5 || v.indexOf('$$') > -1)return;
		if($o instanceof Array){
			for(var i=0; i<$o.length; i++){
				$scope.evtSetComma($o[i],m,v+'['+i+']');
			}
		}else{
			v = v.length > 0 ? v+'.' : '';
			for(var k in $o) {
				if($o.hasOwnProperty(k) && $o[k] != null && typeof $o[k] === 'object'){
					if($o[k] instanceof Money){
						m(v+k+'.str', $o[k]);
					}else{
						$scope.evtSetComma($o[k],m,v+k);
					}
				}
			}
		}
	};

	/**
	 * 작성일	: 2017-02-23
	 * 작성자	: 서재영
	 * 함수명	: 메뉴 클릭 이벤트
	 * 설 명	:
	 */
	$scope.onUnloadMenuClick = function(code, context, param){

		var obj = $rootScope.$broadcast('pageout', false);
		if(obj.defaultPrevented)return

		console.log(code);
		console.log(context);

//		gmLoading.show({msg:'페이지 이동 중입니다.'});

		if(code == 'BTN_BACK'){
//			if(context.includes('estimate')){
//
//				if(context.includes('intro'))
//					location.href = '/front/main/main';
//				if(context.includes('write') || (context.includes('view') && !context.includes('compare')))
//					location.href = '/front/estimate/list';
//				if(context.includes('list') || context.includes('send'))
//					location.href = '/front/estimate/intro';
//				if(context.includes('view') && context.includes('compare'))
//					location.href = '/front/compare/list';
//
//			}else if(context.includes('document')){
//
//				if(context.includes('contracts'))
//					location.href = '/front/main/main';
//				if(context.includes('documentList'))
//					location.href = '/front/document/contracts';
//
//			}else if(context.includes('point')){
//
//				if(context.includes('list'))
//					location.href = '/front/main/main';
//				if(context.includes('introduction') || context.includes('lotte') || context.includes('samsung'))
//					location.href = '/front/point/list';
//
//			}else if(context.includes('hipass')){
//
//				if(context.includes('contracts'))
//					location.href = '/front/main/main';
//				if(context.includes('form'))
//					location.href = '/front/hipass/contracts';
//
//			}else if(context.includes('contract')){
//
//				if(context.includes('car'))
//					location.href = '/front/contract/contractlist';
//				if(context.includes('contractlist'))
//					location.href = '/front/main/main';
//
//			}else if(context.includes('question')){
//				if(context.includes('list')){
//					location.href = '/front/contents/faq';
//				}else if(context.includes('write')){
//					if(GM_PARAM_FLAG==='admin'){
//						location.href = '/front/question/admin';
//					}else{
//						location.href = '/front/question/list';
//					}
//				}else if(context.includes('view')){
//					if(GM_PARAM_FLAG==='admin'){
//						location.href = '/front/question/admin';
//					}else{
//						location.href = '/front/question/list';
//					}
//				}else if(context.includes('admin')){
//					location.href = '/front/main/main';
//				}
//			}else if(context.includes('promotion/car')){
//
//				if(context.includes('list'))
//					location.href = '/front/main/main';
//				if(context.includes('view'))
//					location.href = '/front/promotion/car/list';
//
//			}else{
//				location.href = '/front/main/main';
//			}
		}else if(code == 'BTN_SNB'){
//			if(context == 'HOME'){
//				location.href = '/front/main/main';
//			}else if(context == 'ESTIMATE_WRITE'){
//				location.href = '/front/estimate/write';
//			}else if(context == 'ESTIMATE_LIST'){
//				location.href = '/front/estimate/list';
//			}else if(context == 'ESTIMATE_COMPARE'){
//				location.href = '/front/estimate/compare/list';
//			}else if(context == 'ESTIMATE_SEND'){
//				location.href = '/front/estimate/send';
//			}else if(context == 'CONTRACT_NEW'){
//				moveToContPage(param);
//			}else if(context == 'CONTRACT_LIST'){
//				location.href = '/front/contract/contractlist';
//			}else if(context == 'DOCUMENT'){
//				location.href = '/front/document/contracts';
//			}else if(context == 'POINT'){
//				location.href = '/front/point/list';
//			}else if(context == 'HIPASS'){
//				location.href = '/front/hipass/contracts';
//			}else if(context == 'PROMOTION_CAR'){
//				location.href = '/front/promotion/car/list';
//			}else if(context == 'PROMOTION_EVENT'){
//				location.href = '/front/promotion/event';
//			}else if(context == 'PROMOTION_CATALOG'){
//				location.href = '/front/promotion/catalog';
//			}else if(context == 'PROMOTION_GUIDE'){
//				location.href = '/front/promotion/guidebook';
//			}else if(context == 'FAQ'){
//				location.href = '/front/contents/faq';
//			}else if(context == 'NOTICE'){
//				location.href = '/front/contents/notice';
//			}else if(context == 'QUESTION'){
//				location.href = '/front/question/admin';
//			}

		}
	};

//	$scope.moveEstimate = function(id, pw){
//		var isMobile = {
//			    Android: function() {
//			        return navigator.userAgent.match(/Android/i);
//			    },
//			    BlackBerry: function() {
//			        return navigator.userAgent.match(/BlackBerry/i);
//			    },
//			    iOS: function() {
//			        return navigator.userAgent.match(/iPhone|iPad|iPod/i);
//			    },
//			    Opera: function() {
//			        return navigator.userAgent.match(/Opera Mini/i);
//			    },
//			    Windows: function() {
//			        return navigator.userAgent.match(/IEMobile/i);
//			    },
//			    any: function() {
//			        return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
//			    }
//			};
//
//		var msg = '견적서 이용 중 문제 발생시 아래의 연락처로 문의바랍니다.\n\n김재연    02-850-0029\n박슬애    02-850-0071\n백운혁    02-850-0016\n이병진    02-850-0039\n\n';
//		if(isMobile.Android()){
//			alert(msg + '[크롬]\n 인터넷 상단 [설정] > [사이트 설정] > [팝업] 부분을 "차단" -> "허용" 으로 변경 후 사용해주세요.\n\n [인터넷]\n 인터넷 상단 [더보기] > [설정] > [고급] > [팝업 차단] 부분을 비활성화로 변경 후 사용해주세요.\n\n');
//			window.open("https://www.gmdnet.co.kr/cms/login.do?mode=login&sale_man_cd="+encodeURIComponent(id)+"&encflag="+encodeURIComponent(pw)+"&sso_swork=Y&FROM_SRC=LIST_EST", "_blank");
//		}else if(isMobile.iOS()){
//			alert(msg + '** iOS 견적서 사용 안내 **\n\n Safari 설정에서 팝업 차단 해제 후 사용이 가능합니다.\n 아래 설정방법을 참고하시기 바랍니다.\n\n [설정방법]\n Home화면 > 설정 > Safari > 팝업 차단 해제\n');
//			location.href = "https://www.gmdnet.co.kr/cms/login.do?mode=login&sale_man_cd="+encodeURIComponent(id)+"&encflag="+encodeURIComponent(pw)+"&sso_swork=Y&FROM_SRC=LIST_EST";
//		}else{
//
//		}
//	}

	//데이터 존재여부 체크
	$scope.exists = function(data){
		return $util.isNotEmpty(data);
	};

	$scope.isLogin();
}]);
// beforeunload 이벤트는 여기서 관리
bnkApp.factory('beforeUnload', function($rootScope, $window) {
	$window.onbeforeunload = function (e) {
		var confirmation = {};
		var event = $rootScope.$broadcast('onBeforeUnload', confirmation);

		if(event.defaultPrevented) {
			return confirmation.message;
		}
	}

	$window.onunload = function() {
		$rootScope.$broadcast('onUnload');
	};

	return {};
})
.run(function(beforeUnload) {
});