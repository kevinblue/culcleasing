package com.tenwa.culc.bean;

/**
 * 
 * @author 崔天帅
 * @date 2013-6-12下午04:33:10
 * @info 供应商银行相关信息
 * @Copyright 
 * Tenwa
 */
public class ContractPlanBean {
	private String contract_id; //合同编号
	private String pay_obj;		//客户Id
	private String pay_bank_name;//付款银行
	private String pay_bank_no;  //付款银行账号
	private String projname;     //项目名称
	private String proj_id;      //项目编号
	private String id_owner;//项目经理
	private String id_dept;//部门
	private String id_person;//供应商联系人ID
	private String phone;	//供应商联系人电话
	public String getId_owner() {
		return id_owner;
	}
	public String getId_person() {
		return id_person;
	}
	public void setId_person(String id_person) {
		this.id_person = id_person;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public void setId_owner(String id_owner) {
		this.id_owner = id_owner;
	}
	public String getId_dept() {
		return id_dept;
	}
	public void setId_dept(String id_dept) {
		this.id_dept = id_dept;
	}
	public String getPay_bank_no() {
		return pay_bank_no;
	}
	public void setPay_bank_no(String pay_bank_no) {
		this.pay_bank_no = pay_bank_no;
	}
	public String getProjname() {
		return projname;
	}
	public void setProjname(String projname) {
		this.projname = projname;
	}
	public String getProj_id() {
		return proj_id;
	}
	public void setProj_id(String proj_id) {
		this.proj_id = proj_id;
	}
	public String getContract_id() {
		return contract_id;
	}
	public void setContract_id(String contract_id) {
		this.contract_id = contract_id;
	}
	public String getPay_obj() {
		return pay_obj;
	}
	public void setPay_obj(String pay_obj) {
		this.pay_obj = pay_obj;
	}
	public String getPay_bank_name() {
		return pay_bank_name;
	}
	public void setPay_bank_name(String pay_bank_name) {
		this.pay_bank_name = pay_bank_name;
	}
}
