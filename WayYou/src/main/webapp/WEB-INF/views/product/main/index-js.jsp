<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
$(function(){
	main_list();

	var mH = $(window).outerHeight()-57;
	$('.topContents').css("height", mH);
	//listReactive(); //2017-09-11 추가
	$( window ).resize(function() {
		var mH = $(window).outerHeight()-57;
		$('.topContents').css("height", mH);
		//listReactive(); //2017-09-11 추가
	});
	$('.scrollDown').on('click', function (){
		var dtop = $('.tabContents').offset().top;
		$('body, html').animate({
			'scrollTop' : dtop
		},500);
	});


	// 매물정보 입력 완성
	$("#searchName").keyup(function(){
		if($(this).val() != "") {
			$(".searchSelect").show();
			getQuickSearchData($(this).val());
		} else {
			$(".searchSelect").hide();
		}
	})

/* 	// 체크박스 검색 클릭시 앞에 li의 색상을 변경
	function searchSelect(obj, data) {
		if($(obj).is(":checked")){
			$(obj).parents("li").addClass("on");
			quickCheckTagAdd(data);
			setWords(data);
		} else {
			$(obj).parents("li").removeClass("on");
			quickDelete(obj, data);
		}
	} */

});

/* 2017-09-11 */
var listReactive = function(){
	$('#wrap').addClass("carListCase");
	var widths = $("#wrap.carListCase .listType1").width();
	var num = parseInt(widths/5);
	$("#wrap.carListCase .listType1 li").css('width',num+"px");

	var sWidth = $(".saleCar").width();
	var sHeight = $(".saleCar").height();
	var lHeight = $(".listSet").height();
	$(".imgBack").css({
		'width':(num)+'px',
		'height':(sHeight)+'px'
	});
	$(".listType1 .heartSet").css({
		'bottom':(lHeight-sHeight-38)+'px'
	});
};
/* end 2017-09-11 */


//인증중고차 리스트
function main_list(){
	$.ajax({
		url : BNK_CTX + '/product/mainCertify/AJAX',
		dataType : 'html',
		cache : false,
		success : function(result){
			$("#templateList").html(result);

			$(".listType1 li").hover(
			  function() {
				  $(this).addClass('on');
			  }, function() {
				  $(this).removeClass('on');
			  }
			); // 2017-08-22 by mj-cho
			//$(".listType1 li").css("width" , "50px");
			listReactive();
		},
		error : function(request,status,error){
			alertify.alert(error);
		}
	});
}

//퀵검색
var getQuickSearchData = function(name){
	$("#dropdown").html("");
	$.ajax({
		url : BNK_CTX + "/product/car/quick/search"
		, data : {searchName : name}
		, dataType : 'json'
		, type: "get"
		, contentType: "application/json; charset=UTF-8"
		, success : function(data){
			var tag = "";
			if(data.length == 0) {
				$("#dropdown").append($('<li/>', {
					text: "매물 정보를 찾을 수 없습니다"
				}));
			} else {
				$.each(data, function(index, info){
					$("#dropdown").append($('<li/>', {
						onclick: "quickTextSelect('"+info.code+"','"+info.name+"')"
						,value: info.code
						, text: info.name
					}));
				});
			}
		},
		error: function(error){
			alertify.alert("데이터 통신상태가 원활하지 않습니다.");
			console.log(status);
        }
	});
};
var quickTextSelect = function(code, name){
	var searchInfo = {};
	searchInfo.exists = true;
	searchInfo.code = code;
	searchInfo.name = name;
	$('#searchName').val(name);
	$(".searchSelect").hide();
	localStorage.setObject("searchInfo", searchInfo);
}

</script>