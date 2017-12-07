<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%-- 스크립트 추가 --%>
<link rel="shortcut icon"   href="<c:url value="/front/images/bnk.ico?latest=${cssVersion}"/>"       />

<link rel="stylesheet"      href="<c:url value="/front/css/common.css?latest=${cssVersion}"/>"       />
<link rel="stylesheet"      href="<c:url value="/front/css/snb.css?latest=${cssVersion}"/>"          />
<link rel="stylesheet"      href="<c:url value="/front/css/car.css?latest=${cssVersion}"/>"          />
<link rel="stylesheet"      href="<c:url value="/front/css/my.css?latest=${cssVersion}"/>"           />
<link rel="stylesheet"      href="<c:url value="/front/js/swiper/swiper.css?latest=${cssVersion}"/>" />
<link rel="stylesheet"      href="<c:url value="/front/js/rating/star/rateit.css?latest=${cssVersion}"/>" media="all" type="text/css"/>


<link rel="stylesheet"      href="<c:url value="/front/css/certify.css?latest=${cssVersion}"/>"      />
<link rel="stylesheet"      href="<c:url value="/front/css/login.css?latest=${cssVersion}"/>"        />
<link rel="stylesheet"      href="<c:url value="/front/css/service.css?latest=${cssVersion}"/>"      />
<link rel="stylesheet"      href="<c:url value="/front/css/loading.css?latest=${cssVersion}"/>"      />


<!-- js libs -->
<script type="text/javascript" src="<c:url value="/front/js/jquery-2.2.0.min.js?latest=${jsVersion}"/>"></script>
<script type="text/javascript" src="<c:url value="/front/js/jquery.form.min.js?latest=${jsVersion}"/>"></script>
<script type="text/javascript" src="<c:url value="/front/js/jquery.easing.1.3.min.js?latest=${jsVersion}"/>"></script>
<script type="text/javascript" src="<c:url value="/front/js/swiper/swiper.jquery.js?latest=${jsVersion}"/>"></script>
<script type="text/javascript" src="<c:url value="/front/js/rangeslider.min.js?latest=${jsVersion}"/>"></script>
<script type="text/javascript" src="<c:url value="/front/js/rating/star/jquery.rateit.js?latest=${jsVersion}"/>"></script>
<!-- validator js -->
<script src="<c:url value="/front/js/validator.js?latest=${jsVersion}"/>"></script>

<!-- polyfill js -->
<script src="<c:url value="/front/js/polyfill/polyfill.js?latest=${jsVersion}"/>"></script>


<!-- angular js -->
<script src="<c:url value="/front/js/angular/angular.min.js?latest=${jsVersion}"/>"></script>
<script src="<c:url value="/front/js/angular/module/angular-sanitize.js?latest=${jsVersion}"/>"></script>
<script src="<c:url value="/front/js/angular/module/ng-file-upload.js?latest=${jsVersion}"/>"></script>
<script src="<c:url value="/front/js/angular/module/ng-file-upload-shim.js?latest=${jsVersion}"/>"></script>
<script src="<c:url value="/front/js/angular/module/bnkCommonDirective.js?latest=${jsVersion}"/>"></script>
<script src="<c:url value="/front/js/angular/module/bnkCommonFilter.js?latest=${jsVersion}"/>"></script>
<script src="<c:url value="/front/js/angular/module/bnkCommonService.js?latest=${jsVersion}"/>"></script>

<!-- angular directives js -->
<script src="<c:url value="/front/js/angular/directives/angucomplete-alt.js?latest=${jsVersion}"/>"></script>

<!-- angular services js -->

<!-- thinktree common -->
<script type="text/javascript" src="<c:url value="/front/js/ui-commons-basic.js?latest=${jsVersion}"/>"></script>
<script type="text/javascript" src="<c:url value="/front/js/basic.js?latest=${jsVersion}"/>"></script>

<!-- alertifyjs JavaScript -->
<script src="//cdn.jsdelivr.net/alertifyjs/1.10.0/alertify.min.js"></script>

<!-- alertifyjs CSS -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/alertifyjs/1.10.0/css/alertify.min.css"/>
<!-- Default theme -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/alertifyjs/1.10.0/css/themes/default.min.css"/>
<!-- Semantic UI theme -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/alertifyjs/1.10.0/css/themes/semantic.min.css"/>
<!-- Bootstrap theme -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/alertifyjs/1.10.0/css/themes/bootstrap.min.css"/>


