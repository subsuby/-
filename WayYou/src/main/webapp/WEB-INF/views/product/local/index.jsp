<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div id="contents_wrap" class="sidemenu">
    <!-- leftMenu -->
    <aside class="leftMenu">
        <div class="writeFullType">
            <dl>
                <dt class="title">최대 가격<i>PRICE</i></dt>
                <dd class="data">
                    <div class="sliderRange">
                        <output></output><em>+</em><i>만원</i>
                        <input type="range" min="0" max="6000" value="2000" data-rangeslider>
                    </div>
                </dd>
            </dl>
            <dl>
                <dt class="title">최대 주행거리<i>MILEAGE</i></dt>
                <dd class="data">
                    <div class="sliderRange">
                        <output></output><em>+</em><i>km</i>
                        <input type="range" min="0" max="80" value="50" data-rangeslider>
                    </div>
                </dd>
            </dl>
        </div>
        <div class="btn-accordion-wrapper writeType" data-toggle-on="true">
            <!---->
            <dl class="btn-accordion-switch accordionSet">
                <dt class="accordionTitle btn-accordion-switch-item">
                    <strong>연식<i>YEAR</i></strong>
                </dt>
                <dd class="accordionData">
                    <ul class="dotList">
                        <li class="on"><a href="">2016</a></li>
                    </ul>
                </dd>
            </dl>
            <!---->
            <dl class="btn-accordion-switch accordionSet">
                <dt class="accordionTitle btn-accordion-switch-item">
                    <strong>제조사<i>MAKE</i></strong>
                </dt>
                <dd class="accordionData">
                    <ul class="dotList">
                        <li><a href="">현대</a></li>
                        <li class="sel"><a href="">기아</a></li>
                        <li><a href="">쉐보레</a></li>
                        <li><a href="">제네시스</a></li>
                        <li><a href="">르노삼성</a></li>
                        <li><a href="">쌍용</a></li>
                        <li class="more"><a href="">기타제조사</a></li>
                    </ul>
                </dd>
            </dl>
            <!---->
            <dl class="btn-accordion-switch accordionSet">
                <dt class="accordionTitle btn-accordion-switch-item">
                    <strong>모델<i>MODEL</i></strong>
                </dt>
                <dd class="accordionData">
                </dd>
            </dl>
            <!---->
            <dl class="btn-accordion-switch accordionSet">
                <dt class="accordionTitle btn-accordion-switch-item">
                    <strong>상세모델<i class="fs10">DETAIL MODEL</i></strong>
                </dt>
                <dd class="accordionData">
                </dd>
            </dl>
            <!---->
            <dl class="btn-accordion-switch accordionSet">
                <dt class="accordionTitle btn-accordion-switch-item">
                    <strong>색상<i>COLOR</i></strong>
                </dt>
                <dd class="accordionData colorck">
                    <span class="bg_b"><label for="ck1"><input type="checkbox" id="ck1" checked > <em>검정색</em></label></span>
                    <span class="bg_w"><label for="ck2"><input type="checkbox" id="ck2"> <em>흰색</em></label></span>
                    <span class="bg_g"><label for="ck3"><input type="checkbox" id="ck3"> <em>은색</em></label></span>
                    <span class="bg_p"><label for="ck4"><input type="checkbox" id="ck4"> <em>진주색</em></label></span>
                    <span class="bg_r"><label for="ck5"><input type="checkbox" id="ck5"> <em>빨간색</em></label></span>
                    <span class="bg_e"><label for="ck6"><input type="checkbox" id="ck6"> <em>기타</em></label></span>
                </dd>
            </dl>
            <!---->
            <dl class="btn-accordion-switch accordionSet">
                <dt class="accordionTitle btn-accordion-switch-item">
                    <strong>지역<i>AREA</i></strong>
                </dt>
                <dd class="accordionData">
                </dd>
            </dl>
            <!---->
            <dl class="btn-accordion-switch accordionSet">
                <dt class="accordionTitle btn-accordion-switch-item">
                    <strong>상세지역<i>DETAIL AREA</i></strong>
                </dt>
                <dd class="accordionData">
                </dd>
            </dl>
            <!---->
        </div>
    </aside>
    <!-- //leftMenu -->

    <!-- contents -->
    <div class="contents">
        <section>
            <div class="topSearch">
                <div class="searchText "><!-- 검색단어 노출시 class="searchWord" 삽입 -->
                    <div class="back">
                        <div class="inputArea">
                            <input type="button" value="기아" class="sChoiced" />
                            <input type="button" value="기아" class="sChoiced" />
                            <input type="button" value="기아" class="sChoiced" />
                            <input type="button" value="기아" class="sChoiced" />
                            <input type="text" class="wFull readonly" placeholder="원하는 매물 정보를 입력하세요">
                        </div>
                        <input type="button" value="초기화" class="tsSeset" />
                    </div>
                </div>
                <div class="searchSelect" style="display:none;">
                    <ul>
                        <li>르노삼성</li>
                        <li>기아</li>
                        <li>현대</li>
                        <li>한국GM</li>
                        <li>제네시스</li>
                        <li>BMW</li>
                    </ul>
                </div>
            </div>
            <!-- -->
            <div class="titBar"><!-- active 추가시 활성화 -->
                <h2>인증매물 <em>썸카플러스 자체매물로 Make up 서비스가 완료되었고, 품질보장을 제공합니다.</em></h2>
            </div>
            <ul class="listType1">
                <li>
                    <div class="thumBack">
                        <a href="buy_detail.html.html">
                            <span class="markSet mark1">인증</span>
                            <img src="../../images/thumbnail/sample1.png" alt="" />
                        </a>
                    </div>
                    <div class="prBack">
                        <a href="buy_detail.html.html">
                            <span class="productInfo">
                                <span class="tit"><strong>기아</strong><span>쏘울 1.6 GDI 럭셔리</span><span>스타일팩A...</span></span>
                                <span class="option"><em>2016</em><em>서울</em><em>30k km</em></span>
                            </span>
                            <span class="markGroup">
                                <span class="markSet mark2">환불</span>
                                <span class="markSet mark3">헛걸음</span>
                                <span class="markSet mark4">연장</span>
                                <strong class="goodsPrice">996,500<i>만원</i></strong>
                            </span>
                        </a>
                    </div>
                    <span class="heartSet"><input type="checkbox" id="h_1" checked /><label for="h_1"><!--찜하기--></label></span>
                </li>
                <li>
                    <div class="thumBack">
                        <a href="buy_detail.html.html">
                            <span class="markSet mark1">인증</span>
                            <img src="../../images/thumbnail/sample1.png" alt="" />
                        </a>
                    </div>
                    <div class="prBack">
                        <a href="buy_detail.html.html">
                            <span class="productInfo">
                                <span class="tit"><strong>기아</strong><span>쏘울 1.6 GDI 럭셔리</span><span>스타일팩A...</span></span>
                                <span class="option"><em>2016</em><em>서울</em><em>30k km</em></span>
                            </span>
                            <span class="markGroup">
                                <span class="markSet mark2">환불</span>
                                <span class="markSet mark3">헛걸음</span>
                                <span class="markSet mark4">연장</span>
                                <strong class="goodsPrice">996,500<i>만원</i></strong>
                            </span>
                        </a>
                    </div>
                    <span class="heartSet"><input type="checkbox" id="h_2" /><label for="h_2"><!--찜하기--></label></span>
                </li>
                <li>
                    <div class="thumBack">
                        <a href="buy_detail.html.html">
                            <span class="markSet mark1">인증</span>
                            <img src="../../images/thumbnail/sample1.png" alt="" />
                        </a>
                    </div>
                    <div class="prBack">
                        <a href="buy_detail.html.html">
                            <span class="productInfo">
                                <span class="tit"><strong>기아</strong><span>쏘울 1.6 GDI 럭셔리</span><span>스타일팩A...</span></span>
                                <span class="option"><em>2016</em><em>서울</em><em>30k km</em></span>
                            </span>
                            <span class="markGroup">
                                <span class="markSet mark2">환불</span>
                                <span class="markSet mark3">헛걸음</span>
                                <span class="markSet mark4">연장</span>
                                <strong class="goodsPrice">996,500<i>만원</i></strong>
                            </span>
                        </a>
                    </div>
                    <span class="heartSet"><input type="checkbox" id="h_3" /><label for="h_3"><!--찜하기--></label></span>
                </li>
                <li>
                    <div class="thumBack">
                        <a href="buy_detail.html.html">
                            <span class="markSet mark1">인증</span>
                            <img src="../../images/thumbnail/sample1.png" alt="" />
                        </a>
                    </div>
                    <div class="prBack">
                        <a href="buy_detail.html.html">
                            <span class="productInfo">
                                <span class="tit"><strong>기아</strong><span>쏘울 1.6 GDI 럭셔리</span><span>스타일팩A...</span></span>
                                <span class="option"><em>2016</em><em>서울</em><em>30k km</em></span>
                            </span>
                            <span class="markGroup">
                                <span class="markSet mark2">환불</span>
                                <span class="markSet mark3">헛걸음</span>
                                <span class="markSet mark4">연장</span>
                                <strong class="goodsPrice">996,500<i>만원</i></strong>
                            </span>
                        </a>
                    </div>
                    <span class="heartSet"><input type="checkbox" id="h_1" checked /><label for="h_1"><!--찜하기--></label></span>
                </li>
                <li>
                    <div class="thumBack">
                        <a href="buy_detail.html.html">
                            <span class="markSet mark1">인증</span>
                            <img src="../../images/thumbnail/sample1.png" alt="" />
                        </a>
                    </div>
                    <div class="prBack">
                        <a href="buy_detail.html.html">
                            <span class="productInfo">
                                <span class="tit"><strong>기아</strong><span>쏘울 1.6 GDI 럭셔리</span><span>스타일팩A...</span></span>
                                <span class="option"><em>2016</em><em>서울</em><em>30k km</em></span>
                            </span>
                            <span class="markGroup">
                                <span class="markSet mark2">환불</span>
                                <span class="markSet mark3">헛걸음</span>
                                <span class="markSet mark4">연장</span>
                                <strong class="goodsPrice">996,500<i>만원</i></strong>
                            </span>
                        </a>
                    </div>
                    <span class="heartSet"><input type="checkbox" id="h_1" checked /><label for="h_1"><!--찜하기--></label></span>
                </li>
            </ul>
            <!-- -->
        </section>
    </div>
</div>