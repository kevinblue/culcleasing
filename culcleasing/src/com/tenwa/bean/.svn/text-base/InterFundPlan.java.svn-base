package com.tenwa.bean;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import com.tenwa.culc.calc.util.FieldName;
import com.tenwa.culc.calc.util.Scale;


/**
 * 
 * @author czk
 * @date 2016-8-9
 * @info 项目资金计划
 * @Copyright 
 * Tenwa
 */
@Entity
@FieldName(name = "项目资金计划")
@Table(name="INTER_FUND_PLAN")
public class InterFundPlan {
	@Id
    @GeneratedValue(generator = "paymentableGenerator")     
    @GenericGenerator(name = "paymentableGenerator", strategy = "uuid") 
    @Column(length=32)
	private String id;
	
	@FieldName(name="公司名称")
	@Column(name="COMPANY_NAME")
	private String company_name;
	
	@FieldName(name="合同编号")
	@Column(name="CONTRACT_ID")
	private String contract_id;
	
	@FieldName(name="项目编号")
	@Column(name="PROJ_ID")
	private String proj_id;
	
	@FieldName(name="项目状态")
	@Column(name="PROJ_STATUS")
	private String proj_status;

	@FieldName(name="费用编号")
	@Column(name="PAYMENT_ID")
	private String payment_id;
	
	@FieldName(name="资金计划ID")
	@Column(name="PLAN_ID")
	private Integer plan_id;
	
	@FieldName(name="收款银行")
	@Column(name="ACCOUNT_BANK")
	private String account_bank;
	
	@FieldName(name="收款账号")
	@Column(name="ACCOUNT_NO")
	private String account_no;

	@FieldName(name="帐户名称")
	@Column(name="ACCOUNT")
	private String account;
	
	@FieldName(name="南北编码")
	@Column(name="SUBJECT_NO")
	private String subject_no;
	
	@FieldName(name="收付类型")
	@Column(name="ITEM_METHOD")
	private String item_method;

	@FieldName(name="费用类型")
	@Column(name="FEE_TYPE")
	private String fee_type;
	
	@FieldName(name="费用名称")
	@Column(name="FEE_NAME")
	private String fee_name;

	@FieldName(name="计划日期")
	@Column(name="PLAN_DATE")
	private String plan_date; 
	
	@FieldName(name = "计划金额")
	@Column(name="PLAN_MONEY", precision = 22,scale = Scale.DEFAULT)
	private BigDecimal plan_money;
	
	@FieldName(name="是否上报")
	@Column(name="IS_SB")
	private String is_sb;
	
	@FieldName(name="币种")
	@Column(name="CURRENCY_TYPE")
	private String currency_type;

	@FieldName(name="核销状态")
	@Column(name="PLAN_STATUS")
	private String plan_status;
	
	@FieldName(name="备用字段1")
	@Column(name="SPARE_COLUMN1")
	private String spareColumn1;
	
	@FieldName(name="备用字段2")
	@Column(name="SPARE_COLUMN2")
	private String spareColumn2;
	
	@FieldName(name="备用字段3")
	@Column(name="SPARE_COLUMN3")
	private String spareColumn3;
	
	@FieldName(name="备用字段4")
	@Column(name="SPARE_COLUMN4")
	private String spareColumn4;
	
	@FieldName(name="备用字段5")
	@Column(name="SPARE_COLUMN5")
	private String spareColumn5;
	
	@FieldName(name="用友读取标志")
	@Column(name="READ_FLAG")
	private Integer readFlag;
	
	@FieldName(name="用友读取时间")
	@Column(name="READ_DATE")
	private String readDate;
	
	@FieldName(name="用友读取失败标记")
	@Column(name = "READ_MEMO", length = 1000)
	private String readMemo;
	
	@FieldName(name="创建人")
	@Column(name="CREATOR")
	private String creator;
	
	@FieldName(name="创建日期")
	@Column(name="CREATE_DATE")
	private String createDate;
	
	@FieldName(name="修改人")
	@Column(name="MODIFICATOR")
	private String modificator;

	@FieldName(name="修改日期")
	@Column(name="MODIFY_DATE")
	private String modifyDate;
	
	@FieldName(name="是否有效")
	@Column(name="FLAG")
	private Integer flag;
	
