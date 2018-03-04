<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
$( document ).ready(function() {
	MainScript.init();
});
MainScript = {
	map :'',
	//초기화
	init : function(){
		MainScript.getInfo();
	},
	//정보 가져오기
	getInfo: function(){
		$.ajax({
			url : '/front/main/api',
			type : 'POST',
			dataType : 'json',
			data : '',
			success:function(data){
				if(!data.appt){
					$('#nullAppt').show();
					$('#appts').hide();
					$('.subTitle').hide();
					$('#map').hide();
					$('#timeStamp').hide();
					$('#registBtn').show();
				}else{
					$('#registBtn').hide();
					MainScript.setApptInfo(data.appt);
					MainScript.initMap(data.appt);
				}
			},
			error : function(data, status, er) {
				CommonScript.errorPop('<spring:message code="main.come_appt"/>','<spring:message code="main.msg.error_come_appt_retry"/>')
				console.log("error: " + JSON.stringify(data) + " status: " + status + " er:" + er);
			}
		})
	},
	setApptInfo : function(data){
		$('.time').append(CommonScript.changeSceduleTime(data.apptTime));
		$('.title').prepend(data.apptPurpose);
		$('.guestArea').append('<p class="description blueColor guestDes">'
				+data.host.userName+'<img src="/resources/img/custom/crown.png" class="crown"></p>');
		for(var i = 0; i < data.apptGuestList.length; i++){
			$('.guestArea').append('<p class="description blueColor guestDes">'
					+data.apptGuestList[i].guest.userName+'<strong style="float: right;" class="speaker-name blueColor">'
					+CommonScript.getGuestCondition(data.apptGuestList[i].apptGuestCondition)+'</strong></p>')
		}
	},
	initMap : function(appt){
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center: new daum.maps.LatLng(appt.apptLat, appt.apptLng), // 지도의 중심좌표
			level: 3 // 지도의 확대 레벨
		};
	
		// 지도를 생성합니다    
		var map = new daum.maps.Map(mapContainer, mapOption); 
		MainScript.map = map;
		
		// 지도를 클릭한 위치에 표출할 마커입니다
		var marker = new daum.maps.Marker({ 
			// 지도 중심좌표에 마커를 생성합니다 
			position: map.getCenter() 
		}); 
		// 지도에 마커를 표시합니다
		marker.setMap(map);
		// 지도에 클릭 이벤트를 등록합니다
// 		daum.maps.event.addListener(map, 'click', function(mouseEvent) {
// 			// 클릭한 위도, 경도 정보를 가져옵니다 
// 			var latlng = mouseEvent.latLng; 
// 			// 마커 위치를 클릭한 위치로 옮깁니다
// 			marker.setPosition(latlng);
// 			$('input[name=apptLat]').val(latlng.getLat());
// 			$('input[name=apptLng]').val(latlng.getLng());
// 			var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
// 			message += '경도는 ' + latlng.getLng() + ' 입니다';
// 		});
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
					map: MainScript.map,
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
}
</script>