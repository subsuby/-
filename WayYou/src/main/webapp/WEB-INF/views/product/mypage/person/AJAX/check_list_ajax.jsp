<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script>
</script>
<div class="innerLayout bgGrayCase">
	<div class="dataSet">
		<h3 class="line">체크리스트</h3>
		<div class="carListHead checkListCase">
			<span>발송일자</span>
			<span>등급</span>
			<span>딜러명</span>
			<span>상사명</span>
			<span>전화번호</span>
			<span>상세보기</span>
		</div>
		<div class="myList person makeBox bdbn">
			<table summary="목록">
				<caption>목록</caption>
				<colgroup>
					<col width="223" />
					<col width="223" />
					<col width="223" />
					<col width="223" />
					<col width="223" />
					<col width="128" />
				</colgroup>
				<tbody>
					<c:if test="${fn:length(checkList) != 0}">
						<c:forEach var="list" items="${checkList}" varStatus="status">
							<tr>
								<td>${list.createdDate}</td>
								<td>
									<span class="levelBadge level${not empty list.gradeDealer ? list.gradeDealer : '1' }"></span>
									<strong>${list.gradeDealer eq '1' ? 'BRONZE' : list.gradeDealer eq '2' ? 'SILVER' : list.gradeDealer eq '3' ? 'GOLD' : list.gradeDealer eq '4' ? 'DIAMOND' : 'BRONZE'}</strong>
								</td>
								<td>${list.userName}</td>
								<td>${list.dealerShopName}</td>
								<td>${list.dealerVirtualNum eq null ? list.phoneMobile : list.dealerVirtualNum}</td>
								<td>
									<button class="viewDetail checkBtnDetail" onclick="fn_checkDetail(this)">상세보기</button>
									<div class="btn-popup-auto" data-pop-opts='{"target": ".checkPerson","display":"false"}'></div>
									<input type="hidden" class="items" value="${list.checkItems}" />
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${fn:length(checkList) == 0}">
						<tr>
							<td colspan="8">체크리스트가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
<%-- 		<c:if test="${fn:length(check) != 0}"> --%>
			<div class="pagingBtn">
				<paginatorAjax:print fncName="check_list" curPage="${curPage}" totPages="${totPages}"/>
			</div>
<%-- 		</c:if> --%>
	</div>
</div>