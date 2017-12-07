<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 구매비용계산기 -->
<div class="popupAutoWrap popCostPerson p-container">
<!-- popup header -->
	<div class="popupHeaderAuto">
		<header><h1>비용계산기</h1></header>
		<a class="btnClose p-close" onclick="return false;">
			<em class="blind">닫기</em>
		</a>
	</div>
	<hr/>
	<!-- popup contents -->
	<div class="popupContents">
		<section>
			<div class="costWrap costC2">
				<div class="myWrite" id="costTemplete">
<!-- 					<div class="writeRow type4"> -->
<!-- 						<strong>구매차량정보</strong> -->
<!-- 					</div> -->
<!-- 					<div class="writeRow"> -->
<!-- 	                     <strong><label>차량번호</label></strong> -->
<!-- 						<span><em id="carNum"></em></span> -->
<!-- 	                     <strong><label>차종</label></strong> -->
<!-- 						<span><em id="carModel"></em></span> -->
<!-- 					</div> -->
<!-- 					<div class="writeRow"> -->
<!-- 	                     <strong><label>연식</label></strong> -->
<!-- 						<span><em id="carRegYear"></em></span> -->
<!-- 	                     <strong><label>국산/수입</label></strong> -->
<!-- 						<span><em id="carNation"></em></span> -->
<!-- 					</div> -->
<!-- 					<div class="writeRow"> -->
<!-- 	                     <strong><label>승용/승합/화물</label></strong> -->
<!-- 						<span><em id="carKind"></em></span> -->
<!-- 	                     <strong><label>잔존율</label></strong> -->
<!-- 						<span><em id="carRemainRate"></em></span> -->
<!-- 					</div> -->
<!-- 					<div class="writeRow"> -->
<!-- 	                     <strong><label>과세표준</label></strong> -->
<!-- 						<span><em id="carStandTax"></em></span> -->
<!-- 	                     <strong><label>등록지역</label></strong> -->
<!-- 						<span><em id="regArea"></em></span> -->
<!-- 					</div> -->
<!-- 					<div class="writeRow"> -->
<!-- 	                     <strong><label>신차가격</label></strong> -->
<!-- 						<span><em id="newCarPrice"></em></span> -->
<!-- 	                     <strong><label>용도구분</label></strong> -->
<!-- 						<span><em id="useDiv"></em></span> -->
<!-- 					</div> -->
<!-- 					<div class="writeRow last"> -->
<!-- 	                     <strong><label>차량구매가격</label></strong> -->
<!-- 						<span><em id="carSalePrice"></em></span> -->
<!-- 	                     <strong><label id="carDiv"></label></strong> -->
<!-- 						<span><em id="carDetailDiv"></em></span> -->
<!-- 					</div> -->
<!-- 					<div class="writeRow type4"> -->
<!-- 						<strong>이전등록비용</strong> -->
<!-- 					</div> -->
<!-- 					<div class="writeRow type1"> -->
<!-- 						<strong><label>취등록세</label></strong> -->
<!-- 						<span><em id="regCost"></em></span> -->
<!-- 					</div> -->
<!-- 					<div class="writeRow"> -->
<!-- 	                     <strong><label>공채할인비</label></strong> -->
<!-- 						<span><em id="fundCost"></em></span> -->
<!-- 	                     <strong><label>인지대</label></strong> -->
<!-- 						<span><em id="carRecognition"></em></span> -->
<!-- 					</div> -->
<!-- 					<div class="writeRow"> -->
<!-- 	                     <strong><label>증지대</label></strong> -->
<!-- 						<span><em id="carStampCost"></em></span> -->
<!-- 	                     <strong><label>번호판교체</label></strong> -->
<!-- 						<span><em id="carNumberCost"></em></span> -->
<!-- 					</div> -->
<!-- 					<div class="writeRow type1 last"> -->
<!-- 	                     <strong><label>합계</label></strong> -->
<!-- 						<span><em id="prevRegSum"></em></span> -->
<!-- 					</div> -->
<!-- 					<div class="writeRow type4"> -->
<!-- 						<strong>매매상사 부대비용</strong> -->
<!-- 					</div> -->
<!-- 					<div class="writeRow type1"> -->
<!-- 	                     <strong><label>저당비용</label></strong> -->
<!-- 						<span><em id="carMortgage"></em></span> -->
<!-- 					</div> -->
<!-- 					<div class="writeRow"> -->
<!-- 	                     <strong><label>등록대행료</label></strong> -->
<!-- 						<span><em id="carRegAgency"></em></span> -->
<!-- 	                     <strong><label>관리비용</label></strong> -->
<!-- 						<span><em id="carManageCost"></em></span> -->
<!-- 					</div> -->
<!-- 					<div class="writeRow type1 last"> -->
<!-- 	                     <strong><label>합계</label></strong> -->
<!-- 						<span><em id="etcCostSum"></em></span> -->
<!-- 					</div> -->
<!-- 					<div class="writeRow type1 last"> -->
<!-- 						<strong>총구매비용합계</strong> -->
<!-- 						<span><em id="allSum"></em></span> -->
<!-- 					</div> -->
				</div>
				<div class="btnAreaType">
					<span><button class="btnClose p-close">닫기</button></span>
				</div>
			</div>
		</section>
	</div>
</div>
<!-- //구매비용계산기 -->
