<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
$(function() {
	//엔터누르면 팝업창 띄워지는거 막음
	$("input").on("keypress", function(e){
		if(e.keyCode === 13){
			e.preventDefault();
		}
	});
	//$("#accSuccDiv").hide();
	$("#phoneAcc").click(function() {
		if($("#name").val() == "") {
			$("#name").focus();
			alertify.alert("성명을 입력하여주세요");
			return false;
		}

		if(!passwordValidation()) {
			return false;
		}

        if($("#year").val() == "" || $("#year").val().length < 4) {
			alertify.alert("생년월일읠 년(4자)는 필수 입력입니다.");
			$("#year").focus();
			return false;
		}

        if($("#month option:selected").val() == "") {
			alertify.alert("생년월일읠 월은 필수 입력입니다.");
			$("#month").focus();
			return false;
		}

        if($("#day option:selected").val() == "") {
			alertify.alert("생년월일읠 일은 필수 입력입니다.");
			$("#month").focus();
			return false;
		}

        if($("#email").val() == "") {
			alertify.alert("이메일은 필수 입력입니다.");
			$("#email").focus();
			return false;
		}

        if(!util.emailCheck($("#email").val())){
			alertify.alert("이메일 형식을 올바르게 입력하여 주세요.");
			$("#email").focus();
			return false;
		}

		if($("#phoneNo").val() == "") {
			alertify.alert("휴대폰번호는 필수 입력입니다.");
			$("#phoneNo").focus();
			return false;
		}

		if(!util.phoneCheck($("#phoneNo").val())){
			alertify.alert("휴대폰번호는 형식을 올바르게 입력하여 주세요.");
			$("#phoneNo").focus();
			return false;
		}

		$.ajax({
			url : BNK_CTX + "/product/co/kcmSendData/ajax"
			, data : $("#frm").serialize()
			, type : "post"
			, dataType : 'json'
			, success : function(data, textStatus, jqXHR){
				$("#tr_cert").val(data.trCert);
				$("#tr_url").val(data.trUrl)
				KMCISWindow();
			},
			error: function(error){
				alertify.alert("본인 실패하였습니다.");
                alertify.alert(error);
            }
		});
	});


	$(".loginLayout input[name=gender]").on('click', function(){
		$(this).closest('span').addClass('on').siblings('span').removeClass('on'	);
	});


    $("#btnJoin").click(function(){
		if($("#phoneCert").val() != "Y") {
    		alertify.alert("휴대전화 인증이 완료 되지 않았습니다.");
    		return false;
    	}
    	if(!passwordValidation()) {
			return false;
		}

    	alertify.confirm('회원가입을 하시겠습니까?', function(){
	    	var agreeSmsYn ="N";
	    	var agreePushYn ="N";
	    	if($("#smsAcc").prop("checked")) {
	    		agreeSmsYn ="Y";
	    		agreePushYn ="Y";
			}
			var params={
			    userName    : $("#name").val(),
			    phoneMobile : $("#phoneNo").val(),
			    password    : $("#pwd").val(),
			    email       : $("#email").val(),
			    agreeSmsYn  : agreeSmsYn,
			    agreePushYn : agreePushYn,
			    division    : "N"
			};

			$.ajax({
				url : BNK_CTX + "/product/co/insertUser"
				, data : JSON.stringify(params)
				, dataType : 'json'
				, type: "post"
				, contentType: "application/json"
				, success : function(data, textStatus, jqXHR){
					if(data.result == '1'){
	                    alertify.alert("중복된 사용자 입니다.");
	                    return;
	                }else{
	                    location.href = "/product/index";
	                }
				},
				error: function(error){
	            }
			});
    	});
    });
});

function maxLengthCheck( object ) {
	object.value = object.value.replace(/[^0-9]/g, '');
    if ( object.value.length > object.maxLength ) {
        object.value = value.substring(0, object.maxLength);
    }
}

function passwordValidation() {
	if($("#pwd").val() == "") {
		alertify.alert("비밀번호는 필수 입력입니다.");
		$("#pwd").focus();
		return false;
	}

	if($("#pwdChk").val() == "") {
		alertify.alert("비밀번호 재확인은 필수 입력입니다.");
		$("#pwdChk").focus();
		return false;
	}

	if($("#pwd").val() != $("#pwdChk").val()){
	    alertify.alert("비밀번호가 일치하지 않습니다.\n 다시 입력하여 주십시오.");
	    $("#pwd").val("");
	    $("#pwdChk").val("");
	    $("#pwd").focus();
	    return false;
	}
	
	//공백 금지
	var blank_pattern = /[\s]/g;
	if( blank_pattern.test($("#pwd").val()) == true){
		alertify.alert('비밀번호는 공백없이 입력해주세요.');
	    $("#pwd").val("");
	    $("#pwdChk").val("");
	    $("#pwd").focus();		
	    return false;
	}	

	if(!util.passwordCheck($("#pwd").val())){
	    alertify.alert("비밀번호는 숫자와 영문자, 특수문자 조합으로 10~20자를 사용해야 합니다.");
	    $("#pwd").val("");
	    $("#pwdChk").val("");
	    $("#pwd").focus();
	    return false;
	}
	return true;
}


function KMCISWindow() {
	var KMCIS_window;
	var UserAgent = navigator.userAgent;
	/* 모바일 접근 체크*/
	// 모바일일 경우 (변동사항 있을경우 추가 필요)
	if (UserAgent.match(/iPhone|iPod|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson/i) != null || UserAgent.match(/LG|SAMSUNG|Samsung/) != null) {
		 document.reqKMCISForm.target = '';
	  	}

	// 모바일이 아닐 경우
	else {
		KMCIS_window = window.open('', 'KMCISWindow', 'width=425, height=550, resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=435, top=250' );
		if(KMCIS_window == null){
				alertify.alert(" ※ 윈도우 XP SP2 또는 인터넷 익스플로러 7 사용자일 경우에는 \n    화면 상단에 있는 팝업 차단 알림줄을 클릭하여 팝업을 허용해 주시기 바랍니다. \n\n※ MSN,야후,구글 팝업 차단 툴바가 설치된 경우 팝업허용을 해주시기 바랍니다.");
		}
		$("#reqKMCISForm").attr("target", "KMCISWindow");
	}
	$("#reqKMCISForm").attr("action", "https://www.kmcert.com/kmcis/web/kmcisReq.jsp");
	$("#reqKMCISForm").submit();
}

function KMCISAccOk(rec_cert, certNum) {
	$("#name").attr("readonly", true);
	$("#year").attr("readonly", true);
	$("#month").attr("readonly", true);
	$("#month option").not(":selected").attr("disabled", "disabled");
	$("#day option").not(":selected").attr("disabled", "disabled");
	$("#phoneCorp option").not(":selected").attr("disabled", "disabled");
	$("#phoneNo").attr("readonly", true);
	$("#phoneCert").val("Y");

	$("#accDiv").hide();
	$("#accSuccDiv").show();
}
</script>