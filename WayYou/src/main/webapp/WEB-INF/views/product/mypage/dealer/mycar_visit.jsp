<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.Date" %>

<div class="contents">
	<section>
		<div class="myLayout">
			<jsp:include page="mycar_menu.jsp" flush="false" />
			<!--  -->
			<div class="titBar"><!-- active 추가시 활성화 -->
				<h2>사전방문예약관리 <em>전체 <i class="totalCnt"></i>건</em></h2>
				<!-- <span class="btnHelp"><em class="blind">도움말</em></span>
				<div class="popHelp">
				</div> -->
			</div>
			<div class="searchBox visitSearch">
				<div class="box mb0">
					<strong>신청일</strong>
					<span class="datepicker_panel today" data-date="" data-eval="mycar_visit_list(1)">
						<input type="text" class="open_calendar add-on" id="searchStartDt" value="" readonly="readonly" />
					</span>
					<span class="caltxt">~</span>
					<span class="datepicker_panel normal" data-date="" data-eval="mycar_visit_list(1)">
						<input type="text" class="open_calendar add-on" id="searchEndDt" value="" readonly="readonly" />
					</span>
					<strong class="vehicle">차량</strong>
					<label for=""><input type="text" id="carPlateNum" placeholder="차량번호"></label>
					<strong>상태</strong>
					<c:forEach var="code" items="${ct:getAllValues(ct:getConstDef('SYS_CODE_RES_STATUS'))}" varStatus="status">
						<label for="rStatus${status.index}"><input id="rStatus${status.index}" name="resStatus" type="checkbox" placeholder="차량번호" value="${code[0]}" checked onclick="mycar_visit_list(1)">${code[2]}</label>
					</c:forEach>
					<button class="btnSearch btnL">검색</button>
					<button class="btnInit">초기화</button>
				</div>
			</div>
			<div class="btn-toggle-wrapper">
				<div class="btn-toggle-switch-target" id="templateList">

				</div>
			</div>
		</div>
	</section>
</div>