<script type="text/javascript">
alertify.defaults = {
        // dialogs defaults
        autoReset:true,
        basic:false,
        closable:true,
        closableByDimmer:true,
        frameless:false,
        maintainFocus:true, // <== global default not per instance, applies to all dialogs
        maximizable:true,
        modal:true,
        movable:false,		// 팝업 움직이지 않게.
        moveBounded:false,
        overflow:true,
        padding: true,
        pinnable:true,
        pinned:true,
        preventBodyShift:false, // <== global default not per instance, applies to all dialogs
        resizable:true,
        startMaximized:false,
        transition:'fade',

        // notifier defaults
        notifier:{
            // auto-dismiss wait time (in seconds)
            delay:5,
            // default position
            position:'bottom-right',
            // adds a close button to notifier messages
            closeButton: false
        },

        // language resources
        glossary:{
            // dialogs default title
            //title:'AUTOMOA',
            // ok button text
            ok: 'OK',
            // cancel button text
            cancel: 'Cancel'
        },

        // theme settings
        theme:{
            // class name attached to prompt dialog input textbox.
            input:'ajs-input',
            // class name attached to ok button
            ok:'ajs-ok',
            // class name attached to cancel button
            cancel:'ajs-cancel'
        }
    };

</script>

<!-- popup -->
<script src="<c:url value="/front/js/popup/bnk-car-detail-search-pop/bnk-car-detail-search-pop.js?latest=${jsVersion}"/>"></script>				<!-- 차량정보 상세검색 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-car-sale-regist-pop/bnk-car-sale-regist-pop.js?latest=${jsVersion}"/>"></script>					<!-- 매물등록 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-reverse-auction-regist-pop/bnk-reverse-auction-regist-pop.js?latest=${jsVersion}"/>"></script>	<!-- 내게맞는매물 등록 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-my-qna-write-pop/bnk-my-qna-write-pop.js?latest=${jsVersion}"/>"></script>						<!-- 문의내역 등록 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-change-password-pop/bnk-change-password-pop.js?latest=${jsVersion}"/>"></script>					<!-- 비밀번호 변경 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-dealer-group-search-pop/bnk-dealer-group-search-pop.js?latest=${jsVersion}"/>"></script>			<!-- 딜러 소속단체팝업 -->
<script src="<c:url value="/front/js/popup/bnk-dealer-firm-search-pop/bnk-dealer-firm-search-pop.js?latest=${jsVersion}"/>"></script>			<!-- 딜러 소속상사팝업 -->
<script src="<c:url value="/front/js/popup/bnk-dealer-no-change-pop/bnk-dealer-no-change-pop.js?latest=${jsVersion}"/>"></script>				<!-- 딜러 종사자번호팝업 -->
<script src="<c:url value="/front/js/popup/bnk-sickness-pop/bnk-sickness-pop.js?latest=${jsVersion}"/>"></script>								<!-- 헛걸음보장 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-year-pop/bnk-year-pop.js?latest=${jsVersion}"/>"></script>										<!-- 연장보증 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-guarantee-pop/bnk-guarantee-pop.js?latest=${jsVersion}"/>"></script>										<!-- 연장보증 팝업2 -->
<script src="<c:url value="/front/js/popup/bnk-refund-pop/bnk-refund-pop.js?latest=${jsVersion}"/>"></script>									<!-- 환불보장 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-certify-pop/bnk-certify-pop.js?latest=${jsVersion}"/>"></script>									<!-- 인증중고차 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-login-pop/bnk-login-pop.js?latest=${jsVersion}"/>"></script>									<!-- 로그인 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-request-estimate-pop/bnk-request-estimate-pop.js?latest=${jsVersion}"/>"></script>				<!-- 견적요청 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-request-visit-pop/bnk-request-visit-pop.js?latest=${jsVersion}"/>"></script>                     <!-- 방문견적 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-cost-pop/bnk-cost-pop.js?latest=${jsVersion}"/>"></script>										<!-- 비용계산기 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-cost-result-pop/bnk-cost-result-pop.js?latest=${jsVersion}"/>"></script>							<!-- 비용계산기 결과팝업 -->
<script src="<c:url value="/front/js/popup/bnk-check-pop/bnk-check-pop.js?latest=${jsVersion}"/>"></script>										<!-- 체크리스트 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-check-dealer-pop/bnk-check-dealer-pop.js?latest=${jsVersion}"/>"></script>						<!-- 체크리스트 딜러팝업 -->
<script src="<c:url value="/front/js/popup/bnk-card-pop/bnk-card-pop.js?latest=${jsVersion}"/>"></script>										<!-- 명함발송 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-card-modify-pop/bnk-card-modify-pop.js?latest=${jsVersion}"/>"></script>							<!-- 명함수정 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-car-number-search-pop/bnk-car-number-search-pop.js?latest=${jsVersion}"/>"></script>				<!-- 차량번호검색 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-push-send-pop/bnk-push-send-pop.js?latest=${jsVersion}"/>"></script>								<!-- 전송하기 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-dealer-detail-pop/bnk-dealer-detail-pop.js?latest=${jsVersion}"/>"></script>					<!-- 딜러프로필상세 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-regist-common-pop/bnk-regist-common-pop.js?latest=${jsVersion}"/>"></script>					<!-- 견적여부 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-tip-pop/bnk-tip-pop.js?latest=${jsVersion}"/>"></script>											<!-- 중고차활용팁 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-right-tip-pop/bnk-right-tip-pop.js?latest=${jsVersion}"/>"></script>								<!-- 올바른 중고차고르기 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-document-tip-pop/bnk-document-tip-pop.js?latest=${jsVersion}"/>"></script>						<!-- 중고차 필수서류 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-get-car-sale-pop/bnk-get-car-sale-pop.js?latest=${jsVersion}"/>"></script>						<!-- 딜러 매물가져오기 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-accident-free-tip-pop/bnk-accident-free-tip-pop.js?latest=${jsVersion}"/>"></script>				<!-- 중고차 무사고 기준 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-car-drive-reserve-pop/bnk-car-drive-reserve-pop.js?latest=${jsVersion}"/>"></script>				<!-- 방문 시승 예약 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-car-consign-pop/bnk-car-consign-pop.js?latest=${jsVersion}"/>"></script>							<!-- 탁송 신청 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-address-search-pop/bnk-address-search-pop.js?latest=${jsVersion}"/>"></script>					<!-- 주소 검색 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-makeup-pop/bnk-makeup-pop.js?latest=${jsVersion}"/>"></script>									<!-- [일반]메이크업 신청 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-makeup-dealer-pop/bnk-makeup-dealer-pop.js?latest=${jsVersion}"/>"></script>									<!-- [일반]메이크업 신청 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-view-map-pop/bnk-view-map-pop.js?latest=${jsVersion}"/>"></script>								<!-- [딜러]메이크업 신청 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-consignment-pop/bnk-consignment-pop.js?latest=${jsVersion}"/>"></script>							<!-- 시승탁송 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-fake-report-pop/bnk-fake-report-pop.js?latest=${jsVersion}"/>"></script>							<!-- 허위매물신고 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-dealer-eval-regist-pop/bnk-dealer-eval-regist-pop.js?latest=${jsVersion}"/>"></script>			<!-- 딜러 평가등록 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-join-accept-pop/bnk-join-accept-pop.js?latest=${jsVersion}"/>"></script>					        <!-- 회원가입 완료 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-phone-verify-pop/bnk-phone-verify-pop.js?latest=${jsVersion}"/>"></script>                       <!-- 휴대폰인증 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-phone-verify-dealer-pop/bnk-phone-verify-dealer-pop.js?latest=${jsVersion}"/>"></script>         <!-- 휴대폰인증 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-dealer-estimate-pop/bnk-dealer-estimate-pop.js?latest=${jsVersion}"/>"></script>         		<!-- 딜러견적상세 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-reser-call-pop/bnk-reser-call-pop.js?latest=${jsVersion}"/>"></script>         					<!-- 예약취소불가 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-reser-time-pop/bnk-reser-time-pop.js?latest=${jsVersion}"/>"></script>         					<!-- 예약시간설정 팝업 -->
<script src="<c:url value="/front/js/popup/bnk-reser-time-con-pop/bnk-reser-time-con-pop.js?latest=${jsVersion}"/>"></script>         					<!-- 예약시간확인 팝업 -->

