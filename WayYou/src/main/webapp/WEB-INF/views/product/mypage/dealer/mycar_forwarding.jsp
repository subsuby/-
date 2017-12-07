<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="contents">
	<section>
		<div class="myLayout">
			<jsp:include page="mycar_menu.jsp" flush="false" />
			<!--  -->
			<div class="titBar"><!-- active 추가시 활성화 -->
				<h2>매물전송서비스 <em>매물전송서비스란, 매물공유사이트에 올린 매물을 BNK오토모아로 바로 전송하는 서비스입니다</em></h2>
				<!-- <span class="btnHelp"><em class="blind">도움말</em></span>
				<div class="popHelp">
				</div> -->
			</div>
			<!---->
			<div class="searchBox">
				<div class="box">
					<strong>차량</strong>
					<select id="makerCombo">
					</select>
					<select class="w150" id="modelCombo">
						<option value="">모델</option>
					</select>
					<input type="text" id="carRegYear" placeholder="연식" maxlength="4">
					<select id="carfuel">
						<option value="">연료</option>
						<c:forEach var="c" items="${ct:getAllValuesBean(ct:getConstDef('SYS_CODE_CAR_FUEL_TYPE'))}">
							<option value="${c.cdDtlNo}">${c.cdDtlNm}</option>
						</c:forEach>
					</select>
					<label for=""><input type="text" id="carPlateNum" placeholder="차량번호"></label>
					<button class="btnInit">초기화</button>
				</div>
				<div class="box">
					<strong>등록일</strong>
					<span class="datepicker_panel today" data-date="">
 						<input type="text" class="open_calendar add-on" id="searchStartDt" value="" readonly="readonly" />
					</span>
					<span class="caltxt">~</span>
					<span class="datepicker_panel normal" data-date="">
						<input type="text" class="open_calendar add-on" id="searchEndDt" value="" readonly="readonly" />
					</span>
					<button class="btnSearch">검색</button>
				</div>
			</div>
<!-- 			<div class="btnTab"> -->
<!-- 				<button class="choiceEnrollment">선택매물등록</button> -->
<!-- 			</div> -->
			<div id="templateList">
			</div>
		</div>
	</section>
</div>