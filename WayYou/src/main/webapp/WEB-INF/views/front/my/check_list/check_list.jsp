<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
	<div class="checklistLayout">
		<div class="searchBar">
			<div class="searchArea">
				<input type="text" id="" name="schValue" ng-model="schValue" placeholder="딜러명을 입력하세요.">
				<label for="" class="dpn">딜러명을 입력하세요.</label>
				<button type="button" class="" ng-click="getList()">검색</button>
			</div>
		</div>
		<ul class="checkList" ng-show="checkList.length != 0">
			<li ng-repeat="chk in checkList">
				<span><em>구분</em><strong>{{chk.division == '3' ? '체크리스트' : '구매비용'}}</strong></span>
				<span><em>수신일자</em>{{chk.createdDate}}</span>
				<span><em>딜러명</em>{{chk.userName}}</span>
                <button  ng-click="onClick(chk.division,chk.checkItems,chk.userName,chk.createdDate, chk.chkListSeq)">상세보기</button>
			</li>
		</ul>
		<div class="noRecord" ng-show="checkList && checkList.length === 0">수신된 이력이 없습니다.</div> 
	</div>
</section>
