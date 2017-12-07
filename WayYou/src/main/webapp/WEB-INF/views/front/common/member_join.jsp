<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
    <div class="joinLayout formArea">
        <form id="userForm" name="userForm" method="post" action="<c:url value="/front/common/insertUser"/>"enctype="application/x-www-form-urlencoded">
            <input type="hidden" id="division" name="division" ng-model="division" value="N"></input>
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
                        <input type="text" value="" placeholder="이메일" id="emailId" name="emailId" ng-model="emailId">
                    </div>
                    <div class="sArea">
                        <em>@</em>
                        <input type="text" id="emailDo" name="emailDo" ng-model="emailDo" placeholder="직접입력" value="{{emailDo}}"><!-- 2017-05-26 placeholder 추가 -->
                        <span class="selectSet">
                            <select id="emailDo" ng-model="emailDo">
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
                    <input type="hidden" id="email" name="email" ng-model="email" value="{{emailId}}@{{emailDo}}"></input>
                    </div>
                    <!-- //2017-05-26 UI변경 -->
                </div>
                <!-- 2017-05-23 주소찾기 삭제 -->
                <dl class="writeRow2">
                    <dt>SMS 수신동의</dt>
                    <dd class="checkArea">
                        <span class="checkSet"><input type="checkbox" id="c_c1" ng-model="c_c1" name="agreeSmsYn" value="" ng-click="smsChk('c_c1');"/><label for="c_c1">동의함</label></span>
                        <span class="checkSet"><input type="checkbox" id="c_c2" ng-model="c_c2" name="agreeSmsYn" value="" ng-click="smsChk('c_c2');"/><label for="c_c2">동의하지않음</label></span>
                    </dd>
                </dl>
                <dl class="writeRow2 lastRow mb20">
                    <dt>PUSH 수신동의</dt>
                    <dd class="checkArea">
                        <span class="checkSet"><input type="checkbox" id="c_c3" ng-model="c_c3" name="agreePushYn" value="" ng-click="pushChk('c_c3');"/><label for="c_c3">동의함</label></span>
                        <span class="checkSet"><input type="checkbox" id="c_c4" ng-model="c_c4" name="agreePushYn" value="" ng-click="pushChk('c_c4');"/><label for="c_c4">동의하지않음</label></span>
                    </dd>
                </dl>

                <div class="btnSet">
                    <span><a href="<c:url value='/session/front/login'></c:url>" class="redLine">취소</a></span>
                    <span>
                        <button type="button" class="red" ng-click="join();">확인</button>
                    </span>
                    
                </div>
            </fieldset>
        </form>
    </div>
</section>