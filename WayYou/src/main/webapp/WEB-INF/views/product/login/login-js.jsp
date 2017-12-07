<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
$(function() {

    // 페이지가 로드될때 로컬스토리지에 값을 가져온다.
	var logInfo = localStorage.getObject("logInfo");
	if(util.isNotEmpty(logInfo)){
		if(logInfo.ch1){
			$("#userName").val(logInfo.userName);
			$("#phoneMobile").val(logInfo.phoneMobile);
			$("#ch1").prop("checked", true);
		}

		if(logInfo.ch2){
			$("#password").val(logInfo.password);
			$("#ch2").prop("checked", true);
		}
	}

	// 전화번호 입력창에서 포커스가 빠졌을때
	$("#phoneMobile").on('blur', function() {
		if(this.value != ""){
			this.value = util.phoneHyphen(this.value.replace(/[^0-9]/g,''));
		}
	});
	$("#phoneMobile").on('input',function() {
		if(this.value != ""){
			this.value = this.value.replace(/[^0-9]/g,'');
		}
	});

	// 비밀번호 찾기 버튼을 눌렀을 때
	$("#passBtn").click(function(){
		location.href = '<c:url value="/product/co/pwResetBefore"/>';
	});

	// 회원가입 버튼을 눌렀을 때
	$("#joinBtn").click(function(){
		location.href = '<c:url value="/product/co/joinKind"/>';
	});

	// 로그인 버튼을 눌렀을 때
	$("#btnLogin").click(function(){
		login();
	});
});

function login(){
	var login = new Object();
	var userName = $.trim($("#userName").val());
	var phoneMobile = $.trim($("#phoneMobile").val());
	var password = $.trim($("#password").val());
	var ch1 = $("#ch1").is(':checked');
	var ch2 = $("#ch2").is(':checked');

	if(userName == ""){
		alertify.alert("성명은 공백없이 입력해주세요.");
		$("#userName").focus();
		return;
	}

	if(phoneMobile == ""){
		alertify.alert("휴대폰 번호를 입력해주세요.");
		$("#phoneMobile").focus();
		return;
	}

	if(!/\b\d{3}[-]?\d{3,4}[-]?\d{4}\b/.test(phoneMobile)){
		alertify.alert('휴대전화의 입력형식이 올바르지 않습니다.\n숫자만 입력해 주세요.');
		$("#phoneMobile").focus();
		return;
	}

	if(password == ""){
		alertify.alert("비밀번호를 입력해주세요.");
		$("#password").focus();
		return;
	}

	$.ajax({
		method: 'POST',
		url: BNK_CTX + "/product/co/customLogin",
		data: $("#login_form").serialize()
	})
	.success(function(oRes){
		// 성공
		if(oRes.code == "00"){
			login.ch1 = ch1;
			login.ch2 = ch2;

			if(ch1){
				login.userName = userName;
				login.phoneMobile = phoneMobile;
			}

			if(ch2){
				login.password = password;
			}
			localStorage.setObject("logInfo", login);
			var moveUrl = oRes.moveUrl;

			if(util.isEmpty(moveUrl)){
				location.href = '<c:url value="/product/index"/>';
			}else{
				if(moveUrl == "/product/mypage/mycarPerson"){
					var oDivision = oRes.data.sessUserInfo.division;
					if(oDivision == 'D'){
						location.href = '<c:url value="/product/mypage/mycarDealer"/>';
					}else{
						location.href = BNK_CTX + moveUrl;
					}
				}else{
					location.href = BNK_CTX + moveUrl;
				}
			}
		}
		// 이름, 핸드폰 번호 불일치
		else if(oRes.code == "01"){
			alertify.alert("입력하신 정보와 일치하는 사용자가 존재하지 않습니다. \n다시 한번 확인해 주세요");
		}
		// 비밀번호 오류
		else if(oRes.code == "02"){
			alertify.alert("비밀번호를 잘못 입력하셨습니다.");
			// 비밀번호를 틀릴경우 비밀번호 저장 해제
			$("#ch2").prop("checked", false);	// 비밀번호 저장 해제
		}
	})
	.error(function(data, status, headers, config) {
		/* 서버와의 연결이 정상적이지 않을 때 처리 */
		console.log(status);
	});
}
</script>