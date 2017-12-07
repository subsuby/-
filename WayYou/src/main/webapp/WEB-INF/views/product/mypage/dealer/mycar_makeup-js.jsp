<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
var param = {};
$(function() {
	// 페이지가 로드될 때 리스트 조회
	mycar_makeup(1);
	// 공통 제조사콤보를 가져온다.
	$.fn.makerCombo("makerCombo");

	// 검색 버튼을 눌렀을 때
	$("#btnSearch").click(function(){
		param.carPlateNum = $("#carPlateNum").val();
		param.startDate = $("#searchStartDt").val();
		param.endDate = $("#searchEndDt").val();

		mycar_makeup(1);
	});

	// 초기화 버튼을 눌렀을 때
	$("#btnClear").click(function(){
		// 차량번호를 초기화한다.
		$("#carPlateNum").val("");
		// 검색 등록일자를 초기화한다
		$("#searchStartDt").val("");
		// 검색 종료일자를 초기화한다
		$("#searchEndDt").val("");

		param = {};

		mycar_makeup(1);
	});

	$(".makeupAdd .p-close").on('click', function(){
         var temp = $('.makeupAdd');
         //모바일에도 배기량은 공란으로 되어있어 무조건 없음으로 뿌려줌
         temp.find("#carCC").text("없음");
         temp.find("#carSeqHidden").val('');
         temp.find("#carPlateNumHidden").val('');	//차량번호 초기화
         $('textarea[name=reqRemark]').val('');		//비고 초기화
		 $('#MakeupCarPlateNum').val('');			//검색어 초기화
         temp.find("#carPlateNum").text("없음");
         temp.find("#carRegYear").text("없음");
         temp.find("#carColor").text("없음");
         temp.find("#useKm").text("없음");
         temp.find("#carRegDay").text("없음");
         temp.find("#carMission").text("없음");
         temp.find("#attachCnt").text("없음" + "/ ");
         temp.find("#mortGageCnt").text("없음");
         temp.find("#carFuel").text("없음");
         temp.find("#unpaidTax").text("없음");
	});
});

function mycar_makeup(curPage){

	$.ajax({
		url : BNK_CTX + '/product/mypage/mycarDealerMakeup/AJAX',
		dataType : 'html',
		cache : false,
		data : {
			curPage : curPage,
			carPlateNum : param.carPlateNum,
			startDate : param.startDate,
			endDate :  param.endDate
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

function fn_searchMakeupCar(){
    var carPlateNum = $.trim($("#MakeupCarPlateNum").val());
    if(carPlateNum == ""){
    	alertify.alert("마이카에 등록한 차량번호를 입력하세요.");
    	return;
    }
    var param = {schValue : carPlateNum};

    $.ajax({
        url : BNK_CTX + "/product/mypage/mycarDealerSelectMakupCar"
        , data :  JSON.stringify(param)
        , dataType : 'json'
        , type: "POST"
        , contentType: "application/json"
        , success : function(data, textStatus, jqXHR){
        	if(typeof data.car == 'undefined'){
				alertify.alert("메이크업 신청은 마이카에 등록된 차량만 가능합니다.\n현재 입력하신 차량번호 혹은 마이카에 등록된\n차량번호를 다시 확인해주세요.");
				return;
        	}

            var temp = $('.makeupAdd');

            //모바일에도 배기량은 공란으로 되어있어 무조건 없음으로 뿌려줌
            temp.find("#carCC").text("없음");
            temp.find("#carSeqHidden").val(data.car.carSeq);
            temp.find("#carPlateNumHidden").val(data.car.carPlateNum);

            if(data.car.carPlateNum == null || data.car.carPlateNum == ""){
                temp.find("#carPlateNum").text("없음");
            }else{
                temp.find("#carPlateNum").text(data.car.carPlateNum);
            }
            if(data.car.carRegYear == null || data.car.carRegYear == ""){
                temp.find("#carRegYear").text("없음");
            }else{
                temp.find("#carRegYear").text(data.car.carRegYear);
            }
            if(data.car.carColor == null || data.car.carColor == ""){
                temp.find("#carColor").text("없음");
            }else{
                temp.find("#carColor").text(data.car.label.carColor);
            }
            if(data.car.useKm == null || data.car.useKm == ""){
                temp.find("#useKm").text("없음");
            }else{
                temp.find("#useKm").text(data.car.useKm + "KM");
            }
            if(data.car.carRegDay == null || data.car.carRegDay == ""){
                temp.find("#carRegDay").text("없음");
            }else{
                temp.find("#carRegDay").text(data.car.carRegDay);
            }
            if(data.car.carMission == null || data.car.carMission == ""){
                temp.find("#carMission").text("없음");
            }else{
                temp.find("#carMission").text(data.car.label.carMission);
            }
            if(data.car.attachCnt == null || data.car.attachCnt == ""){
                temp.find("#attachCnt").text("없음" + "/ ");
            }else{
                temp.find("#attachCnt").text(data.car.attachCnt + "/");
            }
            if(data.car.mortGageCnt == null || data.car.mortGageCnt == ""){
                temp.find("#mortGageCnt").text("없음");
            }else{
                temp.find("#mortGageCnt").text(data.car.mortGageCnt);
            }
            if(data.car.carFuel == null || data.car.carFuel == ""){
                temp.find("#carFuel").text("없음");
            }else{
                temp.find("#carFuel").text(data.car.label.carFuel);
            }
            if(data.car.unpaidTax == null || data.car.unpaidTax == ""){
                temp.find("#unpaidTax").text("없음");
            }else{
                temp.find("#unpaidTax").text(data.car.unpaidTax);
            }
        },
        error: function(error){
        }
    });
}

/*
* [function] 메이크업 등록 시 !!
* dev  : 김예지
* date : 2017.08.16
*/
function fn_insertMakeup(){
	var carSeq = $('#carSeqHidden').val();
	if(carSeq == ""){
		$('#carSeqHidden').focus();
		alertify.alert("차량을 먼저 검색해주세요.");
		return;
	}

    alertify.confirm('메이크업을 신청 하시겠습니까?', function(){
        var param = { carSeq        : carSeq ,
                      carPlateNum   : $('#carPlateNumHidden').val() ,
                      reqRemark     : $('textarea[name=reqRemark]').val() ,
                      reqItems      : '1,2,3'
                    };
        $.ajax({
            url : BNK_CTX + "/product/mypage/mycarDealerInsertMakeUp"
            , data :  JSON.stringify(param)
            , dataType : 'json'
            , type: "POST"
            , contentType: "application/json"
            , success : function(data, textStatus, jqXHR){
                alertify.alert("등록 되었습니다.");
                $("#cancelMakeup").trigger('click');
                mycar_makeup(1);
            },
            error: function(error){
            }
        });
    });
}

</script>