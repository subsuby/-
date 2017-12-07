<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
$(function() {
	$("#btnAccr").click(function(){
		if($("#name").val() == "") {
			alertify.alert("성명은 공백없이 입력해주세요.");
			$("#name").focus();
			return false;
		}

		if($("#phoneNo").val() == "") {
			alertify.alert("휴대폰번호를 입력해주세요.");
			$("#phoneNo").focus();
			return false;
		}

		if(!/\b\d{3}[-]?\d{3,4}[-]?\d{4}\b/.test($("#phoneNo").val())){
			alertify.alert('휴대전화의 입력형식이 올바르지 않습니다.\n숫자만 입력해 주세요.');
			$("#phoneNo").focus();
			return false;
		}

		var params = {
			userName 		: $("#name").val(),
			phoneMobile :  $("#phoneNo").val().replace(/-/g, '')
		}
		$.ajax({
			url : BNK_CTX + "/product/co/searchUserInfo"
			, data : JSON.stringify(params)
			, type : "post"
			, dataType : 'json'
			, contentType: "application/json"
			, success : function(data, textStatus, jqXHR){
				 if(data.rslt != '0'){
					 KMCISWindow();
	               }else{
	                   alertify.alert("입력한 정보의 사용자 정보가 없습니다.");
	               }
			},
			error: function(error){
            }
		});
	});

	// 전화번호 입력창에서 포커스가 빠졌을때
	$("#phoneNo").on('blur', function() {
		if(this.value != ""){
			this.value = util.phoneHyphen(this.value.replace(/[^0-9]/g,''));
		}
	});
	
	$("#phoneNo").on('input',function() {
		if(this.value != ""){
			this.value = this.value.replace(/[^0-9]/g,'');
		}
	});
});
function onInput(elem, code){
	switch(code){
	case 'PHONE_NO':
		elem.value = elem.value.replace(/[^0-9]/g,'');
		break;
	}
}
/* 핸드폰 인증 */
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

/* 핸드폰인증후 처리 */
function KMCISAccOk(rec_cert, certNum) {
	var param = {rec_cert : rec_cert, certNum : certNum};
	$.ajax({
		url : BNK_CTX + "/product/co/kmcResult"
		, data : param
		, dataType : 'json'
		, type: "post"
		, success : function(data, textStatus, jqXHR){
			$("#frm").attr("target", "_self");
			$("#frm").attr("action", "/product/co/pwReset");
			$("#frm").submit();
		},
		error: function(error){
        }
	});
}
</script>