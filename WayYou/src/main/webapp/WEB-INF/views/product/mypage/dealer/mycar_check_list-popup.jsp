<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 체크리스트 편집하기 -->
<div class="popupAutoWrap checkListModify p-container">
	<!-- popup header -->
	<div class="popupHeaderAuto">
    	<header><h1>체크리스트 선택하기</h1></header>
    	<a class="btnClose p-close" onclick="return false;"><em class="blind">닫기</em></a>
	</div>
	<hr/>
	<!-- popup contents -->
	<div class="popupContents">
		<section>
		<div class="ChecklistBox">
			<div class="txtBox">
				<h3>중고차 구입 체크리스트</h3>
				<strong>차량 매물정보<span>자동차 관리법상 차량 광고 시 필수 제시 사항</span></strong>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c1" value="A01"/><label for="chk_c1">자동차 관리법상 차량 광고 시 필수 제시 사항</label></p>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c2" value="A02"/><label for="chk_c2">성능&#44; 상태 점검기록부&#40;자동차 관리법 별지 제 82호 서식&#41;</label></p>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c3" value="A03"/><label for="chk_c3">제시 신고 번호</label></p>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c4" value="A04"/><label for="chk_c4">매매업자&#44; 매매사업조합의 상호&#44; 주소 및 전화번호에 관한 사항</label></p>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c5" value="A05"/><label for="chk_c5">자동차 등록번호&#44; 주요 제원 및 옵션에 관한 사항</label></p>
			
				<strong>허위매물확인<span>실제로 존재하지 않는 매물 &frasl; 광고 목적 낮은 금액 제시</span></strong>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c11" value="B01" /><label for="chk_c11">차량시세 &#58; BNK 시세 정보를 참조하여 시세 범위에서 벗어나는지 확인</label></p>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c12" value="B02" /><label for="chk_c12">가격이 변동되는지 확인</label></p>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c13" value="B03" /><label for="chk_c13">좋은 조건의 차량임에도 오랜 기간 광고하는 경우</label></p>
			
				<strong>성능점검기록부 확인사항</strong>
				<em>&#91; 자동차 주요 일반사항, 사고 및 침수 유무 &#93;</em>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c21" value="C01" /><label for="chk_c21">침수유무 확인</label></p>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c22" value="C02" /><label for="chk_c22">주행거리 및 계기 상태 &#58; 작동 불량 표시 여부</label></p>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c23" value="C03" /><label for="chk_c23">검사 유효기간 &#58; 입력 날짜로부터 30일 이내</label></p>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c24" value="C04" /><label for="chk_c24">동일성 확인&#40;차대번호 표기&#41; &#58; 양호가 아닐 경우&#44; 별도</label></p>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c25" value="C05" /><label for="chk_c25">불법 구조변경 &#58; 변경이 있을 경우&#44; 해당 부품 제거 혹은 정품 변경 요청</label></p>
			
				<em>&#91; 주요 장치의 상태 &#93;</em>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c26" value="D01" /><label for="chk_c26">3년 경과 차량은 오일 교환주기 또는 일부 누유 발생 가능</label></p>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c27" value="D02" /><label for="chk_c27">실린더 헤드&#44; 블록의 오일 누유&#44; 냉각수 누수는 미세누수라 하더라도 즉시 수리 요구하는 경우가 많음</label></p>
			
				<em>&#91; 외판과 주요 골격 상태 &#93;</em>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c28" value="E01" /><label for="chk_c28">외판 교환 유무 확인</label></p>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c29" value="E02" /><label for="chk_c29">외판 교환이 일부 있는 경우&#44; 감가요인으로 파악</label></p>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c30" value="E03" /><label for="chk_c30">주요 골격의 손상 유무 확인&#40;휠하우스인사이트패널&#44; 필러패널&#41;</label></p>
				
				<strong>차량매물정보</strong>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c31" value="F01" /><label for="chk_c31">핸들 샤프트&#40;핸들 뒷편 부분&#41; 부식여부 확인</label></p>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c32" value="F02" /><label for="chk_c32">안전벨트를 끝까지 뽑아서 확인하여 진흙이나 물이 마르면서 생기는 흰색 경계선이 있는지 확인</label></p>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c33" value="F03" /><label for="chk_c33">운전석&#44; 뒷좌석 시가잭 부식 여부</label></p>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c34" value="F04" /><label for="chk_c34">엔진 룸 내 ECU 및 전선 교체 흔적 확인&#40;연식 대비 일체 부품 교체 여부 확인&#41;</label></p>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c35" value="F05" /><label for="chk_c35">차량 시트 밑 부식 여부 확인</label></p>
				
				<strong>보험처리이력 확인</strong>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c41" value="G01" /><label for="chk_c41">자동차 일반 사항 &#58; 제작사&#44; 차명&#44; 연식&#44; 배기량&#44; 최초 보험가입일 매물 정보와 확인</label></p>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c42" value="G02" /><label for="chk_c42">용도 이력 &#58; 대여용&#40;렌터카&#41;&#44; 영업용&#44; 관용 여부 확인</label></p>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c43" value="G03" /><label for="chk_c43">소유자 변경 이력 &#58; 소유자 변경 횟수 확인&#40;자주 바뀔 경우&#44; 차량 가치 저하&#41;</label></p>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c44" value="G04" /><label for="chk_c44">차량번호 변경 이력 &#58; 변경 이력 사유 확인</label></p>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c45" value="G05" /><label for="chk_c45">특수보험사고 정보 &#58; 침수&#44; 도난&#44; 전손처리 정보 확인</label></p>
				<p><input type="checkbox" class="big" name="items[]" id="chk_c46" value="G06" /><label for="chk_c46">보험사고 이력 &#58; 내차처리&#44; 타차처리&#44; 타인 재물 가해정보 확인</label></p>         
			</div>
			<div class="btnSet">
				<span class="tal dib">
					<a href="" class="red plr15" id="btnSend" onclick="return false;" >체크리스트 보내기</a>
					<div class="btn-popup-auto" data-pop-opts='{"target": ".checkListSend","display":"false"}'></div>
				</span>
			</div>
		</div>
		</section>
	</div>
