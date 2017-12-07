<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="myList sendCase">
	<table summary="명함 발송이력 항목">
		<caption>명함 발송이력 항목</caption>
		<colgroup>
			<col width="" />
			<col width="" />
			<col width="" />
			<col width="200" />
		</colgroup>
		<thead>
			<tr>
				<th>발송일자 </th>
				<th>고객명</th>
				<th>연락처</th>
				<th>재발송</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${cardList.businesscardList}" var="list">
			<fmt:parseDate var="sendDate" value="${list.sendDate}" pattern="yyyy-MM-dd"/>
			<tr>
				<td><fmt:formatDate value="${sendDate}" pattern="yyyy.MM.dd"/> </td>
				<td>${ct:nameAsterisk(list.userName)}</td>
				<td>${list.phoneMobile}</td>
				<td>
					<span class="btnSet">
						<span><input type="button" value="재발송" class="red" onclick="resendCard(${list.userId})" /></span>
					</span>
				</td>
			</tr>
		</c:forEach>
		<c:if test="${empty cardList.businesscardList}">
			<tr>
				<td colspan="4">발송된 명함이 없습니다.</td>
			</tr>
		</c:if>
		</tbody>
	</table>
</div>
<!---->
<c:if test="${!empty cardList.businesscardList}">
	<paginatorAjax:print fncName="mycar_businesscard_list" curPage="${curPage}" totPages="${cardList.totPages}"/>
</c:if>
