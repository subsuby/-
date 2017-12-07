<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- contents -->
<div class="contents">
    <section>
        <div class="myLayout">
        		<jsp:include page="mycar_menu.jsp" flush="false" />
				<!--  -->
                <div class="titBar"><!-- active 추가시 활성화 -->
                    <h2>매물등록</h2>
                    <!-- <span class="btnHelp"><em class="blind">도움말</em></span>
                    <div class="popHelp">
                    </div> -->
                </div>
                <form id="mycarDealerForm" name="mycarDealerForm">
                <div class="myWrite">
                    <div class="writeRow">
                        <strong><label for="lb1">차량번호</label></strong>
                        <span><input name="carPlateNum" type="text" id="lb1" class="w150" value="${car.carPlateNum}"></span>
                        <strong><label for="lb2">등록일자</label></strong>
                        <span><input name="applyDay" type="text" placeholder="yyyymmdd" id="lb2" maxlength="8"></span>
                    </div>
                    <div class="writeRow">
						<strong><label for="lb21">차대번호</label></strong>
						<span><input name="carFrameNum" type="text" id="lb21" value="${car.carFrameNum}" maxlength="17"></span>
						<strong>보상상품</strong>
						<span class="bsSelect">
							<input type="checkbox" name="carGuarRefundYn" onclick="useProduct(this)" />
								<label for="bs01">환불보장 (0)</label>
							<input type="hidden" name="carGuarRefundYnCnt"/>
							<input type="checkbox" name="carGuarFruitlessYn" onclick="useProduct(this)"/>
								<label for="bs02">헛걸음보장 (0) </label>
							<input type="hidden" name="carGuarFruitlessYnCnt"/>
						</span>
					</div>
                    <div class="writeRow">
                        <strong>제조사/모델</strong>
                        <span>
                            <select name="makerCd" class="w50p" onchange="model_list(this.value, 'modelCd')">
                            </select>
                            <select name="modelCd" class="w50p" onchange="model_list(this.value, 'modelDtlCd')">
                            </select>
                        </span>
                        <strong>세부모델</strong>
                        <span>
                            <select name="modelDtlCd" onchange="model_list(this.value, 'gradeCd')">
                            </select>
                        </span>
                    </div>
                    <div class="writeRow">
                        <strong>등급</strong>
                        <span>
                            <select name="gradeCd">
                            </select>
                        </span>
                        <strong><label for="lb3">연식</label></strong>
                        <span><input name="carRegYear" type="text" id="lb3" placeholder="yyyy" maxlength="4" value="${car.carRegYear}"></span>
                    </div>
                    <div class="writeRow">
                        <strong>연료타입</strong>
                        <span>
                            <select name="carFuel">
                            	${bnk:genOptionTag('SYS_CODE_CAR_FUEL_TYPE',car.carFuel)}
                            </select>
                        </span>
                        <strong>변속기</strong>
                        <span>
                            <select name="carMission">
                            	${bnk:genOptionTag('SYS_CODE_CAR_MISSION_TYPE',car.carMission)}
                            </select>
                        </span>
                    </div>
                    <div class="writeRow">
                        <strong><label for="lb4">주행거리</label></strong>
                        <span class="km"><input name="useKm" type="text" id="lb4" value="${car.useKm}"><i>km</i></span>
                        <strong>색상</strong>
                        <span>
                            <select name="carColor">
                                ${bnk:genOptionTag('SYS_CODE_CAR_COLOR_TYPE', car.carColor)}
                            </select>
						</span>
                    </div>
                    <div class="writeRow">
                        <strong>외관상태</strong>
                        <span>
                            <select name="surfaceState">
                                ${bnk:genOptionTag('SYS_CODE_CAR_EXT_STATUS','')}
                            </select>
						</span>
                        <strong><label for="lb5">판매가격</label></strong>
						<span class="price"><input name="saleAmt" type="text" id="lb5" value="${car.saleAmt}"><i>만원</i></span>
                    </div>
                    <div class="writeRow">
                        <strong><label for="lb6">성능점검번호</label></strong>
						<span><input name="carCheckNo" type="text" id="lb6" value="${car.carCheckNo}" maxlength="10"></span>
                        <strong>렌터카 사용이력</strong>
                        <span>
                            <select name="rentYn">
                                ${bnk:genOptionTag('SYS_CODE_CAR_RENT_STATUS','')}
                            </select>
						</span>
                    </div>
                    <div class="writeRow last">
                        <strong>사고내역</strong>
                        <span>
                            <select name="sagoYn">
                                ${bnk:genOptionTag('SYS_CODE_CAR_ACC_STATUS',car.sagoYn)}
                            </select>
						</span>
                        <strong><label for="lb7">세금 등 미납내역</label></strong>
						<span><input name="unpaidTax" type="text" id="lb7" placeholder="세금 등 미납내역"></span>
                    </div>
                </div>
				<!---->
                <div class="titBar pt40 noline"><!-- active 추가시 활성화 -->
                    <h2>옵션 입력</h2>
                    <span class="btnHelp"><em class="blind">도움말</em></span>
                    <div class="popHelp">
                    </div>
                </div>
                <dl class="myWrite carOptions"> <!-- selector 참조를 위한 class 추가 17.08.14 by hk-lee -->
	                <c:forEach var="code" items="${ct:getAllValues(ct:getConstDef('SYS_CODE_CAR_OPTION_TYPE'))}" varStatus="status">
                       <dt class="allCheckBar">
                           <strong>${code[2]}</strong>
                           <label for="checkAll${status.index}"><input id="checkAll${status.index}" type="checkbox" onclick="checkAll('option${status.index}_', this)">전체</label>
                       </dt>
                       <dd class="checkArea bgWhite bdbn">
                           <c:forEach var="subCode" items="${ct:getAllValues(code[1])}" varStatus="subStatus">
                               	<label for="option${status.index}_${subStatus.index}"><input type="checkbox" id="option${status.index}_${subStatus.index}" value="${subCode[0]}" ${ct:contains(car.optionCdArr,subCode[0]) ? 'checked' : ''} >${subCode[2]}</label>
                           </c:forEach>
                       </dd>
	                </c:forEach>
                </dl>
				<!---->
                <div class="titBar pt40 noline"><!-- active 추가시 활성화 -->
                    <h2>상세설명</h2>
                    <span class="btnHelp"><em class="blind">도움말</em></span>
                    <div class="popHelp">
                    </div>
                </div>
				<div class="myWrite">
					<div class="writeRow type1 last explain">
						<strong><label for="lb75">상세설명</label></strong>
						<span class="vam"><textarea name="carDesc" rows="9" cols="70" id="lb75" placeholder="사고내역을 포함한 차량 상세설명을 입력하세요." class="fl"></textarea></span>
						<div class="checkArea w240 fr">
							<p>클릭하시면 자동으로 입력됩니다.</p>
							<label for="area_0" class="w240"><input type="checkbox" id="area_0" onclick="setArea(this)" value="무사고차량입니다.">무사고차량입니다.</label>
							<label for="area_1" class="w240"><input type="checkbox" id="area_1" onclick="setArea(this)" value="1인 소유로 관리 잘 된 차량입니다.">1인 소유로 관리 잘 된 차량입니다.</label>
							<label for="area_2" class="w240"><input type="checkbox" id="area_2" onclick="setArea(this)" value="내외관 모두 깨끗합니다.">내외관 모두 깨끗합니다.</label>
							<label for="area_3" class="w240"><input type="checkbox" id="area_3" onclick="setArea(this)" value="주행거리 짧은 쌩쌩한 차량입니다">주행거리 짧은 쌩쌩한 차량입니다.</label>
							<label for="area_4" class="w240"><input type="checkbox" id="area_4" onclick="setArea(this)" value="소모품 교환한 차량입니다.">소모품 교환한 차량입니다.</label>
							<label for="area_5" class="w240"><input type="checkbox" id="area_5" onclick="setArea(this)" value="타이어 교환한 차량입니다.">타이어 교환한 차량입니다.</label>
						</div>

					 </div>
				</div>
				<!---->
                <div class="titBar pt40 noline"><!-- active 추가시 활성화 -->
                    <h2>사진 및 동영상 등록</h2>
                    <span class="btnHelp"><em class="blind">도움말</em></span>
                    <div class="popHelp">
                    </div>
                </div>
				<div class="myWrite">
					<div class="writeRow type1">
						<strong>사진 등록</strong>
						<div class="mycarImage">
							<ul>
								<c:forEach var="img" items="${car.carImageFileList}">
								<li>
									<div class="imageUp">
										<span class="imgFileDelete"><input style="button" value="삭제하기"></span>
										<span class="imgFileUp" style="display:none;">
											<label>추가하기</label>
											<input type="file">
										</span>
										<div><strong><img src="<c:url value="${img.logiThumbPath}"/>"onerror='this.src="<c:url value="/product/images/thumbnail/shift_car_002.jpg"/>"'></strong></div>
										<input type="hidden" name="fileSeqs[]" value="${img.fileSeq}"/>
									</div>
								</li>
								</c:forEach>
								<li id="uploader" style="${fn:length(car.carImageFileList) >= 20 ? 'display:none;':''}">
									<div class="imageUp">
										<span class="imgFileDelete" style="display:none;"><input style="button" value="삭제하기"></span>
										<span class="imgFileUp">
											<label>추가하기</label>
											<input type="file">
										</span>
										<div><strong><img></strong></div>
									</div>
								</li>
							</ul>
						</div>
					</div>
					<div class="writeRow type1 last">
                        <strong><label for="lb78">동영상 등록</label></strong>
						<span>
							<input name="carVideoUrl" type="text" id="lb78" placeholder="동영상 등록">
						</span>
					</div>
				</div>
                <!---->
                <div class="titBar pt40 noline"><!-- active 추가시 활성화 -->
                    <h2>주차위치</h2>
                    <span class="btnHelp"><em class="blind">도움말</em></span>
                    <div class="popHelp">
                    </div>
                </div>
				<div class="myWrite">
					<div class="writeRow type1">
                        <strong><label for="lb84">우편번호</label></strong>
                        <span>
                        	<input name="parkZip" id="zipCode" type="text" id="lb84" class="w150" placeholder="우편번호" value="${sessUserInfo.zipCode}">
                        	<button type="button" class="btn-popup-auto" id="btnAddr" data-pop-opts='{"target": ".findAddress"}'>주소검색</button>
                        </span>
					</div>
					<div class="writeRow type1">
                        <strong><label for="lb82">기본주소</label></strong>
						<span>
							<input name="parkAddr1" id="addr1" type="text" id="lb85" readonly placeholder="기본주소" value="${sessUserInfo.addr1}">
						</span>
					</div>
					<div class="writeRow type1 last">
                        <strong><label for="lb83">상세주소</label></strong>
						<span>
							<input name="parkAddr2" type="text" id="lb83" placeholder="상세주소" ${sessUserInfo.addr2}>
						</span>
					</div>
				</div>
                <!---->
                <div class="btnSet mt40">
           			 <span class="tar"><a href="<c:url value="/product/mypage/mycarDealer"/>" class="redLine w240">취소</a></span>
           			 <span class="tal"><a class="red w240" onclick="regist()">등록하기</a></span>
        		</div>
			</form>
            </div>
        </div>
    </section>
</div>
<!-- //contents -->