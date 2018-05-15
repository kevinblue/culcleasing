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
 * @info ��ͬ������Ϣ��
 * @Copyright 
 * Tenwa
 */
@Entity
@FieldName(name = "��ͬ������Ϣ��")
@Table(name="INTER_FINA_BEGIN_INFO")
public class InterFinaBeginInfo {
	@Id
    @GeneratedValue(generator = "paymentableGenerator")     
    @GenericGenerator(name = "paymentableGenerator", strategy = "uuid") 
    @Column(length=32)
	private String id;
	
	@FieldName(name="��ͬ���")
	@Column(name="CONTRACT_ID")
	private String contract_id;
	
	@FieldName(name="״̬")
	@Column(name="PROJ_STATUS")
	private String projStatus;
	
	
	@FieldName(name="������")
	@Column(name="BEGIN_ID")
	private String begin_id;
	
	@FieldName(name="�걨����")
	@Column(name="BANK")
	private String bank;
	
	@FieldName(name="������")
	@Column(name="BANK_STR")
	private String bank_str;
	
/*	@FieldName(name="�Ƿ����")
	@Column(name="IS_GEN_TABLE")
	private Integer isGenTable;
	
	@FieldName(name="�Ƿ�ؿ�")
	@Column(name="IS_PAYMENT")
	private Integer isPayment;
	
	@FieldName(name="�ʲ�״̬")
	@Column(name="ASSET_STATUS")
	private Integer assetStatus;*/
	
	@FieldName(name="��������")
	@Column(name="LEASE_TERM")
	private Integer lease_term;
	
	@FieldName(name="�����㷽ʽ")
	@Column(name="SETTLE_METHOD")
	private String settle_method;
	
	@FieldName(name="��������")
	@Column(name="YEAR_RATE", precision = 22,scale = Scale.DEFAULT)
	private BigDecimal year_rate;
	
	@FieldName(name = "�ڲ�����IRR")
	@Column(name="IRR", precision = 22,scale = Scale.DEFAULT)
	private BigDecimal IRR;
	
	@FieldName(name = "���IRR")
	@Column(name="STANDARDIRR", precision = 22,scale = Scale.DEFAULT)
	private BigDecimal standardIRR;
	
	@FieldName(name="������")
	@Column(name="RENT_START_DATE")
	private String rentStartDate;
	
	@FieldName(name = "�����ʲ���ֵ")
	@Column(name="EQUIP_AMT", precision = 22,scale = Scale.DEFAULT)
	private BigDecimal equipAmt;
	
	@FieldName(name = "���޳ɱ�")
	@Column(name="LEASE_MONEY", precision = 22,scale = Scale.DEFAULT)
	private BigDecimal leaseMoney;
	
	@FieldName(name="��Ϣ��������")
	@Column(name="FREE_DEFA_INTER_DAY")
	private Integer free_defa_inter_day;
	
	@FieldName(name="�����ֶ�1")
	@Column(name="SPARE_COLUMN1")
	private String spareColumn1;
	
	@FieldName(name="�����ֶ�2")
	@Column(name="SPARE_COLUMN2")
	private String spareColumn2;
	
	@FieldName(name="�����ֶ�3")
	@Column(name="SPARE_COLUMN3")
	private String spareColumn3;
	
	@FieldName(name="�����ֶ�4")
	@Column(name="SPARE_COLUMN4")
	private String spareColumn4;
	
	@FieldName(name="�����ֶ�5")
	@Column(name="SPARE_COLUMN5")
	private String spareColumn5;
	
	@FieldName(name="���Ѷ�ȡ��־")
	@Column(name="READ_FLAG")
	private Integer readFlag;
	
	@FieldName(name="���Ѷ�ȡʱ��")
	@Column(name="READ_DATE")
	private String readDate;
	
	@FieldName(name="���Ѷ�ȡʧ�ܱ��")
	@Column(name = "READ_MEMO", length = 1000)
	private String readMemo;
	
	@FieldName(name="������")
	@Column(name="CREATOR")
	private String creator;
	
	@FieldName(name="��������")
	@Column(name="CREATE_DATE")
	private String createDate;
	
	@FieldName(name="�޸���")
	@Column(name="MODIFICATOR")
	private String modificator;

	@FieldName(name="�޸�����")
	@Column(name="MODIFY_DATE")
	private String modifyDate;
	
	@FieldName(name="�Ƿ���Ч")
	@Column(name="FLAG")
	private Integer flag;
	
	@FieldName(name="����ID")
	@Column(name="OPER_ID")
	private String OPER_ID;
	
	@FieldName(name = "��Ϣ������")
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
