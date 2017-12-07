<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
var param = {};
$(function() {
	// 페이지가 로드될 때 리스트 조회
	mycar_list(1);
	// 공통 제조사콤보를 가져온다.
	$.fn.makerCombo("makerCombo");

	// 연식 숫자만 입력가능하게
	$('#carRegYear').keyup(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
	});

	// 검색 버튼을 눌렀을 때
	$("#btnSearch").click(function(){

		var carFullCode = "";
		var makerCd = $("#makerCombo").val();
		var modelCd = $("#modelCombo").val();

		param.carPlateNum = $("#carPlateNum").val();
		param.carRegYear = $("#carRegYear").val();
		param.startDate = $("#searchStartDt").val();
		param.endDate = $("#searchEndDt").val();

		if(modelCd != ""){
			carFullCode = modelCd;
		}else{
			carFullCode = makerCd;
		}

		param.carFullCode = carFullCode;

		console.log(param.carFullCode);
		mycar_list(1);
	});

	// 매물 등록 버튼을 눌렀을 때
	$(".enrollment").click(function(){
		location.href = '<c:url value="/product/mypage/mycarDealerForwarding"/>';
	});

	// 초기화 버튼을 눌렀을 때
	$("#btnClear").click(function(){
		// 제조사 셀렉트박스를 초기화한다.
		$.fn.makerCombo("makerCombo");

		// 모델 셀렉트박스를 초기화한다.
		$("#modelCombo").html("<option value=''>모델</option>");

		// 차량번호를 초기화한다.
		$("#carPlateNum").val("");

		// 연식을 초기화한다.
		$("#carRegYear").val("");

		// 검색 등록일자를 초기화한다
		$("#searchStartDt").val("");

		// 검색 종료일자를 초기화한다
		$("#searchEndDt").val("");

		param = {};

		mycar_list(1);
	});

	// 제조사 셀렉트 박스를 변경 했을 때
	$("#makerCombo").change(function(){
		$.fn.modelCombo("modelCombo", $(this).val());
	});


});

function mycar_list(curPage){

	$.ajax({
		url : BNK_CTX + '/product/mypage/mycarDealerList/AJAX',
		dataType : 'html',
		cache : false,
		data : {
			curPage : curPage,
			carPlateNum : param.carPlateNum,
			carRegYear : param.carRegYear,
			startDate : param.startDate,
			endDate :  param.endDate,
			carFullCode : param.carFullCode
		},
		success : function(detailResult){
			//총 리스트 갯수 가져오기
			var cnt = $(detailResult).find('.cnt').val();
			$(".totalCnt").text(cnt);
			//템플릿 붙여넣기
			$("#templateList").html(detailResult);
		},
		error : function(request,status,error){
			alertify.alert(error);
		}
	});
}