<!-- bnk directives -->
<script src="<c:url value="/front/js/angular/directives/bnk-price/bnk-price-common.js?latest=${jsVersion}"/>"></script>
<script src="<c:url value="/front/js/angular/directives/bnk-price/bnk-price-dealer.js?latest=${jsVersion}"/>"></script>
<script src="<c:url value="/front/js/angular/directives/bnk-price/bnk-price-normal.js?latest=${jsVersion}"/>"></script>
<script src="<c:url value="/front/js/angular/directives/bnk-car-info/bnk-car-info.js?latest=${jsVersion}"/>"></script>
<script src="<c:url value="/front/js/angular/directives/bnk-car-recommend/bnk-car-recommend.js?latest=${jsVersion}"/>"></script>
<script src="<c:url value="/front/js/angular/directives/bnk-dealer-profile/bnk-dealer-profile.js?latest=${jsVersion}"/>"></script>
<script src="<c:url value="/front/js/angular/directives/bnk-car-reverse-auction-recommend/bnk-car-reverse-auction-recommend.js?latest=${jsVersion}"/>"></script>

<!-- javascript object -->
<script src="<c:url value="/front/js/objects/bnk_Money.js?latest=${jsVersion}"/>"></script>	    <!-- Money 객체 -->
<script src="<c:url value="/front/js/objects/bnk_InputData.js?latest=${jsVersion}"/>"></script>	    <!-- InputData 객체 -->
<script src="<c:url value="/front/js/scheme/scheme.js?latest=${jsVersion}"/>"></script>	    	<!-- Scheme -->


