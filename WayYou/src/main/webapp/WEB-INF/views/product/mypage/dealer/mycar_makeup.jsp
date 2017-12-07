<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="contents">
	<section>
		<div class="myLayout">
			<jsp:include page="mycar_menu.jsp" flush="false" />
			<!--  -->
			<div class="titBar"><!-- active 추가시 활성화 -->
				<h2>메이크업 <em>전체 <i class="totalCnt"></i>건</em></h2>
				<!-- <span class="btnHelp"><em class="blind">도움말</em></span>
				<div class="popHelp"></div> -->
			</div>
			<div class="searchBox">
                <div class="box">
                    <strong>차량번호</strong>
                    <label for=""><input type="text" id="carPlateNum" placeholder="차량번호"></label>
                    <button class="btnInit" id="btnClear">초기화</button>
                </div>
				<div class="box">
					<strong>접수일</strong>
					<span class="datepicker_panel today" data-date="">
						<input type="text" class="open_calendar add-on" id="searchStartDt" value="" readonly="readonly" />
					</span>
					<span class="caltxt">~</span>
					<span class="datepicker_panel normal" data-date="">
						<input type="text" class="open_calendar add-on" id="searchEndDt" value="" readonly="readonly" />
					</span>
					<button class="btnSearch" id="btnSearch">검색</button>
				</div>
			</div>
			<div class="btn-toggle-wrapper">
				<div class="btnTab case1 grid4">
					<button onclick="return false;" class="enrollment btn-popup-auto" data-pop-opts='{"target": ".makeupAdd"}'>신청하기</button>
				</div>
				<div class="btn-toggle-switch-target" id="templateList">

				</div>
			</div>
		</div>
	</section>
</div>
