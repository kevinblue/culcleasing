/**
 * com.tenwa.culc.bean
 */
package com.tenwa.culc.bean;

/**
 * 起租信息Bean
 * 
 * @author Jaffe
 * 
 * Date:Jul 25, 2011 7:40:05 PM Email:JaffeHe@hotmail.com
 */
public class BeginInfoBean {
	private int id;// 主键
	private String doc_id;// Doc_id Domino
	private String contract_id;// 合同id
	private String begin_id;// 起租id
	private String proj_id;// 项目id
	private String equip_amt;// 设备金额
	private String currency;// 货币类型
	private String lease_money;// 租赁本金
	private String actual_fund;// 净融资额
	private String assets_value;// 资产余值
	
	private String income_number;// 还租次数
	private String income_number_year;// 付租方式 月付、季付等
	private String lease_term;// 租赁期限（月）
	private String settle_method;// 租金计算方法
	private String period_type;// 付租类型先付/后付
	private String rate_float_type;// 利率浮动类型
	private String rate_float_amt;// 利率调整值

	private String year_rate;// 租赁年利率
	private String pena_rate;// 罚息利率
	private String start_date;// 预计起租日
	private String income_day;// 每月偿付日
	private String end_date;// 预计结束日

	private String plan_irr;// 年内部收益率IRR,预计IRR
	private String free_defa_inter_day;// 逾期宽限日
	private String total_amt;// 租赁合同总金额 -- 租金总额
	private String amt_return;// 设备回购
	private String apply_contract_number;// 适用合同份数

	private String adjust_style;// 调息方式
	private String into_batch;// 是否批量调息

	private String ratio_param;// 本金公比、租金公比、本金公差、租金公差
	private String rent_start_date;// 起租日期
	private String is_open;// 利率是否对外公开
	private String plan_bank_name;// 计划收款银行
	private String plan_bank_no;// 计划收款账号
	private String invoice_type;// 租金开票方式

	private String creator;// 创建人
	private String create_date;// 创建时间
	private String modify_date;// 修改人
	private String modificator;// 修改时间
	// --0929新增--
	private String begin_order_index;// 起租序列号
	// --1018新增--
	private String fact_irr;// 实际IRR
	//SYS2012-2-3新增
	private String factoring;//是否保理
	//2012-9-12新增税种
	private String tax_type;
	//2012-11-20新增税种
	private String tax_type_invoice;

	public String getTax_type() {
		return tax_type;
	}

	public void setTax_type(String tax_type) {
		this.tax_type = tax_type;
	}

	public String getFactoring() {
		return factoring;
	}

	public void setFactoring(String factoring) {
		this.factoring = factoring;
	}

	/**
	 * @return the fact_irr
	 */
	public String getFact_irr() {
		return fact_irr;
	}

	/**
	 * @param fact_irr
	 *            the fact_irr to set
	 */
	public void setFact_irr(String fact_irr) {
		this.fact_irr = fact_irr;
	}

	/**
	 * @return the begin_order_index
	 */
	public String getBegin_order_index() {
		return begin_order_index;
	}

	/**
	 * @param begin_order_index
	 *            the begin_order_index to set
	 */
	public void setBegin_order_index(String begin_order_index) {
		this.begin_order_index = begin_order_index;
	}

	/**
	 * 无参构造函数
	 */
	public BeginInfoBean() {
		super();
	}

