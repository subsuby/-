<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script>
console.log(${ct:toJson(list)});
$(function(){
	$('.dealerCardList li:nth-child(even)').addClass('right'); // 정렬 추가 2017-08-22 by mj-cho
});
</script>
<div class="innerLayout bgGrayCase">
	<div class="dataSet">
		<h3 class="line">명함관리</h3>
		<ul class="dealerCardList">
			<c:forEach var="card" items="${list}">
			<li>
				<div class="cardWrap">
					<dl class="cardArea">
						<dt class="logo">
							<span><em class="blind">bnk</em></span>
							<button type="button" onclick="businesscard_delete('${card.nameCardSeq}')">삭제</button>
						</dt>
						<dd>
							<div class="profileImage">
								<img src="<c:url value="/product/images/thumbnail/profileCorver2.png"/>" alt="" class="corver">
								<div class="imgBack"><span><img src="<c:url value="${card.dealerProfileImgPath}"/>" onerror="this.src='<c:url value="/product/images/thumbnail/profile1.png"/>'" alt=""></span></div>
							</div>
							<span class="levelArea">
								<i class="levelBadge level${empty card.gradeDealer ? '1' : card.gradeDealer }"></i>
								<strong onclick='fn_interestDealer(this, "${card.userId}")'>${card.userName}</strong>딜러
							</span>
							<i class="btn-popup-auto namePop" data-pop-opts='{"target": ".popDealerView","display":"false"}'></i>
							<span class="text"><em>${card.marketInfo.danjifullname}</em><em>${card.marketInfo.danjiaddr}</em></span>
							<span class="num">${empty card.dealerVirtualNum ? card.phoneNumMask : card.dealerVirtualNum }</span>
							<span class="memo">${card.dealerProfileDesc}</span>
						</dd>
					</dl>
				</div>
			</li>
			</c:forEach>
			<c:if test="${fn:length(list) == 0}">
				<li class="noneLine">수신된 명함이 없습니다.</li><!-- 2017-09-01 by mj-cho -->
			</c:if>
		</ul>
		<c:if test="${fn:length(list) != 0}">
			<div class="pagingBtn">
				<paginatorAjax:print fncName="businesscard_list" curPage="${curPage}" totPages="${totPages}"/>
			</div>
		</c:if>
	</div>
</div>