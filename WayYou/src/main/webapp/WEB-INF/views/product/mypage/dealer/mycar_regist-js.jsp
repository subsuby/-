<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
$(function(){
	console.log(${ct:toJson(car)});
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

	//보상상품갯수 초기화
	$.ajax({
		url : BNK_CTX + "/product/co/searchPremInfo"
		, dataType : 'json'
		, data: {userId: '${sessUserInfo.userId}'}
		, type: "get"
		, success : function(data){
			console.log(data);

			$('input[name=carGuarRefundYn]')
			.next('label').text('환불보장 ('+data.userInfo.guarRefundCnt+')').end()
			.siblings('input[name=carGuarRefundYnCnt]').val(data.userInfo.guarRefundCnt).end()
			.prop('disabled', data.userInfo.guarRefundCnt == 0);

			$('input[name=carGuarFruitlessYn]')
			.next('label').text('헛걸음보장 ('+data.userInfo.guarFruitlessCnt+')').end()
			.siblings('input[name=carGuarFruitlessYnCnt]').val(data.userInfo.guarFruitlessCnt).end()
			.prop('disabled', data.userInfo.guarFruitlessCnt == 0);
		},
		error: function(error){
			alertify.alert("데이터 통신상태가 원활하지 않습니다.");
			console.log(status);
		}
	});

	//제조사리스트 초기화
	$.ajax({
		url : BNK_CTX + "/product/co/makerCombo"
		, dataType : 'json'
		, type: "get"
		, success : function(data){
			var $select = $('select[name=makerCd]');
			render_combo($select, data, '${car.carFullCode}'.substring(0,3));
		},
		error: function(error){
			alertify.alert("데이터 통신상태가 원활하지 않습니다.");
			console.log(status);
		}
	});


	//파일 업로드
	$('.mycarImage input[type=file]').fileupload({
		url: '/product/mypage/fileUpload/AJAX'
		, acceptFileTypes: /(\.|\/)(jpg)$/i
		, dataType: 'json'
		, done: function(e, data){
			var blob=new Blob(data.files, {type: "octet/stream"});
            var url = URL.createObjectURL(blob);
            var $ul = $(this).closest('ul');
            var $uploader = $(this).closest('li');
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
	}).on('fileuploadprocessalways', function (e, data) {
		var currentFile = data.files[data.index];
		if (data.files.error && currentFile.error) {
			alertify.alert('jpg 형식만 올릴 수 있습니다.');
		}
	});

});
//콤보박스 그리기
function render_combo($select, data, value){
	var label = '';
	$select.empty();
	switch($select.attr('name')){
	case 'makerCd':
		label = '제조사';
		break;
	case 'modelCd':
		label = '모델';
		break;
	case 'modelDtlCd':
		label = '세부모델';
		break;
	case 'gradeCd':
		label = '등급';
		break;
	}
	$select.append($('<option>').val('').text(label));
	for(var key in data){
		var $option = $('<option>');
		$option.val(key);
		$option.text(data[key]);
		$select.append($option);
	}

	$select.val(value);
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
			var value = '';
			switch(name){
				case 'modelCd':
					value='${car.modelCd}';
					break;
				case 'modelDtlCd':
					value='${car.detailModelCd}';
					break;
				case 'gradeCd':
					value='${car.carFullCode}';
					break;
			}
			render_combo($select, data, value);
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
function regist(){
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
	var valid = Valid.validate(constraints);	//유효성체크 시작
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
	params.fileSeqs = util.nvl(params.fileSeqs, []).join();
	params.optionCds = $('.carOptions input[id^=option]:checked').map(function(){ return this.value; }).get().join();
	params.carGuarFruitlessYn = params.carGuarFruitlessYn ? 'Y':'N';
	params.carGuarRefundYn = params.carGuarRefundYn ? 'Y':'N';

	//step 5. 매물등록 시작
	alertify.confirm('매물을 등록하시겠습니까?', function(){
		$.ajax({
			url: BNK_CTX + '/product/mypage/mycarDealerRegist/AJAX'
			, method: 'POST'
			, data: JSON.stringify(params)
			, contentType: 'application/json;charset=UTF-8'
			, success: function(data){
				if(data.resCd == '00'){
					console.log(data);
					location.href = '/product/mypage/mycarDealerList';
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

function useProduct(elem){
	var count = 0;
	var text = '';

	count=Number($(elem).siblings('input[name='+elem.name+'Cnt]')[0].value);
	if($(elem).prop('checked')){
		count = count-1;
		$(elem).siblings('input[name='+elem.name+'Cnt]')[0].value=count;
	}else{
		count = count+1;
		$(elem).siblings('input[name='+elem.name+'Cnt]')[0].value=count;
	}
	if(elem.name.indexOf('Refund') > 0){
		text='환불보장 ('+count+')'
	}else if(elem.name.indexOf('Fruitless') > 0){
		text='헛걸음보장 ('+count+')'
	}

	$(elem).next('label').text(text);
}


</script>