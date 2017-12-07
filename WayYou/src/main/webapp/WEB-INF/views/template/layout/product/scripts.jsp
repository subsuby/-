<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%-- 스크립트 추가 --%>
<link rel="stylesheet" href="<c:url value="/product/js/alertify/alertify.css?latest=${jsVersion}"/>"/>
<link rel="shortcut icon" href="<c:url value="/product/images/bnk.ico?latest=${cssVersion}"/>"/>
<link rel="stylesheet" href="<c:url value="/product/css/common.css?latest=${cssVersion}"/>"/>
<link rel="stylesheet" href="<c:url value="/product/css/login.css?latest=${cssVersion}"/>"/>
<link rel="stylesheet" href="<c:url value="/product/css/main.css?latest=${cssVersion}"/>"/>
<link rel="stylesheet" href="<c:url value="/product/css/car.css?latest=${cssVersion}"/>"/>
<link rel="stylesheet" href="<c:url value="/product/css/my.css?latest=${cssVersion}"/>"/>
<link rel="stylesheet" href="<c:url value="/product/css/special.css?latest=${cssVersion}"/>"/>

<!-- JavaScript Object -->
<script src="<c:url value="/product/js/objects/bnk_Money.js?latest=${jsVersion}"/>"></script>	    <!-- Money 객체 -->

<!-- JQuery -->
<script type="text/javascript" src="<c:url value="/product/js/jquery/jquery-2.2.0.min.js?latest=${jsVersion}"/>"></script>

<!-- JQuery Libs-->
<link rel="stylesheet" href="<c:url value="/product/js/jquery/jquery-ui.min.css?latest=${cssVersion}"/>"/>
<script type="text/javascript" src="<c:url value="/product/js/jquery/jquery-ui.min.js?latest=${jsVersion}"/>"></script>
<script type="text/javascript" src="<c:url value="/product/js/jquery/jquery.ui.touch-punch.min.js?latest=${jsVersion}"/>"></script>
<script type="text/javascript" src="<c:url value="/product/js/jquery/jquery.form.min.js?latest=${jsVersion}"/>"></script>
<script type="text/javascript" src="<c:url value="/product/js/jquery/jquery.easing.1.3.min.js?latest=${jsVersion}"/>"></script>
<script type="text/javascript" src="<c:url value="/product/js/jquery/placeholders.jquery.min.js?latest=${jsVersion}"/>"></script>
<script type="text/javascript" src="<c:url value="/product/js/jquery/jquery.serialize-object.js?latest=${jsVersion}"/>"></script>
<script type="text/javascript" src="<c:url value="/product/js/jquery/validate.js?latest=${jsVersion}"/>"></script>
<script type="text/javascript" src="<c:url value="/product/js/jquery/underscore.js?latest=${jsVersion}"/>"></script>
<script type="text/javascript" src="<c:url value="/product/js/jquery/jquery.fileupload.js?latest=${jsVersion}"/>"></script>
<script type="text/javascript" src="<c:url value="/product/js/jquery/jquery.fileupload-process.js?latest=${jsVersion}"/>"></script>
<script type="text/javascript" src="<c:url value="/product/js/jquery/jquery.fileupload-validate.js?latest=${jsVersion}"/>"></script>

<!-- Swiper JS -->
<link rel="stylesheet" href="<c:url value="/product/js/swiper/swiper.css?latest=${cssVersion}"/>"/>
<script type="text/javascript" src="<c:url value="/product/js/swiper/swiper.jquery.js?latest=${jsVersion}"/>"></script>

<!-- DatePicker JS -->
<script src="<c:url value="/product/js/calendar/ui.datepicker.js?latest=${jsVersion}"/>"></script>
<script src="<c:url value="/product/js/calendar/CommonMyssgPay.js?latest=${jsVersion}"/>"></script>
<script src="<c:url value="/product/js/calendar/OrderList.js?latest=${jsVersion}"/>"></script>
<script src="<c:url value="/product/js/calendar/payComm.js?latest=${jsVersion}"/>"></script>

<!-- Validator JS -->
<script src="<c:url value="/product/js/validator/validator.js?latest=${jsVersion}"/>"></script>

