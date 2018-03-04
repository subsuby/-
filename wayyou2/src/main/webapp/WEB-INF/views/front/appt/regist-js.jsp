<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
$( document ).ready(function() {
	CommonScript.loading();
	//초기화
	RegistScript.init();
	CommonScript.loadingHide();
});

RegistScript = {
	map : '',
	friendClone : '',
	inviteObj : [],
	//초기화
	init : function(){
		$('#tabs').tabs();
		RegistScript.initMap();
		//datePicker
		$('input[name=apptTime]').datepicker({
			changeMonth : true,
			changeYear : true,
// 			showButtonPanel: true,
			dateFormat : 'yy-mm-dd',
// 			currentText: '오늘',
// 			closeText: '닫기',
		});
		//datePicker
// 		$('input[name=apptAlarm]').datepicker({
// 			changeMonth : true,
// 			changeYear : true,
// // 			showButtonPanel: true,
// 			dateFormat : 'yy-mm-dd',
// // 			currentText: '오늘',
// // 			closeText: '닫기',
// 		});
		//시간 옵션 셋팅
		for(var i = 1; i < 25; i++){
			if(i < 10){
				i = '0'+i;
			}
			$('select[name=apptTimeT]').append('<option>'+i+'</option>');
// 			$('select[name=apptAlarmT]').append('<option>'+i+'</option>');
		}
		//시간 옵션 셋팅
		for(var i = 1; i < 61; i++){
			if(i < 10){
				i = '0'+i;
			}
			$('select[name=apptTimeM]').append('<option>'+i+'</option>');
// 			$('select[name=apptAlarmM]').append('<option>'+i+'</option>');
		}
		RegistScript.friendClone = $('#friendClone').clone();
		$('#friendClone').remove();
		RegistScript.getFriendList();
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
				console.log(user);
				//리스트가 없을시
				if(user.friend.length == 0){
					$('#inviteFriend').append('<h1><spring:message code="regist.msg.there_are_no_friend"/></h1>');
				}
				//리스트가 있을시
				else{
					for(var i = 0; i < user.friend.length; i++){
						RegistScript.makeFriendList(user.friend[i],i);
					}
				}
			},
			error : function(data, status, er) {
				CommonScript.errorPop('<spring:message code="regist.regist_appt"/>','<spring:message code="regist.msg.error_regist_appt_retry"/>')
				console.log("error: " + JSON.stringify(data) + " status: " + status + " er:" + er);
			}
		})
	},
	makeFriendList : function(friend, idx){
		$('#inviteFriend').prepend(RegistScript.friendClone.clone());
		var clone = $('#friendClone');
		clone.show();
		clone.find('.tableFriendName').append('<strong>'+friend.friend.userName+'</strong>');
		clone.find('.tableFriendBirth').append('<img src="/resources/img/custom/birth.png" class="friendTabImg"/>'+CommonScript.formatBirth(friend.friend.userBirth));
		clone.find('.tableFriendPhone').append('<img src="/resources/img/custom/phone.png" class="friendTabImg"/>'+friend.friend.userPhone);
		clone.find('.registCheck').attr('onclick','RegistScript.invite("'+friend.friend.userId+'", this)');
		clone.attr('id','');
	},
	invite : function(userId, obj){
		if($(obj).is(":checked")){
			RegistScript.inviteObj.push(userId);
			$(obj).parent().parent().parent().removeClass('friendDis');
		}else{
			RegistScript.inviteObj.pop(userId);
			$(obj).parent().parent().parent().addClass('friendDis');
		}
		console.log(RegistScript.inviteObj);
	},
	initMap : function(){
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center: new daum.maps.LatLng(37.56582, 126.97865), // 지도의 중심좌표
			level: 3 // 지도의 확대 레벨
		};
	
		// 지도를 생성합니다    
		var map = new daum.maps.Map(mapContainer, mapOption); 
		RegistScript.map = map;
		
		// 지도를 클릭한 위치에 표출할 마커입니다
		var marker = new daum.maps.Marker({ 
			// 지도 중심좌표에 마커를 생성합니다 
			position: map.getCenter() 
		}); 
		// 지도에 마커를 표시합니다
		marker.setMap(map);
		// 지도에 클릭 이벤트를 등록합니다
		daum.maps.event.addListener(map, 'click', function(mouseEvent) {
			// 클릭한 위도, 경도 정보를 가져옵니다 
			var latlng = mouseEvent.latLng; 
			// 마커 위치를 클릭한 위치로 옮깁니다
			marker.setPosition(latlng);
			$('input[name=apptLat]').val(latlng.getLat());
			$('input[name=apptLng]').val(latlng.getLng());
		});
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
					map: RegistScript.map,
					position: coords
				});
				// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				RegistScript.map.setCenter(coords);
				// 지도에 클릭 이벤트를 등록합니다
				daum.maps.event.addListener(RegistScript.map, 'click', function(mouseEvent) {        
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
	regist : function(){
		//변수 설정
		var purpose = $('input[name=apptPurpose]').val();
		var date = $('input[name=apptTime]').val()+' '+$('select[name=apptTimeT]').val()+':'+$('select[name=apptTimeM]').val();
// 		var alarm = $('input[name=apptAlarm]').val()+' '+$('select[name=apptAlarmT]').val()+':'+$('select[name=apptAlarmM]').val();
		var place = $('input[name=apptPlace]').val();
		var lng = $('input[name=apptLng]').val();
		var lat = $('input[name=apptLat]').val();
		Regex.validateDateTime(date)
		console.log(lng);
		console.log(lat);
		//빈칸 체크
		var blank = false;
		if(purpose == ''){
			blank = true;
			CommonScript.errorPop('<spring:message code="regist.regist_appt"/>','<spring:message code="regist.msg.please_input_appt_name"/>');
			$('input[name=apptPurpose]').focus();
		}else if(date == ' :'){
			blank = true;
			CommonScript.errorPop('<spring:message code="regist.regist_appt"/>','<spring:message code="regist.msg.please_input_appt_time"/>');
			$('input[name=apptTime]').focus();
		}
// 		else if(alarm == ' :'){
// 			blank = true;
// 			CommonScript.errorPop('약속등록','약속 알람시간을 입력해주세요.');
// 			$('input[name=apptAlarm]').focus();
// 		}
		else if(place == ''){
			blank = true;
			CommonScript.errorPop('<spring:message code="regist.regist_appt"/>','<spring:message code="regist.msg.please_input_appt_place"/>');
			$('input[name=apptPlace]').focus();
		}else if(lng == ''){
			blank = true;
			CommonScript.errorPop('<spring:message code="regist.regist_appt"/>','<spring:message code="regist.msg.please_click_map_to_marking"/>');
			$('#map').focus();
		}else if(lat == ''){
			blank = true;
			CommonScript.errorPop('<spring:message code="regist.regist_appt"/>','<spring:message code="regist.msg.please_click_map_to_marking"/>');
			$('#map').focus();
		}
		if(blank)return;
		//유효성 검사
		var validate = true;
		//약속 목적 길이 체크
		if(purpose.length > 50){
			CommonScript.errorPop('<spring:message code="regist.regist_appt"/>','<spring:message code="regist.msg.appt_name_is_fifty"/>');
			$('input[name=apptPurpose]').focus();
			validate = false;
		}
		//약속 시간 형식 체크
		else if(!Regex.validateDateTime(date)){
			CommonScript.errorPop('<spring:message code="regist.regist_appt"/>','<spring:message code="regist.msg.input_appt_time_format"/>');
			$('input[name=apptTime]').focus();
			validate = false;
		}
		//약속 시간 범위 체크
		else if(!CommonScript.checkCurdate(date)){
			CommonScript.errorPop('<spring:message code="regist.regist_appt"/>','<spring:message code="regist.msg.appt_time_must_after"/>');
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
			CommonScript.errorPop('<spring:message code="regist.regist_appt"/>','<spring:message code="regist.msg.appt_place_is_fifty"/>');
			$('input[name=apptPlace]').focus();
			validate = false;
		}
		if(!validate)return;
		//초대 유효성 검사
		var invite = true;
		if(RegistScript.inviteObj.length == 0){
			invite = false;
			CommonScript.errorPop('<spring:message code="regist.regist_appt"/>','<spring:message code="regist.msg.no_invite_friend_must_one"/>');
			$('a[href=#inviteFriend]').click();
		}
		if(!invite)return;
		//parameter 만들기
		var parameter = {
			apptTime : date,
			apptPlace : place,
			apptPurpose : purpose,
			apptLat : lat,
			apptLng : lng,
		}
		for(var i = 0; i < RegistScript.inviteObj.length; i++){
			parameter['apptGuestList['+i+'].apptGuestId'] = RegistScript.inviteObj[i];
		}
		//API 호출
		$.ajax({
			url : '/front/appt/regist/api',
			type : 'POST',
			dataType : 'json',
			data : parameter,
			success:function(data){
				var result = data.result;
				if(result = 'true'){
					location.href = '/front/appt/wait'
				}else{
					CommonScript.errorPop('<spring:message code="regist.regist_appt"/>','<spring:message code="regist.msg.error_regist_appt_retry"/>');
				}
			},
			error : function(data, status, er) {
				CommonScript.errorPop('<spring:message code="regist.regist_appt"/>','<spring:message code="regist.msg.error_regist_appt_retry"/>');
				console.log("error: " + JSON.stringify(data) + " status: " + status + " er:" + er);
			}
		})
		//콜백
	}
}
</script>