//매물관리상세팝업초기화
function mycar_detail_pop_init(){
	/* 주소 변경 */
	$("#btnSearchAddr").click(function() {
		searchAddr();
	});
	$("#searchAddrName").keypress(function(e){
		if(e.keyCode === 13){
			searchAddr();
		}
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


	//파일 업로드
	$('.mycarImage input[type=file]').fileupload({
		url: '/product/mypage/fileUpload/AJAX'
		, dataType: 'json'
		, done: function(e, data){
			var blob=new Blob(data.files, {type: "octet/stream"});
            var url = URL.createObjectURL(blob);
            var $ul = $(this).closest('ul');
            var $uploader = $('#uploader');
            var $li_clone = $uploader.clone();

            //step 1. 사진등록 완료 li
            $li_clone
            .find('.imgFileDelete').show().end()
            .find('.imgFileUp').hide().end()
            .find('img').prop('src', url);

            //step 2. 사진 삭제 기능
            $li_clone
            .find('.imgFileDelete')
            .on('click', function(){
				$li_clone.remove();		//업로드된 파일 삭제
				$uploader.show();		//사진등록버튼 표출
            });
            //step 3. 가져온 fileseq hidden으로 등록
            $li_clone
            .append($('<input>', {
				type: 'hidden'
				, name: 'fileSeqs[]'
				, value: data.result.fileSeq
			}));

			//step 4. 다음 사진등록 대기 li 추가
			$uploader.before($li_clone);

			//step 5. 업로드 갯수제한 처리
			var allowFileCount = $('.mycarImage .imgFileDelete:visible').length;
			if(allowFileCount === 20){
				$uploader.hide();
			}
		}
	});
}
//매물관리상세팝업열기
function mycar_detail_pop(elem, data){
	console.log(data);
	$.ajax({
		url : BNK_CTX + '/product/mypage/mycarDealerDetailPop/AJAX',
		dataType : 'html',
		cache : false,
		data : {carSeq: data },
		success : function(detailResult){
			$("#detailPop").html(detailResult);
			mycar_detail_pop_init();
			$(elem).next('input').trigger('click');
		},
		error : function(request,status,error){
			alertify.alert(error);
		}
	});
}
//매물관리상세팝업 파일삭제
function mycar_detail_pop_file_delete(elem){
	var $btn = $(elem);
	$('#uploader').show();		//사진등록버튼 표출
	$btn.closest('li').remove();
}


//콤보박스 그리기
function render_combo($select, data){
	$select.empty();
	for(var key in data){
		var $option = $('<option>');
		$option.val(key);
		$option.text(data[key]);
		$select.append($option);
	}
	$select.trigger('change');
}
//차량모델리스트 가져오기
function model_list(makerCd, name){
	$.ajax({
		url : BNK_CTX + "/product/co/modelCombo"
		, data : {makerCd : makerCd}
		, dataType : 'json'
		, type: "get"
		, contentType: "application/json; charset=UTF-8"
		, success : function(data){
			var $select = $('select[name='+name+']');
			render_combo($select, data);
		},
		error: function(error){
			alertify.alert("데이터 통신상태가 원활하지 않습니다.");
			console.log(status);
        }
	});
}
function checkAll(id, elem){
	$('input[id^='+id+']').prop('checked', $(elem).prop('checked'));
}
function setArea(elem){
	var txt = $('textarea[name=carDesc]').val();
	//체크박스를 라디오버튼 처럼
	//$(elem).closest('.explain').find(':checkbox').not(elem).prop('checked', false);		//현재 선택된 체크박스를 제외한 모든 체크박스 해제

	//체크되어있으면 매크로 문자열 입력
	if($(elem).is(':checked')){
		$('textarea[name=carDesc]').val(txt + elem.value + '\n');
	//체크되어있지않으면 매크로 문자열 제거
	}else{
		$('textarea[name=carDesc]').val(txt.replace(elem.value + '\n', ''));
	}
}
//매물등록
function modify(){
	var params = {};
	var constraints = {};

	//step 1. 폼 데이터 불러오기
	Valid.serialize('#mycarDealerForm');

	//step 2. 제약조건 선언
	//presence: 필수값
	constraints = Valid.getConstraints();
	constraints.carPlateNum.presence	={message:"^차량번호는 필수값입니다."};
	constraints.carPlateNum.format		={message:"^잘못된 차량번호 형식입니다.", pattern:"^[0-9]{2}[\s]*[가-힣]{1}[\s]*[0-9]{4}"};
	constraints.applyDay.presence		={message:"^등록일자는 필수값입니다."};
	constraints.applyDay.format			={message:"^날짜 형식이 올바르지 않습니다.", pattern: "[0-9]{4}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])"};
	constraints.makerCd.presence		={message:"^제조사는 필수값입니다."};
	constraints.modelCd.presence		={message:"^모델은 필수값입니다."};
	constraints.modelDtlCd.presence		={message:"^세부모델은 필수값입니다."};
	constraints.gradeCd.presence		={message:"^등급은 필수값입니다."};
	constraints.carRegYear.presence		={message:"^연식은 필수값입니다."};
	constraints.carFuel.presence		={message:"^연료타입은 필수값입니다."};
	constraints.carMission.presence		={message:"^변속기는 필수값입니다."};
	constraints.useKm.presence			={message:"^주행거리는 필수값입니다."};
	constraints.useKm.format			={message:"^주행거리 형식이 올바르지 않습니다.", pattern: "[0-9]+"};
	constraints.carColor.presence		={message:"^색상은 필수값입니다."};
	constraints.surfaceState.presence	={message:"^외관상태는 필수값입니다."};
	constraints.saleAmt.presence		={message:"^판매가격은 필수값입니다."};
	constraints.carCheckNo.presence		={message:"^성능점검번호는 필수값입니다."};
	constraints.rentYn.presence			={message:"^렌터카 사용이력은 필수값입니다."};

	//step 3. 유효성 처리
	var valid = Valid.validate(constraints);
	if(valid){	//유효성 판단
		Valid.action();
		return;
	}

	//step 4. 데이터가공처리
	//1. 차량코드
	//2. 옵션
	params = Valid.getParams();
	//params.applyDay = params.applyDay.replace(/(\.|\-)/gi,'');
	params.carFullCode = params.gradeCd;
	params.fileSeqs = util.nvl(params.fileSeqs, []).join(',');
	params.optionCds = $('.carOptions input[id^=option]:checked').map(function(){ return this.value; }).get().join();

	/* params.carGuarFruitlessYn = params.carGuarFruitlessYn ? 'Y':'N';
	params.carGuarRefundYn = params.carGuarRefundYn ? 'Y':'N'; */

	if($("input:checkbox[name='carGuarRefundYn']").is(":checked")){
		params.carGuarRefundYn = 'Y';
	}else{
		params.carGuarRefundYn = 'N';
	}

	if($("input:checkbox[name='carGuarFruitlessYn']").is(":checked")){
		params.carGuarFruitlessYn = 'Y';
	}else{
		params.carGuarFruitlessYn = 'N';
	}
	//step 5. 매물등록 시작
	alertify.confirm('매물을 수정하시겠습니까?', function(){
		$.ajax({
			url: BNK_CTX + '/product/mypage/mycarDealerRegist/AJAX'
			, method: 'POST'
			, data: JSON.stringify(params)
			, contentType: 'application/json;charset=UTF-8'
			, success: function(data){
				if(data.resCd == '00'){
					console.log(data);
					mycar_list(1);
					$('.p-close').trigger('click');
					//location.href = '/product/mypage/mycarDealerList';
				}else if(data.resCd == '99'){
					alertify.alert('매물등록에 실패하였습니다.');
				}
			}
			, error: function(){
				alertify.alert("데이터 통신상태가 원활하지 않습니다.");
			}
		});
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
function searchAddr(){
	$("#keyword").val($("#searchAddrName").val());
	$.ajax({
		 url  : BNK_CTX + "/api/juso/addrlink"  //인터넷망
		, method : "GET"
		, data : $("#addrFrm").serializeObject()
		, success : function(response){
			$("#list").html("");
			if(response.code == '00'){
				var json = response.data;
				var data = JSON.parse(json.substring(1, json.length-1));
				if(data.results.common.errorCode !== '0'){	//실패시 처리
					alertify.alert(data.results.common.errorMessage);

				}else if(data.results.common.errorCode === '0'){//성공시 처리
					if(data != null){
						addAddrListData(data);
					}
				}
			}else{
				alertify.alert('통신 환경이 원활하지 않거나 시스템 작업중입니다. 잠시 후 다시 접속해주세요.');
			}
		}
	    ,error: function(xhr,status, error){
	    }
	});
}

function btnComplete(seq){
	alertify.confirm('판매완료 처리하시겠습니까?', function(){
		$.ajax({
			url: BNK_CTX + '/product/mypage/mycarDealerComplete/AJAX'
				, method: 'POST'
				, data: JSON.stringify({carSeq : seq})
				, contentType: 'application/json;charset=UTF-8'
				, success: function(data){
					if(data.resCd == '00'){
						alertify.alert('판매완료 처리 되었습니다.');
						mycar_list(1);
					}else if(data.resCd == '99'){
						alertify.alert('판매처리에 실패하였습니다.');
					}
				}
				, error: function(){
					alertify.alert("데이터 통신상태가 원활하지 않습니다.");
				}

		});
	});
}
</script>