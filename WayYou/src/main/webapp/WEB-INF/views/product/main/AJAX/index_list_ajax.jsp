<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
	<p class="certification">인증중고차</p>
	<ul class="listType1">
		<c:forEach items="${certify.data.list}" var="list" varStatus="status">
        <li>
			<div class="listSet"> <!-- 2017-08-22 by mj-cho -->
	            <div class="thumBack">
	                 <a href="<c:url value="/product/car/detail/${list.carSeq}"/>">
	                	<c:if test="${list.bnkConfYn == 'Y'}">
	                    	<span class="markSet mark1">인증</span>
	                	</c:if>
						<span class="saleCar">
							<span class="imgBack"><strong><img src="<c:url value="${list.itemImgInfo.pImgPath}"/>" onerror='this.src="<c:url value="/product/images/thumbnail/sample1.png"/>"'/></strong></span>
							<img src="<c:url value="/product/images/thumbnail/listCarCorver.png"/>" alt="" class="corver" />
						</span>
	                </a>
	            </div>
	            <div class="prBack">
	                <a href="<c:url value="/product/car/detail/${list.carSeq}"/>">
	                    <span class="productInfo">
	                        <span class="tit"><strong>${list.label.makerName}</strong><span>${list.label.modelDtlName}</span><span>${list.label.gradeName}</span></span>
	                        <span class="option"><em>${list.carRegYear}</em><em>${list.carArea}</em><em><fmt:formatNumber value="${list.useKm}" pattern="#,###" />km</em></span>
	                    </span>
	                    <span class="markGroup">
	                    	<c:if test="${list.carGuarRefundYn == 'Y'}">
	                        	<span class="markSet mark2">환불</span>
	                        </c:if>
	                        <c:if test="${list.carGuarFruitlessYn == 'Y'}">
	                        	<span class="markSet mark3">헛걸음</span>
	                        </c:if>
	                        <c:if test="${list.carGuarTermYn == 'Y'}">
	                        	<span class="markSet mark4">연장</span>
	                        </c:if>
	                        <strong class="goodsPrice"><fmt:formatNumber value="${list.saleAmt}" pattern="#,###" /><i>만원</i></strong>
	                    </span>
	                </a>
	            </div>
	<!--             <span class="heartSet"><input type="checkbox" id="h_1" checked /><label for="h_1">찜하기</label></span> -->
	            <span class="heartSet">
	            	<input type="checkbox" id="favo_${status.index}" <c:if test="${list.dibsYn eq 'Y' }">checked="checked"</c:if> onclick="javascript:util.loginCheck('DIBS_ON', ${list.carSeq}, this);"/>
	            	<label for="favo_${status.index}"><!--찜하기--></label>
	            </span>
	        </div>
			<img src="<c:url value="/product/images/thumbnail/listCorver.png"/>" alt="" class="listCorver" /><!-- 2017-08-22 by mj-cho -->
        </li>
        </c:forEach>
    </ul>
    <div class="btnSet moreBtn">
		<span><a href="<c:url value="/product/premium/index"/>" class="red">인증중고차 더보기</a></span>
	</div>