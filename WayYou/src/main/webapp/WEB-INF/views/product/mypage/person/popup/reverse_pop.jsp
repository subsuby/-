<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 내게맞는매물 -->
<div class="popupAutoWrap reverseAdd p-container">
    <!-- popup header -->
    <div class="popupHeaderAuto">
        <header><h1>내게맞는매물</h1></header>
        <a class="btnClose p-close" onclick="return false;"><em class="blind">닫기</em></a>
    </div>
    <hr/>
    <!-- popup contents -->
    <div class="popupContents">
        <section>
            <div class="autoPop">
                <div class="popTable mt20">
                    <div>
                        <strong>제조사</strong>
                        <span>
                            <input type="hidden" id="hiddenMakerCd"></input>
                            <select name="makerCd" id="reversMakerCd" onchange="model_list(this.value, 'modelCd')"></select>
                        </span>
                    </div>
                    <div>
                        <strong>모델</strong>
                        <span>
                            <select name="modelCd" id="reversModelCd" onchange="model_list(this.value, 'modelDtlCd')">
                            <option value="">모델을 선택하세요</option>
                            </select>
                        </span>
                    </div>
                    <div>
                        <strong>세부모델</strong>
                        <span>
                            <select name="modelDtlCd" id="reversModelDtlCd" onchange="model_list(this.value, 'gradeCd')">
                            <option value="">세부모델을 선택하세요</option>
                            </select>
                        </span>
                    </div>
                    <div>
                        <strong>주행거리</strong>
                        <span><input type="text" id="useKmSelect" name="useKm" placeholder="주행거리를 입력하세요." onkeypress='return event.charCode >= 48 && event.charCode <= 57'/></span>
                    </div>
                    <div>
                        <strong>연식</strong>
                        <span>
                            <select id="carRegYearSelect" name="carRegYear">
                                <c:forEach var="i" begin="0" end="${2017-1990}">
                                    <c:set var="yearOption" value="${2017-i}" />
                                    <option value="${yearOption}">${yearOption}</option>
                                </c:forEach>
                            </select>
                        </span>
                    </div>
                    <div>
                        <strong>색상</strong>
                        <span>
                            <select id="carColorSelect" name="carColor">
                                <c:forEach var="c" items="${ct:getAllValuesBean(ct:getConstDef('SYS_CODE_CAR_COLOR_TYPE'))}">
                                    <option value="${c.cdDtlNo}">${c.cdDtlNm}</option>
                                </c:forEach>
                            </select>
                        </span>
                    </div>
                </div>
                <div class="btnAreaType mt40">
                    <span><button type="button" class="btnClose p-close line">취소</button></span>
                    <span>
                        <button type="button" onclick="fn_insertReserve()">신청</button>
                    </span>
                </div>
            </div>
        </section>
    </div>
</div>
<!-- //내게맞는매물 -->