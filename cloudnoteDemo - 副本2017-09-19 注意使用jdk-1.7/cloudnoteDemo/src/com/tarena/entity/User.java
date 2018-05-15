package com.tarena.entity;

public class User extends Entity {

	private static final long serialVersionUID = 1776757169185464752L;
	
	private String cn_user_id;//用户id
	private String cn_user_name;//用户名
	private String cn_user_password;//密码
	private String cn_user_token;//令牌
	private String cn_user_desc;//说明

	public String getCn_user_id() {
		return cn_user_id;
	}

	public void setCn_user_id(String cnUserId) {
		cn_user_id = cnUserId;
	}

	public String getCn_user_name() {
		return cn_user_name;
	}

	public void setCn_user_name(String cnUserName) {
		cn_user_name = cnUserName;
	}

	public String getCn_user_password() {
		return cn_user_password;
	}

	public void setCn_user_password(String cnUserPassword) {
		cn_user_password = cnUserPassword;
	}

	public String getCn_user_token() {
		return cn_user_token;
	}

	public void setCn_user_token(String cnUserToken) {
		cn_user_token = cnUserToken;
	}

	public String getCn_user_desc() {
		return cn_user_desc;
	}

	public void setCn_user_desc(String cnUserDesc) {
		cn_user_desc = cnUserDesc;
	}

	@Override
	public String toString() {
		return "User [cn_user_desc=" + cn_user_desc + ", cn_user_id="
				+ cn_user_id + ", cn_user_name=" + cn_user_name
				+ ", cn_user_password=" + cn_user_password + ", cn_user_token="
				+ cn_user_token + "]";
	}
	

}