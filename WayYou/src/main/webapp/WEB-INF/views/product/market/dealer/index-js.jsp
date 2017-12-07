<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script>
var __marketInfo={};

//안된것
//보상상품

$(function(){
	//데이터정의
	//1. 태그라벨
	//2. 태그 표출 여부
	//3. 데이터값
	//4. 다음단계로 넘어가기 위한 필수값
	//5. 탭 레벨(초기화용)
	//6. 엘리먼트타입 {}
	var formData = $("#sendDataForm").serializeObject();
	$("#sendDataForm input[type=hidden]").val('');		//폼값 초기화
	for(key in formData){
		__marketInfo[key]= {
			id			: key
			, label		: ''
			, value		: ''
			, display	: false
			, presence	: formData[key].split('^')[0] === "true"
			, level		: formData[key].split('^')[1]	//true^1
		};
	}
	//제조사 콤보박스 생성(최초 1번 실행)
	$.ajax({
		method: 'GET'
		, url: BNK_CTX + '/product/co/makerCombo'
		, success: function(data){
			$("#maker_area").load("/product/market/component/AJAX #component_maker_list", {json: JSON.stringify({makerList: data})});
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
            var $li_clone = $ul.find('.file_template').clone().removeClass('file_template').show();
			var $input = $('<input>', { type: 'hidden' , name: 'fileSeqs[]' , value: data.result.fileSeq });
			var $form = $('#sendDataForm');
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
				$input.remove();		//전송할 fileseq 제거
				$uploader.show();		//사진등록버튼 표출
            });
            //step 3. 가져온 fileseq hidden으로 등록
            $form.append($input);

			//step 4. 다음 사진등록 대기 li 추가
			$uploader.before($li_clone);

			//step 5. 업로드 갯수제한 처리
			var allowFileCount = $('.mycarImage .imgFileDelete:visible').length;
			if(allowFileCount === 20){
				$uploader.hide();
			}

			setMarketData('사진: '+allowFileCount+' 개 등록', allowFileCount, true, 'images');
		}
	}).on('fileuploadprocessalways', function (e, data) {
		var currentFile = data.files[data.index];
		if (data.files.error && currentFile.error) {
			alertify.alert('jpg 형식만 올릴 수 있습니다.');
		}
	});

	/* 주소 변경 */
	$("#btnSearchAddr").click(function() {			//주소 검색 버튼 눌렀을때 검색동작
		searchAddr();
	});
	$("#searchAddrName").keypress(function(e){		//주소 검색창에서 엔터눌렀을때 검색동작
		if(e.keyCode === 13){
			searchAddr();
		}
	});
	$("#dataList").on("click", "li", function() {	//주소 리스트중 한개를 선택했을때 특정 엘리먼트에 해당 정보 입력
		$("#dataList").find("li").removeClass();
		$(this).prop("class","selected");
		$("#selectAddrCode").val($(this).find("span").text());
		$("#selectAddr").val($(this).find("strong").text());
	});
	$("#btnAddrSelect").click(function() {		//주소팝업확인버튼눌렀을때
		$("#parkZip").val($("#selectAddrCode").val());
		$("#parkAddr1").val($("#selectAddr").val());
		$("#btnAddrCancel").trigger("click");
		render_addr();						//요약 데이터와 동기화 처리
	});

	//보상상품갯수 초기화
	$.ajax({
		url : BNK_CTX + "/product/co/searchPremInfo"
		, dataType : 'json'
		, data: {userId: '${sessUserInfo.userId}'}
		, type: "get"
		, success : function(data){
			$('input[name=carGuarRefundYn]')
			.next('label').html('<em>환불보장</em> ('+data.userInfo.guarRefundCnt+')').end()
			.siblings('input[name=carGuarRefundYnCnt]').val(data.userInfo.guarRefundCnt).end()
			.prop('disabled', data.userInfo.guarRefundCnt == 0);

			$('input[name=carGuarFruitlessYn]')
			.next('label').html('<em>헛걸음보장</em> ('+data.userInfo.guarFruitlessCnt+')').end()
			.siblings('input[name=carGuarFruitlessYnCnt]').val(data.userInfo.guarFruitlessCnt).end()
			.prop('disabled', data.userInfo.guarFruitlessCnt == 0);
		},
		error: function(error){
			alertify.alert("데이터 통신상태가 원활하지 않습니다.");
			console.log(status);
		}
	});


});

function setMarketData(label, value, disp, name){
	__marketInfo[name].label=label;		//데이터라벨
	__marketInfo[name].value=value;		//데이터값
	__marketInfo[name].display=disp;	//데이터표시유무
	display(__marketInfo[name]);		//데이터표출
	update(__marketInfo[name]);			//데이터업데이트
	step_valid();						//버튼활성화
}

