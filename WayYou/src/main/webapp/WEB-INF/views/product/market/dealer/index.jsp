<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="contents">
    <section>
    	<form id="sendDataForm">
			<input type="hidden" name="carFullCode" value=""	/>		   	   <!-- (필수)차량코드 (아래 차량코드에 의해서 입력됨)-->
    		<!-- tab 1 -->
			<input type="hidden" name="makerCd" value="true^1" />              <!-- (필수)제조사코드 -->
			<input type="hidden" name="modelCd" value="true^1" />              <!-- (필수)모델코드 -->
			<input type="hidden" name="detailModelCd" value="true^1" />        <!-- (필수)세부모델코드 -->
			<input type="hidden" name="gradeCd" value="true^1" />              <!-- (필수)등급코드 -->
			<input type="hidden" name="carRegYear" value="true^1" />           <!-- (필수)연식 -->
			<input type="hidden" name="carFuel" value="true^1" />              <!-- (필수)연료 -->
			<input type="hidden" name="carMission" value="true^1" />           <!-- (필수)변속기 -->

			<!-- tab 2 -->
			<input type="hidden" name="useKm" value="true^2" />                <!-- (필수)주행거리 -->
			<input type="hidden" name="carColor" value="true^2" />             <!-- (필수)색상 -->
			<input type="hidden" name="surfaceState" value="true^2" />         <!-- (필수)외관상태 -->
			<input type="hidden" name="rentYn" value="false^2" />               <!-- 렌터카사용이력 -->
			<input type="hidden" name="sagoYn" value="false^2" />               <!-- 사고이력 -->
			<input type="hidden" name="unpaidTax" value="false^2" />            <!-- 세금미납내역 -->

			<!-- tab 3 -->
			<input type="hidden" name="images" value="false^3" />               <!-- 이미지파일(태그용) -->
			<input type="hidden" name="optionCds" value="false^3" />            <!-- 옵션코드 -->
			<input type="hidden" name="carDesc" value="false^3" />              <!-- 차량상세설명 -->
			<input type="hidden" name="carVideoUrl" value="false^3" />          <!-- 동영상주소 -->
			<input type="hidden" name="parkZip" value="false^3" />              <!-- 우편번호 -->
			<input type="hidden" name="parkAddr1" value="false^3" />            <!-- 주소 -->
			<input type="hidden" name="parkAddr2" value="false^3" />            <!-- 상세주소 -->
			<input type="hidden" name="carPlateNum" value="true^3" />           <!-- (필수)차량번호 -->
			<input type="hidden" name="carFrameNum" value="false^3" />          <!-- 차대번호 -->
			<input type="hidden" name="applyDay" value="true^3" />              <!-- (필수)등록일자 -->
			<input type="hidden" name="carCheckNo" value="true^3" />            <!-- (필수)성능점검번호 -->
			<input type="hidden" name="carGuarFruitlessYn" value="false^3" />   <!-- 헛걸음보상 -->
			<input type="hidden" name="carGuarRefundYn" value="false^3" />      <!-- 환불보상 -->
			<input type="hidden" name="carGuarTermYn" value="false^3" />        <!-- 연장보증 -->
			<input type="hidden" name="saleAmt" value="true^3" />               <!-- (필수)판매가격 -->
			<!--파일고유번호 여기서부터 히든으로 추가/삭제됨 -->

		</form>

        <div class="carSell">
            <div class="innerLayout">
                <div class="dataSet">
                    <h2>내차팔기<em>차량정보를 입력하시면 내 차 시세를 확인하실 수 있습니다.</em></h2>
                </div>
            </div>
			<!-- Tab 클릭하지 없음으로 변경 -->
			<div class="fixedArea">
				<div class="innerLayout bgGrayCase">
					<div class="dataSet">
						<div class="stepInfo grid3">
							<strong class="stepInfo1 on"><span>정보입력</span></strong>
							<strong class="stepInfo2"><span>상태입력</span></strong>
							<strong class="stepInfo3"><span>세부입력</span></strong>
						</div>
						<div class="productInfoTab">
							<div class="inputArea">
								<input id="_makerCd" type="button" class="sChoiced tab1" style="display:none;" onclick="onClick('REMOVE_COMBO', this)">		<!-- 제조사 -->
								<input id="_modelCd" type="button" class="sChoiced tab1" style="display:none;" onclick="onClick('REMOVE_COMBO', this)">		<!-- 모델 -->
								<input id="_detailModelCd" type="button" class="sChoiced tab1" style="display:none;" onclick="onClick('REMOVE_COMBO', this)">	<!-- 세부모델 -->
								<input id="_gradeCd" type="button" class="sChoiced tab1" style="display:none;" onclick="onClick('REMOVE_COMBO', this)">	<!-- 등급 -->
								<input id="_carRegYear" type="button" class="sChoiced tab1" style="display:none;" onclick="onClick('REMOVE', this)">		<!-- 연식 -->
								<input id="_carFuel" type="button" class="sChoiced tab1" style="display:none;" onclick="onClick('REMOVE', this)">			<!-- 연료 -->
								<input id="_carMission" type="button" class="sChoiced tab1" style="display:none;" onclick="onClick('REMOVE', this)">		<!-- 변속기 -->

								<input id="_useKm" type="button" class="sChoiced tab2" style="display:none;" onclick="onClick('REMOVE', this)">				<!-- 주행거리 -->
								<input id="_carColor" type="button" class="sChoiced tab2" style="display:none;" onclick="onClick('REMOVE', this)">			<!-- 색상 -->
								<input id="_surfaceState" type="button" class="sChoiced tab2" style="display:none;" onclick="onClick('REMOVE', this)">		<!-- 외관상태 -->
								<input id="_rentYn" type="button" class="sChoiced tab2" style="display:none;" onclick="onClick('REMOVE', this)">			<!-- 렌터카여부 -->
								<input id="_sagoYn" type="button" class="sChoiced tab2" style="display:none;" onclick="onClick('REMOVE', this)">			<!-- 사고이력 -->
								<input id="_unpaidTax" type="button" class="sChoiced tab2" style="display:none;" onclick="onClick('REMOVE', this)">			<!-- 세금미납내역 -->

								<input id="_optionCds" type="button" class="sChoiced tab3" style="display:none;" onclick="onClick('REMOVE_CHECK', this)">	<!-- 옵션 -->
								<input id="_images" type="button" class="sChoiced tab3" style="display:none;" onclick="onClick('REMOVE_FILE', this)">		<!-- 사진등록 -->
								<input id="_carDesc" type="button" class="sChoiced tab3" style="display:none;" onclick="onClick('REMOVE', this)">			<!-- 상세설명 -->
								<input id="_carVideoUrl" type="button" class="sChoiced tab3" style="display:none;" onclick="onClick('REMOVE', this)">		<!-- 동영상주소 -->
								<input id="_parkAddr1" type="button" class="sChoiced tab3" style="display:none;" onclick="onClick('REMOVE_ADDR', this)">	<!-- 주소 -->
								<input id="_parkAddr2" type="button" class="sChoiced tab3" style="display:none;" onclick="onClick('REMOVE_ADDR', this)">	<!-- 세부주소 -->
								<input id="_carPlateNum" type="button" class="sChoiced tab3" style="display:none;" onclick="onClick('REMOVE', this)">		<!-- 차량번호 -->
								<input id="_carFrameNum" type="button" class="sChoiced tab3" style="display:none;" onclick="onClick('REMOVE', this)">		<!-- 차대번호 -->
								<input id="_applyDay" type="button" class="sChoiced tab3" style="display:none;" onclick="onClick('REMOVE', this)">			<!-- 등록일자 -->
								<input id="_carCheckNo" type="button" class="sChoiced tab3" style="display:none;" onclick="onClick('REMOVE', this)">		<!-- 성능점검번호 -->
								<input id="_carGuarRefundYn" type="button" class="sChoiced tab3" style="display:none;" onclick="onClick('REMOVE', this)">	<!-- 환불보상-->
								<input id="_carGuarFruitlessYn" type="button" class="sChoiced tab3" style="display:none;" onclick="onClick('REMOVE', this)"><!-- 헛걸음보상-->
								<input id="_saleAmt" type="button" class="sChoiced tab3" style="display:none;" onclick="onClick('REMOVE', this)">			<!-- 차량가격 -->

							</div>
							<button class="btnInit" onclick="removeAll()">선택초기화<i></i></button>
						</div>
					</div>
				</div>
			</div>
			<!-- 정보입력 -->
			<div class="step1Write">
				<div class="innerLayout bgGrayCase">
					<div class="dataSet">
						<div class="itemSelect">
							<dl class="areaWrap w166">
								<dt class="tit">제조사</dt>
								<dd class="area">
									<ul id="maker_area">
										<!-- TODO: -->
									</ul>
								</dd>
							</dl>
							<dl class="areaWrap w166">
								<dt class="tit">모델</dt>
								<dd class="area">
									<ul id="model_area">
										<li><input type="radio"><label>모델</label></li>
									</ul>
								</dd>
							</dl>
							<dl class="areaWrap w244">
								<dt class="tit">세부모델</dt>
								<dd class="area">
									<ul id="model_detail_area">
										<li><input type="radio"><label>세부모델</label></li>
									</ul>
								</dd>
							</dl>
							<dl class="areaWrap w200">
								<dt class="tit">등급</dt>
								<dd class="area">
									<ul id="grade_area">
										<li><input type="radio"><label>등급</label></li>
									</ul>
								</dd>
							</dl>
							<dl class="areaWrap w116">
								<dt class="tit">연식</dt>
								<jsp:useBean id="now" class="java.util.Date"/>
								<fmt:formatDate var="year" value="${now}" pattern="yyyy"/>
								<dd class="area">
									<ul>
										<c:forEach var="y" begin="1986" end="${year}" step="1">
											<li><input type="radio" name="carRegYear" data-label="${year+1987-y}" data-value="${year+1987-y}" onclick="render(this)"><label>${year+1987-y}</label></li>
										</c:forEach>
									</ul>
								</dd>
							</dl>
							<dl class="areaWrap w192">
								<dt class="tit">연료타입</dt>
								<dd class="area">
									<ul>
										<c:forEach var="code" items="${ct:getAllValues(ct:getConstDef('SYS_CODE_CAR_FUEL_TYPE'))}">
											<li><input type="radio" name="carFuel" data-label="${code[2]}" data-value="${code[0]}" onclick="render(this)"><label>${code[2]}</label></li>
                                       	</c:forEach>
									</ul>
								</dd>
							</dl>
							<dl class="areaWrap w160">
								<dt class="tit">변속기</dt>
								<dd class="area">
									<ul>
										<c:forEach var="code" items="${ct:getAllValues(ct:getConstDef('SYS_CODE_CAR_MISSION_TYPE'))}">
											<li><input type="radio" name="carMission" data-label="${code[2]}" data-value="${code[0]}" onclick="render(this)"><label>${code[2]}</label></li>
                                       	</c:forEach>
									</ul>
								</dd>
							</dl>
						</div>
						<div class="preNextBtnArea">
							<button class="btnNext" id="btnNext1" onclick="toStep(this)">다음단계</button> <!-- 1개라도 입력하면 class="btnNext on" -->
						</div>
					</div>
				</div>
			</div>
			<!--//-->
			<!-- 상태입력 -->
			<div class="step2Write" style="display:none;">
				<div class="innerLayout bgGrayCase">
					<div class="dataSet">
						<div class="itemSelect">
							<dl class="areaWrap">
								<dt class="tit">주행거리</dt>
								<dd class="area driven">
									<input name="useKm" type="text" oninput="render_distance(this)" onblur="render_distance(this, true)" maxlength="6"> km
								</dd>
							</dl>
							<dl class="areaWrap">
								<dt class="tit">색상</dt>
								<dd class="area">
									<ul>
										<c:forEach var="code" items="${ct:getAllValues(ct:getConstDef('SYS_CODE_CAR_COLOR_TYPE'))}">
											<li><input type="radio" name="carColor" data-label="${code[2]}" data-value="${code[0]}" onclick="render(this)"><label>${code[2]}</label></li>
										</c:forEach>
									</ul>
								</dd>
							</dl>
							<dl class="areaWrap">
								<dt class="tit">외관상태</dt>
								<dd class="area">
									<ul>
										<c:forEach var="code" items="${ct:getAllValues(ct:getConstDef('SYS_CODE_CAR_EXT_STATUS'))}">
											<li><input type="radio" name="surfaceState" data-label="${code[2]}" data-value="${code[0]}" onclick="render(this)"><label>${code[2]}</label></li>
										</c:forEach>
									</ul>
								</dd>
							</dl>
							<dl class="areaWrap">
								<dt class="tit">렌터카 사용이력</dt>
								<dd class="area">
									<ul>
										<c:forEach var="code" items="${ct:getAllValues(ct:getConstDef('SYS_CODE_CAR_RENT_STATUS'))}">
											<li><input type="radio" name="rentYn" data-label="${code[2]}" data-value="${code[0]}" onclick="render(this)"><label>${code[2]}</label></li>
                                       	</c:forEach>
									</ul>
								</dd>
							</dl>
							<dl class="areaWrap">
								<dt class="tit">사고내역</dt>
								<dd class="area">
									<ul>
										<c:forEach var="code" items="${ct:getAllValues(ct:getConstDef('SYS_CODE_CAR_ACC_STATUS'))}">
											<li><input type="radio" name="sagoYn" data-label="${code[2]}" data-value="${code[0]}" onclick="render(this)"><label>${code[2]}</label></li>
                                       	</c:forEach>
									</ul>
								</dd>
							</dl>
							<dl class="areaWrap">
								<dt class="tit">세금 등 미납내역</dt>
								<dd class="area">
									<ul>
										<li><input name="unpaidTax" type="radio" data-label="있음" data-value="있음" onclick="render(this)"><label>있음</label></li>
										<li><input name="unpaidTax" type="radio" data-label="없음" data-value="없음" onclick="render(this)"><label>없음</label></li>
									</ul>
								</dd>
							</dl>
						</div>
						<div class="preNextBtnArea">
							<button class="btnPrev" id="btnPrev2" onclick="toStep(this)">이전단계</button>
							<button class="btnNext" id="btnNext2" onclick="toStep(this)">다음단계</button> <!-- 1개라도 입력하면 class="btnNext on" -->
						</div>
					</div>
				</div>
			</div>
			<!--//-->
			<!-- 세부입력 -->
			<div class="step3Write" style="display:none;">
				<div class="innerLayout">
					<div class="dataSet">
						<dl class="enterDetail">
							<dt>옵션 체크리스트</dt>
							<dd class="btn-accordion-wrapper" data-toggle-on="true" data-multiple-on="true">
								<c:forEach var="code" items="${ct:getAllValues(ct:getConstDef('SYS_CODE_CAR_OPTION_TYPE'))}" varStatus="statu">
								<div class="btn-accordion-switch accordionSet" onclick="watchChecked(this)">
									<strong class="accordionTitle btn-accordion-switch-item">${code[2]}<span>0</span>
									</strong>
									<div class="accordionData">
										<div class="back">
											<div>
											<c:forEach var="subCode" items="${ct:getAllValues(code[1])}" varStatus="status">
												<span><input type="checkbox" id="pOpt${statu.index}${status.index}" onclick="render_check(this)" value="${subCode[0]}"><label for="pOpt${statu.index}${status.index}">${subCode[2]}</label></span>
											</c:forEach>
											</div>
										</div>
										<span class="total"><input type="checkbox" id="allChk${statu.index}" onclick="checkAll(this)"><label for="allChk${statu.index}">전체선택</label></span>
									</div>
								</div>
								</c:forEach>
							</dd>
						</dl>
					</div>
				</div>
				<!---->
				<div class="innerLayout bgGrayCase">
					<div class="dataSet">
						<dl class="enterDetail2">
							<dt>세부설명</dt>
							<!---->
							<dd>
								<strong class="stit">차량사진</strong>
								<div class="enterDate mycarImage">
									<ul>
										<li class="file_template" style="display:none;">
											<div class="imageUp">
												<span class="imgFileDelete"><input style="button" value="삭제하기"></span>
												<span class="imgFileUp" style="display:none;">
													<label>추가하기</label>
													<input name="fileSeqs[]" type="file">
												</span>
												<div><strong><img></strong></div>
											</div>
										</li>
										<li id="uploader">
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
							</dd>
							<!---->
							<dd>
								<strong class="stit">상세설명</strong>
								<div class="enterDate">
									<textarea name="carDesc" oninput="render_input(this)"></textarea>
								</div>
							</dd>
							<!---->
							<dd>
								<strong class="stit">동영상등록</strong>
								<div class="enterDate">
									<input type="text" placeholder="동영상 등록" name="carVideoUrl" oninput="render_input(this)">
								</div>
							</dd>
							<!---->
							<dd>
								<strong class="stit">주차위치</strong>
								<div class="enterDate findZip">
									<input id="parkZip" name="parkZip" type="text" readonly="" placeholder="우편번호" value="${sessUserInfo.zipCode}">
									<button type="button" class="btn-popup-auto" data-pop-opts='{"target": ".findAddress"}'>주소검색</button>
									<div>
										<input id="parkAddr1" name="parkAddr1" type="text" readonly="" placeholder="기본주소" value="${sessUserInfo.addr1}">
										<input name="parkAddr2" type="text" placeholder="상세주소" class="right" value="${sessUserInfo.addr2}" oninput="render_addr()">
									</div>
								</div>
							</dd>
							<!---->
							<dd>
								<div class="enterDate dupCase">
									<div class="left">
										<strong class="stit">차량번호</strong>
										<span>
											<input type="text" placeholder="차량번호" name="carPlateNum" oninput="render_input(this)">
										</span>
									</div>
									<div class="right">
										<strong class="stit">차대번호</strong>
										<span>
											<input type="text" placeholder="차대번호" name="carFrameNum" oninput="render_input(this)" maxlength="17">
										</span>
									</div>
								</div>
							</dd>
							<!---->
							<dd>
								<div class="enterDate dupCase">
									<div class="left">
										<strong class="stit">등록일자</strong>
										<span>
											<input type="text" placeholder="yyyymmdd" name="applyDay" oninput="render_input(this)" maxlength="8">
										</span>
									</div>
									<div class="right">
										<strong class="stit">성능점검번호</strong>
										<span>
											<input type="text" placeholder="성능점검번호" name="carCheckNo" oninput="render_input(this)">
										</span>
									</div>
								</div>
							</dd>
							<dd>
								<strong class="stit">보상상품</strong>
								<div class="enterDate">
									<div class="bsSelectButton">
										<span class="cSet cs1">
											<input name="carGuarRefundYn" type="checkbox" id="bs01" onclick="render_product(this)"/><label for="bs01"><em>환불보장</em>(0)</label>
											<input type="hidden" name="carGuarRefundYnCnt"/>
										</span>
										<div>
										<span class="cSet cs2">
											<input name="carGuarFruitlessYn" type="checkbox" id="bs02" onclick="render_product(this)"/><label for="bs02"><em>헛걸음보장</em>(0)</label>
											<input type="hidden" name="carGuarFruitlessYnCnt"/>
										</span>
										</div>
										<span class="cSet cs3">
											<input type="checkbox" id="bs03" disabled=""><label for="bs03"><em>연장보장</em>(0)</label>
										</span>

									</div>
								</div>
							</dd>
							<!---->
							<dd>
								<strong class="stit">판매가격</strong>
								<div class="enterDate price">
									<input type="text" name="saleAmt" oninput="render_price(this)"> 만원
								</div>
							</dd>
							<!---->
						</dl>
					</div>
				</div>
				<!---->
				<div class="innerLayout">
					<div class="dataSet">
						<div class="preNextBtnArea">
							<button class="btnPrev" id="btnPrev3" onclick="toStep(this)">이전단계</button>
							<button class="btnNext on" id="btnNext3" onclick="toStep(this)">매물등록</button> <!-- 1개라도 입력하면 class="btnNext on" -->
						</div>
					</div>
				</div>
			</div>
			<!--//-->
        </div>
    </section>
</div>