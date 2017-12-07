<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="myList sendCase">
	<table summary="체크리스트 발송이력 항목">
		<caption>체크리스트 발송이력 항목</caption>
		<colgroup>
			<col width="" />
			<col width="" />
			<col width="" />
			<col width="200" />
		</colgroup>
		<thead>
			<tr>
				<th>발송일자</th>
				<th>고객명</th>
				<th>연락처</th>
				<th>상세보기</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${check.checkList}" var="list">
			<tr>
				<td>${list.createdDate}</td>
				<td>${ct:nameAsterisk(list.userName)}</td>
				<td>${list.phoneMobile}</td>
				<td>
					<span class="btnSet">
						<span>
							<input type="button" class="listView checkBtnDetail" value="상세보기" />
							<div style="display: none;" class="btn-popup-auto" data-pop-opts='{"target": ".checkListDetail","display":"false"}'></div>
							<input type="hidden" class="items" value="${list.checkItems}" />
						</span>
					</span>
				</td>
			</tr>
		</c:forEach>
		<c:if test="${empty check.checkList}">
			<tr>
				<td colspan="4">발송 이력이 없습니다.</td>
			</tr>
		</c:if>
		</tbody>
	</table>
</div>
<!---->
<c:if test="${!empty check.checkList}">
	<paginatorAjax:print fncName="mycar_check_list" curPage="${curPage}" totPages="${check.totPages}"/>
</c:if>