</div>
<!-- //체크리스트 편집하기 --> 

<!-- 체크리스트 전송완료 -->
<div class="popupAutoWrap checkListOk p-container">
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
<!-- //체크리스트 전송완료 -->   

<!-- 체크리스트 보내기 -->
<div class="popupAutoWrap checkListSend p-container w670">
   <!-- popup header -->
	<div class="popupHeaderAuto">
    	<header><h1>체크리스트 보내기</h1></header>
    	<a class="btnClose p-close" onclick="return false;"><em class="blind">닫기</em></a>
	</div>
	<hr/>
	<!-- popup contents -->
	<div class="popupContents">
    	<section>
        	<div class="autoPop">
            	<p class="seasrchBox">
            		<input type="text" id="searchTxt"/><button id="checkBtnSearch"></button>
            	</p>
            	<div class="infoList" id="pushList">
            	</div>
            	<div class="btnAreaType">
                	<span><button class="line p-close">취소</button></span>
                	<!-- <span><button class="btn-popup-auto" onclick="return false;" data-pop-opts="{&quot;target&quot;: &quot;.checkListOk&quot;}">전송</button></span> -->
 					<span>
 						<button class="" id="checkBtnSend"  onclick="return false;" >전송</button>
 						<div class="btn-popup-auto" data-pop-opts='{"target": ".checkListOk","display":"false"}'></div>
 					</span>
 					
                </div>
			</div>
        </section>
    </div>
