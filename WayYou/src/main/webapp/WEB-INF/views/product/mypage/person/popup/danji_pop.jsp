<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>        
<!-- 2017-07-19 소속단지찾기 -->
<div class="popupAutoWrap popGroup p-container w670">
    <!-- popup header -->
    <div class="popupHeaderAuto">
        <header><h1>소속단지찾기</h1></header>
        <a class="btnClose p-close" id="close" onclick="return false;"><em class="blind">닫기</em></a>
    </div>
    <hr/>
    <!-- popup contents -->
    <div class="popupContents">
        <section>
            <div class="autoPop">
                <div class="searchArea">
                    <input type="hidden"    id="selectNo"       name="selectNo"     value="">
                    <input type="hidden"    id="selectName"     name="selectName"   value="">
                    <input type="text"      id="searchName"     name="searchName"   value="">
                    <button type="button"   id="btnSearch" class="iconSearch"><span>검색</span></button>
                </div>
                <div class="popList">
                    <ul id="dataDanjiList"> </ul>
                </div>
                <div class="btnAreaType">
                    <span><button id="cancel" class="line p-close">취소</button></span>
                    <span><button id="success">확인</button></span>
                </div>
            </div>
        </section>
    </div>
</div>
<!-- //소속단지찾기 -->