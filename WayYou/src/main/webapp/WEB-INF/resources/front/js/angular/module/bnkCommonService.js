/*******      Service            *******/
angular.module('bnk-common.service', [])
/**
 * util service
 */
.service('$util', ['$rootScope', '$location', '$sce', '$http',  function ($rootScope, $location, $sce, $http ) {
	//bnk scheme  파서 ( a 태그이용)
	this.parseURL = function ( url ) {
		if ( !url ) {
			return false;
		}

		var parser = document.createElement('a');
		parser.href = url.replace('bnk://', 'http://');
		return {
			source : url,
			protocol : parser.protocol.replace(':', ''),
			host : parser.hostname,
			port : parser.port,
			query : parser.search,
			params : (function () {
				var ret = {},
						seg = parser.search.replace(/^\?/, '').split('&'),
						len = seg.length, i = 0, s;

				for ( ; i < len; i++ ) {
					if ( !seg[i] ) {
						continue;
					}
					s = seg[i].split('=');
					ret[s[0]] = decodeURIComponent(s[1]);
				}
				return ret;
			})(),
			pathname : parser.pathname,
			file : (parser.pathname.match(/\/([^\/?#]+)$/i) || [, ''])[1],
			hash : parser.hash.substr(1),
			path : parser.pathname.replace(/^([^\/])/, '/$1'),
			relative : (parser.href.match(/tps?:\/\/[^\/]+(.+)/) || [, ''])[1],
			segments : parser.pathname.replace(/^\//, '').split('/')
		};
	};
	//scheme 실행

	// station으로 이동

	this.popup = function ( url, name ) {
		name = (name === undefined) ? '_blank' : name;
		window.open(url, name);
	};

	//팝업열때 post 로 parameter 보내기 위해 사용
	this.popupWithForm = function ( form ) {
		window.open("", 'newPopup');
		form.target = 'newPopup';
		form.submit();
	};

	// undefined값대신 ''빈값으로 return
	this.getParam = function ( oParam ) {
		return szParam ? szParam : '';
	};

	/**
	 * 더보기
	 * 중복 스크롤 callback 호출되는 현상을 방지하기위해 스크롤이벤트를 저장해놓는다. 이미 저장 되어있으면 pass
	 * @function callback
	 */
	var scrollCallback = null;
	this.lastItem = function ( callback ) {
		registScrollEvent();
		scrollCallback = callback;
	};
	// oScrollBind에 스크롤이벤트담기
	var oScrollBind;
	var registScrollEvent = function () {
		// 스크롤이벤트가 oScrollBind에 등록되어있지 않을때 등록하기
		if ( !oScrollBind )
		{
			oScrollBind = $(window).bind('scroll', function () {
				// 기본적으로 document Height가 window Height보가 크고, 스크롤이 맨하단에 왔을때 실행
				if ( ($(document).height() > $(window).height()) && ($(window).scrollTop() >= ($(document).height() - $(window).height() - 60)) ) {
					// 콜백이 있으면
					scrollCallback ? scrollCallback() : null;
				}
			});
		}
	};

	// 초로된 시간을 time fomat으로 변경
	this.secondsToTime = function ( nSeconds ) {
		// 빈값이면 return false;
		if ( !nSeconds ) {
			return false;
		}
		var d = Number(nSeconds / 1000);
		var h = Math.floor(d / 3600);
		var m = Math.floor(d % 3600 / 60);
		var s = Math.floor(d % 3600 % 60);
		return ((h > 0 ? (h >= 10 ? h : '0' + h) + ':' : '') + (m > 0 ? (m >= 10 ? m : '0' + m) : '00') + ':' + (s > 0 ? (s >= 10 ? s : '0' + s) : '00'));

	};


	this.isEmpty = function(obj){
		return typeof obj == "undefined" || obj == "undefined" || obj == '' || obj == "null" || obj == null;
	}
	this.isNotEmpty = function(obj){
		return !(typeof obj == "undefined" || obj == "undefined" || obj == '' || obj == "null" || obj == null);
	}
	this.nvl = function(obj, ref){
		return (typeof obj == "undefined" || obj == "undefined" || obj == '' || obj == "null" || obj == null) ? ref : obj;
	}
	this.inc = function(obj){
		return obj*1 +1;
	}
	this.range = function(N, S, V) {
	    S = S|0;
	    V = V|1;
	    var a = [];
	    for (var i = S; i < N; i+=V) {
	        a.push(i);
	    }
	    return a;
	}
	/**
	 * 문자열 포멧
	 * @returns {String}
	 */
	this.printf = function () {
		if ( !arguments || arguments.length < 1 || !RegExp )
		{
			return;
		}
		var str = arguments[0];
		var re = /([^%]*)%('.|0|\x20)?(-)?(\d+)?(\.\d+)?(%|b|c|d|u|f|o|s|x|X)(.*)/;
		var a = b = [], numSubstitutions = 0, numMatches = 0;
		while ( a = re.exec(str) )
		{
			var leftpart = a[1], pPad = a[2], pJustify = a[3], pMinLength = a[4];
			var pPrecision = a[5], pType = a[6], rightPart = a[7];

			//alert(a + '\n' + [a[0], leftpart, pPad, pJustify, pMinLength, pPrecision);

			numMatches++;
			if ( pType == '%' )
			{
				subst = '%';
			} else
			{
				numSubstitutions++;
				if ( numSubstitutions >= arguments.length )
				{
					alert('Error! Not enough function arguments (' + (arguments.length - 1) + ', excluding the string)\nfor the number of substitution parameters in string (' + numSubstitutions + ' so far).');
				}
				var param = arguments[numSubstitutions];
				var pad = '';
				if ( pPad && pPad.substr(0, 1) == "'" )
					pad = leftpart.substr(1, 1);
				else if ( pPad )
					pad = pPad;
				var justifyRight = true;
				if ( pJustify && pJustify === "-" )
					justifyRight = false;
				var minLength = -1;
				if ( pMinLength )
					minLength = parseInt(pMinLength);
				var precision = -1;
				if ( pPrecision && pType == 'f' )
					precision = parseInt(pPrecision.substring(1));
				var subst = param;
				if ( pType == 'b' )
					subst = parseInt(param).toString(2);
				else if ( pType == 'c' )
					subst = String.fromCharCode(parseInt(param));
				else if ( pType == 'd' )
					subst = parseInt(param) ? parseInt(param) : 0;
				else if ( pType == 'u' )
					subst = Math.abs(param);
				else if ( pType == 'f' )
					subst = (precision > -1) ? Math.round(parseFloat(param) * Math.pow(10, precision)) / Math.pow(10, precision) : parseFloat(param);
				else if ( pType == 'o' )
					subst = parseInt(param).toString(8);
				else if ( pType == 's' )
					subst = param;
				else if ( pType == 'x' )
					subst = ('' + parseInt(param).toString(16)).toLowerCase();
				else if ( pType == 'X' )
					subst = ('' + parseInt(param).toString(16)).toUpperCase();
			}
			str = leftpart + subst + rightPart;
		}
		return str;
	};

	// round(55.55, -1);   // 55.6
	// round(55.549, -1);  // 55.5
	// round(55, 1);       // 60
	this.ceil = function(value, exp) {
		// If the exp is undefined or zero...
	    if (typeof exp === 'undefined' || +exp === 0) return Math.ceil(value);
	    value = +value;
	    exp = +exp;
	    // If the value is not a number or the exp is not an integer...
	    if (isNaN(value) || !(typeof exp === 'number' && exp % 1 === 0)) return NaN;
	    // Shift
	    value = value.toString().split('e');
	    value = Math.ceil(+(value[0] + 'e' + (value[1] ? (+value[1] - exp) : -exp)));
	    // Shift back
	    value = value.toString().split('e');
	    return +(value[0] + 'e' + (value[1] ? (+value[1] + exp) : exp));
	};

	// round(55.55, -1);   // 55.6
	// round(55.549, -1);  // 55.5
	// round(55, 1);       // 60
	this.round = function(value, exp) {
		// If the exp is undefined or zero...
	    if (typeof exp === 'undefined' || +exp === 0) return Math.round(value);
	    value = +value;
	    exp = +exp;
	    // If the value is not a number or the exp is not an integer...
	    if (isNaN(value) || !(typeof exp === 'number' && exp % 1 === 0)) return NaN;
	    // Shift
	    value = value.toString().split('e');
	    value = Math.round(+(value[0] + 'e' + (value[1] ? (+value[1] - exp) : -exp)));
	    // Shift back
	    value = value.toString().split('e');
	    return +(value[0] + 'e' + (value[1] ? (+value[1] + exp) : exp));
	};

	// floor(55.59, -1);   // 55.5
	// floor(59, 1);       // 50
	// floor(-55.51, -1);  // -55.6
	this.floor = function(value, exp) {
		// If the exp is undefined or zero...
	    if (typeof exp === 'undefined' || +exp === 0) return Math.floor(value);
	    value = +value;
	    exp = +exp;
	    // If the value is not a number or the exp is not an integer...
	    if (isNaN(value) || !(typeof exp === 'number' && exp % 1 === 0)) return NaN;
	    // Shift
	    value = value.toString().split('e');
	    value = Math.floor(+(value[0] + 'e' + (value[1] ? (+value[1] - exp) : -exp)));
	    // Shift back
	    value = value.toString().split('e');
	    return +(value[0] + 'e' + (value[1] ? (+value[1] + exp) : exp));
	};

	/**
	 * 안드로이드 3.0 이상인지
	 * @returns {undefined}
	 */
	this.isGingerbreadHigher = function ()
	{
		var szUserAgent = navigator.userAgent.toLowerCase();
		if ( szUserAgent.indexOf('android') > -1 ) {
			var nAndroidMajorVersion = parseInt(szUserAgent.match(/android\s([0-9.]*)/i)[1][0]);
			if ( nAndroidMajorVersion < 3 ) {
				return false;
			}
		}
		return true;
	}


	this.getOS = function ()
	{
		var device;
		if ( navigator.userAgent.match(/iPhone|iPad|iPod/i) ) {
			device = 'ios';
		} else if ( navigator.userAgent.match(/Android/i) ) {
			device = 'android';
		} else if ( navigator.userAgent.match(/BlackBerry/i) ) {
			device = 'blackberry';
		} else if ( navigator.userAgent.match(/IEMobile|WPDesktop/i) ) {
			device = 'window';
		} else {
			device = 'etc';
		}
		return device;
	}


	var popup;
	this.callbackWindowPopup = function ( url, callback )
	{

		popup = window.open(url);
		var checkPopup = function () {
			if ( popup && popup.closed )
			{
				if ( callback )
					callback();
			} else
			{
				setTimeout(checkPopup, 500);
			}
		}
		setTimeout(checkPopup, 500)
	}
	// Scroll 이동
	this.moveScroll = function ( nPosition ) {
		setTimeout(function () {
			$('html, body').stop().scrollTop(nPosition);
			nPosition = 0;
		}, 10);
	}

	//모바일 고객센터 이동
	this.goReportHelp = function () {
		location.replace('http://m.naver.com');
	}


	// 언어 셋팅 (default en)
	this.language = function () {
		// 중국어
		if ( /^zh/ig.test(navigator.language) ) {
			return 'zh';
		}
		// 영어
		else if ( /^en/ig.test(navigator.language) ) {
			return 'en';
		}
		// 한국어
		else if ( /^ko/ig.test(navigator.language) ) {
			return 'ko';
		}
		// default : en
		else {
			return 'en';
		}
	};

	// 국가 가져오기
	this.getNationByNationalCode = function ( nNationalCode ) {
		// 중국
		if ( $.inArray(nNationalCode, [156, 158, 344]) > -1 ) {
			return 'chinese';
		}
		// 한국
		else if ( $.inArray(nNationalCode, [410]) > -1 ) {
			return 'korean';
		}
		// 기본
		else {
			return 'english';
		}
	};

	//popLayer
	this.setPopLayer = function ( title, content_tag ) {
		$rootScope.layer_title = title;
		$rootScope.layer_content = $sce.trustAsHtml(content_tag);
		$rootScope.bPopLayer = true;
	};

	/**
	 * Since 데이트 계산
	 * 현재 시간을 기준으로 계산을 하며 날짜기준이아닌 시간값을 기준으로 계산을 한다.
	 * 2017-05-10 15:00 영상을 현재시간 2017-05-12 16:00과 계산을 했을경우 48시간 이전 이므로 1일로 표시
	 * @param {type} time
	 * @returns {undefined|String}
	 */
	this.getBeforeDate = function ( time ) {

		var date1 = new Date(time * 1000);
		var now = new Date();
		var d = Math.abs(now - date1) / 1000;


		var s = {// structure
			year : 31536000,
			month : 2592000,
			week : 604800, // uncomment row to ignore
			day : 86400, // feel free to add your own row
			hour : 3600,
			minute : 60,
			second : 1
		};

		var year = Math.floor(d / s.year);
		var month = Math.floor(d / s.month);
		var week = Math.floor(d / s.week);
		var day = Math.floor(d / s.day);
		var hour = Math.floor(d / s.hour);
		var minute = Math.floor(d / s.minute);
		var second= Math.floor(d / s.second);

		if(year > 0){
			return year + '년 전';
		}
		else if(month > 0){
			return month + '개월 전';
		}
		else if(week > 0){
			return week + '주 전';
		}
		else if(day > 0){
			return day + '일 전';
		}
		else if(hour > 0){
			return hour + '시간 전';
		}
		else if(minute > 0){
			return minute + '분 전';
		}
		else{
			return second + '초 전';
		}
	};

	/**
	 * 관심딜러 등록/삭제
	 * 기능 : 관심딜러 클릭시 이벤트 처리(토글형식)
	 * 매개변수 :
	 * 1. 관심딜러ID(userId) 가 포함된 객체 형태 매개변수
	 * EX) {userId : 'hklee', carSeq: '103'}
	 * 2. 콜백함수
	 * resCd :
	 * 10 - 관심딜러 성공
	 * 99 - 관심딜러 실패
	 * */
	this.getInterestDealer = function(param, callback){
		var param = param;
		this.isLogin({
			success: function(){
				if(param.dealerInterestYn == 'Y'){
					param.dealerInterestYn = 'N';
				}else{
					param.dealerInterestYn = 'Y';
				}
				var promise = $http({
					url: BNK_CTX + '/api/user/interestDealer/'+param.userId
					, method: 'POST'
				});
				promise.then(success, error);

				function success(json){
					console.log('success : ', json.data);
					switch(json.data.resCd){
					case '00':
						console.log('관심딜러(등록/삭제) 성공 ')
						break;
					case '99':
						console.log('관심딜러 중 실패');
						break;
					}

					if(angular.isFunction(callback)){
						callback(json.data);
					}
				}
				function error(){
					console.log('error');
				}
			}
			, fail: function(){
				alertify.confirm('로그인이 필요한 페이지입니다.\n로그인하시겠습니까?', function(){ ITCButton.getPopup('.loginPop').open(); });
			}
		});

	}
	/**
	 * 찜하기
	 * 기능 : 찜하기 클릭시 이벤트 처리(토글형식)
	 * 매개변수 :
	 * 1. 매물식별SEQ(carSeq) 가 포함된 객체 형태 매개변수
	 * EX) {carPlateNum : '12345', carSeq: '103'}
	 * 2. 콜백함수
	 * resCd :
	 * 10 - 찜하기 성공
	 * 99 - 찜하기 실패
	 * */
	this.getDibsOnCar = function(param, callback){
		var param = param;
		this.isLogin({
			success: function(){
				var promise = $http({
					url: BNK_CTX +'/api/user/dibsOn/'+param.carSeq
					, method: 'POST'
				});
				promise.then(success, error);

				function success(json){
					console.log('success : ', json.data);
					switch(json.data.resCd){
					case '00':
						console.log('찜하기(등록/삭제) 성공 ')
						break;
					case '99':
						console.log('찜하기 중 실패');
						break;
					}

					if(angular.isFunction(callback)){
						callback(json.data);
					}
				}
				function error(){
					console.log('error');
				}
			}
			, fail: function(){
				alertify.confirm('로그인이 필요한 페이지입니다.\n로그인하시겠습니까?', function(){ ITCButton.getPopup('.loginPop').open(); });
			}
		});

	}

	/**
	 * 뷰 카운트
	 * 기능 : 뷰 카운트 처리
	 * 매개변수 :
	 *
	 * 1. 매물식별SEQ(carSeq) 가 포함된 객체 형태 매개변수
	 * EX) {carPlateNum : '12345', carSeq: '103'}
	 *
	 * 2. 콜백함수
	 *
	 * resCd :
	 * 10 - 뷰 카운트 성공
	 * 99 - 뷰 카운트 실패
	 * */
	this.incViewCnt = function(param, callback){
		var promise = $http({
			url: BNK_CTX + '/api/user/viewCnt/'+param.carSeq
			, method: 'POST'
		});
		promise.then(success, error);

		function success(json){
			console.log('success : ', json.data);
			switch(json.data.resCd){
			case '00':
				console.log('뷰 카운트 성공 ')
				break;
			case '99':
				console.log('뷰 카운트 중 실패');
				break;
			}

			if(angular.isFunction(callback)){
				callback(json.data);
			}
		}
		function error(){
			console.log('error');
		}
	};

	/**
	 * URL 파라미터 조회
	 * key를 매개변수로 입력받아 URL 파라미터로 넘어온 값을 반환한다.
	 * @param {type} parameter value
	 * @returns {String}
	 */
	this.getQueryStringValue = function(key) {
	  return decodeURIComponent(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + encodeURIComponent(key).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1"));
	}

	/**
	 * URL 파라미터 모두 삭제
	 */
	this.removeQueryString = function() {
		window.history.replaceState(null, null, window.location.pathname);
	}


	this.popupService=function(popupId, callback){
        var
            aniDuration         = 300,
            savePoints          = [],
            container,
            closeCallback,
            isIOS				= navigator.userAgent.match(/(iPod|iPhone|iPad)/),
            wH                  = $(window).height(),
            $b					= $('body'),
            $modal				= $(".popupDim"),
            $wrapBack			= $("#wrap_back"),
            $wrap				= $("#wrap"),
            $popup,
            $pHeader,
            $pContents,
            $pBottom
        ;

        //초기화
        init();
        function init(){
        	container = popupId;
			closeCallback = callback;
    	}

        /* 기본팝업 오픈 */
        function defaultPop() {
            $b.css({"overflow":"hidden", "height":"100%"});
//            ItDevice.lockScroll(true);	// 모바일 화면 : 모달레이어 뒤의 화면은 위 css로 스크롤을 막습니다.

            // 모달 팝업 인덱스 조정
            $modal.css("z-index",$popup.css("z-index") - 1);

            // 기본팝업 높이 조정
            var scrollHeight = $b.scrollTop() + ($b.height() - $popup.height()) / 2;
            $popup.css({
                top:scrollHeight
                , position:"absolute"
                , "margin-top":0
            }).add($modal).show();
        };

        /* 팝오버 팝업 오픈 */
        function popoverPop() {
            $b.css({"overflow":"hidden", "height":"100%"});
//            ItDevice.lockScroll(true);	// 모바일 화면 : 모달레이어 뒤의 화면은 위 css로 스크롤을 막습니다.

            // 모달 팝업 인덱스 조정
            $modal.css("z-index",$popup.css("z-index") - 1);
            $popup.add($modal).show();

        };

        /*
         * 풀팝업 오픈
         */
        function fullPop() {
            // wrap이 잠기기 전에 현재 scrollTop을 저장
            var scrollHeight = $b.scrollTop() + $b.height();

            // 팝업 애니메이션 시작 모션 세팅
            $popup.css('top',"0%").show()
            .find('.popupContents').css({'position':'absolute', 'top':scrollHeight});

            $pBottom.hide();

            // 팝업 헤더 애니메이션
            $pHeader
                .css({"top": scrollHeight, "position":"relative"})
                .animate({'top':scrollHeight - $popup.height()}, aniDuration, function(){
                    $(this).css({"top":"0px","position":"fixed"});
                });

            // 팝업 컨텐츠 height 설정
        	var hH = !!$pHeader?$pHeader.outerHeight():0,
                bH = !!$pBottom?$pBottom.outerHeight():0,
			    popupContentHeight = wH-(hH+bH);

            $pContents.css({
				'height'			: popupContentHeight ,
				'padding-top'		: hH ,
				'padding-bottom'	: bH
			});

            // 팝업 컨텐츠 애니메이션
            $pContents
                .animate({'top':scrollHeight - $popup.height(), scrollTop:0}, aniDuration, function(){
                	// 팝업 하단 버튼 등장
                	try {$pBottom.fadeIn(aniDuration/2);} catch(e){}

					$wrap.hide();
					$pContents.css({top:"0%"});
                });
        };

        /* 팝업 열기 버튼 클릭 이벤트*/
        this.openPopup = function(param){
        	$popup = $(container);
			$pHeader = $popup.find(".popupHeader");
        	$pContents = $popup.find(".popupContents");
        	$pBottom = $popup.find(".popupBottom");

            // 이전 팝업이 있을 경우 z-index를 1씩 증가시킵니다.
        	var z_ = parseInt($popup.css("z-index")),
    		pCnt = savePoints.length;
        	$popup.css("z-index", z_ + (1 * pCnt));

            // 팝업을 띄울때 body scroll position을 저장해둔다. > 팝업 닫을 때에 해당 scroll위치로 복귀 시킨다.
        	savePoints.push($b.scrollTop());

        	//아코디언, 버튼, 탭 등등 이벤트 처리
        	ITCommons.setupTypeCount();
        	ITCommons.setupTypeToggleAndTab();
        	ITCommons.setupTypeAccordion();
        	ITCommons.setupTypeCheckbox();
        	ITCommons.setupTypeRadio();

        	fullPop();
        	/*// 기본 팝업일 경우 -> 기본 팝업 오픈
            if($this.hasClass(P_BUTTON_PREFIX+sufd)) defaultPop();

            // 팝오버 팝업일 경우 -> 팝오버 팝업 오픈
            else if($this.hasClass(P_BUTTON_PREFIX+sufp)) popoverPop();

        	// 풀 팝업일 경우 -> 풀 팝업 오픈
        	else if($this.hasClass(P_BUTTON_PREFIX+suff)) fullPop();*/
        };

    	/* 팝업의 'X'(닫기) 버튼 클릭시 */
        this.closePopup=function(){
        	$popup = $(container);
			$pHeader = $popup.find(".popupHeader");
        	$pContents = $popup.find(".popupContents");
        	$pBottom = $popup.find(".popupBottom");
    		// 1) 기본 팝업일 경우
    		if($popup.hasClass("popupsmallWrap")) {
//        			$b.css({"overflow":"auto", "height":"auto"});
    			$b.css({"overflow":"auto", "height":"100%"});
    			ItDevice.lockScroll(false);

    			$popup.add($modal).hide();

                returnToScroll();
    		}

    		// 2) 풀팝업일 경우
    		else {
    			$popup.css("z-index", 1000);

                // 이전 스크롤 높이로 돌아가기 위해, 이전 페이지의 scrollTop위치로 popup을 이동시킵니다.
                var scrollHeight = $b.scrollTop() + $b.height();

                $popup.css('top',scrollTopBefore())
                .find('.popupContents').css({'position':'absolute'});

                // 이전 화면이 팝업이 아닐 경우, wrap 보이기
                if(savePoints.length - 1 == 0) $wrap.show();
                // 이전 팝업이 기본 팝업일 경우, wrap 보이기
                else if(savePoints.length - 1 != 0 && $modal.is(":visible")) $wrap.show();


                // 이전 화면 스크롤 위치 복귀
				returnToScroll();

				// 팝업 헤더 애니메이션
                $pHeader
                    .css({"top": "0%"})
                    .animate({'top':"100%"}, aniDuration);

                // 팝업 컨텐츠 애니메이션
                $pContents
                .css({"top": "0%"})
                    .animate({'top':'100%'}, aniDuration, function(){
                    	// 팝업 하단 버튼 사라짐
                    	if($pBottom.size() != 0)$pBottom.fadeOut(aniDuration/2, function(){$popup.hide();});
                    	else $popup.hide();
                });

                if ($pContents.length === 0){ // 팝업 컨텐츠가 없다면
                    if ($pHeader.length === 0){
                        // 팝업 하단 버튼 사라짐
                        if($pBottom.size() != 0)$pBottom.fadeOut(aniDuration/2, function(){$popup.hide();});
                        else $popup.hide();
                    } else {
                        setTimeout(function(){
                            // 팝업 하단 버튼 사라짐
                            if($pBottom.size() != 0)$pBottom.fadeOut(aniDuration/2, function(){$popup.hide();});
                            else $popup.hide();
                        },aniDuration);
                    }
                }

    		}

    		//팝업 닫을때 콜백함수 실행
    		if(angular.isFunction(closeCallback)){
    			closeCallback();
    		}
    	};




    	/////////////////////////////////////////////////////////////////
    	//    HELPER FUNCTIONS
        /////////////////////////////////////////////////////////////////

    	/* 이전 화면 스크롤 위치 */
    	function scrollTopBefore(){
    		return savePoints[savePoints.length-1];
    	}
    	/* 이전 화면 스크롤 위치로 복귀 */
    	function returnToScroll(){
            // 이전 화면의 스크롤위치로 복귀
    		var _bodyLastScrollYPos = scrollTopBefore();

    		savePoints.splice (-1,1);
            if (!!_bodyLastScrollYPos){
            	$b.scrollTop(_bodyLastScrollYPos);
            }
    	}

    	return this;
	};

	this.addressService = (function(){
		return {
			search : function(params){
				var defaultParams = {
					confmKey		: JUSO_API_KEY	//신청시 발급받은 승인키
					, currentPage	: '1'			//현재 페이지 번호
					, countPerPage	: '20'			//페이지당 출력할 결과 Row 수
					, resultType	: 'json'		//검색결과형식 설정(xml, json)
					, keyword		: ''			//주소 검색어
					, successCallback : function(data){console.log('default successCallback', data);}		//성공시 콜백함수
				}
				var mergeParams = angular.merge({}, defaultParams, params);

				$http({
					method: 'GET'
					, url: BNK_CTX + '/api/juso/addrlink'
					, params: mergeParams
				})
				.success(function(response){
					if(response.code == '00'){
						var json = response.data;
						var data = JSON.parse(json.substring(1, json.length-1));
						if(data.results.common.errorCode !== '0'){	//실패시 처리
							alert(data.results.common.errorMessage);

						}else if(data.results.common.errorCode === '0'){//성공시 처리
							if(angular.isFunction(mergeParams.successCallback)){
								mergeParams.successCallback(data);
							}
						}
					}else{
						alert('통신 환경이 원활하지 않거나 시스템 작업중입니다. 잠시 후 다시 접속해주세요.');
					}
				})
				.error(function(data){
					console.log('주소 검색중 에러');
				});
			}
		}
	})();

	this.isLogin = function(options){
		options.success = angular.isFunction(options.success) ? options.success : function(){};
		options.fail = angular.isFunction(options.fail) ? options.fail : function(){};
		/* AJAX 통신 처리 */
		$http.get(BNK_CTX + '/api/user/loginCheck',{async:false})
		.success(function(oRes){
			if(oRes.data.loginYn == 'Y'){
				angular.element('#wrap').scope().sessUserInfo = oRes.data.sessUserInfo;
				options.success();
			}else{
				options.fail();
			}
		})
		.error(function(){});
	};
}])
// Local Storage Service
.service('$localstorage', ['$window', '$util', '$http', '$q', '$rootScope', function($window, $util, $http, $q, $rootScope) {

	var db;
	var storeName = "bnkDB";
	var _$this = this;

	// 초기화 - DB객체, 시스템 코드
	this.init = function(){
		getDB().then(function(){
			_$this.sysCodesSync();
		});
	}
	// DB객체 조회
	function getDB(){
		var deffered = $q.defer();

		//prefixes of implementation that we want to test
	    window.indexedDB = window.indexedDB || window.mozIndexedDB || window.webkitIndexedDB || window.msIndexedDB;

	    //prefixes of window.IDB objects
	    window.IDBTransaction = window.IDBTransaction || window.webkitIDBTransaction || window.msIDBTransaction;
	    window.IDBKeyRange = window.IDBKeyRange || window.webkitIDBKeyRange || window.msIDBKeyRange

	    if (!window.indexedDB) {
	       window.alert("Your browser doesn't support a stable version of IndexedDB.")
	    }

	    var request = window.indexedDB.open("newDatabase", 1);

	    request.onerror = function(event) {
	       console.log("error: ");
	    };

	    request.onsuccess = function(event) {
	       db = request.result;
	       console.log("success: "+ db);
	       deffered.resolve(db);
	    };

	    request.onupgradeneeded = function(event) {
	       var db = event.target.result;
	       var objectStore = db.createObjectStore(storeName, {keyPath: "id"});

	    }
	    return deffered.promise;
	}


	/**
	 * 작성일	: 2017-06-20
	 * 작성자	: 서재영
	 * 함수명	: 시스템 코드 싱크 맞춤
	 * 설 명	: car,market,system의 그룹코드들 버전을 확인하여 버전이 맞지 않으면 싱크를 맞춤
	 */
	this.sysCodesSync = function(){
//		setSysCodesData();
		getSysCodesVersion()
			.then(function(data){
				if(data.codes.length > 0){
					getSysCodesData(data);
				}else{
					setSysCodesData();
					// 로컬스토리지에 저장된 코드가 없을경우 재시도
					_$this.get('codesInfo',{}).then(function(codesInfo){
						if(angular.equals({}, codesInfo)){
							data.codes = ['car','market','system'];
							getSysCodesData(data);
						}
					});
				}

			},function(){
				console.log('system code version check error!!');
				// 로컬스토리지에 저장된 코드가 없을경우 재시도
				_$this.get('codesInfo',{}).then(function(codesInfo){
					if(angular.equals({}, codesInfo)){
						alert("네트워크 연결이 원활하지 않습니다.");
						_$this.sysCodesSync();
					}
				});
			});
	};
	function getSysCodesVersion() {
		var deferred = $q.defer();
		$http({method: 'GET', url: BNK_CTX + '/api/code/version', cache: 'true'})
			.success(function(oRes){
				if(oRes.code == '00'){
					_$this.get('codesVersion',{}).then(function(codesVersion){
						var resArr = [];
						if(oRes.data.db != $util.nvl(codesVersion.db,0)){
							_$this.remove('car');_$this.remove('market');_$this.remove('system');_$this.remove('oSearch');	// 삭제
							resArr.push('car');resArr.push('market');resArr.push('system'); // 추가
						}
						if(oRes.data.car != $util.nvl(codesVersion.car,0))resArr.push('car');
						if(oRes.data.market != $util.nvl(codesVersion.market,0))resArr.push('market');
						if(oRes.data.system != $util.nvl(codesVersion.system,0))resArr.push('system');
						deferred.resolve({codes: resArr, versions: oRes.data});
					});
				}else{
					deferred.reject();
				}
			})
			.error(function(){
				deferred.reject();
			});
		return deferred.promise;
	}
	function getSysCodesData(data) {
		var promiseArr = [];
		for(var i in data.codes){
			promiseArr.push($http({method: 'GET', url: BNK_CTX + '/api/code/data/' + data.codes[i], cache: 'true'}));
		}
		if(promiseArr.length > 0){
			$q.all(promiseArr).then(function(resArr){
				_$this.get('codesInfo',{}).then(function(codesInfo){
					for(var i in resArr){
						var oRes = resArr[i].data;
						Object.assign(codesInfo, oRes.data);
					}
					_$this.set('codesInfo', codesInfo);
					_$this.set('codesVersion', data.versions);
					setSysCodesData();
				});
			}, function(){
				console.log('system code info get error!!');
				// 로컬스토리지에 저장된 코드가 없을경우 재시도
				_$this.get('codesInfo',{}).then(function(codesInfo){
					if(angular.equals({}, codesInfo)){
						alert("네트워크 연결이 원활하지 않습니다.");
						_$this.sysCodesSync();
					}
				});
			});
		}
	}
	function setSysCodesData(){
		_$this.get('codesInfo',{}).then(function(codesInfo){
			if($util.isNotEmpty(codesInfo)){
				//차량 코드
				carCodeSearchMap			=	codesInfo.CAR_CODE_SEARCH_INFO;				//차량매물 검색 코드
				carCodeQuickSearchList 		= 	codesInfo.CAR_CODE_QUICK_SEARCH;			//차량매물 퀵검색 코드
				carDefInfoCodeList			=	codesInfo.CAR_CODE_DEF_INFO;				//차량매물 정보 코드
				//매매단지 코드
				shopCodeInfoMap 			= 	codesInfo.MARKET_CODE_SHOP_INFO;			//매매상사 정보 코드
				//시스템 코드
				emailCodeList				=	codesInfo.SYS_CODE_EMAIL_DOMAIN_TYPE;     	//이메일 코드
				optionTypeCodeList			=	codesInfo.SYS_CODE_CAR_OPTION_TYPE;			//옵션종류 코드
				optionBasicCodeList			=	codesInfo.SYS_CODE_CAR_OPTION_BASIC;		//옵션(주요) 코드
				optionExternalCodeList		=	codesInfo.SYS_CODE_CAR_OPTION_EXTERNAL;		//옵션(외장장치) 코드
				optionInternalCodeList		=	codesInfo.SYS_CODE_CAR_OPTION_INTERNAL;		//옵션(내장장치) 코드
				optionConvenienceCodeList	=	codesInfo.SYS_CODE_CAR_OPTION_CONVENIENCE;	//옵션(안전장치) 코드
				optionSafetyCodeList		=	codesInfo.SYS_CODE_CAR_OPTION_SAFETY;		//옵션(편의장치) 코드
				optionMediaCodeList			=	codesInfo.SYS_CODE_CAR_OPTION_MEDIA;		//옵션(멀티미디어) 코드
				optionDefaultCodeList		=	codesInfo.SYS_CODE_CAR_OPTION_DEFAULT;		//옵션(기본) 코드
				evalDivCodeList				=	codesInfo.SYS_CODE_DEALER_EVAL_DIV;			//딜러평가구분 코드

				fuelTypeCodeList		=	codesInfo.SYS_CODE_CAR_FUEL_TYPE;				//연료종류 코드
				missionTypeCodeList		=	codesInfo.SYS_CODE_CAR_MISSION_TYPE;			//기어종류 코드
				colorTypeCodeList		=	codesInfo.SYS_CODE_CAR_COLOR_TYPE;				//색상종류 코드
				carStatusCodeList		=	codesInfo.SYS_CODE_CAR_STATUS;					//매물상태 코드
				carExtStatusCodeList	=	codesInfo.SYS_CODE_CAR_EXT_STATUS;				//매물외부상태 코드
				carAccStatusCodeList	=	codesInfo.SYS_CODE_CAR_ACC_STATUS;				//매물사고여부 코드
				eighteenAreaList		=   codesInfo.SYS_CODE_EIGHTEEN_AREA;				//18개 지역 코드
				carMaxPriceRangeList	=   codesInfo.SYS_CODE_MAX_PRICE;					//최대가격 코드
				carVehicleMileRageList	= 	codesInfo.SYS_CODE_VEHICLE_MILE;				//주행거리 코드
				carRentStatusCodeList	=	codesInfo.SYS_CODE_CAR_RENT_STATUS;				//렌터카사용여부 코드
				resTypeCodeList			=	codesInfo.SYS_CODE_RES_TYPE;					//예약 요청 구분 코드
				resStatusCodeList		=	codesInfo.SYS_CODE_RES_STATUS;					//예약 요청 구분 코드
				estTypeCodeList			=	codesInfo.SYS_CODE_EST_TYPE;					//견적 요청 구분 코드
				makeupStatusCodeList	=	codesInfo.SYS_CODE_MAKEUP_STATUS;				//메이크업 서비스 종류 코드
				makeupTypeCodeList		=	codesInfo.SYS_CODE_MAKEUP_OPTION;				//메이크업 서비스 종류 코드
				fakeTypeCodeList		=	codesInfo.SYS_CODE_FAKE_TYPE;					//허위매물 종류 코드


				regAreaCodeCommList 		= codesInfo.SYS_CODE_COMM_REG_AREA;				// 공통코드 이전등록지역구분 - C0004
				carUseDivCodeCommList 		= codesInfo.SYS_CODE_COMM_CAR_USE_DIV;			// 공통코드 차량 용도구분 - C0001
				carDivCodeCommList 			= codesInfo.SYS_CODE_COMM_CAR_DIV;				// 공통코드 차종구분(잔존율) - C0006
				carDetailDivCodeCommList 	= codesInfo.SYS_CODE_COMM_CAR_DETAIL_DIV;		// 공통코드 상세차종구분 - C0003

				chkDivCodeCommList		=	codesInfo.SYS_CODE_COMM_CATE_DIV;				//공통코드 category 구분

				// firing an event downwards
				$rootScope.$broadcast('onCodeReady', {});
			}
		});
	}

    this.get = function(key, defaultValue) {
    	var deffered = $q.defer();
    	function getData(db){
    		var transaction = db.transaction([storeName]);
    		var objectStore = transaction.objectStore(storeName);
    		var request = objectStore.get(key);

    		// DB조회 에러
    		request.onerror = function(event) {
    			console.log("Unable to retrieve daa from database!");
    		};
    		// DB조회 성공
    		request.onsuccess = function(event) {
    			// Do something with the request.result!
    			if(request.result) {
    				deffered.resolve(request.result['data']);
    			}else{
    				deffered.resolve(defaultValue);	// 값이 없을 경우 기본 입력값으로 출력
    			}
    		};
    	}

    	if(db){
    		getData(db);
    	}else{
    		getDB().then(function(db){ getData(db); });
    	}
    	return deffered.promise;
    }

    this.set = function(key, value) {
    	var deffered = $q.defer();
    	function setData(db){
    		var transaction = db.transaction([storeName], "readwrite");
    		var objectStore = transaction.objectStore(storeName);
    		var request = objectStore.put({ id: key, data: value });
    	}

    	if(db){
    		setData(db);
    	}else{
    		getDB().then(function(db){ setData(db); });
    	}
    	return deffered.promise;
     }

    this.remove = function(key) {
    	var request = db.transaction([storeName], "readwrite")
    	   .objectStore(storeName).delete(key);
    }

    this.setObject = function(key, value) {
      $window.localStorage[key] = JSON.stringify(value);
    };
    this.getObject = function(key) {
      return JSON.parse($util.nvl($window.localStorage[key], '{}'));
    };
}]);
