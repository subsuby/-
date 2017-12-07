<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
 <!-- contents -->
<div class="contents">
	<section>
		<form name="frm" method="post">
		<div class="form">
			<div class="innerLayout">
				<div class="dataSet">
					<h2 class="icon2">회원정보 수정<em>회원님의 정보를 변경하시고자하는 경우, 아래에서 수정해주세요.</em></h2>
				</div>
			</div>
			<div class="loginLayout bgGrayCase pt80">
				<div class="joinForm formArea">
					<div class="writeRow">
					<input type="hidden" value="${userInfo.userId }" id="userId" name="userId">
						<input type="text" value="${userInfo.userName }" id="userName" name="userName" placeholder="성명" readonly>
						<label for="" class="dn">성명</label>
					</div>
					<div class="writeRow">
						<input type="text" value="${ct:phoneFomatter(userInfo.phoneMobile)}" id="phoneMobile" name="phoneMobile" placeholder="휴대폰번호" readonly>
						<label for="" class="dn">휴대폰번호</label>
					</div>
					<div class="writeRow btnType">
						<label for="" class="dn">사용중 휴대폰번호</label>
						<div><input type="text" value="${ct:phoneFomatter(userInfo.actualPhoneMobile)}" id="actualPhoneMobile" name="actualPhoneMobile" placeholder="사용중 휴대폰번호" readonly></div>
						<button type="button" id="phoneUpdate" onclick="return false;" class="wAuto">사용중 휴대폰번호 변경</button> <!-- 본인인증 후 전화번호 변경 -->
					</div>
					<div class="writeRow btnType">
						<label for="" class="dn">비밀번호</label>
						<div><input type="password" value="**********" id="password" name="password"  placeholder="비밀번호" readonly></div>
						<button type="button" class="wAuto btn-popup-auto" onclick="return false;" data-pop-opts='{"target": ".pwChange"}'>비밀번호 변경</button> <!-- 2017-07-19 -->
					</div>
					<div class="writeRow lastRow mb20">
						<input type="text" value="${userInfo.email}" id="email" name="email" placeholder="이메일">
						<label for="" class="dn">이메일</label>
					</div>

					<div class="writeRow btnType">
						<input type="text" value="${userInfo.zipCode}" id="zipCode" name="zipCode" placeholder="우편번호" readonly>
						<label for="" class="dn">우편번호</label>
						<button type="button" class="btn-popup-auto" id="btnAddr" onclick="return false;" data-pop-opts='{"target": ".findAddress"}'>변경</button> <!-- 2017-07-19 -->
					</div>
					<div class="writeRow">
						<input type="text" value="${userInfo.addr1}" id="addr1" name="addr1" placeholder="주소" readonly>
						<label for="" class="dn">주소</label>
					</div>
					<div class="writeRow lastRow mb20">
						<input type="text" value="${userInfo.addr2}" id="addr2" name="addr2" placeholder="상세주소">
                        <label for="" class="dn">상세주소</label>
                    </div>
                    
                    <dl class="writeRow2">
                    <c:choose>
                    	<c:when test="${userInfo.agreeSmsYn eq 'Y' and userInfo.agreePushYn eq 'Y'}">
                    		<input type="checkbox" id="c_c3" checked><label for="c_c3"> SMS, PUSH 수신동의</label>
                    	</c:when>
                    	<c:otherwise>
                    		<input type="checkbox" id="c_c3"><label for="c_c3"> SMS, PUSH 수신동의</label>	
                    	</c:otherwise>
                    </c:choose>
                    </dl>

                    <div class="btnSet">
                        <span><a href='<c:url value="/product/mypage/mycarPerson"/>' id="btnUseUpdateCacel" class="redLine">취소</a></span>
                        <span><a href="#" id="btnUseUpdate" class="red">수정</a></span>
                    </div>
                </div>
            </div>
        </div>
        </form>
    </section>
    <!-- 본인인증서비스 요청 form --------------------------->
	<form id="reqKMCISForm" name="reqKMCISForm" method="post">
	    <input type="hidden" id="tr_cert" name="tr_cert" value="">
	    <input type="hidden" id="tr_url" name="tr_url" value="">
	    <input type="hidden" id="tr_add" name="tr_add" value="N">	
	</form>
</div>
<!-- //contents -->
