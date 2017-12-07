<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>        
<!-- 2017-07-19 소속단지찾기 -->
<div class="popupAutoWrap popGroup2 p-container w670">
    <!-- popup header -->
    <div class="popupHeaderAuto">
        <header><h1>소속상사찾기</h1></header>
        <a class="btnClose p-close" id="close" onclick="return false;"><em class="blind">닫기</em></a>
    </div>
    <hr/>
    <!-- popup contents -->
    <div class="popupContents">
        <section>
            <div class="autoPop">
                <div class="searchArea">
                    <input type="hidden"    id="selectDanjiNo"      name="selectDanjiNo"    value="">
                    <input type="hidden"    id="selectDanjiName"    name="selectDanjiName"  value="">
                    <input type="text"      id="searchGrpName"      name="searchGrpName"    value="">
                    <button type="button" id="btnGrpSearch" class="iconSearch"><span>검색</span></button>
                </div>
                <div class="popList">
                    <ul id="dataGrpList">
                    </ul>
                </div>
                <div class="btnAreaType">
                    <span><button id="cancelGrp" class="line p-close">취소</button></span>
                    <span><button id="successGrp">확인</button></span>
                </div>
            </div>
        </section>
    </div>
</div>
<!-- //소속단지찾기 -->