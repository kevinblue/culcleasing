package com.tenwa.culc.bean;

/**
 * 
 * @author ����˧
 * @date 2013-6-12����04:33:10
 * @info ��Ӧ�̲�����Ϣ
 * @Copyright 
 * Tenwa
 */
public class VbadinfoBean {
	private String sname; //��Ŀ����
	private String idpro; //��Ŀ���
	private String idvendor;//��Ӧ��
	private String delivery;//ʱ���
	private String iddep;//����
	private String idowner;//��Ŀ����
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
