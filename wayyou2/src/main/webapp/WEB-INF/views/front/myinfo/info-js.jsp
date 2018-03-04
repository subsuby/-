<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
$( document ).ready(function() {
	CommonScript.loading();
	//초기화
	MyInfoScript.init();
	CommonScript.loadingHide();
});

MyInfoScript = {
	//초기화
	init : function(){
		//리스트 호출
		$.ajax({
			url : '/front/myinfo/api',
			type : 'POST',
			dataType : 'json',
			data : '',
			success:function(data){
				var user = data.user;
				console.log(user);
				$('input[name=userId]').val(user.userId);
				$('input[name=userName]').val(user.userName);
				$('input[name=birth]').val(CommonScript.formatBirth(user.userBirth));
				$('input[name=phone]').val(user.userPhone);
			},
			error : function(data, status, er) {
				CommonScript.errorPop('<spring:message code="mypage.mypage"/>','<spring:message code="mypage.msg.error_no_info_retry"/>')
				console.log("error: " + JSON.stringify(data) + " status: " + status + " er:" + er);
			}
		})
	},
	changeInfo : function(){
		CommonScript.confirmPop('<spring:message code="mypage.mypage"/>','<spring:message code="mypage.msg.change_your_info"/>','MyInfoScript.changeInfoApi()');
	},
	changeInfoApi : function(){
		var phone = $('input[name=phone]').val();
		var userName = $('input[name=userName]').val();
		var blank = false;
		<!--빈칸 유효성-->
		$('#start').find('.customInput').each(function(index,ele){
			var value = $(ele).val();
			var name = $(ele).attr('name');
			if(value == ''){
				if(name == 'userName'){
					$(ele).next().attr('class','underInputR').text('')
					$(ele).next().attr('class','underInputR').append('* <spring:message code="mypage.msg.input_name"/>')
				}else if(name == 'phone'){
					$(ele).next().attr('class','underInputR').text('');
					$(ele).next().attr('class','underInputR').append('* <spring:message code="mypage.msg.input_phone"/>')
				}
				blank = true;
				return false;
			}
		})
		<!--유효성검사-->
		if(!blank){
			if(!Regex.validatePhone(phone)){
				//핸드폰 유효성 부적합
				form.find('input[name="phone"]').next().attr('class','underInputR').text('');
				form.find('input[name="phone"]').next().attr('class','underInputR').append('* <spring:message code="mypage.msg.input_phone_format"/>');
				form.find('input[name="phone"]').focus();
			}else{
				//api 호출
				$.ajax({
					url : '/front/changeInfo/api',
					type : 'POST',
					dataType : 'json',
					data : {"userName" : userName,
							"userPhone" : phone},
					success:function(data){
						location.reload();
					},
					error : function(data, status, er) {
						CommonScript.loadingHide();
						CommonScript.errorPop('<spring:message code="mypage.mypage"/>','<spring:message code="mypage.msg.error_no_info_retry"/>')
						console.log("error: " + data + " status: " + status + " er:" + er);
					}
				})
			}
		}
	}
}
</script>