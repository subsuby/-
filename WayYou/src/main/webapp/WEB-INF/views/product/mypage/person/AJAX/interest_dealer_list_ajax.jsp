<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script>
console.log(${test});
</script>
<div class="innerLayout">
	<div class="dataSet">
		<h3>관심딜러 리스트</h3>
		<div class="carListHead dealerCase">
			<span>등급</span>
			<span>딜러명</span>
			<span>상사명</span>
			<span>판매중</span>
			<span>누적판매</span>
			<span>상세보기</span>
			<span>&nbsp;</span>
		</div>
		<div class="myList person makeBox bdbn">
			<table summary="목록">
				<caption>목록</caption>
				<colgroup>
					<col width="200" />
					<col width="200" />
					<col width="200" />
					<col width="200" />
					<col width="200" />
					<col width="200" />
					<col width="128" />
					<col width="128" />
				</colgroup>
				<tbody>
					<c:if test="${fn:length(interestDealerList) != 0}">
						<c:forEach var="interestDealer" items="${interestDealerList}" varStatus="status">
							<tr>
								<td>
									<span class="levelBadge level${not empty car.user.gradeDealer ? car.user.gradeDealer : '1' }"></span>
									<strong>
										${car.user.gradeDealer eq '1' ? 'BRONZE' : car.user.gradeDealer eq '2' ? 'SILVER' : car.user.gradeDealer eq '3' ? 'GOLD' : car.user.gradeDealer eq '4' ? 'DIAMOND' : 'BRONZE'}
									</strong>
								</td>
								<td>${interestDealer.userName}</td>
								<td>${interestDealer.dealerShopName}</td>
								<td>${interestDealer.saleCarCnt}대</td>
								<td>${interestDealer.saleCnt}대</td>
								<td>
									<button class="viewDetail dealerProfile" onclick='fn_interestDealer(this, "${interestDealer.userId}")'>상세보기</button>
									<div class="btn-popup-auto" data-pop-opts='{"target": ".popDealerView","display":"false"}'></div>
<%-- 									<a class="dealerProfile" onclick='fn_interestDealer(this, ${ct:toJson(interestDealer)})'> --%>
<%-- 									<a class="dealerProfile" onclick='fn_interestDealer(this, "${interestDealer.userId}")'> --%>
<!-- 									<button class="viewDetail dealerProfile btn-popup-auto"  data-pop-opts='{"target": ".popDealerView","display":"false"}'>상세보기</button> -->
								</td>
								<td>
									<button class="red" onclick="fn_delDealer(${interestDealer.userId})">삭제</button>
								</td>
							</tr>
					</c:forEach>
				</c:if>
				<c:if test="${fn:length(interestDealerList) == 0}">
					<td colspan="8">관심딜러가 없습니다.</td>
				</c:if>
			</tbody>
		</table>
	</div>
	<c:if test="${fn:length(interestDealerList) != 0}">
		<div class="pagingBtn">
			<paginatorAjax:print fncName="interest_dealer_list" curPage="${curPage}" totPages="${totPages}"/>
		</div>
	</c:if>
	</div>

<!--         <ul class="dealerList"> -->
<%--             <c:if test="${fn:length(interestDealerList) == 0}"> --%>
<!--             <li> -->
<!--                 <div class="inner bgGrayCase"> -->
<%--                 <img src="<c:url value="/product/images/common/profile_none.png"/>" class="noPro" alt="프로필 없음" /> --%>
<!--                 빈화면일 경우 img 추가 -->
<!--                 </div> -->
<!--             </li> -->
<%--             </c:if> --%>
<%--             <c:if test="${fn:length(interestDealerList) != 0}"> --%>
<%--                 <c:forEach var="interestDealer" items="${interestDealerList}" varStatus="status"> --%>
<!--                     <li> -->
<!--                         <div class="inner"> -->
<!--                             <span class="heartSet"> -->
<%--                                 <input type="checkbox" id="nmcr2_${status.count }" <c:if test="${ct:equals(interestDealer.dealerInterestYn,'Y')}">checked="checked"</c:if> onclick="javascript:set_interest('INST_ON', ${interestDealer.userId}, this);"/> --%>
<%--                                 <label for="nmcr2_${status.count }"></label> --%>
<!--                             </span> -->
<!--                             <a class="dealerProfile"> -->
<%--                             <a class="dealerProfile" onclick='fn_interestDealer(this, "${interestDealer.userId}")'> --%>
<%--                             <a class="dealerProfile" onclick='fn_interestDealer(this, ${ct:toJson(interestDealer)})'> --%>
<!--                                 <div class="thumProfile"> -->
<%--                                     <img src="<c:url value="/product/images/thumbnail/profile5.png"/>" alt="" /> --%>
<!--                                 </div> -->
<!--                                 <div class="autoWidth"> -->
<%--                                     <span class="levelBadge level${not empty car.user.gradeDealer ? car.user.gradeDealer : '1' }"></span><strong>${interestDealer.userName } <i>딜러</i></strong> --%>
<%--                                     <div class="rating rating-m" data-rateit-readonly="true" data-rateit-value="${interestDealer.evalAvg}"></div> --%>
<%--                                     <p>${interestDealer.dealerDanjiName }. ${interestDealer.marketInfo.danjicity}<br>종사자번호 ${interestDealer.dealerLicenseNo }<br> --%>
<%--                                         <em>판매중 <strong>${interestDealer.saleCarCnt}</strong> 대</em><em>누적판매 ${interestDealer.saleCnt} 대</em><!-- <em>거리 121 M</em> --> --%>
<!--                                     </p> -->
<!--                                 </div> -->
<!--                             </a> -->
<!--                             <button class="dealerProfile btn-popup-auto" data-pop-opts='{"target": ".popDealerView","display":"false"}' style="display: none;"/> -->
<!--                         </div> -->
<!--                     </li> -->
<%--                 </c:forEach> --%>
<%--             </c:if> --%>
<!--         </ul> -->
<%--         <c:if test="${fn:length(interestDealerList) != 0}"> --%>
<!--             <div class="pagingBtn"> -->
<%--                 <paginatorAjax:print fncName="interest_dealer_list" curPage="${curPage}" totPages="${totPages}"/> --%>
<!--             </div> -->
<%--         </c:if> --%>
<!--     </div> -->
</div>