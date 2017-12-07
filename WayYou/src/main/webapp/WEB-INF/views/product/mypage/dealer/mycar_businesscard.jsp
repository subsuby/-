<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="contents">
	<section>
		<div class="myLayout">
			<jsp:include page="mycar_menu.jsp" flush="false" />
			<!--  -->
			<div class="titBar"><!-- active 추가시 활성화 -->
				<h2>명함관리</h2>
				<!-- <span class="btnHelp"><em class="blind">도움말</em></span>
				<div class="popHelp"></div> -->
			</div>
			<div class="searchBox">
				<div class="box mb0">
					<strong class="mr15">전화번호</strong>
					<label for=""><input type="text" id="personPhone" class="w240" placeholder="전화번호" onkeydown="onKeyDown(this, 'PHONE', event)" onblur="onBlur(this, 'PHONE', event)"></label>
					<strong class="ml50">고객명</strong>
					<label for=""><input type="text" id="personName" placeholder="고객명" onkeydown="onKeyDown(this, 'NAME', event)" onblur="onBlur(this, 'NAME', event)"></label></label>
					<button class="btnSearch btnL">검색</button>
					<button class="btnInit">초기화</button>
				</div>
			</div>
			<!---->
			<div class="btnTab">
<!-- 				<button class="btnL">명함발송</button> -->
<!-- 				<button class="enrollment">명함수정</button> -->
				<button class="btnL btn-popup-auto" onclick="return false;" data-pop-opts='{"target": ".popCard"}'>명함발송</button>

<!--  				<button class="enrollment btn-popup-auto" onclick="return false;" data-pop-opts='{"target": ".popCardModify"}'>명함수정</button> -->

 				<button class="" id="nameCardModBtn" onclick="return false;" >명함수정</button>
 				<div class="enrollment btn-popup-auto" style="display: none;" data-pop-opts='{"target": ".popCardModify","display":"false"}'></div>


			</div>
			<div id="templateList"></div>
		</div>
	</section>
</div>