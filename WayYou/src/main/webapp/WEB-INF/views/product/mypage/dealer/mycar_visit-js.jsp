<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
var param = {};
$(function(){

	var settingDate = new Date();
	var now = formatDate(settingDate);
	settingDate.setMonth(settingDate.getMonth()-1);
	var prev= formatDate(settingDate);

	$("#searchStartDt").val(prev);
	$("#searchEndDt").val(now);
	// 페이지가 로드될 때 리스트 조회
	mycar_visit_list(1);


	$("#searchStartDt, #searchEndDt").datepicker().on('changeDate', function(ev) {
		mycar_visit_list(1);
	})

	// 검색 버튼을 눌렀을 때
	$(".btnL").click(function(){
		mycar_visit_list(1);
	});

	// 초기화 버튼을 눌렀을 때
	$(".btnInit").click(function(){

		// 차량번호를 초기화한다.
		$("#carPlateNum").val("");

		// 검색 등록일자를 초기화한다
		$("#searchStartDt").val(prev);

		// 검색 종료일자를 초기화한다
		$("#searchEndDt").val(now);

		param = {};

		mycar_visit_list(1);
	});
});
function formatDate(date) {
	var d = new Date(date)
	, month = '' + (d.getMonth() + 1)
	, day = '' + d.getDate()
	, year = d.getFullYear();

	if (month.length < 2)
		month = '0' + month;
	if (day.length < 2)
		day = '0' + day;
	return [year, month, day].join('-');
}

function mycar_visit_list(curPage){
	$.ajax({
		url : BNK_CTX + '/product/mypage/mycarDealerVisit/AJAX',
		dataType : 'html',
		cache : false,
		data : {
			curPage : curPage,
			startDate : $("#searchStartDt").val(),
			endDate :  $("#searchEndDt").val(),
			carPlateNum : $("#carPlateNum").val(),
			resStatus: $("[name=resStatus]:checked").map(function(){return this.value}).get().join()
		},
		success : function(detailResult){
			$("#templateList").html(detailResult);

			//총 리스트 갯수
			var cnt = $(detailResult).find('.cnt').val();
			$('.totalCnt').text(cnt);
		},
		error : function(request,status,error){
			alertify.alert(error);
		}
	});
}

/*
 * [BUTTON] 승인요청 버튼 클릭 시 !!
 * dev  : 김예지
 * date : 2017.08.17
 */
function fn_acceptVisitDealer(resHisSeq){
    var $btn        = $('#acceptVisitDealer').next();
    var data        = $btn.data('popOpts');
    data.display    = true;
    $btn.data('popOpts', data);
    $btn.trigger('click');

    // 정보가져오기
    $.ajax({
        url : BNK_CTX + '/product/mypage/mycarDealerAcceptVisit/'+resHisSeq,
        method:'POST',
        contentType: 'application/json;charset=UTF-8',
        data: {},
        success : function(data){
            var temp = $('.popReserTime');

            var year    = data.reserve.resDate.substring(0,4);
            var month   = data.reserve.resDate.substring(4,6);
            var day     = data.reserve.resDate.substring(6);
            temp.find('#resHisSeqHidden').val(data.reserve.resHisSeq);
            temp.find('#resAmPm').val(data.reserve.resAmpm);
            temp.find('#resMonth').val(month);
            temp.find('#resDay').val(day);
        },
        error : function(request,status,error){
            alertify.alert(error);
        }
    });
}

/*
 * [BUTTON] 승인요청 팝업에서 확인 버튼 클릭 시 !!
 * dev  : 김예지
 * date : 2017.08.17
 */
function fn_reserveTimeConfirm(){

	if(util.isEmpty($('select[name=resTime]').val())){
		alertify.alert("요청시간을 확인해주세요.");
		return;
	}
    alertify.confirm('예약시간을 승인요청 하시겠습니까?', function(){
        var param = { resTime   : $('select[name=resTime]').val() ,
                      resHisSeq : $('#resHisSeqHidden').val()
                    };
        $.ajax({
            url : BNK_CTX + "/product/mypage/mycarDealerAcceptReserve"
            , data :  JSON.stringify(param)
            , dataType : 'json'
            , type: "POST"
            , contentType: "application/json"
            , success : function(data, textStatus, jqXHR){
                alertify.alert("예약시간이 설정되었습니다.");
                $("#closeReserve").trigger('click');
                mycar_visit_list(1);
            },
            error: function(error){
            }
        });
    });
}

/*
 * [BUTTON] 거절 버튼 클릭 시 !!
 * dev  : 김예지
 * date : 2017.08.17
 */
function fn_refuseVisitDealer(resHisSeq,resKey){
    alertify.confirm('예약을 거절하시겠습니까?', function(){
        var param = { reqStatus : 'reject' ,
                      resHisSeq : resHisSeq,
                      reKey     : ''
                    };
        $.ajax({
            url : BNK_CTX + "/product/mypage/mycarDealerRefuseReserve"
            , data :  JSON.stringify(param)
            , dataType : 'json'
            , type: "POST"
            , contentType: "application/json"
            , success : function(data, textStatus, jqXHR){
                alertify.alert("예약이 거절되었습니다.");
                mycar_visit_list(1);
            },
            error: function(error){
            }
        });
    });
}
</script>