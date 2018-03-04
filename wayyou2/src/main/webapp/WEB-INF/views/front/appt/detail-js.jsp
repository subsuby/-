<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script>
$( document ).ready(function() {
	CommonScript.loading();
	//초기화
	DetailScript.init();
	CommonScript.loadingHide();
});

DetailScript = {
	map : '',
	friendClone : '',
	inviteObj : [],
	userId : '${userId}',
	guestObj : [],
	guestCondition : [],
	guestName : [],
	guestBirth : [],
	guestPhone : [],
	//초기화
	init : function(){
		$('#tabs').tabs();
		DetailScript.initMap();
		//datePicker
		$('input[name=apptTime]').datepicker({
			changeMonth : true,
			changeYear : true,
// 			showButtonPanel: true,
			dateFormat : 'yy-mm-dd',
// 			currentText: '오늘',
// 			closeText: '닫기',
		});
		//시간 옵션 셋팅
		for(var i = 0; i < 25; i++){
			if(i < 10){
				i = '0'+i;
			}
			$('select[name=apptTimeT]').append('<option>'+i+'</option>');
		}
		//시간 옵션 셋팅
		for(var i = 0; i < 61; i++){
			if(i < 10){
				i = '0'+i;
			}
			$('select[name=apptTimeM]').append('<option>'+i+'</option>');
		}
		//시간 셋팅
		DetailScript.setTime();
		//친구 목록 클론생성
		DetailScript.friendClone = $('#friendClone').clone();
		$('#friendClone').remove();
		//게스트 목록 생성
		<c:forEach items="${appt.apptGuestList}" var="list" >  
			DetailScript.guestObj.push('<c:out value="${list.apptGuestId}"/>');
			DetailScript.guestCondition.push('<c:out value="${list.apptGuestCondition}"/>')
			DetailScript.guestName.push('<c:out value="${list.guest.userName}"/>')
			DetailScript.guestBirth.push('<c:out value="${list.guest.userBirth}"/>')
			DetailScript.guestPhone.push('<c:out value="${list.guest.userPhone}"/>')
		</c:forEach>
		//호스트로 들어왔을시
		if(${userId eq appt.apptHostId}){
			DetailScript.getFriendList();
			$('.modifiedBtn').show();
			$('.attendBtn').hide();
		}
		//게스트로 들어왔을시
		else{
			$('.modifiedBtn').hide();
			$('.attendBtn').show();
			//인풋 디스에이블드
			DetailScript.disabledInput();
			//게스트 목록
			DetailScript.getApptGuestList();
		}
	},
	setTime : function(){
		var apptTime = '${appt.apptTime}';
		var date = apptTime.split(' ')[0];
		var time1 = apptTime.split(' ')[1].split(':')[0];
		var time2 = apptTime.split(' ')[1].split(':')[1];
		$('input[name=apptTime]').val(date);
		$('select[name=apptTimeT]').val(time1);
		$('select[name=apptTimeM]').val(time2);
	},
	getFriendList : function(){
		//리스트 호출
		$.ajax({
			url : '/front/friend/list/api',
			type : 'POST',
			dataType : 'json',
			data : '',
			success:function(data){
				var user = data.user;
				//리스트가 없을시
				if(user.friend.length == 0){
// 					$('#inviteFriend').append('<h1>검색된 리스트가 없습니다.</h1>');
				}
				//리스트가 있을시
				else{
					for(var i = 0; i < user.friend.length; i++){
						DetailScript.makeFriendList(user.friend[i],i);
					}
				}
			},
			error : function(data, status, er) {
				CommonScript.errorPop('<spring:message code="detail.appt_detail"/>','<spring:message code="detail.msg.error_detail_appt_retry약속"/>')
				console.log("error: " + JSON.stringify(data) + " status: " + status + " er:" + er);
			}
		})
	},
	makeFriendList : function(friend, idx){
		$('#inviteFriend').append(DetailScript.friendClone.clone());
		var clone = $('#friendClone');
		clone.show();
		clone.find('.tableFriendName').text(friend.friend.userName);
		clone.find('.tableFriendBirth').text('<img src="/resources/img/custom/birth.png" class="friendTabImg"/>'+CommonScript.formatBirth(friend.friend.userBirth));
		clone.find('.tableFriendPhone').text('<img src="/resources/img/custom/phone.png" class="friendTabImg"/>'+friend.friend.userPhone);
		clone.find('.registCheck').attr('onclick','DetailScript.invite("'+friend.friend.userId+'", this)');
		for(var i = 0; i < DetailScript.guestObj.length; i++){
			if(DetailScript.guestObj[i] == friend.friend.userId){
				clone.find('.registCheck').attr('checked','checked');
				DetailScript.inviteObj.push(DetailScript.guestObj[i])
				clone.find('.tableFriendCondition').append('<spring:message code="detail.attendence"/> : '+CommonScript.getGuestCondition(DetailScript.guestCondition[i]))
			}
		}
		clone.attr('id','');
	},
	disabledInput : function(){
		$('input[name=apptPurpose]').attr('disabled','true');
		$('input[name=apptTime]').attr('disabled','true');
		$('select[name=apptTimeT]').attr('disabled','true');
		$('select[name=apptTimeM]').attr('disabled','true');
		$('input[name=apptPlace]').attr('disabled','true');
		$('#registSearch').remove();
	},
	getApptGuestList : function(){
		console.log(DetailScript.guestObj);
		for(var i = 0; i < DetailScript.guestObj.length; i++){
			$('#inviteFriend').append(DetailScript.friendClone.clone());
			var clone = $('#friendClone');
			clone.show();
			clone.find('.tableFriendName').text(DetailScript.guestName[i]);
			clone.find('.tableFriendBirth').append('<spring:message code="detail.birth"/> : '+CommonScript.formatBirth(DetailScript.guestBirth[i]));
			clone.find('.tableFriendPhone').append('<spring:message code="detail.phone"/> : '+DetailScript.guestPhone[i]);
			clone.find('.tableFriendCondition').append('<spring:message code="detail.attendence"/> : '+CommonScript.getGuestCondition(DetailScript.guestCondition[i]))
			clone.find('.registCheck').remove();
			clone.attr('id','');
		}
	},
	invite : function(userId, obj){
		if($(obj).is(":checked")){
			DetailScript.inviteObj.push(userId);
			$(obj).parent().parent().parent().removeClass('friendDis');
		}else{
			DetailScript.inviteObj.pop(userId);
			$(obj).parent().parent().parent().addClass('friendDis');
		}
		console.log(DetailScript.inviteObj);
	},
	initMap : function(){
		var lat = '${appt.apptLat}';
		var lng = '${appt.apptLng}';
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center: new daum.maps.LatLng(lat, lng), // 지도의 중심좌표
			level: 3 // 지도의 확대 레벨
		};
	
		// 지도를 생성합니다    
		var map = new daum.maps.Map(mapContainer, mapOption); 
		DetailScript.map = map;
		
		// 지도를 클릭한 위치에 표출할 마커입니다
		var marker = new daum.maps.Marker({ 
			// 지도 중심좌표에 마커를 생성합니다 
			position: map.getCenter() 
		}); 
		// 지도에 마커를 표시합니다
		marker.setMap(map);
		//호스트 일시
		if(DetailScript.userId == '${appt.apptHostId}'){
			// 지도에 클릭 이벤트를 등록합니다
			daum.maps.event.addListener(map, 'click', function(mouseEvent) {
				// 클릭한 위도, 경도 정보를 가져옵니다 
				var latlng = mouseEvent.latLng; 
				// 마커 위치를 클릭한 위치로 옮깁니다
				marker.setPosition(latlng);
				$('input[name=apptLat]').val(latlng.getLat());
				$('input[name=apptLng]').val(latlng.getLng());
			});
		}
	},
	searchMap : function(){
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new daum.maps.services.Geocoder();
		var schValue = $('input[name=mapSchVal]').val();
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(schValue, function(result, status) {
			// 정상적으로 검색이 완료됐으면 
			if (status === daum.maps.services.Status.OK) {
				var coords = new daum.maps.LatLng(result[0].y, result[0].x);
				// 결과값으로 받은 위치를 마커로 표시합니다
				var marker = new daum.maps.Marker({
					map: DetailScript.map,
					position: coords
				});
				// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				DetailScript.map.setCenter(coords);
				// 지도에 클릭 이벤트를 등록합니다
				daum.maps.event.addListener(DetailScript.map, 'click', function(mouseEvent) {        
					// 클릭한 위도, 경도 정보를 가져옵니다 
					var latlng = mouseEvent.latLng; 
					// 마커 위치를 클릭한 위치로 옮깁니다
					marker.setPosition(latlng);
					$('input[name=apptLat]').val(latlng.getLat());
					$('input[name=apptLng]').val(latlng.getLng());
				});
			}else{
				console.log(result);
				console.log(status);
			}
		});
	},
	Modified : function(){
		//변수 설정
		var purpose = $('input[name=apptPurpose]').val();
		var date = $('input[name=apptTime]').val()+' '+$('select[name=apptTimeT]').val()+':'+$('select[name=apptTimeM]').val();
// 		var alarm = $('input[name=apptAlarm]').val()+' '+$('select[name=apptAlarmT]').val()+':'+$('select[name=apptAlarmM]').val();
		var place = $('input[name=apptPlace]').val();
		var lng = $('input[name=apptLng]').val();
		var lat = $('input[name=apptLat]').val();
		Regex.validateDateTime(date)
		//빈칸 체크
		var blank = false;
		if(purpose == ''){
			blank = true;
			CommonScript.errorPop('<spring:message code="detail.modified_appt"/>','<spring:message code="detail.msg.please_input_appt_name"/>');
			$('input[name=apptPurpose]').focus();
		}else if(date == ' :'){
			blank = true;
			CommonScript.errorPop('<spring:message code="detail.modified_appt"/>','<spring:message code="detail.msg.please_input_appt_time"/>');
			$('input[name=apptTime]').focus();
		}
// 		else if(alarm == ' :'){
// 			blank = true;
// 			CommonScript.errorPop('약속등록','약속 알람시간을 입력해주세요.');
// 			$('input[name=apptAlarm]').focus();
// 		}
		else if(place == ''){
			blank = true;
			CommonScript.errorPop('<spring:message code="detail.modified_appt"/>','<spring:message code="detail.msg.please_input_appt_place"/>');
			$('input[name=apptPlace]').focus();
		}else if(lng == ''){
			blank = true;
			CommonScript.errorPop('<spring:message code="detail.modified_appt"/>','<spring:message code="detail.msg.please_click_map_to_marking"/>');
			$('#map').focus();
		}else if(lat == ''){
			blank = true;
			CommonScript.errorPop('<spring:message code="detail.modified_appt"/>','<spring:message code="detail.msg.please_click_map_to_marking"/>');
			$('#map').focus();
		}
		if(blank)return;
		//유효성 검사
		var validate = true;
		//약속 목적 길이 체크
		if(purpose.length > 50){
			CommonScript.errorPop('<spring:message code="detail.modified_appt"/>','<spring:message code="detail.msg.appt_name_is_fifty"/>');
			$('input[name=apptPurpose]').focus();
			validate = false;
		}
		//약속 시간 형식 체크
		else if(!Regex.validateDateTime(date)){
			CommonScript.errorPop('<spring:message code="detail.modified_appt"/>','<spring:message code="detail.msg.input_appt_time_format"/>');
			$('input[name=apptTime]').focus();
			validate = false;
		}
		//약속 시간 범위 체크
		else if(!CommonScript.checkCurdate(date)){
			CommonScript.errorPop('<spring:message code="detail.modified_appt"/>','<spring:message code="detail.msg.appt_time_must_after"/>');
			$('input[name=apptTime]').focus();
			validate = false;
		}
// 		//약속 알람시간 형식 체크
// 		else if(!Regex.validateDateTime(alarm)){
// 			CommonScript.errorPop('약속등록','약속 알람시간을 형식에 맞게 입력해주세요.');
// 			$('input[name=apptAlarm]').focus();
// 			validate = false;
// 		}
// 		//약속 알람시간 범위 체크
// 		else if(!CommonScript.compareDate(date,alarm)){
// 			CommonScript.errorPop('약속등록','약속 알람시간은 약속시간 이후여야 합니다.');
// 			$('input[name=apptAlarm]').focus();
// 			validate = false;
// 		}
		//약속 장소 길이 체크
		else if(place.length > 50){
			CommonScript.errorPop('<spring:message code="detail.modified_appt"/>','<spring:message code="detail.msg.appt_place_is_fifty"/>');
			$('input[name=apptPlace]').focus();
			validate = false;
		}
		if(!validate)return;
		//초대 유효성 검사
		var invite = true;
		if(DetailScript.inviteObj.length == 0){
			invite = false;
			CommonScript.errorPop('<spring:message code="detail.modified_appt"/>','<spring:message code="detail.msg.no_invite_friend_must_one"/>');
			$('a[href=#inviteFriend]').click();
		}
		if(!invite)return;
		//parameter 만들기
		var parameter = {
			apptId : '${appt.apptId}',
			apptTime : date,
			apptPlace : place,
			apptPurpose : purpose,
			apptLat : lat,
			apptLng : lng,
		}
		for(var i = 0; i < DetailScript.inviteObj.length; i++){
			parameter['apptGuestList['+i+'].apptGuestId'] = DetailScript.inviteObj[i];
		}
		//API 호출
		$.ajax({
			url : '/front/appt/modified/api',
			type : 'POST',
			dataType : 'json',
			data : parameter,
			success:function(data){
				var result = data.result;
				if(result = 'true'){
					location.href = '/front/appt/wait'
				}else{
					CommonScript.errorPop('<spring:message code="detail.modified_appt"/>','<spring:message code="detail.msg.error_modified_appt_retry"/>');
				}
			},
			error : function(data, status, er) {
				CommonScript.errorPop('<spring:message code="detail.modified_appt"/>','<spring:message code="detail.msg.error_modified_appt_retry"/>');
				console.log("error: " + JSON.stringify(data) + " status: " + status + " er:" + er);
			}
		})
	},
	cancel : function(){
		CommonScript.confirmPop('<spring:message code="detail.cancel_appt"/>', '<spring:message code="detail.msg.are_you_cancel"/>','DetailScript.cancelApi()');
	},
	cancelApi : function(){
		//API 호출
		$.ajax({
			url : '/front/appt/delete/api',
			type : 'POST',
			dataType : 'json',
			data : {apptId : '${appt.apptId}'},
			success:function(data){
				var result = data.result;
				if(result = 'true'){
					location.href = '/front/appt/canceled'
				}else{
					CommonScript.errorPop('<spring:message code="detail.cancel_appt"/>','<spring:message code="detail.msg.error_canceled_appt_retry"/>');
				}
			},
			error : function(data, status, er) {
				CommonScript.errorPop('<spring:message code="detail.cancel_appt"/>','<spring:message code="detail.msg.error_canceled_appt_retry"/>');
				console.log("error: " + JSON.stringify(data) + " status: " + status + " er:" + er);
			}
		})
	},
	attend : function(attend){
		//파라미터 셋팅
		var parameter = {
			apptId : '${appt.apptId}',
			apptGuestId : DetailScript.userId,
			apptGuestCondition : attend
		}
		//API 호출
		$.ajax({
			url : '/front/appt/attend/api',
			type : 'POST',
			dataType : 'json',
			data : parameter,
			success:function(data){
				var result = data.result;
				if(result = 'true'){
					location.href = '/front/appt/wait'
				}else{
					CommonScript.errorPop('<spring:message code="detail.attend_appt"/>','<spring:message code="detail.msg.error_attendence_appt_retry"/>');
				}
			},
			error : function(data, status, er) {
				CommonScript.errorPop('<spring:message code="detail.attend_appt"/>','<spring:message code="detail.msg.error_attendence_appt_retry"/>');
				console.log("error: " + JSON.stringify(data) + " status: " + status + " er:" + er);
			}
		})
	}
}
</script>