	@FieldName(name="操作ID")
	@Column(name="OPER_ID")
	private String OPER_ID;
  
	public String getPlan_date() {
		return plan_date;
	}

	public void setPlan_date(String plan_date) {
		this.plan_date = plan_date;
	}

	public String getOPER_ID() {
		return OPER_ID;
	}

	public void setOPER_ID(String oPER_ID) {
		OPER_ID = oPER_ID;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getContract_id() {
		return contract_id;
	}

	public void setContract_id(String contract_id) {
		this.contract_id = contract_id;
	}

	public String getProj_id() {
		return proj_id;
	}

	public void setProj_id(String proj_id) {
		this.proj_id = proj_id;
	}

	public String getProj_status() {
		return proj_status;
	}

	public void setProj_status(String proj_status) {
		this.proj_status = proj_status;
	}

	public String getPayment_id() {
		return payment_id;
	}

	public void setPayment_id(String payment_id) {
		this.payment_id = payment_id;
	}

	public Integer getPlan_id() {
		return plan_id;
	}

	public void setPlan_id(Integer plan_id) {
		this.plan_id = plan_id;
	}

	public String getAccount_bank() {
		return account_bank;
	}

	public void setAccount_bank(String account_bank) {
		this.account_bank = account_bank;
	}

	public String getAccount_no() {
		return account_no;
	}

	public void setAccount_no(String account_no) {
		this.account_no = account_no;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getSubject_no() {
		return subject_no;
	}

	public void setSubject_no(String subject_no) {
		this.subject_no = subject_no;
	}

	public String getItem_method() {
		return item_method;
	}

	public void setItem_method(String item_method) {
		this.item_method = item_method;
	}

	public String getFee_type() {
		return fee_type;
	}

	public void setFee_type(String fee_type) {
		this.fee_type = fee_type;
	}

	public String getFee_name() {
		return fee_name;
	}

	public void setFee_name(String fee_name) {
		this.fee_name = fee_name;
	}



	public BigDecimal getPlan_money() {
		return plan_money;
	}

	public void setPlan_money(BigDecimal plan_money) {
		this.plan_money = plan_money;
	}

	public String getIs_sb() {
		return is_sb;
	}

	public void setIs_sb(String is_sb) {
		this.is_sb = is_sb;
	}

	public String getCurrency_type() {
		return currency_type;
	}

	public void setCurrency_type(String currency_type) {
		this.currency_type = currency_type;
	}

	public String getPlan_status() {
		return plan_status;
	}

	public void setPlan_status(String plan_status) {
		this.plan_status = plan_status;
	}

	public String getSpareColumn1() {
		return spareColumn1;
	}

	public void setSpareColumn1(String spareColumn1) {
		this.spareColumn1 = spareColumn1;
	}

	public String getSpareColumn2() {
		return spareColumn2;
	}

	public void setSpareColumn2(String spareColumn2) {
		this.spareColumn2 = spareColumn2;
	}

	public String getSpareColumn3() {
		return spareColumn3;
	}

	public void setSpareColumn3(String spareColumn3) {
		this.spareColumn3 = spareColumn3;
	}

	public String getSpareColumn4() {
		return spareColumn4;
	}

	public void setSpareColumn4(String spareColumn4) {
		this.spareColumn4 = spareColumn4;
	}

	public String getSpareColumn5() {
		return spareColumn5;
	}

	public void setSpareColumn5(String spareColumn5) {
		this.spareColumn5 = spareColumn5;
	}

	public Integer getReadFlag() {
		return readFlag;
	}

	public void setReadFlag(Integer readFlag) {
		this.readFlag = readFlag;
	}

	public String getReadDate() {
		return readDate;
	}

	public void setReadDate(String readDate) {
		this.readDate = readDate;
	}

	public String getReadMemo() {
		return readMemo;
	}

	public void setReadMemo(String readMemo) {
		this.readMemo = readMemo;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getModificator() {
		return modificator;
	}

	public void setModificator(String modificator) {
		this.modificator = modificator;
	}

	public String getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}

	public Integer getFlag() {
		return flag;
	}

	public void setFlag(Integer flag) {
		this.flag = flag;
	}

	public String getCompany_name() {
		return company_name;
	}

	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}

	
}
