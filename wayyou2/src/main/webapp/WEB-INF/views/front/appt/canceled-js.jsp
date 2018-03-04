<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
$( document ).ready(function() {
	CommonScript.loading();
	//초기화
	CanceledScript.init();
	CommonScript.loadingHide();
});

//비동기 오브젝트
CanceledObj = {
	apptCondition : "canceled",
	apptTime : ''
}

//스크립트
CanceledScript = {
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
				CanceledScript.dateSearch(dateText,inst)
			}
		});
		//날짜가 있을시에 세팅
		var paramD = '<%= request.getParameter("date")%>';
		if(paramD != '' && paramD != 'null'){
			CanceledObj.apptTime = paramD;
		}
		//템플릿복사
		CanceledScript.template = $('.clone').clone();
		$('.clone').remove();
		CanceledScript.smallTemp = $('.smallClone').clone();
		$('.smallClone').remove();
		//리스트 호출
		CanceledScript.callList();
	},
	//날짜 검색
	dateSearch : function(d,i){
		CanceledObj.apptTime = d;
		CanceledScript.callList();
	},
	//날짜 초기화
	reset : function(){
		$('#datePicker').val('');
		CanceledObj.apptTime = '';
		CanceledScript.callList();
	},
	//검색
	search : function(){
		var schValue = $('.searchBox').val();
		if(schValue == ''){
			CanceledObj.searchKey = '';
		}else{
			CanceledObj.searchKey = schValue;
		}
		CanceledScript.callList();
	},
	//리스트 호출
	callList : function(){
		//리스트 호출
		$.ajax({
			url : '/front/appt/api/list',
			type : 'POST',
			dataType : 'json',
			data : CanceledObj,
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
						CanceledScript.makeList(appt[i],i,data.userId);
					}
				}
			},
			error : function(data, status, er) {
				CommonScript.errorPop('<spring:message code="cancel.cancel_appt"/>','<spring:message code="cancel.msg.error_canceled_appt_list"/>')
				console.log("error: " + JSON.stringify(data) + " status: " + status + " er:" + er);
			}
		})
	},
	//리스트 만들기
	makeList : function(data,idx, userId){
		//템플릿 붙이기
		$('#schedule').append(CanceledScript.template.clone());
		var temp = $('.clone');
		temp.find('.tabId').attr('id', 'appt'+idx);
		temp.find('.tabParent').attr('data-parent','#appt'+idx+'_timeline');
		temp.find('.tabHref').attr('href','#appt'+idx+'_time1');
		temp.find('.tabChildrenId').attr('id','appt'+idx+'_time1');
		//데이터 붙이기
		var condition = CommonScript.getApptCondition(data.apptCondition);
		temp.find('.time').append('<img src="/resources/img/custom/schedule-blue.png" class="scheduleIcon">'
			+CommonScript.changeSceduleTime(data.apptTime));
		temp.find('.title').append(data.apptPurpose+'<span class="apptCondition">'+condition+'</span>');
// 				+'<i class="icon icon-arrows-06 blueColor"></i><span class="apptPlace">장소 : '+data.apptPlace+'</span>')
		temp.removeClass('clone');
	},
	//게스트 리스트 만들기
// 	makeGuestList : function(temp, data, idx){
// 		temp.find('.guestArea').append(CanceledScript.smallTemp.clone());
// 		temp.find('.smallClone').append(data.guest.userName+'<strong style="float: right;" class="speaker-name blueColor">'+CommonScript.getGuestCondition(data.apptGuestCondition)+'</strong>');
// // 		+'<br/><span style="float: right;">남은거리 : 10분전에 공개됨/100M</span>');
// 	},
	//상세페이지 이동
// 	goDetail : function(id){
// 		location.href = '/front/appt/detail/'+id;
// 	}
}
</script>