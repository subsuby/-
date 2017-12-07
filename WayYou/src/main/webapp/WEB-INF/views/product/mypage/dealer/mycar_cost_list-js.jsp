<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
var param = {};
var params = {};
var car = {};
$(function() {
	// 페이지가 로드될 때 리스트 조회
	mycar_cost_list(1);

	// 공통 제조사콤보를 가져온다.
	$.fn.makerCombo("makerCombo");

	// 검색 버튼을 눌렀을 때
	$("#btnSearch").click(function(){
		var carFullCode = "";
		var makerCd = $("#makerCombo").val();
		var modelCd = $("#modelCombo").val();
		var modelDetailCd = $("#modelDetailCombo").val();
		var carPlateNum = $("#carPlateNum").val();

		if(modelDetailCd != ""){
			carFullCode = modelDetailCd;
		}else if(modelCd != ""){
			carFullCode = modelCd;
		}else{
			carFullCode = makerCd;
		}

		param.carFullCode = carFullCode;
		param.carPlateNum = carPlateNum;

		mycar_cost_list(1);
	});

	// 초기화 버튼을 눌렀을 때
	$("#btnClear").click(function(){
		// 제조사 셀렉트박스를 초기화한다.
		$.fn.makerCombo("makerCombo");

		// 모델 셀렉트박스를 초기화한다.
		$("#modelCombo").html("<option value=''>모델</option>");

		// 세부모델 셀렉트박스를 초기화한다.
		$("#modelDetailCombo").html("<option value=''>세부모델</option>");

		// 차량번호를 초기화한다.
		$("#carPlateNum").val("");

		param = {};

		mycar_cost_list(1);
	});

	// 제조사 셀렉트 박스를 변경 했을 때
	$("#makerCombo").change(function(){
		$.fn.modelCombo("modelCombo", $(this).val());

		// 세부모델 셀렉트박스를 초기화한다.
		$("#modelDetailCombo").html("<option value=''>세부모델</option>");
	});

	// 모델 셀렉트 박스를 변경 했을 때
	$("#modelCombo").change(function(){
		$.fn.modelCombo("modelDetailCombo", $(this).val());
	});

	//계산하기
	$('#costDo').click(function() {
		//빈값 입력시
		if($('#recv_carPlateNum').val() == ""){
			alertify.alert("차량번호를 입력해주세요");
			$("#recv_carPlateNum").focus();
			return;
		}
		if($('#recv_carMakerName').text() == ""){
			alertify.alert("차량을 먼저 검색해주세요");
			$("#carNum").focus();
			return;
		}

		$('.costC1').hide();
		$('#registCost').show();
		$('#carNum').text($('#recv_carPlateNum').val());
		$('#carModel2').text($('#recv_carMakerName').text());
		$('#carRegYear2').text($('#recv_carRegyear').text());
		$('#carNation2').text($('#recv_carNationName').text());
		$('#carKind2').text($('#recv_carCarkindName').text());
		$('#carRemainRate2').text($('#recv_carRemainRate').text());
		$('#carStandTax2').text($('#recv_carStandTax').text());
		$('#regArea2').text($("#regArea option:selected").text());
		$('#newCarPrice').text($("#recv_carNewPrice").val());
		$('#useDiv2').text($("#useDiv option:selected").text());
		$('#carSalePrice2').text(numberWithCommas($('#recv_carSalePrice').val().replace(/,/g, '')));
		$('#carDiv2').text($("#carDiv option:selected").text());
		$('#carDetailDiv2').text($("#carDetailDiv option:selected").text());

		//다시계산하기 클릭시
		$('#reCal').click(function () {
			$('.costC1').show();
			$('#registCost').hide();
			initData()
		});

		// 전송하기 위한 변수값들 저장
		params.carUse = $('#useDiv').val();
		params.carDiv = $('#carDiv').val();
		params.carDetailDiv = $('#carDetailDiv').val();
		params.carRegArea = $('#regArea').val();
		params.carStandTax = $('#recv_carStandTax2').val().replace(/,/g, '');
		params.carSalePrice = ceil($('#recv_carStandTax2').val().replace(/,/g, ''),4);

		// 전송 시작
		$.ajax({
			url : BNK_CTX + '/api/car/costResultSearch/',
			type: "POST",
			data : JSON.stringify(params),
			contentType:'application/json;charset=utf-8',
			dataType: 'json',
			success : function(result){
				//이전등록비용
				$('#regCost').text(numberWithCommas(result.cost.CAR_REG_COST));
				$('#fundCost').text(numberWithCommas(result.cost.CAR_FUND_COST));
				$('#carRecognition').text(numberWithCommas($('#default_recv_carRecognition').val()));
				$('#carStampCost').text(numberWithCommas($('#default_recv_carStampCost').val()));
				$('#carNumberCost').text(numberWithCommas($('#default_recv_carNumberCost').val()));

				//매매상사 부대비용
				$('#carMortgage').text(numberWithCommas($('#default_recv_carMortgage').val()));
				$('#carRegAgency').text(numberWithCommas($('#default_recv_carRegAgency').val()));
				$('#carManageCost').text(numberWithCommas($('#default_recv_carManageCost').val()));

				var carRegCost = result.cost.CAR_REG_COST;		//취등록세
				var carFundCost = result.cost.CAR_FUND_COST;	//공채할인비
				var carRecognition = Number($('#default_recv_carRecognition').val());	//인지대
				var carStampCost = Number($('#default_recv_carStampCost').val());		//증지대
				var carNumberCost = Number($('#default_recv_carNumberCost').val());		//번호판
				var moveCostSum = carRegCost+carFundCost+carRecognition+carStampCost+carNumberCost; //이전등록비용 합계

				$('#moveCostSum').text(numberWithCommas(moveCostSum));

				var carMortgage = Number($('#default_recv_carMortgage').val());		//저당비용
				var carRegAgency = Number($('#default_recv_carRegAgency').val());	//등록대행료
				var carManageCost = Number($('#default_recv_carManageCost').val());	//관리비용

				var etcCostSum = carMortgage+carRegAgency+carManageCost;	//부대비용합계
				var allSum = Number($('#recv_carSalePrice').val().replace(/,/g, '')) + moveCostSum + etcCostSum;

				$('#etcCostSum').text(numberWithCommas(etcCostSum)); //부대비용
				$('#allSum').text(numberWithCommas(allSum)); //총구매비용합계

				// car안에 전송할 값들 담아주기
				car.carPlateNum = $('#recv_carPlateNum').val();
				car.carRegyear = $('#recv_carRegyear').text();
				car.carRemainRate = $('#recv_carRemainRate').text();
				car.carStandTax = $('#recv_carStandTax2').val().replace(/,/g, '');
				car.carNewPrice = $('#recv_carNewPrice').val().replace(/,/g, '');
				car.carSalePrice = $('#recv_carSalePrice').val().replace(/,/g, '');
				car.carRegArea = $("#regArea").val();
				car.carUse =  $('#useDiv').val();
				car.carDiv =  $('#carDiv').val();
				car.carDetailDiv =  $('#carDetailDiv').val();
				car.carMortgage =  $('#default_recv_carMortgage').val();
				car.carRegAgency = $('#default_recv_carRegAgency').val();
				car.carManageCost = $('#default_recv_carManageCost').val();
				car.etcCostSum = etcCostSum;
				car.regCost = result.cost.CAR_REG_COST;
				car.fundCost = result.cost.CAR_FUND_COST;
				car.carRecognition = $('#default_recv_carRecognition').val();
				car.carStampCost = $('#default_recv_carStampCost').val();
				car.carNumberCost = $('#default_recv_carNumberCost').val();
				car.moveCostSum = moveCostSum;
				car.allSum = allSum;
				car.carFullCode = $('#carFullCd').val();
			},
			error : function(request,status,error){
				alertify.alert(error);
			}
		});

	});

	// 상단 x 버튼으로 닫기시
	$('#closeBtn').click(function(){
		$('.costC1').show();
		$('#registCost').hide();
		initData()
	});

	// 상세보기 팝업
	$(document).on("click", '.costBtnDetail', function(){
		var seq = $(this).parent().find('.costSeq').val();
		var $btn = $('.costBtnDetail').next();
		var data = $btn.data('popOpts');
		data.display = true;
		$btn.data('popOpts', data);
		$btn.trigger('click');

		// 정보가져오기
		$.ajax({
			url : BNK_CTX + '/product/mypage/mycarDealerCostList/detail',
			method:'POST',
			contentType: 'application/json;charset=UTF-8',
			data: JSON.stringify({costingSeq : seq}),
			success : function(data){
				console.log(data);
				//상세보기 팝업에 값 설정
				var temp = $('.popCostView').find('#costView');
				console.log(temp);
				temp.find('#carNum').text(data.getCostDetail.carPlateNum);
				temp.find('#carModel').text(data.getCostDetail.carMakerName+" "+data.getCostDetail.carModelName);
				temp.find('#carRegYear').text(data.getCostDetail.carRegyear);
				temp.find('#carNation').text(data.getCostDetail.carNationName);
				temp.find('#carKind').text(data.getCostDetail.carDivName);
				temp.find('#carRemainRate').text(data.getCostDetail.carRemainRate);
				temp.find('#carStandTax').text(numberWithCommas(data.getCostDetail.carStandTax));
				temp.find('#regArea').text(data.getCostDetail.carRegAreaName);
				temp.find('#newCarPrice').text(numberWithCommas(data.getCostDetail.carNewPrice));
				temp.find('#useDiv').text(data.getCostDetail.carUseName);
				temp.find('#carSalePrice').text(numberWithCommas(data.getCostDetail.carSalePrice));
				temp.find('#carDiv').text(data.getCostDetail.carDivName);
				temp.find('#carDetailDiv').text(data.getCostDetail.carDetailDivName);
				temp.find('#regCost').text(numberWithCommas(data.getCostDetail.regCost));
				temp.find('#fundCost').text(numberWithCommas(data.getCostDetail.fundCost));
				temp.find('#carRecognition').text(numberWithCommas(data.getCostDetail.carRecognition));
				temp.find('#carStampCost').text(numberWithCommas(data.getCostDetail.carStampCost));
				temp.find('#carNumberCost').text(numberWithCommas(data.getCostDetail.carNumberCost));
				temp.find('#moveCostSum').text(numberWithCommas(data.getCostDetail.moveCostSum));
				temp.find('#carMortgage').text(numberWithCommas(data.getCostDetail.carMortgage));
				temp.find('#carRegAgency').text(numberWithCommas(data.getCostDetail.carRegAgency));
				temp.find('#carManageCost').text(numberWithCommas(data.getCostDetail.carManageCost));
				temp.find('#etcCostSum').text(numberWithCommas(data.getCostDetail.etcCostSum));
				temp.find('#allSum').text(numberWithCommas(data.getCostDetail.allSum));
				temp.find('#carFullCd').val(data.getCostDetail.carFullCode);
			},
			error : function(request,status,error){
				alertify.alert(error);
			}
		});
	});

	// 비용계산기 보내기 버튼을 눌렀을 때
	$("#btnSend").click(function(){
		var $btn = $('#btnSend').next();
		var data = $btn.data('popOpts');
		data.display = true;
		$btn.data('popOpts', data);
		$btn.trigger('click');
	});

	// 비용계산기 보낼사람 검색 버튼을 눌렀을때
	$(".iconSearch").click(function(){
		var searchTxt = $("#searchTxt").val();

		if(searchTxt == ""){
			$("#searchTxt").focus();
			alertify.alert("검색어를 입력해주세요.");
			return;
		}

		$.ajax({
			url : BNK_CTX + '/product/mypage/mycarDealerPushList/AJAX',
			dataType : 'html',
			method:'GET',
			cache : false,
			data : {
				searchTxt : searchTxt
			},
			success : function(detailResult){
				$("#pushList").html(detailResult);
			},
			error : function(request,status,error){
				alertify.alert(error);
			}
		});
	});

	// 전송할 회원을 선택하였을때
	$("#pushList").on("click", "li", function(){
		$("#pushList").find("li").removeClass();
		$(this).prop("class","selected");
	});

	// 전송 버튼을 눌렀을때
	$("#checkBtnSend").click(function(){
		if(!$('#pushList li').hasClass("selected")){
			alertify.alert("전송할 사람을 선택해주세요.");
			return;
		}

		var userId = $("#pushList").find(".selected").find(".userId").val();
		//선택한 유저ID
		car.userId = userId;
		//AJAX 전송시작
		$.ajax({
			url : BNK_CTX + '/product/mypage/mycarDealerCostList/register',
			method:'POST',
			contentType: 'application/json;charset=UTF-8',
			data: JSON.stringify(car),
			success : function(data){
				alertify.alert('구매비용 전송을 완료했습니다.');
				mycar_cost_list(1);
				$('.p-close').trigger('click');
				var $btn = $('#checkBtnSend').next();
				var data = $btn.data('popOpts');

				$btn.data('popOpts', data);
				$btn.trigger('click');
			},
			error : function(request,status,error){
				alertify.alert(error);
			}
		});
	});
});

