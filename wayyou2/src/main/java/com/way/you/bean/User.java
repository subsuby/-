package com.way.you.bean;

import java.util.List;

public class User extends Combean{
	
	private String userId;			//사용자 아이디
	private String userPwd;			//사용자 비밀번호
	private String userName;		//사용자 이름
	private String userBirth;		//사용자 생년월일
	private String userPhone;		//사용자 핸드폰 번호
	private String userToken;		//사용자 핸드폰 고유 토큰값
	private String userConfirmCode;	//사용자 인증코드
	private String userConfirmYn;	//사용자 인증여부
	private String userUseYn;		//사용자 사용여부
	private String pwdFindCode;		//비밀번호 찾기 코드
	private List<Friend> friend;	//친구목록
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserBirth() {
		return userBirth;
	}
	public void setUserBirth(String userBirth) {
		this.userBirth = userBirth;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	public String getUserConfirmYn() {
		return userConfirmYn;
	}
	public void setUserConfirmYn(String userConfirmYn) {
		this.userConfirmYn = userConfirmYn;
	}
	public String getUserUseYn() {
		return userUseYn;
	}
	public void setUserUseYn(String userUseYn) {
		this.userUseYn = userUseYn;
	}
	public String getPwdFindCode() {
		return pwdFindCode;
	}
	public void setPwdFindCode(String pwdFindCode) {
		this.pwdFindCode = pwdFindCode;
	}
	public String getUserConfirmCode() {
		return userConfirmCode;
	}
	public void setUserConfirmCode(String userConfirmCode) {
		this.userConfirmCode = userConfirmCode;
	}
	public List<Friend> getFriend() {
		return friend;
	}
	public void setFriend(List<Friend> friend) {
		this.friend = friend;
	}
	@Override
	public String toString() {
		return "User [userId=" + userId + ", userPwd=" + userPwd + ", userName=" + userName + ", userBirth=" + userBirth
				+ ", userPhone=" + userPhone + ", userConfirmCode=" + userConfirmCode + ", userConfirmYn="
				+ userConfirmYn + ", userUseYn=" + userUseYn + ", pwdFindCode=" + pwdFindCode + ", friend=" + friend
				+ "]";
	}
	public String getUserToken() {
		return userToken;
	}
	public void setUserToken(String userToken) {
		this.userToken = userToken;
	}
	
}
