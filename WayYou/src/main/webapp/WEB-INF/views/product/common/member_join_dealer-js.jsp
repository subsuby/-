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
				$("#tr_url").val(data.trUrl);
				KMCISWindow();
			},
			error: function(error){
            }
		});
	});

	$(".loginLayout input[name=gender]").on('click', function(){
		$(this).closest('span').addClass('on').siblings('span').removeClass('on'	);
	});

	function maxLengthCheck( object ) {
		object.value = object.value.replace(/[^0-9]/g, '');
	    if ( object.value.length > object.maxLength ) {
	        object.value = value.substring(0, object.maxLength);
	    }
	}

    $("#btnJoin").click(function(){
		if($("#phoneCert").val() != "Y") {
    		alertify.alert("휴대전화 인증이 완료 되지 않았습니다.");
    		return false;
    	}
    	if(!passwordValidation()) {
			return false;
		}

    	if($("#danjiNo").val() == "") {
    		alertify.alert("소속단지는 필수 입력입니다.");
    		return false;
    	}

    	if($("#shopNo").val() == "") {
    		alertify.alert("소속상사는 필수 입력입니다.");
    		return false;
    	}

    	if($("#dealerLicenseNo").val() == "") {
    		alertify.alert("종사자번호는 필수 입력입니다.");
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
			    division    : "D",
			    danjiNo     : $("#danjiNo").val(),
			    shopNo    	: $("#shopNo").val(),
			    shopEtc		: $("#shopEtc").val(),
			    dealerDanjiName	: $("#dealerDanjiName").val(),
			    dealerShopName	: $("#dealerShopName").val(),
			    dealerLicenseNo	: $("#dealerLicenseNo").val()
			};

			$.ajax({
				url : BNK_CTX + "/product/co/insertUser"
				, data : JSON.stringify(params)
				, dataType : 'json'
				, type: "post"
				, contentType: "application/json"
				, success : function(data, textStatus, jqXHR){
					alertify.alert(data.resCd);
					//검색한 리스트
	                if(data.rsltDealer == 'N'){
	                    alertify.alert("유효하지않은 종사자번호 입니다.");
	                } else if(data.chkDealer == '1'){
	                    alertify.alert("이미 등록 된 종사자번호 입니다.");
	                } else if(data.result != '0'){
	                    alertify.alert("이미 등록 된 회원 입니다.");
	                } else {
	                    location.href = "/product/index";
	                }
				},
				error: function(error){
	            }
			});
    	});
    });

    $("#btnSearch").click(function() {
    	if($("#searchName").val() == "") {
    		alertify.alert("검색어를 입력하여 주세요.");
    		$("#searchName").focus();
    		return false;
    	}
    	if($("#type").val() == "0") {
    		searchGroup();
    	} else {
    		searchFirm();
    	}
    });

    $("#btnGroup").click(function() {
    	clearData();
    	$("#type").val("0");
    	$(".popupHeaderAuto >header>h1").text("소속단지찾기");
    });

    $("#btnShop").click(function() {
    	clearData();
    	$("#type").val("1");
    	$(".popupHeaderAuto >header>h1").text("소속상사찾기");
    	searchFirm();
    });

    // 소속 찾기 선택
    $("#dataList").on("click", "li", function() {
    	$("#dataList").find("li").removeClass();
    	$(this).prop("class","selected");
    	$("#selectNo").val($(this).val());
    	$("#selectName").val($(this).text());
    });

    $("#success").click(function() {
    	if($("#selectNo").val() == "") {
    		alertify.alert("소속을 선택하여 주세요.");
    		return false;
    	}
    	if($("#type").val() == 0) {
    		$("#danjiNo").val($("#selectNo").val());
    		$("#dealerDanjiName").val($("#selectName").val());
    		$("#cancel").trigger("click");
    	} else {
    		$("#shopNo").val($("#selectNo").val());
    		$("#dealerShopName").val($("#selectName").val());
    		$("#cancel").trigger("click");
    	}
    });
});

function maxLengthCheck( object ) {
    if ( object.value.length > object.maxLength ) {
        object.value = object.value.slice(0, object.maxLength);
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
/*
	핸드폰인증후 작업
*/
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

function clearData() {
	$("#selectNo").val("");
	$("#selectName").val("");
	$("#searchName").val("");
	$("#dataList").html("");
}

function searchGroup() {
	var param = {danjiFullName : $("#searchName").val()};
	$.ajax({
		url : BNK_CTX + "/product/co/searchGroup"
		, data :  JSON.stringify(param)
		, dataType : 'json'
		, type: "post"
		, contentType: "application/json"
		, success : function(data, textStatus, jqXHR){
			$("#dataList").html("");
			for(var i=0; i<data.carGroupList.length; i++) {
        		$("#dataList").append($('<li/>', {
        			value: data.carGroupList[i].danjiNo
        	        , text: data.carGroupList[i].danjiFullName
        		}));
        	}
		},
		error: function(error){
        }
	});
}

function searchFirm() {
	var param = {danjiNo : $("#danjiNo").val(), shopFullName : $("#searchName").val()};

	$.ajax({
		url : BNK_CTX + "/product/co/searchFirm"
		, data :  JSON.stringify(param)
		, dataType : 'json'
		, type: "post"
		, contentType: "application/json"
		, success : function(data, textStatus, jqXHR){
			$("#dataList").html("");
			for(var i=0; i<data.carFirmList.length; i++) {
        		$("#dataList").append($('<li/>', {
        			value: data.carFirmList[i].shopNo
        	        , text: data.carFirmList[i].shopFullName
        		}));
        	}
		},
		error: function(error){
        }
	});
}
</script>