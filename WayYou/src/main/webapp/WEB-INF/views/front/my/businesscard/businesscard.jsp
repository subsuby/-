<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
	<div class="busiCardLayout">
		<div class="searchBar">
			<div class="searchArea">
				<input type="text" id="" ng-model="search.schValue" placeholder="고객명 및 연락처를 입력하세요.">
				<label for="" class="dpn">전화번호 및 고객명</label>
				<button type="button" class="" ng-click="onClick()">검색</button>
			</div>
		</div>
		<ul class="cardList">
			<li ng-repeat="send in list">
				<span><em>발송일자</em>{{send.sendDate.substring(0,10)}}</span>
				<span><em>고객명</em>{{send.userName}}</span>
				<span><em>연락처</em><a href="#">{{send.phoneMobile}}</a></span>
				<button class="btnResend" ng-click="reSend(send)">재발송</button>
			</li>
		</ul>
		<div class="noRecord" ng-show="list && list.length === 0">발송된 명함이 없습니다.</div> <!-- 2017-06-18 -->
	</div>
</section>