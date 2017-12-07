</script><%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
$(function() {
	/* 비밀번호 변경 */
	$("#btnPwdUpdate").click(function(){
		if(!passwordValidation()) {
			return false();
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
					$("#password").val($("#newPassword").val());
					alertify.alert("비밀번호를 변경하였습니다.");
					$("#btnCancel").trigger("click");
				},
				error: function(error){
		        }
			});
		});
	});

	$("#btnPwdPop").click(function(){
		$("input[type=password]").val("");
	})

	/* 사용중 휴대폰번호 변경 */
	$("#phoneUpdate").click(function() {
		$.ajax({
			url : BNK_CTX + "/product/co/kcmSendData/ajax"
			, data : {urlType : "04"}
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

	$("#btnAddrPop").click(function() {
		$("#keyword").val("");
		$("#searchAddrName").val("");
		$("#dataList").html("");
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
		    division    : "D",
		    danjiNo     : $("#danjiNo").val(),
		    shopNo    	: $("#shopNo").val(),
		    shopEtc		: $("#shopEtc").val(),
		    dealerDanjiName	: $("#dealerDanjiName").val(),
		    dealerShopName	: $("#dealerShopName").val(),
		    dealerLicenseNo	: $("#dealerLicenseNo").val()
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
					//location.reload();
					location.href = "/product/mypage/mycarDealer";
				},
				error: function(error){
	            }
			});
    	});
    });

    /* 소속 찾기 */
    $("#btnGroupSearch").click(function() {
    	if($("#searchGroupName").val() == "") {
    		alertify.alert("검색어를 입력하여 주세요.");
    		$("#searchName").focus();
    		return false;
    	}
    	if($("#groupType").val() == "0") {
    		searchGroup();
    	} else {
    		searchFirm();
    	}
    });

    $("#btnGroup").click(function() {
    	clearGroupData();
    	$("#groupType").val("0");
    	$("#groupPopup .group >header>h1").text("소속단지찾기");
    });

    $("#btnShop").click(function() {
    	clearGroupData();
    	$("#groupType").val("1");
    	$("#groupPopup >header>h1").text("소속상사찾기");
    	searchFirm();
    });


    // 소속 찾기 선택
    $("#dataGroupList").on("click", "li", function() {
    	$("#dataGroupList").find("li").removeClass();
    	$(this).prop("class","selected");
    	$("#selectGroupNo").val($(this).val());
    	$("#selectGroupName").val($(this).text());
    });

    $("#groupSuccess").click(function() {
    	if($("#selectGroupNo").val() == "") {
    		alertify.alert("소속을 선택하여 주세요.");
    		return false;
    	}
    	if($("#groupType").val() == 0) {
    		$("#danjiNo").val($("#selectGroupNo").val());
    		$("#dealerDanjiName").val($("#selectGroupName").val());
    		$("#groupCancel").trigger("click");
    	} else {
    		$("#shopNo").val($("#selectGroupNo").val());
    		$("#dealerShopName").val($("#selectGroupName").val());
    		$("#groupCancel").trigger("click");
    	}
    });

    /* 종사자 */
    $("#btnLicense").click(function() {
		$("#oldDealerLicenseNo").val("");
		$("#newDealerLicenseNo").val("");
		$("#newDealerLicenseNoChk").val("");
	});

    $("#btnDealerUpdate").click(function() {
    	if($("#oldDealerLicenseNo").val() =="") {
    		alertify.alert("현재 종사자번호는 필수입니다.");
    		$("#oldDealerLicenseNo").fucus();
    		return false;
    	}

    	if($("#newDealerLicenseNo").val() =="") {
    		alertify.alert("새로운 종사자번호는 필수입니다.");
    		$("#newDealerLicenseNo").fucus();
    		return false;
    	}

    	if($("#newDealerLicenseNoChk").val() =="") {
    		alertify.alert("다시한번 종사자번호는 필수입니다.");
    		$("#newDealerLicenseNoChk").fucus();
    		return false;
    	}

    	if($("#newDealerLicenseNo").val() != $("#newDealerLicenseNoChk").val()) {
    		alertify.alert("새로운 종사자번호가 같지 않습니다.");
    		$("#newDealerLicenseNo").val("");
    		$("#newDealerLicenseNoChk").val("");
    		$("#newDealerLicenseNo").fucus();
    		return false;
    	}

		alertify.confirm('종사자번호를 변경하시겠습니까?', function(){
    		var param = {
    			userId : $("#userId").val(),
    			userName : $("#userName").val(),
    			dealerNoCurrent : $("#oldDealerLicenseNo").val(),
    			dealerLicenseNo : $("#newDealerLicenseNo").val()
    		}
	    	$.ajax({
	    		url : BNK_CTX + "/product/mypage/changeDealerNo"
	    		, data :  JSON.stringify(param)
	    		, dataType : 'json'
	    		, type: "post"
	    		, contentType: "application/json"
	    		, success : function(data, textStatus, jqXHR){
	    			if(data.resCd == '00'){
	    				alertify.alert("종사자번호가 변경되었습니다.");
		    			$("#dealerLicenseNo").val(data.dealerLicenseNo);
		    			$("#btnDealerCancel").trigger("click");
	            	}else if(data.resCd =='10'){
		            	alertify.alert("종사자 번호가 일치하지않습니다.");
	            	}else {
		            	alertify.alert("알 수 없는 오류가 발생했습니다.");
	            	}
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

/* 소속 초기화 */
function clearGroupData() {
	$("#selectGroupNo").val("");
	$("#selectGroupName").val("");
	$("#searchGroupName").val("");
	$("#dataGroupList").html("");
}

function searchGroup() {
	var param = {danjiFullName : $("#searchGroupName").val()};
	$.ajax({
		url : BNK_CTX + "/product/co/searchGroup"
		, data :  JSON.stringify(param)
		, dataType : 'json'
		, type: "post"
		, contentType: "application/json"
		, success : function(data, textStatus, jqXHR){
			$("#dataGroupList").html("");
			for(var i=0; i<data.carGroupList.length; i++) {
        		$("#dataGroupList").append($('<li/>', {
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
	var param = {danjiNo : $("#danjiNo").val(), shopFullName : $("#searchGroupName").val()};

	$.ajax({
		url : BNK_CTX + "/product/co/searchFirm"
		, data :  JSON.stringify(param)
		, dataType : 'json'
		, type: "post"
		, contentType: "application/json"
		, success : function(data, textStatus, jqXHR){
			$("#dataGroupList").html("");
			for(var i=0; i<data.carFirmList.length; i++) {
        		$("#dataGroupList").append($('<li/>', {
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