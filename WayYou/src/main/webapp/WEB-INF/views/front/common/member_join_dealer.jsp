<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
    <div class="joinLayout formArea">
        <form id="dealerForm" name="dealerForm" method="post" action="<c:url value="/front/common/insertUser"/>"enctype="application/x-www-form-urlencoded">
            <input type="hidden" id="division" name="division" ng-model="division" value="D"></input>
            <fieldset>
                <dl class="writeRow2">
                    <dt><label for="">성명</label></dt>
                    <dd>
                        <input type="text" value="{{userName}}" id="userName" name="userName" ng-model="userName" class="readonly" readonly/>
                    </dd>
                </dl>
                <dl class="writeRow2">
                    <dt><label for="">휴대폰번호</label></dt>
                    <dd>
                        <input type="tel" value="{{phoneMobile}}" id="phoneMobile" name="phoneMobile" ng-model="phoneMobile" class="readonly" readonly/>
                    </dd>
                </dl>
                <div class="writeRow">
                    <input type="password" value="" id="password" name="password" ng-model="password" placeholder="10~20자 영문. 숫자. 특수문자 조합" />
                    <label for="" class="dpn">비밀번호</label>
                </div>
                <div class="writeRow">
                    <input type="password" value="" id="passwordChk" name="passwordChk" ng-model="passwordChk" placeholder="비밀번호 확인" />
                    <label for="" class="dpn">비밀번호 확인</label>
                </div>
                <div class="writeRow emailArea lastRow">
                    <!-- 2017-05-26 UI변경 -->
                    <div class="fArea">
                        <input type="text" value="" placeholder="이메일" id="emailId" name="emailId" ng-model="emailId"/>
                    </div>
                    <div class="sArea">
                        <em>@</em>
                        <input type="text" name="emailDo" ng-model="emailDo" placeholder="직접입력" value="{{emailDo}}"><!-- 2017-05-26 placeholder 추가 -->
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
                    <input type="hidden" id="email" name="email" ng-model="email" value="{{emailId}}@{{emailDo}}"></input>
                    <input type="hidden" id="agreeSmsYn"  name="agreeSmsYn"  ng-model="agreeSmsYn"  value="Y"></input>
                    <input type="hidden" id="agreePushYn" name="agreePushYn" ng-model="agreePushYn" value="Y"></input>
                    <!-- //2017-05-26 UI변경 -->
                </div>
                <!-- 2017-05-23 주소찾기 삭제 -->
                <p class="grayTxt">인증비용은 오토모아에서 부담합니다.</p>
                <div class="writeRow btnType">
                    <input type="text" value="" id="danjiFullName" name="danjiFullName" ng-model="danjiFullName" placeholder="소속단체" class="readonly" readonly />
                    <label for="" class="dpn">소속단체</label>
                    <button type="button" ng-click="onOpenPopup('GROUP_POP')">검색</button>
                </div>
                <div class="writeRow btnType">
                    <input type="text" value="" id="shopFullName" name="shopFullName" ng-model="shopFullName" placeholder="소속상사" class="readonly" readonly />
                    <label for="" class="dpn">소속상사</label>
                    <button type="button" ng-click="onOpenPopup('FIRM_POP')">검색</button>
                </div>
                <div class="writeRow">
                    <input type="text" value="" id="shopEtc" name="shopEtc" ng-model="shopEtc" placeholder="기타소속" />
                    <label for="" class="dpn">기타소속</label>
                </div>
                <div class="writeRow lastRow mb20">
                    <input type="text" value="" id="dealerLicenseNo" name="dealerLicenseNo" ng-model="dealerNo" placeholder="종사자번호"/>
                    <!-- <input type="text" name="cellPhone" id="cellPhone" placeholder="핸드폰 번호 입력" maxlength="13" /> -->
                    <label for="" class="dpn">종사자번호</label>
                </div>
                <div class="btnSet">
                    <span><a href="<c:url value='/session/front/login'></c:url>" class="redLine">취소</a></span>
                    <span><button type="button" class="red" ng-click="join();">확인</button></span>
                </div>

            </fieldset>
        </form>
    </div>
</section>

<!-- 기본 alter 팝업 -->
<div class="popupsmallWrap commonPopup p-container">
    <!-- popup contents -->
    <div class="popupContents">
        <section>
            <div class="contentsBack">
                <div class="txtArea">
                    <p>
                        <em>회원가입</em>이 <br/>완료되었습니다.
                    </p>
                </div>
                <div class="btnSet">
                    <span><button class="redLine p-close">취소</button></span>
                    <span><a href="<c:url value='/session/front/login'></c:url>" class="red">확인</a></span>
                </div>
            </div>
        </section>
    </div>
    <!-- //-->
</div>
<div class="popupDim"></div>
<!-- //기본 alter 팝업 -->