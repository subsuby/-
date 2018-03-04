<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<section>
	<div class="calendar-header">
		<div class="calendarTitle">
			<div class="calendar-left-icon" onclick="CalendarScript.changeMonth('last')"></div>
			<span class="calendarMonth pinkColor"></span>
			<div class="calendar-right-icon" onclick="CalendarScript.changeMonth('next')"></div>
		</div>
		<strong class="calendarDate pinkColor"></strong>
		<span class="scheduleArea pinkColor"></span>
	</div>
	<div class="calendar-body">
		<div class="calendar-comment">
			<strong class="pinkComment">&nbsp;&nbsp;<spring:message code="calendar.choosen_date"/></strong>
			<div class="calendarCircle"></div>
		</div>
		<div class="calendar-comment">
			<strong class="pinkComment">&nbsp;&nbsp;<spring:message code="calendar.is_exist_appt_date"/></strong>
			<div class="calendar-underline"></div>
		</div>
		<div class="calendar-days">
			<div class="calendar-day">SUN</div>
			<div class="calendar-day">MON</div>
			<div class="calendar-day">TUE</div>
			<div class="calendar-day">WED</div>
			<div class="calendar-day">THU</div>
			<div class="calendar-day">FRI</div>
			<div class="calendar-day">SAT</div>
		</div>
		<div class="calendar-dates">
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
		</div>
		<div class="calendar-dates">
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
		</div>
		<div class="calendar-dates">
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
		</div>
		<div class="calendar-dates">
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
		</div>
		<div class="calendar-dates">
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
			<div class="calendar-date"></div>
		</div>
		<div class="calendar-links">
			<div class="calendar-link-title"><spring:message code="calendar.on_choosen_date"/></div>
			<div class="calendar-link" onclick="CalendarScript.checkAppt()">
				<div class="calendar-link-icon"></div>
				<div class="calendar-link-comment"><spring:message code="calendar.confirm_appt"/></div>
			</div>
<!-- 			<div class="calendar-link" onclick="CalendarScript.registAppt()"> -->
<!-- 				<div class="calendar-link-icon"></div> -->
<!-- 				<div class="calendar-link-comment">약속 등록하기</div> -->
<!-- 			</div> -->
<!-- 			<div class="calendar-link"> -->
<!-- 				<div class="calendar-link-icon"></div> -->
<!-- 				<div class="calendar-link-comment">약속 상세보기</div> -->
<!-- 			</div> -->
		</div>
	</div>
</section>