<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<tiles:insertAttribute name="meta" />
		<tiles:insertAttribute name="scripts" />
		<script>
		$(document).ready(function(){
			$('.heartSet').click(function(e){
				e.preventDefault();
				if(this.dataset.htype=='inst'){
					util.loginCheck('INST_ON', this.dataset.dealer, this);
				}else if(this.dataset.htype=='dibs'){
					util.loginCheck('DIBS_ON', this.dataset.seq, this);
				}
			});

			/**
				###[ 2017-08-28 ]###
				nav 회색 길이 조절
			*/
			var ___$wb = $('#wrap_back');
			var ___$contents = ___$wb.find('.contents:eq(0)');
			var ___$nav = ___$wb.find('.sideNav');
			___$nav.height(___$contents.height());
			$(this).ajaxComplete(function(event, req) {
				___$nav.height(___$contents.height());
			})

		});
		</script>
	</head>
	<body>
		<div id="skip">
			<h2 class="blind">스킵 네비게이션</h2>
			<ul>
				<li><a href="#container">본문바로가기</a></li>
				<li><a href="#gnb">메뉴바로가기</a></li>
				<li><a href="#footer">페이지하단 바로가기</a></li>
			</ul>
		</div>
		<div id="wrap_back">
			<div id="wrap">
				<tiles:insertAttribute name="header" />
				<hr/>
					<c:if test="${!fn:containsIgnoreCase(context, '/product/index')}">
					<div id="contents_wrap" <c:if test="${fn:containsIgnoreCase(context, '/car/index') || fn:containsIgnoreCase(context, '/premium/index')}">class="sidemenu"</c:if> >
					</c:if>
					<tiles:insertAttribute name="contents" />
					<tiles:insertAttribute name="contents-js" />
					<c:if test="${!fn:containsIgnoreCase(context, '/product/index')}">
					</div>
					</c:if>
				<hr/>
				<c:if test="${!fn:containsIgnoreCase(context, '/product/index')}">
				<!-- sideNav -->
				<div class="sideNav">
					<nav>
						<div>
						<h2>MY<br />MENU</h2>
							<ul>
							<c:choose>
								<c:when test="${sessUserInfo.userId == null}">
									<li><a href="javascript:void(0);" class="icon1 myBanner mycar_list"><i class="blind">마이카</i></a></li> <!-- 견적이 왔을 때 "new" -->
									<li><a href="javascript:void(0);" class="icon2 myBanner reserve_list"><i class="blind">방문사전 / 시승 / 탁송 예약알림</i></a></li>  <!-- 예약승인이 왔을 때 "new" -->
									<li><a href="javascript:void(0);" class="icon3 myBanner makeup_list"><i class="blind">메이크업</i></a></li> <!-- 상태값 변경이 있을 때 "new" -->
									<li><a href="javascript:void(0);" class="icon4 myBanner businesscard_list"><i class="blind">명함관리</i></a></li> <!-- 신규왔을  때 "new" -->
									<li><a href="javascript:void(0);" class="icon5 myBanner cost_list"><i class="blind">구매비용계산기</i></a></li> <!-- 신규왔을  때 "new" -->
									<li><a href="javascript:void(0);" class="icon6 myBanner check_list"><i class="blind">체크리스트</i></a></li> <!-- 신규왔을  때 "new" -->
									<li><a href="javascript:void(0);" class="icon7 myBanner interest_dealer_list"><i class="blind">관심딜러 리스트</i></a></li> <!-- "new" 없음 -->
									<li><a href="javascript:void(0);" class="icon8 myBanner interest_car_list"><i class="blind">관심차량</i></a></li> <!-- "new" 없음 -->
									<li><a href="javascript:void(0);" class="icon9 myBanner sale_list"><i class="blind">내게 맞는 매물</i></a></li> <!-- 맞는 매물이 신규왔을  때 "new" -->
									<li><a href="javascript:void(0);" class="icon10 myBanner question_list"><i class="blind">문의내역관리</i></a></li> <!-- 답변이 왔을 때 "new" -->
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${sessUserInfo.division == 'D'}">
											<li><a href="<c:url value="/product/mypage/mycarDealerRegist"/>" class="icon11"><i class="blind">매물등록</i></a></li> <!-- "new" 없음 -->
											<li><a href="<c:url value="/product/mypage/mycarDealerList"/>" class="icon1"><i class="blind">매물관리</i></a></li> <!-- "new" 없음 -->
											<li><a href="<c:url value="/product/mypage/mycarDealerForwarding"/>" class="icon12"><i class="blind">매물전송서비스</i></a></li> <!-- "new" 없음 -->
											<li <c:if test="${newDataInfo.readYnRes eq 'Y'}"> class="new" </c:if>><a href="<c:url value="/product/mypage/mycarDealerVisit"/>" class="icon2"><i class="blind">사전방문예약관리</i></a></li>  <!-- 신규 왔을 때 "new" -->
											<li><a href="<c:url value="/product/mypage/mycarDealerBusinesscard"/>" class="icon4"><i class="blind">명함관리</i></a></li> <!-- "new" 없음 -->
											<li><a href="<c:url value="/product/mypage/mycarDealerCheckList"/>" class="icon6"><i class="blind">체크리스트관리</i></a></li> <!-- "new" 없음 -->
											<li><a href="<c:url value="/product/mypage/mycarDealerCostList"/>" class="icon5"><i class="blind">구매비용계산기</i></a></li> <!-- "new" 없음 -->
											<li <c:if test="${newDataInfo.readYnMakeup eq 'Y'}"> class="new" </c:if>><a href="<c:url value="/product/mypage/mycarDealerMakeup"/>" class="icon3"><i class="blind">메이크업</i></a></li> <!-- 상태값 변경이 있을 때 "new" -->
											<c:if test="${sessUserInfo.userId eq '4123'}">
												<li><a href="<c:url value="/product/mypage/mycarDealerQna"/>" class="icon10"><i class="blind">문의내역관리</i></a></li> <!-- 신규왔을  때 "new" -->
											</c:if>
											<li><a href="<c:url value="/product/mypage/mycarDealerMark"/>" class="icon13"><i class="blind">마크서비스</i></a></li> <!-- "new" 없음 -->
										</c:when>
										<c:otherwise>
											<li <c:if test="${newDataInfo.readYnMycar eq 'Y'}"> class="new" </c:if>><a href="javascript:void(0);" class="icon1 myBanner mycar_list"><i class="blind">마이카</i></a></li> <!-- 견적이 왔을 때 "new" -->
											<li <c:if test="${newDataInfo.readYnRes eq 'Y'}"> class="new" </c:if>><a href="javascript:void(0);" class="icon2 myBanner reserve_list"><i class="blind">방문사전 / 시승 / 탁송 예약알림</i></a></li>  <!-- 예약승인이 왔을 때 "new" -->
											<li <c:if test="${newDataInfo.readYnMakeup eq 'Y'}"> class="new" </c:if>><a href="javascript:void(0);" class="icon3 myBanner makeup_list"><i class="blind">메이크업</i></a></li> <!-- 상태값 변경이 있을 때 "new" -->
											<li <c:if test="${newDataInfo.readYnNameCard eq 'Y'}"> class="new" </c:if>><a href="javascript:void(0);" class="icon4 myBanner businesscard_list"><i class="blind">명함관리</i></a></li> <!-- 신규왔을  때 "new" -->
											<li <c:if test="${newDataInfo.readYnCost eq 'Y'}"> class="new" </c:if>><a href="javascript:void(0);" class="icon5 myBanner cost_list"><i class="blind">구매비용계산기</i></a></li> <!-- 신규왔을  때 "new" -->
											<li <c:if test="${newDataInfo.readYnCheck eq 'Y'}"> class="new" </c:if>><a href="javascript:void(0);" class="icon6 myBanner check_list"><i class="blind">체크리스트</i></a></li> <!-- 신규왔을  때 "new" -->
											<li><a href="javascript:void(0);" class="icon7 myBanner interest_dealer_list"><i class="blind">관심딜러 리스트</i></a></li> <!-- "new" 없음 -->
											<li><a href="javascript:void(0);" class="icon8 myBanner interest_car_list"><i class="blind">관심차량</i></a></li> <!-- "new" 없음 -->
											<li <c:if test="${newDataInfo.readYnRecomm eq 'Y'}"> class="new" </c:if>><a href="javascript:void(0);" class="icon9 myBanner sale_list"><i class="blind">내게 맞는 매물</i></a></li> <!-- 맞는 매물이 신규왔을  때 "new" -->
											<li <c:if test="${newDataInfo.readYnQna eq 'Y'}"> class="new" </c:if>><a href="javascript:void(0);" class="icon10 myBanner question_list"><i class="blind">문의내역관리</i></a></li> <!-- 답변이 왔을 때 "new" -->
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
							</ul>
						</div>
					</nav>
				</div>
				<!-- //sideNav -->
				</c:if>
				<tiles:insertAttribute name="footer" />
			</div>
			<!---->
			<div class="topGo">
				<a href="#wrap" class="" id="goTop">상단이동</a>
			</div>
			<!--//-->
			<form id="navForm" method="post">
				<input type="hidden" name="navVal" id="navVal"/>
			</form>

			<div class="popupDim"></div>
			<c:set var="tilesLayer"><tiles:getAsString name="contents-popup"/></c:set>
			<c:set var="existLayer" value="${layer:exist(req, tilesLayer)}"/>
			<c:if test="${existLayer}">
				<tiles:insertAttribute name="contents-popup"/>
			</c:if>
		</div>
	</body>
</html>