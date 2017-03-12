package com.joinuser.app;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

public class PasswordEncoding implements PasswordEncoder {
	
	private PasswordEncoder passwordEncoder;
	
	public PasswordEncoding() {
		// TODO Auto-generated constructor stub
		this.passwordEncoder = new BCryptPasswordEncoder();
	}
	
	public PasswordEncoding(PasswordEncoder passwordEncoder) {
		this.passwordEncoder = passwordEncoder;
	}

	@Override
	public String encode(CharSequence password) {
		// TODO Auto-generated method stub
		return passwordEncoder.encode(password);
	}

	@Override
	public boolean matches(CharSequence password, String encodedPassword) {
		// TODO Auto-generated method stub
		return passwordEncoder.matches(password, encodedPassword);
	}


}
