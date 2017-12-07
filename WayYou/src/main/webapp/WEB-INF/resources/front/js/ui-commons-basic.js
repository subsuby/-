// JS Comp... http://closure-compiler.appspot.com/home
var ItDevice = {}
ItDevice.isMobile = function () {
    var check = false;
    (function(a){if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino|android|ipad|playbook|silk/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4)))check = true})(navigator.userAgent||navigator.vendor||window.opera);
    return check;
};
ItDevice.getMobileOSName = function () {
    var userAgent = navigator.userAgent || navigator.vendor || window.opera;
    if( userAgent.match( /iPad/i ) || userAgent.match( /iPhone/i ) || userAgent.match( /iPod/i ) ){
        return 'iOS';
    } else if( userAgent.match( /Android/i ) ){
        return 'Android';
    } else {
        return 'unknown';
    }
};
ItDevice.isAndroid = ItDevice.getMobileOSName() == 'Android';
ItDevice.isIOS = ItDevice.getMobileOSName() == 'iOS';
/* iOS의 경우 body에 overflow : hidden이 잡히질 않아 'touch move'이벤트를 prevent */
ItDevice.lockScroll = function (lock){
        if(lock){
            $('body').on("touchmove", function(e){
                e.preventDefault();
            },false);
        } else {
            $('body').off("touchmove");
        }
    };

/**
 * Common JS (UI)
 *
 * Created By Think Tree Co., Ltd.
 *
 * require module
 *  -jQuery.2.2.0 (http://jquery.com/)
 *  -swiper.3.3.0.js (http://www.idangero.us/swiper/)
 *
 * @version 0.1
 * @date 2016. 02. 01.
 */
