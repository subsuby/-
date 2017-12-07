<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="contents">
    <section>
        <div class="myLayout">
            	<jsp:include page="mycar_menu.jsp" flush="false" />
                <div class="titBar"><!-- active 추가시 활성화 -->
                    <h2>문의내역관리 <em>전체 <i class="totalCnt" id="questionCount"></i>건</em></h2>
                    <span class="btnHelp"><em class="blind">도움말</em></span>
                    <div class="popHelp">
                    </div>
                </div>
                <div class="searchBox">
                    <div class="box mb0">
                        <strong>글쓴이</strong>
						<span class="mr15">
							<label for=""><input id="userName" type="text" id="" placeholder="글쓴이" onkeypress="onKeyPress(event)"></label>
						</span>
                        <strong>등록일</strong>
                        <jsp:useBean id="now" class="java.util.Date"/>
                        <fmt:formatDate var="startDate" value="${now}" pattern="yyyy-MM-dd"/>
                        <fmt:formatDate var="startDay" value="${now}" pattern="dd"/>
                        <fmt:formatDate var="endDate" value="${now}" pattern="yyyy-MM-"/>

                        <span class="datepicker_panel today" data-date="${startDate}">
                            <input type="text" class="open_calendar add-on" id="searchStartDt" value="" readonly="readonly" />
                        </span>
                        <span class="caltxt">~</span>
                        <span class="datepicker_panel normal" data-date="${endDate}${startDay+30}">
                            <input type="text" class="open_calendar add-on" id="searchEndDt" value="" readonly="readonly" />
                        </span>
                        <button class="btnSearch btnL" onclick="mycar_qna_list(1)">검색</button>
                        <button class="btnInit" onclick="initSearch()">초기화</button>
                    </div>
                </div>
                <!---->
                <div id="qnaList" class="myList qnaManage"></div>
                <!---->

            </div>
        </div>
    </section>
</div>
<!-- //contents -->