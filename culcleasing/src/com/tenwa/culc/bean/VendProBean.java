package com.tenwa.culc.bean;

import java.util.Date;



/**
 * 
 * @author ����˧
 * @date 2013-6-12����04:33:10
 * @info ��Ӧ����Ŀ��Ϣ
 * @Copyright 
 * Tenwa
 */
public class VendProBean {
	private String sname;//��Ŀ����
	private String idpro;//��Ŀid
	private String idvendor;//��Ӧ��ID
	private String equip;//�������
	private String models;//��������ͺ�
	private String producer;//��������
	private String darrive;//ʵ�ʵ���ʱ��
	private String idowner;//��Ŀ����
	private String iddep;//����
	private String sflag;//
	private String ventype;//provider_type��Ӧ������;
	private String plan_date;//�ƻ�����ʱ��
	private String equip_id;//����������
	private String qualification_name;//����֤������
	private Date qualification_date;//����֤����Ч��
	private String is_arrive;//�Ƿ�����
	
	public String getIs_arrive() {
		return is_arrive;
	}
	public void setIs_arrive(String isArrive) {
		is_arrive = isArrive;
	}
	public String getQualification_name() {
		return qualification_name;
	}
	public void setQualification_name(String qualification_name) {
		this.qualification_name = qualification_name;
	}
	
	public Date getQualification_date() {
		return qualification_date;
	}
	public void setQualification_date(Date qualificationDate) {
		qualification_date = qualificationDate;
	}
	public String getEquip_id() {
		return equip_id;
	}
	public void setEquip_id(String equip_id) {
		this.equip_id = equip_id;
	}
	public String getPlan_date() {
		return plan_date;
	}
	public void setPlan_date(String plan_date) {
		this.plan_date = plan_date;
	}
	public String getVentype() {
		return ventype;
	}
	public void setVentype(String ventype) {
		this.ventype = ventype;
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
	public String getEquip() {
		return equip;
	}
	public void setEquip(String equip) {
		this.equip = equip;
	}
	public String getModels() {
		return models;
	}
	public void setModels(String models) {
		this.models = models;
	}
	public String getProducer() {
		return producer;
	}
	public void setProducer(String producer) {
		this.producer = producer;
	}
	public String getDarrive() {
		return darrive;
	}
	public void setDarrive(String darrive) {
		this.darrive = darrive;
	}
	public String getIdowner() {
		return idowner;
	}
	public void setIdowner(String idowner) {
		this.idowner = idowner;
	}
	public String getIddep() {
		return iddep;
	}
	public void setIddep(String iddep) {
		this.iddep = iddep;
	}
	public String getSflag() {
		return sflag;
	}
	public void setSflag(String sflag) {
		this.sflag = sflag;
	}
}
