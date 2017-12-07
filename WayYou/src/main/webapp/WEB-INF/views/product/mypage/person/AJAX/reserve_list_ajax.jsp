<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="innerLayout bgGrayCase ">
    <div class="dataSet">
		<h3>방문사전 / 시승 / 탁송 예약알림 <strong style="float:right; font-size:14px; display:inline-block; padding-top:20px;">*신청한 차량이 판매된 경우 목록에서 삭제됩니다. </strong></h3>
        <div class="myList person reList">
            <table summary="목록">
                <caption>목록</caption>
                <colgroup>
                    <col width="130" />
                    <col width="*"   />
                    <col width="155" />
                    <col width="170" />
                    <col width="125" />
                    <col width="100" />
                    <col width="130" />
                    <col width="100" />
                </colgroup>
                <thead>
                    <tr>
                        <th>항목</th>
                        <th>예약차량</th>
                        <th>위치</th>
                        <th>판매자</th>
                        <th>예약일자</th>
                        <th>상태</th>
                        <th>시간</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${fn:length(reserve) == 0}">
                        <tr class="dataNone">
                            <td colspan="8">예약 알림이 없습니다.</td>
                        </tr>
                    </c:if>
                    <c:if test="${fn:length(reserve) != 0 }">
                        <c:forEach var="resrvList" items="${reserve }" varStatus="status">
                            <fmt:parseDate value="${resrvList.resReqDate}" pattern="yyyy-MM-dd" var="resReqDate"/>
                            <tr>
                                <td><span><i class="redline">${ct:getCodeString(ct:getConstDef('SYS_CODE_RES_TYPE'),resrvList.resType) }</i></span></td>
                                <td>${resrvList.carInfo.label.makerName }<br/>${resrvList.carInfo.label.carFullName }</td>
                                <td>${resrvList.carInfo.user.marketInfo.danjisido }${resrvList.carInfo.user.marketInfo.danjicity }<br />${resrvList.carInfo.user.dealerShopName }</td>
                                <td><span class="levelWrap"><em class="levelBadge level3"></em>${resrvList.carInfo.user.userName }</span></td>
                                <td><fmt:formatDate value="${resReqDate}" type="date" pattern="yyyy.MM.dd" /></td>
                                <td>
                                    <i class="${ct:getCodeSubNoString(ct:getConstDef('SYS_CODE_RES_STATUS'), resrvList.resStatus) }">
                                        ${ct:getCodeString(ct:getConstDef('SYS_CODE_RES_STATUS'),resrvList.resStatus) }
                                    </i>
                                </td>
                                <td>
                                    <c:if test="${resrvList.resAmpm eq 'AM'}">오전 <c:if test="${resrvList.resTime ne null}">${resrvList.resTime } 시</c:if></c:if>
                                    <c:if test="${resrvList.resAmpm eq 'PM'}">오후 <c:if test="${resrvList.resTime ne null}">${resrvList.resTime } 시</c:if></c:if>
                                </td>
                                <td>
                                    <c:if test="${resrvList.resStatus eq 92 || resrvList.resStatus eq 91 || resrvList.resStatus eq 90}"></c:if>
                                    <c:if test="${resrvList.resStatus ne 92 || resrvList.resStatus ne 91 || resrvList.resStatus ne 90}">
                                        <c:choose>
                                            <c:when test="${resrvList.resStatus eq 10 }">
                                                <button class="red" onclick="fn_cancel('${resrvList.resHisSeq }')">예약취소</button>
                                            </c:when>
                                            <c:when test="${resrvList.resStatus eq 11 }">
                                                <button class="red"     onclick="fn_acceptReserve('${resrvList.resHisSeq }')">승인</button>
                                                <button class="redline" onclick="fn_refuseReserve('${resrvList.resHisSeq }')">거절</button>
                                            </c:when>
                                            <c:when test="${resrvList.resStatus eq 20 }">
                                                <button class="redline btn-popup-auto" onclick="return false;" data-pop-opts='{"target": ".visitCancel"}' style="width: 100px;">취소요청</button>
                                            </c:when>
                                        </c:choose>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                </tbody>
            </table>
        </div>
        <c:if test="${fn:length(reserve) != 0}">
            <div class="pagingBtn">
                <paginatorAjax:print fncName="reserve_list" curPage="${curPage}" totPages="${totPages}"/>
            </div>
        </c:if>
    <!-- <span class="btnSet">
        <span><a href="" class="redLine" onclick="fn_cancel()">선택 예약취소</a></span>
    </span> -->
    </div>
</div>