<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="contents">
     <section>
         <div class="myLayout">
				<jsp:include page="mycar_menu.jsp" flush="false" />
             <!--  -->
			<div class="titBar"><!-- active 추가시 활성화 -->
                <h2>시승요청관리 <em>전체 <i>10</i>건</em></h2>
                <!-- <span class="btnHelp"><em class="blind">도움말</em></span>
                <div class="popHelp">
                </div> -->
            </div>
            <div class="searchBox visitSearch">
                <div class="box mb0">
                   	<strong>신청일</strong>
                    <span class="datepicker_panel today" data-date="2017-04-29">
                        <input type="text" class="open_calendar add-on" id="searchStartDt" value="" readonly="readonly" />
                    </span>
                    <span class="caltxt">~</span>
                    <span class="datepicker_panel normal" data-date="2017-05-29">
                        <input type="text" class="open_calendar add-on" id="searchEndDt" value="" readonly="readonly" />
                    </span>
                    <strong class="vehicle">차량</strong>
                    <label for=""><input type="text" id="" placeholder="차량번호"></label>
                    <button class="btnSearch btnL">검색</button>
                    <button class="btnInit">초기화</button>
                </div>
                <script type="text/javascript" src="../../js/calendar/ui.datepicker.js"></script>
                <script type="text/javascript" src="../../js/calendar/CommonMyssgPay.js"></script>
                <script type="text/javascript" src="../../js/calendar/payComm.js"></script>
                <script type="text/javascript" src="../../js/calendar/OrderList.js"></script>
            </div>
            <div class="btn-toggle-wrapper">
                <div class="btnTab case1 grid4">
                    <a href="" onclick="return false;" class="btn-toggle-switch on"><span>전체</span></a>
                    <a href="" onclick="return false;" class="btn-toggle-switch" ><span>대기</span></a>
                    <a href="" onclick="return false;" class="btn-toggle-switch" ><span>수락</span></a>
                    <a href="" onclick="return false;" class="btn-toggle-switch" ><span>거절</span></a>
                    <button class="accept btnL">수락하기</button>
                    <button class="refuse">거절하기</button>
                </div>
                <div class="btn-toggle-switch-target">
                    <div class="myList noMark">
                        <table summary="수집하는 개인정보 항목">
                            <caption>수집하는 개인정보 항목</caption>
                            <colgroup>
                                <col width="" />
                                <col width="" />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>선택</th>
                                    <th>예약날짜</th>
                                    <th>차량번호</th>
                                    <th>모델</th>
                                    <th>가격</th>
                                    <th>방문시간</th>
                                    <th>신청인</th>
                                    <th>연락처</th>
                                    <th>상태</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><input type="checkbox" class="big"></td>
                                    <td>2017.05.05</td>
                                    <td>12가1234</td>
                                    <td>그랜저</td>
                                    <td>2,000만원</td>
                                    <td>오후 11시30분</td>
                                    <td>강미랑</td>
                                    <td>010-1234-5678</td>
                                    <td><i class="redLine">대기</i></td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox" class="big"></td>
                                    <td>2017.05.05</td>
                                    <td>12가1234</td>
                                    <td>스포티지</td>
                                    <td>2,000만원</td>
                                    <td>오후 11시30분</td>
                                    <td>강미랑</td>
                                    <td>010-1234-5678</td>
                                    <td><i class="red">수락</i></td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox" class="big"></td>
                                    <td>2017.05.05</td>
                                    <td>12가1234</td>
                                    <td>쉐보레크루즈</td>
                                    <td>2,000만원</td>
                                    <td>오후 11시30분</td>
                                    <td>강미랑</td>
                                    <td>010-1234-5678</td>
                                    <td><i class="red">수락</i></td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox" class="big"></td>
                                    <td>2017.05.05</td>
                                    <td>12가1234</td>
                                    <td>SM7</td>
                                    <td>2,000만원</td>
                                    <td>오후 11시30분</td>
                                    <td>강미랑</td>
                                    <td>010-1234-5678</td>
                                    <td><i class="blackLine">거절</i></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!---->
                    <div class="paging">
                        <span class="btn prev"><a href="">이전</a></span>
                        <a href="">1</a>
                        <a href="" class="on">2</a>
                        <a href="">3</a>
                        <a href="">4</a>
                        <a href="">5</a>
                        <span class="btn next"><a href="">다음</a></span>
                    </div>
                </div>
                <div class="btn-toggle-switch-target" style="display:none;">
                    <div class="myList noMark">
                        <table summary="수집하는 개인정보 항목">
                            <caption>수집하는 개인정보 항목</caption>
                            <colgroup>
                                <col width="" />
                                <col width="" />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>선택</th>
                                    <th>예약날짜</th>
                                    <th>차량번호</th>
                                    <th>모델</th>
                                    <th>가격</th>
                                    <th>방문시간</th>
                                    <th>신청인</th>
                                    <th>연락처</th>
                                    <th>상태</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><input type="checkbox" class="big"></td>
                                    <td>2017.05.05</td>
                                    <td>12가1234</td>
                                    <td>스포티지</td>
                                    <td>2,000만원</td>
                                    <td>오후 11시30분</td>
                                    <td>강미랑</td>
                                    <td>010-1234-5678</td>
                                    <td><i class="redLine">대기</i></td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox" class="big"></td>
                                    <td>2017.05.05</td>
                                    <td>12가1234</td>
                                    <td>그랜저</td>
                                    <td>2,000만원</td>
                                    <td>오후 11시30분</td>
                                    <td>강미랑</td>
                                    <td>010-1234-5678</td>
                                    <td><i class="red">수락</i></td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox" class="big"></td>
                                    <td>2017.05.05</td>
                                    <td>12가1234</td>
                                    <td>그랜저</td>
                                    <td>2,000만원</td>
                                    <td>오후 11시30분</td>
                                    <td>강미랑</td>
                                    <td>010-1234-5678</td>
                                    <td><i class="blackLine">거절</i></td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox" class="big"></td>
                                    <td>2017.05.05</td>
                                    <td>12가1234</td>
                                    <td>스포티지</td>
                                    <td>2,000만원</td>
                                    <td>오후 11시30분</td>
                                    <td>강미랑</td>
                                    <td>010-1234-5678</td>
                                    <td><i class="redLine">대기</i></td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox" class="big"></td>
                                    <td>2017.05.05</td>
                                    <td>12가1234</td>
                                    <td>그랜저</td>
                                    <td>2,000만원</td>
                                    <td>오후 11시30분</td>
                                    <td>강미랑</td>
                                    <td>010-1234-5678</td>
                                    <td><i class="red">수락</i></td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox" class="big"></td>
                                    <td>2017.05.05</td>
                                    <td>12가1234</td>
                                    <td>스포티지</td>
                                    <td>2,000만원</td>
                                    <td>오후 11시30분</td>
                                    <td>강미랑</td>
                                    <td>010-1234-5678</td>
                                    <td><i class="blackLine">거절</i></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!---->
                    <div class="paging">
                        <span class="btn prev"><a href="">이전</a></span>
                        <a href="">1</a>
                        <a href="" class="on">2</a>
                        <a href="">3</a>
                        <a href="">4</a>
                        <a href="">5</a>
                        <span class="btn next"><a href="">다음</a></span>
                    </div>
                </div>
                <div class="btn-toggle-switch-target" style="display:none;">
                    <div class="myList noMark">
                        <table summary="수집하는 개인정보 항목">
                            <caption>수집하는 개인정보 항목</caption>
                            <colgroup>
                                <col width="" />
                                <col width="" />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>선택</th>
                                    <th>예약날짜</th>
                                    <th>차량번호</th>
                                    <th>모델</th>
                                    <th>가격</th>
                                    <th>방문시간</th>
                                    <th>신청인</th>
                                    <th>연락처</th>
                                    <th>상태</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><input type="checkbox" class="big"></td>
                                    <td>2017.05.05</td>
                                    <td>12가1234</td>
                                    <td>그랜저</td>
                                    <td>2,000만원</td>
                                    <td>오후 11시30분</td>
                                    <td>강미랑</td>
                                    <td>010-1234-5678</td>
                                    <td><i class="redLine">대기</i></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!---->
                    <div class="paging">
                        <span class="btn prev"><a href="">이전</a></span>
                        <a href="">1</a>
                        <a href="" class="on">2</a>
                        <a href="">3</a>
                        <a href="">4</a>
                        <a href="">5</a>
                        <span class="btn next"><a href="">다음</a></span>
                    </div>
                </div>
                <div class="btn-toggle-switch-target" style="display:none;">
                    <div class="myList noMark">
                        <table summary="수집하는 개인정보 항목">
                            <caption>수집하는 개인정보 항목</caption>
                            <colgroup>
                                <col width="" />
                                <col width="" />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>선택</th>
                                    <th>예약날짜</th>
                                    <th>차량번호</th>
                                    <th>모델</th>
                                    <th>가격</th>
                                    <th>방문시간</th>
                                    <th>신청인</th>
                                    <th>연락처</th>
                                    <th>상태</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><input type="checkbox" class="big"></td>
                                    <td>2017.05.05</td>
                                    <td>12가1234</td>
                                    <td>스포티지</td>
                                    <td>2,000만원</td>
                                    <td>오후 11시30분</td>
                                    <td>강미랑</td>
                                    <td>010-1234-5678</td>
                                    <td><i class="redLine">대기</i></td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox" class="big"></td>
                                    <td>2017.05.05</td>
                                    <td>12가1234</td>
                                    <td>그랜저</td>
                                    <td>2,000만원</td>
                                    <td>오후 11시30분</td>
                                    <td>강미랑</td>
                                    <td>010-1234-5678</td>
                                    <td><i class="red">수락</i></td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox" class="big"></td>
                                    <td>2017.05.05</td>
                                    <td>12가1234</td>
                                    <td>쉐보레크루즈</td>
                                    <td>2,000만원</td>
                                    <td>오후 11시30분</td>
                                    <td>강미랑</td>
                                    <td>010-1234-5678</td>
                                    <td><i class="redLine">대기</i></td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox" class="big"></td>
                                    <td>2017.05.05</td>
                                    <td>12가1234</td>
                                    <td>SM7</td>
                                    <td>2,000만원</td>
                                    <td>오후 11시30분</td>
                                    <td>강미랑</td>
                                    <td>010-1234-5678</td>
                                    <td><i class="red">수락</i></td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox" class="big"></td>
                                    <td>2017.05.05</td>
                                    <td>12가1234</td>
                                    <td>그랜저</td>
                                    <td>2,000만원</td>
                                    <td>오후 11시30분</td>
                                    <td>강미랑</td>
                                    <td>010-1234-5678</td>
                                    <td><i class="blackLine">거절</i></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!---->
                        <div class="paging">
                            <span class="btn prev"><a href="">이전</a></span>
                            <a href="">1</a>
                            <a href="" class="on">2</a>
                            <a href="">3</a>
                            <a href="">4</a>
                            <a href="">5</a>
                            <span class="btn next"><a href="">다음</a></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>						