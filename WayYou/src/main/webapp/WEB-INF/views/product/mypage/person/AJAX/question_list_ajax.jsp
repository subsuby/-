<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<div class="innerLayout bgGrayCase">
    <div class="dataSet">
        <h3>문의내역관리</h3>
        <div class="qnaHead">
            <span>번호</span>
            <span>제목</span>
            <span>날짜</span>
            <span>상태</span>
        </div>
        <c:if test="${fn:length(qnaList) == 0}">
            <table class="qnaArea">
                <tr class="dataNone qnaNone"><td>문의 내역이 없습니다.</td></tr>
            </table>
        </c:if>
        <c:if test="${fn:length(qnaList) != 0}">
            <div class="btn-accordion-wrapper qnaList qnaListNone" data-toggle-on="true">
                <c:forEach var="qna" items="${qnaList }" varStatus="status">
                    <dl class="btn-accordion-switch accordionSet" id="qnaAcor_${status.index }">
                        <dt class="btn-accordion-switch-item">
                            <span>${status.count }</span>
                            <span>
                                <c:choose>
                                    <c:when test="${fn:length(qna.qnaTitle) >= 35 }">
                                        <c:out value="${fn:substring(qna.qnaTitle,0,35) }..."></c:out>
                                    </c:when>
                                    <c:otherwise>${qna.qnaTitle }</c:otherwise>
                                </c:choose>
                            </span>
                            <fmt:parseDate var="dateString" value="${qna.regDt}" pattern="yyyy-MM-dd" />
                            <span><fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd" /></span>
                            <span>
                                <i class="${ct:getCodeExpString(ct:getConstDef('SYS_CODE_QNA_STATUS'),qna.qcStatus) }">
                                    ${ct:getCodeString(ct:getConstDef('SYS_CODE_QNA_STATUS'),qna.qcStatus) }
                                </i>
                            </span>
                        </dt>
                        <dd class="accordionData">
                            <p>
	                            <strong>${qna.qnaTitle}</strong>
	                            <span>${fn:replace(qna.contents, newLineChar , "<br/>")}</span>
                            </p>
                            <!-- 답변이 있을 경우 답변이 달리는 영역 -->
                            <p><strong></strong>${empty qna.answer ? '답변 대기중' : qna.answer}</p>
                        </dd>
                    </dl>
                </c:forEach>
            </div>
        </c:if>
        <c:if test="${fn:length(qnaList) != 0}">
            <div class="pagingBtn">
                <paginatorAjax:print fncName="question_list" curPage="${curPage}" totPages="${totPages }"/>
            </div>
        </c:if>
            <span class="btnSet">
                <span><a href="" class="redLine btn-popup-auto" onclick="return false;" data-pop-opts='{"target": ".popQue"}'>문의하기</a></span>
            </span>
    </div>
</div>