//출력 데이터 업데이트(전송데이터, 요약데이터, 1차 유효성처리)
function update(object){
	$("#_"+object.id).val(object.label);
	$("#sendDataForm input[name="+object.id+"]").val(object.value);
}
function step_valid(){
	var tab1=true, tab2=true, tab3=true;
	//다음 단계로 넘어가는 버튼 활성화 로직(1차 유효성체크)
	//유효성체크지만 데이터의 형식까지 체크안함. 필수체크만
	//2차 유효성 체크는 매물등록 직전에함.
	for(key in __marketInfo){
		if(tab1 && _.isMatch(__marketInfo[key], {level: '1', presence: true, value: ''})){	//첫번째 탭의 데이터이면서 필수값인데 빈값인 것 찾기
			tab1=false;
		}
		if(tab2 && _.isMatch(__marketInfo[key], {level: '2', presence: true, value: ''})){	//두번째 탭의 데이터이면서 필수값인데 빈값인 것 찾기
			tab2=false;
		}
		if(tab3 && _.isMatch(__marketInfo[key], {level: '3', presence: true, value: ''})){	//세번째 탭의 데이터이면서 필수값인데 빈값인 것 찾기
			tab3=false;
		}
	}
	if(tab1){
		$('#btnNext1').addClass('on');		//정상일시 2단계 활성화
	}else{
		$('#btnNext1').removeClass('on');	//비정상일시 2단계 비활성화
	}
	if(tab2){
		$('#btnNext2').addClass('on');		//정상일시 3단계 활성화
	}else{
		$('#btnNext2').removeClass('on');	//비정상일시 3단계 비활성화
	}
	if(tab3){
		$('#btnNext3').addClass('on');		//정상일시 매물등록 활성화
	}else{
		$('#btnNext3').removeClass('on');	//비정상일시 매물등록 비활성화
	}
	//버튼 활성화 로직 끝.
}
//데이터표출
function display(object){
	if(object.display && util.isNotEmpty(object.value)){
		$("#_"+object.id).show();
	}else{
		$("#_"+object.id).hide();
	}
}
//일반 정보 공통삭제처리(전송데이터, 요약데이터, 리스트 삭제 후 초기화)
function remove(object){
	var id = object.id;
	__marketInfo[id].value='';
	__marketInfo[id].label='';
	__marketInfo[id].display=false;

	$('.area [name='+id+']').prop('checked', false);			//선택된 radio 버튼 해제
	$('.bsSelectButton [name='+id+']').prop('checked', false);	//보상상품 체크 해제
	$('.area [name='+id+']').val('');							//name 일치하는 엘리먼트 text 제거
	$('.enterDetail2 [name='+id+']').val('');					//name 일치하는 엘리먼트 text 제거

}
function onClick(code, object){
	var id = object.id;
	if(id.indexOf('_') > -1){
		id = id.substring(1);
	}
	//두번째탭에서 첫번째탭 삭제하면 안되는것
	//연식, 연료타입, 변속기
	//세번째탭에서 첫번째탭,두번째탭 삭제하면 안되는것
	//연식, 연료타입, 변속기, 주행거리, 색상, 외관상태, 렌터카, 사고내역, 세금 등 미납내역
	switch(code){
	case 'REMOVE':
		//TODO:
		if($('.stepInfo strong.on').hasClass('stepInfo1')){
			removeDefault(__marketInfo[id]);
		}
		if($('.stepInfo strong.on').hasClass('stepInfo2')){
			switch(id){
			case 'carRegYear':
			case 'carFuel':
			case 'carMission':
				break;
			default:
				removeDefault(__marketInfo[id]);
			}
		}
		if($('.stepInfo strong.on').hasClass('stepInfo3')){
			switch(id){
			case 'carRegYear':
			case 'carFuel':
			case 'carMission':
			case 'useKm':
			case 'carColor':
			case 'surfaceState':
			case 'rentYn':
			case 'sagoYn':
			case 'unpaidTax':
				break;
			default:
				removeDefault(__marketInfo[id]);
			}
		}
		break;
	case 'REMOVE_ADDR':
		remove_addr(__marketInfo[id]);
		removeDefault(__marketInfo[id]);
		break;
	case 'REMOVE_FILE':
		remove_file(__marketInfo[id]);
		removeDefault(__marketInfo[id]);
		break;
	case 'REMOVE_CHECK':
		remove_check(__marketInfo[id]);
		removeDefault(__marketInfo[id]);
		break;
	case 'REMOVE_COMBO':
		if($('.stepInfo strong.on').hasClass('stepInfo1')){
			remove_combo(__marketInfo[id]);
			removeDefault(__marketInfo[id]);
			if(id=='makerCd'){
				remove_combo(__marketInfo['modelCd']);
				removeDefault(__marketInfo['modelCd']);

				remove_combo(__marketInfo['detailModelCd']);
				removeDefault(__marketInfo['detailModelCd']);

				remove_combo(__marketInfo['gradeCd']);
				removeDefault(__marketInfo['gradeCd']);
			}else if(id=='modelCd'){
				remove_combo(__marketInfo['detailModelCd']);
				removeDefault(__marketInfo['detailModelCd']);

				remove_combo(__marketInfo['gradeCd']);
				removeDefault(__marketInfo['gradeCd']);
			}else if(id=='detailModelCd'){
				remove_combo(__marketInfo['gradeCd']);
				removeDefault(__marketInfo['gradeCd']);
			}
		}
		break;
	}

	step_valid();	//버튼활성화
}

