<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="myList qnaManage">
	<table summary="수집하는 개인정보 항목" class="btn-accordion-wrapper" data-toggle-on="true">
	    <caption>수집하는 개인정보 항목</caption>
	    <colgroup>
	        <col width="80" />
	        <col width="" />
	        <col width="100" />
	        <col width="100" />
	        <col width="100" />
	    </colgroup>
	    <thead>
	        <tr>
	            <th>번호</th>
	            <th>내용</th>
	            <th>등록일</th>
	            <th>글쓴이</th>
	            <th>답변여부</th>
	        </tr>
	    </thead>
	    <tbody>
	    	<script>
	    		console.log(${ct:toJson(qnaList)});
	    		$(function(){ $('#questionCount').html('${totListSize}'); });		//전체갯수출력
	    	</script>
	    	<c:forEach var="qna" items="${qnaList}" varStatus="status">
	        <tr>
	            <td>${totListSize - status.index}</td>
	            <td class="qnaArea">
					<dl class="btn-accordion-switch accordionSet">
						<dt class="btn-accordion-switch-item">${fn:length(qna.qnaTitle) > 30 ? fn:substring(qna.qnaTitle, 0, 30) += '...' : qna.qnaTitle}</dt>
						<dd class="accordionData">${qna.contents}</dd>
						<c:forEach var="answer" items="${qna.answerList}">
							<dd class="answerArea accordionData">${answer.contents}</dd>
						</c:forEach>
						<c:if test="${fn:length(qna.answerList) == 0}">
							<dd class="answerArea accordionData">답변을 기다리는 중 입니다</dd>
						</c:if>
					</dl>
				</td>

	            <td><fmt:parseDate var="regDt" value="${qna.regDt}" pattern="yyyy-MM-dd"/><fmt:formatDate value="${regDt}" pattern="yyyy-MM-dd"/></td>

	            <td>${qna.regId}</td>
				<td>
					<c:if test="${ct:equals(qna.qcStatus, '10')}">
					<button class="red" onclick='onClick("QNA_REGIST_POP", ${ct:toJson(qna)})'>답변대기</button>
					<input id="qnaPop" type="hidden" class="btn-popup-auto" data-pop-opts='{"target": ".popQue"}'/>
					</c:if>
					<c:if test="${ct:equals(qna.qcStatus, '20')}">
					<button class="redLine">답변완료</button>
					</c:if>
				</td>
	        </tr>
	    	</c:forEach>
	    	<c:if test="${empty qnaList}">
	        <tr>
	            <td colspan="10">등록된 문의내역이 없습니다.</td>
	        </tr>
	    	</c:if>
	    </tbody>
	</table>
</div>
<paginatorAjax:print fncName="mycar_qna_list" curPage="${curPage}" totPages="${totPages}"/>