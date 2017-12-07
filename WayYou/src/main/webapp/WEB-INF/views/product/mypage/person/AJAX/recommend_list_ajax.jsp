<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="innerLayout bgGrayCase">
    <div class="dataSet">
        <h3>관심차량</h3>
        <ul class="listType1 recCar">
            <c:if test="${fn:length(recommend) == 0}">
                <li class="noInfo"></li>
                <li class="noInfo"></li>
                <li class="noInfo"></li>
                <li class="noInfo"></li>
                <li class="noInfo"></li>
                <li class="noInfo"></li>
                <li class="noInfo"></li>
                <li class="noInfo"></li>
            </c:if>
            <c:if test="${fn:length(recommend) != 0}">
                <c:forEach var="recList" items="${recommend }" varStatus="status">
                    <li>
                        <div class="thumBack">
                            <a href="#">
                                <span class="markSet mark1" <c:if test="${recList.bnkConfYn ne 'Y' }">style="display:none;"</c:if>>인증</span>
                                <%-- <img src="<c:url value="${recList.itemImgInfo.mThumbPath }"/>" alt="${recList.label.makerName } ${recList.label.modelDtlName}"> --%>
                                <img src="<c:url value="/product/images/thumbnail/sample5.png"/>" alt="">
                            </a>
                        </div>
                        <div class="prBack">
                            <a href="#">
                                <span class="productInfo">
                                    <span class="tit">
                                        <strong>${recList.label.makerName }     </strong>
                                        <span>  ${recList.label.modelDtlName }  </span>
                                        <span>  ${recList.label.gradeName }     </span>
                                    </span>
                                    <span class="option"><em>${recList.carRegYear}</em><em>${recList.carArea}</em><em>${recList.useKm} km</em></span>
                                </span>
                                <span class="markGroup">
                                <c:if test="${recList.carGuarRefundYn == 'Y'}">
                                    <span class="markSet mark2">환불</span>
                                </c:if>
                                <c:if test="${recList.carGuarFruitlessYn == 'Y'}">
                                    <span class="markSet mark3">헛걸음</span>
                                </c:if>
                                <c:if test="${recList.carGuarTermYn == 'Y'}">
                                    <span class="markSet mark4">연장</span>
                                </c:if>
                                    <strong class="goodsPrice">${recList.saleAmt }<i>만원</i></strong>
                                </span>
                            </a>
                        </div>
                        <span class="heartSet">
                            <input type="checkbox" id="recm_${status.count }" <c:if test="${recList.dibsYn eq 'Y' }">checked="checked"</c:if> onclick="javascript:util.loginCheck('DIBS_ON', ${recList.carSeq}, this);">
                            <label for="recm_${status.count }"></label>
                        </span>
                    </li>
                </c:forEach>
            </c:if>
        </ul>
        <c:if test="${fn:length(recommend) != 0}">
            <div class="pagingBtn">
                <paginatorAjax:print fncName="recommend_list" curPage="${curPage}" totPages="${totPages }"/>
            </div>
        </c:if>
	</div>
</div>