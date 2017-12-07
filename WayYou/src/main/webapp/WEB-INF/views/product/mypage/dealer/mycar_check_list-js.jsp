<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
var param = {};
var items = [];
$(function(){
	// 페이지가 로드될 때 리스트 조회
	mycar_check_list(1);

	// 검색 버튼을 눌렀을 때
	$(".btnL").click(function(){
		param.phoneMobile = $("#personPhone").val();
		param.userName = $("#personName").val();
		mycar_check_list(1);
	});

	// 초기화 버튼을 눌렀을 때
	$(".btnInit").click(function(){
		//전화번호 초기화
		$("#personPhone").val("");
		//이름 초기화
		$("#personName").val("");
		//param초기화
		param = {};
		//리스트 다시 불러오기
		mycar_check_list(1);
	});

	// 상세보기 버튼을 눌렀을 때
	$(document).on("click", '.checkBtnDetail', function(){
		$("input[type=checkbox]").prop("checked", false);
		$(".checkDiv").hide();
		$("input[type=checkbox]").parent("p").hide();

		var items = $(this).parent().find(".items").val();
		var itemSplit = items.split(",");
		if(itemSplit.length > 0){
			for (var i = 0; i < itemSplit.length; i++) {
				$("#"+itemSplit[i]).prop("checked" , true);	// 체크
				$("#"+itemSplit[i]).parent().show();
				$("#"+itemSplit[i]).parent().parent("div").show();
			}
		}

		var $btn = $('.checkBtnDetail').next();
		var data = $btn.data('popOpts');

		data.display = true;
		$btn.data('popOpts', data);
		$btn.trigger('click');
	});

	// 체크리스트 발송 버튼을 눌렀을 때
	$(".enrollment").click(function(){
		$("input[type=checkbox]").parent("p").show();
		$(".checkDiv").show();
	});

	// 체크리스트 보내기 버튼을 눌렀을 때
	$("#btnSend").click(function(){
		items = [];
		$("input[name='items[]']:checked").each(function (){
			items.push($(this).val());
		});

		if(items.length == 0){
			alertify.alert("항목을 하나라도 체크해주세요.");
			return;
		}

		var $btn = $('#btnSend').next();
		var data = $btn.data('popOpts');

		data.display = true;
		$btn.data('popOpts', data);
		$btn.trigger('click');
	});

	// 체크리스트 검색 버튼을 눌렀을때
	$("#checkBtnSearch").click(function(){
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
		var checkParams={
				checkItems : items.toString(),
				userId : userId
			};
		$.ajax({
			url : BNK_CTX + '/product/mypage/mycarDealerCheckList/register',
			method:'POST',
			contentType: 'application/json;charset=UTF-8',
			data: JSON.stringify(checkParams),
			success : function(data){
				$('.p-close').trigger('click');
				var $btn = $('#checkBtnSend').next();
				var data = $btn.data('popOpts');

				data.display = true;
				$btn.data('popOpts', data);
				$btn.trigger('click');
			},
			error : function(request,status,error){
				alertify.alert(error);
			}
		});
	});

	// 확인 버튼을 눌렀을때
	$("#checkBtnClose").click(function(){
		$("input[type=checkbox]").prop("checked", false);
		mycar_check_list(1);
		$('.p-close').trigger('click');
	});
	
	$(".p-close").click(function(){
		$('#searchTxt').val('');
		$("#pushList").empty();
	});

});

function mycar_check_list(curPage){
	$.ajax({
		url : BNK_CTX + '/product/mypage/mycarDealerCheckList/AJAX',
		dataType : 'html',
		cache : false,
		data : {
			curPage : curPage,
			phoneMobile : util.nvl(param.phoneMobile, '').replace(/[^0-9]/gi,''),
			userName : param.userName
		},
		success : function(detailResult){
			$("#templateList").html(detailResult);
		},
		error : function(request,status,error){
			alertify.alert(error);
		}
	});
}

//키 입력 처리
function onKeyDown(elem, code, event){
	switch(code){
	case 'PHONE':
		if(/[^0-9\-]/.test(elem.value)){
			event.preventDefault();
		}
		elem.value = elem.value.replace(/[^0-9\-]/gi,'');
		break;
	case 'NAME':
		if(/[^ㄱ-힛a-zA-Z]/.test(elem.value)){
			event.preventDefault();
		}
		elem.value = elem.value.replace(/[^ㄱ-힛a-zA-Z]/gi,'');
		break;
	}
}
function onBlur(elem, code, event){
	switch(code){
	case 'PHONE':
		elem.value = elem.value.replace(/[^0-9\-]/gi,'');
		break;
	case 'NAME':
		elem.value = elem.value.replace(/[^ㄱ-힛a-zA-Z]/gi,'');
		break;
	}
}
</script>