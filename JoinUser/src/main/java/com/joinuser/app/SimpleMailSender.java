package com.joinuser.app;

import java.util.Random;

import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;

public class SimpleMailSender {
	
	private MailSender mailSender;
	private SimpleMailMessage authMessage;
	
	public void setMailSender(MailSender mailSender) {
		this.mailSender = mailSender;
	}
	public void setTemplateMessage(SimpleMailMessage authMessage) {
		this.authMessage = authMessage;
	}
	
	public void sendSimpleMail(String receiver) {
		SimpleMailMessage message = new SimpleMailMessage(this.authMessage);
		
		int ran = new Random().nextInt(100000) + 10000;

	    String content = "인증코드="+ran;
	    
	    
		message.setTo(receiver);
		message.setText(content);
		try {
			this.mailSender.send(message);
		} catch(MailException ex) {
			System.err.println(ex.getMessage());
		}
		
	}

}
