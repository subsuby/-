<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
var param = {};
var modifyParams={};
$(function() {
	// 페이지가 로드될 때 리스트 조회
	mycar_businesscard_list(1);

	// 전화번호 입력창에서 포커스가 빠졌을때
	$("#personPhone").on('blur', function() {
		if(this.value != ""){
			this.value = util.phoneHyphen(this.value.replace(/[^0-9]/g,''));
		}
	});
	$("#personPhone").on('input',function() {
		if(this.value != ""){
			this.value = this.value.replace(/[^0-9]/g,'');
		}
	});
	
	// 검색 버튼을 눌렀을 때
	$(".btnL").click(function(){
		param.phoneMobile = $("#personPhone").val();
		param.userName = $("#personName").val();
		mycar_businesscard_list(1);
	});

	$('.btnDel').click(function () {
		$('.realImage').hide();
		$('.noImage').show();
		$('.btnDel').hide();
		$('.btnAdd').show();
		modifyParams.dealerProfileFileSeq = '';
	});

	$('.btnDel').on('click',function(){
		$('#noImage').attr('src','/product/images/thumbnail/profile1.png');
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
		mycar_businesscard_list(1);
	});

	//파일 업로드
	$('.profileImage input[type=file]').fileupload({
		url: '/product/mypage/businesscard/fileUpload/AJAX'
		, dataType: 'json'
		, done: function(e, data){
			var blob=new Blob(data.files, {type: "octet/stream"});
			var url = URL.createObjectURL(blob);
			//추가,삭제버튼
			$('.btnDel').show();
			$('.btnAdd').hide();
			//이미지경로 넣어주기
			$("#noImage").prop('src', url);
			//이미지 seq param에 담아주기
			modifyParams.dealerProfileFileSeq = data.result.fileSeq;
		}
	});

	// 명함발송팝업에서 검색 버튼을 눌렀을때
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
	$("#cardBtnSend").click(function(){
		if(!$('#pushList li').hasClass("selected")){
			alertify.alert("전송할 사람을 선택해주세요.");
			return;
		}

		var userId = $("#pushList").find(".selected").find(".userId").val();
		var checkParams={
				userId : userId
			};
		$.ajax({
			url : BNK_CTX + '/product/mypage/mycarDealerBusinesscard/register',
			method:'POST',
			contentType: 'application/json;charset=UTF-8',
			data: JSON.stringify(checkParams),
			success : function(data){
				$('.p-close').trigger('click');
				var $btn = $('#cardBtnSend').next();
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
		mycar_businesscard_list(1);
		$('.p-close').trigger('click');
	});

	$(".p-close").click(function(){
		$('#searchTxt').val('');
		$("#pushList").empty();
	});

	//명함수정하기 버튼을 눌렀을때
	$(document).on("click", '#nameCardModBtn', function(){
		var $btn = $('#nameCardModBtn').next();
		var data = $btn.data('popOpts');
		data.display = true;
		$btn.data('popOpts', data);
		$btn.trigger('click');

		$.ajax({
			url : BNK_CTX + '/product/mypage/mycarDealerBusinesscard/nameCardProfileInfo',
			method:'POST',
			contentType: 'application/json;charset=UTF-8',
			success : function(data){

				//명함수정 버튼 클릭시 나오는 기본 팝업 정보
				$('#dealerName').text(data.user.userName);
				$('#dealerDanjiName').text(data.user.dealerDanjiName + " " +data.user.dealerShopName);
				$('#danjiaddr').text(data.user.marketInfo.danjiaddr);
				if(data.user.dealerVirtualNum != null){
					$('#num1').text(data.user.dealerVirtualNum)
				}else{
					$('#num1').text(data.user.phoneNumMask)
				}
				$('#memo').text(data.user.dealerProfileDesc);

				// 수정하기 버튼 클릭시 나오는 팝업정보
				$('#dealerName2').text(data.user.userName);
				$('#dealerDanjiName2').text(data.user.dealerDanjiName + " " +data.user.dealerShopName);
				$('#danjiaddr2').text(data.user.marketInfo.danjiaddr);

				//안심번호가 있으면 안심번호 없으면 휴대폰번호
				if(data.user.dealerVirtualNum != null){
					$('#num2').text(data.user.dealerVirtualNum)
				}else{
					$('#num2').text(data.user.phoneNumMask)
				}
				$('#dealerMemo').val(data.user.dealerProfileDesc);

				// 명함 이미지가 있을경우와 없을경우
				if(data.user.dealerProfileFileSeq == null){
					$('.realImage').hide();
					$('.noImage').show();
					$('.btnDel').hide();
					$('.btnAdd').show();
					$('.prFile').show();
				}else{
					$('.main').find('.imgBack').find('img').attr('src', data.user.dealerProfileImgPath);
					$('#imgSpan').find('img').attr('src', data.user.dealerProfileImgPath);
					$('.btnDel').show();
					$('.prFile').hide();
				}

				//데이터 수정을위한 userId 담아주기
				modifyParams.userId = data.user.userId;
				modifyParams.dealerProfileFileSeq = data.user.dealerProfileFileSeq;
			},
			error : function(request,status,error){
				alertify.alert(error);
			}
		});

		//수정하기 버튼 클릭시
		$('#cModifyBtn').click(function () {
			$('.cardP1').hide();
			$('.cardP2').show();
		});


		//수정완료 버튼 클릭시
		$('.modifyOk').click(function(){
			//메모 내용값 담아주기
			modifyParams.dealerProfileDesc = $('#dealerMemo').val();
			//수정 ajax시작
			$.ajax({
				url : BNK_CTX + '/product/mypage/mycarDealerBusinesscard/modifyNameCard',
				method:'POST',
				data :JSON.stringify(modifyParams),
				contentType: 'application/json;charset=UTF-8',
				success : function(data){
					alertify.alert('수정 되었습니다.');
					mycar_businesscard_list(1);
					$('.p-close').trigger('click');
					$('.cardP1').show();
					$('.cardP2').hide();

					//프로필에 명함사진적용
					$(".profileImage .imgBack img").prop('src', $("#noImage").prop('src'));
				},
				error : function(request,status,error){
					alertify.alert(error);
				}
			});
		});

		//수정취소 버튼 클릭시
		$('.p-close').click(function () {
			$('.cardP1').show();
			$('.cardP2').hide();
		});

	});
});

//리스트 불러오기
function mycar_businesscard_list(curPage){
	$.ajax({
		url : BNK_CTX + '/product/mypage/mycarDealerBusinesscard/AJAX',
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

//명함 재전송
function resendCard(userId){
	alertify.confirm('재발송 하시겠습니까?', function(){
		$.ajax({
			url : BNK_CTX + '/product/mypage/mycarDealerBusinesscard/register',
			method:'POST',
			data :JSON.stringify({userId : userId}),
			contentType: 'application/json;charset=UTF-8',
			success : function(data){
				alertify.alert('재발송 되었습니다.')
				mycar_businesscard_list(1);
			},
			error : function(request,status,error){
				alertify.alert(error);
			}
		});
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