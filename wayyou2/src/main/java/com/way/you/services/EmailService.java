package com.way.you.services;

public interface EmailService {

	
	//이메일 보내기
	public void sendSimpleMessage(String to, String subject, String text);
}
