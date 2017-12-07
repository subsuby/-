<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="popupAutoWrap popWrapTake p-container w980">
    <!-- popup header -->
    <div class="popupHeaderAuto">
        <header><h1>시승·탁송</h1></header>
        <a class="btnClose p-close" onclick="return false;"><em class="blind">닫기</em></a>
    </div>
    <hr/>
    <!-- popup contents -->
    <div class="popupContents">
        <section>
            <div class="textInfo"><!-- 2017-08-31 by mj-cho -->
                <dl>
                    <dt>시승·탁송 서비스란?</dt>
                    <dd>
                        <strong>시승서비스</strong>란, 판매딜러가 차량을 타고 고객에게 직접 찾아가는 서비스이며,<br>
                        <strong>탁송서비스</strong>란, 차를 구매하고 고객이 원하는 곳으로 차량을 배송해주는 서비스 입니다.
                    </dd>
                </dl>
                <dl>
                    <dt>탁송서비스 <i>차량을 원하시는 곳으로 보내드립니다.</i></dt>
                    <dd>
                        <p class="qna"><i>Q</i> 여러군데 돌아보았지만 처음에 본 차량이 제일 좋았어요. 차량을 구매했는데 매매단지로 갈 시간이 없어요. 온라인으로 차량을 구매했는데 집에서 바로 받아보고 싶어요. 구매한 차량이 너무 멀리 있어요.</p>
                        <p class="qna"><i>A</i> 매매단지에 가지 말고 내 차를 받아보세요!
                        BNK의 특별한 서비스로 고객님께 차량을 보내드립니다. 차량 구매 후, 차량 운송이 어려우신 고객님들께 구매하신 차량을 원하는 지역까지 이송해드립니다.</p>
                    </dd>
                </dl>
                <dl>
                    <dt>탁송 신청절차</dt>
                    <dd>
                        1. 홈페이지에서 차량 확인<br>
                        2. 오프라인 구매 진행<br>
                        3. 탁송서비스 신청(탁송 날짜/지역 입력)<br>
                        4. 원하시는 곳에서 차량 수령
                    </dd>
                </dl>
                <dl>
                    <dt>진행상태 확인</dt>
                    <dd>
                        현재 진행사항을 확인하시고 구입 예정차량 상황을 간편하게 확인하세요.<br>
                        시승예약 및 탁송 상황을 확인 가능합니다. 진행상황을 시시간으로 보여드리며, 판매자 정보를 전달해드립니다.
                    </dd>
                </dl>
                <dl class="pb0">
                    <dt>이용조건</dt>
                    <dd class="term">
                        <strong>탁송서비스 이용조건</strong>
                        <ul>
                            <li>구매한 차량만 탁송서비스가 가능합니다.</li>
                            <li>탁송서비스 신청시 정확한 방문을 위해 회원가입 및 연락처, 주소지정보를 등록해야 합니다.</li>
                            <li>탁송서비스 신청 시 사용료가 청구될 수 있습니다.</li>
                            <li>온라인 구매 후 탁송서비스를 신청하신 경우, 환불보장차량 혹은 신차급 중고차량 등 온라인 상으로 구매 판단이 가능한 특정 매물을 대상으로 합니다.</li>
                        </ul>
                        <strong>시승서비스 이용조건</strong>
                        <ul class="mb0">
                            <li>시승서비스 신청시 정확한 방문을 위해 회원가입 및 연락처, 주소지정보를 등록해야 합니다.</li>
                            <li>시승은 딜러가 허용한 매물만 가능하며, 시승을 신청하시면 딜러가 승인한 후 진행됩니다.</li>
                            <li>시승서비스는 구매 여부와 상관없이 신청이 가능합니다.</li>
                        </ul>
                    </dd>
                </dl>
            </div>
            <div class="btnAreaType mt35">
            	<c:if test="${sessUserInfo.division != 'D'}">
					<span><a onclick="location.href='<c:url value="/product/mypage/mycarPerson"/>'">시승·탁송 현황 보러가기</a></span>
            	</c:if>
            	<c:if test="${sessUserInfo.division == 'D'}">
					<span><a onclick="location.href='<c:url value="/product/mypage/mycarDealer"/>'">시승·탁송 현황 보러가기</a></span>
            	</c:if>
            </div>
        </section>
    </div>
</div>
<!-- //시승탁송 -->