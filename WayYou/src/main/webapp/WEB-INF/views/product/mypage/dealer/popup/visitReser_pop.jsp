<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 승인요청 -->
<div class="popupAutoWrap popReserTime p-container w670">
    <!-- popup header -->
    <div class="popupHeaderAuto">
        <header><h1>예약시간 승인요청</h1></header>
        <a class="btnClose p-close" onclick="return false;"><em class="blind">닫기</em></a>
    </div>
    <hr/>
    <!-- popup contents -->
    <div class="popupContents">
        <section>
            <div class="autoPop">
                <div class="basicWrite">
                    <table summary="정보입력 화면입니다.">
                        <colgroup>
                            <col style="width:20%;">
                            <col style="width:80%;">
                        </colgroup>
                        <caption>정보입력</caption>
                        <tbody>
                            <tr>
                                <th><label for="">예약 날짜</label></th>
                                <td>
                                    <input type="hidden" name="resHisSeq" id="resHisSeqHidden" value=""></input>
                                    <input type="hidden" name="resDate"   id="resDateHidden"   value=""></input>
                                    <select name="" id="resMonth" class="w100" disabled="disabled">
                                        <option value="">월</option>
                                        <c:forEach var="i" begin="1" end="12" step="1" >
                                            <option value="<fmt:formatNumber value="${i}" minIntegerDigits="2"/>"> ${i}월 </option>
                                        </c:forEach>
                                    </select>
                                    <select name="" id="resDay" class="w100 ml7" disabled="disabled">
                                        <option value="">일</option>
                                        <c:forEach var="i" begin="1" end="31" step="1" >
                                            <option value="<fmt:formatNumber value="${i}" minIntegerDigits="2"/>"> ${i}일 </option>
                                        </c:forEach>
                                    </select>
                                    <select name="resAmPm" id="resAmPm" class="w125 ml7" disabled="disabled">
                                        <option value="">오전/오후</option>
                                        <option value="AM">오전</option>
                                        <option value="PM">오후</option>
                                    </select>
                                    <select name="resTime" id="resTime" class="w100 ml7">
                                        <option value="">시간</option>
                                        <c:forEach var="i" begin="1" end="12" step="1" >
                                            <option value="<fmt:formatNumber value="${i}" minIntegerDigits="2"/>"><c:if test="${i <= 9 }">0</c:if> ${i}시 </option>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="btnAreaType mt20">
                    <span><button class="line p-close" id="closeReserve">취소</button></span>
                    <span><button type="button" onclick="fn_reserveTimeConfirm()">확인</button></span>
                </div>
            </div>
        </section>
    </div>
</div>
<!-- //승인요청 -->