</div>
<!-- 체크리스트 상세보기 -->
<div class="popupAutoWrap checkListDetail p-container">
	<!-- popup header -->
	<div class="popupHeaderAuto">
    	<header><h1>체크리스트</h1></header>
    	<a class="btnClose p-close" onclick="return false;"><em class="blind">닫기</em></a>
	</div>
	<hr/>
	<!-- popup contents -->
	<div class="popupContents">
		<section>
		<div class="ChecklistBox">
			<div class="txtBox">
				<h3>중고차 구입 체크리스트</h3>
				<div class="checkDiv">
					<strong>차량 매물정보<span>자동차 관리법상 차량 광고 시 필수 제시 사항</span></strong>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="A01" value=""/><label for="chk_c1">자동차 관리법상 차량 광고 시 필수 제시 사항</label></p>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="A02" value=""/><label for="chk_c2">성능&#44; 상태 점검기록부&#40;자동차 관리법 별지 제 82호 서식&#41;</label></p>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="A03" value=""/><label for="chk_c3">제시 신고 번호</label></p>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="A04" value=""/><label for="chk_c4">매매업자&#44; 매매사업조합의 상호&#44; 주소 및 전화번호에 관한 사항</label></p>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="A05" value=""/><label for="chk_c5">자동차 등록번호&#44; 주요 제원 및 옵션에 관한 사항</label></p>
				</div>
				<div class="checkDiv">
					<strong>허위매물확인<span>실제로 존재하지 않는 매물 &frasl; 광고 목적 낮은 금액 제시</span></strong>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="B01" value="" /><label for="chk_c11">차량시세 &#58; BNK 시세 정보를 참조하여 시세 범위에서 벗어나는지 확인</label></p>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="B02" value="" /><label for="chk_c12">가격이 변동되는지 확인</label></p>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="B03" value="" /><label for="chk_c13">좋은 조건의 차량임에도 오랜 기간 광고하는 경우</label></p>
				</div>
				<div class="checkDiv">
					<strong>성능점검기록부 확인사항</strong>
					<em>&#91; 자동차 주요 일반사항, 사고 및 침수 유무 &#93;</em>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="C01" value="" /><label for="chk_c21">침수유무 확인</label></p>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="C02" value="" /><label for="chk_c22">주행거리 및 계기 상태 &#58; 작동 불량 표시 여부</label></p>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="C03" value="" /><label for="chk_c23">검사 유효기간 &#58; 입력 날짜로부터 30일 이내</label></p>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="C04" value="" /><label for="chk_c24">동일성 확인&#40;차대번호 표기&#41; &#58; 양호가 아닐 경우&#44; 별도</label></p>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="C05" value="" /><label for="chk_c25">불법 구조변경 &#58; 변경이 있을 경우&#44; 해당 부품 제거 혹은 정품 변경 요청</label></p>
				</div>
				<div class="checkDiv">
					<em>&#91; 주요 장치의 상태 &#93;</em>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="D01" value="" /><label for="chk_c26">3년 경과 차량은 오일 교환주기 또는 일부 누유 발생 가능</label></p>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="D02" value="" /><label for="chk_c27">실린더 헤드&#44; 블록의 오일 누유&#44; 냉각수 누수는 미세누수라 하더라도 즉시 수리 요구하는 경우가 많음</label></p>
				</div>
				<div class="checkDiv">
					<em>&#91; 외판과 주요 골격 상태 &#93;</em>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="E01" value="" /><label for="chk_c28">외판 교환 유무 확인</label></p>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="E02" value="" /><label for="chk_c29">외판 교환이 일부 있는 경우&#44; 감가요인으로 파악</label></p>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="E03" value="" /><label for="chk_c30">주요 골격의 손상 유무 확인&#40;휠하우스인사이트패널&#44; 필러패널&#41;</label></p>
				</div>
				<div class="checkDiv">
					<strong>차량매물정보</strong>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="F01" value="" /><label for="chk_c31">핸들 샤프트&#40;핸들 뒷편 부분&#41; 부식여부 확인</label></p>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="F02" value="" /><label for="chk_c32">안전벨트를 끝까지 뽑아서 확인하여 진흙이나 물이 마르면서 생기는 흰색 경계선이 있는지 확인</label></p>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="F03" value="" /><label for="chk_c33">운전석&#44; 뒷좌석 시가잭 부식 여부</label></p>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="F04" value="" /><label for="chk_c34">엔진 룸 내 ECU 및 전선 교체 흔적 확인&#40;연식 대비 일체 부품 교체 여부 확인&#41;</label></p>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="F05" value="" /><label for="chk_c35">차량 시트 밑 부식 여부 확인</label></p>
				</div>
				<div class="checkDiv">
					<strong>보험처리이력 확인</strong>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="G01" value="" /><label for="chk_c41">자동차 일반 사항 &#58; 제작사&#44; 차명&#44; 연식&#44; 배기량&#44; 최초 보험가입일 매물 정보와 확인</label></p>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="G02" value="" /><label for="chk_c42">용도 이력 &#58; 대여용&#40;렌터카&#41;&#44; 영업용&#44; 관용 여부 확인</label></p>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="G03" value="" /><label for="chk_c43">소유자 변경 이력 &#58; 소유자 변경 횟수 확인&#40;자주 바뀔 경우&#44; 차량 가치 저하&#41;</label></p>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="G04" value="" /><label for="chk_c44">차량번호 변경 이력 &#58; 변경 이력 사유 확인</label></p>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="G05" value="" /><label for="chk_c45">특수보험사고 정보 &#58; 침수&#44; 도난&#44; 전손처리 정보 확인</label></p>
					<p><input type="checkbox" onclick="return false;" class="big" name="items[]" id="G06" value="" /><label for="chk_c46">보험사고 이력 &#58; 내차처리&#44; 타차처리&#44; 타인 재물 가해정보 확인</label></p>
				</div>         
			</div>
			<div class="btnSet">
				<span class="tal dib">
					<a class="btnClose p-close" onclick="return false;"><em class="blind">닫기</em></a>
				</span>
			</div>
		</div>
		</section>
	</div>
</div>
<!-- //체크리스트 상세보기 --> 