var fn_CommonJS_isRunning = false;
function fn_CommonJS(){
//    'use strict';

	if (fn_CommonJS_isRunning) return; // fn_CommonJS()가 실행되었을 때 반복실행되지 않도록 한다.
	if (!$(window) || !$(window).outerHeight()){setTimeout(function(){fn_CommonJS();}, 200); return;} // window를 아직 불러오지 못했을 경우 재귀실행한다.
	fn_CommonJS_isRunning = true;

	var $window = $(window),
		windowHeight = $(window).outerHeight() || document.body.clientHeight;

    // Constant
    var exportModules = {}, // window.uiModules에 export할 모듈

        _date       = new Date(),
        _dateTime   = _date.getTime(),

        // Regex
        regexNumber = /^\d+$/,

        EL_ACTIVE_CLASS         = 'on',
        EL_DATA_NAME_INDEX      = 'navIdx',

        /* --------------------------------
            발생 이벤트
        -------------------------------- */
        /* private 트리거 이벤트 타입 */
        TRIGGER_SHOP_EVENT_PRIVATE
            = 'trigger:shop-'+_dateTime,
        /*
            public 트리거 이벤트 타입
            예)
                $(document).on(TRIGGER_SHOP_EVENT_PUBLIC, function(){
                    console.log('public', arguments)
                });
        */
        TRIGGER_SHOP_EVENT_PUBLIC
            = 'trigger:shop',
        /* --------------------------------
            이벤트의 sub를 구분하기 위한 상수 [2번째 인자로 전달받는 배열값의 0번째는 아래의 타입이 넘어감]
        -------------------------------- */
        // 네비게이션 변경시 발생되는 이벤트 타입
        TRIGGER_SHOP_EVENT_TYPE_NAV_CHANGE
            = 'trigger:top-nav-change'
        ;

    function nvl(){
        if (
                arguments[0] === null || arguments[0] === undefined || arguments[0] === ''
                ||
                (
                    typeof arguments[0] === 'string' &&
                    (arguments[0] === 'null' || arguments[0] === 'undefined' || arguments[0].replace(/\s/g,'').length == 0)
                )
            ){
            return !!arguments[1]?arguments[1]:'';
        }
        return arguments[0];
    }

    /* ------------------------------------------------------------------------------------------
        ITCommons
    ------------------------------------------------------------------------------------------ */
    var ITCommons = function(){
        var itc = this;

        /*
         * $el에 Swiper을 추가한다.
         *
         * ------------ 사용방법
         * 1. 엘리먼트에 Class설정
         * <div class="nav"> <!-- new ITCommons().swiper(jQueryElement); 중 jQueryElement 셀렉터에 사용할 클래스 : id나 nodeName으로 선택할 수 있으므로 필수값 아님 -->
         *   <div class="swiper-wrapper"> <!-- Swiper Wrapper : 클래스명 필수 및 명칭 변경 불가!! -->
         *     <div class="swiper-slide"></div> <!-- 실제 Swiper될 아이템들 : 클래스명 필수 및 명칭 변경 불가!! -->
         *     <div class="swiper-slide"></div> <!--  -->
         *   </div>
         * </div>
         *
         * 2. JS로 Swiper 적용
         * var options = {}; // 옵션 설정 (돔의 속성 옵션보다 우선 적용됨)
         * var navSwiper = new ITCommons().swiper($('.nav[|#nav|div:eq(0)]'), options); // 'nav' 클래스가 들어가있는 돔 엘리먼트에 Swiper를 적용한다. 한번에 한개씩 적용 가능하다.
         *
         * ------------ 옵션들
         * // 프로퍼티
         * useMyWidth            : boolean - 각 아이템을 페이지단위로 넓이를 강제 변경하지 않는다.[즉, 디자인 된 넓이를 사용한다] (기본값 false - 엘리멘트 속성 사용 가능 : data-tt-sw-use-my-width="boolean")
         * autoHeight            : boolean - 각 아이템의 높이를 자동으로 변경한다. (기본값 false - 엘리멘트 속성 사용 가능 : data-tt-sw-use-my-width="boolean")
         * freeMode              : boolean - Swipe시 페이지단위로 맞추지 않는다.[페이징 효과를 적용하지 않는다] (기본값 false - 엘리멘트 속성 사용 가능 : data-tt-sw-use-my-width="boolean")
         * loop                  : boolean - 무한루프로 설정한다. (기본값 false - 엘리멘트 속성 사용 가능 : data-tt-sw-use-my-width="boolean")
         * // 콜백
         * onSlideChangeStart    : function - 슬라이드 변경 시작 되었을때 호출될 콜백 (기본값 없음 - 엘리멘트 속성 사용 불가)
         *
         * // 파라미터 =============================================
         * @param jQueryElementObject $el
         * @param jsonObject options
         * // 리턴 =============================================
         * @return SwiperObject
         */
        itc.swiper = function(){
            /*
             * Exception
             */
            function ITCommonsSwiperException(message){
                return {
                    name:        'ITCommons Swiper Exception',
                    message:     !!message ? message : 'Empty Message',
                    toString:    function(){return this.name + ': ' + this.message;}
                }
            }

            // Start Swiper Binding
            var $el = arguments[0],
                options = arguments[1] || {};

            // Validation Arguements [S]
            if ( $ === undefined || !($.fn) ){
                throw new ITCommonsSwiperException('undefined jQuery');
            } else if ( !($.fn['swiper']) ){
                throw new ITCommonsSwiperException('undefined Swiper');
            }
            if ( typeof $el !== 'object' || !($el instanceof $) || $el.length === undefined /*|| $el.length != 1*/ ){
                console.error($el);
                console.error(typeof $el !== 'object')
                console.error(!($el instanceof $))
                console.error($el.length === undefined)
                console.error(($el.length !== 1))

                throw new ITCommonsSwiperException('invalid "$el" parameter');
            }
            // Validation Arguements [E]

            var ttswPrefix = 'tt-sw',
                $ttswItem = $el,
                ttswOptions = { // Setup Options

                    useMyWidth              :       !!$ttswItem.data(ttswPrefix+'-use-my-width')||false, // (Boolean) ks-choi custom property
                    autoHeight              :       !!$ttswItem.data(ttswPrefix+'-auto-height')||false, // (Boolean) 세로 자동 맞춤 - true일 경우 화면 크기 변경시 반응 안함
                    freeMode                :       !!$ttswItem.data(ttswPrefix+'-free-mode')||false, // (Boolean) 세로 자동 맞춤 - true일 경우 화면 크기 변경시 반응 안함
                    loop                    :       $ttswItem.data(ttswPrefix+'-loop')||false, // (Boolean) 루프 활성 - loop시 복사 노드가 앞뒤로 추가되어 activeIndex가 변경된다. [0,1,2,3] > [0(3),1(0),2(1),3(2),4(3),5(0)]

                    centeredSlides          :       $ttswItem.data(ttswPrefix+'-centered-slides')||false, // (Boolean) 중앙에 슬라이더 아이템 맞춤
                    fitSlides               :       $ttswItem.data(ttswPrefix+'-fit-slides')||false, // (Boolean) 좌우에 슬라이더 아이템 맞춤 - centeredSlides 필수 true

                    /* Callbacks [S] */
                    // onSlideChangeStart : function(_swiper){} // : 슬라이드 변경 시작 되었을때 호출
                    /* Callbacks [E] */
                };

            $.extend(ttswOptions, options);

            ttswOptions.stopPropagation = true;

            return $ttswItem.swiper(ttswOptions); // Return Swiper Object;
        }


/*
// 갤럭시 구형모델에서 아래 function을 동작시 에러가 발생
var MutationObserver = window.MutationObserver || window.WebKitMutationObserver;

var observer = new MutationObserver(function(mutations, observer) {
// fired when a mutation occurs
console.log(mutations, observer);
// ...
});

// define what element should be observed by the observer
// and what types of mutations trigger the callback
observer.observe(document, {
subtree: true,
attributes: true
//...
});
*/

        itc.button = function(){
            var _b = this;
            var
                SUFFIX_CLASS_WRAPPER    = '-wrapper';
            var
                TYPE_DEFAULT            = 'btn-default',
                TYPE_COUNT              = 'btn-count',
                TYPE_TOGGLE             = 'btn-toggle',
                TYPE_CHECKBOX           = 'btn-checkbox',
                TYPE_RADIO              = 'btn-radio',
                TYPE_ACCORDION          = 'btn-accordion',
                TYPE_POPUP              = 'btn-popup',
                TYPES                   = [TYPE_DEFAULT, TYPE_COUNT, TYPE_TOGGLE, TYPE_CHECKBOX, TYPE_RADIO, TYPE_ACCORDION, TYPE_POPUP];

            /*
             * [-] 0 [+] 형태의 카운트 증가/감소 버튼 이벤트 추가
             *
             * > 사용 예)
             *      <div class="btn-count-wrapper" data-step="1" data-max="10" data-min="0">
             *          <button class="btn-count-m">-</button>
             *          <strong class="btn-count-o">0</strong>
             *          <button class="btn-count-p">+</button>
             *      </div>
             *
             * > wrapper에 아래와 같은 속성으로 기본 값 설정
             *      1. 증가/감소 수치 변경 : data-step="1", 기본값 0
             *      2. 최대값 변경 : data-max="10", 기본값 제한없음
             *      3. 최소값 변경 : data-min="0", 기본값 제한없음
             */
            function setupTypeCountmOnClick(e){
                var _$p = e.data._$p,
                    _$o = e.data._$o,
                    _$m = e.data._$m,
                    curVal = parseInt(_$o[0].nodeName.toLowerCase() === 'input' ? _$o.val() : _$o.text()),
                    step = e.data.step,
                    min = e.data.min,
                    max = e.data.max;
                if (typeof min === 'number' && curVal < min) {_$m.prop('disabled', true);return;}
                _$p.prop('disabled', false);
                curVal -= step;
                if (typeof min === 'number' && curVal <= min) {_$m.prop('disabled', true);curVal = min;}
                _$o[0].nodeName.toLowerCase() === 'input' ? _$o.val(curVal) : _$o.text(curVal);
            }
            function setupTypeCountpOnClick(e){
                var _$p = e.data._$p,
                    _$o = e.data._$o,
                    _$m = e.data._$m,
                    curVal = parseInt(_$o[0].nodeName.toLowerCase() === 'input' ? _$o.val() : _$o.text()),
                    step = e.data.step,
                    min = e.data.min,
                    max = e.data.max;
                if (typeof max === 'number' && curVal > max) {_$p.prop('disabled', true);return;}
                _$m.prop('disabled', false);
                curVal += step;
                if (typeof max === 'number' && curVal >= max) {_$p.prop('disabled', true);curVal = max;}
                _$o[0].nodeName.toLowerCase() === 'input' ? _$o.val(curVal) : _$o.text(curVal);
            }
            _b.setupTypeCount = function(){
                var
                    sufm = '-m', // Minus
                    sufp = '-p', // Plus
                    sufo = '-o' // Output
                    ;
                $('.'+TYPE_COUNT+SUFFIX_CLASS_WRAPPER).each(function(i){
                    var _$this = $(this),
                        _$m = _$this.find('.'+TYPE_COUNT+sufm),
                        _$p = _$this.find('.'+TYPE_COUNT+sufp),
                        _$o = _$this.find('.'+TYPE_COUNT+sufo),

                        curVal,
                        max     = regexNumber.test(_$this.data('max')) ? _$this.data('max') : null, // 최대값
                        min     = regexNumber.test(_$this.data('min')) ? _$this.data('min') : null, // 최소값
                        step    = regexNumber.test(_$this.data('step')) ? _$this.data('step') : 1 // 증감수
                        ;

                    if (!(_$o instanceof $)) return true;

                    // 입력되어 있는 값을 기본값으로 적용 (디폴트 0)
                    if (isNaN(curVal = parseInt(_$o[0].nodeName.toLowerCase() === 'input' ? _$o.val() : _$o.text()))){
                        curVal = 0;
                        _$o[0].nodeName.toLowerCase() === 'input' ? _$o.val(curVal) : _$o.text(curVal);
                    }
                    _$m.off('click', setupTypeCountmOnClick).on('click', {'_$p':_$p, '_$o':_$o, 'step':step, '_$m':_$m, 'min':min, 'max':max}, setupTypeCountmOnClick);
                    _$p.off('click', setupTypeCountpOnClick).on('click', {'_$p':_$p, '_$o':_$o, 'step':step, '_$m':_$m, 'min':min, 'max':max}, setupTypeCountpOnClick);
                });
            }

            /*
             * 토글 혹은 탭 형태의 이벤트 추가
             *
             * > 토글, 탭 공통 적용 방법
             *  1. 전체(버튼과 대상 엘리먼트)를 감싸는 노드에 'btn-toggle-wrapper' 클래스 추가
             *  2. 토글 버튼 각각에 'btn-toggle-switch' 클래스 추가
             *    2-1. 'dis' 클래스를 추가 할 경우 해당 탭은 선택이 불가능하다.
             *  3. 토글에 해당하는 다른 타겟들에 'btn-toggle-switch-target' 클래스 추가
             *
             * > 토글 옵션 속성
             *  1. (switch)data-on-class="값"        : [필수] (string : 'on') 스위치 버튼 선택시 'btn-toggle-switch-target' 클래스로 지정된 엘리먼트의 클래스 변경한다. (기본값:on, 대상 클래스:btn-toggle-switch)
             *  2. (wrapper)data-on-class="값"       : [옵션] (string : 'on') 스위치 버튼 선택시 선택된 버튼에 부여할 클래스 (기본값:on, 대상 클래스:btn-toggle-wrapper)
             *  3. (switch)data-on-sub-control="값"  : [옵션] (string : '') 스위치 버튼 선택시 타겟노드 안의 원하는 엘리먼트의 클래스를 변경
             *                          값 형태 : "셀렉터/삭제클래스/추가클래스:셀렉터/삭제클래스/추가클래스..." >>>>> ":"=각 엘리먼트 구분(n개의 엘리먼트 변경 가능), "/"=값 구분
             *                          값 예제 : "span.myClass1/class1/class2:span.myClass2/classA/classB"
             *  4. (wrapper)no-hide                 : [옵션] 스위치 타겟이 1개 이상일 경우 스위치 인덱스외 타겟은 모두 hide되는데, 이 속성 추가시 hide되지 않음
             *  5. (wrapper)data-on-class-use-multiple-target
             *                                      : multiple target일 때 switch에 등록한 on클래스를 모든 target에 등록 (등록안할 경우 기본인 switch와 같은 index위치의 target에만 on클래스 부여)
             *
             * > 탭 옵션 속성
             *  1. (wrapper)data-suffix-class="값" : [생략가능] 스위치 안에 스위치가 들어갈 경우(다중) 이를 구분하기 위해 사용 (기본값:하위의 'btn-toggle-switch'클래스가 있는 모든 엘리먼트가 대상이 됨, 대상 클래스:btn-toggle-wrapper)
             *                              예로) data-suffix-class="aaa"라고 넣었다면 'btn-toggle-switch' 와 'btn-toggle-switch-target' 클래스 뒤에 '-aaa'라고 추가해줘야 인식한다.
             *
             * > 사용 예 1) - 토글 : 일반 (='btn-toggle-switch-target'이 한개인 경우)
             *       <div class="btn-toggle-wrapper" data-on-class="on">
             *          <div>
             *              <button class="btn-toggle-switch on" data-on-class="grid1" data-on-sub-control="li/sub2/sub1">한줄보기</button>
             *              <button class="btn-toggle-switch" data-on-class="grid2" data-on-sub-control="li/sub1/sub2">두줄보기</button>
             *          </div>
             *          <div>
             *              <ul class="btn-toggle-switch-target grid1">
             *                  <li class="sub1">내용1</li>
             *                  <li class="sub1">내용2</li>
             *              </ul>
             *          </div>
             *      </div>
             *
             * > 사용 예 1) - 탭구성 : 일반 (='btn-toggle-switch-target'이 'btn-toggle-switch'수와 같을 때)
             *      <div class="btn-toggle-wrapper">
             *          <div>
             *              <a href="" onclick="return false;" class="btn-toggle-switch on">탭1</a>
             *              <a href="" onclick="return false;" class="btn-toggle-switch on">탭2</a>
             *              <a href="" onclick="return false;" class="btn-toggle-switch on">탭3</a>
             *          </div>
             *          <div class="btn-toggle-switch-target">탭1 내용</div>
             *          <div class="btn-toggle-switch-target">탭2 내용</div>
             *          <div class="btn-toggle-switch-target">탭3 내용</div>
             *      </div>
             *
             * > 사용 예 2) - 탭구성 : 하위 탭 (=탭 구성이 1개 이상 중첩될 경우)
             *      <div class="btn-toggle-wrapper" data-suffix-class="a">
             *          <div class="btnTab case1 grid4">
             *              <a href="" onclick="return false;" class="btn-toggle-switch-a on">책정보</a>
             *              <a href="" onclick="return false;" class="btn-toggle-switch-a on">책정보</a>
             *              <a href="" onclick="return false;" class="btn-toggle-switch-a on">책정보</a>
             *          </div>
             *          <div class="btn-toggle-switch-target-a">
             *              <div class="btn-toggle-wrapper">
             *                  <div>
             *                      <a href="" onclick="return false;" class="btn-toggle-switch on">서브 탭1</a>
             *                      <a href="" onclick="return false;" class="btn-toggle-switch on">서브 탭2</a>
             *                      <a href="" onclick="return false;" class="btn-toggle-switch on">서브 탭3</a>
             *                  </div>
             *                  <div class="btn-toggle-switch-target">서브 탭1 내용</div>
             *                  <div class="btn-toggle-switch-target">서브 탭2 내용</div>
             *                  <div class="btn-toggle-switch-target">서브 탭3 내용</div>
             *              </div>
             *          </div>
             *          <div class="btn-toggle-switch-target-a">탭2 내용</div>
             *          <div class="btn-toggle-switch-target-a">탭3 내용</div>
             *      </div>
             */
            function setupTypeToggleAndTabsOnClick(e){
                var _$sThis = $(this),
                    _$s = e.data._$s,
                    _$t = e.data._$t,
                    _index = _$s.index(_$sThis),
                    _hasOn = _$sThis.hasClass(_switchOnClass),
                    _$this = e.data._$this,
                    _useToggle = e.data._useToggle,
                    _useMultipleOn = e.data._useMultipleOn,
                    _switchOnClass = e.data._switchOnClass,
                    _targetOnClazzs = e.data._targetOnClazzs
                    ;

                /*
                 * 문자 배열을 jQuery "addClass()" 함수에 사용하기 위해 문자열(문자구분:스페이스)로 변환한다.
                 * ex) 입력 : ['a','b','c'] / 반환 : 'a b c'
                 *
                 * @param arr (array) : 문자 배열
                 *
                 * @return String : 스페이스로 구분되는 스트링 문자열
                 */
                function arrayToCssClassString (arr){
                    var result = '';
                    if (typeof arr !== 'object' || typeof arr['push'] !== 'function') return result;

                    for(var _i in arr) result += ' '+arr[_i];
                    return result;
                }

                function subItemClassControl(){
                    var _$$t = arguments[0];
                    var _subItemClassControl = arguments[1];
                    if (!!_$$t && !!_subItemClassControl){
                        var _subItemClassControlArray = _subItemClassControl.split(':');
                        for (var _subItemClassControlArrayIdx in _subItemClassControlArray){
                            _subItemClassControl = _subItemClassControlArray[_subItemClassControlArrayIdx];
                            _subItemClassControl = _subItemClassControl.split('/');
                            if (_subItemClassControl.length != 3) continue;
                            _$$t.find(_subItemClassControl[0]).removeClass(_subItemClassControl[1]).addClass(_subItemClassControl[2]);
                        }
                    }
                }

                if (_$sThis.hasClass('dis')) return false; // dis =  CSS 클래스(disabled 효과)로 해당 클래스가 있으면 리턴한다.

                if (!_useMultipleOn){
                   _$s.removeClass(_switchOnClass); // 모든 스위치에 on클래스 제거
                }

                if (_useToggle){
                    if (!_hasOn){
                        _$sThis.addClass(_switchOnClass)
                    } else {
                        _$sThis.removeClass(_switchOnClass)
                    }
                } else {
                    _$sThis.addClass(_switchOnClass); // 이벤트 대상 스위치에만 on클래스 추가
                }

                if (_$sThis[0].hasAttribute('top-by-on-tap')){
                    var topVal = _$this.offset().top - (($('#header').css('position')==='fixed')?$('#header').outerHeight():0);
                    if (!isNaN(parseInt(_$sThis.attr('top-by-on-tap')))){ topVal -= parseInt(_$sThis.attr('top-by-on-tap'));}
                    $('html, body, .popupContents').scrollTop(
                        topVal
                    );
                }

                // 타겟이 없을때
                if (_$t.length < 1){
                    // return; // 마지막에 $.fn.swiperUpdate() 호출 하기 위해 리턴 시키는 부분 주석처리
                }
                // 타겟이 1개뿐일때 (=클래스 토글 타입)
                else if (_$t.length == 1){
                    _$t
                        .removeClass(arrayToCssClassString(_targetOnClazzs)) // 타겟에 클래스 제거
                        .addClass(_$sThis.data('on-class')); // 타겟에 클래스 추가
                    // Sub Item Control
                    subItemClassControl(_$t, _$sThis.data('on-sub-control'));
                }
                // 타겟이 1개 이상일때 (인덱스로 구분하여 클래스 추가)
                else if (_$t.length > 1){
                    if(!_$this[0].hasAttribute('no-hide')){
                        if (_targetOnClazzs.length == 0){ // 타겟의 ON 클래스가 없을 때 show/hide를 기본 동작으로 한다. (같은 index를 타겟으로 함)
                            $(_$t.not( // 다른 타겟 숨김
                                    _$t.eq(_index).show() // 타겟 보여줌
                                )).hide();
                        } else { // 다른 타겟들 클래스 제거
                            if (_$this[0].hasAttribute('data-on-class-use-multiple-target')) {
                                _$t.removeClass(arrayToCssClassString(_targetOnClazzs)) // 모든 타겟에 클래스 제거
                                _$t.addClass(_$sThis.data('on-class')); // 모든 타겟에 클래스 추가
                                subItemClassControl(_$t, _$sThis.data('on-sub-control'));
                            }
                            else {
                                _$t.removeClass(arrayToCssClassString(_targetOnClazzs)) // 모든 타겟에 클래스 제거
                                _$t.eq(_index).addClass(_$sThis.data('on-class')); // index가 일치하는 타겟에 클래스 추가
                            }
                        }
                    }
                }
                setTimeout(function(){window.uiModules.swiperUpdate()},100); // Swiper 전체 높이를 update한다.
            }
            _b.setupTypeToggleAndTab = function(){
                var
                    sufs = '-switch',               // class suffix : Switch Buttons
                    suft = '-switch-target'         // class suffix : show/hide view targets
                    ;

                $('.'+TYPE_TOGGLE+SUFFIX_CLASS_WRAPPER).each(function(){
                    var _$this = $(this),                                            // 컨테이너
                        _selectSuffixClass = _$this.data('suffix-class') && _$this.data('suffix-class').length > 0 ? '-'+_$this.data('suffix-class') : '', // 하위 엘리먼트에 같은 기능이 들어갈 경우 select 값 변경
                        _$s = _$this.find('.'+TYPE_TOGGLE+sufs+_selectSuffixClass),     // 스위치들
                        _$t = _$this.find('.'+TYPE_TOGGLE+suft+_selectSuffixClass),     // 타겟들

                        _useToggle = _$this.data('toggle-on') || false,                 // 토글 기능 사용 여부 (off>on, on>off)
                        _useMultipleOn = _$this.data('multiple-on') || false,           // 다중 on이 될 수 있도록
                        _switchOnClass = _$this.data('on-class')||EL_ACTIVE_CLASS,      // 스위치의 ON 클래스 (기본값 : on)
                        _targetOnClazzs = []                                            // 타겟의 ON 클래스 (기본값 : 없음)
                        ;
                    _$s.each(function(){
                        var _thisOnClass = $(this).data('on-class');
                        if (typeof _thisOnClass === 'string' && _thisOnClass.length > 0)_targetOnClazzs.push(_thisOnClass);
                    });

                    if(_useMultipleOn) _useToggle = true;

                    _$s.off('click', setupTypeToggleAndTabsOnClick)
                        .on('click',
                            {
                                '_$this':_$this,
                                '_$s':_$s,
                                '_$t':_$t,
                                '_useToggle':_useToggle,
                                '_useMultipleOn':_useMultipleOn,
                                '_switchOnClass':_switchOnClass,
                                '_targetOnClazzs':_targetOnClazzs
                            },
                            setupTypeToggleAndTabsOnClick);
//                    if (!_$this.hasClass('no-auto-selected')){
//                    	_$s.each(function(i){
//                            if (!$(this).hasClass('dis')){
//                            	_$s.eq(i).click(); // 첫번째 탭 요소가 보여지도록 하기 위해 el(0)번째 click이벤트 발생
//                            	return false;
//                            }
//                        });
//                    }
                });
            }


            /*
             * 아코디언 형태의 이벤트 추가
             *
             * > 아코디언 적용 방법
             *  1. 전체(스위치와 대상 엘리먼트)를 감싸는 노드에 'btn-accordion-wrapper' 클래스 추가
             *  2. 클래스 토글 엘리먼트에 각각에 'btn-accordion-switch' 클래스 추가
             *    2-1. 'dis' 클래스를 추가 할 경우 해당 아코디언은 선택이 불가능하다.
             *  3. 실제 토글 버튼 역할을 할 엘이먼트에 'btn-accordion-switch-item' 클래스 추가
             *
             * > 토글 옵션 속성
             *  1. (wrapper)data-on-class="값"       : (string:기본값'on') [옵션] 토글 버튼 선택시 해당 클래스 토글 엘리먼트에 부여할 클래스
             *                                  (대상 클래스:(btn-accordion-switch-item 클래스 부모 노드의 btn-accordion-switch))
             *  2. (wrapper)data-toggle-on="값"      : (boolean:기본값'false') [옵션] on 클래스를 토글시킴
             *                                  (Item Click > Switch - bind 'On' Class > Item Click > Switch - unbind 'On' Class)
             *                                  (* 아래 속성인 (switchItem)'data-accordion-close-switch'가 추가 될 경우 이 속성은 무시됨. > 토글이 필요한 스위치는 각 스위치에 아래 'data-toggle-on'속성을 추가하여 컨트롤 가능)
             *  3. (switch)data-toggle-on="값"      : (boolean:기본값'false') [옵션] on 클래스를 토글시킴
             *                                  ('data-accordion-close-switch'속성 추가시 '.btn-accordion-switch-item'를 눌러도 토글되지 않는다. 닫기버튼도 별도로 있으며 switch-item 선택시에도 토글되지 원할경우 true로 값 추가)
             *  4. (switch)data-accordion-move-to-top   : (string) on이 될 때 해당 switch가 상단에 붙도록 설정한다.
             *                                  data
             *                                      empty : 바로 상단에 붙는다.
             *                                      selector : 해당 엘리먼트 높이만큼 아래 붙는다. (ex: '#header')
             *  5. (wrapper)data-multiple-on="값"    : (boolean:기본값'false') [옵션] 여러 switch 엘리먼트에 'on'클래스를 부여가 가능하다. (여러 아코디언을 확장 가능한 상태로 만듬), false일 경우 wrapper당 최대 1개의 switch만 on 가능.
             *  6. (wrapper)data-suffix-class="값" : [생략가능] 아코디언 안에 아코디언이 들어갈 경우(다중) 이를 구분하기 위해 사용 (기본값:하위의 'btn-accordion-switch'클래스가 있는 모든 엘리먼트가 대상이 됨, 대상 클래스:btn-accordion-wrapper)
             *                              예로) data-suffix-class="aaa"라고 넣었다면 'btn-accordion-switch' 와 'btn-accordion-switch-item' 클래스 뒤에 '-aaa'라고 추가해줘야 인식한다.
             *  7. (switch)data-accordion-close-switch :  (string[selector]:'') 아코디언 닫기 버튼이 별도로 있을 때
             *                                  (닫기 버튼이 여러개일 때 ',[콤마]'로 구분하여 추가할 수 있으며, 'btn-accordion-switch-item'로 지정된 엘리먼트는 추가하면 안됨('data-toggle-on'을 사용할 것).)
             *
             * > 기타 클래스
             *  1. 'dis' : 해당 엘리먼트를 선택하지 못하도록 한다.
             *
             * > 사용 예 1) - 아코디언 : 단일
             *    <div class="btn-accordion-wrapper" data-toggle-on="true" data-multiple-on="true">
             *       <dl class="btn-accordion-switch on">
             *           <dt class="btn-accordion-switch-item">단독 아코디언 스타일</dt>
             *           <dd>
             *               내용이 나오는 영역입니다.<br/>
             *               Click으로 변경될 예정임
             *           </dd>
             *       </dl>
             *   </div>
             * > 사용 예 2) - 아코디언 : 다중
             *    <div class="btn-accordion-wrapper" data-toggle-on="true">
             *       <dl class="btn-accordion-switch on">
             *           <dt class="btn-accordion-switch-item">다중 아코디언 스타일</dt>
             *           <dd>
             *               내용이 나오는 영역입니다.<br/>
             *               Click으로 변경될 예정임
             *               현재 hover 스타일로 되어있지만 onClick으로 해주셔야 합니다.
             *           </dd>
             *       </dl>
             *       <dl class="btn-accordion-switch">
             *           <dt class="btn-accordion-switch-item">다중 아코디언 스타일</dt>
             *           <dd>
             *               내용이 나오는 영역입니다.<br/>
             *               Click으로 변경될 예정임
             *           </dd>
             *       </dl>
             *   </div>
             * > 사용 예 3) - 아코디언 : 별도의 닫기 버튼이 있는 아코디언
             *    <ul class="btn-accordion-wrapper" data-multiple-on="true">
             *       <!-- Loop -->
             *       <li class="btn-accordion-switch" data-accordion-close-switch=".acc-close">
             *           <div class="btn-accordion-switch-item">
             *               <h3>안내1</h3>
             *               <span>2015-12-16</span>
             *           </div>
             *           <div style="display:none;">
             *               <p>컨텐츠 영역입니다.</p>
             *               <button class="acc-close">닫기</button>
             *           </div>
             *       </li>
             *       <li class="btn-accordion-switch" data-accordion-close-switch=".acc-close">
             *           <div class="btn-accordion-switch-item">
             *               <h3>안내2</h3>
             *               <span>2015-12-15</span>
             *           </div>
             *           <div style="display:none;">
             *               <p>컨텐츠 영역입니다.</p>
             *               <button class="acc-close">닫기</button>
             *           </div>
             *       </li>
             *       <!-- // Loop -->
             *   </ul>
             */
            /*
             * 아코디언을 닫는 함수 (='on'클래스 제거)
             */
            function setupTypeAccordionaccordionClose(e /*
                    e: Event
                    e.data: on()함수로 data에 노드를 담아 넘겨준다
                    e.data.sufs
                    e.data.sufsi
                    e.data._selectSuffixClass
                    e.data.s = switch
                    e.data.si = switchItem
                    e.data.uoi = useOnItem
                    e.data.umo = useMultipleOn
                */ ){
                e.data.s.removeClass(e.data._switchOnClass);
                setTimeout(function(){window.uiModules.swiperUpdate()},100); // Swiper Height 갱신
            }
            function setupTypeAccordionsiOnClick(e){
                var sufs = e.data.sufs,
                    sufsi = e.data.sufsi,
                    _$this = e.data._$this,
                    _selectSuffixClass = e.data._selectSuffixClass,
                    _$s = e.data._$s,
                    _$si = e.data._$si,
                    _useToggle = e.data._useToggle,
                    _useMultipleOn = e.data._useMultipleOn,
                    _switchOnClass = e.data._switchOnClass,
                    _$siThis = $(this),  // 아코디언 스위치 아이템
                    _$sThis = _$siThis.parents('.'+TYPE_ACCORDION+sufs+_selectSuffixClass+':eq(0)'), // 아코디언 스위치
                    _index = _$s.index(_$sThis), // 아코디언 스위치들 중의 index
                    _hasOn = _$sThis.hasClass(_switchOnClass), // 아코디언 스위치에 활성화('on')되어있는지
                    _sCloseItemSel = _$s.data('accordion-close-switch'), // 아코디언을 닫을 버튼
                    _useSwitchToggle = _$sThis.data('toggle-on') || false
                    ;

                /*
                 * 닫기 버튼이 있는 경우 해당 버튼에 아코디언을 닫는 이벤트를 추가
                 */
                function bindAccordionCloseEvent(_$s, _$si){
                    if (typeof _$s !== 'object' || !(_$s instanceof $)) return;
                    var _sCloseItemSel = _$s.data('accordion-close-switch'),
                        _$sCloseItem = !!_sCloseItemSel ? _$s.find(_sCloseItemSel) : null
                        ;

                    if (!!_sCloseItemSel){
                        _$sCloseItem
                            .off('click', setupTypeAccordionaccordionClose)
                            .on('click', {'s':_$s, 'si':_$si, 'umo':_useMultipleOn, '_switchOnClass':_switchOnClass, 'sufs':sufs, 'sufsi':sufsi, '_selectSuffixClass':_selectSuffixClass}, setupTypeAccordionaccordionClose);
                    }
                }

                // Switch에 ON 클래스 추가시
                if (_$sThis.hasClass('dis')) return false; // dis =  CSS 클래스(disabled 효과)로 해당 클래스가 있으면 리턴한다.

                if (!_useMultipleOn){
                   _$s.removeClass(_switchOnClass); // 모든 스위치에 on클래스 제거
                }

                if (_useToggle && !_sCloseItemSel || _useSwitchToggle){
                    if (!_hasOn){
                        _$sThis.addClass(_switchOnClass)
                    } else {
                        _$sThis.removeClass(_switchOnClass)
                    }
                } else {
                    _$sThis.addClass(_switchOnClass); // 이벤트 대상 스위치에만 on클래스 추가
                }

                // Position을 이동시킨다.
                if (_$sThis[0].hasAttribute('data-accordion-move-to-top')){
                    var _belowTargetSelector = _$sThis.data('accordion-move-to-top'),
                        offsetTop = _$sThis.offset().top;
                    if (!!_belowTargetSelector) offsetTop -= $(_belowTargetSelector).outerHeight();
                    $('window, body').scrollTop(offsetTop);
                }

                bindAccordionCloseEvent(_$sThis, _$siThis);
                setTimeout(function(){window.uiModules.swiperUpdate()},100); // Swiper Height 갱신
                /*if(!!lnbScroll){setTimeout(function () {lnbScroll.refresh();},0)} // iScroll Height 갱신*/
            }
            _b.setupTypeAccordion = function(){
                var
                    sufs = '-switch',               // class suffix : Switch Buttons
                    sufsi = '-switch-item'          // class suffix : Switch Buttons
                    ;

                /*
                 * 문자 배열을 jQuery "addClass()" 함수에 사용하기 위해 문자열(문자구분:스페이스)로 변환한다.
                 * ex) 입력 : ['a','b','c'] / 반환 : 'a b c'
                 *
                 * @param arr (array) : 문자 배열
                 *
                 * @return String : 스페이스로 구분되는 스트링 문자열
                 */

                function arrayToCssClassString (arr){
                    var result = '';
                    if (typeof arr !== 'object' || typeof arr['push'] !== 'function') return result;

                    for(var _i in arr) result += ' '+arr[_i];
                    return result;
                }

                $('.'+TYPE_ACCORDION+SUFFIX_CLASS_WRAPPER).each(function(){
                    var _$this = $(this),                                            // 컨테이너
                        _selectSuffixClass = _$this.data('suffix-class') && _$this.data('suffix-class').length > 0 ? '-'+_$this.data('suffix-class') : '', // 하위 엘리먼트에 같은 기능이 들어갈 경우 select 값 변경
                        _$s = _$this.find('.'+TYPE_ACCORDION+sufs+_selectSuffixClass),  // 스위치들 ( Switch On Class가 토글될 엘리먼트 )
                        _$si = _$s.find('.'+TYPE_ACCORDION+sufsi+_selectSuffixClass),   // 스위치들 ( 버튼 역할을 할 실제 아이템 )

                        _useToggle = _$this.data('toggle-on') || false,                 // 토글 기능 ( 기본값 : false, [off>on, on>off] )
                        _useMultipleOn = _$this.data('multiple-on') || false,           // 다중 on ( 기본값 : false)
                        _switchOnClass = _$this.data('on-class')||EL_ACTIVE_CLASS       // 스위치의 ON 클래스 (기본값 : on)
                        ;

                    if(_useMultipleOn) _useToggle = true;

                    /*
                     * 닫기 버튼이 있는 경우 해당 버튼에 아코디언을 닫는 이벤트를 추가
                     */
                    function bindAccordionCloseEvent(_$s, _$si){
                        if (typeof _$s !== 'object' || !(_$s instanceof $)) return;
                        var _sCloseItemSel = _$s.data('accordion-close-switch'),
                            _$sCloseItem = !!_sCloseItemSel ? _$s.find(_sCloseItemSel) : null
                            ;

                        if (!!_sCloseItemSel){
                            _$sCloseItem
                                .off('click', setupTypeAccordionaccordionClose)
                                .on('click', {'s':_$s, 'si':_$si, 'umo':_useMultipleOn, '_switchOnClass':_switchOnClass, 'sufs':sufs, 'sufsi':sufsi, '_selectSuffixClass':_selectSuffixClass}, setupTypeAccordionaccordionClose);
                        }
                    }

                    for (var i=0,j=_$si.length; i<j; i++){
                        bindAccordionCloseEvent(
                            // 아코디언 스위치 아이템에 클릭이벤트 추가
                            _$si.eq(i).off('click', setupTypeAccordionsiOnClick)
                                .on('click',
                                    {
                                        'sufs':sufs, 'sufsi':sufsi,
                                        '_$this':_$this, '_selectSuffixClass':_selectSuffixClass,
                                        '_$s':_$s, '_$si':_$si,
                                        '_useToggle':_useToggle, '_useMultipleOn':_useMultipleOn,
                                        '_switchOnClass':_switchOnClass
                                    },
                                    setupTypeAccordionsiOnClick)
                            // 닫기 버튼이 따로 있는 경우
                            // 이미 on되어 있는 엘리먼트에는 닫기 버튼에 이벤트가 할당이 되지 않아 이를 추가해주기 위해 parent를 조사
                            .parents('.'+TYPE_ACCORDION+sufs+_selectSuffixClass+'.on:eq(0)')
                        );
                    }
                });
            }



            /*
             * 단일 토글버튼 이벤트 추가
             *
             */
            function btnToggleBasicEvent(){
                var _$this = $(this),
                    _onClass = _$this.data('toggle-single-on-class')||EL_ACTIVE_CLASS,
                    _singleOtherOnSelClzString = _$this.data('toggle-single-other-on-sel-clz')||null,
                    _singleOtherOnSelClzArray = !!_singleOtherOnSelClzString ? _singleOtherOnSelClzString.split(':') : null
                    // _onOtherSelector = _$this.data('toggle-single-other-on-selector')||null,
                    // _onOtherClass = _$this.data('toggle-single-other-on-class')||''
                    ;
                if (_$this.hasClass('dis')) return;
                if (_$this.hasClass(_onClass)){
                    _$this.removeClass(_onClass);
                    if (!!_singleOtherOnSelClzArray){
                        for(var i=0,j=_singleOtherOnSelClzArray.length; i<j; i++){
                            var _singleOtherOnSelClzSplit = _singleOtherOnSelClzArray[i].split('/');
                            if (_singleOtherOnSelClzSplit.length == 2) $(_singleOtherOnSelClzSplit[0]).removeClass(_singleOtherOnSelClzSplit[1]);
                        }
                    }
                } else {
                    _$this.addClass(_onClass)
                    if (!!_singleOtherOnSelClzArray){
                        for(var i=0,j=_singleOtherOnSelClzArray.length; i<j; i++){
                            var _singleOtherOnSelClzSplit = _singleOtherOnSelClzArray[i].split('/');
                            if (_singleOtherOnSelClzSplit.length == 2) $(_singleOtherOnSelClzSplit[0]).addClass(_singleOtherOnSelClzSplit[1]);
                        }
                    }
                }
            }
            $('body').off('click', btnToggleBasicEvent).on('click', '.btn-toggle-single', btnToggleBasicEvent);



            /*
             * 체크박스 형태의 엘리먼트 이벤트 추가
             *
             * > 체크박스 적용 방법
             *  1. 체크박스를 감싸는 노드에 'btn-checkbox-wrapper' 클래스 추가
             *  2. 체크박스 엘리먼트에 'btn-checkbox' 클래스 추가
             *    2-1. 'dis' 클래스를 추가 할 경우 해당 체크박스는 선택이 불가능하다.
             *
             * > 토글 옵션 속성
             *  1. (wrapper)data-on-class="값"       : (string:'on') [옵션] 토글 버튼 선택시 해당 클래스 토글 엘리먼트에 부여할 클래스
             *                                  (기본값:on, 대상 클래스:(btn-accordion-switch-item 클래스 부모 노드의 btn-accordion-switch))
             *  3. (wrapper)data-multiple-on="값"    : (boolean:'false') [옵션] 여러 switch 엘리먼트에 'on'클래스를 부여가 가능하다. (여러 아코디언을 확장 가능한 상태로 만듬), false일 경우 wrapper당 최대 1개의 switch만 on 가능.
             *  4. (wrapper)data-suffix-class="값" : [생략가능] 아코디언 안에 아코디언이 들어갈 경우(다중) 이를 구분하기 위해 사용 (기본값:하위의 'btn-accordion-switch'클래스가 있는 모든 엘리먼트가 대상이 됨, 대상 클래스:btn-accordion-wrapper)
             *                              예로) data-suffix-class="aaa"라고 넣었다면 'btn-accordion-switch' 와 'btn-accordion-switch-item' 클래스 뒤에 '-aaa'라고 추가해줘야 인식한다.
             * > 기타 클래스
             *  1. (checkbox)dis : 해당 엘리먼트를 선택하지 못하도록 한다.
             *
             * > 사용 예 1) - 체크박스
             *    <li class="btn-checkbox-wrapper" data-on-class="selected">
             *       <div>
             *           <span class="checkSet on">
             *               <input class="btn-checkbox" type="checkbox" id="c_ab"><label for="c_ab"></label>
             *           </span>
             *       </div>
             *   </li>
             */
             function setupTypeCheckboxcOnClick(e){
                var _$cThis = $(this),
                    _$this = e.data._$this,
                    _switchOnClass = e.data._switchOnClass
                    ;
                if (_$cThis.hasClass('dis')) return false;

                if (_$cThis.is(':checked')){
                    _$this.addClass(_switchOnClass)
                } else {
                    _$this.removeClass(_switchOnClass)
                }
                setTimeout(function(){window.uiModules.swiperUpdate()},100); // Swiper 전체 높이를 update한다.
            }
            /* 체크박스를 리셋시킨다. 해당 체크박스만 리셋된다. (on class remove, checked attrbute remove) */
            function callCheckboxReset(e){
                var _$cThis = $(this),
                    _$this = e.data._$this,
                    _switchOnClass = e.data._switchOnClass
                    ;
                if (_$cThis.hasClass('dis')) return false;

                _$this.removeClass(_switchOnClass);
                _$cThis.prop('checked', false);

                setTimeout(function(){window.uiModules.swiperUpdate()},100); // Swiper 전체 높이를 update한다.
            }
            _b.setupTypeCheckbox = function(){

                /*
                 * 체크가 되어있는 항목을 찾아 클래스를 추가한다.
                 */
                function updateTypeCheckboxLayout(_$cw, _$c, _switchOnClass){
                    if (_$c.is(':checked')){
                        _$cw.addClass(_switchOnClass)
                    } else {
                        _$cw.removeClass(_switchOnClass)
                    }
                }

                $('.'+TYPE_CHECKBOX+SUFFIX_CLASS_WRAPPER).each(function(){
                    var _$this = $(this),                                            // 컨테이너
                        _selectSuffixClass = _$this.data('suffix-class') && _$this.data('suffix-class').length > 0 ? '-'+_$this.data('suffix-class') : '', // 하위 엘리먼트에 같은 기능이 들어갈 경우 select 값 변경
                        _$c = _$this.find('.'+TYPE_CHECKBOX+_selectSuffixClass),        // 체크박스들

                        _switchOnClass = _$this.data('on-class')||EL_ACTIVE_CLASS       // 체크박스의 ON 클래스 (기본값 : on)
                        ;

                    _$c.off('click, change', setupTypeCheckboxcOnClick).on('click, change', {'_$this':_$this, '_switchOnClass':_switchOnClass}, setupTypeCheckboxcOnClick);
                    _$c.off('call-reset', callCheckboxReset).on('call-reset', {'_$this':_$this, '_switchOnClass':_switchOnClass}, callCheckboxReset);

                    updateTypeCheckboxLayout(_$this, _$c, _switchOnClass);
                    setTimeout(function(){window.uiModules.swiperUpdate()},100); // Swiper 전체 높이를 update한다.
                });
            }


            /*
             * 라디오 형태의 엘리먼트 이벤트 추가
             *
             * > 라디오 적용 방법
             *  1. 라디오 전체를 감싸는 노드에 'btn-radio-wrapper' 클래스 추가
             *  2. 라디오 엘리먼트에 'btn-radio' 클래스 추가
             *    2-1. 'dis' 클래스를 추가 할 경우 해당 체크박스는 선택이 불가능하다.
             *
             * > 토글 옵션 속성
             *  1. (wrapper)data-on-class="값"       : (string:'on') [옵션] 토글 버튼 선택시 해당 클래스 토글 엘리먼트에 부여할 클래스
             *                                  (기본값:on, 대상 클래스:(btn-accordion-switch-item 클래스 부모 노드의 btn-accordion-switch))
             *  3. (wrapper)data-onoff-selectors="값"    : (string:'') [옵션] wrapper안에 on/off 클래스를 추가해줘야 하는 엘리먼트가 있을 경우 wrapper를 기준으로 하는 selector(jQuery)를 입력한다. 이벤트 대상은 on, 나머지 라디오는 off 클래스가 등록된다. 각 아이템은 라디오 한개씩 1:1맵핑이 되어야 한다.
             *  4. (wrapper)data-selectors-on-class="값" : (string:'on') [옵션] 라디오 선택시 data-onoff-selectors(index)에 on될 클래스
             *  5. (wrapper)data-selectors-off-class="값" : (string:'') [옵션] 라디오 선택시 data-onoff-selectors(not index)에 on될 클래스
             * > 기타 클래스
             *  1. (checkbox)dis : 해당 엘리먼트를 선택하지 못하도록 한다.
             *
             * > 사용 예 1) - 라디오 (on/off 클래스가 추가될 엘리먼트로 wrapper 바로 하위의 li를 선택['data-onoff-selectors="> li"']. 라디오를 클릭하면 해당 라디오의 상위 li에 'on'클래스, 나머지 li에 'off'클래스가 추가됨)
             *    <ul class="btn-radio-wrapper" data-on-class="selected" data-onoff-selectors="> li" data-selectors-on-class="on" data-selectors-off-class="off">
             *       <li>
             *           <div>
             *               <input class="btn-radio" type="radio" id="r_a"><label for="r_a"></label>
             *           </div>
             *       </li>
             *       <li>
             *           <div>
             *               <input class="btn-radio" type="radio" id="r_b"><label for="r_b"></label>
             *           </div>
             *       </li>
             *   </ul>
             */
             function setupTypeRadiorOnClick(e){
                var _$rThis = $(this),
                    _$this = e.data._$this,
                    _onClass = e.data._onClass,
                    _$r = e.data._$r,
                    _$onSelectors = e.data._$onSelectors,
                    _selectorsOnClass = e.data._selectorsOnClass,
                    _selectorsOffClass = e.data._selectorsOffClass
                    ;
                if (_$rThis.hasClass('dis')) return false;

                if (_$rThis.is(':checked')){
                    _$r.removeClass(_onClass);
                    _$this.add(_$rThis).addClass(_onClass);
                } else {
                    _$r.removeClass(_onClass);
                    _$this.removeClass(_onClass);
                }

                if (!!_$onSelectors && _$onSelectors.length > 0){
                    // 전체 on 클래스 제거
                    // 전체 off 클래스 추가
                    // 해당 index on클래스 추가, off클래스 제거
                    _$onSelectors.removeClass(_selectorsOnClass).addClass(_selectorsOffClass)
                        .eq(_$r.index(_$rThis)).removeClass(_selectorsOffClass).addClass(_selectorsOnClass);
                }
                setTimeout(function(){window.uiModules.swiperUpdate()},100); // Swiper 전체 높이를 update한다.
            }
            /* 라디오를 리셋시킨다. 라디오는 체크박스 리셋과 다르게 셀렉터를 하나만 지정했더라도 연관된 모든 라디오를 리셋한다. (on class remove, checked attrbute remove) */
            function callRadioReset(e){
                var _$rThis = $(this),
                    _$this = e.data._$this,
                    _onClass = e.data._onClass,
                    _$r = e.data._$r,
                    _$onSelectors = e.data._$onSelectors,
                    _selectorsOnClass = e.data._selectorsOnClass,
                    _selectorsOffClass = e.data._selectorsOffClass
                    ;
                if (_$rThis.hasClass('dis')) return false;

                _$r.removeClass(_onClass);
                _$r.prop('checked',false);

                if (!!_$onSelectors && _$onSelectors.length > 0){
                    _$onSelectors.removeClass(_selectorsOnClass).removeClass(_selectorsOffClass);
                }
                setTimeout(function(){window.uiModules.swiperUpdate()},100); // Swiper 전체 높이를 update한다.
            }
            _b.setupTypeRadio = function(){
                /*
                 * 체크가 되어있는 항목을 찾아 클래스를 추가한다.
                 */
                function updateTypeRadioLayout(_$rw, _$r, _onClass){
                    if (_$r.is(':checked')){
                        _$rw.addClass(_onClass)
                    } else {
                        _$rw.removeClass(_onClass)
                    }
                }

                $('.'+TYPE_RADIO+SUFFIX_CLASS_WRAPPER).each(function(){
                    var _$this = $(this),                                            // 컨테이너
                        _selectSuffixClass = _$this.data('suffix-class') && _$this.data('suffix-class').length > 0 ? '-'+_$this.data('suffix-class') : '', // 하위 엘리먼트에 같은 기능이 들어갈 경우 select 값 변경
                        _$r = _$this.find('.'+TYPE_RADIO+_selectSuffixClass),        // 라디오들

                        _onClass = _$this.data('on-class')||EL_ACTIVE_CLASS,       // 체크박스의 ON 클래스 (기본값 : on)
                        _onSelectors = _$this.data('onoff-selectors'),
                        _selectorsOnClass = _$this.data('selectors-on-class')||EL_ACTIVE_CLASS,
                        _selectorsOffClass = _$this.data('selectors-off-class')||'',
                        _$onSelectors = !!_onSelectors ? _$this.find(_onSelectors) : undefined
                        ;
                    _$r.off('click, change', setupTypeRadiorOnClick)
                        .on('click, change',
                            {
                                '_$this':_$this,
                                '_$r':_$r,
                                '_$onSelectors':_$onSelectors,
                                '_onClass':_onClass,
                                '_selectorsOnClass':_selectorsOnClass,
                                '_selectorsOffClass':_selectorsOffClass
                            }, setupTypeRadiorOnClick);

                    _$r.off('call-reset', callRadioReset)
                        .on('call-reset',
                            {
                                '_$this':_$this,
                                '_$r':_$r,
                                '_$onSelectors':_$onSelectors,
                                '_onClass':_onClass,
                                '_selectorsOnClass':_selectorsOnClass,
                                '_selectorsOffClass':_selectorsOffClass
                            }, callRadioReset);

                    updateTypeRadioLayout(_$this, _$r, _onClass);
                    setTimeout(function(){window.uiModules.swiperUpdate()},100); // Swiper 전체 높이를 update한다.
                });
            }


            /*
             * Popup
             * --------------------------------------------
             *
             * #### 사용 방법 ####
             *
             *  1. 호출할 팝업(공통)
             *    a.팝업의 최상위 element에 'p-container' 클래스를 추가해줍니다.
             *      ex) <div class="popupsmallWrap btn-toggle-wrapper changeDisPopup p-container">
             *
             *    b.팝업을 닫는 기능이 있는 element에 'p-close' 클래스를 추가해줍니다.
             *      * 주의 : 팝업을 닫는 element는 항상 팝업의 자식노드여야만 합니다.
             *      ex) <a class="btnClose p-close">닫기</a>
             *
             *  2. 호출 버튼(공통)
             *    a.옵션에 display를 "false"로 입력하면 버튼을 클릭해도 팝업이 열리지 않습니다.
             *      ex) <button class="right btnBlack btn-popup-default" data-pop-opts='{"target": ".changeDisPopup","display":"false"}'>할인혜택변경</button>
             *
             *  3. 일반 팝업 호출버튼
             *    - 일반팝업은 모달창으로 덮인 화면 가운데에 뜨는 팝업입니다.
             *
             *      a.호출 element에 'btn-popup-default' 클래스를 추가해줍니다
             *      b.호출 element에 'data-pop-opts' 속성을 추가하고 'target'에 호출할 팝업의 선택자를 입력합니다.
             *        ex) <button class="right btnBlack btn-popup-default" data-pop-opts='{"target": ".changeDisPopup"}'>할인혜택변경</button>
             *
             *
             *  4. 풀(full) 팝업 호출버튼
             *    - 풀 팝업은 화면 전체를 차지하는 팝업입니다.
             *
             *      a.호출 element에 'btn-popup-full' 클래스를 추가해줍니다
             *      b.호출 element에 'data-pop-opts' 속성을 추가하고 'target'에 호출할 팝업의 선택자를 입력합니다.
             *        ex) <a class="white btn-popup-full" data-pop-opts='{"target": "#popupSample"}'>사은품선택</a>
             *
             */
            _b.oPopup = {};
//            var _$this = {};
            _b.oPopup.P_BUTTON_PREFIX     = "btn-popup-";
            _b.oPopup.POP_ID_PREFIX		= "__pop_up_";
            _b.oPopup.sufd                = "default";
            _b.oPopup.sufp                = "popover";
            _b.oPopup.suff                = "full";
            _b.oPopup.aniDuration 		   = 300;

            _b.oPopup.isIOS				= navigator.userAgent.match(/(iPod|iPhone|iPad)/);''

            _b.oPopup.wH                  = $(window).height();

            _b.oPopup.$b					= $('body');
            _b.oPopup.$btns                = $("."+_b.oPopup.P_BUTTON_PREFIX+"default" +"," +"."+_b.oPopup.P_BUTTON_PREFIX+"full");
            _b.oPopup.$modal				= $(".popupDim");
            _b.oPopup.$wrapBack			= $("#wrap_back");
            _b.oPopup.$wrap				= $("#wrap");

            _b.oPopup.bLoad = false;

            function onPopupOpenEvent(e){
                var _$oPopup = e.data._$oPopup,
                	_$this = e.data._$this;

                _$this.bLoad= true;

                // 이전 팝업이 있을 경우 z-index를 1씩 증가시킵니다.
            	var z_ = parseInt(_$oPopup.$this.css("z-index")),
        			pCnt = $('.popupWrap:visible').length;
            	_$oPopup.$this.css("z-index", z_ + (1 * pCnt));

                // 팝업을 띄울때 body scroll position을 저장해둔다. > 팝업 닫을 때에 해당 scroll위치로 복귀 시킨다.
            	_$oPopup.savePoint = _$this.$b.scrollTop();

            	// 기본 팝업일 경우 -> 기본 팝업 오픈
                if(_$oPopup.type == _$this.sufd) _$this.defaultPop(_$oPopup);

                // 팝오버 팝업일 경우 -> 팝오버 팝업 오픈
                else if(_$oPopup.type == _$this.sufp) _$this.popoverPop(_$oPopup);

            	// 풀 팝업일 경우 -> 풀 팝업 오픈
            	else if(_$oPopup.type == _$this.suff) _$this.fullPop(_$oPopup);

                _$oPopup.onOpenHandle();
            }

            function onPopupCloseEvent(e){
            	var _$this = e.data._$this;
            	var _$oPopup = e.data._$oPopup;
        		if(_$this.bLoad) return false; 		//팝업 닫을때 시점 일치하기 위해

        		_$oPopup.onCloseHandle();

        		// 1) 기본 팝업일 경우
        		if(_$oPopup.$this.hasClass("popupsmallWrap")) {
//        			$b.css({"overflow":"auto", "height":"auto"});
        			if($('.popupsmallWrap:visible').length - 1 == 0){
            			_$this.$b.css({"overflow":"auto", "height":"100%"});
            			ItDevice.lockScroll(false);

            			_$oPopup.$this.add(_$this.$modal).hide();

            			_$this.returnToScroll();
            			_$this.clear();
        			}else{
        				_$oPopup.$this.hide();
        			}
        		}

        		// 2) 풀팝업일 경우
        		else {
        			_$oPopup.$this.css("z-index", 1000);

                    // 이전 스크롤 높이로 돌아가기 위해, 이전 페이지의 scrollTop위치로 popup을 이동시킵니다.
	                var scrollHeight = _$this.$b.scrollTop() + _$this.$b.height();

	                _$oPopup.$this.css('top',_$oPopup.savePoint)
	                .find('.popupContents').css({'position':'absolute'});

	                // 이전 화면이 팝업이 아닐 경우, wrap 보이기
	                if($('.popupWrap:visible').length - 1 == 0) _$this.$wrap.show();
	                // 이전 팝업이 기본 팝업일 경우, wrap 보이기
	                else if($('.popupWrap:visible').length - 1 != 0 && _$this.$modal.is(":visible")) _$this.$wrap.show();


	                // 이전 화면 스크롤 위치 복귀
	                _$this.returnToScroll(_$oPopup.savePoint);

					// 팝업 헤더 애니메이션
	                _$oPopup.$pHeader
	                    .css({"top": "0%"})
	                    .animate({'top':"100%"}, _$this.aniDuration);

	                // 팝업 컨텐츠 애니메이션
	                _$oPopup.$pContents
	                .css({"top": "0%"})
	                    .animate({'top':'100%'}, _$this.aniDuration, function(){
	                    	// 팝업 하단 버튼 사라짐
	                    	if(_$oPopup.$pBottom.size() != 0)_$oPopup.$pBottom.fadeOut(_$this.aniDuration/2, function(){_$oPopup.$this.hide();});
	                    	else _$oPopup.$this.hide();
                    });

                    if (_$oPopup.$pContents.length === 0){ // 팝업 컨텐츠가 없다면
                        if (_$oPopup.$pHeader.length === 0){
                            // 팝업 하단 버튼 사라짐
                            if(_$oPopup.$pBottom.size() != 0)_$oPopup.$pBottom.fadeOut(_$this.aniDuration/2, function(){_$oPopup.$this.hide();});
                            else _$oPopup.$this.hide();
                        } else {
                            setTimeout(function(){
                                // 팝업 하단 버튼 사라짐
                                if(_$oPopup.$pBottom.size() != 0)_$oPopup.$pBottom.fadeOut(_$this.aniDuration/2, function(){_$oPopup.$this.hide();});
                                else _$oPopup.$this.hide();
                            },_$this.aniDuration);
                        }
                    }

                    _$this.clear();
        		}
        	}
            
            function oPopupSetting(_$oPopup){
            	_$oPopup.$this.data('oPopup', _$oPopup);

            	// 팝업 열고, 닫기 메서드
            	_$oPopup.open = function(){
            		onPopupOpenEvent({'data': {'_$this':_b.oPopup, '_$oPopup':this} });
            		return this;
            	};
            	_$oPopup.close = function(){
            		onPopupCloseEvent({'data': {'_$this':_b.oPopup, '_$oPopup':this} });
            		return this;
            	};

            	// 팝업 핸들러 이벤트
            	_$oPopup.onOpenHandle = function(){};
            	_$oPopup.onCloseHandle = function(){};
            	_$oPopup.onCompleteHandle = function(){};
            	_$oPopup.init = function(){};
            	_$oPopup.complete = function(param){this.onCompleteHandle(param);};

            	/* 팝업의 'X'(닫기) 버튼 클릭시 */
                _$oPopup.$this.find('.p-close')
                	.off('click', onPopupCloseEvent)
                	.on('click',{
                		'_$this':_b.oPopup,
                 	   '_$oPopup':_$oPopup
                    }, onPopupCloseEvent);
            }

            _b.isOpenPopup = function(){
            	return $('.popupWrap:visible').length > 0;
            };

            // popup type : default, popover, full
            _b.initPopup = function(target, type){
            	var _$oPopup = {};
            	if((typeof target == 'string' || (typeof target == 'object' && target.length > 0)) && (type == 'default' || type == 'popover' || type == 'full')){
            		_$oPopup.$this 			= typeof target == 'object'? target : _b.oPopup.$b.find(target);	// body에서 팝업버튼 타겟에 등록된 클래스로 팝업 컨테이너를 가져온다.
                	_$oPopup.$pHeader 		= _$oPopup.$this.find(".popupHeader");
                	_$oPopup.$pContents 	= _$oPopup.$this.find(".popupContents");
                	_$oPopup.$pBottom 		= _$oPopup.$this.find(".popupBottom");
                	_$oPopup.savePoint 		= 0;
                	_$oPopup.type			= type;
                	if(typeof _$oPopup.$this.data('oPopup') != 'undefined')return _$oPopup.$this.data('oPopup');
                	oPopupSetting(_$oPopup);
            	}else{
            		console.error('init popup prameter error [target] - ',target);
            		console.error('init popup prameter error [type] - ',type);
            	}

            	return _$oPopup;
            };

            _b.getPopup = function(target){
            	return _b.oPopup.$b.find(target).data('oPopup');
            };

            _b.closePopup = function(){
            	function popSort(a,b){return ((parseInt(b.style.zIndex,10) - parseInt(a.style.zIndex,10)))}
            	var _$oPopup = _b.oPopup.$b.find('.popupWrap:visible').sort(popSort).eq(0).data('oPopup'); // 오픈되어있는 최상이 팝업객체를 가져온다.
            	if(_$oPopup){
            		onPopupCloseEvent({'data': {'_$this':_b.oPopup, '_$oPopup':_$oPopup} });
            	}
            };

            _b.setupTypePopup = function(target){

                $("."+_b.oPopup.P_BUTTON_PREFIX+_b.oPopup.sufd+", ."+_b.oPopup.P_BUTTON_PREFIX+_b.oPopup.suff+", ."+_b.oPopup.P_BUTTON_PREFIX+_b.oPopup.sufp).each(function(){
                	var _$b = $(this);	// 팝업오픈 버튼
                	var _$oPopup = {};
                	_$oPopup.$this 			= _b.oPopup.$b.find(_$b.data('popOpts').target);	// body에서 팝업버튼 타겟에 등록된 클래스로 팝업 컨테이너를 가져온다.
                	_$oPopup.$pHeader 		= _$oPopup.$this.find(".popupHeader");
                	_$oPopup.$pContents 	= _$oPopup.$this.find(".popupContents");
                	_$oPopup.$pBottom 		= _$oPopup.$this.find(".popupBottom");
                	_$oPopup.savePoint 		= 0;
                	if(_$b.hasClass(_b.oPopup.P_BUTTON_PREFIX+_b.oPopup.sufd)){
                		_$oPopup.type = _b.oPopup.sufd;
                	}else if(_$b.hasClass(_b.oPopup.P_BUTTON_PREFIX+_b.oPopup.suff)){
                		_$oPopup.type = _b.oPopup.suff;
                	}else if(_$b.hasClass(_b.oPopup.P_BUTTON_PREFIX+_b.oPopup.sufp)){
                		_$oPopup.type = _b.oPopup.sufp;
                	}

                	if(_$oPopup.$this.length != 0){
                		if(typeof _$oPopup.$this.data('oPopup') != 'undefined'){
                			if(target && target.length > 0 && !_$oPopup.$this.hasClass(target.prop('class')))return;
                    		/* 팝업 열기 버튼 클릭 이벤트*/
                            _$b.off('click', onPopupOpenEvent)
                               .on('click',{
                            	   '_$this':_b.oPopup,
                            	   '_$oPopup':_$oPopup.$this.data('oPopup')
                               }, onPopupOpenEvent);
                    	}else{
                    		oPopupSetting(_$oPopup);
                        	/* 팝업 열기 버튼 클릭 이벤트*/
                            _$b.off('click', onPopupOpenEvent)
                               .on('click',{
                            	   '_$this':_b.oPopup,
                            	   '_$oPopup':_$oPopup
                               }, onPopupOpenEvent);
                    	}
                	}
                });

                /* 기본팝업 오픈 */
                _b.oPopup.defaultPop = function($oPopup) {
                    this.$b.css({"overflow":"hidden", "height":"100%"});
//                    ItDevice.lockScroll(true);	// 모바일 화면 : 모달레이어 뒤의 화면은 위 css로 스크롤을 막습니다.

                    // 모달 팝업 인덱스 조정
                    this.$modal.css("z-index",$oPopup.$this.css("z-index") - 1);

                    // 기본팝업 높이 조정
                    var scrollHeight = this.$b.scrollTop() + (this.$b.height() - $oPopup.$this.height()) / 2;
                    $oPopup.$this.css({
                        top:scrollHeight
                        , position:"absolute"
                        , "margin-top":0
                    }).add(this.$modal).show();

                    this.clear();
                };

                /* 팝오버 팝업 오픈 */
                _b.oPopup.popoverPop = function($oPopup) {
                    this.$b.css({"overflow":"hidden", "height":"100%"});
//                    ItDevice.lockScroll(true);	// 모바일 화면 : 모달레이어 뒤의 화면은 위 css로 스크롤을 막습니다.

                    // 모달 팝업 인덱스 조정
                    this.$modal.css("z-index",$oPopup.$this.css("z-index") - 1);
                    $oPopup.$this.add(this.$modal).show();

                    this.clear();
                };

	            /*
	             * 풀팝업 오픈
	             */
	            _b.oPopup.fullPop = function($oPopup) {
	                // wrap이 잠기기 전에 현재 scrollTop을 저장
	                var scrollHeight = this.$b.scrollTop() + this.$b.height();

	                // 팝업 애니메이션 시작 모션 세팅
	                $oPopup.$this.css('top',"0%").show()
	                .find('.popupContents').css({'position':'absolute', 'top':scrollHeight});

	                $oPopup.$pBottom.hide();

	                // 팝업 헤더 애니메이션
	                $oPopup.$pHeader
	                    .css({"top": scrollHeight, "position":"relative"})
	                    .animate({'top':scrollHeight - $oPopup.$this.height()}, this.aniDuration, function(){
	                        $(this).css({"top":"0px","position":"fixed"});
	                    });

	                // 팝업 컨텐츠 height 설정
                	var hH = !! $oPopup.$pHeader? $oPopup.$pHeader.outerHeight():0,
                        bH = !! $oPopup.$pBottom? $oPopup.$pBottom.outerHeight():0,
					    popupContentHeight = this.wH-(hH+bH);

                    $oPopup.$pContents.css({
						'height'			: popupContentHeight ,
						'padding-top'		: hH ,
						'padding-bottom'	: bH
					});

	                // 팝업 컨텐츠 애니메이션
                    $oPopup.$pContents
	                    .animate({'top':scrollHeight - $oPopup.$this.height(), scrollTop:0}, this.aniDuration, function(){
	                    	// 팝업 하단 버튼 등장
	                    	try {$oPopup.$pBottom.fadeIn(_b.oPopup.aniDuration/2);} catch(e){}

	                    	_b.oPopup.$wrap.hide();
	                    	$oPopup.$pContents.css({top:"0%"});
	                    	_b.oPopup.clear();
	                    });
	            };


	        	/////////////////////////////////////////////////////////////////
	        	//    HELPER FUNCTIONS
                /////////////////////////////////////////////////////////////////

	        	/* 이전 화면 스크롤 위치 */
	        	_b.oPopup.scrollTopBefore = function(){
	        		return this.savePoints[this.savePoints.length-1];
	        	}

	        	/* 이전 화면 스크롤 위치로 복귀 */
	        	_b.oPopup.returnToScroll = function(savePoint){
	                // 이전 화면의 스크롤위치로 복귀
	        		var _bodyLastScrollYPos = savePoint;

                    if (!!_bodyLastScrollYPos){
                    	this.$b.scrollTop(_bodyLastScrollYPos);
                    }
	        	}

	        	/* 변수에 담겨있던 popup 초기화*/
	        	_b.oPopup.clear = function() {
//	                this.$popup=null;
//	                this.$pHeader=null;
//	                this.$pContents=null;
//	                this.$pBottom=null;

	                this.bLoad = false;
	        	}

            } // popup end

            /*
			 * Star Rating (v1.0.22)
			 * -------------------------------------------- Site :
			 * https://rateit.codeplex.com/ License : MIT
			 * (ttps://rateit.codeplex.com/license) Download :
			 * https://rateit.codeplex.com/releases/ Document :
			 * https://rateit.codeplex.com/documentation Demo :
			 * http://www.radioactivethinking.com/rateit/example/example.htm
			 */
            _b.setupTypeRating = function(){
                try{$('div.rating, span.rating').rateit();}catch(e){}
                /*
                 * > Check Function
                 * ------------------------------------------------------
                 * 값 얻기 : $('#rateit').rateit('value');
                 * 값 설정 : $('#rateit').rateit('value', 3);
                 * 읽기전용 확인 : $('#rateit').rateit('readonly');
                 * 읽기전용 설정 : $('#rateit').rateit('readonly', true);
                 * ======================================================
                 *
                 * > Options
                 * ------------------------------------------------------
                 * rtl : style="direction: rtl;"
                 * ------------------------------------------------------
                 * 선택취소버튼 사용안함 : <div data-rateit-resetable="false" />
                 * ======================================================
                 *
                 * > CallBacks
                 * ------------------------------------------------------
                 * rated-선택 후 : $("#rateit5").bind('rated', function (event, value) { $('#value5').text('You\'ve rated it: ' + value); });
                 * reset-리셋 후 : $("#rateit5").bind('reset', function () { $('#value5').text('Rating reset'); });
                 * over-마우스 오버 : $("#rateit5").bind('over', function (event, value) { $('#hover5').text('Hovering over: ' + value); });
                 * beforerated-선택 전 : $('#rateit13').on('beforerated', function (e, value) {if (!confirm(value + ' stars?')) {e.preventDefault();//적용취소}});
                 * beforereset-리셋 전 : $('#rateit13').on('beforereset', function (e) {if (!confirm('reset the rating?')) {e.preventDefault();//리셋취소}});
                 * ======================================================
                 */
            }

            _b.setupAll = function(){
                _b.setupTypeCount();
                _b.setupTypeToggleAndTab();
                _b.setupTypeAccordion();
                _b.setupTypeCheckbox();
                _b.setupTypeRadio();
                _b.setupTypePopup();
                _b.setupTypeRating();
            }

            // removeAll = function(){};
            // updateAll = function(){};

            return _b;
        }



        // 초기화 구문
        function init(){
            // console.log('itc init()');
        }

        init();

        return itc;
    }

    /* -------------------------------------------------------------
        Private Function [S]
    ------------------------------------------------------------- */

    // Codes...

    /* -------------------------------------------------------------
        Private Function [E]
	------------------------------------------------------------- */
// jy-seo
//    window.ITCommons = ITCommons;

    // ---------------------- jQuery - Document Ready [S] ---------------------- //
//    $(document).ready(function(){
        var
            $fixNavTopEls = $('.fix-nav-top'),
            // Elements
            $bodyEl = $('body'),                         // Element - Body
            $navSwiperEl = $bodyEl.find('div.shopNav'),     // Element - Top Navigation
            $navSwiperWrapperEl = $bodyEl.find('section.shop-nav-adaptor > div.swiper-wrapper'), // Element - Top Navigation - Swiper Wrapper

            // Debug
            debug = false,                                  // 디버깅 on/off
            $d = $bodyEl.find('#debug'),                    // 스크롤 이벤트 디버깅

            lastBodyY = undefined,                          // 바디의 마지막 스크롤 Y값
            //updateNavPositionTimer = undefined,             // 스크롤시 GND Top에 붙이는 Interval
            swipeIndex = undefined,

            // Swiper
            iTCommons = new ITCommons()
            ;

        // @title [네비게이션 상단 고정 스크립트]
        // @description
        //  메인에서 스크롤시 상단의 GNB를 고정시킨다.
        //  고정은 body의 Top값이 일정 수치보다 클 경우를 체크하여 클래스(style에 "position:fixed")를 토글시키는것으로 구현되었다.
        //  "window 스크롤 이벤트"에서 스크롤 이벤트 발생시 Interval로 이 함수가 반복 호출된다.
        //  body의 offset(Top위치)을 반복적으로 체크하며, 체크하는 값이 같을때 스크롤이 멈춘것으로 판단하여 Interval을 해제시킨다.
        // @history
        //  2016.2.21. | ks-choi | shop main의 상단 네비 사라짐. 스크롤시 끊기는 느낌이 있어 주석처리.
        //  2016.4.18. | ks-choi | 기획 변경으로 인한 복원.
        function updateNavPosition(){
            var _fixedNavTopClass = 'fixed-nav-top';
            if (lastBodyY != $bodyEl.scrollTop()){ // 스크롤 위치가 이전 값과 다르다면(스크롤중이라면) 현재 값 저장
                lastBodyY = $bodyEl.scrollTop();
            } /*else {
                clearTimeout(updateNavPositionTimer);
                updateNavPositionTimer = undefined;
            }*/

            // 메인 GNB 상단 고정 스크립트
            /*if ($navSwiperEl && typeof $navSwiperEl === 'object' && $navSwiperEl.length > 0 &&
                $navSwiperWrapperEl && typeof $navSwiperWrapperEl === 'object' && $navSwiperWrapperEl.length > 0){
                if (lastBodyY >= $navSwiperWrapperEl.offset().top - $navSwiperEl.height()){
                    $navSwiperEl.add($navSwiperWrapperEl).addClass(_fixedNavTopClass);
                }

                if(lastBodyY < $navSwiperWrapperEl.offset().top) {
                    $navSwiperEl.add($navSwiperWrapperEl).removeClass(_fixedNavTopClass);
                }
            }*/

            /* // TODO: scroll up - fixed header
            $fixNavTopEls.each(function(){
                var $fixNavTopEl = $(this),
                    _minYPos = $fixNavTopEl.data('min-y-pos');
                if (!_minYPos) return;
                _minYPos
                if (lastBodyY > $navSwiperWrapperEl.offset().top){
                    $fixNavTopEls.addClass(_fixedNavTopClass);
                } else {
                    $fixNavTopEls.removeClass(_fixedNavTopClass);
                }
            })
            */
        }

        /*
         * 이벤트를 발생시킨다.
         * "$.on('이벤트명', function(event){});"로 받을 수 있다.
         *
         *
         * @param isPrivate (boolean) : 내부 동작에서만 사용할 이벤트일 경우 'TRIGGER_SHOP_EVENT_PRIVATE' 변수값을 사용 하고
         *          아닐 경우 'TRIGGER_SHOP_EVENT_PUBLIC' 변수값을 사용한다.
         * @param args (Array) : 이벤트 발생시 넘겨줄 파라미터 변수 배열이다.
         *          배열 첫번째 값을 이벤트 type을 넘긴다.
         *          각 타입은 'TRIGGER_SHOP_EVENT_TYPE_*' 형태의 변수값에 정의되어있으며, 이를 사용한다.
         *
         * @return boolean : 이벤트 발생 성공/실패 여부
         */
        function triggerEvent( /* isPrivate[Boolean], Event Arguements[Array] */ ){
            var _isPrivate = false,
                _args = undefined,
                _triggerString = TRIGGER_SHOP_EVENT_PUBLIC;

            if (!arguments || arguments.length == 0 || (typeof arguments[0] !== 'boolean' && typeof arguments[0] !== 'object')) {
                console.error('triggerEvent :', 'Invalid Param');
                return false;
            } else {
                for (var _i=0, _j=arguments.length; _i<_j; _i++){
                    if (typeof arguments[_i] === 'boolean'){
                        _isPrivate = arguments[_i];
                    } else if (typeof arguments[_i] === 'object' && typeof arguments[_i]['push'] === 'function'){
                        _args = arguments[_i];
                    }
                }
            }

            if (typeof _isPrivate === 'boolean' && _isPrivate){
                _triggerString = TRIGGER_SHOP_EVENT_PRIVATE;
            }
            if (_args === undefined)_args = [];

            $.event.trigger(_triggerString, _args);

            return true;
        }

        var
            // Swipers
            sw_nav = iTCommons.swiper(              // Shop > GNB (Hone, Event, LuckyBack...)
                    $navSwiperEl,
                    {
                        freeMode: true,
                        useMyWidth: true,
                        centeredSlides: true,
                        fitSlides: true
                    }
                ),
            sw_nav_pages = iTCommons.swiper(        // Shop > Pages (Hone, Event, LuckyBack...)
                    $bodyEl.find('.shop-nav-adaptor'),
                    {
                        autoHeight: true,
                        noBounce: true,
                        // loop: true, // 기획 변경으로 주석처리 ks-choi 2016.2.11.
                        onSlideChangeStart : function(_swiper) {
                            window.$bodyEl = $bodyEl;
                            window.swipertest = $navSwiperWrapperEl;
                            triggerEvent(true, [TRIGGER_SHOP_EVENT_TYPE_NAV_CHANGE, _swiper.activeIndex]);
                            if ($bodyEl.scrollTop() >= ($navSwiperWrapperEl.offset().top + $navSwiperEl.outerHeight())){
                                $bodyEl.animate({
                                    scrollTop: 0// $navSwiperWrapperEl.offset().top
                                }, 0);
                            } else {
                                updateNavPosition();
                            }
                        }
                    }
                ),
            sw_main_event = [], // Shop > Home > 최상단 이벤트 슬라이더
            sw_type_page = [], // 전체 페이지 공통 슬라이더 : 타입 1 - 페이지 단위 Swipe
            sw_type_default = [], // 전체 페이지 공통 슬라이더 : 타입 2 - 디자인된 영역을 가져가는 Swipe
            sw_type_cover = [], // 전체 페이지 공통 슬라이더 : 타입 1 - 페이지 단위 Swipe
            sw_type_cover_zz = [] // 2 page Cover 단독 Script
            ;

        // Dynamic
        function bindSwiperMainEvent(){
            // sw_main_event = []; // Reset
            $bodyEl.find('.mainEvent').each(function(){
                var _exists = false,
                    _$this = $(this);
                for (var i in sw_main_event){
                    if (_$this.is(sw_main_event[i].el)){
                        _exists = true;
                        break;
                    }
                }
                if (!_exists){
                    sw_main_event.push({
                        el: _$this,
                        swiper: iTCommons.swiper(
                                _$this,
                                {
                                    autoHeight: "true",
                                    pagination: '.swiper-pagination', // <div class="swiper-pagination"></div>
                                    paginationClickable: true,
                                    paginationBulletRender: function (index, className) {
                                        return '<span class="' + className + '">' + (index + 1) + '</span>';
                                    }
                                }
                            )
                    });
                }
            });
        }
        bindSwiperMainEvent();
        // Tab동적 컨텐츠에 Swiper가 있을 경우

        function bindSwiperTypePage(){
            // sw_type_page = []; // Reset
            $bodyEl.find('.swiperTypePage').each(function(){
                var _exists = false,
                    _$this = $(this),
                    _nextSelector = _$this.data('next-selector'),
                    _prevSelector = _$this.data('prev-selector');
                for (var i in sw_type_page){
                    if (_$this.is(sw_type_page[i].el)){
                        _exists = true;
                        break;
                    }
                }
                if (!_exists){
                    sw_type_page.push({
                        el: _$this,
                        swiper: iTCommons.swiper(
                            _$this,
                            {
                                paginationClickable: true,
                                pagination: '.swiper-pagination', // <div class="swiper-pagination"></div>
                                nextButton: !!_nextSelector?_nextSelector:'.swiper-button-next', // <div class="swiper-button-next"></div>
                                prevButton: !!_prevSelector?_prevSelector:'.swiper-button-prev' // <div class="swiper-button-prev"></div>
                            }
                        )
                    });
                }
            });
        }
        bindSwiperTypePage();

        function bindSwiperTypePagezz(){
            // sw_type_page = []; // Reset
            $bodyEl.find('.swiperTypeNumber').each(function(){
                var _exists = false,
                    _$this = $(this);
                for (var i in sw_type_page){
                    if (_$this.is(sw_type_page[i].el)){
                        _exists = true;
                        break;
                    }
                }
                if (!_exists){
                    sw_type_page.push({
                        el: _$this,
                        swiper: iTCommons.swiper(
                            _$this,
                            {
                                slidesPerView: 'auto',
                                paginationClickable: true,
							    noBounce: true,
                                pagination: '.swiper-pagination', // <div class="swiper-pagination"></div>
                                nextButton: '.swiper-button-next', // <div class="swiper-button-next"></div>
                                prevButton: '.swiper-button-prev', // <div class="swiper-button-prev"></div>,
								paginationType: 'fraction'
                            }
                        )
                    });
                }
            });
        }
        bindSwiperTypePagezz();

        function bindSwiperTypeDefault(){
            // sw_type_default = []; // Reset
            $bodyEl.find('.swiperTypeDefault').each(function(){
                var _exists = false,
                    _$this = $(this);

                for (var i in sw_type_default){
                    if (_$this.is(sw_type_default[i].el)){
                        _exists = true;
                        break;
                    }
                }

                if (!_exists){
                    var
                        _$thisSliderTemp = !!_$this.data('swiper-slider-selector')?$bodyEl.find(_$this.data('swiper-slider-selector')):[],
                        _$thisSlider = _$thisSliderTemp.length>0?_$thisSliderTemp.slider({
                        // *Slider가 붙을 경우 일정한 페이징(index번호)을 위해 "swiper-slide"에 width값이 %로 설정되어야 한다.
                                min: 0,
                                max: 0,
                                step: 1,
                                slide: function( event, ui ) { // Slide Change
                                    if (!!_defaultSlider)_defaultSlider.slideTo(ui.value);
                                }
                            }):null,
                        // Swiper Navigator Selector String
                        _thisSliderNavSel = !!_$this.data('swiper-nav-selector')?_$this.data('swiper-nav-selector'):null,
                        _nextSelector = _$this.data('next-selector'),
                        _prevSelector = _$this.data('prev-selector');

                    if (_thisSliderNavSel){ // Add Action : Swiper Navigator onClick
                        $bodyEl.on('click', _thisSliderNavSel, function(e){
                            var _swiperMoveTo = parseInt($(this).attr('data-swiper-move-to'));
                            if( !isNaN(_swiperMoveTo) ) _defaultSlider.slideTo(_swiperMoveTo);
                        });
                    }

                    $bodyEl.on('swiper-slider-update', function(){ // uiModules.runAllFun()에서 이벤트 발생시킴
                        if (!!_$thisSlider) { // Swiper가 변경됐을때 slider가 있을 경우 max값을 설정해준다.
                            _$thisSlider.slider('option', 'max', _defaultSlider.slides.length-1);
                            _$thisSlider.find('.ui-slider-handle').text(_defaultSlider.activeIndex+1);;

                            // _$thisSliderTemp.siblings(':button.firstPage.swiperSliderNav').attr({'data-swiper-move-to':0});
                            _$thisSliderTemp.siblings(':button.pastPage.swiperSliderNav')
                                .attr({'data-swiper-move-to':_defaultSlider.slides.length-1})
                                .text(_defaultSlider.slides.length);
                        }
                    });

                    var _defaultSlider = iTCommons.swiper(
                            _$this,
                            {
                                slidesPerView: 'auto',
                                paginationClickable: true,
                                pagination: '.swiper-pagination', // <div class="swiper-pagination"></div>
                                nextButton: !!_nextSelector?_nextSelector:'.swiper-button-next', // <div class="swiper-button-next"></div>
                                prevButton: !!_prevSelector?_prevSelector:'.swiper-button-prev', // <div class="swiper-button-prev"></div>
                                onInit: function(_swiper){
                                    if (!!_$thisSlider) { // 초기화 될때 slider가 있을 경우 max값을 설정해준다.
                                        _$thisSlider.slider('option', 'max', _swiper.slides.length-1);
                                        _$thisSlider.find('.ui-slider-handle').text(_swiper.activeIndex+1);
                                    }
                                },
                                onSlideChangeStart: function(_swiper){
                                    if (!!_$thisSlider){ // 페이지가 변경될 때 slider가 있으면 값을 같이 변경해준다.
                                        var _activeIndex = _swiper.activeIndex > _swiper.slides.length-1 ? _swiper.slides.length-1 : _swiper.activeIndex;
                                        _$thisSlider.slider( 'option', 'value', _activeIndex );
                                        _$thisSlider.find('.ui-slider-handle').text(_activeIndex+1);
                                    }
                                }
                            }
                        );
                    sw_type_default.push({
                        el: _$this,
                        swiper: _defaultSlider
                    });
                }
            });
        }
        bindSwiperTypeDefault();

        function bindSwiperTypeCover(){
            // sw_type_cover = []; // Reset
            $bodyEl.find('.swiperTypeCover').each(function(){
                var _exists = false,
                    _$this = $(this),
                    footerSelector = _$this.data('footer-selector'),
                    headerSelector = _$this.data('header-selector'),
                    $header = !!headerSelector ? $(headerSelector) : undefined, //.outerHeight()
                    $footer = !!footerSelector ? _$this.find(footerSelector) : undefined,
                    _thisSliderNavSel = !!_$this.data('swiper-nav-selector')?_$this.data('swiper-nav-selector'):null,
                    _nextSelector = _$this.data('next-selector'),
                    _prevSelector = _$this.data('prev-selector');

                for (var i in sw_type_cover){
                    if (_$this.is(sw_type_cover[i].el)){
                        _exists = true;
                        break;
                    }
                }

                if (!_exists){
                    $(window).resize(function(){ // 디스플레이 폭이 변경되면 fullscreen slider에 높이 값을 다시 설정. onSlideChangeEnd() 콜백에도 호출하는 부분있음.
                        _$this.find('.swiper-wrapper > .swiper-slide').each(function(_i, _o){
                            var $s = $(_o);
                            var _slideContentHeight = ($(window).outerHeight() || document.body.clientHeight)-
                                    (
                                        ($header && $header.length>0?$header.outerHeight():0)
                                        + ($footer && $footer.length>0?$footer.outerHeight():0)
                                        + 50 //sub header Height
                                    )+2;

                            if ($s.children().length == 1) {
                                var _cssOpt = {};
                                _cssOpt['min-height'] = _slideContentHeight; // 최소 높이 설정
                                if ($s[0].hasAttribute('data-fit-height')){
                                    _cssOpt['height'] = _slideContentHeight;
                                }

                                /*
                                 * footer가 보여지는 슬라이드에서
                                 * 컨텐츠 높이가 스크린-풋터 사이즈보다 크다면 그만큼 margin-bottom을 추가
                                 */
                                if (!$s[0].hasAttribute('data-footer-hide')){
                                    if ($s.children(0).outerHeight() > $window.height()-(($footer && $footer.length>0?$footer.outerHeight():0) + ($header && $header.length>0?$header.outerHeight():0))){
                                        _cssOpt['margin-bottom'] = $footer && $footer.length>0?$footer.outerHeight():0;
                                    }
                                }
                                $s.children(0).css(_cssOpt);
                            }
                        });
                    }).trigger('resize');

                    if (_thisSliderNavSel){ // Add Action : Swiper Navigator onClick
                        $bodyEl.on('click', _thisSliderNavSel, function(e){
                            var _swiperMoveTo = parseInt($(this).attr('data-swiper-move-to'));
                            if( !isNaN(_swiperMoveTo) ) _typeCoverSwiper.slideTo(_swiperMoveTo);
                        });
                    }

                    /*
                     * Swiper에 Padding-bottom을 추가(Footer크기만큼)/제거(0) 한다.
                     *
                     * -추가 : setSwiperPaddingBottom(true, _$activeSlide);
                     * -제거 : setSwiperPaddingBottom()
                     */
                    function setSwiperPaddingBottom(useSetPadding, _$swActiveSlide){
                        if (useSetPadding){
                            if (!_$swActiveSlide[0].hasAttribute('data-fit-height'))
                            _$this.css({
                                'padding-bottom': ($footer && $footer.length>0?$footer.outerHeight():0)
                            })
                        } else {
                            _$this.css({
                                'padding-bottom': 0
                            })
                        }
                    }

                    /*
                     * Cover형 Swiper를 추가한다.
                     *
                     * > 속성
                     * - 풋터를 지정한다. data-fit-height 속성을 사용할 경우 쓰인다.
                     *      (.swiperTypeCover) data-footer-selector=".swiper-footer"
                     * - 해더를 지정한다.
                     *      (.swiperTypeCover) data-header-selector="#wrap .swiper-header"
                     * - 슬라이더 높이를 화면 크기에 맞춘다.
                     *      (.swiper-slide) data-fit-height
                     * - 풋터를 보인다. data-footer-show="[옵션:duration]"
                     *      (.swiper-slide) data-footer-show="300"
                     * - 풋터를 숨긴다. data-footer-hide="[옵션:duration]"
                     *      (.swiper-slide) data-footer-hide="300"
                     */
                    var _typeCoverSwiper_hideBtnCoverPrevQueue;
                    var _typeCoverSwiper = iTCommons.swiper(
                            _$this,
                            {
                                noBounce: !!_$this[0].hasAttribute('no-bounce'),
                                height: 100,
                                autoHeight: "true",
                                pagination: '.swiper-pagination', // <div class="swiper-pagination"></div>
                                paginationClickable: true,
                                nextButton: '.swiper-button-next', // <div class="swiper-button-next"></div>
                                prevButton: '.swiper-button-prev', // <div class="swiper-button-prev"></div>
                                onInit: function(_swiper){
                                    var _$activeSlide = $(_swiper.slides[_swiper.activeIndex]);
                                    // footer hide
                                    if (_$activeSlide[0].hasAttribute('data-footer-hide')){
                                        var footerHideDuration = _$activeSlide.data('footer-hide');
                                        // 숫자일 경우 : 애니메이션 시간
                                        if ($footer && $footer.length>0){
                                            if (regexNumber.test(footerHideDuration)) $footer.slideUp(footerHideDuration);
                                            else $footer.slideUp(0);
                                        }
                                        setSwiperPaddingBottom();

                                    }
                                    // footer show
                                    else {
                                        var footerShowDuration = _$activeSlide.data('footer-show');
                                        // 숫자일 경우 : 애니메이션 시간
                                        if ($footer && $footer.length>0){
                                            if (regexNumber.test(footerShowDuration)) $footer.slideDown(footerShowDuration, function(){setSwiperPaddingBottom(true, _$activeSlide)});
                                            else $footer.slideDown(0, function(){setSwiperPaddingBottom(true, _$activeSlide)});
                                        }
                                    }
                                    $('div.coverPrev').hide();
                                },
                                onSlideChangeStart : function(_swiper){ // 페이지 변경시 호출
                                    var _$activeSlide = $(_swiper.slides[_swiper.activeIndex]);
                                    // footer hide
                                    if (_$activeSlide[0].hasAttribute('data-footer-hide')){
                                        var footerHideDuration = _$activeSlide.data('footer-hide');
                                        // 숫자일 경우 : 애니메이션 시간
                                        if ($footer && $footer.length>0){
                                            if (regexNumber.test(footerHideDuration)) $footer.slideUp(footerHideDuration);
                                            else $footer.slideUp(0);
                                        }
                                        setSwiperPaddingBottom();
                                    }
                                    // footer show
                                    else {
                                        var footerShowDuration = _$activeSlide.data('footer-show');
                                        // 숫자일 경우 : 애니메이션 시간
                                        if ($footer && $footer.length>0){
                                            if (regexNumber.test(footerShowDuration)) $footer.slideDown(footerShowDuration, function(){setSwiperPaddingBottom(true, _$activeSlide)});
                                            else $footer.slideDown(0, function(){setSwiperPaddingBottom(true, _$activeSlide)});
                                        }
                                    }
                                    if (_swiper.isEnd) {
                                    	$('div.coverPrev').show();
                                    	if (!!_typeCoverSwiper_hideBtnCoverPrevQueue){clearTimeout(_typeCoverSwiper_hideBtnCoverPrevQueue);_typeCoverSwiper_hideBtnCoverPrevQueue = null;}
                                    	_typeCoverSwiper_hideBtnCoverPrevQueue = setTimeout(function(){
                                    		$('div.coverPrev').animate({'opacity':0}, 500, function(){$(this).hide().css({'opacity':1})});
                                    	}, 10*1000);
                                    }
                                    else {
                                    	$('div.coverPrev').hide();
                                    	if (!!_typeCoverSwiper_hideBtnCoverPrevQueue){clearTimeout(_typeCoverSwiper_hideBtnCoverPrevQueue);_typeCoverSwiper_hideBtnCoverPrevQueue = null;}
                                    }
                                },
                                onSlideChangeEnd: function(_swiper){
                                    $(window).trigger('resize');
                                }
                            }
                        );

                    sw_type_cover.push({
                        el: _$this,
                        swiper: _typeCoverSwiper
                    });
                    $bodyEl.on('click', 'div.coverPrev', function(){_typeCoverSwiper.slidePrev()});
                }
            });
        }
        bindSwiperTypeCover();

        function bindSwiperTypeCoverzz(){
            // sw_type_cover_zz = []; // Reset
            $bodyEl.find('.swiperTypeCoverzz').each(function(){
                var _exists = false,
                    _$this = $(this),
                    headerSelector = _$this.data('header-selector'),
                    footerSelector = _$this.data('footer-selector'),
                    pageHeaderSelector = _$this.data('page-header-selector'),
                    $header = !!headerSelector ? $(headerSelector) : undefined, //.outerHeight()
                    $footer = !!footerSelector ? _$this.find(footerSelector) : undefined,
                    _thisSliderNavSel = !!_$this.data('swiper-nav-selector')?_$this.data('swiper-nav-selector'):null,
                    $pageHeader = !!pageHeaderSelector ? $(pageHeaderSelector) : undefined; //.outerHeight()

                for (var i in sw_type_cover_zz){
                    if (_$this.is(sw_type_cover_zz[i].el)){
                        _exists = true;
                        break;
                    }
                }

                if (!_exists){
                    $(window).resize(function(){ // 디스플레이 폭이 변경되면 fullscreen slider에 높이 값을 다시 설정. onSlideChangeEnd() 콜백에도 호출하는 부분있음.
                        _$this.find('.swiper-wrapper > .swiper-slide').each(function(_i, _o){
                            var $s = $(_o);
                            var _slideContentHeight = ($(window).outerHeight() || document.body.clientHeight)-
                                    (
                                        ($header && $header.length>0?$header.outerHeight():0)
                                        + ($footer && $footer.length>0?$footer.outerHeight():0)
                                    )+2;

                            if ($s.children().length == 1) {
                                var _cssOpt = {};
                                _cssOpt['min-height'] = _slideContentHeight; // 최소 높이 설정
                                if ($s[0].hasAttribute('data-fit-height')){
                                    _cssOpt['height'] = _slideContentHeight;
                                }

                                /*
                                 * footer가 보여지는 슬라이드에서
                                 * 컨텐츠 높이가 스크린-풋터 사이즈보다 크다면 그만큼 margin-bottom을 추가
                                 */
                                if (!$s[0].hasAttribute('data-footer-hide')){
                                	if ($s.children(0).outerHeight() > $window.height()-(($footer && $footer.length>0?$footer.outerHeight():0) + ($header && $header.length>0?$header.outerHeight():0))){
                                		_cssOpt['margin-bottom'] = $footer && $footer.length>0?$footer.outerHeight():0;
                                	}
                                }
                                $s.children(0).css(_cssOpt);
                            }
                        });
                    }).trigger('resize');

                    if (_thisSliderNavSel){ // Add Action : Swiper Navigator onClick
                        $bodyEl.on('click', _thisSliderNavSel, function(e){
                            var _swiperMoveTo = parseInt($(this).attr('data-swiper-move-to'));
                            if( !isNaN(_swiperMoveTo) ) _swTypeCoverZz.slideTo(_swiperMoveTo);
                        });
                    }

                    /*
                     * Swiper에 Padding-bottom을 추가(Footer크기만큼)/제거(0) 한다.
                     *
                     * -추가 : setSwiperPaddingBottom(true, _$activeSlide);
                     * -제거 : setSwiperPaddingBottom()
                     */
                    function setSwiperPaddingBottom(useSetPadding, _$swActiveSlide){
                        if (useSetPadding){
                            if (!_$swActiveSlide[0].hasAttribute('data-fit-height'))
                            _$this.css({
                                'padding-bottom': ($footer && $footer.length>0?$footer.outerHeight():0)
                            })
                        } else {
                            _$this.css({
                                'padding-bottom': 0
                            })
                        }
                    }

                    var _swTypeCoverZz_hideBtnCoverPrevQueue;
                    var _swTypeCoverZz = iTCommons.swiper(
                                _$this,
                                {
                                    noBounce: true,
                                    height: 100,
                                    autoHeight: "true",
                                    pagination: '.swiper-pagination', // <div class="swiper-pagination"></div>
                                    paginationClickable: true,
                                    nextButton: '.swiper-button-next', // <div class="swiper-button-next"></div>
                                    prevButton: '.swiper-button-prev', // <div class="swiper-button-prev"></div>
                                    onInit: function(_swiper){
                                        var _$activeSlide = $(_swiper.slides[_swiper.activeIndex]);
//                                        $('.topVisual').css({'margin-top':-$window.outerHeight()});

                                        // footer hide
                                        if (_$activeSlide[0].hasAttribute('data-footer-hide')){
                                            var footerHideDuration = _$activeSlide.data('footer-hide');
                                            // 숫자일 경우 : 애니메이션 시간
                                            if ($footer && $footer.length>0){
                                                if (regexNumber.test(footerHideDuration)) $footer.slideUp(footerHideDuration);
                                                else $footer.slideUp(0);
                                            }
                                            setSwiperPaddingBottom();

                                        }
                                        // footer show
                                        else {
                                            var footerShowDuration = _$activeSlide.data('footer-show');
                                            // 숫자일 경우 : 애니메이션 시간
                                            if ($footer && $footer.length>0){
                                                if (regexNumber.test(footerShowDuration)) $footer.slideDown(footerShowDuration, function(){setSwiperPaddingBottom(true, _$activeSlide)});
                                                else $footer.slideDown(0, function(){setSwiperPaddingBottom(true, _$activeSlide)});
                                            }
                                        }
                                        $('div.coverPrev').hide();
                                    },
                                    onSlideChangeStart : function(_swiper){ // 페이지 변경시 호출
                                        var _$activeSlide = $(_swiper.slides[_swiper.activeIndex]);

                                        if (_swiper.activeIndex === 0){
                                            // Header All hide And Show
                                            // $('.topVisual').css({'margin-left':window.outerHeight});
                                        } else if (_swiper.activeIndex === 1){
                                            $pageHeader.css({'z-index':'1'}).each(function(_i, _o){
                                                var __$this = $(this),
                                                    _pageHeaderIndex = __$this.data('page-header-index');
                                                if (_pageHeaderIndex !== undefined && regexNumber.test(_pageHeaderIndex)){
                                                    if (_swiper.activeIndex === parseInt(_pageHeaderIndex)){
//                                                        __$this.show()//.css({'z-index':'100'});
//                                                        $('.topVisual').animate({'margin-top':0}, 0, function(){updateInnerTxtWrapMarginTop()})
                                                    }
                                                }
                                            })
                                        }

                                        // footer hide
                                        if (_$activeSlide[0].hasAttribute('data-footer-hide')){
                                            var footerHideDuration = _$activeSlide.data('footer-hide');
                                            // 숫자일 경우 : 애니메이션 시간
                                            if ($footer && $footer.length>0){
                                                if (regexNumber.test(footerHideDuration)) $footer.slideUp(footerHideDuration);
                                                else $footer.slideUp(0);
                                            }
                                            setSwiperPaddingBottom();
                                        }
                                        // footer show
                                        else {
                                            var footerShowDuration = _$activeSlide.data('footer-show');
                                            // 숫자일 경우 : 애니메이션 시간
                                            if ($footer && $footer.length>0){
                                                if (regexNumber.test(footerShowDuration)) $footer.slideDown(footerShowDuration, function(){setSwiperPaddingBottom(true, _$activeSlide)});
                                                else $footer.slideDown(0, function(){setSwiperPaddingBottom(true, _$activeSlide)});
                                            }
                                        }
                                        if (_swiper.isEnd) {
                                        	$('div.coverPrev').show();
                                        	if (!!_swTypeCoverZz_hideBtnCoverPrevQueue){clearTimeout(_swTypeCoverZz_hideBtnCoverPrevQueue);_swTypeCoverZz_hideBtnCoverPrevQueue = null;}
                                        	_swTypeCoverZz_hideBtnCoverPrevQueue = setTimeout(function(){
                                        		$('div.coverPrev').animate({'opacity':0}, 500, function(){$(this).hide().css({'opacity':1})});
                                        	}, 10*1000);
                                        }
                                        else {
                                        	$('div.coverPrev').hide();
                                        	if (!!_swTypeCoverZz_hideBtnCoverPrevQueue){clearTimeout(_swTypeCoverZz_hideBtnCoverPrevQueue);_swTypeCoverZz_hideBtnCoverPrevQueue = null;}
                                        }


                                    },
                                    onSlideChangeEnd: function(_swiper){
//                                        if (_swiper.activeIndex === 0){
//                                            // Header All hide And Show
////                                            $('.topVisual').css({'margin-top':-$window.outerHeight()});
//                                        }
                                        $(window).trigger('resize');
                                    }
                                }
                            );
                    sw_type_cover_zz.push({
                        el: _$this,
                        swiper: _swTypeCoverZz
                    });
                    $bodyEl.on('click', 'div.coverPrev', function(){_swTypeCoverZz.slidePrev()});

                    var $fixedHeaderImage = $('#fixedHeaderImage'),
                        $innerTxtWrap = $('.innerTxtWrap');
                    if(!!$fixedHeaderImage && $fixedHeaderImage.length > 0)
                        $fixedHeaderImage
                            .on('load', function(){})
                            .on('error', function(){
                                // this.src='../../images/thumbnail/talk/sample_interview.png'; // Error Image
                            })
                            .each(function(){
                                if(this.complete) {
                                    $(this).load()
                                } else if(this.error) {
                                    $(this).error();
                                }
                            });

                    function updateInnerTxtWrapMarginTop(){
                        $innerTxtWrap.css({
                            'padding-top':$fixedHeaderImage.outerHeight()
                                        /*
                                        // #contents CSS에 padding-top 설정되어 있어 top만큼 더해주는 부분(아래) 주석처리
                                            +Math.abs($fixedHeaderImage.offset().top)
                                        */
                        });
                        swiperUpdate();
                    }
                    $window.resize(function(){
                        if (!!$fixedHeaderImage && $fixedHeaderImage.length > 0){
                            updateInnerTxtWrapMarginTop();
                        }
                    });

                    updateInnerTxtWrapMarginTop();
                }
            });
        }
        bindSwiperTypeCoverzz();


        // Swiper 업데이트 (동적 컨텐츠 Load할 때 Height 재설정) - 개발영역에서 Swiper 페이지가 동적 변경되면 이 함수를 호출해줘야함
        function swiperUpdate(){
            if(!!sw_nav)sw_nav.update();
            if(!!sw_nav_pages)sw_nav_pages.update();
            if(!!sw_main_event){
                for(var i = 0, j = sw_main_event.length; i < j; i++){
                    sw_main_event[i].swiper.update();
                }
            }
            if(!!sw_type_page){
                for(var i = 0, j = sw_type_page.length; i < j; i++){
                    sw_type_page[i].swiper.update();
                }
            }
            if(!!sw_type_default){
                for(var i = 0, j = sw_type_default.length; i < j; i++){
                    sw_type_default[i].swiper.update();
                }
            }
            if(!!sw_type_cover){
                for(var i = 0, j = sw_type_cover.length; i < j; i++){
                    sw_type_cover[i].swiper.update();
                }
            }
            if(!!sw_type_cover_zz){
                for(var i = 0, j = sw_type_cover_zz.length; i < j; i++){
                    sw_type_cover_zz[i].swiper.update();
                }
            }
        }
        // ---------------------------------------------------------------
        // Export Function [S]
        // ---------------------------------------------------------------
        exportModules.bindSwiperMainEvent = bindSwiperMainEvent;
        exportModules.bindSwiperTypePage = bindSwiperTypePage;
        exportModules.bindSwiperTypePagezz = bindSwiperTypePagezz;
        exportModules.bindSwiperTypeDefault = bindSwiperTypeDefault;
        exportModules.bindSwiperTypeCover = bindSwiperTypeCover;
        exportModules.bindSwiperTypeCoverzz = bindSwiperTypeCoverzz;
        exportModules.swiperUpdate = swiperUpdate;
        // ---------------------------------------------------------------
        // Export Function [E]
        // ---------------------------------------------------------------

            // iTCommons.swiper(
            //     $('.popupScroll'),
            //     {
            //         scrollbar: '.swiper-scrollbar',
            //         direction: 'vertical',
            //         slidesPerView: 'auto',
            //         mousewheelControl: true,
            //         freeMode: true
            //     }
            // );

        // Test코드 - 반영시 제거
        $(document).on('click','footer', function(){
            debug = true;
        });

        /* --------------------------------------------
            Navigation 클릭 이벤트 등록 [S]
        -------------------------------------------- */
        var $shopNav_items      = $bodyEl.find('.shopNav > ul.swiper-wrapper li.swiper-slide'), // GNB
            shopNav_itemsSize   = $shopNav_items.length;
        for (var i = 0, ii = shopNav_itemsSize; i < ii; i++){
            var $shopNav_item = $shopNav_items.eq(i);

            /* loop모드 일 경우 인덱스+1 하여 data를 추가한다 */
            if (sw_nav_pages.params.loop) $shopNav_item.data(EL_DATA_NAME_INDEX, i+1);
            else $shopNav_item.data(EL_DATA_NAME_INDEX, i);

            $shopNav_item.on('click', function(e){ // 상단 Nav 아이템 클릭시 콜백 이벤트 등록
                triggerEvent(true, [TRIGGER_SHOP_EVENT_TYPE_NAV_CHANGE, $(this).data(EL_DATA_NAME_INDEX)]); // broadcast Event
            });
        }

        $(document).on(TRIGGER_SHOP_EVENT_PRIVATE, function(){
            // arguments[ 1 /* [이벤트], [이벤트 서브 타입], [기타 값들],[]... */]
            var _eSubType   = arguments[ 1 ],
                _idx        = arguments[ 2 ]
                ;

            switch(_eSubType){
                case TRIGGER_SHOP_EVENT_TYPE_NAV_CHANGE: {
                    if (typeof _idx !== 'number'){
                        return;
                    }
                    var _navIdx, _navPageIdx;
                        _navIdx = _navPageIdx = _idx;
                    if (sw_nav && sw_nav_pages){
                        if (sw_nav_pages.params.loop) {
                            switch (_idx){
                                case 0: { // 마지막 페이지
                                    _navIdx = shopNav_itemsSize-1;
                                    break;
                                }
                                case shopNav_itemsSize: { // 마지막 페이지
                                    _navIdx = shopNav_itemsSize-1;
                                    break;
                                }
                                case shopNav_itemsSize+1: { // 첫번째 페이지
                                    _navIdx = 0;
                                    break;
                                }
                                default: {_navIdx -= 1;}
                            }
                        }

                        $shopNav_items.removeClass(EL_ACTIVE_CLASS).eq(_navIdx).addClass(EL_ACTIVE_CLASS);
                        sw_nav.slideTo(_navIdx);
                        sw_nav_pages.slideTo(_navPageIdx);

                        triggerEvent([TRIGGER_SHOP_EVENT_TYPE_NAV_CHANGE, _navIdx]);
                    }
                }
            }
        });
        // Navigation 클릭 이벤트 등록 [E]

        /* --------------------------------------------
            메인화면 SWIPE 이벤트 등록 [S]
        -------------------------------------------- */
        $(document).on(TRIGGER_SHOP_EVENT_PUBLIC, function(){
            if (!!arguments[1] && typeof arguments[1] === 'string' && arguments[1] === TRIGGER_SHOP_EVENT_TYPE_NAV_CHANGE){
                var pageIdx = arguments[2] || 0;	// 넘어오는 argument가 없을 경우 default 0.

                if(swipeIndex != pageIdx) swipeIndex = pageIdx;
                else return false;


                //var _$activeSlide = $('section.shop-nav-adaptor > div.swiper-wrapper > .swiper-slide:eq('+pageIdx+')');

                /*if (!!_$activeSlide.attr('swiper-slide-header-title')){
                    if (!!_$activeSlide.attr('swiper-slide-header-src')) {
                        $(".mainLogo").html(
                            $('<img />').attr({
                                'src' : _$activeSlide.attr('swiper-slide-header-src'),
                                'alt' : _$activeSlide.attr('swiper-slide-header-title')
                            })
                        );
                    } else {
                        $(".mainLogo").text(_$activeSlide.attr('swiper-slide-header-title'));
                    }
                } else {
                    $(".mainLogo").text('');
                }*/

                // 메인화면 현재 페이지 인덱스
                $(document).trigger("mainIdx", pageIdx);

                // 홈 화면이 아닌 페이지에서만 홈버튼 표출
                /*if(pageIdx == 0) $(".btnMainHome").fadeOut(150);
                else $(".btnMainHome").fadeIn(150);*/
            }
        });
        // 메인화면 SWIPE 이벤트 등록 [E]


        /* --------------------------------------------
            화면 이동 element 등록 [S]
        -------------------------------------------- */
        /*
         * 사용방법
         *     1.페이지 이동 기능을 가진 element에 'goToPage'클래스를 입력합니다.
         *     2.해당 엘리먼트에 'data-swipe-to'속성과 타겟 인덱스를 값으로 입력합니다.
         *
         *     주의. data-swipe-to 속성이 없을 경우 '0'번째 페이지로 이동합니다.
         *
         *     ex) <span class="goToPage sth-oth-cls" data-swipe-to = '3'><a>랭킹화면으로..</a></span>
         *         ㄴ> '3'번째 페이지로 이동하는 a tag
         */
        $bodyEl.on('click', '.goToPage', function(){
        	var pIdx = $(this).data("swipeTo") || 0;
            sw_nav.slideTo(pIdx);
            sw_nav_pages.slideTo(pIdx);
        });
        // 화면 이동 element 등록 [E]


        /* --------------------------------------------
            고정 레이어 [S]
        -------------------------------------------- */
        /*
         * 사용방법
         *      -높이값을 처음 Load될때 'data-offset-top'으로 자동으로 설정됨
         *      1. 고정시킬 레이어(class추가 형식)에 'fixed-layer' 클래스 추가
         *      2. 'offset-top' 영역보다 스크롤 위치가 커질 때 추가 할 클래스를 'data-fixed-layer-class' 속성에 등록
         *      3. 어색하지 않도록 margin이 필요할 경우 'data-fixed-layer-margin'에 number형태로 등록
         */
        var $fixedLayerEls = $bodyEl.find('.fixed-layer');
        $fixedLayerEls.each(function(){
            var _$this = $(this);
            if(!!!_$this.data('offset-top')) _$this.data('offset-top', _$this.offset().top);
        })
        // 이벤트 발생은 $window.scroll() 에서 처리
        /*function fixedLayerUpdate(wTop){
        	console.log("먼저");
        	var $fixedLayerEl = $fixedLayerEls.eq(0);
        	console.log("$fixedLayerEl.data('offset-top') : " + $fixedLayerEl.data('offset-top'));
        	console.log("wTop : " + wTop);
            if ($fixedLayerEl.data('offset-top')+$fixedLayerEls.eq(_i).outerHeight() < wTop){
            	console.log("yes");
                $fixedLayerEl.addClass(nvl($fixedLayerEl.data('fixed-layer-class')));
                if (!!nvl($fixedLayerEl.data('fixed-layer-margin')))
                    $fixedLayerEl.css({'margin-top': nvl($fixedLayerEl.data('fixed-layer-margin'))});
            } else {
                $fixedLayerEl.removeClass(nvl($fixedLayerEl.data('fixed-layer-class')));
                if (!!nvl($fixedLayerEl.data('fixed-layer-margin'))){
                	var mgtop = $fixedLayerEl.data("fixed-layer-margin-top");
                	$fixedLayerEl.css({'margin-top': !!mgtop ? mgtop : 0});
                }
            }
        }*/
        // 고정 레이어 [E]


        /* --------------------------------------------
            더보기 이벤트 등록 [S]
        -------------------------------------------- */
        /*
         * 2016.3.9. ks-choi
         * 사용방법
         *      1. 더보기 이벤트를 동작시킬 엘리먼트에 '.ui-btn-more'를 추가
         *      2. 더보기 클릭시 보이도록 할 아이템 셀렉터를 'data-more-items-selector' 속성값으로 입력 (기준 <body/>이하 엘리먼트)
         *      3. 더보기 클릭시 숨게 할 아이템 셀렉터를 'data-more-hide-selector' 속성값으로 입력 (기준 <body/>이하 엘리먼트)
         *
         * 수정이력
         * 	    2016.3.28.   ks-choi    '더보기' 누를 경우 숨김처리가 아닌 '접기'로 문구 변경 및 이에 맞는 동작으로 변경
         */
        $bodyEl.on('click', '.ui-btn-more', function(){
            var $this = $(this),
            	onMoreClass = 'on-more',
                moreItemsSelector = $this.attr("data-more-items-selector"),
                $moreEls = !!moreItemsSelector ? $(moreItemsSelector) : []
//                moreHideSelector = $this.attr("data-more-hide-selector"),
//                $moreHideEls = !!moreHideSelector ? $(moreHideSelector) : []
                ;
            if ($this.hasClass(onMoreClass)){
            	$this.removeClass(onMoreClass).text('\ub354\ubcf4\uae30');
            	if ($moreEls.length > 0)$moreEls.hide(); // 더보기 아이템들 show()
//                if ($moreHideEls.length > 0)$moreHideEls.show(); // 숨길 아이템으로 지정된 엘리먼트 hide()
            	if(!!lnbScroll){setTimeout(function () {lnbScroll.refresh();},0)} // iScroll Height 갱신
            } else {
            	$this.addClass(onMoreClass).text('\uc811\uae30');
            	if ($moreEls.length > 0)$moreEls.show(); // 더보기 아이템들 show()
//                if ($moreHideEls.length > 0)$moreHideEls.hide(); // 숨길 아이템으로 지정된 엘리먼트 hide()
            	if(!!lnbScroll){setTimeout(function () {lnbScroll.refresh();},0)} // iScroll Height 갱신
            }
        });
        // 더보기 이벤트 등록 [E]


        /* --------------------------------------------
            검색 이벤트 등록 [S]
        -------------------------------------------- */
        /*
         * 2016.3.9. ks-choi
         * 사용방법
         *      1. 검색 영역을 show/hide 토글 할 버튼에 '.ui-btn-search-toggle' 추가
         *      2. 검색 영역 최상위 엘리먼트에 '#ui-btn-search-wrapper' 추가
         *      3. 검색어 입력 input box에 '.ui-input-search' 추가 (단, input box는 2.에서 등록한 '#ui-btn-search-wrapper'엘리먼트 안에 있어야 함)
         * 이벤트 동작에 따른 클래스 바인딩
         *      1. 검색 영역이 보여지게 되면 body와 검색 영역 최상위 엘리먼트('#ui-btn-search-wrapper')에 '.search-on' 추가됨 (반대 상황에서는 클래스 제거)
         *      2. 검색어 input('.ui-input-search')에 포커스가 되면 input과 검색 영역 최상위 엘리먼트('#ui-btn-search-wrapper')에 '.search-focus-on' 추가됨 (반대 상황에서는 클래스 제거)

        var topSearchInputFocusoutHandleQueue;
        $bodyEl.on('click', '#mainHeader .ui-btn-search-toggle', function(e){
            var $this = $(this),
                SEARCH_ON_CLASS = 'search-on',
                $searchWrapper = $('#ui-btn-search-wrapper');
                $headerSearchWrapper = $('.headerSearchWrap');
                $activationWrap = $('.autoActivationWrap');
                $mainContent = $('.shop-nav-adaptor');
                ;
            // 숨김
            if ($searchWrapper.hasClass(SEARCH_ON_CLASS)){
                $searchWrapper.add($bodyEl).removeClass(SEARCH_ON_CLASS)
                $headerSearchWrapper.css('display',"block");
                //$activationWrap.css('display',"none");
                $mainContent.css('display',"block");
            }
            // 보임
            else {
                $searchWrapper.add($bodyEl).addClass(SEARCH_ON_CLASS);
                //$activationWrap.css('display',"block");
                $mainContent.css('display',"none");
            }
        });
        $bodyEl.on('click', '#header .ui-btn-search-toggle', function(e){
            var $this = $(this),
                SEARCH_ON_CLASS = 'search-on',
                $searchWrapper = $('#ui-btn-search-wrapper');
                ;
            // 숨김
            if ($searchWrapper.hasClass(SEARCH_ON_CLASS)){
                $searchWrapper.add($bodyEl).removeClass(SEARCH_ON_CLASS);
            }
            // 보임
            else {
                $searchWrapper.add($bodyEl).addClass(SEARCH_ON_CLASS);
            }
        });
        $bodyEl.on('focus blur top-search-value-delete', '#ui-btn-search-wrapper .ui-input-search', function(e){
            var $this = $(this),
                SEARCH_INPUT_FOCUS_IN_CLASS = 'search-focus-on',
                $searchWrapper = $('#ui-btn-search-wrapper');
            switch (e.type){
                case 'focusin':{
                    $this.add($searchWrapper).addClass(SEARCH_INPUT_FOCUS_IN_CLASS);
                    $this.closest('.searchInner').removeClass('focusBefore');
                    break;
                }
                case 'top-search-value-delete':{
                	if (!!topSearchInputFocusoutHandleQueue) {clearTimeout(topSearchInputFocusoutHandleQueue); topSearchInputFocusoutHandleQueue=null;}
                	break;
                }
                case 'focusout':{
                	if (!!topSearchInputFocusoutHandleQueue) {clearTimeout(topSearchInputFocusoutHandleQueue);}
                	topSearchInputFocusoutHandleQueue = setTimeout(function(){
                    		$this.add($searchWrapper).removeClass(SEARCH_INPUT_FOCUS_IN_CLASS);
                    		$this.closest('.searchInner').addClass('focusBefore');
                    	}, 200);
                    break;
                }
            }
        });
        $bodyEl.on('click', '.ui-btn-search-delete', function(){
            $('#ui-btn-search-wrapper .ui-input-search').val('').focus().trigger('top-search-value-delete');
        });*/
        // 검색 이벤트 등록 [E]


        /* --------------------------------------------
            Detect Body Touch Events [S]
        -------------------------------------------- */
        // 터치 이벤트
        $bodyEl.on('touchend', function(e){
            if (debug) $d.html('Event:'+e.type +'<br/>Target:'+e.target.nodeName+'<br/>Class:'+e.target.className);
        })
        // 터치 이벤트
        $bodyEl.on('touchstart', function(e){
            if (debug) $d.html('Event:'+e.type +'<br/>Target:'+e.target.nodeName+'<br/>Class:'+e.target.className);
        })
        // 터치 이벤트
        $bodyEl.on('touchmove', function(e){
            if (debug) $d.html('Event:'+e.type +'<br/>Target:'+e.target.nodeName+'<br/>Class:'+e.target.className);
        });
        // @title window 스크롤 이벤트
        $window.on('scroll touchmove',function(_el){
        	/*if (updateNavPositionTimer === undefined) {
                updateNavPositionTimer = setInterval(fixedLayerUpdate, 100);
            }*/

            if ($('#goTop').length > 0){ // 2016.3.28.   ks-choi   Window스크롤시 상황에 따라 "#goTop"버튼 Show/Hide 토글
	            if ($window.scrollTop() < 54){
	            	$('#goTop').hide();
	            	$('.dealerArea').removeClass('smalltype');
	            	$('.qSCase').removeClass('off');
	            } else {
	            	$('#goTop').show();
	            	$('.dealerArea').addClass('smalltype');
	            	$('.qSCase').addClass('off');
	            }
            }

            if ($('.mainGnb').length > 0){ // 2017.5.11.   ks-choi   Window스크롤시 상황에 따라 "#mainGnb"버튼 Show/Hide 토글
                if ($window.scrollTop() < 10){
                    $('.mainGnb').removeClass('active');
                } else {
                    $('.mainGnb').addClass('active');
                }
            }
        }).scroll();
        $('.popupContents').scroll(function(){
        	if ($('.goTopPop').length > 0){ // 2016.3.28.   ks-choi   Window스크롤시 상황에 따라 ".goTopPop"버튼 Show/Hide 토글
	            if ($(this).scrollTop() < 50){
	            	$('.goTopPop').hide();
	            } else {
	            	$('.goTopPop').show();
	            }
            }
        });
        // Detect Body Touch Events [E]
        $bodyEl.on('click', '.p-container .goTopPop', function(){
        	$(this).closest('.p-container').find('.popupContents').scrollTop(0);
        });

        function init(){
            $bodyEl.addClass(ItDevice.isAndroid?'androidCase':ItDevice.isIOS?'iosCase':'');
            setTimeout(function(){updateNavPosition();}, 100);
            window.ITCButton.setupAll();
        }

        exportModules.runAllFun = function(){
            try{
                for (var k in window.uiModules){
                    if (typeof window.uiModules[k] === 'function' && k !== 'runAllFun'){
                        window.uiModules[k]();
                    }
                }
                iTCommons.setupTypeCount();
                iTCommons.setupTypeToggleAndTab();
                iTCommons.setupTypeAccordion();
                iTCommons.setupTypeCheckbox();
                iTCommons.setupTypeRadio();
                // iTCommons.setupTypePopup() // 팝업은 처음 로딩을 다 해와야 사용 가능
                iTCommons.setupTypeRating();
                $bodyEl.trigger('swiper-slider-update');
                if(!!lnbScroll){setTimeout(function () {lnbScroll.refresh();},0)}

                return true;
            } catch(e){
                return false;
            }
        }

        // Radio or Checkbox On - uiModules.checkOn('selector')
        exportModules.checkOn = function(sel){
            if (typeof sel !== 'string') return [];
            var $targets = $(sel).not(':checked');
            var $success = [];
            for (var i = 0, j = $targets.length; i<j; i++){
                if ($targets[i].nodeName.toLowerCase() === 'input' && $targets.eq(i).is(':radio,:checkbox')){
                    $success.push($targets.eq(i).click());
                }
            }
            return $success;
        }
        // Radio or Checkbox Off - uiModules.checkOff('selector')
        exportModules.checkOff = function(sel){
            if (typeof sel !== 'string') return [];
            var $targets = $(sel+':checked');
            var $success = [];
            for (var i = 0, j = $targets.length; i<j; i++){
                if ($targets[i].nodeName.toLowerCase() === 'input' && $targets.eq(i).is(':radio,:checkbox')){
                    $success.push($targets.eq(i).trigger('call-reset'));
                }
            }
            return $success;
        }

        window.uiModules = $.extend(window.uiModules || {}, exportModules);
//    });
    // ---------------------- jQuery - Document Ready [E] ---------------------- //
        window.ITCommons = iTCommons;
        window.ITCButton = iTCommons.button();
        init();
};
$(document).ready(fn_CommonJS);





