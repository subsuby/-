<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 명함 -->
<div class="first">
    <h2>명함</h2>
     <div class="dealerProfile"'>
        <div class="thumProfile">
            <img src="<c:url value="/product/images/thumbnail/profile5.png"/>" alt="" />
        </div>
        <div class="autoWidth">
            <span class="levelBadge level1"></span>
            <input type="hidden" id="dealerIdHidden" value="${user.userId }"></input>
            <strong>${user.userName }<i> 딜러</i></strong>
            <p>"${user.dealerProfileDesc }"</p> 
        </div>
    </div>
</div>
<!-- 딜러정보 -->
<div class="second">
    <h2>딜러정보</h2>
    <div class="back">
        <ul>
            <li>
                <strong>연락처</strong>
                <span>${empty user.dealerVirtualNum ? user.phoneNumMask : user.dealerVirtualNum }</span>
            </li>
            <li>
                <strong>회원가입일</strong>
                <span>${user.createdDate }</span>
            </li>
            <li>
                <strong>딜러매물</strong>
                <span>판매중 ${user.saleCarCnt }대 | 판매완료 ${user.saleCnt }대</span>
            </li>
            <li>
                <strong>종사자번호</strong>
                <span>${user.dealerLicenseNo }</span>
            </li>
            <li>
                <strong>지역/상사</strong>
                <span>${user.marketInfo.danjisido } ${user.marketInfo.danjicity } ${user.marketInfo.danjifullname }</span>
            </li>
        </ul>
        <div class="dMap" id="map" style="width:242px; height:182px; position: absolute !important;"></div>
        <script>
            var map = new naver.maps.Map('map', {
                center: new naver.maps.LatLng(${user.marketInfo.shop.shopLocLat},${user.marketInfo.shop.shopLocLng}),
                zoom: 10
            });

            var marker = new naver.maps.Marker({
                position: new naver.maps.LatLng(${user.marketInfo.shop.shopLocLat},${user.marketInfo.shop.shopLocLng}),
                map: map
            });
		</script>
    </div>
</div>
<!-- 거래평가 -->
<div class="third" id="evalListDiv"></div>
<!-- 판매차량 -->
<div class="fourth" id="saleCarDiv"></div>
