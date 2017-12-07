<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
    <div class="joinLayout formArea">
    	<form method="post" id="agreeFrm" name="agreeFrm" target="_blank" action="">
			<input type="hidden" name="tr_cert" id="tr_cert" value="${tr_cert}"/>
			<input type="hidden" name="tr_url" id="tr_url" value="${tr_url}"/>
			<input type="hidden" name="tr_add" value="N"/>
		</form>
        <form id="userUpdForm" name="userUpdForm" method="post" action="<c:url value="/front/common/updateUser"/>"enctype="application/x-www-form-urlencoded">
            <input type="hidden" id="userId" name="userId" value=""></input>
            <input type="hidden" id="division" name="division" value="N"></input>
            <fieldset>
                <dl class="writeRow2">
                    <dt><label for="">성명</label></dt>
                    <dd>
                        <input type="text" value="" id="userName" name="userName" class="readonly" readonly />
                    </dd>
                </dl>
                <dl class="writeRow2">
                    <dt><label for="">휴대폰번호</label></dt>
                    <dd>
                        <input type="tel" value="" id="phoneMobile" name="phoneMobile" class="readonly" readonly />
                    </dd>
                </dl>
                <dl class="writeRow2 btnType">
                    <dt><label for="">사용중 휴대폰</label></dt>
                    <dd>
                        <input type="tel" value="" id="actualPhoneMobile" name="actualPhoneMobile" class="readonly" readonly />
                        <button type="button" ng-click="kmCert()">변경</button>
                    </dd>
                </dl>
                <dl class="writeRow2 btnType">
                    <dt><label for="">비밀번호</label></dt>
                    <dd>
                        <input type="password" value="" id="password" name="password" class="readonly" readonly />
                        <button class="btn-popup-full" data-pop-opts='{"target": ".popWrapPwChange"}'>변경</button>
                    </dd>
                </dl>
                <div class="writeRow emailArea lastRow">
                    <!-- 2017-05-26 UI변경 -->
                    <div class="fArea">
                        <input type="text" value="" id="emailId" name="emailId" ng-model="emailId" placeholder="이메일" />
                    </div>
                    <div class="sArea">
                        <em>@</em>
                        <input type="text" id="emailDo" name="emailDo" ng-model="emailDo" value="">
                        <span class="selectSet">
                            <select id="emailSel" ng-model="emailDo">
                                <option value="">직접입력 </option>
                                <option value="naver.com">naver.com</option>
                                <option value="nate.com">nate.com</option>
                                <option value="hanmail.net">hanmail.net</option>
                                <option value="gmail.com">gmail.com</option>
                                <option value="hotmail.com">hotmail.com</option>
                                <option value="yahoo.co.kr">yahoo.co.kr</option>
                                <option value="yahoo.com">yahoo.com</option>
                            </select>
                        </span>
                    <input type="hidden" id="email" name="email" value="{{emailId}}@{{emailDo}}"></input>
                    </div>
                    <!-- //2017-05-26 UI변경 -->
                </div>
                <!-- 2017-05-23 주소찾기 사용안함-->
                <div class="writeRow btnType">
					<input type="text" ng-model="zipCode" value="" id="zipCode" placeholder="우편번호" class="readonly" readonly="" />
					<label for="zipCode" class="dpn">우편번호</label>
					<button type="button" ng-click="addrClick()">변경</button>
				</div>
				<div class="readtxt">
					<input type="text" ng-model="addr1" value="" id="addr1" placeholder="주소" class="readonly" readonly="" />
					<label for="addr1" class="dpn">주소</label>
				</div>
				<div class="readtxt">
					<input type="text" ng-model="addr2" value="" id="addr2" placeholder="상세주소" class="readonly" readonly="" />
					<label for="addr2" class="dpn">상세주소</label>
				</div>
                <dl class="writeRow2">
                    <dt>SMS 수신동의</dt>
                    <dd class="checkArea">
                        <span class="checkSet"><input type="checkbox" id="cc_c1" name="agreeSmsYn" value="" ng-click="smsChk('cc_c1');"/><label for="cc_c1">동의함</label></span>
                        <span class="checkSet"><input type="checkbox" id="cc_c2" name="agreeSmsYn" value="" ng-click="smsChk('cc_c2');"/><label for="cc_c2">동의하지않음</label></span>
                    </dd>
                </dl>
                <dl class="writeRow2 lastRow mb20">
                    <dt>PUSH 수신동의</dt>
                    <dd class="checkArea">
                        <span class="checkSet"><input type="checkbox" id="c_c3" name="agreePushYn" value="" ng-click="pushChk('c_c3');"/><label for="c_c3">동의함</label></span>
                        <span class="checkSet"><input type="checkbox" id="c_c4" name="agreePushYn" value="" ng-click="pushChk('c_c4');"/><label for="c_c4">동의하지않음</label></span>
                    </dd>
                </dl>

                <div class="btnSet">
                    <span><a href="" ng-click="hisBack()" class="redLine">취소</a></span>
                    <span><a href="" ng-click="modify();" class="red">확인</a></span>
                </div>

                <!-- <div class="btnSet btnSecession">
                    <a href="">회원탈퇴하기</a>
                </div> -->
            </fieldset>
        </form>
    </div>
</section>