<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
$( document ).ready(function() {
	CommonScript.loading();
	//초기화
	ProgressScript.init();
	CommonScript.loadingHide();
});

//비동기 오브젝트
ProgressObj = {
	apptCondition : "progress",
	apptTime : ''
}

//스크립트
ProgressScript = {
	//템플릿
	tempalte : '',
	smallTemp : '',
	//초기화 함수
	init : function(){
		//datePicker
		$('#datePicker').datepicker({
			changeMonth : true,
			changeYear : true,
// 			showButtonPanel: true,
			dateFormat : 'yy-mm-dd',
// 			currentText: '오늘',
// 			closeText: '닫기',
			onSelect : function(dateText,inst){
				ProgressScript.dateSearch(dateText,inst)
			}
		});
		//날짜가 있을시에 세팅
		var paramD = '<%= request.getParameter("date")%>';
		if(paramD != '' && paramD != 'null'){
			ProgressObj.apptTime = paramD;
		}
		//템플릿복사
		ProgressScript.template = $('.clone').clone();
		$('.clone').remove();
		ProgressScript.smallTemp = $('.smallClone').clone();
		$('.smallClone').remove();
		//리스트 호출
		ProgressScript.callList();
	},
	//날짜 검색
	dateSearch : function(d,i){
		ProgressObj.apptTime = d;
		ProgressScript.callList();
	},
	//날짜 초기화
	reset : function(){
		$('#datePicker').val('');
		ProgressObj.apptTime = '';
		ProgressScript.callList();
	},
	//검색
	search : function(){
		var schValue = $('.searchBox').val();
		if(schValue == ''){
			ProgressObj.searchKey = '';
		}else{
			ProgressObj.searchKey = schValue;
		}
		ProgressScript.callList();
	},
	//리스트 호출
	callList : function(){
		//리스트 호출
		$.ajax({
			url : '/front/appt/api/list',
			type : 'POST',
			dataType : 'json',
			data : ProgressObj,
			success:function(data){
				var appt = data.appt;
				$('#schedule').children().remove();
				//리스트가 없을시
				if(appt.length == 0){
					$('#schedule').hide();
					$('#nullAppt').show();
// 					$('#nullApptTitle').show();
// 					$('#apptTitle').hide();
					$('#registBtn').show();
				}
				//리스트가 있을시
				else{
					$('#registBtn').hide();
					$('#nullAppt').hide();
					$('#schedule').show();
// 					$('#nullApptTitle').hide();
					for(var i = 0; i < appt.length; i++){
						ProgressScript.makeList(appt[i],i,data.userId);
					}
				}
			},
			error : function(data, status, er) {
				CommonScript.errorPop('<spring:message code="progress.progress_appt"/>','<spring:message code="progress.msg.error_progress_list"/>')
				console.log("error: " + JSON.stringify(data) + " status: " + status + " er:" + er);
			}
		})
	},
	//리스트 만들기
	makeList : function(data, idx, userId){
		//템플릿 붙이기
		$('#schedule').append(ProgressScript.template.clone());
		var temp = $('.clone');
		temp.find('.tabId').attr('id', 'appt'+idx);
		temp.find('.tabParent').attr('data-parent','#appt'+idx+'_timeline');
		temp.find('.tabHref').attr('href','#appt'+idx+'_time1');
		temp.find('.tabChildrenId').attr('id','appt'+idx+'_time1');
		//데이터 붙이기
		var condition = CommonScript.getApptCondition(data.apptCondition);
		if(userId == data.apptHostId){
			temp.find('.time').append('<img src="/resources/img/custom/schedule-blue.png" class="scheduleIcon">'
					+CommonScript.changeSceduleTime(data.apptTime));
			temp.find('.time').after('<img src="/resources/img/custom/crown.png" class="crown">');
		}else{
			temp.find('.time').append('<img src="/resources/img/custom/schedule-blue.png" class="scheduleIcon">'
					+CommonScript.changeSceduleTime(data.apptTime));
		}
// 				+'<span class="apptCondition">상태:'+condition+'</span>');
		temp.find('.title').append(data.apptPurpose+"<div class='apptDetail' onclick='ProgressScript.goDetail("+data.apptId+")'>약속 상세보기<img src='/resources/img/custom/detail-blue.png' class='detail-blue'/></div>");
// 				+'<i class="icon icon-arrows-06 blueColor"></i><span class="apptPlace">장소 : '+data.apptPlace+'</span>')
		temp.find('.guestArea').append(ProgressScript.smallTemp.clone());
		temp.find('.smallClone').append(data.host.userName+'<img src="/resources/img/custom/crown.png" class="crown">');
// 		+'<br/><span style="float: right;">남은거리 : 10분전에 공개됨/100M</span>');
		temp.find('.guestArea').append('<br/>')
		temp.find('.smallClone').removeClass();
		for(var i = 0; i < data.apptGuestList.length; i++){
			ProgressScript.makeGuestList(temp, data.apptGuestList[i],i);
			temp.find('.smallClone').removeClass();
			temp.find('.guestArea').append('<br/>')
		}
		temp.find('.guestArea').append($('<div>'));
		temp.removeClass('clone');
	},
	//게스트 리스트 만들기
	makeGuestList : function(temp, data, idx){
		temp.find('.guestArea').append(ProgressScript.smallTemp.clone());
		temp.find('.smallClone').append(data.guest.userName+'<strong style="float: right;" class="speaker-name blueColor">'+CommonScript.getGuestCondition(data.apptGuestCondition)+'</strong>');
// 		+'<br/><span style="float: right;">남은거리 : 10분전에 공개됨/100M</span>');
	},
	//상세페이지 이동
	goDetail : function(id){
		location.href = '/front/appt/detail/'+id;
	}
}
</script>