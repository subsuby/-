package com.way.you.bean;

public class Friend extends Combean{

	private String friendId;		//친구 시퀀스
	private String userId;			//유저아이디
	private String userFriendId;	//친구 유저 아이디
	private User friend;			//친구 유저 정보
	
	public String getFriendId() {
		return friendId;
	}
	public void setFriendId(String friendId) {
		this.friendId = friendId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public User getFriend() {
		return friend;
	}
	public void setFriend(User friend) {
		this.friend = friend;
	}
	public String getUserFriendId() {
		return userFriendId;
	}
	public void setUserFriendId(String userFriendId) {
		this.userFriendId = userFriendId;
	}
	
	@Override
	public String toString() {
		return "Friend [friendId=" + friendId + ", userId=" + userId + ", userFriendId=" + userFriendId + ", friend="
				+ friend + "]";
	}
}
