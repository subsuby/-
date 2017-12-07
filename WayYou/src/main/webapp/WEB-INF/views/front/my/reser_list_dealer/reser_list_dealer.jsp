<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<section>
	<div>
		<ul class="alreadyReser">
			<li ng-repeat="res in resList">
				<span class="positionL">
					<i ng-if="res.resStatus == 10 || res.resStatus == 90 || res.resStatus == 91 || res.resStatus == 92" class="refuse">{{res.label.resStatus}}</i>
					<i ng-if="res.resStatus == 11" >{{res.label.resStatus}}</i>
					<i ng-if="res.resStatus == 20" class="complete">{{res.label.resStatus}}</i>
					<i>{{res.label.resType}}</i>
				</span>
				<em class="dateTxt">{{res.resUserNm}} 님</em>
				<em class="cancleTxt" ng-hide="true">예약취소 {{res.cancelCnt}}회</em>
				<strong>{{res.label.carFullName}}</strong>
				<em class="dateTxt">
					{{res.resDate.substr(0,4)}}년 {{res.resDate.substr(4,2)}}월 {{res.resDate.substr(6,8)}}일
					<i ng-if="res.resAmpm == 'AM'">오전</i><i ng-if="res.resAmpm == 'PM'">오후</i>
					{{res.resTime}}<i ng-if="res.resTime.length > 0">시</i>
				</em>
				<span class="positionR">
					<button class="btnComplete" ng-show="res.resStatus == 10" ng-click="acceptReserve(res)">승인요청</button>
					<button class="btnRefuse" ng-show="res.resStatus == 10 || res.resStatus == 11" ng-click="rejectReserve(res)">거절</button>
					<button class="btnRefuse redLine" ng-click="cancelPop()" ng-show="res.resStatus == 20">취소요청</button>
				</span>
			</li>
		</ul>
		<div class="noRecord" ng-show="resList.length === 0">예약신청이 없습니다.</div> <!-- 2017-06-18 class 변경 -->
	</div>
</section>
