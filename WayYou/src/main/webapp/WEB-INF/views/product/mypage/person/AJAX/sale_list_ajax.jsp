<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="innerLayout">
    <div class="dataSet">
        <h3 class="line">내게 맞는 매물</h3>
        <h4>등록조건
            <c:if test="${car.makerCd eq null }">
                <span class="btnSet fr wAuto">
                    <span><a class="red btn-popup-auto" onclick="return false;" data-pop-opts='{"target": ".reverseAdd"}'>조건등록</a></span>
                </span>
            </c:if>
            <c:if test="${car.makerCd ne null }">
                <span class="btnSet fr wAuto">
                    <span><a class="redLine" onclick="fn_deleteSaleCar()">삭제</a></span>
                    <span><a class="red" id="modifySaleCar">조건수정</a><div class="btn-popup-auto" data-pop-opts='{"target": ".reverseAdd","display":"false"}' style="display: none;"></div></span>
                </span>
            </c:if>
        </h4>
        <div class="myList person rcList">
            <table summary="목록">
                <caption>목록</caption>
                <colgroup>
                    <col width="220" />
                    <col width="130" />
                    <col width="390" />
                    <col width="180" />
                    <col width="100" />
                    <col width="224" />
                </colgroup>
                <thead>
                    <tr>
                        <th>제조사</th>
                        <th>모델</th>
                        <th>세부모델</th>
                        <th>연식</th>
                        <th>색상</th>
                        <th>주행거리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${car.makerCd eq null }">
                        <tr class="dataNone">
                            <td colspan="7">등록된 차량 정보가 없습니다.</td>
                        </tr>
                    </c:if>
                    <c:if test="${car.makerCd ne null }">
                        <input type="hidden" id="saleMakerCd" name="makerCd" value="${car.makerCd }"></input>
                        <input type="hidden" id="saleModelCd" name="modelCd" value="${car.modelCd }"></input>
                        <input type="hidden" id="saleDetailModelCd" name="detailModelCd" value="${car.detailModelCd }"></input>
                        <tr>
                            <td>${car.label.makerName }</td>
                            <td>${car.label.modelName }</td>
                            <td><p>${car.label.modelDtlName }</p></td>
                            <td>
                                <c:if test="${car.label.carRegYear ne ''}">${car.label.carRegYear }</c:if>
                                <c:if test="${car.label.carRegYear eq ''}">없음</c:if>
                            </td>
                            <td>
                                <c:if test="${car.label.carColor ne ''}">${car.label.carColor }</c:if>
                                <c:if test="${car.label.carColor eq ''}">없음</c:if>
                            </td>
                            <td>
                                <c:if test="${car.label.useKm ne ''}"><fmt:formatNumber value="${car.label.useKm }" groupingUsed="true"/> km</c:if>
                                <c:if test="${car.label.useKm eq ''}">0km</c:if>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
        <div class="mt40">
        <h4>조건에 맞는 추천차량</h4>
        <ul class="listType1 recCar">
            <c:if test="${fn:length(recommend) != 0}">
                <c:forEach var="recList" items="${recommend }" varStatus="status">
                    <li>
                        <div class="thumBack">
                            <a href="/product/car/detail/${recList.carSeq}">
                                <span class="markSet mark1" <c:if test="${recList.bnkConfYn ne 'Y' }">style="display:none;"</c:if>>인증</span>
                                <span class="saleCar">
                                	<span class="imgBack">
	                                	<strong>
                                			<img src="<c:url value="${recList.itemImgInfo.mThumbPath }"/>" onerror="this.src='<c:url value="/product/images/thumbnail/sample5.png"/>'">
	                                	</strong>
                                	</span>
                                	<img src="<c:url value="/product/images/thumbnail/listCarCorver.png"/>" alt="" class="corver" />
								</span>
                                <%-- <img src="<c:url value="/product/images/thumbnail/sample5.png"/>" alt=""> --%>
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
                                    <span class="option"><em>${recList.carRegYear }</em><em>${recList.carArea }</em><em><fmt:formatNumber value="${recList.useKm }" groupingUsed="true"/> km</em></span>
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
                            <input type="checkbox" id="inst_sale_${status.count }" <c:if test="${recList.dibsYn eq 'Y' }">checked="checked"</c:if> onclick="javascript:util.loginCheck('DIBS_ON', ${recList.carSeq}, this);">
                            <label for="inst_sale_${status.count }"></label>
                        </span>
                    </li>
                </c:forEach>
            </c:if>
            <c:if test="${fn:length(recommend) == 0}">
                <li class="noInfo"></li>
                <li class="noInfo"></li>
                <li class="noInfo"></li>
                <li class="noInfo"></li>
            </c:if>
        </ul>
        <%-- <c:if test="${fn:length(recommend) != 0}">
            <div class="pagingBtn">
                <paginatorAjax:print fncName="sale_list" curPage="${curPage}" totPages="${totPages }"/>
            </div>
        </c:if> --%>
        </div>
    </div>
</div>