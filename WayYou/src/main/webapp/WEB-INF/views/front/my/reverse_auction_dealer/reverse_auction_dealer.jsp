<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
	<!-- 2017-06-18 -->
	<div class="reAutoNoList">
		<div>
			<strong>등록된 매물정보가 없습니다.</strong>
			<button class="btn-popup-full" onclick="return false;" data-pop-opts='{"target": ".likeRecord"}'>등록하기</button>
		</div>
	</div>
	<!-- //2017-06-18 -->
	<div class="reAutoView" style="display:none;"><!-- 2017-06-18 -->
		<dl class="reAutoList">
			<dt><span>매물등록정보</span> <button id="deleteSample">정보삭제</button></dt>
			<dd class="reAutoInfo">
				<ul>
					<li>제조사<span>기아</span></li>
					<li>모델<span>올 뉴 소울</span></li>
					<li>세부모델<span>1.6 GDI 프레스티지</span></li>
					<li>주행거리<span>20,000 km</span></li>
					<li>연식<span>연식</span></li>
					<li>색상<span>레드</span></li>
				</ul>
			</dd>
		</dl>
		<dl class="reAutoList">
			<dt><span>추천차량리스트</span></dt>
			<dd>
				<ul class="listType1 grid2">
					<!-- Loop -->
					<li>
						<a href="">
							<div class="thumBack">
								<span class="markSet mark1">인증</span>
								<div>
									<img src="/front/images/thumbnail/shift_car_001.jpg" alt="" />
								</div>
							</div>
							<div class="prBack">
								<div class="productInfo">
									<div><strong>기아</strong><span>그랜드</span><span>그랜드카니발 그랜드카니발</span></div>
									<p><span>2016</span><em>서울</em><em>30k km</em></p>
									<strong class="goodsPrice"><strong>13,500</strong>원</strong>
								</div>
								<span class="markGroup">
									<span class="markSet mark2">환불</span>
									<span class="markSet mark3">헛걸음</span>
									<span class="markSet mark4">1년보증</span>
								</span>
							</div>
						</a>
						<span class="heartSet"><input type="checkbox" id="h_1" checked /><label for="h_1"><!--찜하기--></label></span>
					</li>
					<!-- //Loop -->
					<li>
						<a href="">
							<div class="thumBack">
								<span class="markSet mark1">인증</span>
								<div>
									<img src="../../images/thumbnail/shift_car_002.jpg" alt="" />
								</div>
							</div>
							<div class="prBack">
								<div class="productInfo">
									<div><strong>기아</strong><span>그랜드 그랜드</span><span>그랜드카니발</span></div>
									<p><span>2016</span><em>서울</em><em>30k km</em></p>
									<strong class="goodsPrice"><strong>13,500</strong>원</strong>
								</div>
								<span class="markGroup">
									<span class="markSet mark2">환불</span>
									<span class="markSet mark3">헛걸음</span>
									<span class="markSet mark4">1년보증</span>
								</span>
							</div>
						</a>
						<span class="heartSet"><input type="checkbox" id="h_2" /><label for="h_2"><!--찜하기--></label></span>
					</li>
				</ul>									
			</dd>
		</dl>
	</div>
</section>