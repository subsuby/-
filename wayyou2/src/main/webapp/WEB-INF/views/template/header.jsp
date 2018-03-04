<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<header class="header header-black fixed" style="min-height: 66px;height:66px;">
	<div class="header-wrapper" style="height:66px;">
		<div class="container">
			<div class="col-sm-2 col-xs-12 navigation-header" style="height:66px;">
				<a href="/front/main" class="logo" style="width:40%">
					<img src="/resources/img/custom/logo_nodes.png" alt="∑Œ∞Ì" style="width:40%;margin-top:5%;margin-left:55%;" class="retina-hide logoIcon">
					<img src="/resources/img/custom/logo_nodes.png" alt="∑Œ∞Ì" style="width:40%;margin-top:5%;margin-left:55%;" class="retina-show logoIcon">
				</a>
				<button style="margin-top:12px;" id="iconBar" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navigation" aria-expanded="false" aria-controls="navigation">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a href="/front/friend/list">
					<img src="/resources/img/custom/people-pink.png" alt="ƒ£±∏∏Ò∑œ" id="friendList" style="width: 25px;height: auto;display: inline-block;margin-left:2%;">
				</a>
			</div>
			<div class="col-sm-10 col-xs-12 navigation-container">
				<div id="navigation" class="navbar-collapse collapse" style="max-height: 753px;">
					<ul class="navigation-list pull-left light-text">
						<li class="navigation-item dropdown">
							<a class="navigation-link dropdown-toggle" data-toggle="dropdown"><spring:message code="header.appt_list"/></a>
							<ul class="dropdown-menu" style="">
								<li class="navigation-item"><a href="/front/main" class="navigation-link"><spring:message code="header.come_appt"/></a></li>
								<li class="navigation-item"><a href="/front/appt/wait" class="navigation-link"><spring:message code="header.wait_appt"/></a></li>
								<li class="navigation-item"><a href="/front/appt/progress" class="navigation-link"><spring:message code="header.progress_appt"/></a></li>
								<li class="navigation-item"><a href="/front/appt/canceled" class="navigation-link"><spring:message code="header.complete_appt"/></a></li>
								<li class="navigation-item"><a href="/front/appt/calendar" class="navigation-link"><spring:message code="header.calendar"/></a></li>
								<li class="navigation-item"><a href="/front/appt/regist" class="navigation-link"><spring:message code="header.regist_appt"/></a></li>
							</ul>
						</li>
					</ul>
					<ul class="navigation-list pull-left light-text">
						<li class="navigation-item"><a href="/front/friend/list" class="navigation-link"><spring:message code="header.friend_list"/></a></li>
						<li class="navigation-item"><a href="/front/myinfo/info" class="navigation-link"><spring:message code="header.mypage"/></a></li>
						<li class="navigation-item"><span class="navigation-link" onclick="CommonScript.changeLocale('K')">«—±πæÓ</span><span href="#none" class="navigation-link" onclick="CommonScript.changeLocale('J')">ÏÌ‹‚Âﬁ</span></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</header>