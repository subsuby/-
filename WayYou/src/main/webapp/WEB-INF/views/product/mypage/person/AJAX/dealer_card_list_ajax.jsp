<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script>
</script>
<div class="innerLayout">
	<div class="dataSet">
		<h3 class="line">명함관리</h3>
		<ul class="dealerCardList">
			<li>
				<div class="cardWrap">
					<dl class="cardArea">
						<dt class="logo">
							<span><em class="blind">bnk</em></span>
							<button>삭제</button>
						</dt>
						<dd>
							<div class="profileImage">
								<img src="../../images/thumbnail/profileCorver2.png" alt="" class="corver">
								<div class="imgBack"><span><img src="../../images/thumbnail/profile1_2.png" alt=""></span></div>
							</div>
							<span class="levelArea"><i class="levelBadge level2"></i><strong>김무영</strong>딜러</span>
							<span class="text"><em>서울 자동차 매매단지</em><em>서울 강서구 등촌동 201-1</em></span>
							<span class="num">0508-1234-5678</span>
							<span class="memo">"정직과 신용으로 최선을다하겠습니다."</span>
						</dd>
					</dl>
				</div>
			</li>
			<li class="right">
				<div class="cardWrap">
					<dl class="cardArea">
						<dt class="logo">
							<span><em class="blind">bnk</em></span>
							<button>삭제</button>
						</dt>
						<dd>
							<div class="profileImage">
								<img src="../../images/thumbnail/profileCorver2.png" alt="" class="corver">
								<div class="imgBack"><span><img src="../../images/thumbnail/profile1_2.png" alt=""></span></div>
							</div>
							<span class="levelArea"><i class="levelBadge level2"></i><strong>김무영</strong>딜러</span>
							<span class="text"><em>서울 자동차 매매단지</em><em>서울 강서구 등촌동 201-1</em></span>
							<span class="num">0508-1234-5678</span>
							<span class="memo">"정직과 신용으로 최선을다하겠습니다."</span>
						</dd>
					</dl>
				</div>										
			</li>
		</ul>
<%-- 		<c:if test="${fn:length(costList) != 0}"> --%>
<!-- 			<div class="pagingBtn"> -->
<%-- 				<paginatorAjax:print fncName="cost_list" curPage="${curPage}" totPages="${totPages}"/> --%>
<!-- 			</div> -->
<%-- 		</c:if> --%>
	</div>
</div>