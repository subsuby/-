<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div id="header">
	<div class="topGnb">
		<header>
			<span class="left">
				<span class="hbtnSnb"><button ng-click="onHSnbBtnClick()">SNB Go</button></span>
				<c:if test="${!(fn:containsIgnoreCase(context, 'index'))
					&& !(fn:containsIgnoreCase(context, 'category/service/serviceList'))
					&& !(fn:containsIgnoreCase(context, 'category/service/special'))
					&& !(fn:containsIgnoreCase(context, 'category/certify/certifyList'))
					&& !(fn:containsIgnoreCase(context, 'category/mycar/buyList'))
					&& !(fn:containsIgnoreCase(context, 'category/mycar/sells'))}">
 					<span class="hbtnBack"><button ng-click="onBackClick()">Back page</button></span>
 				</c:if>
 				<c:if test="${(fn:containsIgnoreCase(context, 'category/mycar/sellsResult'))}">
 					<span class="hbtnBack"><button ng-click="onBackClick()">Back page</button></span>
 				</c:if>
			</span>
			<h1>${pageTitle}</h1>
			<span class="right">
				<c:if test="${!(fn:containsIgnoreCase(context, 'session/front/login'))}">
				<span class="hbtnMypage" ng-class="{off: sessUserInfo.division === -1}"><button ng-click="onHMypageBtnClick()">My page</button></span>
				</c:if>
			</span>
		</header>
	</div>
	<c:if test="${(fn:containsIgnoreCase(context, 'category/service/serviceList'))}">
		<div class="topSearch hAuto locationOff">
			<div class="gpsArea">
				<p>BNK오토모아 현장서비스의 편리한 사용을 위해 <br/>단말기 설정에서 '위치 서비스' 사용를 허용해주세요.</p><!-- 2017-06-01 로고명변경 -->
				<div class="btnSet">
					<span><button class="redLine"  ng-click="locationOn()">위치 서비스 켜기</button></span>
				</div>
			</div>
		</div>
		<div class="topSearch locationOn hAuto" style="display:none;" >
			<div class="dealerArea"><!-- 축약형 일때 class="smalltype" 삽입 -->
				<p class="location">{{danjiSido}}  ·  {{danjiCity}}  ·  {{danjiFullName}} <input ng-click="reloadBtn()" type="button" value="새로고침"/></p>
				<ul class="dealerList2" ng-if="userDealerList.size > 0">
					<li>
						<div class="inner">
							<span class="heartSetS" ng-show="userDealerList[0].userId != null"><!-- input type="checkbox" id="" /><label for=""><!--찜하기></label --></span>
							<a href="" ng-click="dealerOpen(userDealerList[0].userId)" class="dealerProfile">
								<div class="fixWidth">
									<span class="thumProfile">
										<img src="../../images/thumbnail/profile2.png" alt="" />
									</span>
								</div>
								<div class="autoWidth" ng-show="userDealerList[0].userId != null">
									<span class="levelBadge level{{userDealerList[0].gradeDealer}}"><strong>{{userDealerList[0].userName}}</strong></span>
									<p>{{userDealerList[0].phoneMobile}}</p>
									<div class="rating rating-s" data-rateit-readonly="true" data-rateit-value="{{userDealerList[0].phoneMobile}}"></div>
								</div>
							</a>
						</div>
					</li>
					<li>
						<div class="inner">
							<span class="heartSetS" ng-show="userDealerList[1].userId != null"><!-- input type="checkbox" id="" /><label for=""><!--찜하기></label --></span>
							<a href="" ng-click="dealerOpen(userDealerList[1].userId)" class="dealerProfile">
								<div class="fixWidth">
									<span class="thumProfile">
										<img src="../../images/thumbnail/profile2.png" alt="" />
									</span>
								</div>
								<div class="autoWidth" ng-show="userDealerList[1].userId != null">
									<span class="levelBadge level{{userDealerList[1].gradeDealer}}"><strong>{{userDealerList[1].userName}}</strong></span>
									<p>{{userDealerList[1].phoneMobile}}</p>
									<div class="rating rating-s" data-rateit-readonly="true" data-rateit-value="{{userDealerList[1].phoneMobile}}"></div>
								</div>
							</a>
						</div>
					</li>
					<li>
						<div class="inner">
							<span class="heartSetS" ng-show="userDealerList[2].userId != null"><!-- input type="checkbox" id="" /><label for=""><!--찜하기></label --></span>
							<a href="" ng-click="dealerOpen(userDealerList[2].userId)" class="dealerProfile">
								<div class="fixWidth">
									<span class="thumProfile">
										<img src="../../images/thumbnail/profile2.png" alt="" />
									</span>
								</div>
								<div class="autoWidth" ng-show="userDealerList[2].userId != null">
									<span class="levelBadge level{{userDealerList[2].gradeDealer}}"><strong>{{userDealerList[2].userName}}</strong></span>
									<p>{{userDealerList[2].phoneMobile}}</p>
									<div class="rating rating-s" data-rateit-readonly="true" data-rateit-value="{{userDealerList[2].phoneMobile}}"></div>
								</div>
							</a>
						</div>
					</li>
					<li>
						<div class="inner">
							<span class="heartSetS" ng-show="userDealerList[3].userId != null"><!-- input type="checkbox" id="" /><label for=""><!--찜하기></label --></span>
							<a href="" ng-click="dealerOpen(userDealerList[3].userId)" class="dealerProfile">
								<div class="fixWidth">
									<span class="thumProfile">
										<img src="../../images/thumbnail/profile2.png" alt="" />
									</span>
								</div>
								<div class="autoWidth" ng-show="userDealerList[3].userId != null">
									<span class="levelBadge level{{userDealerList[3].gradeDealer}}"><strong>{{userDealerList[3].userName}}</strong></span>
									<p>{{userDealerList[3].phoneMobile}}</p>
									<div class="rating rating-s" data-rateit-readonly="true" data-rateit-value="{{userDealerList[3].phoneMobile}}"></div>
								</div>
							</a>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</c:if>
</div>