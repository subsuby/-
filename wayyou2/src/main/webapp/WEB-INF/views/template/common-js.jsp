<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
$( document ).ready(
	function(){
		//백버튼 만들기
		$back = $('.icon-wayYou-back');
		$back.append('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="/resources/img/custom/backIcon.png" alt="뒤로가기" style="width: 25px;padding-top:25px; position: fixed;"></img>');
		CommonScript.init();
	}
)
//정규식 
Regex = {
	validateEmail : function(email) {
		var mailRules = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
		return mailRules.test(email);
	},
	validatePwd : function(pwd){
		var passwordRules = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
		return passwordRules.test(pwd);
	},
	validateBirth : function(birth){
		var birthRules = /^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;
		return birthRules.test(birth);
	},
	validatePhone : function(phone){
		phone = phone.split('-').join('');
		var phoneRules = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;
		return phoneRules.test(phone);
	},
	validateDateTime : function(date){
		var dates = date.split(' ')[0];
		var time = date.split(' ')[1];
		var dateRules = /^\d\d\d\d-(0?[1-9]|1[0-2])-(0?[1-9]|[12][0-9]|3[01])$/;
		var timeRules = /(00|[0-9]|1[0-9]|2[0-3]):([0-9]|[0-5][0-9])$/;
		var result = true;
		if(!dateRules.test(dates)){
			result = false;
		}else if(!timeRules.test(time)){
			result = false
		}
		return result;
	}
}
//공통 스크립트
CommonScript = {
	//초기화
	init : function(){
		var url = window.location.href;
		if(!url.startsWith('http://localhost/front/login')){
			//api 호출
			$.ajax({
				url : '/front/main/new/api',
				type : 'POST',
				dataType : 'json',
				data : '',
				success:function(data){
					console.log(data);
					if(data.result == 'true'){
						$('#iconBar').after('<a href="/front/appt/wait"><img src="/resources/img/custom/alarm-yellow.png" alt="알람" style="width: 21px;height: auto;display: inline-block;margin-left:22%;"></a>')
					}else{
						$('#friendList').css('margin-left', '30%');
					}
				},
				error : function(data, status, er) {
//	 				CommonScript.loadingHide();
//	 				CommonScript.errorPop('회원가입','회원가입도중 오류가 발생하였습니다. 다시 시도해주세요.')
//	 				console.log("error: " + data + " status: " + status + " er:" + er);
				}
			})
		}
	},
	//언어 변경
	changeLocale : function(lang){
		var param = '';
		if(lang == 'K'){
			param = 'lang=ko';
		}else{
			param = 'lang=ja';
		}
		var url = location.href;
		var basicUrl = url.split('?')[0];
		var parameter = url.split('?')[1];
		console.log(basicUrl);
		console.log(parameter);
		if(!parameter){
			url = basicUrl + '?' + param;
		}else{
			var paramArr = parameter.split('&');
			var newArr = [];
			console.log(paramArr);
			for(var i = 0; i < paramArr.length; i++){
				if(paramArr[i].split('=')[0] != 'lang'){
					newArr.push(paramArr[i]);
				}
			}
			var newParameter = '';
			for(var i = 0; i < newArr.length; i++){
				newParameter = newParameter + newArr[i]+'&';
			}
			newParameter = newParameter + param;
// 			console.log(newParameter);
			url = basicUrl + '?' + newParameter;
		}
		console.log(url);
		location.href =url;
	},
	//로딩띄우기
	loading : function(){
		$('.preloader-mask').show();
	},
	//로딩 없애기
	loadingHide : function(){
		$('.preloader-mask').hide();
	},
	//에러 팝업 띄우기
	errorPop : function(subject, content){
		$('.modal-window').hide();
		errorPop = $('.errorPop');
		errorPop.show();
		errorPop.find('.errorSub').text('');
		errorPop.find('.errorSub').children().remove();
		errorPop.find('.errorSub').append(subject);
		errorPop.find('.errorContent').text('');
		errorPop.find('.errorContent').children().remove();
		errorPop.find('.errorContent').append(content);
	},
	//컨펌 팝업 띄우기
	confirmPop : function(subject, content, confirmCallback, cancelCallback){
		$('.modal-window').hide();
		confirmPop = $('.confirmPop');
		confirmPop.show();
		confirmPop.find('.confirmSub').text('');
		confirmPop.find('.confirmSub').children().remove();
		confirmPop.find('.confirmSub').append(subject);
		confirmPop.find('.confirmContent').text('');
		confirmPop.find('.confirmContent').children().remove();
		confirmPop.find('.confirmContent').append(content);
		if(!confirmCallback){
			confirmPop.find('.confirmY').addClass('close-btn confirmClose');
		}else{
			confirmPop.find('.confirmY').attr('onclick', confirmCallback);
		}
		if(!cancelCallback){
			confirmPop.find('.confirmN').addClass('close-btn confirmClose');
		}else{
			confirmPop.find('.confirmN').attr('onclick', cancelCallback);
		}
	},
	closePop : function(){
// 		$('.confirmPop').find('.close-btn').click();
	},
	//블러시 핸드폰 하이픈 넣기
	blurPhone : function(obj){
		var str = $(obj).val();
		str = str.replace(/[^0-9]/g, '');
		var tmp = '';
		if( str.length < 4){
			tmp = str;
		}else if(str.length < 7){
			tmp += str.substring(0, 3);
			tmp += '-';
			tmp += str.substring(3,7);
		}else if(str.length < 11){
			tmp += str.substring(0, 3);
			tmp += '-';
			tmp += str.substring(3, 7);
			tmp += '-';
			tmp += str.substring(7,11);
		}else{
			tmp += str.substring(0, 3);
			tmp += '-';
			tmp += str.substring(3, 7);
			tmp += '-';
			tmp += str.substring(7, 11);
		}
		$(obj).val(tmp);
	},
	getGuestCondition : function(param){
		if(param == 'A'){
			param = '<spring:message code="common.attend"/>';
		}else if(param == 'D'){
			param = '<spring:message code="common.dis_attend"/>';
		}else{
			param = '<spring:message code="common.no_answer"/>';
		}
		return param;
	},
	getApptCondition : function(param){
		if(param == 'W'){
			param = '<spring:message code="common.wait"/>';
		}else if(param == 'P'){
			param = '<spring:message code="common.progress"/>';
		}else if(param == 'E'){
			param = '<spring:message code="common.complete"/>';
		}else if(param == 'C'){
			param = '<spring:message code="common.cancel"/>'
		}
		return param;
	},
	getToday : function(){
		var date = new Date();
		var y = date.getFullYear();
		var m = date.getMonth() + 1;
		var d = date.getDate();
		var engM = '';
		if(m == 1){
			engM = 'JAN';
			m = '01';
		}else if(m == 2){
			engM = 'FEB';
			m = '02';
		}else if(m == 3){
			engM = "MAR";
			m = '03';
		}else if(m == 4){
			engM = "APR";
			m = '04';
		}else if(m == 5){
			engM = "MAY";
			m = '05';
		}else if(m == 6){
			engM = "JUN";
			m = '06';
		}else if(m == 7){
			engM = "JUL";
			m = '07';
		}else if(m == 8){
			engM = "AUG";
			m = '08';
		}else if(m == 9){
			engM = "SEP";
			m = '09';
		}else if(m == 10){
			engM = "OCT"
		}else if(m == 11){
			engM = "NOV"
		}else{
			engM = "DEC"
		}
		if(d < 10){
			d = '0'+d;
		}
		var dateObj = {year : y, month : m, dates : d, engMonth : engM};
		return dateObj;
	},
	getAmPmTime : function(param){
		var times = param.split(' ')[1];
		var time = times.split(':')[0];
		if(time > 12){
			time = time - 12;
			time = '<spring:message code="common.pm"/> '+ time;
		}else{
			time = '<spring:message code="common.am"/>' + time;
		}
		return time;
	},
	changeSceduleTime : function(t){
		var array = t.split(' ');
		var dArray = array[0].split('-');
		var time = array[1].split(':')[0];
		var result = dArray[0]+'<spring:message code="common.year"/> '+dArray[1]+'<spring:message code="common.month"/> '+dArray[2]+'<spring:message code="common.day"/> ';
		if(time < 13){
			time = '<spring:message code="common.am"/> '+time+'<spring:message code="common.time"/>';
		}else{
			time = '<spring:message code="common.pm"/> '+(parseInt(time)-12)+'<spring:message code="common.time"/>';
		}
		result = result + time;
		return result;
	},
	formatBirth : function(date){
		var y = date.substring(0,4);
		var m = date.substring(4,6);
		var d = date.substring(6,8);
		return y+"<spring:message code='common.year'/> "+m+"<spring:message code='common.month'/> "+d+'<spring:message code="common.day"/>';
	},
	checkCurdate : function(date){
		var today = new Date();
		var endDate = new Date(date);
		var reulst;
		if (today < endDate) {
			result = true;
		} else {
			result = false;
		}
		return result;
	}
}
</script>
<div class="modal-window errorPop open" data-modal="errorPop" style="background-color: #405470; display: none;">
	<div class="modal-box small animated zoomIn" data-animation="zoomIn" data-duration="700" 
	style="top: 0px; animation-delay: 0ms; animation-duration: 0.7s;margin-top:50%;margin-bottom:50%;">
		<span class="close-btn icon icon-office-52"></span>
		<h5 class="align-center"><span class="pinkColor errorSub"></span></h5>
		<br/><br/>
		<h7 class="align-center"><span class="pinkColor errorContent" style="font-size:14px;text-align:center;"></span></h7>
	</div>
</div>
<div class="modal-window confirmPop open" data-modal="confirmPop" style="background-color: #405470; display: none;">
	<div class="modal-box small animated zoomIn" data-animation="zoomIn" data-duration="700" 
	style="top: 0px; animation-delay: 0ms; animation-duration: 0.7s;margin-top:50%;margin-bottom:50%;">
		<span class="close-btn icon icon-office-52"></span>
		<h5 class="align-center"><span class="pinkColor confirmSub"></span></h5>
		<br/><br/>
		<h7 class="align-center"><span class="pinkColor confirmContent" style="font-size:14px;text-align:center;"></span></h7>
		<ul style="display: block;margin-left: auto;margin-right: auto;padding: 0;margin-top: 10%;">
			<a href="#none" class="pinkColor confirmN">
				<li style="display: inline-block;width: 45%;text-align: center;border: 1px solid #edc3c3 !important;margin-left: 5%;">
					취소
				</li>
			</a>
			<a href="#none" class="pinkColor confirmY" style="font-size:14px !important;">
				<li style="display: inline-block;width: 45%;text-align: center;border: 1px solid #edc3c3 !important;">
					확인
				</li>
			</a>
		</ul>
	</div>
</div>