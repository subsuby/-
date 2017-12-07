<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<title>GMK Smart work</title>
		<meta charset="UTF-8"> 
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">
		<link rel="shortcut icon" href="/front/images/favicon.ico" />
		<link rel="stylesheet" href="/front/css/common.css">
		<link rel="stylesheet" href="/front/css/responsive.css">
		<!-- js libs -->
		<script src="http://code.jquery.com/jquery-1.12.3.min.js"></script>
		<script src="http://code.jquery.com/jquery-migrate-1.4.0.min.js"></script>
		<script>
			$(document).ready(function() {
				$("#btn_login").click(function() {
		            $("#login_form").submit();       
				});
				// error message hide 처리
				$("input[name='un'], input[name='up']").keydown(function (key) { 
					if(key.keyCode == 13){$("#login_form").submit();} // Enter Key Evnet
				});
				var param = getUrlParams();
				if(param.c && param.cd){
					/* 
					 * 01 : 카매니저 정보 갱신 또는 디바이스가 인증되지 않았습니다.
					 * 10 : 비밀번호가 틀렸습니다.
					 * 20 : 비밀번호가 만료되었습니다.
					 * 30 : 비밀번호 오류횟수가 초과되었습니다.
					 * 40 : 입력하신 사번을 확인해 주세요.
					 * 77 : 이전사번 로그인 시도
					 * 88 : 인증서버 연결을 실패하였습니다.
					 * 99 : 기타오류
					 */
					switch(param.cd){
						case '01': alertify.alert('카매니저 정보 갱신 또는 디바이스가 인증되지 않았습니다.');break;
						case '10': alertify.alert('비밀번호가 틀렸습니다.');break;
						case '20': alertify.alert('비밀번호가 만료되었습니다.');break;
						case '30': alertify.alert('비밀번호 오류횟수가 초과되었습니다.');break;
						case '40': alertify.alert('입력하신 사번을 확인해 주세요.');break;
						case '77': alertify.alert('이전사번 로그인 시도');break;
						case '88': alertify.alert('인증서버 연결을 실패하였습니다.');break;
						default : alertify.alert('기타오류');break;
					}	
					window.location.search = 'c=fail';
				}
				saveLastId();
			});
			//save id
			function saveLastId(){
				 // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
			    var userInputId = getCookie("userInputId");
			    $("input[name=un]").val(userInputId); 
			     
			    if($("input[name=un]").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
			        $("#c_01").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
			    }
			     
			    $("#c_01").change(function(){ // 체크박스에 변화가 있다면,
			        if($("#c_01").is(":checked")){ // ID 저장하기 체크했을 때,
			            var userInputId = $("input[name=un]").val();
			            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
			        }else{ // ID 저장하기 체크 해제 시,
			            deleteCookie("userInputId");
			        }
			    });
			     
			    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
			    $("input[name=un]").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
			        if($("#c_01").is(":checked")){ // ID 저장하기를 체크한 상태라면,
			            var userInputId = $("input[name=un]").val();
			            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
			        }
			    });
			}
			
			function setCookie(cookieName, value, exdays){
			    var exdate = new Date();
			    exdate.setDate(exdate.getDate() + exdays);
			    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
			    document.cookie = cookieName + "=" + cookieValue;
			}
			 
			function deleteCookie(cookieName){
			    var expireDate = new Date();
			    expireDate.setDate(expireDate.getDate() - 1);
			    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
			}
			 
			function getCookie(cookieName) {
			    cookieName = cookieName + '=';
			    var cookieData = document.cookie;
			    var start = cookieData.indexOf(cookieName);
			    var cookieValue = '';
			    if(start != -1){
			        start += cookieName.length;
			        var end = cookieData.indexOf(';', start);
			        if(end == -1)end = cookieData.length;
			        cookieValue = cookieData.substring(start, end);
			    }
			    return unescape(cookieValue);
			}
			
			function getUrlParams() {
				var params = {};
				window.location.search.replace(
						/[?&]+([^=&]+)=([^&]*)/gi,
							function(str, key, value){params[key] = value;}
				);
				return params;
			}
			
        </script>
	</head>
	<body>
	
		<!-- 로그인 contents -->
		<div id="loginContents">
			<!-- 로그인 -->
			<div class="loginLayout">
				<section>

					<div class="loginForm">
						<section>
							<h1><img src="/front/images/img_maintit.png" alt="Mobile Smart Work | GM KOREA 전자 견적서 / 전자 매매 계약서" /></h1>
							<form name="login_form" id="login_form" action="<c:url value="/session/custom-login-proc"/>" method="post">
								<div class="idInput">
									<label><input type="text" placeholder="ID" name="un" /></label>
								</div>
								<div class="pwInput">
									<label><input type="password" placeholder="PASSWORD" name="up" /></label>
								</div>
								<div class="loginSubmit">
									<input type="submit" value="로그인" id="btn_login"/>
								</div>
								<div class="saveId">
									<span class="checkSet">
										<input type="checkbox" id="c_01" checked />
										<label for="c_01">판매코드 저장</label>
									</span>
								</div>
								<p>디바이스 등록 및 회원가입 후 로그인이 가능합니다. <br/>비밀번호 분실 시 시스템 관리자에게 문의하시기 바랍니다.</p>
							</form>
						</section>
					</div>
					
				</section>
			</div>
			<div class="comMainLogo"><img src="/front/images/img_mainfoot.png" alt="Chevrolet" /></div>
			<!-- //로그인 -->
			<img src="/front/images/img_mainbg.png" alt="" class="comMainBG" /> <!-- 관리자에서 등록한 이미지 -->
		</div>
		<!-- //로그인 contents -->

	</body>
</html>