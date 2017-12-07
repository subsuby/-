<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="myList">
<input type="hidden" class="cnt" value="${car.cnt}">
	<table>
		<colgroup>
			<col width="100" />
			<col width="" />
			<col width="" />
			<col width="60" />
			<col width="100" />
			<col width="80" />
			<col width="80" />
			<col width="80" />
			<col width="160" />
			<col width="90" />
		</colgroup>
		<thead>
			<tr>
				<th>등록일자</th>
				<th>제조사</th>
				<th>모델</th>
				<th>연식</th>
				<th>주행거리</th>
				<th>연료</th>
				<th>차량번호</th>
				<th>가격</th>
				<th>태그</th>
				<th>판매완료</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${car.carList}" var="list">
		<fmt:parseDate var="dateString" value="${list.applyDay}" pattern="yyyyMMdd" />
		<tr>
		    <td><fmt:formatDate value="${dateString}" pattern="yyyy.MM.dd" /></td>
		    <td>${list.label.makerName}</td>
		    <td>
		    	<a class="txtDeco" onclick="mycar_detail_pop(this, '${list.carSeq}')" >${list.label.modelName}</a>
		    	<input type="hidden" class="btn-popup-auto" data-pop-opts='{"target": ".popCarModfy"}'/>
		    </td>
		    <td>${list.carRegYear}</td>
		    <td><fmt:formatNumber value="${list.useKm}" pattern="#,###" />km</td>
		    <td>${list.label.carFuel}</td>
		    <td>${list.carPlateNum}</td>
		    <td><fmt:formatNumber value="${list.saleAmt}" pattern="#,###" />만원</td>
		    <td>
		   	<c:if test="${list.carGuarRefundYn == 'Y'}">
		       <i class="markSet mark2">환불</i>
		   	</c:if>
		   	<c:if test="${list.carGuarFruitlessYn == 'Y'}">
		       <i class="markSet mark3">헛걸음</i>
		   	</c:if>
		   	<c:if test="${list.carGuarTermYn == 'Y'}">
		       <i class="markSet mark4">연장</i>
		   	</c:if>
		    </td>
		    <td>
		    	<input type="hidden" value="${list.carSeq}"/>
		    	<button class="blackLine" onclick="btnComplete(${list.carSeq})">판매완료</button>
		    </td>
		</tr>
		</c:forEach>
		<c:if test="${empty car.carList}">
			<tr>
				<td colspan="10">등록된 매물이 없습니다.</td>
			</tr>
		</c:if>
		</tbody>
	</table>
</div>
<!---->
<c:if test="${!empty car.carList}">
	<paginatorAjax:print fncName="mycar_list" curPage="${curPage}" totPages="${car.totPages}"/>
</c:if>