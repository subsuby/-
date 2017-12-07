<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script>
</script>
<div class="innerLayout">
	<div class="dataSet">
		<h3 class="line">구매비용계산기</h3>
		<div class="carListHead ccCase">
			<span>발송일자</span>
			<span>딜러명</span>
			<span>차량번호</span>
			<span>제시가격</span>
			<span>제조사</span>
			<span>모델</span>
			<span>연식</span>
			<span>상세보기</span>
		</div>
		<div class="myList person makeBox bdbn">
			<table summary="목록">
				<caption>목록</caption>
				<colgroup>
					<col width="145" />
					<col width="145" />
					<col width="145" />
					<col width="145" />
					<col width="145" />
					<col width="277" />
					<col width="125" />
					<col width="128" />
				</colgroup>
				<tbody>
					<c:if test="${fn:length(costList) != 0}">
						<c:forEach var="list" items="${costList}" varStatus="status">
							<tr>
								<td>${list.createdDate}</td>
								<td>${list.userName}</td>
								<td>${list.carPlateNum}</td>
								<td><fmt:formatNumber value="${list.allSum / 10000}" pattern="#,###" /> 만원</td>
								<td>${list.carMakerName}</td>
								<td>${list.carModelName}</td>
								<td>${list.carRegyear}</td>
								<td>
									<button class="viewDetail" onclick='fn_costDetail(this, "${list.costingSeq}")'>상세보기</button>
									<div class="btn-popup-auto" data-pop-opts='{"target": ".popCostPerson","display":"false"}'></div>
									<input type="hidden" class="carFullCode" value="${list.carFullCode}" />
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${fn:length(costList) == 0}">
						<tr>
							<td colspan="8">구매비용 리스트가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		<c:if test="${fn:length(costList) != 0}">
			<div class="pagingBtn">
				<paginatorAjax:print fncName="cost_list" curPage="${curPage}" totPages="${totPages}"/>
			</div>
		</c:if>
	</div>
</div>