function removeDefault(object){
	remove(object);
	display(object);
	update(object);
}
//전체 정보 삭제처리(전송데이터, 요약데이터, 리스트 삭제 후 초기화)
function removeAll(){
	if($('.stepInfo strong.on').hasClass('stepInfo1')){
		for(key in __marketInfo){
			remove_combo(__marketInfo[key])
			remove_file();
			remove_check();

			remove(__marketInfo[key]);
			update(__marketInfo[key]);
			display(__marketInfo[key]);
		}
	}
	if($('.stepInfo strong.on').hasClass('stepInfo2')){
		for(key in __marketInfo){
			if(__marketInfo[key].level == '2' || __marketInfo[key].level == '3'){
				remove_file();
				remove_check();

				remove(__marketInfo[key]);
				update(__marketInfo[key]);
				display(__marketInfo[key]);
			}
		}
	}
	if($('.stepInfo strong.on').hasClass('stepInfo3')){
		for(key in __marketInfo){
			if(__marketInfo[key].level == '3'){
				remove_file();
				remove_check();

				remove(__marketInfo[key]);
				update(__marketInfo[key]);
				display(__marketInfo[key]);
			}
		}
	}

	step_valid();		//버튼활성화
}
//가변 리스트 삭제처리(전송데이터, 요약데이터, 리스트 삭제 후 초기화)
function remove_combo(object){
	switch(object.id){
	case 'makerCd':
		$("#maker_area input").prop('checked', false);
		$("#model_area").empty().html('<li><input type="radio"/><label>모델</label></li>');
		$("#model_detail_area").empty().html('<li><input type="radio"/><label>세부모델</label></li>');
		$("#grade_area").empty().html('<li><input type="radio"/><label>등급</label></li>');
		break;
	case 'modelCd':
		$("#model_area input").prop('checked', false);
		$("#model_detail_area").empty().html('<li><input type="radio"/><label>세부모델</label></li>');
		$("#grade_area").empty().html('<li><input type="radio"/><label>등급</label></li>');
		break;
	case 'detailModelCd':
		$("#model_detail_area input").prop('checked', false);
		$("#grade_area").empty().html('<li><input type="radio"/><label>등급</label></li>');
		break;
	case 'gradeCd':
		$("#grade_area input").prop('checked', false);
		break;
	}
}
//주소 입력값 삭제처리(전송데이터, 요약데이터, 리스트 삭제 후 초기화)
function remove_addr(object){
	if(object.id=='parkAddr1'){
		remove(__marketInfo['parkZip']);
		update(__marketInfo['parkZip']);
		display(__marketInfo['parkZip']);
	}
}
//파일 정보 삭제처리(전송데이터, 요약데이터, 리스트 삭제 후 초기화)
function remove_file(){
	$('#sendDataForm [name="fileSeqs[]"]').remove();
	$('.enterDetail2 [name="fileSeqs[]"]').closest('li').not('.file_template').remove();
}
//옵션 정보 삭제처리(전송데이터, 요약데이터, 리스트 삭제 후 초기화)
function remove_check(){
	var $checkboxs = $('.enterDetail').find('input[type=checkbox]');
	$checkboxs.prop('checked', false);									//옵션 체크 해제
	$('.enterDetail').find('strong.accordionTitle span').text(0);		//옵션 체크 갯수 초기화
}


