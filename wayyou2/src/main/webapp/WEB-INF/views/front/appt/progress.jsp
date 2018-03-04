<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<section>
	<div class="searchArea" id="apptTitle">
		<h3 class="menuTitle"><spring:message code="progress.progress_appt"/></h3>
		<input type="button" value="<spring:message code='progress.search'/>" class="btn btn-search btn-outline" onclick="ProgressScript.search()">
		<input type="text" placeholder="<spring:message code='progress.search'/>" class="searchBox">
		<input type="text" id="datePicker" class="datePicker searchBox" placeholder="<spring:message code='progress.date'/>" readonly/>
		<input type="button" value="<spring:message code='progress.reset'/>" class="btn btn-reset btn-outline" onclick="ProgressScript.reset()">
	</div>
	<div class="schedule" id="schedule">
	</div>
	<div class="schedule" style="display:none;" id="nullAppt">
		<div class="tab-content">
			<div class="tab-content tab-content-schedule">
				<div class="tab-pane fade active in" id="main">
					<div class="panel-group">
						<div class="panel schedule-item" style="margin-top:7%;">
							<img src="/resources/img/custom/null.png" class="scheduleIcon" style="width:12%;height:12%;margin-bottom:8% !important;display:inline-blcok;">
							<h6 class="title blueColor" style="font-size:15px;width: 80%;display: inline-block">
								<spring:message code="progress.msg.there_are_no_appt"/> 
								<br/><spring:message code="progress.msg.lets_regist_appt"/>
							</h6>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<a href="/front/appt/regist" class="btn btn-outline btn-md" class="login" id="registBtn"
		style="font-size: 16px;display: block;margin-bottom: 4%;margin-left: auto;margin-right: auto;"><spring:message code="progress.regist_appt"/></a>
</section>
<p class="description blueColor smallClone">
</p>
<div class="tab-content clone">
	<!-- Day 1 content start -->
	<div class="tab-content tab-content-schedule">
		<div class="tab-pane fade active in tabId">
			<div class="panel-group">
				<div class="panel schedule-item">
					<a data-toggle="collapse" class="schedule-item-toggle collapsed tabParent tabHref">
						<strong class="time blueColor"></strong>
						<h6 class="title blueColor"></h6>
					</a>
				</div>
			</div>
		</div>
	</div>
</div>