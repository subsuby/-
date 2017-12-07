<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="innerLayout">
	<div class="dataSet">
		<h3>메이크업</h3>
		<div class="myList person makeBox bdbn makeUpHead"> <!-- 2017-09-09 -->
			<table summary="목록">
				<caption>목록</caption>
				<colgroup>
                    <col width="150" />
                    <col width="150" />
                    <col width="150" />
                    <col width="150" />
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
				<c:forEach var="makeup" items="${makeupList}">
				<tr>
					<td>${makeup.carPlateNum}</td>
					<td>${makeup.createdDate}</td>
					<td>${makeup.label.makeupState}</td>
					<td>${makeup.visitDay}</td>
                    <%-- <c:if test="${makeup.visitAddr eq null}">
                        <td>고객센터 문의(1644-6598)</td>
                    </c:if> --%>
                    <%-- <c:if test="${makeup.visitAddr ne null}"> --%>
                        <td>${makeup.visitAddr }</td>
                    <%-- </c:if> --%>
                    <td>
                        <c:if test="${makeup.visitorTel eq null}">
                        ${makeup.visitorNm}${makeup.visitorTel}
                        </c:if>
                        <c:if test="${makeup.visitorTel ne null}">
                        ${makeup.visitorNm}(${makeup.visitorTel})
                        </c:if>
                    </td>
				</tr>
				</c:forEach>
				<c:if test="${empty makeupList}">
				<tr class="dataNone">
					<td colspan="6">
						당신의 자동차에 새로운 생명을 불어넣어 보세요.<br />
						<em>BNK만의 특화서비스 메이크업을 신청하시고<br />진행상태를 체크해보세요.</em>
					</td>
				</tr>
				</c:if>
				</tbody>
			</table>
		</div>
			<div class="pagingBtn">
				<c:if test="${fn:length(makeupList) != 0}">
					<paginatorAjax:print fncName="makeup_list" curPage="${curPage}" totPages="${totPages}"/>
				</c:if>
				<span class="btnSet">
					<span><a class="red btn-popup-auto" onclick="return false;" data-pop-opts='{"target": ".makeupAdd"}'>신청하기</a></span>
				</span>
			</div>
	</div>
</div>
<script>
// console.log("1>>>>",${makeupListArr});
</script>