<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=0OYqmW1gNciBsrZm_dxg"></script>	<!-- 네이버 지도 -->

<script>

var JUSO_API_KEY = 'U01TX0FVVEgyMDE3MDcxNDIyNTEwNDIyOTIy';

//차량 코드
var carCodeSearchMap		=	{};		//차량매물검색용 맵(최초에 makerList로 검색)
var carCodeQuickSearchList 	= 	[];		//퀵검색 자동완성을 위한 차량정보
var carDefInfoCodeList		=	[];		//차량매물기본정보
//CARMARKET 공통코드
var carMarketCommCodeMap	=	{};
//매매단지 코드
var shopCodeInfoMap 		= 	{};		//전체 매매상사 코드정보
//시스템 코드
var emailCodeList				=	[]; //DTL > MAIL DOMAIN
var optionTypeCodeList			=	[];	//옵션종류
var optionBasicCodeList			=	[];	//옵션(주요)
var optionExternalCodeList		=	[];	//옵션(외장장치)
var optionInternalCodeList		=	[];	//옵션(내장장치)
var optionConvenienceCodeList	=	[];	//옵션(안전장치)
var optionSafetyCodeList		=	[];	//옵션(편의장치)
var optionMediaCodeList			=	[];	//옵션(멀티미디어)
var optionDefaultCodeList		=	[];	//옵션(멀티미디어)
var evalDivCodeList				=	[];	//옵션(멀티미디어)

var fuelTypeCodeList		=	[];		//연료종류
var missionTypeCodeList		=	[];		//기어종류
var colorTypeCodeList		=	[];		//색상종류
var carStatusCodeList		=	[];		//매물상태
var carExtStatusCodeList	=	[];		//매물외부상태
var carAccStatusCodeList	=	[];		//매물사고여부
var eighteenAreaList		=   [];		//18개 지역
var carMaxPriceRangeList	=   [];		//최대가격
var carVehicleMileRageList	= 	[];		//주행거리
var carRentStatusCodeList	=	[];		//렌터카사용여부
var resTypeCodeList			=	[];		//예약요청구분
var resStatusCodeList		=	[];		//예약상태구분
var estTypeCodeList			=	[];		//견적요청구분
var makeupStatusCodeList	=	[];		//메이크업상태
var makeupTypeCodeList		=	[];		//메이크업서비스종류
var fakeTypeCodeList		=	[];		//허위매물종류

var regAreaCodeCommList = [];		// 공통코드 이전등록지역구분 - C0004
var carUseDivCodeCommList = [];		// 공통코드 차량 용도구분 - C0001
var carDivCodeCommList = [];		// 공통코드 차종구분(잔존율) - C0006
var carDetailDivCodeCommList = [];	// 공통코드 상세차종구분 - C0003

var chkDivCodeCommList     =   []; //공통코드 category 구분
$(document).ready(function(){


});
</script>