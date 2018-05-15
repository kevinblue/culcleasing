/**
 * com.tenwa.culc.bean
 */
package com.tenwa.culc.bean;
/**
 * 医疗管理商务条件信息(起租)
 * 
 * @author Jaffe
 * 
 * Date:Feb 6, 2012 5:09:46 PM Email:JaffeHe@hotmail.com
 */
public class BeginInfoMediBean {
	private int id;// 主键
	private String doc_id;// Doc_id Domino
	private String contract_id;// 合同id
	private String begin_id; //起租ID
	
	private String rent_start_date;// 起租日期
	private String start_date;// 第一期租金日
	private String income_day;// 每月偿付日
	private String income_number;// 还租次数
	private String income_number_year;// 付租方式 月付、季付等
	private String lease_term;// 租赁期限（月）
	private String begin_order_index;
	
	//以下都不需要
	private String equip_amt;// 设备金额
	private String currency;// 货币类型
	private String lease_money;// 租赁本金
	private String first_payment;// 首付款
	private String caution_money;// 保证金
	
	private String caution_deduction_money;// 保证金抵扣金额
	private String actual_fund;// 净融资额

	private String handling_charge;// 手续费
	private String management_fee;// 管理费
	private String nominalprice;// 残值收入
	private String return_amt;// 厂商返利
	private String rate_subsidy;// 利息补贴
	private String before_interest;// 租前息
	private String before_interest_type;// 租前息 - 类型 是否算本
	private String discount_rate;// 贴现息
	private String consulting_fee_out;// 咨询费付出
	private String consulting_fee_in;// 咨询费收入
	private String other_income;// 其它收入
	private String other_expenditure;// 其它支出

	private String pena_rate;// 罚息利率
	private String free_defa_inter_day;// 逾期宽限日

	private String insure_type;// 投保方式
	private String insure_pay_type;// 保险收取方式
	private String insure_money;// 保费金额

	private String is_floor;// 是否有保底租金
	private String floor_rent;// 保底租金
	private String manager_pay_type;// manager_pay_type
	private String actual_fund_ratio;

	private String creator;// 创建人
	private String create_date;// 创建时间
	private String modify_date;// 修改人
	private String modificator;// 修改时间

	//sys 2012-2-13新增字段
	private String plan_bank_name; //计划收款银行
	private String plan_bank_no;   //计划收款账号
	
