<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- 관리자 화면 템플릿 --%>
<!DOCTYPE html>
<html lang="ko">
	<c:set var="angularCtrlVal"><tiles:getAsString name="angularCtrl"/></c:set><!-- Angular Controller 이름 : tiles.xml에서 세팅 -->
	<head>
		<tiles:insertAttribute name="meta" />
		<tiles:insertAttribute name="scripts" />
		<style>
		/* 일반 문자, 이미지들 블록지정 하지 못하도록 */
		p, label, em, img {
			-webkit-touch-callout: none; /* iOS Safari */
			  -webkit-user-select: none; /* Chrome/Safari/Opera */
			   -khtml-user-select: none; /* Konqueror */
			     -moz-user-select: none; /* Firefox */
			      -ms-user-select: none; /* Internet Explorer/Edge */
			          user-select: none; /* Non-prefixed version, currently
			                                not supported by any browser */
		}
		</style>
		<script type="text/javascript">
			'use strict';
			var BNK_CTX = "${pageContext.request.contextPath}";
			var bnkApp = angular.module('bnkApp', ['bnk-common.filter','bnk-common.directive','bnk-common.service','angucomplete-alt','ngFileUpload','ngSanitize']);
			var CTRL_NAME = '${angularCtrlVal}';

			// angular exception 공통 예외처리
			bnkApp.config(function($provide){
			    $provide.decorator("$exceptionHandler", function($delegate, $injector){
			        return function(exception, cause){
			        	console.log(exception, cause);
// 			        	angular.element('body').hide();
// 			            var $rootScope = $injector.get("$rootScope");
// 			            $rootScope.addError({message:"Exception", reason:exception});
// 			            $delegate(exception, cause);
			        };
			    });

			});

			bnkApp.run(['$localstorage', function($localstorage){
				$localstorage.init();
			}]);
		</script>
		<!-- BNK PLUS Global Controller -->
		<script src="<c:url value="/front/js/angular/controller/global-controller.js?latest=${jsVersion}"/>"></script>
	</head>
	<body ng-app="bnkApp" ng-controller="globalCtrl" ng-cloak>
		<!-- wrap_back -->
		<div id="wrap_back" ng-controller="${angularCtrlVal}">
			<!------------------------------------------------------------------------>
			<!-- Menu Mask -->
			<div id="c-mask" class="c-mask"></div>
			<tiles:insertAttribute name="slide-l" />
			<tiles:insertAttribute name="slide-r" />
			<!------------------------------------------------------------------------>
			<!-- wrap -->
			<div id="wrap">

				<!-- header -->
				<tiles:insertAttribute name="header" />
				<!-- //header -->
				<hr/>
				<!-- contents -->
				<div id="contents">
					<!-- 메인 -->
					<tiles:insertAttribute name="contents" />
					<tiles:insertAttribute name="contents-js" />
				</div>
				<!-- //contents -->

				<hr/>
				<!-- footer -->
				<tiles:insertAttribute name="footer" />
				<!-- //footer -->
			</div>
			<!-- //wrap -->

			<!-- footerFixed -->
			<div class="footerFixed">
				<a href="#wrap" class="moveTop" id="goTop" ng-click="onFloatingTopBtnClick()">상단이동</a>
					<c:if test="${(fn:containsIgnoreCase(context, 'category/service/serviceList'))}">
						<div class="serviceMenu typeD" ng-show="sessUserInfo.division == 'D'">
							<button class="btn-popup-full" data-pop-opts='{"target": ".popWrapCost"}'>구매비용계산</button>
							<button class="btn-popup-full" data-pop-opts='{"target": ".popCheckList"}'>체크리스트</button>
							<button class="btn-popup-full" data-pop-opts='{"target": ".businesscard"}'>명함발송</button>
							<button class="btn-popup-full" data-pop-opts='{"target": ".carNumSearch1"}'>차량번호검색</button>
						</div>
						<div class="serviceMenu type2" ng-show="sessUserInfo.division != 'D' && sessUserInfo.division != -1">
							<button class="btn-popup-full" data-pop-opts='{"target": ".popTip"}'>중고차 구입활용팁</button>
							<button class="btn-popup-full" data-pop-opts='{"target": ".carNumSearch1"}'>실매물체크</button>
						</div>
					</c:if>
					<!-- 2017-06-15 위치이동 footerFixed -->
					<c:if test="${(fn:containsIgnoreCase(context, 'category/mycar/buyDetail'))}">
						<div class="btnSet twoCase" ng-show="sessUserInfo.division != 'D'">
							<span>
								<button onClick="return false;" type="button" class="red" ng-click="onClick('CD_RESERVE')">방문·시승 <em>예약</em></button>
							</span>
							<span class="last">
								<button onClick="return false;" type="button" class="red" ng-click="onClick('CD_CONSIGN')">탁송 <em>신청</em></button>
							</span>
						</div>
					</c:if>
			</div>
			<!-- //footerFixed-->
			<c:if test="${not (fn:containsIgnoreCase(context, 'session/front/login'))}">
				<div><login-pop sess-user-info="sessUserInfo" /></div>	<%-- 로그인 팝업 공통 --%>
			</c:if>
			<c:set var="tilesLayer"><tiles:getAsString name="contents-popup"/></c:set>
			<c:set var="existLayer" value="${layer:exist(req, tilesLayer)}"/>
			<c:if test="${existLayer}">
				<tiles:insertAttribute name="contents-popup"/>
			</c:if>
			<div class="popupDim"></div>
		</div>
		<div id="loadingAll" class="loadingAll" style="display:none;">
			<img src="/front/images/common/loading_one.gif" alt="loading" />
		</div>
		<!-- //wrap_back -->
	</body>
</html>