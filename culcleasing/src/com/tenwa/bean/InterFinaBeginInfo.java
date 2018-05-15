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
 * @info 合同起租信息表
 * @Copyright 
 * Tenwa
 */
@Entity
@FieldName(name = "合同起租信息表")
@Table(name="INTER_FINA_BEGIN_INFO")
public class InterFinaBeginInfo {
	@Id
    @GeneratedValue(generator = "paymentableGenerator")     
    @GenericGenerator(name = "paymentableGenerator", strategy = "uuid") 
    @Column(length=32)
	private String id;
	
	@FieldName(name="合同编号")
	@Column(name="CONTRACT_ID")
	private String contract_id;
	
	@FieldName(name="状态")
	@Column(name="PROJ_STATUS")
	private String projStatus;
	
	
	@FieldName(name="起租编号")
	@Column(name="BEGIN_ID")
	private String begin_id;
	
	@FieldName(name="申报银行")
	@Column(name="BANK")
	private String bank;
	
	@FieldName(name="拟银行")
	@Column(name="BANK_STR")
	private String bank_str;
	
/*	@FieldName(name="是否出表")
	@Column(name="IS_GEN_TABLE")
	private Integer isGenTable;
	
	@FieldName(name="是否回款")
	@Column(name="IS_PAYMENT")
	private Integer isPayment;
	
	@FieldName(name="资产状态")
	@Column(name="ASSET_STATUS")
	private Integer assetStatus;*/
	
	@FieldName(name="租赁年限")
	@Column(name="LEASE_TERM")
	private Integer lease_term;
	
	@FieldName(name="租金测算方式")
	@Column(name="SETTLE_METHOD")
	private String settle_method;
	
	@FieldName(name="租赁利率")
	@Column(name="YEAR_RATE", precision = 22,scale = Scale.DEFAULT)
	private BigDecimal year_rate;
	
	@FieldName(name = "内部收益IRR")
	@Column(name="IRR", precision = 22,scale = Scale.DEFAULT)
	private BigDecimal IRR;
	
	@FieldName(name = "达标IRR")
	@Column(name="STANDARDIRR", precision = 22,scale = Scale.DEFAULT)
	private BigDecimal standardIRR;
	
	@FieldName(name="起租日")
	@Column(name="RENT_START_DATE")
	private String rentStartDate;
	
	@FieldName(name = "租赁资产价值")
	@Column(name="EQUIP_AMT", precision = 22,scale = Scale.DEFAULT)
	private BigDecimal equipAmt;
	
	@FieldName(name = "租赁成本")
	@Column(name="LEASE_MONEY", precision = 22,scale = Scale.DEFAULT)
	private BigDecimal leaseMoney;
	
	@FieldName(name="罚息减免天数")
	@Column(name="FREE_DEFA_INTER_DAY")
	private Integer free_defa_inter_day;
	
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
	
	@FieldName(name = "罚息日利率")
	@Column(name="pena_rate", precision = 22,scale = Scale.DEFAULT)
	private BigDecimal penarate;
	

	public BigDecimal getPenarate() {
		return penarate;
	}

	public void setPenarate(BigDecimal penarate) {
		this.penarate = penarate;
	}


	public BigDecimal getYear_rate() {
		return year_rate;
	}

	public void setYear_rate(BigDecimal year_rate) {
		this.year_rate = year_rate;
	}

	public String getProjStatus() {
		return projStatus;
	}

	public void setProjStatus(String projStatus) {
		this.projStatus = projStatus;
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

	public String getBegin_id() {
		return begin_id;
	}

	public void setBegin_id(String begin_id) {
		this.begin_id = begin_id;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getBank_str() {
		return bank_str;
	}

	public void setBank_str(String bank_str) {
		this.bank_str = bank_str;
	}


	public Integer getLease_term() {
		return lease_term;
	}

	public void setLease_term(Integer lease_term) {
		this.lease_term = lease_term;
	}

	public String getSettle_method() {
		return settle_method;
	}

	public void setSettle_method(String settle_method) {
		this.settle_method = settle_method;
	}

	public BigDecimal getIRR() {
		return IRR;
	}

	public void setIRR(BigDecimal iRR) {
		IRR = iRR;
	}

	public BigDecimal getStandardIRR() {
		return standardIRR;
	}

	public void setStandardIRR(BigDecimal standardIRR) {
		this.standardIRR = standardIRR;
	}

	public String getRentStartDate() {
		return rentStartDate;
	}

	public void setRentStartDate(String rentStartDate) {
		this.rentStartDate = rentStartDate;
	}

	public BigDecimal getEquipAmt() {
		return equipAmt;
	}

	public void setEquipAmt(BigDecimal equipAmt) {
		this.equipAmt = equipAmt;
	}

	public BigDecimal getLeaseMoney() {
		return leaseMoney;
	}

	public void setLeaseMoney(BigDecimal leaseMoney) {
		this.leaseMoney = leaseMoney;
	}

	public Integer getFree_defa_inter_day() {
		return free_defa_inter_day;
	}

	public void setFree_defa_inter_day(Integer free_defa_inter_day) {
		this.free_defa_inter_day = free_defa_inter_day;
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

	
}
