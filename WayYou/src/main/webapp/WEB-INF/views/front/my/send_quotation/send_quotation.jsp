<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
	<div class="busiCardLayout">
		<div class="searchBar">
			<div class="searchArea">
				<input type="text" id="carPlateNum" placeholder="차량번호를 입력하세요.">
				<label for="" class="dpn">차량번호</label>
				<button type="button" class="" ng-click="carQuotationSearch()">검색</button>
			</div>
		</div>
		<ul class="quotationList">
			<li ng-repeat="cost in costList">
				<span><em>전송일자</em><strong>{{cost.createdDate}}</strong></span><!-- 2017-06-15 -->
				<span><em>차량번호</em><strong>{{cost.carPlateNum}}</strong></span>
				<span><em>고객명</em><strong>{{cost.userName}}</strong></span>
				<span><em>제시가격</em><strong>{{cost.allSum}} 원</strong></span>
				<span><em>차량명</em><strong>{{cost.carFullName}}</strong></span>
				<a class="" ng-click="searchDetail(cost.costingSeq)" >더보기</a> <!-- 2017-06-14 -->
			</li>
		</ul>
		<div class="noRecord">발송된 비용계산이 없습니다.</div> <!-- 2017-06-18 -->
	</div>
</section>