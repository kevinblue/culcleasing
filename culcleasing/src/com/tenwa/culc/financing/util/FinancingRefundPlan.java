/**
 * com.tenwa.culc.financing.util
 */
package com.tenwa.culc.financing.util;

/**
 * 融资还款计划Bean
 * 
 * @author Jaffe
 * 
 * Date:Dec 27, 2011 9:40:48 AM Email:JaffeHe@hotmail.com
 */
public class FinancingRefundPlan {

	private int id;
	private String drawings_id;// 提款编号
	private String doc_id;// 文档编号
	private String refund_list;// 还款期次
	private String refund_plan_date;// 还款日期
	private String refund_rate;// 还款利率
	private String refund_corpus;// 还款本金
	private String refund_interest;// 还款利息
	private String refund_money;// 还款本+息
	private String refund_otherfee_money;// 还款其他费用
	private String refund_otherfee_type;// 还款其他费用类型
	private String refund_subtotal;// 还款计划小计
	private String refund_status;// 还款状态 未还款|已还款
	private String remark;// 备注
	private String state;// 标志 默认为0

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
	 * @return the drawings_id
	 */
	public String getDrawings_id() {
		return drawings_id;
	}

	/**
	 * @param drawings_id
	 *            the drawings_id to set
	 */
	public void setDrawings_id(String drawings_id) {
		this.drawings_id = drawings_id;
	}

	/**
	 * @return the refund_list
	 */
	public String getRefund_list() {
		return refund_list;
	}

	/**
	 * @param refund_list
	 *            the refund_list to set
	 */
	public void setRefund_list(String refund_list) {
		this.refund_list = refund_list;
	}

	/**
	 * @return the refund_plan_date
	 */
	public String getRefund_plan_date() {
		return refund_plan_date;
	}

	/**
	 * @param refund_plan_date
	 *            the refund_plan_date to set
	 */
	public void setRefund_plan_date(String refund_plan_date) {
		this.refund_plan_date = refund_plan_date;
	}

	/**
	 * @return the refund_rate
	 */
	public String getRefund_rate() {
		return refund_rate;
	}

	/**
	 * @param refund_rate
	 *            the refund_rate to set
	 */
	public void setRefund_rate(String refund_rate) {
		this.refund_rate = refund_rate;
	}

	/**
	 * @return the refund_corpus
	 */
	public String getRefund_corpus() {
		return refund_corpus;
	}

	/**
	 * @param refund_corpus
	 *            the refund_corpus to set
	 */
	public void setRefund_corpus(String refund_corpus) {
		this.refund_corpus = refund_corpus;
	}

	/**
	 * @return the refund_interest
	 */
	public String getRefund_interest() {
		return refund_interest;
	}

	/**
	 * @param refund_interest
	 *            the refund_interest to set
	 */
	public void setRefund_interest(String refund_interest) {
		this.refund_interest = refund_interest;
	}

	/**
	 * @return the refund_money
	 */
	public String getRefund_money() {
		return refund_money;
	}

	/**
	 * @param refund_money
	 *            the refund_money to set
	 */
	public void setRefund_money(String refund_money) {
		this.refund_money = refund_money;
	}

	/**
	 * @return the refund_otherfee_money
	 */
	public String getRefund_otherfee_money() {
		return refund_otherfee_money;
	}

	/**
	 * @param refund_otherfee_money
	 *            the refund_otherfee_money to set
	 */
	public void setRefund_otherfee_money(String refund_otherfee_money) {
		this.refund_otherfee_money = refund_otherfee_money;
	}

	/**
	 * @return the refund_otherfee_type
	 */
	public String getRefund_otherfee_type() {
		return refund_otherfee_type;
	}

	/**
	 * @param refund_otherfee_type
	 *            the refund_otherfee_type to set
	 */
	public void setRefund_otherfee_type(String refund_otherfee_type) {
		this.refund_otherfee_type = refund_otherfee_type;
	}

	/**
	 * @return the refund_subtotal
	 */
	public String getRefund_subtotal() {
		return refund_subtotal;
	}

	/**
	 * @param refund_subtotal
	 *            the refund_subtotal to set
	 */
	public void setRefund_subtotal(String refund_subtotal) {
		this.refund_subtotal = refund_subtotal;
	}

	/**
	 * @return the refund_status
	 */
	public String getRefund_status() {
		return refund_status;
	}

	/**
	 * @param refund_status
	 *            the refund_status to set
	 */
	public void setRefund_status(String refund_status) {
		this.refund_status = refund_status;
	}

	/**
	 * @return the remark
	 */
	public String getRemark() {
		return remark;
	}

	/**
	 * @param remark
	 *            the remark to set
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}

	/**
	 * @return the state
	 */
	public String getState() {
		return state;
	}

	/**
	 * @param state
	 *            the state to set
	 */
	public void setState(String state) {
		this.state = state;
	}

}
