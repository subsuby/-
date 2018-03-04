package com.way.you.services.impl;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

import com.way.you.config.AppConstBean;
import com.way.you.services.EmailService;

@Service("EmailService")
public class EmailServiceImpl implements EmailService {

	@Autowired
	public JavaMailSenderImpl emailSender;

	public void sendSimpleMessage(String to, String subject, String text) {
		MimeMessage message = emailSender.createMimeMessage();
		try {
			message.addRecipient(RecipientType.TO, new InternetAddress(to));			//받는사람
			message.setSubject(subject);												//제목
			message.setText(text, "UTF-8", "html");										//내용
			message.setFrom(new InternetAddress(AppConstBean.MAIL_SERVICE_USERNAME));	//보내는 사람
			emailSender.send(message);
		}catch(Exception e) {
			e.printStackTrace();
		}
    }
}