	public String getBegin_order_index() {
		return begin_order_index;
	}
	public void setBegin_order_index(String beginOrderIndex) {
		begin_order_index = beginOrderIndex;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDoc_id() {
		return doc_id;
	}
	public void setDoc_id(String docId) {
		doc_id = docId;
	}
	public String getContract_id() {
		return contract_id;
	}
	public void setContract_id(String contractId) {
		contract_id = contractId;
	}
	public String getBegin_id() {
		return begin_id;
	}
	public void setBegin_id(String beginId) {
		begin_id = beginId;
	}
	public String getEquip_amt() {
		return equip_amt;
	}
	public void setEquip_amt(String equipAmt) {
		equip_amt = equipAmt;
	}
	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	public String getLease_money() {
		return lease_money;
	}
	public void setLease_money(String leaseMoney) {
		lease_money = leaseMoney;
	}
	public String getFirst_payment() {
		return first_payment;
	}
	public void setFirst_payment(String firstPayment) {
		first_payment = firstPayment;
	}
	public String getCaution_money() {
		return caution_money;
	}
	public void setCaution_money(String cautionMoney) {
		caution_money = cautionMoney;
	}
	public String getCaution_deduction_money() {
		return caution_deduction_money;
	}
	public void setCaution_deduction_money(String cautionDeductionMoney) {
		caution_deduction_money = cautionDeductionMoney;
	}
	public String getActual_fund() {
		return actual_fund;
	}
	public void setActual_fund(String actualFund) {
		actual_fund = actualFund;
	}
	public String getHandling_charge() {
		return handling_charge;
	}
	public void setHandling_charge(String handlingCharge) {
		handling_charge = handlingCharge;
	}
	public String getManagement_fee() {
		return management_fee;
	}
	public void setManagement_fee(String managementFee) {
		management_fee = managementFee;
	}
	public String getNominalprice() {
		return nominalprice;
	}
	public void setNominalprice(String nominalprice) {
		this.nominalprice = nominalprice;
	}
	public String getReturn_amt() {
		return return_amt;
	}
	public void setReturn_amt(String returnAmt) {
		return_amt = returnAmt;
	}
	public String getRate_subsidy() {
		return rate_subsidy;
	}
	public void setRate_subsidy(String rateSubsidy) {
		rate_subsidy = rateSubsidy;
	}
	public String getBefore_interest() {
		return before_interest;
	}
	public void setBefore_interest(String beforeInterest) {
		before_interest = beforeInterest;
	}
	public String getBefore_interest_type() {
		return before_interest_type;
	}
	public void setBefore_interest_type(String beforeInterestType) {
		before_interest_type = beforeInterestType;
	}
	public String getDiscount_rate() {
		return discount_rate;
	}
	public void setDiscount_rate(String discountRate) {
		discount_rate = discountRate;
	}
	public String getConsulting_fee_out() {
		return consulting_fee_out;
	}
	public void setConsulting_fee_out(String consultingFeeOut) {
		consulting_fee_out = consultingFeeOut;
	}
	public String getConsulting_fee_in() {
		return consulting_fee_in;
	}
	public void setConsulting_fee_in(String consultingFeeIn) {
		consulting_fee_in = consultingFeeIn;
	}
	public String getOther_income() {
		return other_income;
	}
	public void setOther_income(String otherIncome) {
		other_income = otherIncome;
	}
	public String getOther_expenditure() {
		return other_expenditure;
	}
	public void setOther_expenditure(String otherExpenditure) {
		other_expenditure = otherExpenditure;
	}
	public String getRent_start_date() {
		return rent_start_date;
	}
	public void setRent_start_date(String rentStartDate) {
		rent_start_date = rentStartDate;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String startDate) {
		start_date = startDate;
	}
	public String getIncome_day() {
		return income_day;
	}
	public void setIncome_day(String incomeDay) {
		income_day = incomeDay;
	}
	public String getIncome_number() {
		return income_number;
	}
	public void setIncome_number(String incomeNumber) {
		income_number = incomeNumber;
	}
	public String getIncome_number_year() {
		return income_number_year;
	}
	public void setIncome_number_year(String incomeNumberYear) {
		income_number_year = incomeNumberYear;
	}
	public String getLease_term() {
		return lease_term;
	}
	public void setLease_term(String leaseTerm) {
		lease_term = leaseTerm;
	}
	public String getPena_rate() {
		return pena_rate;
	}
	public void setPena_rate(String penaRate) {
		pena_rate = penaRate;
	}
	public String getFree_defa_inter_day() {
		return free_defa_inter_day;
	}
	public void setFree_defa_inter_day(String freeDefaInterDay) {
		free_defa_inter_day = freeDefaInterDay;
	}
	public String getInsure_type() {
		return insure_type;
	}
	public void setInsure_type(String insureType) {
		insure_type = insureType;
	}
	public String getInsure_pay_type() {
		return insure_pay_type;
	}
	public void setInsure_pay_type(String insurePayType) {
		insure_pay_type = insurePayType;
	}
	public String getInsure_money() {
		return insure_money;
	}
	public void setInsure_money(String insureMoney) {
		insure_money = insureMoney;
	}
	public String getIs_floor() {
		return is_floor;
	}
	public void setIs_floor(String isFloor) {
		is_floor = isFloor;
	}
	public String getFloor_rent() {
		return floor_rent;
	}
	public void setFloor_rent(String floorRent) {
		floor_rent = floorRent;
	}
	public String getManager_pay_type() {
		return manager_pay_type;
	}
	public void setManager_pay_type(String managerPayType) {
		manager_pay_type = managerPayType;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String createDate) {
		create_date = createDate;
	}
	public String getModify_date() {
		return modify_date;
	}
	public void setModify_date(String modifyDate) {
		modify_date = modifyDate;
	}
	public String getModificator() {
		return modificator;
	}
	public void setModificator(String modificator) {
		this.modificator = modificator;
	}
	public String getActual_fund_ratio() {
		return actual_fund_ratio;
	}
	public void setActual_fund_ratio(String actualFundRatio) {
		actual_fund_ratio = actualFundRatio;
	}
	public String getPlan_bank_name() {
		return plan_bank_name;
	}
	public void setPlan_bank_name(String planBankName) {
		plan_bank_name = planBankName;
	}
	public String getPlan_bank_no() {
		return plan_bank_no;
	}
	public void setPlan_bank_no(String planBankNo) {
		plan_bank_no = planBankNo;
	}
	
	
	/**
	 * 
	 */
	public BeginInfoMediBean() {
		super();
		// TODO Auto-generated constructor stub
	}
	/**
	 * @param docId
	 * @param contractId
	 * @param beginId
	 * @param equipAmt
	 * @param currency
	 * @param leaseMoney
	 * @param firstPayment
	 * @param cautionMoney
	 * @param cautionDeductionMoney
	 * @param actualFund
	 * @param handlingCharge
	 * @param managementFee
	 * @param nominalprice
	 * @param returnAmt
	 * @param rateSubsidy
	 * @param beforeInterest
	 * @param beforeInterestType
	 * @param discountRate
	 * @param consultingFeeOut
	 * @param consultingFeeIn
	 * @param otherIncome
	 * @param otherExpenditure
	 * @param rentStartDate
	 * @param startDate
	 * @param incomeDay
	 * @param incomeNumber
	 * @param incomeNumberYear
	 * @param leaseTerm
	 * @param penaRate
	 * @param freeDefaInterDay
	 * @param insureType
	 * @param insurePayType
	 * @param insureMoney
	 * @param isFloor
	 * @param floorRent
	 * @param managerPayType
	 * @param creator
	 * @param createDate
	 * @param modifyDate
	 * @param modificator
	 * @param actualFundRatio
	 * @param planBankName
	 * @param planBankNo
	 */
	public BeginInfoMediBean(String docId, String contractId, String beginId,
			String equipAmt, String currency, String leaseMoney,
			String firstPayment, String cautionMoney,
			String cautionDeductionMoney, String actualFund,
			String handlingCharge, String managementFee, String nominalprice,
			String returnAmt, String rateSubsidy, String beforeInterest,
			String beforeInterestType, String discountRate,
			String consultingFeeOut, String consultingFeeIn,
			String otherIncome, String otherExpenditure, String rentStartDate,
			String startDate, String incomeDay, String incomeNumber,
			String incomeNumberYear, String leaseTerm, String penaRate,
			String freeDefaInterDay, String insureType, String insurePayType,
			String insureMoney, String isFloor, String floorRent,
			String managerPayType, String creator, String createDate,
			String modifyDate, String modificator, String actualFundRatio,
			String planBankName, String planBankNo) {
		super();
		doc_id = docId;
		contract_id = contractId;
		begin_id = beginId;
		equip_amt = equipAmt;
		this.currency = currency;
		lease_money = leaseMoney;
		first_payment = firstPayment;
		caution_money = cautionMoney;
		caution_deduction_money = cautionDeductionMoney;
		actual_fund = actualFund;
		handling_charge = handlingCharge;
		management_fee = managementFee;
		this.nominalprice = nominalprice;
		return_amt = returnAmt;
		rate_subsidy = rateSubsidy;
		before_interest = beforeInterest;
		before_interest_type = beforeInterestType;
		discount_rate = discountRate;
		consulting_fee_out = consultingFeeOut;
		consulting_fee_in = consultingFeeIn;
		other_income = otherIncome;
		other_expenditure = otherExpenditure;
		rent_start_date = rentStartDate;
		start_date = startDate;
		income_day = incomeDay;
		income_number = incomeNumber;
		income_number_year = incomeNumberYear;
		lease_term = leaseTerm;
		pena_rate = penaRate;
		free_defa_inter_day = freeDefaInterDay;
		insure_type = insureType;
		insure_pay_type = insurePayType;
		insure_money = insureMoney;
		is_floor = isFloor;
		floor_rent = floorRent;
		manager_pay_type = managerPayType;
		this.creator = creator;
		create_date = createDate;
		modify_date = modifyDate;
		this.modificator = modificator;
		actual_fund_ratio = actualFundRatio;
		plan_bank_name = planBankName;
		plan_bank_no = planBankNo;
	}
	
	
}
