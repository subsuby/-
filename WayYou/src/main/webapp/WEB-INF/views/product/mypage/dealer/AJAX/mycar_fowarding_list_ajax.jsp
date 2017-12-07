<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="myList noMark">
<table summary="수집하는 개인정보 항목">
    <caption>수집하는 개인정보 항목</caption>
    <colgroup>
        <col width="" />
        <col width="" />
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
            <th>상태</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${fowarding.fowardingList}" var="list">
        <fmt:parseDate var="dateString" value="${list.carRegDay}" pattern="yyyyMMdd" />
	        <tr>
	            <td><fmt:formatDate value="${dateString}" pattern="yyyy.MM.dd" /></td>
	            <td>${list.label.makerName}</td>
	            <td>${list.label.modelName}</td>
	            <td>${list.carRegYear}</td>
	            <td><fmt:formatNumber value="${list.useKm}" pattern="#,###" />km</td>
	            <td>${list.carFuel}</td>
	            <td>${list.carPlateNum}</td>
	            <td><fmt:formatNumber value="${list.saleAmt}" pattern="#,###" />만원</td>
            	<td>
					<input type="button" value="전송하기" onclick='goRegist(${ct:toJson(list)})'/>
				</td>
			</tr>
        </c:forEach>
        <c:if test="${empty fowarding.fowardingList}">
			<tr>
				<td colspan="9">전송할 매물이 없습니다.</td>
			</tr>
		</c:if>
    </tbody>
</table>
</div>
<!---->
<c:if test="${!empty fowarding.fowardingList}">
	<paginatorAjax:print fncName="mycar_fowarding_list" curPage="${curPage}" totPages="${fowarding.totPages}"/>
</c:if>