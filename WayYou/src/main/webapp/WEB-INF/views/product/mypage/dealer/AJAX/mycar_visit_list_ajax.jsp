<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="myList noMark">
<input type="hidden" class="cnt" value="${reserve.cnt}">
	<table summary="수집하는 개인정보 항목">
        <caption>수집하는 개인정보 항목</caption>
        <colgroup>
            <col width="100" />
            <col width="100" />
            <col width="" />
            <col width="" />
            <col width="80" />
            <col width="100" />
            <col width="130" />
            <col width="" />
            <col width="100" />
            <col width="100" />
        </colgroup>
        <thead>
            <tr>
                <th>예약날짜</th>
                <th>차량번호</th>
                <th>모델</th>
                <th>가격</th>
                <th>방문시간</th>
                <th>신청인</th>
                <th>연락처</th>
                <th>구분</th>
                <th>상태</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${reserve.resList}" var="list">
            	<fmt:parseDate var="dateString" value="${list.resReqDate}" pattern="yyyy-MM-dd"/>
            	<fmt:formatDate var="resReqDate" value="${dateString}" pattern="yyyy.MM.dd"/>
                <tr>
                    <td>${resReqDate}<input type="hidden" name="resHisSeq" value="${list.resHisSeq }"></input></td>
                    <td>${list.carPlateNum}</td>
                    <td>${list.carInfo.label.modelName}</td>
                    <td>
                  		<c:if test="${list.carInfo.saleAmt ne null}">
                   		 <fmt:formatNumber value="${list.carInfo.saleAmt}" pattern="#,###" />만원
                   		</c:if>
                   	</td>
                    <td>${list.resAmpm == 'AM' ? '오전' : list.resAmpm == 'PM' ? '오후' : ''} <c:if test="${list.resTime ne null}">&nbsp;${list.resTime}시 </c:if></td>
                    <td>${list.resUserNm}</td>
                    <td>${list.resUserTel}</td>
                    <td>${ct:getCodeString(ct:getConstDef('SYS_CODE_RES_TYPE'),list.resType) }</td>
                    <td>
                        <i class="${ct:getCodeSubNoString(ct:getConstDef('SYS_CODE_RES_STATUS'),list.resStatus) }">
                            ${ct:getCodeString(ct:getConstDef('SYS_CODE_RES_STATUS'),list.resStatus) }
                        </i>
                    </td>
                    <td>
                        <c:if test="${list.resStatus eq 92 || list.resStatus eq 91 || list.resStatus eq 90}"></c:if>
                        <c:if test="${list.resStatus ne 92 || list.resStatus ne 91 || list.resStatus ne 90}">
                            <c:choose>
                                <c:when test="${list.resStatus eq 10 }">
                                    <button class="redLine" onclick="fn_acceptVisitDealer('${list.resHisSeq }')" id="acceptVisitDealer">승인요청</button>
                                    <button class="btn-popup-auto" data-pop-opts='{"target": ".popReserTime"}' style="display: none;">승인요청</button><br/>
                                    <button class="blackLine" onclick="fn_refuseVisitDealer('${list.resHisSeq }','${list.resKey }')">거절</button>
                                </c:when>
                                <c:when test="${list.resStatus eq 11 }">
                                    <button class="blackLine" onclick="fn_refuseVisitDealer('${list.resHisSeq }','${list.resKey }')">거절</button>
                                </c:when>
                                <c:when test="${list.resStatus eq 20 }">
                                    <button class="blackLine btn-popup-auto" onclick="return false;" data-pop-opts='{"target": ".visitCancel"}'>취소요청</button>
                                </c:when>
                            </c:choose>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty reserve.resList}">
			<tr>
				<td colspan="10">예약신청이 없습니다.</td>
			</tr>
		</c:if>
        </tbody>
    </table>
</div>
<!---->
<c:if test="${!empty reserve.resList}">
	<paginatorAjax:print fncName="mycar_visit_list" curPage="${curPage}" totPages="${reserve.totPages}"/>
</c:if>