	/**
	 * @param doc_id
	 * @param contract_id
	 * @param begin_id
	 * @param proj_id
	 * @param equip_amt
	 * @param currency
	 * @param lease_money
	 * @param actual_fund
	 * @param assets_value
	 * @param income_number
	 * @param income_number_year
	 * @param lease_term
	 * @param settle_method
	 * @param period_type
	 * @param rate_float_type
	 * @param rate_float_amt
	 * @param year_rate
	 * @param pena_rate
	 * @param start_date
	 * @param income_day
	 * @param end_date
	 * @param plan_irr
	 * @param free_defa_inter_day
	 * @param adjust_style
	 * @param into_batch
	 * @param ratio_param
	 * @param rent_start_date
	 * @param is_open
	 * @param plan_bank_name
	 * @param plan_bank_no
	 * @param creator
	 * @param create_date
	 * @param modify_date
	 * @param modificator
	 */
	public BeginInfoBean(String doc_id, String contract_id, String begin_id,
			String equip_amt, String currency, String lease_money,
			String actual_fund, String assets_value, String income_number,
			String income_number_year, String lease_term, String settle_method,
			String period_type, String rate_float_type, String rate_float_amt,
			String year_rate, String pena_rate, String start_date,
			String income_day, String end_date, String plan_irr,
			String free_defa_inter_day, String adjust_style, String into_batch,
			String ratio_param, String rent_start_date, String is_open,
			String plan_bank_name, String plan_bank_no, String creator,
			String create_date, String modify_date, String modificator) {
		super();
		this.doc_id = doc_id;
		this.contract_id = contract_id;
		this.begin_id = begin_id;
		this.equip_amt = equip_amt;
		this.currency = currency;
		this.lease_money = lease_money;
		this.actual_fund = actual_fund;
		this.assets_value = assets_value;
		this.income_number = income_number;
		this.income_number_year = income_number_year;
		this.lease_term = lease_term;
		this.settle_method = settle_method;
		this.period_type = period_type;
		this.rate_float_type = rate_float_type;
		this.rate_float_amt = rate_float_amt;
		this.year_rate = year_rate;
		this.pena_rate = pena_rate;
		this.start_date = start_date;
		this.income_day = income_day;
		this.end_date = end_date;
		this.plan_irr = plan_irr;
		this.free_defa_inter_day = free_defa_inter_day;
		this.adjust_style = adjust_style;
		this.into_batch = into_batch;
		this.ratio_param = ratio_param;
		this.rent_start_date = rent_start_date;
		this.is_open = is_open;
		this.plan_bank_name = plan_bank_name;
		this.plan_bank_no = plan_bank_no;
		this.creator = creator;
		this.create_date = create_date;
		this.modify_date = modify_date;
		this.modificator = modificator;
	}

	/**
	 * @return the invoice_type
	 */
	public String getInvoice_type() {
		return invoice_type;
	}