//옵션 체크박스 전체 선택
function checkAll(elem){
	var $checkboxs = $(elem).closest('.accordionData').find('.back input');
	$checkboxs.prop('checked', $(elem).prop('checked'));
	render_check(elem);
}
//옵션 전체선택 체크박스 관찰(전체선택 체크여부 관찰)
function watchChecked(elem){
	var $elem = $(elem);
	var totLength=$elem.find('.back input').length;
	var chkLength=$elem.find('.back input:checked').length;
	$elem.find('strong.accordionTitle span').text(chkLength);
	if(totLength != chkLength){
		$elem.find('.total input').prop('checked', false);
	}else{
		$elem.find('.total input').prop('checked', true);
	}
}


//탭내 요약정보 렌더링
//1. 불변 리스트			render()
//2. 가변 리스트			render_combo()
//2. 거리(input)			render_distance()
//3. 가격(input)			render_price()
//4. 일반(input)			render_input()
//5. 주소(input)			render_addr()
//6. 보상상품(input)		render_product()
//7. 옵션(input)			render_check()

//불변 리스트
function render(elem){
	var tit = $(elem).closest('dl').find('.tit').text();
	setMarketData(tit+': '+elem.dataset.label, elem.dataset.value, true, elem.name);
}
//가변 리스트
function render_combo(elem, code){
	$.ajax({
		method: 'GET'
		, url: BNK_CTX + '/product/co/modelCombo'
		, data: {makerCd: elem.dataset.value}
		, success: function(data){

			var tit = $(elem).closest('dl').find('.tit').text();

			switch(code){
			case 'MODEL':
				remove_combo(__marketInfo['modelCd']);
				removeDefault(__marketInfo['modelCd']);
				remove_combo(__marketInfo['detailModelCd']);
				removeDefault(__marketInfo['detailModelCd']);
				remove_combo(__marketInfo['gradeCd']);
				removeDefault(__marketInfo['gradeCd']);
				$("#model_area").load("/product/market/component/AJAX #component_model_list", {json: JSON.stringify({modelList: data})});
				break;
			case 'MODEL_DETAIL':
				remove_combo(__marketInfo['detailModelCd']);
				removeDefault(__marketInfo['detailModelCd']);
				remove_combo(__marketInfo['gradeCd']);
				removeDefault(__marketInfo['gradeCd']);
				$("#model_detail_area").load("/product/market/component/AJAX #component_model_detail_list", {json: JSON.stringify({modelDtlList: data})});
				break;
			case 'GRADE':
				remove_combo(__marketInfo['gradeCd']);
				removeDefault(__marketInfo['gradeCd']);
				$("#grade_area").load("/product/market/component/AJAX #component_grade_list", {json: JSON.stringify({gradeList: data})});
				break;
			}

			setMarketData(tit+': '+elem.dataset.label, elem.dataset.value, true, elem.name);
		}
	});
}
//일반인풋
function render_input(elem){
	var tit = $(elem).closest('dl').find('.tit').text();
	if(util.isEmpty(tit)){
		tit = $(elem).parent().siblings('.stit').text();
	}
	var txt = elem.value;

	if(elem.name == "carDesc"){
		if(txt.length > 10){
			txt = txt.substring(0,10)+"...";
		}
	}
	setMarketData(tit+': '+txt, elem.value, true, elem.name);
}
//주행거리
function render_distance(elem, blur){
	elem.value= elem.value.replace(/[^0-9]/g, '');

	if(blur && elem.value < 1000){
		elem.value = 1000;
	}
	if(elem.value > 300000){
		elem.value = 300000;
	}
	var tit = $(elem).closest('dl').find('.tit').text();
	setMarketData(tit+': '+util.addComma(elem.value)+' km', elem.value, true, elem.name);
}
//차량가격
function render_price(elem){
	elem.value= elem.value.replace(/[^0-9]/g, '');
	setMarketData('판매가격: '+util.addComma(elem.value)+' 만원', elem.value, true, elem.name);
}

//주차위치
function render_addr(elem){
	var $addr=$('.findZip');
	var zip=$addr.find('[name=parkZip]')[0];
	var addr1=$addr.find('[name=parkAddr1]')[0];
	var addr2=$addr.find('[name=parkAddr2]')[0];
	setMarketData('주소: ('+zip.value+') '+addr1.value, addr1.value, true, addr1.name);
	setMarketData('상세주소: '+addr2.value, addr2.value, true, addr2.name);
}
//보상상품
function render_product(elem){
	if(elem.name=='carGuarRefundYn'){
		setMarketData('보상상품: 환불', $(elem).prop('checked')?'Y':'N', $(elem).prop('checked'), elem.name);
	}else if(elem.name=='carGuarFruitlessYn'){
		setMarketData('보상상품: 헛걸음', $(elem).prop('checked')?'Y':'N', $(elem).prop('checked'), elem.name);
	}
	useProduct(elem);
}
//옵션 체크박스
function render_check(elem){
	var $optionWrap=$(elem).closest('.btn-accordion-wrapper');
	var $firstCheckbox= $optionWrap.find('.back input:checked:eq(0)');
	var optionCds=$optionWrap.find('.back input:checked').map(function(){return this.value}).get().join();
	var chkLength = $optionWrap.find('.back input:checked').length-1;
	var name = "optionCds";
	setMarketData('옵션: '+$firstCheckbox.next('label').text()+' 외 '+chkLength+'종', optionCds, true, name);
}

