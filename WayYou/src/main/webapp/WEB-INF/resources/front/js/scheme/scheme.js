var __backCnt = 0; 
function __onBackPress(url){
	if(window.ITCButton.isOpenPopup()){
		window.ITCButton.closePopup();
	}else if(window.slideLeft.mask.hasClass('is-active')){
		window.slideLeft.close();
		window.slideRight.close();
	}else{
		window.history.back();
		if(url.indexOf('/front/index') >= 0){
			setTimeout(function(){__backCnt=0;},500);	// 초기화(0.5초)
			console.log('\'뒤로\'버튼을 한번 더 누르시면 종료됩니다.');
			if(++__backCnt == 2){
				alertify.confirm('앱을 종료하시겠습니까?', function(){
					location.href = "bnk://system.appFinish";
				});
			}
		}
	}
}

function __setLoginForm(data){
	
	console.log('@@@@@@@@@@@@@@@@@@@@@@@@@@ ', data);
	if($('#deviceContain').length == 0)$('#login_form').append('<div id="deviceContain">');
	$('#deviceContain').empty();
	$('#deviceContain').append($('<input type="hidden">').prop('name','pushToken').val(data.pushToken));			// 푸시토큰
	$('#deviceContain').append($('<input type="hidden">').prop('name','deviceType').val(data.deviceType));			// 디바이스 타입(android, ios)
	$('#deviceContain').append($('<input type="hidden">').prop('name','deviceOsVer').val(data.deviceOsVer));		// 디바이스 OS 버전
	$('#deviceContain').append($('<input type="hidden">').prop('name','deviceModel').val(data.deviceModel));		// 디바이스 모델명
	$('#deviceContain').append($('<input type="hidden">').prop('name','appVer').val(data.appVer));					// 앱 버전(사용자 고지)
	$('#deviceContain').append($('<input type="hidden">').prop('name','buildVer').val(data.buildVer));				// 빌드 버전(업데이트 체크)

}

/** App Gubun 
 * 	- isAppGubun: 앱이면 true, 앱이 아니면 false를 반환
 *  - __mobileGubun: scheme callback function
 * */
var gv_appGubun = false;
var iframeError;
function __appGubun(result){
	if(result == 1){
		gv_appGubun = true;
		clearTimeout(iframeError);
		console.log('success');
	}else{
		gv_appGubun = false;
		console.log('failed');
	}
}
function isAppGubun(){
	return gv_appGubun;
}
$(document).ready(function(){
	// 잘못된 url 호출로 모바일 웹에서 에러 발생하지 않도록 iframe으로 감싸서 앱 구분 체크를 한다.
	var iframe = document.createElement('iframe');
	iframe.setAttribute("style", "display:none;");
	iframe.setAttribute("id", "appCheck");
	document.body.appendChild(iframe);
	
	var url = 'bnk://app.gubun';
	$("#appCheck").attr("src", url);
	iframeError = setTimeout(function(){__appGubun(-1)}, 1000);
});
/* // */