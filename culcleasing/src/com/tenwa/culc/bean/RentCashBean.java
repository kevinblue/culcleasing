/**
 * com.tenwa.culc.bean
 */
package com.tenwa.culc.bean;

/**
 * 现金流
 * 
 * @author Jaffe
 * 
 * Date:Jun 27, 2011 2:53:01 PM Email:JaffeHe@hotmail.com
 */
public class RentCashBean {
	private int id;// 主键Id
	private String contract_id;// 合同id
	private String proj_id;// 项目id
	private String begin_id;// 起租id
	private String doc_id;// Doc_id Domino
	private String plan_date;// 日期
	private String follow_in;// 流入量
	private String follow_in_detail;// 流入量清单
	private String follow_out;// 流出量
	private String follow_out_detail;// 流出量清单
	private String net_follow;// 净流量
	private String creator;// 创建人
	private String create_date;// 创建日期
	private String modificator;// 更新人
	private String modify_date;// 更新日期

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
	 * @return the follow_in
	 */
	public String getFollow_in() {
		return follow_in;
	}

	/**
	 * @param follow_in
	 *            the follow_in to set
	 */
	public void setFollow_in(String follow_in) {
		this.follow_in = follow_in;
	}

	/**
	 * @return the follow_in_detail
	 */
	public String getFollow_in_detail() {
		return follow_in_detail;
	}

	/**
	 * @param follow_in_detail
	 *            the follow_in_detail to set
	 */
	public void setFollow_in_detail(String follow_in_detail) {
		this.follow_in_detail = follow_in_detail;
	}

	/**
	 * @return the follow_out
	 */
	public String getFollow_out() {
		return follow_out;
	}

	/**
	 * @param follow_out
	 *            the follow_out to set
	 */
	public void setFollow_out(String follow_out) {
		this.follow_out = follow_out;
	}

	/**
	 * @return the follow_out_detail
	 */
	public String getFollow_out_detail() {
		return follow_out_detail;
	}

	/**
	 * @param follow_out_detail
	 *            the follow_out_detail to set
	 */
	public void setFollow_out_detail(String follow_out_detail) {
		this.follow_out_detail = follow_out_detail;
	}

	/**
	 * @return the net_follow
	 */
	public String getNet_follow() {
		return net_follow;
	}

	/**
	 * @param net_follow
	 *            the net_follow to set
	 */
	public void setNet_follow(String net_follow) {
		this.net_follow = net_follow;
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

}
