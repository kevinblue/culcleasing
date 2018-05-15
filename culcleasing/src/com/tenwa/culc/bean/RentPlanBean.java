/**
 * com.tenwa.culc.bean
 */
package com.tenwa.culc.bean;

/**
 * 租金Bean
 * 
 * @author Jaffe
 * 
 * Date:Jun 27, 2011 2:51:44 PM Email:JaffeHe@hotmail.com
 */
public class RentPlanBean {

	private int id;// 主键Id
	private String contract_id;// 合同id
	private String proj_id;// 项目proj_id
	private String begin_id;// 起租Id
	private String doc_id;// Doc_id Domino
	private String measure_date;// 测算日期
	private String rent_list;// 租金期次

	private String plan_date;// 租金计划收取日期
	private String pena_plan_date;// 罚息收取日期
	private String plan_status;// 租金核销状态
	private String pena_status;// 罚息核销状态

	private String curr_rent;// 当前应收租金金额
	private String rent;// 租金（测算结果数据）
	private String curr_corpus;// 应收本金
	private String corpus;// 本金
	private String year_rate;// 年利率
	private String curr_interest;// 应收利息
	private String interest;// 利息
	private String rent_overage;// 租金余额
	private String corpus_overage;// 本金余额
	private String interest_overage;// 利息余额

	private String curr_penalty;// 当前应收罚息
	private String penalty;// 罚息（总和）
	private String penalty_overage;// 罚息余额

	private String plan_bank_name;// 预计收款银行名称
	private String plan_bank_no;// 预计收款银行账号

	private String creator;// 创建人
	private String create_date;// 创建时间
	private String modificator;// 更新人
	private String modify_date;// 更新日期

	/**
	 * @return the curr_corpus
	 */
	public String getCurr_corpus() {
		return curr_corpus;
	}

	/**
	 * @param curr_corpus
	 *            the curr_corpus to set
	 */
	public void setCurr_corpus(String curr_corpus) {
		this.curr_corpus = curr_corpus;
	}

	/**
	 * @return the curr_interest
	 */
	public String getCurr_interest() {
		return curr_interest;
	}

	/**
	 * @param curr_interest
	 *            the curr_interest to set
	 */
	public void setCurr_interest(String curr_interest) {
		this.curr_interest = curr_interest;
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
	 * @return the measure_date
	 */
	public String getMeasure_date() {
		return measure_date;
	}

	/**
	 * @param measure_date
	 *            the measure_date to set
	 */
	public void setMeasure_date(String measure_date) {
		this.measure_date = measure_date;
	}

	/**
	 * @return the pena_plan_date
	 */
	public String getPena_plan_date() {
		return pena_plan_date;
	}

	/**
	 * @param pena_plan_date
	 *            the pena_plan_date to set
	 */
	public void setPena_plan_date(String pena_plan_date) {
		this.pena_plan_date = pena_plan_date;
	}

	/**
	 * @return the pena_status
	 */
	public String getPena_status() {
		return pena_status;
	}

	/**
	 * @param pena_status
	 *            the pena_status to set
	 */
	public void setPena_status(String pena_status) {
		this.pena_status = pena_status;
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
	 * @return the rent_list
	 */
	public String getRent_list() {
		return rent_list;
	}

	/**
	 * @param rent_list
	 *            the rent_list to set
	 */
	public void setRent_list(String rent_list) {
		this.rent_list = rent_list;
	}

	/**
	 * @return the plan_date
	 */
	public String getPlan_date() {
		return plan_date;
	}

	/**
	 * @param plan_date
	 *            the plan_date to set
	 */
	public void setPlan_date(String plan_date) {
		this.plan_date = plan_date;
	}

	/**
	 * @return the curr_rent
	 */
	public String getCurr_rent() {
		return curr_rent;
	}

	/**
	 * @param curr_rent
	 *            the curr_rent to set
	 */
	public void setCurr_rent(String curr_rent) {
		this.curr_rent = curr_rent;
	}

	/**
	 * @return the rent
	 */
	public String getRent() {
		return rent;
	}

	/**
	 * @param rent
	 *            the rent to set
	 */
	public void setRent(String rent) {
		this.rent = rent;
	}

	/**
	 * @return the corpus
	 */
	public String getCorpus() {
		return corpus;
	}

	/**
	 * @param corpus
	 *            the corpus to set
	 */
	public void setCorpus(String corpus) {
		this.corpus = corpus;
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
	 * @return the interest
	 */
	public String getInterest() {
		return interest;
	}

	/**
	 * @param interest
	 *            the interest to set
	 */
	public void setInterest(String interest) {
		this.interest = interest;
	}

	/**
	 * @return the rent_overage
	 */
	public String getRent_overage() {
		return rent_overage;
	}

	/**
	 * @param rent_overage
	 *            the rent_overage to set
	 */
	public void setRent_overage(String rent_overage) {
		this.rent_overage = rent_overage;
	}

	/**
	 * @return the corpus_overage
	 */
	public String getCorpus_overage() {
		return corpus_overage;
	}

	/**
	 * @param corpus_overage
	 *            the corpus_overage to set
	 */
	public void setCorpus_overage(String corpus_overage) {
		this.corpus_overage = corpus_overage;
	}

	/**
	 * @return the interest_overage
	 */
	public String getInterest_overage() {
		return interest_overage;
	}

	/**
	 * @param interest_overage
	 *            the interest_overage to set
	 */
	public void setInterest_overage(String interest_overage) {
		this.interest_overage = interest_overage;
	}

	/**
	 * @return the penalty_overage
	 */
	public String getPenalty_overage() {
		return penalty_overage;
	}

	/**
	 * @param penalty_overage
	 *            the penalty_overage to set
	 */
	public void setPenalty_overage(String penalty_overage) {
		this.penalty_overage = penalty_overage;
	}

	/**
	 * @return the curr_penalty
	 */
	public String getCurr_penalty() {
		return curr_penalty;
	}

	/**
	 * @param curr_penalty
	 *            the curr_penalty to set
	 */
	public void setCurr_penalty(String curr_penalty) {
		this.curr_penalty = curr_penalty;
	}

	/**
	 * @return the penalty
	 */
	public String getPenalty() {
		return penalty;
	}

	/**
	 * @param penalty
	 *            the penalty to set
	 */
	public void setPenalty(String penalty) {
		this.penalty = penalty;
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
	 * @return the plan_status
	 */
	public String getPlan_status() {
		return plan_status;
	}

	/**
	 * @param plan_status
	 *            the plan_status to set
	 */
	public void setPlan_status(String plan_status) {
		this.plan_status = plan_status;
	}

}
