<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="innerLayout bgGrayCase">
    <div class="dataSet">
        <h3>관심차량</h3>
        <ul class="listType1 recCar">
            <c:if test="${fn:length(interestCarList) == 0}">
                <li class="noInfo"></li>
                <li class="noInfo"></li>
                <li class="noInfo"></li>
                <li class="noInfo"></li>
                <li class="noInfo"></li>
                <li class="noInfo"></li>
                <li class="noInfo"></li>
                <li class="noInfo"></li>
            </c:if>
            <c:if test="${fn:length(interestCarList) != 0}">
                <c:forEach var="interestCar" items="${interestCarList}" varStatus="status">
                    <li>
                        <div class="thumBack">
                            <a href="<c:url value="/product/car/detail/${interestCar.carSeq}"/>">
                                <span class="markSet mark1" <c:if test="${interestCar.bnkConfYn ne 'Y' }">style="display:none;"</c:if>>인증</span>
                                <span class="saleCar">
                                	<span class="imgBack">
	                                	<strong>
	                                		<img src="<c:url value="${interestCar.itemImgInfo.mThumbPath }"/>" onerror="this.src='<c:url value="/product/images/thumbnail/sample5.png"/>'">
	                                	</strong>
                                	</span>
                                	<img src="<c:url value="/product/images/thumbnail/listCarCorver.png"/>" alt="" class="corver" />
								</span>
                            </a>
                        </div>
                        <div class="prBack">
                            <a href="<c:url value="/product/car/detail/${interestCar.carSeq}"/>">
                                <span class="productInfo">
                                    <span class="tit">
                                        <strong>${interestCar.label.makerName }     </strong>
                                        <span>  ${interestCar.label.modelDtlName }  </span>
                                        <span>  ${interestCar.label.gradeName }     </span>
                                    </span>
                                    <span class="option"><em>${interestCar.carRegYear }</em><em>${interestCar.carArea }</em><em><fmt:formatNumber value="${interestCar.useKm }" groupingUsed="true"/> km</em></span>
                                </span>
                                <span class="markGroup">
                                <c:if test="${interestCar.carGuarRefundYn == 'Y'}">
                                    <span class="markSet mark2">환불</span>
                                </c:if>
                                <c:if test="${interestCar.carGuarFruitlessYn == 'Y'}">
                                    <span class="markSet mark3">헛걸음</span>
                                </c:if>
                                <c:if test="${interestCar.carGuarTermYn == 'Y'}">
                                    <span class="markSet mark4">연장</span>
                                </c:if>
                                    <strong class="goodsPrice"><fmt:formatNumber value="${interestCar.saleAmt }" groupingUsed="true"/><i>만원</i></strong>
                                </span>
                            </a>
                        </div>
                        <span class="heartSet">
                            <input type="checkbox" id="recm_${status.count }" <c:if test="${interestCar.dibsYn eq 'Y' }">checked="checked"</c:if> onclick="fn_deleteCar(${interestCar.carSeq});">
                            <label for="recm_${status.count }"></label>
                        </span>
                    </li>
                </c:forEach>
            </c:if>
        </ul>
        <c:if test="${fn:length(interestCarList) != 0}">
            <div class="pagingBtn">
                <paginatorAjax:print fncName="interest_car_list" curPage="${curPage}" totPages="${totPages}"/>
            </div>
        </c:if>
	</div>
</div>