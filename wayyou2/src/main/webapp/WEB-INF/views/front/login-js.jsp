<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
LoginScript = {
	//초기화면 이동
	goBack : function(){
		$('#login').hide("slide", { direction: "left" }, 200);
		$('#start').hide("slide", { direction: "left" }, 200, function(){
			$('#hero').show("slide", { direction: "right" }, 600);
		});
	},
	//로그인 화면이동
	goLogin : function(){
		//input 초기화
		$('#login').find('input[type=text]').val('');
		$('#login').find('input[type=password]').val('');
		//이동
		$('#hero').hide("slide", { direction: "left" }, 200, function(){
			$('#login').show("slide", { direction: "right" }, 600);
		});
	},
	//회원가입 화면 이동
	goSignUp : function(){
		//input 초기화
		$('#start').find('input[type=text]').val('');
		$('#login').find('input[type=password]').val('');
		//이동
		$('#hero').hide("slide", { direction: "left" }, 200, function(){
			$('#start').show("slide", { direction: "right" }, 600);
		});
	},
	//로그인 하기
	goMain : function(){
		//변수설정
		var form = $('#loginForm');		//회원가입 폼
		var userId = form.find('input[name="userId"]').val();
		var password = form.find('input[name="password"]').val();
		<!--유효성 초기화-->
		$('.underInputR').text('');
		var blank = false;
		<!--빈칸 유효성-->
		$('#loginForm').find('.customInput').each(function(index,ele){
			var value = $(ele).val();
			var name = $(ele).attr('name');
			if(value == ''){
				if(name == 'userId'){
					$(ele).next().attr('class','underInputR').append('* <spring:message code="login.msg.input_email"/>');
				}else if(name == 'password'){
					$(ele).next().attr('class','underInputR').append('* <spring:message code="login.msg.input_password"/>')
				}
				blank = true;
				return false;
			}
		})
		<!--유효성검사-->
		if(!blank){
			if(!Regex.validateEmail(userId)){
				//이메일 유효성 부적합
				form.find('input[name="userId"]').next().append('* <spring:message code="login.msg.input_email_format"/>');
				form.find('input[name="userId"]').focus();
			}else{
				CommonScript.loading();
				//api 호출
				$.ajax({
					url : '/front/login/api/login',
					type : 'POST',
					dataType : 'json',
					data : {"userId" : userId,
							"password" : password},
					success:function(data){
						CommonScript.loadingHide();
						if(JSON.stringify(data) == 'true'){
							//콜백
							location.href = "/front/main"
						}else{
							CommonScript.errorPop('<spring:message code="login.login"/>','<spring:message code="login.msg.there_are_no_password"/><br/><spring:message code="login.msg.please_confirm"/>')
						}
					},
					error : function(data, status, er) {
						CommonScript.loadingHide();
						CommonScript.errorPop('<spring:message code="login.login"/>','<spring:message code="login.msg.error_login_retry"/>')
						console.log("error: " + data + " status: " + status + " er:" + er);
					}
				})
			}
		}
	},
	//아이디 중복검사
	checkDuplicate : function(){
		var userId = $('#signForm').find('input[name=userId]').val();
		if(userId == ''){
			$('#signForm').find('input[name=userId]').next().next().attr('class','underInputR').append('* <spring:message code="login.msg.input_email"/>');
		}else if(!Regex.validateEmail(userId)){
			$('#signForm').find('input[name=userId]').next().next().attr('class','underInputR').append('* <spring:message code="login.msg.input_email_format"/>');
		}else{
			CommonScript.loading();
			//api 호출
			$.ajax({
				url : '/front/login/api/duplicate',
				type : 'POST',
				dataType : 'json',
				data : {"userId" : userId},
				success:function(data){
					CommonScript.loadingHide();
					console.log(data)
					if(JSON.stringify(data) == 'true'){
						$('#signForm').find('input[name=userId]').next().next().attr('class','underInput').append('* <spring:message code="login.msg.available_email"/>');
						$('#checkDup').val('Y');
					}else{
						$('#signForm').find('input[name=userId]').next().next().attr('class','underInputR').append('* <spring:message code="login.msg.duplicate_email_input_another_email"/>');
						$('#checkDup').val('N');
					}
				},
				error : function(data, status, er) {
					CommonScript.loadingHide();
					CommonScript.errorPop('<spring:message code="login.sign_in"/>','<spring:message code="login.msg.error_sign_in_retry"/>')
					console.log("error: " + data + " status: " + status + " er:" + er);
				}
			})
		}
	},
	//중복 체크 여부
	resetDup : function(){
		$('#checkDup').val('N');
	},
	//회원가입 완료
	submit : function(){
		//변수설정
		var form = $('#signForm');		//회원가입 폼
		var userId = form.find('input[name="userId"]').val();
		var password = form.find('input[name="password"]').val();
		var passwordConfirm = form.find('input[name="passwordConfirm"]').val();
		var userName = form.find('input[name="userName"]').val();
		var birth = form.find('input[name="birth"]').val();
		var phone = form.find('input[name="phone"]').val();
		<!--유효성 초기화-->
		$('.underInputR').text('');
		var blank = false;
		<!--빈칸 유효성-->
		$('#start').find('.customInput').each(function(index,ele){
			var value = $(ele).val();
			var name = $(ele).attr('name');
			if(value == ''){
				if(name == 'userId'){
					$(ele).next().next().attr('class','underInputR').append('* <spring:message code="login.msg.input_email"/>');
				}else if(name == 'password'){
					$(ele).next().attr('class','underInputR').append('* <spring:message code="login.msg.input_password"/>')
				}else if(name == 'passwordConfirm'){
					$(ele).next().attr('class','underInputR').append('* <spring:message code="login.msg.input_password_retry"/>')
				}else if(name == 'userName'){
					$(ele).next().attr('class','underInputR').append('* <spring:message code="login.msg.input_name"/>')
				}else if(name == 'birth'){
					$(ele).next().attr('class','underInputR').append('* <spring:message code="login.msg.input_birth"/>')
				}else if(name == 'phone'){
					$(ele).next().attr('class','underInputR').append('* <spring:message code="login.msg.input_phone"/>')
				}
				blank = true;
				return false;
			}
		})
		<!--유효성검사-->
		if(!blank){
			if($('#checkDup').val() != 'Y'){
				//이메일 유효성 부적합
				form.find('input[name="userId"]').next().next().append('* <spring:message code="login.msg.check_duplicate"/>');
				form.find('input[name="userId"]').focus();
			}else if(!Regex.validateEmail(userId)){
				//이메일 유효성 부적합
				form.find('input[name="userId"]').next().next().append('* <spring:message code="login.msg.input_email_format"/>');
				form.find('input[name="userId"]').focus();
			}else if(!Regex.validatePwd(password)){
				//비밀번호 유효성 부적합
				form.find('input[name="password"]').next().attr('class','underInputR').append('* <spring:message code="login.msg.password_format"/>');
				form.find('input[name="password"]').focus();
			}else if(password != passwordConfirm){
				//비밀번호 불일치
				form.find('input[name="passwordConfirm"]').next().append('* <spring:message code="login.msg.not_match_password"/>');
				form.find('input[name="passwordConfirm"]').focus();
			}else if(!Regex.validateBirth(birth)){
				//생년월일 유효성 부적합
				form.find('input[name="birth"]').next().attr('class','underInputR').append('* <spring:message code="login.msg.input_birth_format"/>');
				form.find('input[name="birth"]').focus();
			}else if(!Regex.validatePhone(phone)){
				//핸드폰 유효성 부적합
				form.find('input[name="phone"]').next().attr('class','underInputR').append('* <spring:message code="login.msg.input_phone_format"/>');
				form.find('input[name="phone"]').focus();
			}else{
				CommonScript.loading();
				//api 호출
				$.ajax({
					url : '/front/login/api/sign',
					type : 'POST',
					dataType : 'json',
					data : {"userId" : userId,
							"password" : password,
							"userName" : userName,
							"birth" : birth,
							"phone" : phone},
					success:function(data){
						CommonScript.loadingHide();
						if(JSON.stringify(data) == 'true'){
							//콜백
					 		$('.modal-window').hide();
					 		$('.signResult').show();
					 		$('.signResult').addClass('open');
					 		$('#login').hide("slide", { direction: "left" }, 200);
					 		$('#start').hide("slide", { direction: "left" }, 200, function(){
					 			$('#hero').show("slide", { direction: "right" }, 600);
					 		});
						}else{
							CommonScript.errorPop('<spring:message code="login.sign_in"/>','<spring:message code="login.msg.error_sign_in_retry"/>')
						}
					},
					error : function(data, status, er) {
						CommonScript.loadingHide();
						CommonScript.errorPop('<spring:message code="login.sign_in"/>','<spring:message code="login.msg.error_sign_in_retry"/>')
						console.log("error: " + data + " status: " + status + " er:" + er);
					}
				})
			}
		}
	},
	//아이디 패스워드 찾기 인풋 초기화
	resetInput : function(){
		$('#findIdForm').find('input[type=text]').val('');
		$('#findPwdForm').find('input[type=text]').val('');
		$('#pwdResetForm').find('input[type=text]').val('');
		$('input[name=pwdFindCode]').val('');
	},
	//아이디 찾기
	findId : function(){
		//변수설정
		var form = $('#findIdForm');		//아이디 찾기 폼
		var userName = form.find('input[name="userName"]').val();
		var userBirth = form.find('input[name="userBirth"]').val();
		var userPhone = form.find('input[name="userPhone"]').val();
		<!--유효성 초기화-->
		$('.underInputR').text('');
		var blank = false;
		<!--빈칸 유효성-->
		$('#findIdForm').find('.customInput').each(function(index,ele){
			var value = $(ele).val();
			var name = $(ele).attr('name');
			if(value == ''){
				if(name == 'userName'){
					$(ele).next().attr('class','underInputR').append('* <spring:message code="login.msg.input_name"/>');
				}else if(name == 'userBirth'){
					$(ele).next().attr('class','underInputR').append('* <spring:message code="login.msg.input_birth"/>');
				}else if(name == 'userPhone'){
					$(ele).next().attr('class','underInputR').append('* <spring:message code="login.msg.input_phone"/>');
				}
				blank = true;
				return false;
			}
		})
		<!--유효성검사-->
		if(!blank){
			if(!Regex.validateBirth(userBirth)){
				//생년월일 유효성 부적합
				form.find('input[name="userBirth"]').next().attr('class','underInputR').append('<spring:message code="login.msg.input_birth_format"/>');
				form.find('input[name="userBirth"]').focus();
			}else if(!Regex.validatePhone(userPhone)){
				//핸드폰 유효성 부적합
				form.find('input[name="userPhone"]').next().attr('class','underInputR').append('<spring:message code="login.msg.input_phone_format"/>');
				form.find('input[name="userPhone"]').focus();
			}else{
				CommonScript.loading();
				//api 호출
				$.ajax({
					url : '/front/login/api/findId',
					type : 'POST',
// 					dataType : 'json',
					data : {"userName" : userName,
							"userBirth" : userBirth,
							"userPhone" : userPhone},
					success:function(data){
						CommonScript.loadingHide();
						if(data != 'false'){
							//콜백
							$('.modal-window').hide();
							$('#idResult').append('<spring:message code="login.msg.your_id_is"/>'+data+'<spring:message code="login.msg.ipnida"/>')
							$('.idResult').show();
							$('.idResult').addClass('open');
						}else{
							CommonScript.errorPop('<spring:message code="login.find_id"/>','<spring:message code="login.msg.not_match_member_retry"/>')
						}
					},
					error : function(data, status, er) {
						CommonScript.loadingHide();
						CommonScript.errorPop('<spring:message code="login.find_id"/>','<spring:message code="login.msg.not_match_member_retry"/>')
						console.log("error: " + data + " status: " + status + " er:" + er);
					}
				})
			}
		}
	},
	//비밀번호 찾기
	findPw : function(){
		//변수설정
		var form = $('#findPwdForm');		//비밀번호 찾기 폼
		var userId = form.find('input[name="userId"]').val();
		var userName = form.find('input[name="userName"]').val();
		var userBirth = form.find('input[name="userBirth"]').val();
		var userPhone = form.find('input[name="userPhone"]').val();
		<!--유효성 초기화-->
		$('.underInputR').text('');
		var blank = false;
		<!--빈칸 유효성-->
		$('#findPwdForm').find('.customInput').each(function(index,ele){
			var value = $(ele).val();
			var name = $(ele).attr('name');
			if(value == ''){
				if(name == 'userId'){
					$(ele).next().attr('class','underInputR').append('* <spring:message code="login.msg.input_email"/>');
				}else if(name == 'userName'){
					$(ele).next().attr('class','underInputR').append('* <spring:message code="login.msg.input_name"/>');
				}else if(name == 'userBirth'){
					$(ele).next().attr('class','underInputR').append('* <spring:message code="login.msg.input_birth"/>')
				}else if(name == 'userPhone'){
					$(ele).next().attr('class','underInputR').append('* <spring:message code="login.msg.input_phone"/>')
				}
				blank = true;
				return false;
			}
		})
		<!--유효성검사-->
		if(!blank){
			if(!Regex.validateEmail(userId)){
				//이메일 유효성 부적합
				form.find('input[name="userId"]').next().attr('class','underInputR').append('* <spring:message code="login.msg.input_email_format"/>');
				form.find('input[name="userId"]').focus();
			}else if(!Regex.validateBirth(userBirth)){
				//생년월일 유효성 부적합
				form.find('input[name="userBirth"]').next().attr('class','underInputR').append('* <spring:message code="login.msg.input_birth_format"/>');
				form.find('input[name="userBirth"]').focus();
			}else if(!Regex.validatePhone(userPhone)){
				//핸드폰 유효성 부적합
				form.find('input[name="userPhone"]').next().attr('class','underInputR').append('* <spring:message code="login.msg.input_phone_format"/>');
				form.find('input[name="userPhone"]').focus();
			}else{
				CommonScript.loading();
				//api 호출
				$.ajax({
					url : '/front/login/api/findPwd',
					type : 'POST',
// 					dataType : 'json',
					data : {"userId" : userId,
							"userName" : userName,
							"userBirth" : userBirth,
							"userPhone" : userPhone},
					success:function(data){
						CommonScript.loadingHide();
						if(data == 'true'){
							//콜백
							$('.modal-window').hide();
							$('.pwResult').show();
							$('.pwResult').addClass('open');
						}else{
							CommonScript.errorPop('<spring:message code="login.find_pwd"/>', '<spring:message code="login.msg.not_match_member_retry"/>');
						}
					},
					error : function(data, status, er) {
						CommonScript.loadingHide();
						CommonScript.errorPop('<spring:message code="login.find_pwd"/>', '<spring:message code="login.msg.error_find_password_retry"/>')
						console.log("error: " + data + " status: " + status + " er:" + er);
					}
				})
			}
		}
	},
	//비밀번호 재설정화면
	pwReset : function(){
		//비밀번호 변경코드
		var pwdFindCode = $('input[name="pwdFindCode"]').val();
		var userId = $('#findPwdForm').find('input[name="userId"]').val();
		<!--유효성 초기화-->
		$('.underInputR').text('');
		var blank = false;
		<!--빈칸 유효성-->
		if(pwdFindCode == ''){
			$('input[name="pwdFindCode"]').next().attr('class','underInputR').append('* <spring:message code="login.msg.input_password_reset_code"/>');
			blank = true;
		}
		if(!blank){
			CommonScript.loading();
			//api 호출
			$.ajax({
				url : '/front/login/api/confirmPwdCode',
				type : 'POST',
//					dataType : 'json',
				data : {"pwdFindCode" : pwdFindCode,
						"userId" : userId},
				success:function(data){
					CommonScript.loadingHide();
					if(data == 'true'){
						//콜백
						$('.modal-window').hide();
						$('.pwReset').show();
						$('.pwReset').addClass('open');
					}else{
						CommonScript.errorPop('<spring:message code="login.find_pwd"/>','<spring:message code="login.msg.not_match_password_code"/>');
					}
				},
				error : function(data, status, er) {
					CommonScript.loadingHide();
					CommonScript.errorPop('<spring:message code="login.find_pwd"/>','<spring:message code="login.msg.error_find_password_retry"/>')
					console.log("error: " + data + " status: " + status + " er:" + er);
				}
			})
		}
	},
	//비밀번호 재설정컨펌
	pwResetConfirm : function(){
		//변수설정
		var form = $('#pwdResetForm');		//비밀번호 재설정 폼
		var userId = $('#findPwdForm').find('input[name="userId"]').val();
		var password = form.find('input[name="password"]').val();
		var passwordConfirm = form.find('input[name="passwordConfirm"]').val();
		<!--유효성 초기화-->
		$('.underInputR').text('');
		var blank = false;
		<!--빈칸 유효성-->
		$('#pwdResetForm').find('.customInput').each(function(index,ele){
			var value = $(ele).val();
			var name = $(ele).attr('name');
			if(value == ''){
				if(name == 'password'){
					$(ele).next().attr('class','underInputR').append('* <spring:message code="login.msg.input_password"/>');
				}else if(name == 'passwordConfirm'){
					$(ele).next().attr('class','underInputR').append('* <spring:message code="login.msg.input_password_retry"/>');
				}
				blank = true;
				return false;
			}
		})
		<!--유효성검사-->
		if(!blank){
			if(!Regex.validatePwd(password)){
				//비밀번호 유효성 부적합
				form.find('input[name="password"]').next().attr('class','underInputR').append('* <spring:message code="login.msg.password_format"/>');
				form.find('input[name="password"]').focus();
			}else if(password != passwordConfirm){
				//비밀번호 불일치
				form.find('input[name="passwordConfirm"]').next().attr('class','underInputR').append('* <spring:message code="login.msg.not_match_password"/>');
				form.find('input[name="passwordConfirm"]').focus();
			}else{
				CommonScript.loading();
				//api 호출
				$.ajax({
					url : '/front/login/api/pwdReset',
					type : 'POST',
					dataType : 'json',
					data : {"userId" : userId,
							"password" : password},
					success:function(data){
						CommonScript.loadingHide();
						if(JSON.stringify(data) == 'true'){
							//콜백
							$('.modal-window').hide();
							$('.pwResetResult').show();
							$('.pwResetResult').addClass('open');
						}else{
							CommonScript.errorPop('<spring:message code="login.find_pwd"/>', '<spring:message code="login.msg.error_find_password_retry"/>');
						}
					},
					error : function(data, status, er) {
						CommonScript.loadingHide();
						CommonScript.errorPop('<spring:message code="login.find_pwd"/>', '<spring:message code="login.msg.error_find_password_retry"/>');
						console.log("error: " + data + " status: " + status + " er:" + er);
					}
				})
			}
		}
	}
}
</script>