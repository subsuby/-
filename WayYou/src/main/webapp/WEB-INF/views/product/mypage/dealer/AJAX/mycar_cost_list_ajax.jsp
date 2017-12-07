<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="myList">
<input type="hidden" class="cnt" value="${cost.cnt}">
	<table>
		<colgroup>
			<col width="" />
			<col width="" />
			<col width="" />
			<col width="" />
			<col width="" />
			<col width="" />
			<col width="" />
			<col width="120" />
		</colgroup>
		<thead>
        <tr>
            <th>발송일자</th>
            <th>고객명</th>
            <th>차량번호</th>
            <th>제시가격</th>
            <th>제조사</th>
            <th>모델</th>
            <th>연식</th>
            <th>상세보기</th>
        </tr>
		</thead>
		<tbody>
		<c:forEach items="${cost.costList}" var="list">
		<tr>
		    <td>${list.createdDate}</td>
		    <td>${ct:nameAsterisk(list.userName)}</td>
		    <td>${list.carPlateNum}</td>
		    <td><fmt:formatNumber value="${list.allSum / 10000}" pattern="#,###" /> 만원</td>
		    <td>${list.carMakerName}</td>
		    <td>${list.carModelName}</td>
		    <td>${list.carRegyear}</td>
		    <td>
		    	<button class="costBtnDetail listView">상세보기</button>
		    	<div class="btn-popup-auto" data-pop-opts='{"target": ".popCostView","display":"false"}'></div>
				<input type="hidden" class="costSeq" value="${list.costingSeq}" />
				<input type="hidden" class="carFullCode" value="${list.carFullCode}" />
			</td>
		</tr>
		</c:forEach>
		<c:if test="${empty cost.costList}">
			<tr>
				<td colspan="8">발송된 비용계산이 없습니다.</td>
			</tr>
		</c:if>
		</tbody>
	</table>
</div>
<!---->
<c:if test="${!empty cost.costList}">
	<paginatorAjax:print fncName="mycar_cost_list" curPage="${curPage}" totPages="${cost.totPages}"/>
</c:if>