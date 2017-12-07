<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="innerLayout">
    <div class="dataSet">
        <h3 class="line">
			마이카
			<span class="btnSet mycarAdd">
				<span>
				<a class="red" onclick="mycar_detail_pop(this)">내차등록하기</a>
				<input type="hidden" class="btn-popup-auto" data-pop-opts='{"target": ".popCarModfy"}'/>
				</span>
			</span>
        </h3>
        <h4>등록차량리스트</h4>
        <div class="carListHead">
            <span>차량번호</span>
            <span>제조사</span>
            <span>모델명</span>
            <span>연식</span>
            <span>주행거리</span>
            <span>색상</span>
            <span>상태</span>
            <span>견적상태</span>
        </div>
        <div class="myList carList"> <!--  dataNoneList 2017-06-08 리스트 내용 없을 시  dataNoneList 클래스 추가 by hr-park -->
            <table summary="목록">
                <caption>목록</caption>
                <colgroup>
                    <col width="120">
                    <col width="170">
                    <col width="300">
                    <col width="100">
                    <col width="155">
                    <col width="115">
                    <col width="170">
                    <col width="95"> <!-- 2017-08-19 -->
                </colgroup>
                <tbody>
                	<c:if test="${empty myCarList}">
                	<tr class="dataNone">
                		<td colspan="7">등록된 차량 정보가 없습니다.</td>
                	</tr>
                	</c:if>
                	<c:forEach var="myCar" items="${myCarList}" varStatus="status">
					<!--마이카매물자동선택스크립트 -->
                	<c:if test="${status.index==0}">
                		<script>
                		$(function(){ $('.myList.carList tr:eq(0)').trigger('click'); });
                		</script>
                	</c:if>
                    <tr onclick='onClick("BTN_SELECT_MYCAR", ${ct:toJson(myCar)}, this)'>
                        <td>${myCar.carPlateNum}</td>
                        <td>${myCar.label.makerName}</td>
                        <td>
	                        <p>
		                        <a class="txtDeco" onclick='mycar_detail_pop(this, ${myCar.mycarSeq})'>${myCar.label.modelDtlName}</a>
		                        <input type="hidden" class="btn-popup-auto" data-pop-opts='{"target": ".popCarModfy"}'/>
	                        </p>
                        </td>

                        <td>${myCar.carRegYear}</td>
                        <td><fmt:formatNumber value="${myCar.useKm div 10000 + 1}" pattern="#,###만" groupingUsed="true"/> KM 미만</td>
                        <td>${myCar.label.carColor}</td>
                        <td>
                        	<c:if test="${ct:equals(myCar.estReqYn, 'Y')}">
                        	<i class="${ct:getCodeExpString(ct:getConstDef('SYS_CODE_EST_STATE'), myCar.estState)}">
                        		${ct:getCodeString(ct:getConstDef('SYS_CODE_EST_STATE'), myCar.estState)}
                        	</i>
                        	</c:if>
                        	<c:if test="${not ct:equals(myCar.estReqYn, 'Y')}">
                        	<i class="red">견적하기</i>
                        	</c:if>
                        </td>
                        <td>
	                        ${fn:length(myCar.estimateArr)}/5
                        </td>
                    </tr>
                	</c:forEach>
                </tbody>
            </table>
        </div>
        <div class="mycarPart" id="mycar_list_sub">
        	<c:if test="${empty myCarList}">
           	<div class="root rootNone first noneCar">
				<p class="noInfo info1">방문견적<em>전문가에게 모든 판매를 맡겨보세요</em></p>
				<div class="btnSet btnCenter">
					<span><a class="red btn-popup-auto"  onclick="return false;" data-pop-opts='{"target": ".visitApp"}'>신청하기</a></span>
				</div>
			</div>
			<div class="root rootNone noneCar">
				<p class="noInfo info2">딜러견적<em>전문가에게 모든 판매를 맡겨보세요</em></p>
				<div class="btnSet btnCenter">
					<span><a class="red" onclick="mycar_list_estimate_service('dealer', '${myCar.mycarSeq}')">신청하기</a></span>
				</div>
			</div>
           	</c:if>
        </div>
     </div>
</div>