<!-- Polyfill JS -->
<script src="<c:url value="/product/js/polyfill/polyfill.js?latest=${jsVersion}"/>"></script>

<!-- Alertify JS -->
<script src="<c:url value="/product/js/alertify/alertify.js?latest=${jsVersion}"/>"></script>

<!-- Range Slider JS -->
<script type="text/javascript" src="<c:url value="/product/js/rangeslider/rangeslider.min.js?latest=${jsVersion}"/>"></script>

<!-- Rateit JS -->
<link rel="stylesheet" href="<c:url value="/product/js/rating/star/rateit.css?latest=${cssVersion}"/>" media="all" type="text/css"/>
<script type="text/javascript" src="<c:url value="/product/js/rating/star/jquery.rateit.js?latest=${jsVersion}"/>"></script>

<!-- Thinktree Common -->
<script type="text/javascript" src="<c:url value="/product/js/common/basic.js?latest=${jsVersion}"/>"></script>
<script type="text/javascript" src="<c:url value="/product/js/common/ui-commons-basic.js?latest=${jsVersion}"/>"></script>
<script type="text/javascript" src="<c:url value="/product/js/common/bnk_Valid.js?latest=${jsVersion}"/>"></script>

<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=0OYqmW1gNciBsrZm_dxg"></script>	<!-- 네이버 지도 -->

<script>
var JUSO_API_KEY = 'U01TX0FVVEgyMDE3MDcxNDIyNTEwNDIyOTIy';
var BNK_CTX = '${pageContext.request.contextPath}';
$("document").ready(function() {

	/* var mobileKeyWords = new Array('iPhone', 'iPod', 'BlackBerry', 'Android', 'Windows CE', 'Windows CE;', 'LG', 'MOT', 'SAMSUNG', 'SonyEricsson', 'Mobile', 'Symbian', 'Opera Mobi', 'Opera Mini', 'IEmobile');
	for (var word in mobileKeyWords){
		if (navigator.userAgent.match(mobileKeyWords[word]) != null){
			window.location.href = "https://bnkautomoa.co.kr/index.html";
			break;
		}
	}*/

	var curContext = '${context}';
	var scroll = 0;
	/* myMenu*/
	var cH = $(".contents").outerHeight();
	var elem = $("#footer").offset();
	$('.sideNav').css("height", cH);
	var floatPosition = parseInt($(".dealerArea").css('top'));
	var navPosition = parseInt($(".sideNav").css('top'));

	$(window).scroll(function(){
		if ($(window).scrollTop() < 57){
			$('.dealerArea').animate({top:"0" },{queue: false, duration:250});
			$('.priceLarge').css("position", "absolute");
			$('.sideNav div').animate({top:$(window).scrollTop()+"px" },{queue: false, duration:250});
		} else {
			var scrollTop = $(window).scrollTop()-57;
			var scrollNavTop = $(window).scrollTop()-114;
			var newPosition = scrollTop + floatPosition;
			var navNewPosition = scrollNavTop + navPosition;

			// 기존 css에서 플로팅 배너 위치(top)값을 가져와 저장한다.
			if(newPosition >= 4106) {
				newPosition = 4106;
		    }

			if(navNewPosition >= 4106){
				navNewPosition;
			}
			$(".dealerArea").stop().animate({
				"top" : newPosition + "px"
			}, {queue: false, duration:250});
			$(".sideNav div").stop().animate({
				"top" : navNewPosition + "px"
			}, {queue: false, duration:250});
			$('.priceLarge').css("position", "fixed");
			//$('').animate({top:($(window).scrollTop()-57)+"px" },{queue: false, duration:250});
			//$('.dealerArea').animate({top:($(window).scrollTop()-80)+"px" },{queue: false, duration:250});
		}
	});

	// 2017-08-25 jj-choi 배너클릭시 이동하게
	$(".myBanner").click(function(){
		var classes = $(this).attr('class').split(' ');
		if(curContext.indexOf("mypage/mycarPerson") != -1){
			var offset = $("#"+classes[2]).offset();
	        $('html, body').animate({scrollTop : offset.top +80}, 400);
		}else{
			$("#navVal").val(classes[2]);
			$("#navForm").attr("action", "/product/mypage/mycarPerson");
			$("#navForm").submit();
		}
	});
});

</script>