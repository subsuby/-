<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 비용계산기 보내기 -->
<div class="popupAutoWrap popCost p-container w670">
	<!-- popup header -->
	<div class="popupHeaderAuto">
		<header><h1>비용계산기 보내기</h1></header>
		<a class="btnClose p-close" onclick="return false;"><em class="blind">닫기</em></a>
	</div>
	<hr/>
	<!-- popup contents -->
	<div class="popupContents">
		<section>
			<div class="autoPop">
				<div class="searchArea">
					<input type="text" id="searchTxt" value="">
					<button type="button" class="iconSearch"><span>검색</span></button>
				</div>
				<div class="infoList" id="pushList">
				</div>
				<div class="btnAreaType">
					<span><button class="line p-close">취소</button></span>
					<span><button id="checkBtnSend">전송</button></span>
				</div>
			</div>
		</section>
	</div>
</div>
<!-- //비용계산기 보내기 --> 

<!-- 비용계산기 -->
<div class="popupAutoWrap popCostSetting p-container">
<!-- popup header -->
	<div class="popupHeaderAuto">
		<header><h1>비용계산기</h1></header>
		<a class="btnClose p-close" onclick="return false;" id="closeBtn"><em class="blind">닫기</em></a>
	</div>
	<hr/>
	<!-- popup contents -->
	<div class="popupContents">
		<section>
			<div class="costWrap costC1">
				<div class="myWrite">
					<div class="writeRow type1">
						<strong><label for="recv_carPlateNum">차량번호</label></strong>
						<span><input type="text" id="recv_carPlateNum" class="w150" placeholder="차량번호"><button onclick="searchClick()">적용</button></span>
					</div>
					<div class="writeRow">
						<strong><label class="text">차종</label></strong>
						<span><em class="text" id="recv_carMakerName"></em></span>
						<strong><label class="text">연식</label></strong>
						<span><em class="text" id="recv_carRegyear"></em></span>
					</div>
					<div class="writeRow">
						<strong><label class="text">국산/수입</label></strong>
						<span><em class="text" id="recv_carNationName"></em></span>
						<strong><label class="text">승용/승합/화물</label></strong>
						<span><em class="text" id="recv_carCarkindName"></em></span>
					</div>
					<div class="writeRow noLine">
						<strong><label class="text">잔존율</label></strong>
						<span><em class="text" id="recv_carRemainRate"></em></span>
						<strong><label class="text">과세표준</label></strong>
						<span><em class="text" id="recv_carStandTax"></em></span>
					</div>
				</div>

				<div class="myWrite">
					<div class="writeRow">
						<strong><label for="recv_carNewPrice">신차가격 <i class="text f_s12">VAT제외</i></label></strong>
						<span><input type="text" id="recv_carNewPrice" placeholder=""></span>
						<strong><label for="recv_carStandTax2">과세표준</label></strong>
						<span><input type="text" id="recv_carStandTax2" placeholder=""></span>
					</div>
					<div class="writeRow noLine">
						<strong><label for="recv_carSalePrice">차량구매가격</label></strong>
						<span><input type="text" id="recv_carSalePrice" placeholder=""></span>
						<strong>등록지역</strong>
						<span>
							<select id="regArea">
								<c:forEach var="c" items="${ct:getAllValuesBean(ct:getConstDef('SYS_CODE_COMM_REG_AREA'))}">
									<option value="${c.cdDtlNo}">${c.cdDtlNm}</option>
								</c:forEach>
							</select>
						</span>
					</div>
				</div>

				<div class="myWrite">
					<div class="writeRow">
						<strong>용도구분</strong>
						<span>
							<select id="useDiv">
								<c:forEach var="c" items="${ct:getAllValuesBean(ct:getConstDef('SYS_CODE_COMM_CAR_USE_DIV'))}">
									<option value="${c.cdDtlNo}">${c.cdDtlNm}</option>
								</c:forEach>
<!-- 								<option>비영업용(자가용)</option> -->
<!-- 								<option>영업용</option> -->
<!-- 								<option>이륜차</option> -->
							</select>
						</span>
						<strong>차종구분</strong>
						<span>
							<select id="carDiv">
								<c:forEach var="c" items="${ct:getAllValuesBean(ct:getConstDef('SYS_CODE_COMM_CAR_DIV'))}">
									<option value="${c.cdDtlNo}">${c.cdDtlNm}</option>
								</c:forEach>
<!-- 								<option>경차</option> -->
<!-- 								<option>승용차</option> -->
<!-- 								<option>승합차</option> -->
<!-- 								<option>화물차</option> -->
							</select>
						</span>
					</div>
					<div class="writeRow noLine">
						<strong>상세차량구분</strong>
							<span>
								<select id="carDetailDiv">
									<c:forEach var="c" items="${ct:getAllValuesBean(ct:getConstDef('SYS_CODE_COMM_CAR_DETAIL_DIV'))}">
										<option value="${c.cdDtlNo}">${c.cdDtlNm}</option>
									</c:forEach>
