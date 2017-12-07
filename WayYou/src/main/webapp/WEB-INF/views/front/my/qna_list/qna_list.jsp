<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
	<div class="quesLayout">
		<div class="btn-accordion-wrapper qnaList" data-toggle-on="true">
			<dl class="btn-accordion-switch accordionSet" ng-repeat="question in list" ng-init="$last && resInit()">
				<dt class="accordionTitle btn-accordion-switch-item">
					<i class="accepting" ng-if="question.qcStatus == '10'">답변대기중</i>
 					<i class="complete" ng-if="question.qcStatus == '20'">답변완료</i>
					<strong>{{question.qnaTitle}}</strong>
					<em>작성일 {{question.regDt.substring(0,10)}}</em>
					<em ng-if="question.answerDt != null">답변일 {{question.answerDt.substring(0,10)}}</em>
				</dt>
				<dd class="accordionData">
					<p class="txtQ">
						<strong>[제목] {{question.qnaTitle}}</strong><br/>
						<span ng-bind-html="question.contents | newLine"></span>
					</p>
					<p class="txtA" ng-if="question.answer != null">
						<span ng-bind-html="question.answer | newLine"></span>
					</p>
				</dd>
			</dl>
		</div>
		<div style="width:100%" class="bnk_loading more" ng-hide="oPageInfo.bHasMore == false || bShowEmpty === true"></div>
		<div class="noRecord" ng-show="list && list.length === 0">문의내역이 없습니다.</div> <!-- 2017-06-18 -->
		<div class="btnSet pd11">
			<span><button class="red" ng-click='onClick()'>신규신청</button></span>
<!-- 			<span><button class="red btn-popup-full" data-pop-opts='{"target": ".popWrapQWrite"}'>신규신청</button></span> -->
		</div>
	</div>
</section>