<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="myList">
<input type="hidden" class="cnt" value="${makeup.totListSize}">
	<table>
		<colgroup>
			<col width="130" />
			<col width="130" />
			<col width="130" />
			<col width="130" />
			<col width="*" />
			<col width="220" />
		</colgroup>
		<thead>
		<tr>
		    <th>차량번호</th>
		    <th>접수일자</th>
		    <th>진행단계</th>
		    <th>방문예정일자</th>
		    <th>방문지주소</th>
			<th>서비스 담당자</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${makeup.makeupList}" var="list">
		<tr>
		    <td>${list.carPlateNum}</td>
		    <td>${list.createdDate}</td>
		    <td>${list.label.makeupState}</td>
		    <td>${list.visitDay}</td>
		    <td>${list.visitAddr}</td>
		    <td><c:if test="${list.visitorTel eq null}">
                ${list.visitorNm}${list.visitorTel}
                </c:if>
                <c:if test="${list.visitorTel ne null}">
                ${list.visitorNm}(${list.visitorTel})
                </c:if>
             </td>
		</tr>
		</c:forEach>
		<c:if test="${empty makeup.makeupList}">
		<tr>
            <td colspan="6">신청내역이 없습니다.</td>
        </tr>
		</c:if>		
		</tbody>
	</table>
</div>
<!---->
<c:if test="${!empty makeup.makeupList}">
	<paginatorAjax:print fncName="mycar_makeup" curPage="${curPage}" totPages="${makeup.totPages}"/>
</c:if>