<!-- 									<option>1500CC 미만</option> -->
<!-- 									<option>1600CC 미만</option> -->
<!-- 									<option>2000CC 미만</option> -->
<!-- 									<option>2000CC 이상</option> -->
								</select>
							</span>
							<strong><label for="default_recv_carMortgage">저당비용</label></strong>
							<span><input type="text" id="default_recv_carMortgage" placeholder=""></span>
					</div>
				</div>

				<div class="myWrite">
					<div class="writeRow">
						<strong><label for="default_recv_carRecognition">인지대</label></strong>
						<span><input type="text" id="default_recv_carRecognition" placeholder=""></span>
						<strong><label for="default_recv_carStampCost">증지대</label></strong>
						<span><input type="text" id="default_recv_carStampCost" placeholder=""></span>
					</div>
					<div class="writeRow">
						<strong><label for="default_recv_carNumberCost">번호판교체</label></strong>
						<span><input type="text" id="default_recv_carNumberCost" placeholder=""></span>
						<strong><label for="default_recv_carRegAgency">등록대행료</label></strong>
						<span><input type="text" id="default_recv_carRegAgency" placeholder=""></span>
					</div>
					<div class="writeRow type1 last">
						<strong><label for="default_recv_carManageCost">관리비용</label></strong>
						<span><input type="text" id="default_recv_carManageCost" class="w150" placeholder=""></span>
					</div>
				</div>

				<div class="btnAreaType">
					<span><button class="line" id="costInit">초기화</button></span>
					<span><button id="costDo" onclick="costDo">계산하기</button></span>
				</div>
			</div>
					
			<div class="costWrap costC2" id="registCost" style="display:none">
				<div class="myWrite">
					<div class="writeRow type4">
						<strong>구매차량정보</strong>
						<input type="hidden" value="" id="carFullCd">
					</div>
					<div class="writeRow">
	                     <strong><label>차량번호</label></strong>
						<span><em id="carNum"></em></span>
	                     <strong><label>차종</label></strong>
						<span><em id="carModel2"></em></span>
					</div>
					<div class="writeRow">
	                     <strong><label>연식</label></strong>
						<span><em id="carRegYear2"></em></span>
	                     <strong><label>국산/수입</label></strong>
						<span><em id="carNation2"></em></span>
					</div>
					<div class="writeRow">
	                     <strong><label>승용/승합/화물</label></strong>
						<span><em id="carKind2"></em></span>
	                     <strong><label>잔존율</label></strong>
						<span><em id="carRemainRate2"></em></span>
					</div>
					<div class="writeRow">
	                     <strong><label>과세표준</label></strong>
						<span><em id="carStandTax2"></em></span>
	                     <strong><label>등록지역</label></strong>
						<span><em id="regArea2"></em></span>
					</div>
					<div class="writeRow">
	                     <strong><label>신차가격</label></strong>
						<span><em id="newCarPrice"></em></span>
	                     <strong><label>용도구분</label></strong>
						<span><em id="useDiv2"></em></span>
					</div>
					<div class="writeRow last">
	                     <strong><label>차량구매가격</label></strong>
						<span><em id="carSalePrice2"></em></span>
	                     <strong><label id="carDiv2"></label></strong>
						<span><em id="carDetailDiv2"></em></span>
					</div>
					<div class="writeRow type4">
						<strong>이전등록비용</strong>
					</div>
					<div class="writeRow type1">
						<strong><label>취등록세</label></strong>
						<span><em id="regCost"></em></span>
					</div>
					<div class="writeRow">
	                     <strong><label>공채할인비</label></strong>
						<span><em id="fundCost"></em></span>
	                     <strong><label>인지대</label></strong>
						<span><em id="carRecognition"></em></span>
					</div>
					<div class="writeRow">
	                     <strong><label>증지대</label></strong>
						<span><em id="carStampCost"></em></span>
	                     <strong><label>번호판교체</label></strong>
						<span><em id="carNumberCost"></em></span>
					</div>
					<div class="writeRow type1 last">
	                     <strong><label>합계</label></strong>
						<span><em id="moveCostSum"></em></span>
					</div>
					<div class="writeRow type4">
						<strong>매매상사 부대비용</strong>
					</div>
					<div class="writeRow type1">
	                     <strong><label>저당비용</label></strong>
						<span><em id="carMortgage"></em></span>
					</div>
					<div class="writeRow">
	                     <strong><label>등록대행료</label></strong>
						<span><em id="carRegAgency"></em></span>
	                     <strong><label>관리비용</label></strong>
						<span><em id="carManageCost"></em></span>
					</div>
					<div class="writeRow type1 last">
	                     <strong><label>합계</label></strong>
						<span><em id="etcCostSum"></em></span>
					</div>
					<div class="writeRow type1 last">
						<strong>총구매비용합계</strong>
						<span><em id="allSum"></em></span>
					</div>
				</div>
				<div class="btnAreaType">
					<span><button class="line" id="reCal">다시 계산하기</button>
<!-- 					<span><button class="btn-popup-auto" onclick="return false;" data-pop-opts='{"target": ".popCost"}'>전송하기</button></span> -->
				
					<a href="" class="red plr15" id="btnSend" onclick="return false;">전송하기</a>
					<div class="btn-popup-auto" data-pop-opts='{"target": ".popCost","display":"false"}'></div></span>
				</div>
			</div>
		</section>
	</div>
</div>
<!--   //비용계산기  -->