/*
 * Open Source : Slide & Push Menus (added by ks-choi. 2016.3.1.)
 * Site : http://callmenick.com/
 * tutorial : http://callmenick.com/post/slide-and-push-menus-with-css3-transitions
 * Git : https://github.com/callmenick/Slide-Push-Menus
 * License : Licensed under the MIT license. Copyright 2014, Call Me Nick.
 * ------------------------------------------------------------------------
 * > 사용 방법 (*css는 추가 안함 : on 되면
 *              [body = .has-active-menu, mask = .is-active, menu = .is-active, wrap = .has-slide-left]
 *              가 추가되며 각 클래스를 이용하여 transition과 transform을 이용하여 animation 구현. 'tutorial' 사이트 링크를 참고)
 *  - html 마크업
 *      <body>
 *          <!-- 메뉴 -->
 *          <aside class="c-menu c-menu--slide-left">
 *              <button class="c-menu-close">Close</button>
 *              <div class="back">
 *                  <ul class="c-menu-items">
 *                      <li class="c-menu-item">side menu</li>
 *                      <li class="c-menu-item">side menu</li>
 *                  </ul>
 *              </div>
 *          </aside>
 *          <!-- 마스크 -->
 *          <div id="c-mask" class="c-mask"></div>
 *          <!-- 메인 -->
 *          <div id="wrap">
 *              <span class="hbtnSnb c-button">메뉴보기</span>
 *          </wrap>
 *      </body>
 *  - 스크립트
 *          var slideLeft = new Menu({
 *              wrapper: '#wrap', // wrap 지정
 *              type: 'slide-left', // 타입 지정 (slide, push. left, up, right, down등이 있지만.. slide left만 개발 적용해둠)
 *              menuOpenerClass: '.c-button', // 메뉴 열기 버튼 클래스 지정 (실제 동작이 아니라 메뉴가 열렸을 때 이벤트 동작을 막기 위해 동일 클래스를 지정)
 *              maskId: '#c-mask', // Mask Id 지정
 *              closeBtn: '.c-menu-close'
 *          });
 *          $(document).on('click', '.hbtnSnb', function(e){
 *              e.preventDefault;
 *              slideLeft.open();
 *          });
 * ------------------------------------------------------------------------
 * > 수정 이력
 * ks-choi     2016.3.1.    기본 스크립트 셀렉터 사용방식에서 jQuery 셀렉터로 변경
 *                          closeBtn 셀렉터 하드코딩 된 부분 option으로 설정 가능하도록 변경
 */
