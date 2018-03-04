<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<h3 class="menuTitle">약속 상세</h3>
<section class="regist">
	<div id="tabs">
		<ul>
			<li><a href="#apptRegist"><spring:message code="detail.appt_info"/></a></li>
			<li><a href="#inviteFriend"><spring:message code="detail.invite_friend"/></a></li>
		</ul>
		<div id="apptRegist" class="detailBarOn">
			<div class="regist">
				<div class="tab-content">
					<div class="tab-content tab-content-schedule">
						<div class="tab-pane fade active in" style="background-color:#405470 !important;">
							<div class="panel-group">
								<div class="panel schedule-item registPanel">
									<span class="pinkColor registSpan"><spring:message code="detail.appt_name"/> : </span>
									<input type="text" name="apptPurpose" class="registInput" value="${appt.apptPurpose }"/>
								</div>
								<div class="panel schedule-item registPanel">
									<span class="pinkColor registSpan"><spring:message code="detail.appt_date"/> : </span>
									<input type="text" name="apptTime" class="registDatePicker" placeholder="Date" readonly/>
									<select name="apptTimeT" class="registSelect">
										<option></option>
									</select>
									<select name="apptTimeM" class="registSelect">
										<option></option>
									</select>
								</div>
								<div class="panel schedule-item registPanel">
									<span class="pinkColor registSpan"><spring:message code="detail.appt_place"/> : </span>
									<input type="text" name="apptPlace" class="registInput" value="${appt.apptPlace }"/>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id="map" style="width:100%;height:300px;"></div>
			<br/>
			<div class="regist" id="registSearch">
				<div class="tab-content">
					<div class="tab-content tab-content-schedule">
						<div class="tab-pane fade active in" style="background-color:#405470 !important;">
							<div class="panel-group">
								<div class="panel schedule-item registPanel">
									<span class="pinkColor mapSpan"><spring:message code="detail.map_search"/></span>
									<input type="text" class="mapSearch" name="mapSchVal"/>
									<input type="button" value="<spring:message code='detail.search'/>" class="btn btn-outline btn-map" onclick="DetailScript.searchMap()">
									<input type="hidden" name="apptLat" value="${appt.apptLat }">
									<input type="hidden" name="apptLng" value="${appt.apptLng }">
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="inviteFriend" class="detailBarOn">
		</div>
		<div class="modifiedBtn">
			<input type="button" value="<spring:message code='detail.modified'/>" class="btn btn-outline btn-regist" onclick="DetailScript.Modified()"/>
			<input type="button" value="<spring:message code='detail.cancel_appt'/>" class="btn btn-outline btn-regist" onclick="DetailScript.cancel()" style="padding-left: 2% !important;"/>
		</div>
		<div class="attendBtn">
			<input type="button" value="<spring:message code='detail.attend'/>" class="btn btn-outline btn-regist" onclick="DetailScript.attend('A')"/>
			<input type="button" value="<spring:message code='detail.dis_attend'/>" class="btn btn-outline btn-regist" onclick="DetailScript.attend('D')" style="padding-left: 2% !important;"/>
		</div>
	</div>
</section>
<div class="regist" id="friendClone" style="display:none;">
	<input type="checkbox" class="registCheck"/>
	<div class="tab-content firendTab">
		<div class="tab-content tab-content-schedule">
			<div class="tab-pane fade active in friendPane">
				<div class="panel-group">
					<div class="panel schedule-item friendPanel">
						<table class="friendTable">
							<tbody>
								<tr>
									<td rowspan="3" class="tableFriendName pinkColor">
									</td>
									<td class="tableFriendBirth pinkColor">
									</td>
								</tr>
								<tr>
									<td class="tableFriendPhone pinkColor">
									</td>
								</tr>
								<tr>
									<td class="tableFriendCondition pinkColor">
									</td>
								</tr>
							</tbody>
						</table>
<!-- 						<input type="button" value="초대하기" class="friendInvite" name="friendInvite"/> -->
<!-- 						<input type="button" value="초대취소" class="friendInviteCancel" name="friendInviteCancel" style="display:none;"/> -->
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
