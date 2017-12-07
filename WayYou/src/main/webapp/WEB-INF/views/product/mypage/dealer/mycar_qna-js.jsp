<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
var param = {};
$(function() {
	mycar_qna_list(1);
});

function initSearch(){
	$("#userName").val('');
	$("#searchStartDt").val('');
	$("#searchEndDt").val('');
	mycar_qna_list(1);
}
function mycar_qna_list(curPage){
	var params = {
		curPage : curPage,
		schValue : $("#userName").val(),
		startDate : $("#searchStartDt").val(),
		endDate :  $("#searchEndDt").val()
	};

	$.ajax({
		url : BNK_CTX + '/product/mypage/mycarDealerQnaList/AJAX',
		dataType : 'html',
		cache : false,
		data : params,
		success : function(detailResult){
			$("#qnaList").empty();
			$("#qnaList").append(detailResult);
			ITCButton.setupTypeAccordion();
		},
		error : function(request,status,error){
			alertify.alert(error);
		}
	});
}
function onKeyPress(event){
	if(event.keyCode == '13'){
		mycar_qna_list(1);
	}
}

function onClick(code, object){
	switch(code){
	case 'QNA_REGIST_POP':
		var $popTable = $('.popQue .popTable');
		$popTable.find('dl > dt').text(object.qnaTitle);
		$popTable.find('dl > dd').text(object.contents);
		$popTable.find('[name=qtSeq]').val(object.qtSeq);
		$('#qnaPop').trigger('click');
		break;
	case 'QNA_REGIST':
		//TODO:
		var params = {};
		var constraints = {};
		Valid.serialize('#questionForm');
		constraints = Valid.getConstraints();
		constraints.contents.presence = {message: '^답변을 작성해주세요.'};
		//Valid Start
		var valid = Valid.validate(constraints);
		if(valid){
			Valid.action();
			return;
		}
		params = Valid.getParams();
		//TODO:
		$.ajax({
			method: 'GET'
			, url: BNK_CTX + '/product/mypage/mycarDealerQnaRegist/AJAX'
			, data: params
			, success: function(data){
				if(data.resCd == '00'){
					console.log('등록완료');
					mycar_qna_list(1);
					$('.popQue a.p-close').trigger('click');
				}else if(data.resCd == '99'){
					console.log('등록실패');
				}
			}
			, error: function(){
				alertify.alert("error")
			}
		});
		break;
	}

}


</script>