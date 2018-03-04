<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
$( document ).ready(function() {
	//초기화
	CalendarScript.init();
});

CalendarScript = {
	//검색날짜
	date : {},
	//초기화
	init : function(){
		var d = CommonScript.getToday();
		CalendarScript.date = d;
		//상단 날짜 입력
		CalendarScript.getTitleDate(d);
		//하단 날짜 구성하기
		CalendarScript.getMonthDates(d);
		//오늘날짜의 일정 검색
		CalendarScript.getSchedule();
	},
	getSchedule : function(){
		//리스트 호출
		$.ajax({
			url : '/front/appt/calendar/api',
			type : 'POST',
			dataType : 'json',
			data : CalendarScript.date,
			success:function(data){
				var calendar = data.calendar;
				CalendarScript.makeUnderline(calendar);
			},
			error : function(data, status, er) {
				CommonScript.errorPop('<spring:message code="calendar.calendar"/>','<spring:message code="calendar.msg.eroor_calendar_data_retry"/>')
				console.log("error: " + JSON.stringify(data) + " status: " + status + " er:" + er);
			}
		})
	},
	getTitleDate : function(d){
		$('.calendarMonth').children().remove();
		$('.calendarMonth').text('');
		$('.calendarMonth').append(d.year+'<spring:message code="calendar.year"/> '+'<strong>'+d.engMonth+'</strong> '+d.month+'<spring:message code="calendar.month"/>');
		$('.calendarDate').text('');
		$('.calendarDate').append(d.dates+'<spring:message code="calendar.day"/>');
	},
	getMonthDates : function(d){
		//날짜 오브젝트
		var dates1 = new Array();
		var dates2 = new Array();
		var dates3 = new Array();
		//이번달의 첫날짜의 요일 구하기
		var week = new Array(0, 1, 2, 3, 4, 5, 6);
		var first = new Date(d.year+'-'+d.month+'-01').getDay();
		var firstLabel = week[first];
		//전달의 마지막 날짜구하기
		var exlastDay = (new Date(d.year, d.month-1, 0)).getDate();
		for(var i = exlastDay-firstLabel+1; i < exlastDay + 1; i++){
			dates1.push(i);
		}
		//이번달의 마지막 날짜 구하기
		var lastDay = (new Date(d.year, d.month, 0)).getDate();
		for(var i = 1; i < lastDay +1; i++){
			dates2.push(i);
		}
		//이번달의 마지막 날짜의 요일 구하기
		var last = new Date(d.year+'-'+d.month+'-'+lastDay).getDay();
		var lastLabel = week[last];
		for(var i = 1;lastLabel < 6; i++, lastLabel++){
			dates3.push(i);
		}
		var idx = 0;
		//달력 구성하기
		for(var i = 0; i < dates1.length; i++,idx++){
			$('.calendar-date:eq('+idx+')').text(dates1[i]);
			$('.calendar-date:eq('+i+')').addClass('calendar-date-ext');
		}
		for(var i = 0; i < dates2.length; i++,idx++){
			//오늘 날짜 하이라이트
			if(dates2[i] == d.dates){
				$('.calendar-date:eq('+idx+')').children().remove();
				$('.calendar-date:eq('+idx+')').text('');
				$('.calendar-date:eq('+idx+')').append('<div class="calendarToday">'+dates2[i]+'</div>')
			}else{
				$('.calendar-date:eq('+idx+')').text(dates2[i]);
			}
		}
		for(var i = 0; i < dates3.length; i++,idx++){
			$('.calendar-date:eq('+idx+')').text(dates3[i]);
			$('.calendar-date:eq('+idx+')').addClass('calendar-date-ext');
		}
		$('.calendar-date:not(.calendar-date-ext)').attr('onclick','CalendarScript.changeDate(this)');
	},
	makeUnderline : function(c){
		$('.scheduleArea').text('');
		$('.scheduleArea').append('· <spring:message code="calendar.msg.no_appt_on_day"/>');
		$('.calendar-date').removeClass('calendar-date-on');
		//밑줄 긋기
		for(var i = 0; i < c.length; i++){
			var idx = c[i].dates - 1;
			$('.calendar-date:not(.calendar-date-ext):eq('+idx+')').addClass('calendar-date-on');
			//선택 날짜 약속보여주기
			if(CalendarScript.date.dates == c[i].dates){
				$('.scheduleArea').text('');
				$('.scheduleArea').children().remove();
				for(var j = 0; j < c[i].appt.length; j++){
					$('.scheduleArea').append('· '+CommonScript.getAmPmTime(c[i].appt[j].apptTime)+'시에 '+c[i].appt[j].apptPlace+'에서 '+c[i].appt[j].apptPurpose+'<br/>');
				}
			}
		}
	},
	changeDate : function(obj){
		if($(obj).text.length == 1){
			CalendarScript.date.dates = '0'+$(obj).text();
		}else{
			CalendarScript.date.dates = $(obj).text();
		}
		//상단 날짜 입력
		CalendarScript.getTitleDate(CalendarScript.date);
		//하단 날짜 구성하기
		CalendarScript.getMonthDates(CalendarScript.date);
		//오늘날짜의 일정 검색
		CalendarScript.getSchedule();
	},
	changeMonth : function(param){
		var month = parseInt(CalendarScript.date.month);
		//전달 검색시
		if(param == 'last'){
			month = month - 1;
			//년도 바꾸기
			if(month == 0){
				month = 12;
				CalendarScript.date.year = CalendarScript.date.year - 1;
			}
		}
		//다음달 검색시
		else{
			month = month + 1;
			//년도 바꾸기
			if(month == 13){
				month = 1;
				CalendarScript.date.year = CalendarScript.date.year + 1;
			}
		}
		var engM = '';
		if(month == 1){
			engM = 'JAN';
			CalendarScript.date.month = '01';
		}else if(month == 2){
			engM = 'FEB';
			CalendarScript.date.month = '02';
		}else if(month == 3){
			engM = "MAR";
			CalendarScript.date.month = '03';
		}else if(month == 4){
			engM = "APR";
			CalendarScript.date.month = '04';
		}else if(month == 5){
			engM = "MAY";
			CalendarScript.date.month = '05';
		}else if(month == 6){
			engM = "JUN";
			CalendarScript.date.month = '06';
		}else if(month == 7){
			engM = "JUL";
			CalendarScript.date.month = '07';
		}else if(month == 8){
			engM = "AUG";
			CalendarScript.date.month = '08';
		}else if(month == 9){
			engM = "SEP";
			CalendarScript.date.month = '09';
		}else if(month == 10){
			engM = "OCT"
			CalendarScript.date.month = '10';
		}else if(month == 11){
			engM = "NOV"
			CalendarScript.date.month = '11';
		}else{
			engM = "DEC"
			CalendarScript.date.month = '12';
		}
		CalendarScript.date.engMonth = engM;
		//상단 날짜 입력
		CalendarScript.getTitleDate(CalendarScript.date);
		//하단 날짜 구성하기
		CalendarScript.getMonthDates(CalendarScript.date);
		//오늘날짜의 일정 검색
		CalendarScript.getSchedule();
	},
	checkAppt : function(){
		console.log(CalendarScript.date);
		var d = CalendarScript.date;
		location.href = '/front/appt/progress?date='+d.year+'-'+d.month+'-'+d.dates;
	}
}
</script>