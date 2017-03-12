package com.joinuser.app;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class User {
	//private MultipartFile image;
	private List<MultipartFile> files;
	private String id;
	private String name;
	private String road_name_address;
	private String detail_address;
	private String lot_number;
	private String post_code;
	private String phone;
	private String email;
	private String password1;
	private String password2;
	private String joinpath;
	private String interests;
	private String captcha_response;
	
	/*public MultipartFile getImage() {
		return image;
	}
	public void setImage(MultipartFile image) {
		this.image = image;
	}*/
	public List<MultipartFile> getFiles() {
		return files;
	}
	public void setFiles(List<MultipartFile> files) {
		this.files = files;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRoad_name_address() {
		return road_name_address;
	}
	public void setRoad_name_address(String road_name_address) {
		this.road_name_address = road_name_address;
	}
	public String getDetail_address() {
		return detail_address;
	}
	public void setDetail_address(String detail_address) {
		this.detail_address = detail_address;
	}
	public String getLot_number() {
		return lot_number;
	}
	public void setLot_number(String lot_number) {
		this.lot_number = lot_number;
	}
	public String getPost_code() {
		return post_code;
	}
	public void setPost_code(String post_code) {
		this.post_code = post_code;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getJoinpath() {
		return joinpath;
	}
	public void setJoinpath(String joinpath) {
		this.joinpath = joinpath;
	}
	public String getInterests() {
		return interests;
	}
	public void setInterests(String interests) {
		this.interests = interests;
	}
	public String getCaptcha_response() {
		return captcha_response;
	}
	public void setCaptcha_response(String captcha_response) {
		this.captcha_response = captcha_response;
	}
	public String getPassword1() {
		return password1;
	}
	public void setPassword1(String password1) {
		this.password1 = password1;
	}
	public String getPassword2() {
		return password2;
	}
	public void setPassword2(String password2) {
		this.password2 = password2;
	}

}
