<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<body>
<!-- 	<div class="preloader-mask"> -->
<!-- 		<div class="preloader"></div> -->
<!-- 	</div> -->
<h3 class="menuTitle"><spring:message code="main.come_appt"/></h3>
<section id="recent" class="section schedule-section align-center">
	<div class="container">
		<div class="schedule" id="appts">
			<div class="tab-content">
				<div class="tab-content tab-content-schedule">
					<div class="tab-pane fade active in" id="main">
						<div class="panel-group">
							<div class="panel schedule-item">
							<a data-toggle="collapse" data-parent="#main_timeline" class="schedule-item-toggle collapsed" href="#main_time1" >
								<strong class="time blueColor" style="margin-left:10px;">
									<img src="/resources/img/custom/schedule-blue.png" class="scheduleIcon">
								</strong>
								<h6 class="title blueColor" style="font-size:15px;">
									<img src="/resources/img/custom/underIcon.png" class="people" style="float:right;">
								</h6>
							</a>
							<div class="panel-collapse schedule-item-body collapse" id="main_time1" style="height: 0px;border-top: 1.5px solid #405470;">
								<article class="guestArea" style="margin-left:10px;">
									<img src="/resources/img/custom/people-blue.png" class="people">
								</article>
							</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="schedule" style="display:none;" id="nullAppt">
			<div class="tab-content">
				<div class="tab-content tab-content-schedule">
					<div class="tab-pane fade active in" id="main">
						<div class="panel-group">
							<div class="panel schedule-item" style="margin-top:7%;">
								<img src="/resources/img/custom/null.png" class="scheduleIcon" style="width:12%;height:12%;margin-bottom:8% !important;display:inline-blcok;">
								<h6 class="title blueColor" style="font-size:15px;width: 80%;display: inline-block">
									<spring:message code="main.msg.there_are_no_appt"/>
									<br/><spring:message code="main.msg.lets_regist_appt"/>
								</h6>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<h3 class="subTitle"><spring:message code="main.appt_place"/></h3>
		<div id="map" style="width:90%;height:300px;display:inline-block;border-radius:7%;"></div>
		<br/>
<!-- 		<h5 class="pinkColor" id="timeStamp" style="font-size:20px;">위치공개 남은시간 00:00:00</h5> -->
		<br/>
		<a href="/front/appt/regist" class="btn btn-outline btn-md" class="login" id="registBtn"
		style="font-size: 16px;display: block;margin-bottom: 17%;margin-left: auto;margin-right: auto;"><spring:message code="main.msg.regist_appt"/></a>
	</div>
</section>
</body>
