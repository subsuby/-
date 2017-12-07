<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- contents -->
<div class="contents">
	<section>
		<div class="form">
			<div class="innerLayout">
				<div class="dataSet">
					<h2 class="icon2">회원가입<em>간편하게 가입에 가능합니다.</em></h2>
				</div>
			</div>
			<div class="loginLayout bgGrayCase pt80">
				<form id="frm" name="frm" method="POST" action="">
					<input type="hidden" id="agreeMarketing" name="agreeMarketing" value="${param.agreeMarketing}" >
					<input type="hidden" id="phoneCert" name="phoneCert" value="N" >
					<input type="hidden" id="urlType" name="urlType" value="02" >
					<div class="joinForm formArea">
						<div class="writeRow">
							<input type="text" value="" id="name" name="name" placeholder="성명">
							<label for="" class="dn">성명</label>
						</div>
						<div class="writeRow">
							<input type="password" id="pwd" name="pwd" placeholder="숫자와 영문자, 특수문자 조합으로 10~20자">
							<label for="" class="dn">비밀번호</label>
						</div>
						<div class="writeRow">
							<input type="password" id="pwdChk" name="pwdChk" placeholder="비밀번호 재확인">
							<label for="" class="dn">비밀번호 확인</label>
						</div>
						<div class="writeRow gender">
							<span class="on"><label for="a1"><input type="radio" name="gender" id="men" value="0" checked ><i>남자</i></label></span>
							<span><label for="a2"><input type="radio" name="gender" id="girl" value="1"><i>여자</i></label></span>
						</div>
						<div class="writeRow birthday">
							<span>생일</span>
							<span><input type="number" value="" id="year" name="year" placeholder="년(4자)" maxlength="4" oninput="maxLengthCheck(this)"><label for="" class="dn">년도</label></span>
							<span>
								<select id="month" name="month">
									<option value="">월</option>
									<c:forEach var="month" begin="1" end="12" step="1">
										<option value="<fmt:formatNumber value="${month}" pattern="00"/>"><c:out value="${month}" />월</option>
									</c:forEach>
								</select>
							</span>
							<span>
								<select id="day" name="day">
									<option>일</option>
									<c:forEach var="day" begin="1" end="31" step="1">
										<option value="<fmt:formatNumber value="${day}" pattern="00"/>"><c:out value="${day}" />일</option>
									</c:forEach>
								</select>
							</span>
						</div>
	                    <div class="writeRow">
	                        <input type="text" value="" id="email" name="email" placeholder="본인확인 이메일">
	                        <label for="" class="dn">본인확인 이메일</label>
	                    </div>
	                    <div class="writeRow btnType phoneNum lastRow mb20">
	                        <span>
	                            <select id="phoneCorp" name="phoneCorp">
	                                <option value="SKT">SKT</option>
	                                <option value="KTF">KT</option>
	                                <option value="LGT">LGU+</option>
	                                <option value="SKM">SKTmvno</option>
									<option value="KTM">KTmvno</option>
									<option value="LGM">LGU+mvno</option>
	                            </select>
	                        </span>
	                        <span>
	                            <input type="text" id="phoneNo" name="phoneNo" maxlength="11" oninput="maxLengthCheck(this)" placeholder="전화번호">
	                            <label for="" class="dn">전화번호</label>
	                            <!-- <button class="btn-popup-full" data-pop-opts="{&quot;target&quot;: &quot;.fullAddress&quot;}">인증</button> -->
							</span>
						</div>
	               <!-- <div class="writeRow btnType lastRow mb20">
	                   <input type="number" value="" id="" placeholder="인증번호">
	                   <label for="" class="dn">인증번호</label>
	                   <button class="btn-popup-full" data-pop-opts="{&quot;target&quot;: &quot;.fullAddress&quot;}">확인</button>
	               </div> -->

						<div class="certifyArea" id="accDiv">
							본인명의의 휴대전화를 이용하여 인증을 진행합니다.
							<div class="btnSet">
								<span><a href="#" class="redLine certifyCase" id="phoneAcc"><em>휴대전화 인증</em></a></span>
							</div>
						</div>
						<div class="certifyArea" id="accSuccDiv" style="display:none;">
							<p>휴대전화 인증이 완료되었습니다.</p>
						</div>

						<div class="writeRow btnType">
							<input type="hidden" value="" id="danjiNo" name="danjiNo">
                            <input type="text" value="" id="dealerDanjiName" name="dealerDanjiName" placeholder="소속단지" readonly="readonly">
                            <label for="" class="dn">소속단지</label>
                            <button class="btn-popup-auto" id="btnGroup" onclick="return false;" data-pop-opts='{"target": ".popGroup"}'>검색</button> <!-- 2017-07-19 -->
                         </div>
                         <div class="writeRow btnType">
                         	<input type="hidden" value="" id="shopNo" name="shopNo">
                            <input type="text" value="" id="dealerShopName" name="dealerShopName" placeholder="소속상사" readonly="readonly">
                            <label for="" class="dn">소속상사</label>
                            <button class="btn-popup-auto" id="btnShop" onclick="return false;" data-pop-opts='{"target": ".popGroup"}'>검색</button> <!-- 2017-07-19 -->
                         </div>
                         <div class="writeRow">
                            <input type="text" value="" id="shopEtc" name="shopEtc" placeholder="기타소속">
                            <label for="shopEtc" class="dn">기타소속</label>
                         </div>
                         <div class="writeRow lastRow mb20">
                            <input type="text" value="" id="dealerLicenseNo" name="dealerLicenseNo" placeholder="종사자번호">
                            <label for="dealerShopName" class="dn">종사자번호</label>
                         </div>


						<dl class="writeRow2">
							<input type="checkbox" id="smsAcc"><label for="smsAcc"> SMS, PUSH 수신동의</label>
						</dl>
	                        <!-- 휴대전화인증 위치 -->
	                    <div class="btnSet">
	                        <span><a href="#" id="btnJoin" class="red">가입하기</a></span>
	                    </div>
	                </div>
                </form>
            </div>
        </div>
    </section>
    <!-- 본인인증서비스 요청 form --------------------------->
	<form id="reqKMCISForm" name="reqKMCISForm" method="post">
	    <input type="hidden" id="tr_cert" name="tr_cert" value="">
	    <input type="hidden" id="tr_url" name="tr_url" value="">
	    <input type="hidden" id="tr_add" name="tr_add" value="N">
	</form>
</div>


