package com.joinuser.app;

import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

public class SHAPasswordEncoder implements PasswordEncoder{
	
	private ShaPasswordEncoder shaPasswordEncoder;
	private Object salt = null;

	public void setSalt(Object salt) {
		this.salt = salt;
	}

	public SHAPasswordEncoder() {
		// TODO Auto-generated constructor stub
		shaPasswordEncoder = new ShaPasswordEncoder();
	}
	
	public SHAPasswordEncoder(int sha) {
		// TODO Auto-generated constructor stub
		shaPasswordEncoder = new ShaPasswordEncoder(sha);
	}
	
	public void setEncodeHashAsBase64(boolean encodeHashAsBase64) {
		shaPasswordEncoder.setEncodeHashAsBase64(encodeHashAsBase64);
	}

	@Override
	public String encode(CharSequence password) {
		// TODO Auto-generated method stub
		return shaPasswordEncoder.encodePassword(password.toString(), salt);
	}

	@Override
	public boolean matches(CharSequence password, String encodedPassword) {
		// TODO Auto-generated method stub
		return shaPasswordEncoder.isPasswordValid(encodedPassword, password.toString(), salt);
	}

}
