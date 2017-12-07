<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 계약하기 -->
<div class="popupAutoWrap markServiceAdd p-container">
    <!-- popup header -->
	<div class="popupHeaderAuto">
		<header><h1>계약하기</h1></header>
		<a class="btnClose p-close" onclick="return false;"><em class="blind">닫기</em></a>
	</div>
	<hr/>
    <!-- popup contents -->
	<div class="popupContents">
		<section>
			<div class="autoPop">
				<p class="seasrchBox"><input type="text" placeholder="차량번호로 검색하세요" /><button>검색</button></p>
				<div class="carInfo mt20">
					<ul class="txtListType1">
						<li><strong>차량명</strong>소나타</li>
						<li><strong>차종</strong>대형</li>
						<li><strong>주행거리</strong>64,904KM</li>
						<li><strong>연료</strong>가솔린</li>
					</ul>
				</div>
				<div class="mt20">
					<h3>보험가입여부</h3>
					<div class="backLine">
						<span><label><input type="checkbox" checked />가입</label></span>
						<span><label><input type="checkbox" checked />미가입</label></span>
					</div>
				</div>
				<div class="mt20">
					<h3>비치용품</h3>
					<div class="backLine">
						<span><label><input type="checkbox" checked />스페어타이어</label></span>
						<span><label><input type="checkbox" checked />블랙박스</label></span>
						<span><label><input type="checkbox" checked />네비게이션</label></span>
						<span class="wAuto"><label><input type="checkbox" checked />차량용 공구</label></span>
						<span><label><input type="checkbox" checked />자동차등록증</label></span>
						<span class="wAuto">
							<label><input type="checkbox" checked />스마트키</label>
							<input type="text" />개
						</span>
						<div>
							<span class="wAuto"><label><input type="checkbox" checked />기타물품</label></span>
							<input type="text" />
						</div>
					</div>
				</div>
				<div class="mt20">
					<h3>예약자선택</h3>
					<div class="selectLine">
						<select>
							<option>고영권 -- 010-1234-5678 --</option>
						</select>
					</div>
				</div>
				<div class="btnAreaType mt40">
				          <span><button class="line">취소</button></span>
				          <span><button>신청</button></span>
				      </div>
	           </div>
		</section>
	</div>
</div>
  <!-- //계약하기 -->  