function mycar_cost_list(curPage){
	$.ajax({
		url : BNK_CTX + '/product/mypage/mycarDealerCostList/AJAX',
		dataType : 'html',
		cache : false,
		data : {
			curPage : curPage,
			carFullCode :param.carFullCode,
			carPlateNum : param.carPlateNum
		},
		success : function(detailResult){
			//총 리스트 갯수 가져오기
			var cnt = $(detailResult).find('.cnt').val();
			$("#costTotCnt").text(cnt);
			//템플릿 붙여넣기
			$("#templateList").html(detailResult);
		},
		error : function(request,status,error){
			alertify.alert(error);
		}
	});
}

//구매비용발송 차량검색
function searchClick(){
	var carPlateNum = $('#recv_carPlateNum').val();

	$.ajax({
		url : BNK_CTX + '/api/car/costSearch/',
		dataType : 'json',
		type: "POST",
		data : {
			carPlateNum : carPlateNum
		},
		success : function(data){
			if(data.cost != null){
				var cost = data.cost;
				for(var key in cost){
					switch(key){
					case 'carMakerName':
						$('#recv_'+key).text(cost.carMakerName+" "+cost.carModelName);
						break;
					case 'carMakerName':
						$('#recv_'+key).text(numberWithCommas(cost[key]));
						break;
					case 'carNewPrice':
						$('#recv_'+key).val(numberWithCommas(cost[key]));
						break;
					case 'carStandTax':
						$('#recv_'+key).text(numberWithCommas(cost[key]));
						$('#recv_'+key+2).val(numberWithCommas(cost[key]));
						$('#recv_carSalePrice').val(numberWithCommas(ceil(cost[key], 4)));
						break;
					default:
						$('#recv_'+key).text(cost[key]);
					}
				}

				//인지대,종지대등 입력안했을시 기본값 0으로 설정
				$('input[id^=default_recv_]').val(0);

				//검색결과 초기화
				$("#costInit").on('click',function(){
					initData();
				});

				$('#carFullCd').val(data.cost.carFullCode);

			}else{
				alertify.alert('차량정보가 없습니다.');
				initData();
			}
		},
		error : function(request,status,error){
			alertify.alert(error);
		}
	});
}

