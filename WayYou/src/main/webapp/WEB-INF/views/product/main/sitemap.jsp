<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- contents -->
<div class="contents">
	<section>
	<div class="sitemap">
		<div class="innerLayout">
			<div class="dataSet">
				<h2>전체메뉴<em>BNK오토모아의 모든 메뉴를 보실 수 있습니다.</em></h2>
			</div>
		</div>
		<div class="innerLayout bgGrayCase">
			<div class="dataSet">
				<div class="sitemapBack">
					<dl>
						<dt>내차사기</dt>
						<dd>
							<a href="<c:url value="/product/car/index"/>">내차사기</a>
						</dd>
					</dl>
					<dl>
						<dt>내차팔기</dt>
						<dd>
							<a href="<c:url value="/product/market/index"/>">내차팔기</a>
						</dd>
					</dl>
					<dl class="three">
						<dt>인증중고차</dt>
						<dd>
							<a href="<c:url value="/product/premium/index"/>">인증중고차</a>
						</dd>
					</dl>
					<dl>
						<dt>BNK 특화서비스</dt>
						<dd>
							<a href="<c:url value="/product/service/index?menu=1"/>">BNK시세</a>
							<a href="<c:url value="/product/service/index?menu=2"/>">보장서비스</a>
							<a href="<c:url value="/product/service/index?menu=3"/>">내차사기</a>
							<a href="<c:url value="/product/service/index?menu=4"/>">내차팔기</a>
						</dd>
					</dl>
					<dl>
						<dt>마이페이지</dt>
						<dd>
						<c:choose>
							<c:when test="${sessUserInfo.userId == null}">
								<a href="<c:url value="/product/co/login"/>">마이카</a>
								<a href="<c:url value="/product/co/login"/>">방문사전/시승/탁송 예약알림</a>
								<a href="<c:url value="/product/co/login"/>">메이크업</a>
								<a href="<c:url value="/product/co/login"/>">명함관리</a>
								<a href="<c:url value="/product/co/login"/>">구매비용계산기</a>
								<a href="<c:url value="/product/co/login"/>">체크리스트</a>
								<a href="<c:url value="/product/co/login"/>">관심딜러</a>
								<a href="<c:url value="/product/co/login"/>">관심차량</a>
								<a href="<c:url value="/product/co/login"/>">내게맞는매물</a>
								<a href="<c:url value="/product/co/login"/>">문의내역관리</a>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${sessUserInfo.division == 'D'}">
										<a href="<c:url value="/product/mypage/mycarDealerRegist"/>">매물등록</a>
										<a href="<c:url value="/product/mypage/mycarDealerList"/>" >매물관리</a>
										<a href="<c:url value="/product/mypage/mycarDealerForwarding"/>" >매물전송서비스</a>
										<a href="<c:url value="/product/mypage/mycarDealerVisit"/>" >사전방문예약관리</a>
										<a href="<c:url value="/product/mypage/mycarDealerBusinesscard"/>" >명함관리</a>
										<a href="<c:url value="/product/mypage/mycarDealerCheckList"/>" >체크리스트관리</a>
										<a href="<c:url value="/product/mypage/mycarDealerCostList"/>" >구매비용계산기</a>
										<a href="<c:url value="/product/mypage/mycarDealerMakeup"/>" >메이크업</a>
										<a href="<c:url value="/product/mypage/mycarDealerMark"/>" >마크서비스</a>
									</c:when>
									<c:otherwise>
										<a href="javascript:void(0);" class="site myBanner mycar_list">마이카</a>
										<a href="javascript:void(0);" class="site myBanner reserve_list">방문사전/시승/탁송 예약알림</a>
										<a href="javascript:void(0);" class="site myBanner makeup_list">메이크업</a>
										<a href="javascript:void(0);" class="site myBanner businesscard_list">명함관리</a>
										<a href="javascript:void(0);" class="site myBanner cost_list">구매비용계산기</a>
										<a href="javascript:void(0);" class="site myBanner check_list">체크리스트</a>
										<a href="javascript:void(0);" class="site myBanner interest_dealer_list">관심딜러</a>
										<a href="javascript:void(0);" class="site myBanner interest_car_list">관심차량</a>
										<a href="javascript:void(0);" class="site myBanner sale_list">내게맞는매물</a>
										<a href="javascript:void(0);" class="site myBanner question_list">문의내역관리</a>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
						</dd>
					</dl>
				</div>
			</div>
		</div>
	</div>
	</section>
</div>
<!-- //contents -->