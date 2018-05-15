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
 * @info ��ͬ����������
 * @Copyright 
 * Tenwa
 */
@Entity
@FieldName(name = "��ͬ����������")    
@Table(name="INTER_FINA_CONTRACT_CONDITION")
public class InterFinaContractCondition {
	@Id
    @GeneratedValue(generator = "paymentableGenerator")     
    @GenericGenerator(name = "paymentableGenerator", strategy = "uuid") 
    @Column(length=32)
	private String id;
	
	@FieldName(name="��ͬ���")
	@Column(name="CONTRACT_ID")
	private String contract_id;
	
	@FieldName(name="ERP��Ŀ���")
	@Column(name="PROJ_ID")
	private String projId;
	
	
	
	@FieldName(name = "���������޳ɱ�")
	@Column(name="YQZ_LEASE_MONEY", precision = 22,scale = Scale.DEFAULT)
	private BigDecimal yqzLeaseMoney;
	
	
	@FieldName(name = "�����ʲ���ֵ")
	@Column(name="EQUIP_AMT", precision = 22,scale = Scale.DEFAULT)
	private BigDecimal equipAmt;
	
	
	@FieldName(name = "���޳ɱ�")
	@Column(name="LEASE_MONEY", precision = 22,scale = Scale.DEFAULT)
	private BigDecimal leaseMoney;
	
	
	
	@FieldName(name = "ʵ���ʽ�֧��")
	@Column(name="FACT_FUND_PAY", precision = 22,scale = Scale.DEFAULT)
	private BigDecimal factFundPay;
	
	
	@FieldName(name = "�����")
	@Column(name="MANAGEMENT_FEE", precision = 22,scale = Scale.DEFAULT)
	private BigDecimal managementFee;
	
	
	@FieldName(name = "���޷����")
	@Column(name="HANDLING_CHARGE", precision = 22,scale = Scale.DEFAULT)
	private BigDecimal handlingCharge;
	
	
	@FieldName(name = "��֤��")
	@Column(name="CAUTION_MONEY", precision = 22,scale = Scale.DEFAULT)
	private BigDecimal cautionMoney;
	
	@FieldName(name = "��֤�����")
	@Column(name="CAUTION_MONEY_RATIO", precision = 22,scale = Scale.DEFAULT)
	private BigDecimal cautionMoneyRatio;
	
	
	@FieldName(name = "�׸���")
	@Column(name="FIRST_PAYMENT", precision = 22,scale = Scale.DEFAULT)
	private BigDecimal firstPayment;
	
	

	@FieldName(name = "�׸������")
	@Column(name="FIRST_PAYMENT_RATIO", precision = 22,scale = Scale.DEFAULT)
	private BigDecimal firstPaymentRatio;
	
	
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
	
	
	@FieldName(name="����ID")
	@Column(name="OPER_ID")
	private String OPER_ID;
	
	
	@FieldName(name = "��������")
	@Column(name="YEAR_RATE", precision = 22,scale = Scale.DEFAULT)
	private BigDecimal year_rate;
	

	@FieldName(name="�����ֶ�6")
	@Column(name="SPARE_COLUMN6")
	private String spareColumn6;
	
	@FieldName(name="�����ֶ�7")
	@Column(name="SPARE_COLUMN7")
	private String spareColumn7;
	
	@FieldName(name="�����ֶ�8")
	@Column(name="SPARE_COLUMN8")
	private String spareColumn8;
	
	@FieldName(name="�����ֶ�9")
	@Column(name="SPARE_COLUMN9")
	private String spareColumn9;
	
	@FieldName(name="�����ֶ�10")
	@Column(name="SPARE_COLUMN10")
	private String spareColumn10;


	@FieldName(name="��Ŀ״̬")
	@Column(name="PROJ_STATUS")
	private String projStatus;
	
	
	@FieldName(name = "irr")
	@Column(name="irr", precision = 22,scale = Scale.DEFAULT)
	private BigDecimal irr;
	
