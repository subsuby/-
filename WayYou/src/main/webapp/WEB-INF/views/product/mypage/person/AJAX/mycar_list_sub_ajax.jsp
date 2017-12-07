<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 견적대기 -->
<c:if test="${ct:equals(myCarPrice.est_state,'1')}">
<h4>견적루트</h4>
<div class="root rootNone first">
	<p class="noInfo info1">방문견적<em>전문가에게 모든 판매를<br>맡겨보세요</em></p>
	<div class="btnSet btnCenter">
		<span><a class="red btn-popup-auto"  onclick="return false;" data-pop-opts='{"target": ".visitApp"}'>신청하기</a></span>
	</div>
</div>
<div class="root rootNone">
	<p class="noInfo info2">딜러견적<em>전문가에게 모든 판매를<br>맡겨보세요</em></p>
	<div class="btnSet btnCenter">
		<span><a class="red" onclick="mycar_list_estimate_service('dealer', '${myCar.mycarSeq}')">신청하기</a></span>
	</div>
</div>
</c:if>
<!--견적신청-->
<c:if test="${ct:equals(myCarPrice.est_state,'2')}">
	<c:if test="${ct:equals(myCar.estReqType,'3')}">
		<h4>견적루트</h4>
		<div class="root">
			<p class="noInfo rootIng rootIng1">딜러견적 요청중<em>고객님의 차량을 검토하고 있습니다.<br>현재 담당 전문가를 배정중이니, 잠시만 기다려 주십시오.</em></p>
		</div>
		<div class="btnSet mt20">
			<span><a class="redLine" onclick="mycar_list_estimate_service('cancel', '${myCar.mycarSeq}')">견적취소</a></span>
		</div>
	</c:if>
	<c:if test="${not ct:equals(myCar.estReqType,'3')}">
		<h4>견적루트</h4>
		<div class="root">
			<p class="noInfo rootIng rootIng1">방문견적 요청중<em>고객님의 차량을 검토하고 있습니다.<br>현재 담당 전문가를 배정중이니, 잠시만 기다려 주십시오.</em></p>
		</div>
		<div class="btnSet mt20">
			<span><a class="redLine" onclick="mycar_list_estimate_service('cancel', '${myCar.mycarSeq}')">견적취소</a></span>
		</div>
	</c:if>
</c:if>

<!--견적완료 -->
<c:if test="${ct:equals(myCarPrice.est_state,'3')}">
	<c:if test="${not ct:equals(myCar.estReqType,'3')}">
			<h4>견적루트</h4>
			<div class="root">
				<p class="noInfo rootIng rootIng2">방문견적 완료<em>고객님 차량의 견적이 완료되었습니다.<br>견적이 마음에 들지 않는다면 견적 다시 받기를 신청해주세요.</em></p>
			</div>
			<div class="btnSet mt20">
				<span><a class="redLine" onclick="mycar_list_estimate_service('cancel', '${myCar.mycarSeq}')">견적취소</a></span>
			</div>
	</c:if>
	<c:if test="${ct:equals(myCar.estReqType,'3')}">
		<h4>견적루트 <span>딜러견적리스트</span></h4>
		<div class="myList">
			<table summary="목록">
				<caption>목록</caption>
				<colgroup>
					<col width="200">
					<col width="140">
					<col width="175">
					<col width="*">
					<col width="180">
					<col width="137">
				</colgroup>
				<thead>
					<tr>
						<th>딜러이름</th>
						<th>견적가격</th>
						<th>상사명</th>
						<th>상사주소</th>
						<th>연락처</th>
						<th>비고</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${not empty myCar.estimateArr}">
					<c:forEach var="estimate" items="${myCar.estimateArr}">
					<tr>
						<td>${ct:nameAsterisk(estimate.estDealerNm)}</td>
						<td>${estimate.estAmt}만원</td>
						<td>${estimate.estShopNm}</td>
						<td>${estimate.estShopAddr}</td>
						<td>${estimate.estDealerTel}</td>
						<td>${estimate.estRemark}</td>
					</tr>
					</c:forEach>
				</c:if>
				</tbody>
			</table>
		</div>
		<div class="btnSet mt20">
			<span><a class="red" onclick="mycar_list_estimate_service('retry', '${myCar.mycarSeq}')"">견적다시받기</a></span>
		</div>
	</c:if>
</c:if>
<!--견적만료 -->
<c:if test="${ct:equals(myCarPrice.est_state,'4')}">
	<h4>견적루트</h4>
	<div class="root">
		<p class="noInfo rootIng rootIng1">딜러견적 요청 만료<em>요청 기간동안 해당 매물의 견적을 작성한 딜러가 없습니다.<br>견적이 필요한 경우 견적 다시 받기를 신청해주세요.</em></p>
	</div>
	<div class="btnSet mt20">
		<span><a class="red" onclick="mycar_list_estimate_service('retry', '${myCar.mycarSeq}')"">견적다시받기</a></span>
	</div>
</c:if>
<jsp:include page="../popup/address_pop.jsp"></jsp:include>				<!-- 주소팝업 -->
<jsp:include page="../popup/estimate_visit_pop.jsp"></jsp:include>		<!-- 방문견적 팝업 -->
<jsp:include page="../popup/danji_pop.jsp"         ></jsp:include>
<jsp:include page="../popup/shop_pop.jsp"          ></jsp:include>