	/**
	 * @param invoice_type
	 *            the invoice_type to set
	 */
	public void setInvoice_type(String invoice_type) {
		this.invoice_type = invoice_type;
	}

	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}

	/**
	 * @param id
	 *            the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}

	/**
	 * @return the doc_id
	 */
	public String getDoc_id() {
		return doc_id;
	}

	/**
	 * @param doc_id
	 *            the doc_id to set
	 */
	public void setDoc_id(String doc_id) {
		this.doc_id = doc_id;
	}

	/**
	 * @return the contract_id
	 */
	public String getContract_id() {
		return contract_id;
	}

	/**
	 * @param contract_id
	 *            the contract_id to set
	 */
	public void setContract_id(String contract_id) {
		this.contract_id = contract_id;
	}

	/**
	 * @return the begin_id
	 */
	public String getBegin_id() {
		return begin_id;
	}

	/**
	 * @param begin_id
	 *            the begin_id to set
	 */
	public void setBegin_id(String begin_id) {
		this.begin_id = begin_id;
	}

	/**
	 * @return the proj_id
	 */
	public String getProj_id() {
		return proj_id;
	}

	/**
	 * @param proj_id
	 *            the proj_id to set
	 */
	public void setProj_id(String proj_id) {
		this.proj_id = proj_id;
	}

	/**
	 * @return the equip_amt
	 */
	public String getEquip_amt() {
		return equip_amt;
	}

	/**
	 * @param equip_amt
	 *            the equip_amt to set
	 */
	public void setEquip_amt(String equip_amt) {
		this.equip_amt = equip_amt;
	}

	/**
	 * @return the currency
	 */
	public String getCurrency() {
		return currency;
	}

	/**
	 * @param currency
	 *            the currency to set
	 */
	public void setCurrency(String currency) {
		this.currency = currency;
	}

	/**
	 * @return the lease_money
	 */
	public String getLease_money() {
		return lease_money;
	}

	/**
	 * @param lease_money
	 *            the lease_money to set
	 */
	public void setLease_money(String lease_money) {
		this.lease_money = lease_money;
	}

	/**
	 * @return the actual_fund
	 */
	public String getActual_fund() {
		return actual_fund;
	}

	/**
	 * @param actual_fund
	 *            the actual_fund to set
	 */
	public void setActual_fund(String actual_fund) {
		this.actual_fund = actual_fund;
	}

	/**
	 * @return the assets_value
	 */
	public String getAssets_value() {
		return assets_value;
	}

	/**
	 * @param assets_value
	 *            the assets_value to set
	 */
	public void setAssets_value(String assets_value) {
		this.assets_value = assets_value;
	}

	/**
	 * @return the income_number
	 */
	public String getIncome_number() {
		return income_number;
	}

	/**
	 * @param income_number
	 *            the income_number to set
	 */
	public void setIncome_number(String income_number) {
		this.income_number = income_number;
	}

	/**
	 * @return the income_number_year
	 */
	public String getIncome_number_year() {
		return income_number_year;
	}

	/**
	 * @param income_number_year
	 *            the income_number_year to set
	 */
	public void setIncome_number_year(String income_number_year) {
		this.income_number_year = income_number_year;
	}

	/**
	 * @return the lease_term
	 */
	public String getLease_term() {
		return lease_term;
	}

	/**
	 * @param lease_term
	 *            the lease_term to set
	 */
	public void setLease_term(String lease_term) {
		this.lease_term = lease_term;
	}

	/**
	 * @return the settle_method
	 */
	public String getSettle_method() {
		return settle_method;
	}

	/**
	 * @param settle_method
	 *            the settle_method to set
	 */
	public void setSettle_method(String settle_method) {
		this.settle_method = settle_method;
	}

	/**
	 * @return the period_type
	 */
	public String getPeriod_type() {
		return period_type;
	}

	/**
	 * @param period_type
	 *            the period_type to set
	 */
	public void setPeriod_type(String period_type) {
		this.period_type = period_type;
	}

	/**
	 * @return the rate_float_type
	 */
	public String getRate_float_type() {
		return rate_float_type;
	}

	/**
	 * @param rate_float_type
	 *            the rate_float_type to set
	 */
	public void setRate_float_type(String rate_float_type) {
		this.rate_float_type = rate_float_type;
	}

	/**
	 * @return the rate_float_amt
	 */
	public String getRate_float_amt() {
		return rate_float_amt;
	}

	/**
	 * @param rate_float_amt
	 *            the rate_float_amt to set
	 */
	public void setRate_float_amt(String rate_float_amt) {
		this.rate_float_amt = rate_float_amt;
	}

	/**
	 * @return the year_rate
	 */
	public String getYear_rate() {
		return year_rate;
	}

	/**
	 * @param year_rate
	 *            the year_rate to set
	 */
	public void setYear_rate(String year_rate) {
		this.year_rate = year_rate;
	}

	/**
	 * @return the pena_rate
	 */
	public String getPena_rate() {
		return pena_rate;
	}

	/**
	 * @param pena_rate
	 *            the pena_rate to set
	 */
	public void setPena_rate(String pena_rate) {
		this.pena_rate = pena_rate;
	}

	/**
	 * @return the start_date
	 */
	public String getStart_date() {
		return start_date;
	}

	/**
	 * @param start_date
	 *            the start_date to set
	 */
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	/**
	 * @return the income_day
	 */
	public String getIncome_day() {
		return income_day;
	}

	/**
	 * @param income_day
	 *            the income_day to set
	 */
	public void setIncome_day(String income_day) {
		this.income_day = income_day;
	}

	/**
	 * @return the end_date
	 */
	public String getEnd_date() {
		return end_date;
	}

	/**
	 * @param end_date
	 *            the end_date to set
	 */
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	/**
	 * @return the plan_irr
	 */
	public String getPlan_irr() {
		return plan_irr;
	}

	/**
	 * @param plan_irr
	 *            the plan_irr to set
	 */
	public void setPlan_irr(String plan_irr) {
		this.plan_irr = plan_irr;
	}

	/**
	 * @return the free_defa_inter_day
	 */
	public String getFree_defa_inter_day() {
		return free_defa_inter_day;
	}

	/**
	 * @param free_defa_inter_day
	 *            the free_defa_inter_day to set
	 */
	public void setFree_defa_inter_day(String free_defa_inter_day) {
		this.free_defa_inter_day = free_defa_inter_day;
	}

	/**
	 * @return the total_amt
	 */
	public String getTotal_amt() {
		return total_amt;
	}

	/**
	 * @param total_amt
	 *            the total_amt to set
	 */
	public void setTotal_amt(String total_amt) {
		this.total_amt = total_amt;
	}

	/**
	 * @return the amt_return
	 */
	public String getAmt_return() {
		return amt_return;
	}

	/**
	 * @param amt_return
	 *            the amt_return to set
	 */
	public void setAmt_return(String amt_return) {
		this.amt_return = amt_return;
	}

	/**
	 * @return the apply_contract_number
	 */
	public String getApply_contract_number() {
		return apply_contract_number;
	}

	/**
	 * @param apply_contract_number
	 *            the apply_contract_number to set
	 */
	public void setApply_contract_number(String apply_contract_number) {
		this.apply_contract_number = apply_contract_number;
	}

	/**
	 * @return the adjust_style
	 */
	public String getAdjust_style() {
		return adjust_style;
	}

	/**
	 * @param adjust_style
	 *            the adjust_style to set
	 */
	public void setAdjust_style(String adjust_style) {
		this.adjust_style = adjust_style;
	}

	/**
	 * @return the into_batch
	 */
	public String getInto_batch() {
		return into_batch;
	}

	/**
	 * @param into_batch
	 *            the into_batch to set
	 */
	public void setInto_batch(String into_batch) {
		this.into_batch = into_batch;
	}

	/**
	 * @return the ratio_param
	 */
	public String getRatio_param() {
		return ratio_param;
	}

	/**
	 * @param ratio_param
	 *            the ratio_param to set
	 */
	public void setRatio_param(String ratio_param) {
		this.ratio_param = ratio_param;
	}

	/**
	 * @return the rent_start_date
	 */
	public String getRent_start_date() {
		return rent_start_date;
	}

	/**
	 * @param rent_start_date
	 *            the rent_start_date to set
	 */
	public void setRent_start_date(String rent_start_date) {
		this.rent_start_date = rent_start_date;
	}

	/**
	 * @return the is_open
	 */
	public String getIs_open() {
		return is_open;
	}

	/**
	 * @param is_open
	 *            the is_open to set
	 */
	public void setIs_open(String is_open) {
		this.is_open = is_open;
	}

	/**
	 * @return the plan_bank_name
	 */
	public String getPlan_bank_name() {
		return plan_bank_name;
	}

	/**
	 * @param plan_bank_name
	 *            the plan_bank_name to set
	 */
	public void setPlan_bank_name(String plan_bank_name) {
		this.plan_bank_name = plan_bank_name;
	}

	/**
	 * @return the plan_bank_no
	 */
	public String getPlan_bank_no() {
		return plan_bank_no;
	}

	/**
	 * @param plan_bank_no
	 *            the plan_bank_no to set
	 */
	public void setPlan_bank_no(String plan_bank_no) {
		this.plan_bank_no = plan_bank_no;
	}

	/**
	 * @return the creator
	 */
	public String getCreator() {
		return creator;
	}

	/**
	 * @param creator
	 *            the creator to set
	 */
	public void setCreator(String creator) {
		this.creator = creator;
	}

	/**
	 * @return the create_date
	 */
	public String getCreate_date() {
		return create_date;
	}

	/**
	 * @param create_date
	 *            the create_date to set
	 */
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}

	/**
	 * @return the modify_date
	 */
	public String getModify_date() {
		return modify_date;
	}

	/**
	 * @param modify_date
	 *            the modify_date to set
	 */
	public void setModify_date(String modify_date) {
		this.modify_date = modify_date;
	}

	/**
	 * @return the modificator
	 */
	public String getModificator() {
		return modificator;
	}

	/**
	 * @param modificator
	 *            the modificator to set
	 */
	public void setModificator(String modificator) {
		this.modificator = modificator;
	}

	public String getTax_type_invoice() {
		return tax_type_invoice;
	}

	public void setTax_type_invoice(String tax_type_invoice) {
		this.tax_type_invoice = tax_type_invoice;
	}

}
