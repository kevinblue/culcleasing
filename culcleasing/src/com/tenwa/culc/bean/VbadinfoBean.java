package com.tenwa.culc.bean;

/**
 * 
 * @author 崔天帅
 * @date 2013-6-12下午04:33:10
 * @info 供应商不良信息
 * @Copyright 
 * Tenwa
 */
public class VbadinfoBean {
	private String sname; //项目名称
	private String idpro; //项目编号
	private String idvendor;//供应商
	private String delivery;//时间差
	private String iddep;//部门
	private String idowner;//项目经理
	public String getIddep() {
		return iddep;
	}
	public void setIddep(String iddep) {
		this.iddep = iddep;
	}
	public String getIdowner() {
		return idowner;
	}
	public void setIdowner(String idowner) {
		this.idowner = idowner;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public String getIdpro() {
		return idpro;
	}
	public void setIdpro(String idpro) {
		this.idpro = idpro;
	}
	public String getIdvendor() {
		return idvendor;
	}
	public void setIdvendor(String idvendor) {
		this.idvendor = idvendor;
	}
	public String getDelivery() {
		return delivery;
	}
	public void setDelivery(String delivery) {
		this.delivery = delivery;
	}
}
