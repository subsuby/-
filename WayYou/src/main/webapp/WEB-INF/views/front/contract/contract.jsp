<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
	<!-- 계약서 & 견적서 공통 -->
	<div class="contractLayout">
		<article>
			<div class="ctTop">
				<div class="cNback">
					<div class="carName">
						<div>[상품성강화] 2017년형 ALL NEW 말리부 1.5터보 가솔린LTZ 퍼펙트 블랙휠</div>
						<input type="button" value="차종선택" class="carReName" />
					</div>
				</div>
				<div class="cCback"><div class="carColor">색상은여덟글자임</div></div>
			</div>
		</article>
		<!---->
		<article>
			<div class="ctMenu">
				<div class="tab grid4">
					<span class="checkoff"><a href="#none">개인정보 <strong>수집동의</strong></a></span>
					<!-- <span class="checkoff"> : 다른 탭활성화 + 수집동의 안함 
					<span class="checkon"> : 다른 탭활성화 + 수집동의 완료
					<span class="on checkoff"> : 동의 탭 활성화 + 수집동의 안함
					<span class="on checkon">  : 동의 탭 활성화 + 수집동의 완료 -->
					<span class="on"><a href="#none">매매계약서</a></span>
					<span><a href="#none">계약약관</a></span>
					<span><a href="#none">계약서 확인 <strong>및 서명</strong></a></span>
				</div>
			</div>
		</article>
		<!---->
		<article>
			<h2 class="hiddenTitle">매매계약서</h2>
			<div class="ctDetail">
				<!-- 기본계약정보 -->
				<div class="shadowBox">
					<h3 class="hiddenTitle">기본계약정보</h3>
					<div class="box">
						<div class="uniqueNum">E90003656</div>
						<div class="gridSet grid2-2">
							<div class="gridItem">
								<div class="iSet">
									<label>계약일자 <sup>필수항목</sup></label>
									<span class="iLine"><input type="date" /></span>
								</div>
							</div>
							<div class="gridItem">
								<div class="iSet">
									<label>청약 / 계약장소 <sup>필수항목</sup></label>
									<span class="iLine"><input type="text" /></span>
								</div>
							</div>
						</div>
						<!---->
						<div class="gridSet grid2-2">
							<div class="gridItem">
								<div class="iSet">
									<label>인도일자 <sup>필수항목</sup></label>
									<span class="iLine"><input type="date" /></span>
								</div>
							</div>
							<div class="gridItem">
								<div class="iSet">
									<label>차량인도장소 <sup>필수항목</sup></label>
									<span class="iLine"><input type="text" /></span>
								</div>
							</div>
						</div>
						<!--//-->
					</div>
				</div>
				<!-- 매수인(1) -->
				<div class="lineBox mt13">
					<h3 class="formatTit">
						<strong>매수인(1)</strong>
						<span class="customerCheck">
							<span class="checkSet">
								<input type="checkbox" id="c_01" checked />
								<label for="c_01">E-mail 수신동의</label>
							</span>
							<span class="checkSet">
								<input type="checkbox" id="c_02" checked />
								<label for="c_02">SMS 수신동의</label>
							</span>
							<em>&smashp; e-mail 수신 및 SMS 전송체크 시, 매수인(1)에게 전송됩니다. </em>
						</span>
					</h3>
					<div class="box">
						<div class="gridSet grid2-1">
							<div class="gridItem">
								<div class="iSet">
									<label class="key">성명 <span>(상호/대표이사)</span> <sup>필수항목</sup></label>
									<div class="findCase"><input type="button" value="고객조회" class="btnColor gray" /><span class="iLine"><input type="text" placeholder="성명을 입력해 주세요" /></span></div>
								</div>
								<div class="iSet">
									<label>E-Mail <sup>필수항목</sup></label>
									<div class="emailCase">
										<span class="iLine first"><input type="text" /></span>
										<strong>@</strong>
										<span class="iLine">
											<span class="selectSet">
												<select>
													<option>선택해주세요</option>
												</select>
											</span>
										</span>
										<span class="iLine last"><input type="text" placeholder="직접 입력하세요" /></span>
									</div>
								</div>
							</div>
							<div class="gridItem">
								<div class="iSet">
									<label>서명</label>
									<div class="signCase"><div>서명을 입력해 주세요</div></div>
								</div>
							</div>
						</div>
						<!---->
						<div class="gridSet">
							<div class="gridItem">
								<div class="iSet addCase">
									<label class="key">주민등록주소 <span>(사업자주소)</span> <sup>필수항목</sup></label>
									<div class="findCase"><input type="button" value="주소찾기" class="btnColor gray" /><span class="iLine"><input type="text" placeholder="주소 찾기를 완료하면 자동으로 입력되어 집니다." /></span></div>
									<span class="iLine"><input type="text" placeholder="나머지 주소를 입력해 주세요" /></span>
								</div>
							</div>
						</div>
						<!---->
						<div class="gridSet grid3">
							<div class="gridItem">
								<div class="iSet">
									<label>주민번호 <sup>필수항목</sup></label>
									<span class="iLine"><input type="number" placeholder="숫자로 입력해 주세요" /></span>
								</div>
							</div>
							<div class="gridItem">
								<div class="iSet">
									<label>>  대리인</label>
									<span class="iLine"><input type="text" placeholder="이름을 입력해 주세요" /></span>
								</div>
							</div>
							<div class="gridItem">
								<div class="iSet">
									<label>>  관계</label>
									<span class="iLine"><input type="text" placeholder="관계를 입력해 주세요" /></span>
								</div>
							</div>
						</div>
						<!---->
						<div class="gridSet grid3">
							<div class="gridItem">
								<div class="iSet">
									<label>휴대전화 <sup>필수항목</sup></label>
									<span class="iLine"><input type="number" placeholder="숫자로 입력해 주세요" /></span>
								</div>
							</div>
							<div class="gridItem">
								<div class="iSet">
									<label>자택전화</label>
									<span class="iLine"><input type="number" placeholder="숫자로 입력해 주세요" /></span>
								</div>
							</div>
							<div class="gridItem">
								<div class="iSet">
									<label>직장전화</label>
									<span class="iLine"><input type="number" placeholder="숫자로 입력해 주세요" /></span>
								</div>
							</div>
						</div>
						<!---->
						<div class="gridSet grid3">
							<div class="gridItem">
								<div class="iSet">
									<label>사업자 번호</label>
									<span class="iLine"><input type="number" placeholder="숫자로 입력해 주세요" /></span>
								</div>
							</div>
							<div class="gridItem">
								<div class="iSet">
									<label>업태</label>
									<span class="iLine"><input type="text" placeholder="업태를 입력해 주세요" /></span>
								</div>
							</div>
							<div class="gridItem">
								<div class="iSet">
									<label>종목</label>
									<span class="iLine"><input type="text" placeholder="종목을 입력해 주세요" /></span>
								</div>
							</div>
						</div>
						<!---->
						<div class="gridSet grid3">
							<div class="gridItem">
								<div class="iSet">
									<label>구입용도</label>
									<span class="iLine">
										<span class="selectSet">
											<select>
												<option>선택해주세요</option>
											</select>
										</span>
									</span>
								</div>
							</div>
							<div class="gridItem"></div>
							<div class="gridItem"></div>
						</div>
						<!--//-->
					</div>
				</div>
				<!-- 매수인(2) -->
				<div class="lineBox mt13">
					<h3 class="formatTit">
						<strong>매수인(2)</strong>
						<span class="customerCheck">
							<span class="checkSet">
								<input type="checkbox" id="c_07" />
								<label for="c_07">고객정보가 매수인 (1)과 동일할 경우 정보가 자동으로 입력됩니다.</label>
							</span>
						</span>
					</h3>
					<div class="box">
						<div class="moreBuyer"><input type="button" value="매수인 (2)의 고개정보를 작성합니다" /></div>
					</div>
				</div>
				<!-- 차량사항 -->
				<div class="lineBox mt13">
					<h3 class="formatTit"><strong>차량사항</strong></h3>
					<div class="box">
						<div class="gridSet">
							<div class="gridItem">
								<div class="iSet">
									<label>차종 <sup>필수항목</sup></label>
									<div class="findCase"><input type="button" value="차종검색" class="btnColor gray" /><span class="iLine"><input type="text" placeholder="선택해주세요" /></span></div>
								</div>
							</div>
						</div>
						<!---->
						<div class="gridSet grid2">
							<div class="gridItem">
								<div class="iSet">
									<label>기어타입 <sup>필수항목</sup></label>
									<span class="iLine">
										<span class="selectSet">
											<select>
												<option>선택해주세요</option>
											</select>
										</span>
									</span>
								</div>
							</div>
							<div class="gridItem">
								<div class="iSet">
									<label>색상 <sup>필수항목</sup></label>
									<span class="iLine">
										<span class="selectSet">
											<select>
												<option>선택해주세요</option>
											</select>
										</span>
									</span>
								</div>
							</div>
						</div>
						<!---->
						<div class="gridSet grid2">
							<div class="gridItem">
								<div class="iSet">
									<label>선택사양 <sup>필수항목</sup></label>
									<span class="iLine">
										<span class="selectSet">
											<select>
												<option>선택해주세요</option>
											</select>
										</span>
									</span>
								</div>
							</div>
							<div class="gridItem">
								<div class="iSet">
									<label></label>
									<span class="iLine"><input type="text" /></span>
								</div>
							</div>
						</div>
						<!---->
						<div class="gridSet grid2">
							<div class="gridItem">
								<div class="iSet">
									<label>배송방법 <sup>필수항목</sup></label>
									<span class="iLine">
										<span class="selectSet">
											<select>
												<option>선택해주세요</option>
											</select>
										</span>
									</span>
								</div>
							</div>
							<div class="gridItem">
								<div class="iSet">
									<label>자동차등록 <sup>필수항목</sup></label>
									<span class="iLine">
										<span class="selectSet">
											<select>
												<option>선택해주세요</option>
											</select>
										</span>
									</span>
								</div>
							</div>
						</div>
						<!--//-->
					</div>
				</div>
				<div class="gridSet grid2 mt13">
					<div class="gridItem">
						<!-- 차량판매가격 -->
						<div class="lineBox">
							<h3 class="formatTit"><strong>차량판매가격</strong></h3>
							<div class="box">
								<div class="iSet">
									<label>차량기본가격 <sup>필수항목</sup></label>
									<div class="iLine unitCase"><input type="number" placeholder="0" /><span class="unit">원</span></div>
								</div>
								<div class="iSet blueColor">
									<label>차량옵션가격</label>
									<div class="iLine unitCase"><input type="number" placeholder="0" /><span class="unit">원</span></div>
								</div>
								<div class="iSet redColor">
									<label>차량가격 계</label>
									<div class="iLine unitCase"><input type="number" placeholder="0" /><span class="unit">원</span></div>
								</div>
								<div class="iSet">
									<label>매출 A/C (할인)</label>
									<div class="iLine unitCase"><input type="number" placeholder="0" /><span class="unit">원</span></div>
								</div>
								<div class="iSet redColor">
									<label>현금가격 계</label>
									<div class="iLine unitCase"><input type="number" placeholder="0" /><span class="unit">원</span></div>
								</div>
							</div>
						</div>
					</div>
					<div class="gridItem payCase">
						<!-- 지불조건 -->
						<div class="lineBox">
							<h3 class="formatTit"><strong>지불조건</strong></h3>
							<div class="box">
								<div class="iSet">
									<label>계약금 <sup>필수항목</sup></label>
									<div class="iLine unitCase"><input type="number" placeholder="0" /><span class="unit">원</span></div>
								</div>
								<div class="iSet">
									<label>인도금 1 <sup>필수항목</sup></label>
									<div class="gridSet grid2-2">
										<div class="gridItem">
											<span class="iLine"><input type="date" /></span>
										</div>
										<div class="gridItem">
											<div class="iLine unitCase"><input type="number" placeholder="0" /><span class="unit">원</span></div>
										</div>
									</div>
								</div>
								<div class="iSet">
									<label>인도금 2</label>
									<div class="gridSet grid2-2">
										<div class="gridItem">
											<span class="iLine"><input type="date" /></span>
										</div>
										<div class="gridItem">
											<div class="iLine unitCase"><input type="number" placeholder="0" /><span class="unit">원</span></div>
										</div>
									</div>
								</div>
								<div class="iSet">
									<label>선할인금액</label>
									<div class="gridSet grid2-2">
										<div class="gridItem">
											<span class="iLine"><input type="text" placeholder="카드사를 입력해주세요" /></span>
										</div>
										<div class="gridItem">
											<div class="iLine unitCase"><input type="number" placeholder="0" /><span class="unit">원</span></div>
										</div>
									</div>
								</div>
								<div class="iSet">
									<label>오토 Point</label>
									<div class="iLine unitCase"><input type="number" placeholder="0" /><span class="unit">p</span></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- 차량대금 지급방법 -->
				<div class="lineBox mt13">
					<h3 class="formatTit"><strong>차량대금 지급방법</strong></h3>
					<div class="box">
						<div class="iSet payKind">
							<label>지급방법 <sup>필수항목</sup></label>
							<div class="gridSet grid2">
								<div class="gridItem">
									<span class="radioSet">
										<input type="radio" id="r_01" checked />
										<label for="r_01">일시불</label>
									</span>
									<span class="radioSet">
										<input type="radio" id="r_02" checked />
										<label for="r_02">할부</label>
									</span>
									<span class="radioSet">
										<input type="radio" id="r_03" checked />
										<label for="r_03">오토론</label>
									</span>
								</div>
								<div class="gridItem">
									<span class="iLine"><input type="text" placeholder="금융사명을 입력해 주세요." /></span>
								</div>
							</div>
						</div>
						<div class="lineBox2 installToggle">
							<h4><strong>할부상환내역</strong></h4>
							<div class="box">
								<div class="gridSet grid2">
									<div class="gridItem">
										<div class="iSet">
											<label>할부상품유형</label>
											<span class="iLine">
												<span class="selectSet">
													<select>
														<option>할부</option>
													</select>
												</span>
											</span>
										</div>
										<div class="iSet">
											<label>할부기간 / 이율</label>
											<div class="gridSet grid2"> 
												<div class="gridItem">
													<div class="iLine unitCase"><input type="number" placeholder="" /><span class="unit">회</span></div>
												</div>
												<div class="gridItem">
													<div class="iLine unitCase"><input type="number" placeholder="" /><span class="unit">%</span></div>
												</div>
											</div>
										</div>
									</div>
									<div class="gridItem">
										<div class="iSet">
											<label>대출(할부)원금</label>
											<div class="iLine unitCase"><input type="number" placeholder="0" /><span class="unit">원</span></div>
										</div>
										<div class="iSet">
											<label>월 할부금</label>
											<div class="iLine unitCase"><input type="number" placeholder="0" /><span class="unit">원</span></div>
										</div>
										<div class="iSet redColor">
											<label>할부가격 총액</label>
											<div class="iLine unitCase"><input type="number" placeholder="0" /><span class="unit">원</span></div>
										</div>
									</div>
								</div>
								<!---->
								<div class="txtGuide">
									<ul>
										<li>금융사 대출인 경우 당사 할부판매가 아닌 금융사 상환내역입니다.</li>
										<li>입금계좌는 당사의 전용 계좌로서 안전한 금융거래를 약속드립니다.<br/>저희 회사는 차량구입 관련 비용 일체를 현금으로 수납하지 않습니다.<br/>안전한 금융거래를 위해 인터넷 뱅킹이나 펌뱅킹계좌를 이용해 주시기 바랍니다.
										  </li>
										<li>본건 차량에 불만이 있으시면 고객상담센터(080-3000-5000) 또는 해당 대리점에 문의하시기 바랍니다.<br/>당사는 고객님의 불만이 있는 경우 관련 법령을 준수하여 분쟁을 해결하고 있습니다.</li>
									</ul>
								</div>
								<!--//-->
							</div>
						</div>
					</div>
				</div>
				<!-- 차량구입 부대비용 -->
				<div class="lineBox mt13">
					<h3 class="formatTit"><strong>차량구입 부대비용</strong></h3>
					<div class="box">
						<div class="gridSet grid2">
							<div class="gridItem">
								<div class="iSet">
									<label>임판발급</label>
									<span class="iLine">
										<span class="selectSet">
											<select>
												<option>선택해주세요</option>
											</select>
										</span>
									</span>
								</div>
								<div class="iSet">
									<label>임판책임보험료</label>
									<div class="iLine unitCase"><input type="number" placeholder="0" /><span class="unit">원</span></div>
								</div>
							</div>
							<div class="gridItem">
								<div class="iSet">
									<label>차량물류배송비</label>
									<div class="iLine unitCase"><input type="number" placeholder="0" /><span class="unit">원</span></div>
								</div>
								<div class="iSet">
									<label>인지대 (기타)</label>
									<div class="iLine unitCase"><input type="number" placeholder="0" /><span class="unit">원</span></div>
								</div>
								<div class="iSet redColor">
									<label>부대비용 합계</label>
									<div class="iLine unitCase"><input type="number" placeholder="0" /><span class="unit">원</span></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- 이전보유차량 -->
				<div class="lineBox mt13">
					<h3 class="formatTit"><strong>이전보유차량</strong></h3>
					<div class="box">
						<div class="gridSet grid2">
							<div class="gridItem">
								<div class="iSet">
									<label>이전보유차량</label>
									<span class="iLine">
										<span class="selectSet">
											<select>
												<option>선택해주세요</option>
											</select>
										</span>
									</span>
								</div>
							</div>
							<div class="gridItem">
								<div class="iSet">
									<label>구입년도</label>
									<div class="iLine unitCase"><input type="number" /><span class="unit">년</span></div>
								</div>
							</div>
						</div>
						<!---->
						<div class="gridSet">
							<div class="gridItem">
								<div class="iSet">
									<label>제조사 / 차량명</label>
									<div class="gridSet grid2"> 
										<div class="gridItem">
											<span class="iLine"><input type="text" placeholder="제조사명을 입력해 주세요" /></span>
										</div>
										<div class="gridItem">
											<span class="iLine"><input type="text" placeholder="차량명을 입력해 주세요" /></span>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!--//-->
					</div>
				</div>
				<!-- 특약사항 -->
				<div class="lineBox mt13">
					<h3 class="formatTit"><strong>특약사항</strong> (0/500글자)</h3>
					<div class="box">
						<div class="iSet">
							<span class="iLine"><textarea class="h100"></textarea></span>
						</div>
					</div>
				</div>
				<!-- 비고 -->
				<div class="lineBox mt13">
					<h3 class="formatTit"><strong>비고</strong></h3>
					<div class="box">
						<div class="gridSet grid2">
							<div class="gridItem">
								<div class="iSet">
									<label>선택항목</label>
									<span class="iLine">
										<span class="selectSet">
											<select>
												<option>선택해주세요</option>
											</select>
										</span>
									</span>
								</div>
							</div>
							<div class="gridItem">
								<div class="checkLine">
									<span class="checkSet">
										<input type="checkbox" id="c_03" checked />
										<label for="c_03">특별사은품</label>
									</span>
									<span class="checkSet">
										<input type="checkbox" id="c_04" checked />
										<label for="c_04">전시차</label>
									</span>
									<span class="checkSet">
										<input type="checkbox" id="c_05" checked />
										<label for="c_05">재고할인</label>
									</span>
								</div>
							</div>
						</div>
						<!---->
						<div class="gridSet grid2">
							<div class="gridItem">
								<div class="iSet">
									<label>출고일자</label>
									<span class="iLine"><input type="date" /></span>
								</div>
							</div>
							<div class="gridItem">
								<div class="iSet">
									<label>DMS 입력</label>
									<span class="iLine"><input type="text" /></span>
								</div>
							</div>
						</div>
						<!---->
						<div class="gridSet grid2">
							<div class="gridItem">
								<div class="iSet">
									<label>PO-NO</label>
									<span class="iLine"><input type="text" /></span>
								</div>
							</div>
							<div class="gridItem">
								<div class="iSet">
									<label>제작증 수령인</label>
									<span class="iLine"><input type="text" /></span>
								</div>
							</div>
						</div>
						<!---->
						<div class="gridSet grid2">
							<div class="gridItem">
								<div class="iSet">
									<label>차대번호</label>
									<span class="iLine"><input type="text" /></span>
								</div>
							</div>
							<div class="gridItem">
								<div class="iSet">
									<label>차량인수확인</label>
									<span class="iLine"><input type="text" /></span>
								</div>
							</div>
						</div>
						<!---->
						<div class="gridSet">
							<div class="gridItem">
								<div class="iSet">
									<label>비고 <span>(0/400글자)</span></label>
									<span class="iLine"><textarea class="h100"></textarea></span>
								</div>
							</div>
						</div>
						<!--//-->
					</div>
				</div>
				<!-- 영수증 -->
				<div class="lineBox mt13">
					<h3 class="formatTit"><strong>영수증</strong></h3>
					<div class="box">
						<div class="gridSet grid2-1">
							<div class="gridItem">
								<div class="iSet">
									<label class="key">영수금액 <sup>필수항목</sup></label>
									<div class="iLine unitCase"><input type="number" placeholder="0" /><span class="unit">원</span></div>
								</div>
								<div class="iSet">
									<label class="key">영수인 <sup>필수항목</sup></label>
									<span class="iLine"><input type="text" placeholder="이름을 입력해주세요" /></span>
								</div>
							</div>
							<div class="gridItem">
								<div class="iSet">
									<label>서명</label>
									<div class="signCase"><div>서명을 입력해 주세요</div></div>
								</div>
							</div>
						</div>
						<!---->
						<div class="txtGuide">본 영수증은 자동차 매매금융으로만 효력이 있으며, 기타 용도 사용은 무효입니다.</div>
					</div>
				</div>
				<!-- 매도인 -->
				<div class="lineBox mt13">
					<h3 class="formatTit"><strong>매도인</strong></h3>
					<div class="box">
						<div class="gridSet grid3-1">
							<div class="gridItem gmkIn">
								<img src="/front/images/sample1.png" alt="" />
							</div>
							<div class="gridItem">
								<div class="iSet">
									<label>판매코드</label>
									<span class="iLine"><input type="text" placeholder="판매코드를 입력해주세요" /></span>
								</div>
								<div class="iSet">
									<label>카 매니져</label>
									<span class="iLine"><input type="text" placeholder="이름을 입력해주세요" /></span>
								</div>
							</div>
							<div class="gridItem">
								<div class="iSet">
									<label>서명</label>
									<div class="signCase"><div>서명을 입력해 주세요</div></div>
								</div>
							</div>
						</div>
						<!---->
						<div class="txtGuide">※ 고객성명 및 주소는 고객(자필)임을 확인함<br/>※ 대리점 대표의 날인이 없는 계약서는 무효입니다.</div>
					</div>
				</div>
				<!--//-->
			</div>
		</article>
	</div>
	<!-- //contract -->
</section>