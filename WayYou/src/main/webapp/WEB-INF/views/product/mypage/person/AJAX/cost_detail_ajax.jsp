<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="writeRow type4">
	<strong>구매차량정보</strong>
</div>
<div class="writeRow">
     <strong><label>차량번호</label></strong>
	<span><em id="carNum">${costInfo.getCostDetail.carPlateNum}</em></span>
     <strong><label>차종</label></strong>
	<span><em id="carModel">${costInfo.getCostDetail.carMakerName} &nbsp; ${costInfo.getCostDetail.carModelName}</em></span>
</div>
<div class="writeRow">
     <strong><label>연식</label></strong>
	<span><em id="carRegYear">${costInfo.getCostDetail.carRegyear}</em></span>
     <strong><label>국산/수입</label></strong>
	<span><em id="carNation"></em>${costInfo.getCostDetail.carNationName}</span>
</div>
<div class="writeRow">
     <strong><label>승용/승합/화물</label></strong>
	<span><em id="carKind">${costInfo.getCostDetail.carDivName}</em></span>
     <strong><label>잔존율</label></strong>
	<span><em id="carRemainRate">${costInfo.getCostDetail.carRemainRate}</em></span>
</div>
<div class="writeRow">
     <strong><label>과세표준</label></strong>
	<span><em id="carStandTax"><fmt:formatNumber value="${costInfo.getCostDetail.carStandTax}" pattern="#,###" /></em></span>
     <strong><label>등록지역</label></strong>
	<span><em id="regArea">${costInfo.getCostDetail.carRegAreaName}</em></span>
</div>
<div class="writeRow">
     <strong><label>신차가격</label></strong>
	<span><em id="newCarPrice"><fmt:formatNumber value="${costInfo.getCostDetail.carNewPrice}" pattern="#,###" /></em></span>
     <strong><label>용도구분</label></strong>
	<span><em id="useDiv">${costInfo.getCostDetail.carUseName}</em></span>
</div>
<div class="writeRow last">
     <strong><label>차량구매가격</label></strong>
	<span><em id="carSalePrice"><fmt:formatNumber value="${costInfo.getCostDetail.carSalePrice}" pattern="#,###" /></em></span>
     <strong><label id="carDiv">${costInfo.getCostDetail.carDivName}</label></strong>
	<span><em id="carDetailDiv">${costInfo.getCostDetail.carDetailDivName}</em></span>
</div>
<div class="writeRow type4">
	<strong>이전등록비용</strong>
</div>
<div class="writeRow type1">
	<strong><label>취등록세</label></strong>
	<span><em id="regCost"><fmt:formatNumber value="${costInfo.getCostDetail.regCost}" pattern="#,###" /></em></span>
</div>
<div class="writeRow">
     <strong><label>공채할인비</label></strong>
	<span><em id="fundCost"><fmt:formatNumber value="${costInfo.getCostDetail.fundCost}" pattern="#,###" /></em></span>
     <strong><label>인지대</label></strong>
	<span><em id="carRecognition"><fmt:formatNumber value="${costInfo.getCostDetail.carRecognition}" pattern="#,###" /></em></span>
</div>
<div class="writeRow">
     <strong><label>증지대</label></strong>
	<span><em id="carStampCost"><fmt:formatNumber value="${costInfo.getCostDetail.carStampCost}" pattern="#,###" /></em></span>
     <strong><label>번호판교체</label></strong>
	<span><em id="carNumberCost"><fmt:formatNumber value="${costInfo.getCostDetail.carNumberCost}" pattern="#,###" /></em></span>
</div>
<div class="writeRow type1 last">
     <strong><label>합계</label></strong>
	<span><em id="prevRegSum"><fmt:formatNumber value="${costInfo.getCostDetail.moveCostSum}" pattern="#,###" /></em></span>
</div>
<div class="writeRow type4">
	<strong>매매상사 부대비용</strong>
</div>
<div class="writeRow type1">
     <strong><label>저당비용</label></strong>
	<span><em id="carMortgage"><fmt:formatNumber value="${costInfo.getCostDetail.carMortgage}" pattern="#,###" /></em></span>
</div>
<div class="writeRow">
     <strong><label>등록대행료</label></strong>
	<span><em id="carRegAgency"><fmt:formatNumber value="${costInfo.getCostDetail.carRegAgency}" pattern="#,###" /></em></span>
     <strong><label>관리비용</label></strong>
	<span><em id="carManageCost"><fmt:formatNumber value="${costInfo.getCostDetail.carManageCost}" pattern="#,###" /></em></span>
</div>
<div class="writeRow type1 last">
     <strong><label>합계</label></strong>
	<span><em id="etcCostSum"><fmt:formatNumber value="${costInfo.getCostDetail.etcCostSum}" pattern="#,###" /></em></span>
</div>
<div class="writeRow type1 last">
	<strong>총구매비용합계</strong>
	<span><em id="allSum"><fmt:formatNumber value="${costInfo.getCostDetail.allSum}" pattern="#,###" /></em></span>
</div>
