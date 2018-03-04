<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<section>
	<h3 class="menuTitle"><spring:message code="friend.friend_list"/></h3>
	<div class="myInfo">
		<div class="friendSearchArea">
			<input data-modal-link="addFriend" type="button" value="<spring:message code='friend.msg.add_friend_by_id'/>" class="friendAddButton" onclick="FriendScript.addFriend();"/>
		</div>
	</div>
	<div class="friendList">
		<div class="friendSearchArea">
			<input type="text" class="friendSearch" name="schValue"/>
			<input type="button" value="<spring:message code='friend.search'/>" class="friendSearchButton" onclick="FriendScript.search();"/>
		</div>
	</div>
	<div class="regist friendTabs" id="friendClone">
		<div class="tab-content friendTabPink">
			<div class="tab-content tab-content-schedule">
				<div class="tab-pane fade active in friendPanePink">
					<div class="panel-group">
						<div class="panel schedule-item PinkTab">
							<table class="friendTable">
								<tbody>
									<tr>
										<td rowspan="2" class="tableFriendName blueColor">
										</td>
										<td class="tableFriendBirth blueColor">
										</td>
									</tr>
									<tr>
										<td class="tableFriendPhone blueColor">
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
</section>
<div class="modal-window open" data-modal="addFriend" style="background-color: #405470; display: none;">
	<div class="modal-box small animated zoomIn" data-animation="zoomIn" data-duration="700" 
	style="top: 0px; animation-delay: 0ms; animation-duration: 0.7s;" id="addFriendPop">
		<span class="close-btn icon icon-office-52"></span>
		<h5 class="align-center"><span class="pinkColor"><spring:message code="friend.msg.add_friend_by_id"/></span></h5>
		<br/>
		<form class="form registration-form align-center" id="addFriendForm">
			<fieldset class="col-sm-12" style="padding:0px;">
				<input name="findId" type="text" class="emailIn customInput" placeholder="<spring:message code='friend.email'/>">
				<span class="underInputR" style="width:85%;display:block;margin-left:auto !important;margin-right:auto !important;"></span>
			</fieldset>
			<br/>
			<input type="button" value="<spring:message code='friend.find'/>" class="btn btn-outline btn-md" onclick="FriendScript.findFriend()" 
			style="font-size:16px;min-height:30px;padding:0px !important;">
		</form>
	</div>
</div>
<div class="modal-window open findFriendResult" data-modal="findFriendResult" style="background-color: #405470; display: none;">
	<div class="modal-box small animated zoomIn" data-animation="zoomIn" data-duration="700" 
	style="top: 0px; animation-delay: 0ms; animation-duration: 0.7s;" id="addFriendPop">
		<span class="close-btn icon icon-office-52"></span>
		<h5 class="align-center"><span class="pinkColor"><spring:message code="friend.msg.add_friend_by_id"/></span></h5>
		<br/>
		<div>
			<span class="pinkColor findFriendSpan findFriendName"><spring:message code="friend.name"/> : </span>
			<span class="pinkColor findFriendSpan findFriendPhone"><spring:message code="friend.phone"/> : </span>
			<span class="pinkColor findFriendSpan findFriendBirth"><spring:message code="friend.birth"/> : </span>
			<input type="button" value="<spring:message code='friend.add'/>" class="btn btn-outline btn-md" id="addFriendBtn" 
			style="font-size:16px;min-height:30px;padding:0px !important;margin-top:3%">
		</div>
	</div>
</div>
<div class="modal-window addFriendResult open" data-modal="addFriendResult" style="background-color: #405470; display: none;">
	<div class="modal-box small animated zoomIn" data-animation="zoomIn" data-duration="700" 
	style="top: 0px; animation-delay: 0ms; animation-duration: 0.7s;margin-top:50%;margin-bottom:50%;">
		<span class="close-btn icon icon-office-52"></span>
		<h5 class="align-center"><span class="pinkColor"><spring:message code="friend.msg.add_friend_by_id"/></span></h5>
		<br/><br/>
		<h7 class="align-center"><span class="pinkColor"><spring:message code="friend.msg.add_Friend_complete"/></span></h7>
	</div>
</div>