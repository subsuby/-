<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
$(function() {
	$("#pwChange").click(function(){
		if($("#newPw").val() == "") {
			alertify.alert("새 비밀번호를 입력하세요.");
			$("#newPw").focus();
			return false;
		}

		if($("#newPwChk").val() == "") {
			alertify.alert("새 비밀번호 확인을 입력하세요.");
			$("#newPwChk").focus();
			return false;
		}

		if($("#newPw").val() != $("#newPwChk").val()){
		    alertify.alert("비밀번호가 일치하지 않습니다.\n 다시 입력하여 주십시오.");
		    $("#newPw").val("");
		    $("#newPwChk").val("");
		    $("#newPw").focus();
		    return false;
		}
		
		//공백 금지
		var blank_pattern = /[\s]/g;
		if( blank_pattern.test($("#newPw").val()) == true){
			alertify.alert('비밀번호는 공백없이 입력해주세요.');
		    $("#newPw").val("");
		    $("#newPwChk").val("");
		    $("#newPw").focus();		
		    return false;
		}

		if(!util.passwordCheck($("#newPw").val())){
		    alertify.alert("비밀번호는 숫자와 영문자, 특수문자 조합으로 10~20자를 사용해야 합니다.");
		    $("#newPw").val("");
		    $("#newPwChk").val("");
		    $("#newPw").focus();
		    return false;
		}

		var params = {
			userName	: $("#name").val(),
			phoneMobile :  $("#phoneNo").val(),
			password 	:  $("#newPw").val()
		}
		$.ajax({
			url : BNK_CTX + "/product/co/changePassword"
			, data : JSON.stringify(params)
			, type : "post"
			, dataType : 'json'
			, contentType: "application/json"
			, success : function(data, textStatus, jqXHR){
				if(data.rslt != '0'){
                    alertify.alert("비밀번호가 변경 되었습니다.");
                    location.href = "/product/index";
                }else{
                    alertify.alert("비밀번호 변경 실패 하였습니다. !");
                }
			},
			error: function(error){
            }
		});
	});
});
</script>