//다음 스텝으로 이동시 사용
function toStep(elem){
	if($(elem).hasClass('on') && elem.id == 'btnNext1'){
		$('.step1Write').hide();
		$('.step2Write').show();
		$('.step3Write').hide();
		$('.stepInfo strong').removeClass('on');
		$('.stepInfo2').addClass('on');
	}else if($(elem).hasClass('on') && elem.id == 'btnNext2'){
		$('.step1Write').hide();
		$('.step2Write').hide();
		$('.step3Write').show();
		$('.stepInfo strong').removeClass('on');
		$('.stepInfo3').addClass('on');

		render_addr();
	}else if($(elem).hasClass('on') && elem.id == 'btnNext3'){
		regist();
		//확인 시 마이페이지의 목록으로 이동
	}else if(elem.id == 'btnPrev2'){
		$('.step1Write').show();
		$('.step2Write').hide();
		$('.step3Write').hide();
		$('.stepInfo strong').removeClass('on');
		$('.stepInfo1').addClass('on');

	}else if(elem.id == 'btnPrev3'){
		$('.step1Write').hide();
		$('.step2Write').show();
		$('.step3Write').hide();
		$('.stepInfo strong').removeClass('on');
		$('.stepInfo2').addClass('on');
		$(window).scrollTop('0');
	}
}

//@매물등록
function regist(){
	//유효성 처리
	var params = {};
	var constraints = {};
	Valid.serialize('#sendDataForm');
	constraints = Valid.getConstraints();
	constraints.carPlateNum.presence	={message:"^차량번호는 필수값입니다."};
	constraints.carPlateNum.format		={message:"^잘못된 차량번호 형식입니다.", pattern:"^[0-9]{2}[\s]*[가-힣]{1}[\s]*[0-9]{4}"};
	constraints.applyDay.presence		={message:"^등록일자는 필수값입니다."};
	constraints.applyDay.format			={message:"^날짜 형식이 올바르지 않습니다.", pattern: "[0-9]{4}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])"};
	constraints.makerCd.presence		={message:"^제조사는 필수값입니다."};
	constraints.modelCd.presence		={message:"^모델은 필수값입니다."};
	constraints.detailModelCd.presence	={message:"^세부모델은 필수값입니다."};
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

	//Valid Start
	var valid = Valid.validate(constraints);
	if(valid){
		Valid.action();
		return;
	}

	//유효성 처리 끝난후 데이터 가공
	params = Valid.getParams();
	params.carFullCode = params.gradeCd;
	params.fileSeqs = util.nvl(params.fileSeqs, []).join();
	console.log('params: ',params);

	$.ajax({
		method: 'POST'
		, url: BNK_CTX + '/product/mypage/mycarDealerRegist/AJAX'
		, data: JSON.stringify(params)
		, contentType: 'application/json;charset=UTF-8'
		, success: function(data){
			if(data.resCd == '00'){
				alertify.alert('매물등록이 완료되었습니다.');
				location.href = '/product/mypage/mycarDealerList';
			}else if(data.resCd == '99'){
				alertify.alert('매물등록에 실패하였습니다.');
			}
		}
		, error: function(){
			alertify.alert("error")
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
//보상상품 선택시 남은 갯수 처리
function useProduct(elem){
	var count = 0;
	var html = '';

	count=Number($(elem).siblings('input[name='+elem.name+'Cnt]')[0].value);
	if($(elem).prop('checked')){
		count = count-1;
		$(elem).siblings('input[name='+elem.name+'Cnt]')[0].value=count;
	}else{
		count = count+1;
		$(elem).siblings('input[name='+elem.name+'Cnt]')[0].value=count;
	}
	if(elem.name.indexOf('Refund') > 0){
		html='<em>환불보장</em> ('+count+')'
	}else if(elem.name.indexOf('Fruitless') > 0){
		html='<em>헛걸음보장</em> ('+count+')'
	}

	$(elem).next('label').html(html);
}
</script>