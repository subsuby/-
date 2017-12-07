<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 메이크업 신청하기 -->
<div class="popupAutoWrap makeupAdd p-container">
    <!-- popup header -->
    <div class="popupHeaderAuto">
        <header><h1>메이크업 신청하기</h1></header>
        <a class="btnClose p-close" onclick="return false;"><em class="blind">닫기</em></a>
    </div>
    <hr/>
    <!-- popup contents -->
    <div class="popupContents">
        <section>
            <div class="autoPop">
                <div class="searchArea">
                    <input type="text" id="MakeupCarPlateNum" name="schValue" placeholder="마이카에 등록한 차량번호를 입력하세요.">
                    <button type="button" class="iconSearch" onclick="fn_searchMakeupCar()"><span>검색</span></button>
                </div>
                <div class="carInfo mt20">
                    <ul class="txtListType1">
                        <li>
                            <strong>차량번호</strong>
                            <input type="hidden" id="carSeqHidden"></input>
                            <input type="hidden" id="carPlateNumHidden"></input>
                            <span id="carPlateNum"></span>
                        </li>
                        <li>
                            <strong>배기량</strong>
                            <span id="carCC"></span><!-- CC -->
                        </li>
                        <li>
                            <strong>연식</strong>
                            <span id="carRegYear"></span>
                        </li>
                        <li>
                            <strong>색상</strong>
                            <span id="carColor"></span>
                        </li>
                        <li>
                            <strong>주행거리</strong>
                            <span id="useKm"></span>
                        </li>
                        <li>
                            <strong>제시번호</strong>
                            <span id="carRegDay"></span>
                        </li>
                        <li>
                            <strong>변속기</strong>
                            <span id="carMission"></span>
                        </li>
                        <li>
                            <strong>압류/저당</strong>
                            <span id="attachCnt"></span>
                            <span id="mortGageCnt"></span>
                        </li>
                        <li>
                            <strong>연료</strong>
                            <span id="carFuel"></span>
                        </li>
                        <li>
                            <strong>세금미납</strong>
                            <span id="unpaidTax"></span>
                        </li>

                    </ul>
                </div>
                <div class="mt20">
                    <h3>요청서비스</h3>
                    <div class="backLine">
                        <span><label><input type="checkbox" id="makeChk1" checked="checked" disabled >세차</label></span>
                        <span><label><input type="checkbox" id="makeChk2" checked="checked" disabled >광택</label></span>
                        <span><label><input type="checkbox" id="makeChk3" checked="checked" disabled >사진 및 동영상 촬영</label></span>
                    </div>
                </div>
                <div class="mt20">
                    <h3>기타 요청사항</h3>
                    <textarea name="reqRemark" id="reqRemark"></textarea>
                </div>
                <div class="btnAreaType mt40">
                    <span><button type="button" id="cancelMakeup" class="btnClose p-close line">취소</button></span>
                    <span><button type="button" onclick="fn_insertMakeup()">신청</button></span>
                </div>
            </div>
        </section>
    </div>
</div>
<!-- //메이크업 신청하기 -->