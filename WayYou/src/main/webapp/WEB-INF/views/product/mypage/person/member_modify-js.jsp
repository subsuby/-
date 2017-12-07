<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
$(function() {
	/* 비밀번호 변경 */
	$("#btnPwdUpdate").click(function(){
		if(!passwordValidation()) {
			return false;
		}
		alertify.confirm('비밀번호를 변경하시겠습니까?', function(){
			var param = {
					oldPw : $("#oldPw").val(),
					password : $("#newPassword").val(),
					userId : $("#userId").val(),
					userName : $("#userName").val(),
					phoneMobile : $("#phoneMobile").val()
				}
			$.ajax({
				url : BNK_CTX + "/product/mypage/chkUpdatePw"
				, data :  JSON.stringify(param)
				, dataType : 'json'
				, type: "POST"
				, contentType: "application/json"
				, success : function(data, textStatus, jqXHR){
					if(data.resCd=="00"){
						$("#password").val($("#newPassword").val());
						alertify.alert("비밀번호를 변경하였습니다.");
						$("#btnCancel").trigger("click");
					}else if(data.resCd=="99"){
						alertify.alert("비밀번호가 다릅니다.");

					}
				},
				error: function(error){
		        }
			});
		});
	});

	/* 사용중 휴대폰번호 변경 */
	$("#phoneUpdate").click(function() {
		$.ajax({
			url : BNK_CTX + "/product/co/kcmSendData/ajax"
			, data : {urlType : "03"}
			, type : "post"
			, dataType : 'json'
			, success : function(data, textStatus, jqXHR){
				$("#tr_cert").val(data.trCert);
				$("#tr_url").val(data.trUrl)
				KMCISWindow();
			},
			error: function(error){
            }
		});
	});

	/* 주소 변경 */
	$("#btnSearchAddr").click(function() {
		$("#keyword").val($("#searchAddrName").val());
		$.ajax({
			 url  : "http://www.juso.go.kr/addrlink/addrLinkApiJsonp.do"  //인터넷망
			,type : "post"
			,data : $("#addrFrm").serialize()
			,dataType : "jsonp"
			,crossDomain : true
			,success : function(data){
				$("#list").html("");
				var errCode = data.results.common.errorCode;
				var errDesc = data.results.common.errorMessage;
				if(errCode != "0"){
					alertify.alert(errDesc);
				}else{
					if(data != null){
						addAddrListData(data);
					}
				}
			}
		    ,error: function(xhr,status, error){
		    }
		});
	});

    $("#dataList").on("click", "li", function() {
    	$("#dataList").find("li").removeClass();
    	$(this).prop("class","selected");
    	$("#selectAddrCode").val($(this).find("span").text());
    	$("#selectAddr").val($(this).find("strong").text());
    });

    $("#btnAddrSelect").click(function() {
    	$("#zipCode").val($("#selectAddrCode").val());
    	$("#addr1").val($("#selectAddr").val());
    	$("#btnAddrCancel").trigger("click");
    });

    /* 프로필 수정 */
    $("#btnUseUpdate").click(function() {
    	if($("#addr2").val() == "") {
    		alertify.alert("상세주소는 필수입니다.");
    		return false;
    	}

    	var agreeSmsYn ="N";
    	var agreePushYn ="N";
    	if($("#c_c3").prop("checked")) {
        	if(!$("#smsAcc").prop("checked")) {
        		agreeSmsYn ="Y";
        		agreePushYn ="Y";
    		}
    	}

    	var params={
    		userId				: $("#userId").val(),
    		actualPhoneMobile	: $("#actualPhoneMobile").val(),
		    email       		: $("#email").val(),
		    agreeSmsYn  		: agreeSmsYn,
		    agreePushYn 		: agreePushYn,
		    zipCode     		: $("#zipCode").val(),
		    addr1     			: $("#addr1").val(),
		    addr2     			: $("#addr2").val(),
		    division    		: "N"
		};
    	alertify.confirm('회원정보를 수정하시겠습니까?', function(){
	    	$.ajax({
				url : BNK_CTX + "/product/mypage/updateUser"
				, data : JSON.stringify(params)
				, type : "post"
				, dataType : 'json'
				, contentType: "application/json"
				, success : function(data, textStatus, jqXHR){
					alertify.alert("회원정보가 수정되었습니다.");
					location.href = "/product/mypage/mycarPerson";
				},
				error: function(error){
	            }
			});
    	});
    });

});

/* 비밀번호 유효성 검사 */
function passwordValidation() {
	if($("#oldOwd").val() == "") {
		alertify.alert("현재 비밀번호는 필수 입력입니다.");
		$("#oldOwd").focus();
		return false;
	}

	if($("#oldOwd").val() == $("#newPassword").val()) {
		alertify.alert("새로운 비밀번호가 현재 비밀번호와 동일합니다..");
		$("#newPassword").focus();
		return false;
	}

	if($("#newPassword").val() == "") {
		alertify.alert("비밀번호는 필수 입력입니다.");
		$("#newPassword").focus();
		return false;
	}

	if($("#newPasswordChk").val() == "") {
		alertify.alert("비밀번호 재확인은 필수 입력입니다.");
		$("#newPasswordChk").focus();
		return false;
	}

	if($("#newPassword").val() != $("#newPasswordChk").val()){
	    alertify.alert("비밀번호가 일치하지 않습니다.\n 다시 입력하여 주십시오.");
	    $("#newPassword").val("");
	    $("#newPasswordChk").val("");
	    $("#newPassword").focus();
	    return false;
	}
	
	//공백 금지
	var blank_pattern = /[\s]/g;
	if( blank_pattern.test($("#newPassword").val()) == true){
		alertify.alert('비밀번호는 공백없이 입력해주세요.');
	    $("#newPassword").val("");
	    $("#newPasswordChk").val("");
	    $("#newPassword").focus();		
	    return false;
	}

	if(!util.passwordCheck($("#newPassword").val())){
	    alertify.alert("비밀번호는 숫자와 영문자, 특수문자 조합으로 10~20자를 사용해야 합니다.");
	    $("#newPassword").val("");
	    $("#newPasswordChk").val("");
	    $("#newPassword").focus();
	    return false;
	}
	return true;
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
			$("#actualPhoneMobile").val(util.phoneHyphen(data.phoneNo));
		},
		error: function(error){
        }
	});
}

/* 주소검색 TAG 생성 */
function addAddrListData(data) {
	$("#dataList").html("");
	$(data.results.juso).each(function(index){
		$("#dataList").append($('<li/>', {
			id: index
		}));
		$("#"+index).append($('<strong/>', {
	        text: this.roadAddr
		}));
		$("#"+index).append($('<span/>', {
	        text: this.zipNo
		}));
	});
}

</script>