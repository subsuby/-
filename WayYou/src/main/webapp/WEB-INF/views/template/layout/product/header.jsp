<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<c:choose>
	<c:when test="${fn:containsIgnoreCase(context, 'product/index')}">
		<c:set var="pos" value="main"/>
	</c:when>
	<c:when test="${fn:containsIgnoreCase(context, 'product/car')}">
		<c:set var="gnbIndex" value="0"/>
	</c:when>
	<c:when test="${fn:containsIgnoreCase(context, 'product/market')}">
		<c:set var="gnbIndex" value="1"/>
	</c:when>
	<c:when test="${fn:containsIgnoreCase(context, 'product/premium')}">
		<c:set var="gnbIndex" value="2"/>
	</c:when>
	<c:when test="${fn:containsIgnoreCase(context, 'product/service')}">
		<c:set var="gnbIndex" value="3"/>
	</c:when>
	<c:otherwise>
		<c:set var="gnbIndex" value="4"/>
	</c:otherwise>
</c:choose>
<script>
$(function(){
	if("${pos}" == "main"){
		$('#wrap').addClass('mainImgArea');
		$('#header').addClass('mainHeader');
	}
	$('#gnb li:eq(${gnbIndex})').addClass('on');

});
</script>
<div id="header">
	<header>
		<h1 class="logo"><a href="<c:url value="/product/index"/>">bnk오토모아</a></h1>
		<div id="gnb">
			<nav>
				<ul>
					<li><a href="<c:url value="/product/car/index"/>">내차사기</a></li>
					<li><a href="<c:url value="/product/market/index"/>">내차팔기</a></li>
					<li><a href="<c:url value="/product/premium/index"/>">인증중고차</a></li>
					<c:choose>
						<c:when test="${fn:containsIgnoreCase(context, '/product/index')}">
							<li><a href="<c:url value="/product/service/index"/>">BNK오토모아서비스</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<c:url value="/product/service/index"/>">BNK오토모아서비스</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</nav>
		</div>
		<div class="linkArea">
			<ul>
				<c:choose>
					<c:when test="${sessUserInfo.userId == null}">
						<li class="iconLogin"><a href="<c:url value="/product/co/login"/>">로그인</a></li>
					</c:when>
					<c:otherwise>
						<li class="iconLoout"><a href="<c:url value="/product/co/logout-proc"/>">로그아웃</a></li>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${sessUserInfo.userId == null}">
						<li class="iconJoin"><a href="<c:url value="/product/co/joinKind"/>">회원가입</a></li>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${sessUserInfo.division == 'D'}">
								<li class="iconMypage"><a href="<c:url value="/product/mypage/mycarDealer"/>">마이페이지</a></li>
							</c:when>
							<c:otherwise>
								<li class="iconMypage"><a href="<c:url value="/product/mypage/mycarPerson"/>">마이페이지</a></li>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
				<li class="iconSitemap"><a href="<c:url value="/product/sitemap"/>">전체메뉴</a></li>
			</ul>
		</div>
	</header>
</div>