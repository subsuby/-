<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 2017-10-10 -->
<style>
	.mEventBig {position:fixed;top:75px;left:150px;z-index:1040;padding:0 0 15px;background:#fff;}
	.mEventBig img {display:block;}
	.mEventBig .btnSet {padding:0 35px 15px;}
	.mEventBig .btnSet a {padding:12px 0 10px;}
	.mEventBig .checkSet {padding:0 35px;}
	.mEventBig .checkSet label {font-size:16px;}
	.mEventBig button {position:absolute;top:10px;right:10px;border:none;}
	.mEventSmall {display:none;position:fixed;bottom:35px;left:70px;z-index:1040;}
	.mEventSmall button {border:none;}
</style>
<script>
	$("document").ready(function() {

		var popCloseYn = getCookie("eventClose");
		if(popCloseYn == "Y"){
			$('.mEventBig').hide();
			$('.mEventSmall').show();
			$('.mEventBig :checkbox').prop('checked', true);
		}else if(popCloseYn == "N" || !popCloseYn){
			$('.mEventBig').show();
			$('.mEventSmall').hide();
			$('.mEventBig :checkbox').prop('checked', false);
		}

		$('.mEventBig button ').on('click touch', function (){	//이벤트팝업창 닫기버튼
			$('.mEventBig').fadeOut();
			$('.mEventSmall').fadeIn();
			setCookie("eventClose", $('.mEventBig :checkbox').is(":checked")?"Y":"N", 1);
		});
		$('.mEventSmall button ').on('click touch', function (){	//이벤트뱃지 버튼
			$('.mEventSmall').fadeOut();
			$('.mEventBig').fadeIn();
		});
	});

	function setCookie(cookieName, value, exdays){
	    var exdate = new Date();
	    exdate.setDate(exdate.getDate() + exdays);
	    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
	    document.cookie = cookieName + "=" + cookieValue;
	}

	function deleteCookie(cookieName){
	    var expireDate = new Date();
	    expireDate.setDate(expireDate.getDate() - 1);
	    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
	}

	function getCookie(cookieName) {
	    cookieName = cookieName + '=';
	    var cookieData = document.cookie;
	    var start = cookieData.indexOf(cookieName);
	    var cookieValue = '';
	    if(start != -1){
	        start += cookieName.length;
	        var end = cookieData.indexOf(';', start);
	        if(end == -1)end = cookieData.length;
	        cookieValue = cookieData.substring(start, end);
	    }
	    return unescape(cookieValue);
	}
</script>
<div class="mEventBig" style="display:none;left:50%;margin-left:-250px">
	<img src="<c:url value="/product/images/sub/mainEvent_img.png"/>" alt="오픈기념 고객참여 EVENT  - 서비스 이용하고 혜택받자!" />
	<div class="btnSet">
		<span><a href="<c:url value="http://www.bnkcapital.co.kr/pc/bnkautomoa/event.html"/>" class="red" target="_blank">이벤트 확인</a></span>
	</div>
	<span class="checkSet"><label for="ch1"><input type="checkbox" id="ch1" class="big"/> 하루동안 보지 않기</label></span>
	<button><img src="<c:url value="/product/images/sub/mainEvent_close.png"/>" alt="이벤트닫기" /></button>
</div>
<div class="mEventSmall" style="display:none;">
	<button><img src="<c:url value="/product/images/sub/mainEvent_small.png"/>" alt="이벤트열기" /></button>
</div>
<!-- //2017-10-10 -->

<!-- contents -->
<div id="main_contents_wrap">
	<div class="mainContents">
		<section>
			<div class="topContents">
				<div class="back"> <!-- 2017-08-21 -->
					<img src="<c:url value="/product/images/common/mainLogo.png"/>" alt="BNK AUTOMOA"/>
					<p>허위매물 없는 실매물 중심의 중고차<br />BNK오토모아의 특별한 서비스와 함께해보세요.</p>
					<div class="mainSearch">
						<p class="searchBox1"><span></span><input type="text" id="searchName" placeholder="차량정보를 입력하세요" /><button class="icon" onclick="location.href='<c:url value="/product/car/index"/>'">검색</button></p>

						<div class="searchSelect" style="display:none;">
							<ul id="dropdown" >
							</ul>
						</div>
					</div>
					<a href="<c:url value="/product/car/index"/>" class="search">상세조건 검색하기</a>
					<button class="scrollDown">scrollDown</button>
				</div>
			</div>
			<div class="tabContents">
				<div class="innerLayout">
					<div class="dataSet">
						<div class="btn-toggle-wrapper sellTab">
							<div class="btnArea">
								<div class="btnTab case1 grid3">
									<a href="" onclick="return false;" class="btn-toggle-switch on"><span>내차사기</span></a>
									<a href="" onclick="return false;" class="btn-toggle-switch" ><span>내차팔기</span></a>
								</div>
							</div>
							<div class="btn-toggle-switch-target">
								<div class="swiperBack">
									<div class="swiperTypeCover" >
										<ul class="swiper-wrapper">
											<li class="swiper-slide">
												<div>
													<strong>시승·탁송 서비스</strong>
													<em>구매 전 시승하고 내 집에서 내 차 받기!</em>
													<p>
														원하시는 장소, 시간대에서 구매 전 차량을 시승해보고<br>
														구매한 차량을 원하는 곳에서 받아보세요!
													</p>
													<a href="<c:url value="/product/service/index?serviceMenu=7"/>">자세히 알아보기</a>
													<span class="icon7"></span>
												</div>
											</li>
											<li class="swiper-slide">
												<div>
													<strong>사전예약서비스</strong>
													<em>내가 먼저 찜! 내 차를 예약하기</em>
													<p>
														마음에 드는 차량이 내가 도착하기 전에 팔리면 어쩌지?<br>
														고객님이 직접 차량을 확인하시기 전까지 차량 판매를<br>
														유보해드립니다
													</p>
													<a href="<c:url value="/product/service/index?serviceMenu=6"/>">자세히 알아보기</a>
													<span class="icon6"></span>
												</div>
											</li>
										</ul>
										<div class="swiper-pagination"></div>
										<div class="btnSet pt12 pb0">
											<span><button class="red" onclick="location.href='<c:url value="/product/car/index"/>'">내차사기</button></span>
										</div>
									</div>
								</div>
							</div>
							<div class="btn-toggle-switch-target" style="display:none;">
								<div class="swiperBack">
									<div class="swiperTypeCover" >
										<ul class="swiper-wrapper">
											<li class="swiper-slide">
												<div>
													<strong>방문견적 서비스</strong>
													<em>내 차 판매를 내 집에서!</em>
													<p>
														내 차가 얼마인지 궁금하다면? 방문견적 서비스를 이용해보세요.<br>
														차량평가 전문가가 찾아가 차량을 평가해드립니다.
													</p>
													<a href="<c:url value="/product/service/index?serviceMenu=9"/>">자세히 알아보기</a>
													<span class="icon9"></span>
												</div>
											</li>
											<li class="swiper-slide">
												<div>
													<strong>MAKE-UP 서비스</strong>
													<em>차량 업그레이드로 더 높은 가격에!</em>
													<p>
														메이크업 전문가가 직접 방문하여<br>
														차량의 메이크업 토탈케어를 해드립니다.<br>
														차량  관리도 하고 더 높은 가격에 판매해보세요.
													</p>
													<a href="<c:url value="/product/service/index?serviceMenu=8"/>">자세히 알아보기</a>
													<span class="icon8"></span>
												</div>
											</li>
											<li class="swiper-slide">
												<div>
													<strong>위탁판매 서비스</strong>
													<em>번거로운 차량판매를 쉽게!</em>
													<p>
														차량판매가 번거로우신가요? 가격흥정에 질리셨나요?<br>
														BNK오토모아에 믿고 맡기신다면, 신속하고 높은 가격에<br> <!-- 2017-06-01 로고명변경 -->
														차량을 판매해드립니다.
													</p>
													<a href="<c:url value="/product/service/index?serviceMenu=10"/>">자세히 알아보기</a>
													<span class="icon10"></span>
												</div>
											</li>
										</ul>
										<div class="swiper-pagination"></div>
										<div class="btnSet pt12 pb0">
											<span><button class="red" onclick="location.href='<c:url value="/product/market/index"/>'">내차팔기</button></span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="innerLayout bgGrayCase" id="templateList">
			</div>
			<div class="innerLayout bgGrayCase" style="padding: 70px 100px;">
				<div style="text-align: center;">
					<video width="50%" controls="" controlslist="nodownload">
						<source src="https://bnkautomoa.co.kr/image/main.mp4" type="video/mp4">
					</video>
				</div>
			</div>

		</section>
	</div><!-- .mainContents -->
</div>
<!-- //contents -->