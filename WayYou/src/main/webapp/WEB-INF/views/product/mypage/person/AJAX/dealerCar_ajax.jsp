<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 판매차량 -->
<script>
console.log(${ct:toJson(interestCarList)});
</script>
<h2>판매차량</h2>
<ul class="listType1 recCar">
    <c:if test="${fn:length(interestCarList) == 0}">
    
    </c:if>
    <c:if test="${fn:length(interestCarList) != 0}">
        <c:forEach var="carList" items="${interestCarList }" varStatus="status">
            <li>
                <div class="thumBack">
                    <a href="/product/car/detail/${carList.carSeq}">
                        <span class="markSet mark1" style="${ct:equals(carList.bnkConfYn, 'Y') ? 'display:none;' : ''}">인증</span>
						<span class="saleCar">
							<span class="imgBack"><strong><img src="<c:url value="${carList.itemImgInfo.pThumbPath }"/>" onerror="this.src='<c:url value="/product/images/thumbnail/sample5.png"/>'" alt=""></strong></span>
							<img src="<c:url value="/product/images/thumbnail/listCarCorver.png"/>" alt="" class="corver" />
						</span>
                    </a>
                </div>
                <div class="prBack">
                    <a href="#">
                        <span class="productInfo">
                            <span class="tit">
                                <strong>${carList.label.makerName }     </strong>
                                <span>  ${carList.label.modelDtlName }  </span>
                                <span>  ${carList.label.gradeName }     </span>
                            </span>
                            
                            <span class="option"><em>${carList.carRegYear }</em><em>${carList.carArea }</em><em><fmt:formatNumber value="${carList.useKm }" groupingUsed="true" /> km</em></span>
                        </span>
                        <span class="markGroup">
                        <c:if test="${ct:equals(carList.carGuarRefundYn, 'Y')}">
                            <span class="markSet mark2">환불</span>
                        </c:if>
                        <c:if test="${ct:equals(carList.carGuarFruitlessYn, 'Y')}">
                            <span class="markSet mark3">헛걸음</span>
                        </c:if>
                        <c:if test="${ct:equals(carList.carGuarTermYn, 'Y')}">
                            <span class="markSet mark4">연장</span>
                        </c:if>
                            <strong class="goodsPrice"><fmt:formatNumber value="${carList.saleAmt }" groupingUsed="true" /> <i>만원</i></strong>
                        </span>
                    </a>
                </div>
                <span class="heartSet">
                    <input type="checkbox" id="dealer_inst_car_${status.index}" ${ct:equals(carList.dibsYn, 'Y') ? 'checked' : ''} onclick="javascript:util.loginCheck('DIBS_ON', '${carList.carSeq}', this);">
                    <label for="dealer_inst_car_${status.index}"></label>
                 </span>
            </li>
        </c:forEach>
    </c:if>
</ul>
<c:if test="${fn:length(interestCarList) != 0}">
    <div class="pagingBtn">
        <paginatorAjax:print fncName="fn_dealerProfile" curPage="${curPage}" totPages="${totPages }"/>
    </div>
</c:if>