	@FieldName(name = "���irr")
	@Column(name="STANDARD_IRR", precision = 22,scale = Scale.DEFAULT)
	private BigDecimal standardirr;
	
	
	@FieldName(name="��������")
	@Column(name="LEASE_TERM")
	private Integer leaseterm;

	@FieldName(name="�����㷽ʽ")
	@Column(name="SETTLE_METHOD")
	private String settlemethod;
	
	
	public BigDecimal getIrr() {
		return irr;
	}

	public void setIrr(BigDecimal irr) {
		this.irr = irr;
	}

	public BigDecimal getStandardirr() {
		return standardirr;
	}

	public void setStandardirr(BigDecimal standardirr) {
		this.standardirr = standardirr;
	}

	public Integer getLeaseterm() {
		return leaseterm;
	}

	public void setLeaseterm(Integer leaseterm) {
		this.leaseterm = leaseterm;
	}

	public String getSettlemethod() {
		return settlemethod;
	}

	public void setSettlemethod(String settlemethod) {
		this.settlemethod = settlemethod;
	}

	public String getProjId() {
		return projId;
	}

	public void setProjId(String projId) {
		this.projId = projId;
	}


	public BigDecimal getYear_rate() {
		return year_rate;
	}

	public void setYear_rate(BigDecimal year_rate) {
		this.year_rate = year_rate;
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

	public BigDecimal getYqzLeaseMoney() {
		return yqzLeaseMoney;
	}

	public void setYqzLeaseMoney(BigDecimal yqzLeaseMoney) {
		this.yqzLeaseMoney = yqzLeaseMoney;
	}

	public BigDecimal getFactFundPay() {
		return factFundPay;
	}

	public void setFactFundPay(BigDecimal factFundPay) {
		this.factFundPay = factFundPay;
	}

	public BigDecimal getManagementFee() {
		return managementFee;
	}

	public void setManagementFee(BigDecimal managementFee) {
		this.managementFee = managementFee;
	}

	public BigDecimal getHandlingCharge() {
		return handlingCharge;
	}

	public void setHandlingCharge(BigDecimal handlingCharge) {
		this.handlingCharge = handlingCharge;
	}

	public BigDecimal getCautionMoney() {
		return cautionMoney;
	}

	public void setCautionMoney(BigDecimal cautionMoney) {
		this.cautionMoney = cautionMoney;
	}

	public BigDecimal getCautionMoneyRatio() {
		return cautionMoneyRatio;
	}

	public void setCautionMoneyRatio(BigDecimal cautionMoneyRatio) {
		this.cautionMoneyRatio = cautionMoneyRatio;
	}

	public BigDecimal getFirstPayment() {
		return firstPayment;
	}

	public void setFirstPayment(BigDecimal firstPayment) {
		this.firstPayment = firstPayment;
	}

	public BigDecimal getFirstPaymentRatio() {
		return firstPaymentRatio;
	}

	public void setFirstPaymentRatio(BigDecimal firstPaymentRatio) {
		this.firstPaymentRatio = firstPaymentRatio;
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
	
	public String getProjStatus() {
		return projStatus;
	}

	public void setProjStatus(String projStatus) {
		this.projStatus = projStatus;
	}

	public String getSpareColumn6() {
		return spareColumn6;
	}

	public void setSpareColumn6(String spareColumn6) {
		this.spareColumn6 = spareColumn6;
	}

	public String getSpareColumn7() {
		return spareColumn7;
	}

	public void setSpareColumn7(String spareColumn7) {
		this.spareColumn7 = spareColumn7;
	}

	public String getSpareColumn8() {
		return spareColumn8;
	}

	public void setSpareColumn8(String spareColumn8) {
		this.spareColumn8 = spareColumn8;
	}

	public String getSpareColumn9() {
		return spareColumn9;
	}

	public void setSpareColumn9(String spareColumn9) {
		this.spareColumn9 = spareColumn9;
	}

	public String getSpareColumn10() {
		return spareColumn10;
	}

	public void setSpareColumn10(String spareColumn10) {
		this.spareColumn10 = spareColumn10;
	}
  
}
