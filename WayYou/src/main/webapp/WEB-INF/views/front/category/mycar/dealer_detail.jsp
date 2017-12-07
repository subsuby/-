<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
<div class="dealerDetail">
	<!---->
	<div class="dealerArea">
		<span class="heartSet"><input type="checkbox" id="h_2" /><label for="h_2"><!--찜하기--></label></span>
		<span class="thumProfile">
			<img src="../../images/thumbnail/profile2.png" alt="" />
		</span>
		<div>
			<span class="levelBadge level3"><span><strong>김영한</strong> 딜러</span></span><br/>
			<p>“정직과 신용으로 최선을 다하겠습니다.”</p>
		</div>
	</div>
	<!---->
	<div class="btn-toggle-wrapper">
		<div class="btnTab case1 grid3">
			<a href="" onclick="return false;" class="btn-toggle-switch on"><span>딜러정보</span></a>
			<a href="" onclick="return false;" class="btn-toggle-switch" ><span>거래평가</span></a>
			<a href="" onclick="return false;" class="btn-toggle-switch" ><span>판매차량<em>13</em></span></a>
		</div>
		<div class="btn-toggle-switch-target">
			<div class="infoArea">
				<dl>
					<dt>연락처</dt>
					<dd>0508-4568-4567</dd>
				</dl>
				<dl>
					<dt>회원가입일</dt>
					<dd>2015년 11월 01일</dd>
				</dl>
				<dl>
					<dt>딜러매물</dt>
					<dd>판매중 13 대 | 판매완료 62대</dd>
				</dl>
				<dl>
					<dt>종사자번호</dt>
					<dd>86-120-302050</dd>
				</dl>
				<dl>
					<dt>지역/상사</dt>
					<dd>서울특별시 강서구 등촌동 서울자동차매매단지</dd>
				</dl>
			</div>
			<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=XxBcp1zLYX1c5n1h8OOS"></script> <!-- Key 값 변경 필요 -->
			<div id="map" style="width:100%;height:178px;"></div>
			<script>
			var map = new naver.maps.Map('map', {
				center: new naver.maps.LatLng(37.5647481,126.8471523),
				zoom: 10
			});
			
			var marker = new naver.maps.Marker({
				position: new naver.maps.LatLng(37.5647481,126.8471523),
				map: map
			});
			</script>
		</div>
		<div class="btn-toggle-switch-target" style="display:none;">
			<div class="ratingArea">
				<div class="dealerRating">
					<span>종합 거래평가</span><div class="rating" data-rateit-readonly="true" data-rateit-value="4"></div><strong>4.3</strong>
				</div>
				<div class="btnSet">
					<span><a href="" onclick="return false;" class="redLine rankWrite btn-popup-full" data-pop-opts='{"target": ".ratingAdd"}'><em><strong>평가작성</strong>하기</em></a></span>
				</div>
				<!---->
				<div class="dealerAfter">
					<div class="btn-accordion-wrapper" data-toggle-on="true">
						<ul>
							<li class="btn-accordion-switch">
								<div class="afterTit">
									<div class="btn-accordion-switch-item">
										<strong>상담</strong>
										<div>좋은 거래 감사합니다. 다음번에도 부탁드립니다. 좋은 거래 감사합니다. 다음번에도 부탁드립니다.</div>
										<span>2016-01-02</span>
									</div>
								</div>
								<div class="afterDetail">
									좋은 거래 감사합니다. 다음번에도 부탁드립니다. 좋은 거래 감사합니다. 다음번에도 부탁드립니다.
								</div>
							</li>
							<li class="btn-accordion-switch">
								<div class="afterTit">
									<div class="btn-accordion-switch-item">
										<strong>거래</strong>
										<div>친절하고 확실하게 정리해서 알려주셨어요^^ 친절하고 확실하게 정리해서 알려주셨어요^^</div>
										<span>2016-01-02</span>
									</div>
								</div>
								<div class="afterDetail">
									친절하고 확실하게 정리해서 알려주셨어요^^ 친절하고 확실하게 정리해서 알려주셨어요^^
								</div>
							</li>
							<li class="btn-accordion-switch">
								<div class="afterTit">
									<div class="btn-accordion-switch-item">
										<strong>거래</strong>
										<div>만족스러운 거래!</div>
										<span>2016-01-02</span>
									</div>
								</div>
								<div class="afterDetail">
									만족스러운 거래! 만족스러운 거래! 좋은 거래 감사합니다. 다음번에도 부탁드립니다. 좋은 거래 감사합니다. 다음번에도 부탁드립니다.
								</div>
							</li>
							<li class="btn-accordion-switch">
								<div class="afterTit">
									<div class="btn-accordion-switch-item">
										<strong>거래</strong>
										<div>다음번에도 부탁드립니다^^ </div>
										<span>2016-01-02</span>
									</div>
								</div>
								<div class="afterDetail">
									다음번에도 부탁드립니다^^ 다음번에도 부탁드립니다. 좋은 거래 감사합니다. 다음번에도 부탁드립니다.
								</div>
							</li>
							<li class="btn-accordion-switch">
								<div class="afterTit">
									<div class="btn-accordion-switch-item">
										<strong>거래</strong>
										<div>정말 친절하고 꼼꼼하게 챙겨주시네요</div>
										<span>2016-01-02</span>
									</div>
								</div>
								<div class="afterDetail">
									정말 친절하고 꼼꼼하게 챙겨주시네요 좋은 거래 감사합니다. 다음번에도 부탁드립니다. 좋은 거래 감사합니다. 다음번에도 부탁드립니다.
								</div>
							</li>
							<li class="btn-accordion-switch">
								<div class="afterTit">
									<div class="btn-accordion-switch-item">
										<strong>거래</strong>
										<div>만족스러운 거래!</div>
										<span>2016-01-02</span>
									</div>
								</div>
								<div class="afterDetail">
									만족스러운 거래! 좋은 거래 감사합니다. 다음번에도 부탁드립니다. 좋은 거래 감사합니다. 다음번에도 부탁드립니다.
								</div>
							</li>
							<li class="btn-accordion-switch">
								<div class="afterTit">
									<div class="btn-accordion-switch-item">
										<strong>거래</strong>
										<div>다음번에도 부탁드립니다^^ 다음번에도 부탁드립니다^^</div>
										<span>2016-01-02</span>
									</div>
								</div>
								<div class="afterDetail">
									다음번에도 부탁드립니다^^ 다음번에도 부탁드립니다^^ 다음번에도 부탁드립니다. 좋은 거래 감사합니다. 다음번에도 부탁드립니다.
								</div>
							</li>
						</ul>
					</div>
					<!---->
					<div class="btnMore">
						<button><strong>거래평</strong> 더보기 +</button>
					</div>
				</div>
			</div>
		</div>
		<div class="btn-toggle-switch-target" style="display:none;">
			<ul class="listType1 grid2">
				<!-- Loop -->
				<li>
					<a href="buy_detail.html">
						<div class="thumBack">
							<span class="markSet mark1">인증</span>
							<div>
								<img src="../../images/thumbnail/shift_car_001.jpg" alt="" />
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
					<span class="heartSet"><input type="checkbox" id="h_1" checked /><label for="h_1"><!--찜하기--></label></span>
				</li>
				<!-- //Loop -->
				<li>
					<a href="buy_detail.html">
						<div class="thumBack">
							<span class="markSet mark1">인증</span>
							<div>
								<img src="../../images/thumbnail/shift_car_002.jpg" alt="" />
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
					<span class="heartSet"><input type="checkbox" id="h_2" /><label for="h_2"><!--찜하기--></label></span>
				</li>
				<li>
					<a href="buy_detail.html">
						<div class="thumBack">
							<span class="markSet mark1">인증</span>
							<div>
								<img src="../../images/thumbnail/shift_car_003.jpg" alt="" />
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
					<span class="heartSet"><input type="checkbox" id="h_3" /><label for="h_3"><!--찜하기--></label></span>
				</li>
				<li>
					<a href="buy_detail.html">
						<div class="thumBack">
							<span class="markSet mark1">인증</span>
							<div>
								<img src="../../images/thumbnail/shift_car_004.jpg" alt="" />
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
					<span class="heartSet"><input type="checkbox" id="h_4" /><label for="h_4"><!--찜하기--></label></span>
				</li>
				<li>
					<a href="buy_detail.html">
						<div class="thumBack">
							<span class="markSet mark1">인증</span>
							<div>
								<img src="../../images/thumbnail/shift_car_005.jpg" alt="" />
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
					<span class="heartSet"><input type="checkbox" id="h_5" /><label for="h_5"><!--찜하기--></label></span>
				</li>
			</ul>
		</div>
	</div>
</div>
</section>