<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 신청한 서비스 상세보기 -->
<div class="popupAutoWrap popmarkServiceDetail p-container">
    <!-- popup header -->
    <div class="popupHeaderAuto">
        <header><h1>환불보장서비스 확인서</h1></header> <!-- 보장종류에 따라 이름 변경 -->
        <a class="btnClose p-close" onclick="return false;"><em class="blind">닫기</em></a>
    </div>
    <hr/>
    <!-- popup contents -->
    <div class="popupContents">
        <section>
			<div class="costWrap costC2">
                <!---->
				<div class="myWrite">
					<div class="writeRow type4">
						<strong>구매자정보</strong>
					</div>
					<div class="writeRow">
                        <strong><label>성명</label></strong>
						<span><em>김오토</em></span>
                        <strong><label>생년월일</label></strong>
						<span><em>1990.11.01</em></span>
					</div>
					<div class="writeRow">
                        <strong><label>전화번호</label></strong>
						<span><em>010-1234-5678</em></span>
                        <strong><label>구매형태</label></strong>
						<span><em></em></span>
					</div>
					<div class="writeRow">
                        <strong><label>환불계좌은행</label></strong>
						<span>
							<select>
								<option>선택</option>
							</select>
						</span>
                        <strong><label>할불계좌</label></strong>
						<span>
							<input type="text" placeholder="입력하세요." />
						</span>
					</div>
					<div class="writeRow type1 last">
                        <strong><label>구매자 주소</label></strong>
						<span><em>자동기입</em></span>
					</div>
					<!---->
					<div class="writeRow type4">
						<strong>판매자정보</strong>
					</div>
					<div class="writeRow">
                        <strong><label>단지명</label></strong>
						<span><em>서울오토갤러리</em></span>
                        <strong><label>상사명</label></strong>
						<span><em>(주)에이스모터스</em></span>
					</div>
					<div class="writeRow">
                        <strong><label>딜러명</label></strong>
						<span><em>고영권</em></span>
                        <strong><label>전화번호</label></strong>
						<span><em>010-1111-5555</em></span>
					</div>
					<div class="writeRow type1 last">
                        <strong><label>상사주소</label></strong>
						<span><em>서울특별시 강서구 자양동 서울오토갤러리 2F</em></span>
					</div>
					<!---->
					<div class="writeRow type4">
						<strong>구매차량정보</strong>
					</div>
					<div class="writeRow">
                        <strong><label>차량번호</label></strong>
						<span><em>19서7667</em></span>
                        <strong><label>차량명</label></strong>
						<span><em>2016 A4 30 TDI Dynimic</em></span>
					</div>
					<div class="writeRow">
                        <strong><label>제조사</label></strong>
						<span><em>아우디</em></span>
                        <strong><label>주행거리</label></strong>
						<span><em>33,245 km</em></span>
					</div>
					<div class="writeRow">
                        <strong><label>연료상태</label></strong>
						<span><em>디젤</em></span>
                        <strong><label>보험가입여부</label></strong>
						<span class="markCase1">
							<label><input type="checkbox" checked />가입</label>
							<label><input type="checkbox" checked />미가입</label>
						</span>
					</div>
					<div class="writeRow type1 last">
                        <strong><label>비치용품</label></strong>
						<span class="markCase2">
							<label><input type="checkbox" checked />스페어타이어</label>
							<label><input type="checkbox" checked />블랙박스</label>
							<label><input type="checkbox" checked />네비게이션</label>
							<label class="wAuto"><input type="checkbox" checked />차량용 공구</label>
							<label><input type="checkbox" checked />자동차등록증</label>
							<span>
								<label class="wAuto"><input type="checkbox" checked />스마트키</label>
								<input type="text" /> 개
							</span>
							<div>
								<label class="wAuto"><input type="checkbox" checked />기타물품</label>
								<input type="text" />
							</div>
						</span>
					</div>
				</div>
                <!---->
				<div class="btnAreaType">
					<span><button class="p-close" onclick="return false;">확인</button></span>
				</div>
			</div>
        </section>
    </div>
</div>
<!-- //신청한 서비스 상세보기 --> 
