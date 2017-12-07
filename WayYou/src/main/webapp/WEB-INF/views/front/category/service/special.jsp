<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
	<div class="btn-toggle-wrapper">
		<div class="btnTab specialTab">
			<a href="" onclick="return false;" class="btn-toggle-switch on"><span><strong>BNK시세</strong><i>BNK Car Value</i></span></a>
			<a href=""onclick="return false;" class="btn-toggle-switch" ><span><strong>보장서비스</strong><i>Guarantee</i></span></a>
			<a href=""onclick="return false;" class="btn-toggle-switch" ><span><strong>내차사기</strong><i>Buy a Car</i></span></a>
			<a href=""onclick="return false;" class="btn-toggle-switch" ><span><strong>내차팔기</strong><i>Sell a Car</i></span></a>
		</div>
		<!-- BNK시세 -->
		<div class="btn-toggle-switch-target">
			<div class="innerLayout">
				<p class="carValue icon1">
					<strong>중고차 거래 관련 시세의 기준을 제공합니다</strong>
					<span>
						그 어디보다 정확한 중고차 시세를 확인해보실 수 있습니다.<br>
						전국에서 팔린 중고차 거래를 분석하여<br>
						정확한 시세를 제공해드립니다.<br>
						시세를 알고 싶은 차량의 정보를 입력하면<br>
						시세를 바로 확인해보실 수 있습니다 <br>
						<i>이제 BNK시세로 중고차 가격을 확인해보세요!</i>
					</span>
				</p>
				<p class="carValue icon2">
					<strong>신뢰 가능한 BNK시세</strong>
					<span>
						전국에서 팔린 중고차 거래 가격을 토대로<br>
						신뢰할 수 있는 현장정보를 제공해드립니다.<br>
						전국단위 최근 6개월 실 거래 데이터를 <br><!-- 2017-07-24 / 2017-07-20 -->
						매월 초 시세산출 프로그램을 이용, 차량 별 소매거래 시세를 실시간으로 제공합니다. <!-- 2017-07-24 -->
					</span>
				</p>
				<div class="btnSet mt20">
					<span><a href="<c:url value='/front/category/mycar/buyList'/>" class="red">내차사기</a></span>
					<span><a href="<c:url value='/front/category/mycar/sells'/>" class="red">내차팔기</a></span>
				</div>
			</div>
		</div>
		<!-- //BNK시세 -->
		<!-- 보장서비스 -->
		<div class="btn-toggle-switch-target" style="display:none;">
			<div class="innerLayout">
				<p class="carValue icon3">
					<strong>헛걸음보상 서비스</strong>
					<span>
						허위매물로부터 고객을 보호합니다.<br>
						구매 희망하는 차량이 광고와 다른 경우,<br>
						BNK오토모아에서 보상해드립니다.<br><!-- 2017-06-01 로고명변경 -->
						<i>사전 온라인 방문 예약된 헛걸음보상 차량에 한해 제공</i>
						<button class="btn-popup-full" data-pop-opts='{"target": ".popWrapSickness"}'>자세히보기</button>
					</span>
				</p>
				<p class="carValue icon4">
					<strong>환불보장 서비스</strong>
					<span>
						환불보장 서비스를 신청해보세요.<br>
						BNK 환불보장 마크가 부착된 차량 구매 시,<br>
						3일 이내에 환불이 가능합니다.<br>
						<i>고객 서비스 이용 수수료 및 환불 부담금 발생</i>
						<button class="btn-popup-full" data-pop-opts='{"target": ".popWrapRefund"}'>자세히보기</button>
					</span>
				</p>
				<p class="carValue icon5">
					<strong>연장보증 서비스</strong>
					<span>
						BNK오토모아에서 중고차 구매 시,<br> <!-- 2017-07-20 -->
						1년/2만km까지 중고차 보증기간을 무상으로 연장해드립니다. <br>
						<i>보장범위 및 보상대상 차종 등 자세한 사항은 확인</i>
						<button class="btn-popup-full" data-pop-opts='{"target": ".popWrapYear"}'>자세히보기</button>
					</span>
				</p>
			</div>
		</div>
		<!-- //보장서비스 -->
		<!-- 내차사기 -->
		<div class="btn-toggle-switch-target" style="display:none;">
			<div class="innerLayout">
				<p class="carValue icon6">
					<strong>내가 먼저 찜! 사전예약 서비스</strong>
					<span>
						마음에 드는 차량이 내가 보러 가는 중간에 팔리면 어쩌지?<br>
						직접 차량 확인 전 까지 차량 판매를 유보해드립니다.<br>
						원하시는 날짜, 시간, 시승여부등을 입력하고 신청하시면<br>
						판매자가 승인하는 경우에 한해서<br>
						고객님이 매매단지로 직접 확인하러 가기 전까지<br>
						판매자가 다른 사람에게 차량을 판매하지 않습니다. <br/>
						<i>(단, 헛걸음마크 부착차량이 아닌 경우 헛걸음이 발생할 수 있으니 판매 딜러와 충분한 협의 후 방문하시기 바랍니다. 헛걸음 마크 부착 차량에 한하여 보상금이 지급됩니다.)</i><!-- 2017-07-24 -->
					</span>
				</p>
				<p class="carValue icon7">
					<strong>시승·탁송 서비스</strong>
					<span>
						차량을 구매했는데 차량을 가지러 갈 시간이 없다면?<br>
						<!-- 차량을 시승해보고 싶다면?<br>
						시승서비스를 신청하시면 구매 전 차량을 시승하실 수 있습니다.<br> 2017-07-24 -->
						탁송서비스를 신청하시면 구매하신 차량에 한해서 원하는 곳에서 차량을 받아보실 수 있습니다.<br>
						<!-- 2017-07-12 by mj-cho
						시승서비스를 신청하시면 고객님이 원하시는 곳에서<br>
						구매 전 차량을 시승하실 수 있습니다.<br>
						탁송서비스를 신청하시면 구매하신 차량에 한해서<br>
						원하는 곳에서 차량을 받아보실 수 있습니다.<br> -->
						<i>서비스 신청 절차와 기타 자세한 사항은 확인바랍니다.</i>
						<button class="btn-popup-full" data-pop-opts='{"target": ".popWrapTake"}'>자세히보기</button>
					</span>
				</p>
			</div>
		</div>
		<!-- //내차사기 -->
		<!-- 내차팔기 -->
		<div class="btn-toggle-switch-target" style="display:none;">
			<div class="innerLayout">
				<p class="carValue icon8">
					<strong>MAKE-UP 서비스</strong>
					<span>
						메이크업 전문가가 직접 방문하여<br>
						차량의 토탈케어를 해드립니다.<br>
						차량 관리도 하고 더 높은 가격에 판매해보세요.
						<i><em>토탈케어</em> 세차 / 광택 / 사진 및 동영상 촬영</i>
						<!-- <i><em>토탈케어</em> 세차 / 광택 / 정비 / 소모품교체 / 성능점검 / 사진 및 동영상 촬영</i> 2017-07-24 -->
						<a href="#" ng-click="goMakeup()">신청하기</a>
					</span>
				</p>
				<p class="carValue icon9">
					<strong>방문견적 서비스</strong>
					<span>
						내 차가 얼마인지 궁금하다면?<br>
						방문견적 서비스를 이용해보세요.<br>
						차량평가 전문가가 찾아가 차량을 평가해드립니다.<br>
						<i>내차팔기 메뉴 혹은 마이페이지-마이카에서 내차등록후 신청가능합니다.</i>
						<a href="#" ng-click="goMycar()">신청하기</a>
					</span>
				</p>
				<p class="carValue icon10">
					<strong>위탁판매 서비스</strong>
					<span>
						번거로운 차량판매, 가격 흥정에 질리셨다면?<br>
						BNK오토모아에 믿고 맡기세요.<br><!-- 2017-06-01 로고명변경 -->
						신속하고 높은 가격에 차량을 판매해드립니다.
						<a href="javascript:alert('준비중입니다')">신청하기</a>
					</span>
				</p>
			</div>
		</div>
		<!-- //내차팔기 -->
	</div>
</section>