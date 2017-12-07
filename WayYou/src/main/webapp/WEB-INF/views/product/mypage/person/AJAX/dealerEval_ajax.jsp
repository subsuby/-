<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<link rel="stylesheet" href="<c:url value="/product/js/rating/star/rateit.css?latest=${cssVersion}"/>" media="all" type="text/css"/>
<script type="text/javascript" src="<c:url value="/product/js/rating/star/jquery.rateit.js?latest=${jsVersion}"/>"></script>
<!-- 거래평가 -->
<h2>거래평가</h2>
<div class="dealerRating">
    <span>종합 거래평가</span><div class="rating" data-rateit-readonly="true" data-rateit-value="${eval.evalAvg}"></div><em class="point">${eval.evalAvg}</em>
    <button class="btn-popup-auto" data-pop-opts='{"target": ".appraisePop"}'>평가작성하기<i></i></button>
</div>
<div class="dealerAfter">
    <div class="btn-accordion-wrapper" data-toggle-on="true">
        <ul>
            <c:forEach var="evalList" items="${eval.dealerEvalList}" varStatus="status">
                <li class="btn-accordion-switch">
                    <div class="afterTit">
                        <div class="btn-accordion-switch-item">
                            <strong>${evalList.evalDivLabel }</strong>
                            <div>${fn:replace(evalList.reviews, newLineChar , "<br/>")}</div>
                            <span>${evaleList.createdDate }</span>
                        </div>
                    </div>
                    <div class="afterDetail">${fn:replace(evalList.reviews, newLineChar , "<br/>")}</div>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>
<div class="pagingBtn">
    <paginatorAjax:print fncName="fn_dealerEval" curPage="${curPage}" totPages="${totPages}"/>
</div>