//데이터 초기화
function initData(){
	$('#recv_carPlateNum').val("");		//차량번호 초기화
	$('#recv_carMakerName').text("");	//차종 초기화
	$('#recv_carRegyear').text("");		//연식 초기화
	$('#recv_carNationName').text("");	//국산수입 초기화
	$('#recv_carCarkindName').text("");	//종류 초기화
	$('#recv_carRemainRate').text("");	//잔존율 초기화
	$('#recv_carStandTax').text("");	//과세표준 초기화
	$('#recv_carNewPrice').val("");		//신차가격 초기화
	$('#recv_carStandTax2').val("");	//과세표준 초기화
	$('#recv_carSalePrice').val("");	//구매가격 초기화
	$("#regArea option:eq(0)").prop('selected', true);		//등록지역 초기화
	$("#useDiv option:eq(0)").prop('selected', true);		//용도구분 초기화
	$("#carDiv option:eq(0)").prop('selected', true);		//차종구분 초기화
	$("#carDetailDiv option:eq(0)").prop('selected', true);	//상세차량구분 초기화
	$("#default_recv_carMortgage").val("");		//저당비용 초기화
	$("#default_recv_carRecognition").val("");	//인지대 초기화
	$("#default_recv_carStampCost").val("");	//증지대 초기화
	$("#default_recv_carNumberCost").val("");	//번호판교체 초기화
	$("#default_recv_carRegAgency").val("");	//등록대행료 초기화
	$("#default_recv_carManageCost").val("");	//관리비용 초기화
}

//숫자 콤마처리
function numberWithCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
//차량구매가격
function ceil(value, exp) {
	// If the exp is undefined or zero...
	if (typeof exp === 'undefined' || +exp === 0) return Math.ceil(value);
	value = +value;
	exp = +exp;
	// If the value is not a number or the exp is not an integer...
	if (isNaN(value) || !(typeof exp === 'number' && exp % 1 === 0)) return NaN;
	// Shift
	value = value.toString().split('e');
	value = Math.ceil(+(value[0] + 'e' + (value[1] ? (+value[1] - exp) : -exp)));
	// Shift back
	value = value.toString().split('e');
	return +(value[0] + 'e' + (value[1] ? (+value[1] + exp) : exp));
};
</script>