<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 명함보내기 -->
<div class="popupAutoWrap popCard p-container w670">
    <!-- popup header -->
    <div class="popupHeaderAuto">
        <header><h1>명함 보내기</h1></header>
        <a class="btnClose p-close" onclick="return false;"><em class="blind">닫기</em></a>
    </div>
    <hr/>
    <!-- popup contents -->
    <div class="popupContents">
        <section>
            <div class="autoPop">
            	<div class="searchArea">
					<input type="text" id="searchTxt" />
					<button type="button" class="iconSearch"><span>검색</span></button>
				</div>
                <div class="infoList" id="pushList">
                </div>
                <div class="btnAreaType">
                    <span><button class="line p-close">취소</button></span>
					<span>
						<button class="" id="cardBtnSend"  onclick="return false;" >전송</button>
						<div class="btn-popup-auto" data-pop-opts='{"target": ".cardSendOk","display":"false"}'></div>
					</span>
<!--                     <span><button>전송</button></span> -->
                </div>
            </div>
        </section>
    </div>
</div>
<!-- //명함보내기 --> 
<!-- 명함보내기 전송완료 -->
<div class="popupAutoWrap cardSendOk p-container">
    <!-- popup contents -->
	<div class="popupContents">
	    <section>
	        <div class="alertPop">
	            <p class="mb20">전송이 완료되었습니다.</p>
	             <div class="btnArea"><span class="w100p"><button id="checkBtnClose">확인</button></span></div>
	            <a class="btnClose p-close" onclick="return false;"><em class="blind">닫기</em></a>
            </div>
        </section>
    </div>
</div>
<!-- //명함보내기 전송완료 -->  