(function(window, $) {
    'use strict';
    /**
     * Extend Object helper function.
     */
    function extend(a, b) {
        for(var key in b) {
            if(b.hasOwnProperty(key)) {
                a[key] = b[key];
            }
        }
        return a;
    }

    /**
     * Each helper function.
     */
    function each(collection, callback) {
        for (var i = 0; i < collection.length; i++) {
            var item = collection[i];
            callback(item);
        }
    }

    /**
     * Menu Constructor.
     */
    function Menu(options) {
        this.options = extend({}, this.options);
        extend(this.options, options);
        this._init();
    }

    /**
     * Menu Options.
     */
    Menu.prototype.options = {
        /*wrapper: '#o-wrapper',          // The content wrapper
        type: 'slide-left',             // The menu type
        menuOpenerClass: '.c-button',   // The menu opener class names (i.e. the buttons)
        maskId: '#c-mask',              // The ID of the mask
        closeBtn: '.c-menu__close'*/
    };

    /**
     * Initialise Menu.
     */
    Menu.prototype._init = function() {
        this.body = $('body');
        this.wrapper = $(this.options.wrapper);
        this.mask = $(this.options.maskId);
        this.menu = $('.c-menu--' + this.options.type); // ks-choi id > class로 변경
        this.closeBtn = $(this.options.closeBtn);
        this.menuOpeners = $(this.options.menuOpenerClass);

        this._initEvents();
    };

    /**
     * Initialise Menu Events.
     */
    Menu.prototype._initEvents = function() {
        // Event for clicks on the close button inside the menu.
        /*this.closeBtn.on('click', function(e) {
            e.preventDefault();
            this.close();
        }.bind(this));*/

        // Event for clicks on the mask.
        this.mask.on('touchstart', function(e) {
            e.preventDefault();
            this.close();
        }.bind(this));

       var ww = 0, // window width
            tst = 0, // touch start timestamp
            tsx = 0, // touch start X pos
            tsy = 0, // touch start Y pos
            mx = 0, // move X pos
            my = 0, // move Y pos
            isMenuSwipe = 0; // 0: no event, 'sx': swipe X, 'sy': swipe Y
       /*         this.menu.on('touchstart', function(e) {
            this.menu.css('transition-duration', '0ms');
            tst = e.timeStamp;
            ww = $(window).outerWidth();
            tsx = e.originalEvent.touches[0].pageX;
            tsy = e.originalEvent.touches[0].pageY;
        }.bind(this));

        this.menu.on('touchmove', function(e) {
            mx = (tsx - e.originalEvent.touches[0].pageX);
            my = (tsy - e.originalEvent.touches[0].pageY);
            if (typeof isMenuSwipe === 'number' && Math.max(Math.abs(mx),Math.abs(my)) > 20){
                if (Math.abs(mx) > Math.abs(my)){ // x 스크롤이 더 클때
                    isMenuSwipe = 'sx';
                } else { // y 스크롤이 더 클때
                    isMenuSwipe = 'sy';
                }
            }
            if (isMenuSwipe === 'sx'){
                e.preventDefault();
                this.menu.css('transform','translate3d(-' + mx + 'px,0,0)');
            }
        }.bind(this));*/

        this.menu.on("touchend", function(e) {
            this.menu.css('transition-duration', '300ms');

            if (Math.abs(tst-e.timeStamp) < 500){ // 500ms보다 작게 이벤트가 발생했을 경우
                if (isMenuSwipe === 'sx') this.close();
            } else {
                if ((this.menu.outerWidth() / 2) > mx) {
                    this.menu.css('transform','translate3d(0px,0,0)');
                } else {
                    this.close();
                }
            }

            ww = tsx = tsy = mx = my = isMenuSwipe = tst = 0;
        }.bind(this));
    };

    // Menu.prototype._disableBodyScroll = function() {
    //   this.body.addEventListener('touchmove', function(e) {
    //     e.preventDefault();
    //   }, false);
    // };

    // Menu.prototype._enableBodyScroll = function() {
    //   this.body.removeEventListener('touchmove', function(e) {
    //     return true;
    //   }, false);
    // };

    /**
     * Open Menu.
     */
    Menu.prototype.open = function() {
        this.body.addClass('has-active-menu');
        // this._disableBodyScroll();

        this.wrapper.addClass('has-' + this.options.type);
        this.menu.addClass('is-active');
        this.mask.addClass('is-active');
        this.disableMenuOpeners();
    };

    /**
     * Close Menu.
     */
    Menu.prototype.close = function() {
        this.menu.css('transform','');

        this.body.removeClass('has-active-menu');
        // this._enableBodyScroll();

        this.wrapper.removeClass('has-' + this.options.type);
        this.menu.removeClass('is-active');
        this.mask.removeClass('is-active');
        this.enableMenuOpeners();
    };

    /**
     * Disable Menu Openers.
     */
    Menu.prototype.disableMenuOpeners = function() {
        each(this.menuOpeners, function(item) {
            item.disabled = true;
        });
    };

    /**
     * Enable Menu Openers.
     */
    Menu.prototype.enableMenuOpeners = function() {
        each(this.menuOpeners, function(item) {
            item.disabled = false;
        });
    };

    /**
     * Add to global namespace.
     */
    window.Menu = Menu;

})(window, jQuery);
