<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
var schParam = {};
$(function() {
	// 페이지가 로드될 때 리스트 조회
	mycar_fowarding_list(1);

	// 공통 제조사콤보를 가져온다.
	$.fn.makerCombo("makerCombo");

	// 제조사 셀렉트 박스를 변경 했을 때 모델값 가져오기
	$("#makerCombo").change(function(){
		$.fn.modelCombo("modelCombo", $(this).val());
	});

	// 연식 숫자만 입력가능하게
	$('#carRegYear').keyup(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
		if($(this).val().length < 4){
		}
	});

	// 검색 버튼을 눌렀을 때
	$(".btnSearch").click(function(){
		var carFullCode = "";
		var makerCd = $("#makerCombo").val();
		var modelCd = $("#modelCombo").val();
		schParam.carPlateNum = $("#carPlateNum").val();
		schParam.carRegYear = $("#carRegYear").val();
		schParam.startDate = $("#searchStartDt").val();
		schParam.endDate = $("#searchEndDt").val();
		schParam.carFuel = $("#carfuel option:selected").val();


		if(modelCd != ""){
			carFullCode = modelCd;
		}else{
			carFullCode = makerCd;
		}
		schParam.carFullCode = carFullCode;
		mycar_fowarding_list(1);
	});

	// 초기화 버튼을 눌렀을 때
	$(".btnInit").click(function(){
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
		//연료 셀렉트박스 초기화
		$("#carfuel option:eq(0)").prop('selected', true);
		schParam = {};
		mycar_fowarding_list(1);
	});
});

//리스트
function mycar_fowarding_list(curPage){
	$.ajax({
		url : BNK_CTX + '/product/mypage/mycarDealerFowardingPaging/AJAX',
		dataType : 'html',
		cache : false,
		data : {
			curPage : curPage,
			carPlateNum : schParam.carPlateNum,
			carRegYear : schParam.carRegYear,
			startDate : schParam.startDate,
			endDate :  schParam.endDate,
			carFullCode : schParam.carFullCode,
			carFuel  :schParam.carFuel
		},
		success : function(detailResult){
			$("#templateList").html(detailResult);
		},
		error : function(request,status,error){
			alertify.alert(error);
		}
	});
}

function goRegist(list){
	location.href = '/product/mypage/mycarDealerRegist/forward?carPlateNum='+list.carPlateNum+'&dealerLicenseNo='+list.dealerLicenseNo;
}
</script>