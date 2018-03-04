package com.way.you.services;

import com.way.you.bean.User;

public interface LoginService {
	
	
	//회원가입하기
	public int signUp(User user);
	
	//회원인증하기
	public User userConfirm(User user);

	//회원 아이디 찾기
	public User findId(User user);

	//회원 비밀번호 찾기 및 비밀번호 인증 코드 생성
	public int findPwd(User user);

	//회원 비밀번호 찾기 비밀번호 인증
	public int pwdFindCode(User user);

	//회원 비밀번호 재설정
	public int resetPassword(User user);

	//로그인 하기
	public int login(User user);

	public int duplicate(User user);

	public User getMyInfo(User user);

	public User changeMyInfo(User user);

	public String getNewInfo(User param);
}
