<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
    <div class="joinLayout formArea">
    	<form method="post"   target="_blank" action="">
			<input type="hidden" name="tr_cert" id="tr_cert" value="${tr_cert}"/>
			<input type="hidden" name="tr_url" id="tr_url" value="${tr_url}"/>
			<input type="hidden" name="tr_add" value="N"/>
		</form>
        <fieldset>
            <dl class="writeRow2">
                <dt><label for="">성명</label></dt>
                <dd>
                    <input type="text" ng-model="user.userName" class="readonly" readonly />
                </dd>
            </dl>
            <dl class="writeRow2">
                <dt><label for="">휴대폰번호</label></dt>
                <dd>
                    <input type="tel" ng-model="user.phoneMobile" class="readonly" readonly />
                </dd>
            </dl>
            <dl class="writeRow2 btnType">
                <dt><label for="">사용중 휴대폰</label></dt>
                <dd>
                    <input type="tel" ng-model="user.actualPhoneMobile" class="readonly" readonly />
                    <button type="button" ng-click="kmCert()">변경</button>
                </dd>
            </dl>
            <dl class="writeRow2 btnType">
                <dt><label for="">비밀번호</label></dt>
                <dd>
                    <input type="password" class="readonly" readonly />
                    <button class="btn-popup-full" data-pop-opts='{"target": ".popWrapPwChange"}'>변경</button>
                </dd>
            </dl>
            <dl class="writeRow2 btnType">
                <dt><label for="">소속단체</label></dt>
                <dd>
                    <input type="text" ng-model="user.danjiFullName" class="readonly" readonly />
                    <button type="button" ng-click="onOpenPopup('GROUP_POP')">변경</button>
                </dd>
            </dl>
            <dl class="writeRow2 btnType">
                <dt><label for="">소속상사</label></dt>
                <dd>
                    <input type="text" ng-model="user.shopFullName" class="readonly" readonly />
                    <button type="button" ng-click="onOpenPopup('FIRM_POP')">변경</button>
                </dd>
            </dl>
            <dl class="writeRow2 btnType">
                <dt><label for="">기타소속</label></dt>
                <dd class="btnWrite">
                    <input type="text" ng-model="user.shopEtc" class=""/>
                    <!-- <button type="button">변경</button> -->
                </dd>
            </dl>
            <dl class="writeRow2 btnType lastRow">
                <dt><label for="">종사자번호</label></dt>
                <dd>
                    <input type="text" ng-model="user.dealerLicenseNo" class="readonly"/>
                    <button class="btn-popup-full" data-pop-opts='{"target": ".popWrapPwChange2"}'>변경</button>
                </dd>
            </dl>

            <div class="writeRow emailArea lastRow mb20">
                <!-- 2017-05-26 UI변경 -->
                <div class="fArea">
                    <input type="text" ng-model="emailId" placeholder="이메일" />
                </div>
                <div class="sArea">
                    <em>@</em>
                    <input type="text" ng-model="emailDo" placeholder="직접입력" value="{{emailDo}}"><!-- 2017-05-26 placeholder 추가 -->
                    <span class="selectSet">
                        <select ng-model="emailDo">
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
                </div>
                <!-- //2017-05-26 UI변경 -->
            </div>

            <!-- 2017-05-23 주소찾기 사용안함-->
           <div class="writeRow btnType">
				<input type="text" ng-model="zipCode"  placeholder="우편번호" class="readonly" readonly />
				<label for="zipCode" class="dpn">우편번호</label>
				<button type="button" ng-click="onOpenPopup('ADDR_POP')">변경</button>
			</div>
			<div class="readtxt">
				<input type="text" ng-model="addr1"  placeholder="주소" class="readonly" readonly />
				<label for="addr1" class="dpn">주소</label>
			</div>
			<div class="btnType mb20">
				<input type="text" ng-model="addr2"  placeholder="상세주소" class="readonly" readonly />
				<label for="addr2" class="dpn">상세주소</label>
			</div>
            <div class="btnSet">
                <span><a href="" ng-click="hisBack()" class="redLine">취소</a></span>
                <span><a href=""  ng-click="modify();" class="red">확인</a></span>
            </div>

        </fieldset>
    </div>
</section>