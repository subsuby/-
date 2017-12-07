<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<c:choose>
	<%-- <c:when test="${fn:containsIgnoreCase(context, 'product/mypage/mycarDealerRegist')}">
		<c:set var="gnbIndex" value="0"/>
	</c:when> --%>
	<c:when test="${fn:containsIgnoreCase(context, 'product/mypage/mycarDealerList')}">
		<c:set var="gnbIndex" value="0"/>
	</c:when>
	<c:when test="${fn:containsIgnoreCase(context, 'product/mypage/mycarDealerForwarding')}">
		<c:set var="gnbIndex" value="1"/>
	</c:when>
	<c:when test="${fn:containsIgnoreCase(context, 'product/mypage/mycarDealerVisit')}">
		<c:set var="gnbIndex" value="2"/>
	</c:when>
	<c:when test="${fn:containsIgnoreCase(context, 'product/mypage/mycarDealerBusinesscard')}">
		<c:set var="gnbIndex" value="3"/>
	</c:when>
	<c:when test="${fn:containsIgnoreCase(context, 'product/mypage/mycarDealerCheckList')}">
		<c:set var="gnbIndex" value="4"/>
	</c:when>
	<c:when test="${fn:containsIgnoreCase(context, 'product/mypage/mycarDealerCostList')}">
		<c:set var="gnbIndex" value="5"/>
	</c:when>
	<c:when test="${fn:containsIgnoreCase(context, 'product/mypage/mycarDealerMakeup')}">
		<c:set var="gnbIndex" value="6"/>
	</c:when>
	<c:when test="${fn:containsIgnoreCase(context, 'product/mypage/mycarDealerMark')}">
		<c:set var="gnbIndex" value="7"/>
	</c:when>
	<c:when test="${fn:containsIgnoreCase(context, 'product/mypage/mycarDealerQna')}">
		<c:set var="gnbIndex" value="8"/>
	</c:when>
	<c:otherwise>
		<c:set var="gnbIndex" value="9"/>
	</c:otherwise>
</c:choose>
<script>
$(function(){
	$('#mycarMenu li:eq(${gnbIndex})').addClass('on');
	totalStatus();

	$("#mycarMenu li").click(function(){
		var url = $(this).children("a").attr("href");
		location.href = BNK_CTX + url;
	});
});

//전체상황 데이터
function totalStatus(){
	$.ajax({
		url : BNK_CTX + '/product/mypage/mycarDealerMenu/status',
		type: "POST",
		contentType:'application/json;charset=utf-8',
		dataType: 'json',
		success : function(result){
			$('#favoCnt').text(result.car.dealerInterestCnt);	//관심딜러 등록 수
			$('#curCnt').text(result.car.curCnt);	//현재등록매물수
			$('#sucCnt').text(result.car.sucCnt);	//판매완료
			$('#resCnt').text(result.car.resHisCnt);//방문+시승요청
		},
		error : function(request,status,error){
			alertify.alert(error);
		}
	});
}
</script>

<div class="mymenu">
	<div class="dealerProfile">
		<!-- 2017-08-19 프로필이미지 변경 -->
		<div class="profileImage">
			<em class="levelWrap"><i class="levelBadge level2"></i></em>
			<img src="<c:url value="/product/images/thumbnail/profileCorver1.png"/>" alt="" class="corver">
			<div class="imgBack"><span><img src="${sessUserInfo.dealerProfileImgPath}" onerror="this.src='<c:url value="/product/images/thumbnail/profile1.png"/>'" alt=""></span></div>
		</div>
		<!-- 2017-08-19 프로필이미지 변경 -->
		<span class="dealName"><strong>${sessUserInfo.userName}</strong>딜러</span>
		<a href="<c:url value="/product/mypage/memberModifyDealer"/>" class="btnModify">회원정보수정</a>
	</div>

	<ul class="menu" id="mycarMenu">
		<!-- li><a href="<c:url value="/product/mypage/mycarDealerRegist"/>">매물등록</a></li -->
	    <li><a href="<c:url value="/product/mypage/mycarDealerList"/>">매물관리</a></li>
	    <li><a href="<c:url value="/product/mypage/mycarDealerForwarding"/>">매물전송서비스</a></li>
	    <li><a href="<c:url value="/product/mypage/mycarDealerVisit"/>">사전방문예약관리</a></li>
	    <li><a href="<c:url value="/product/mypage/mycarDealerBusinesscard"/>">명함관리</a></li>
	    <li><a href="<c:url value="/product/mypage/mycarDealerCheckList"/>">체크리스트관리</a></li>
	    <li><a href="<c:url value="/product/mypage/mycarDealerCostList"/>">구매비용계산기</a></li>
	    <li><a href="<c:url value="/product/mypage/mycarDealerMakeup"/>">메이크업</a></li>
	    <li><a href="<c:url value="/product/mypage/mycarDealerMark"/>">마크서비스</a></li>
	</ul>
	<div class="menuSmall">
		<c:if test="${sessUserInfo.userId eq '4123'}">
			<span><a href="<c:url value="/product/mypage/mycarDealerQna"/>">문의내역관리</a></span>
		</c:if>
	    <!-- <span><a href="#">회원탈퇴신청</a></span>
	    <span><a href="#">정보수정</a></span> -->
	</div>
</div>
<div class="container">
	<p class="infoTxt"><strong>${sessUserInfo.userName}</strong>님의 프로필을 <i id="favoCnt"></i>명이 관심딜러로 등록하였습니다.</p>
		<div class="titBar"><!-- active 추가시 활성화 -->
    		<h2>전체상황</h2>
    		<!-- <span class="btnHelp"><em class="blind">도움말</em></span>
    		<div class="popHelp">
    		</div> -->
		</div>
		<div class="allSituation">
			<span>
	            <em><i id="curCnt"></i>현재등록매물수</em>
	            <em><i id="sucCnt"></i>판매완료</em>
	            <em><i id="resCnt"></i>사전방문예약요청</em>
	            <!-- <em><i>　</i></em> -->
	        </span>
	        <span>
	            <strong>사용 태그상품</strong>
	            <i class="markSet mark2">환불</i>
	            <i class="markSet mark3">헛걸음</i>
	            <i class="markSet mark4">연장</i>
	        </span>
		</div>