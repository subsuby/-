<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
	<div class="checklistLayout">
		<div class="searchBar">
			<div class="searchArea">
				<input type="text" name="schValue" ng-model="schValue" placeholder="고객명을 입력하세요.">
				<label for="" class="dpn">고객명을 입력하세요.</label>
				<button type="button" class="" ng-click="getList()">검색</button>
			</div>
		</div>
		<ul class="checkList" ng-show="checkList.length != 0">
			<li ng-repeat="chk in checkList" class="asd">
				<span><em>발송일자</em>{{chk.createdDate}}</span>
				<span><em>고객명</em>{{chk.userName}}</span>
				<button  ng-click="onClick(chk.checkItems,chk.userName,chk.createdDate)">상세보기</button>
			</li>
		</ul>
		<div class="noRecord" ng-show="checkList.length == 0">발송 이력이 없습니다.</div> <!-- 2017-06-18 -->				
	</div>
</section>