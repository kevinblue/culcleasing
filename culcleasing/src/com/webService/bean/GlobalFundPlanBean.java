/**
 * com.tenwa.datasync.finance.bean
 */
package com.webService.bean;

/**
 * 资金收付计划表
 * 
 * @author Jaffe
 * 
 * Date:Sep 12, 2011 9:56:59 PM Email:JaffeHe@hotmail.com
 */
public class GlobalFundPlanBean {
	private int id;// 关联id号
	private String invcode;// 单据号 年+项目+流水号
	private String ccodetrust;// 承租客户 传入对应的南北客户码

	private String ccode;// 收/付款人 传入对应的南北编码
	private String bcode;// 项目经理 传入对应的南北编码
	private String nccode;//客商编码
	public String getNccode() {
		return nccode;
	}

	public void setNccode(String nccode) {
		this.nccode = nccode;
	}

	private String tenancytype;// 租赁类型
	/*
	 * "分为：融资租赁、经营租赁、售后回租赁和结构分成式租赁； 传入数据使用汉字；"
	 */
	private String picode;// 项目编号
	private String pcode;// 项目名称
	private String ordcode;// 合同号
	private String remark;// 款项名称

	private String changesign;// 变更标识 0：变更 1：正常
	private String odate;// 计划日期 示例格式为：2008-1-1
	private String modifydate;// 传输时间 示例格式为：2008-1-1

	private String invtype;// 款项内容
	/*
	 * "包括如下类型，智联腾华按以下编码规则传入中间表： 870：保证金 871：首付款 872：租赁管理费 873：预付款利息（租前息）
	 * 874：收代付保险费 877：逾期利息 878：罚息 880：租赁服务费 881：利息补贴 882：资产余值 884：其他收入 885：收咨询费
	 * 886：租金"
	 */
	private String rmb;// 人民币金额
	private String r_flags;// 导入标识 该字段为南北做是否从中间表取数标识使用，智联不需要导入该字段任何值
	private String industry;//内部行业
	private String remark_o;//备注
	
	// 特殊字段
	private String priId;// 主键
	private String para_2;// 参数2
	private String para_3;// 参数3
	private String para_4;// 参数4
	private String syncType;// 操作类型
	
	private String leas_type;//租赁类型
	private String remark_1;//备注
	private String remark_2;//备注
	private String ncdeptno;//nc部门编码	
	private String acode;//银行账户
	
	
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
	 * @return the invcode
	 */
	public String getInvcode() {
		return invcode;
	}

	/**
	 * @param invcode
	 *            the invcode to set
	 */
	public void setInvcode(String invcode) {
		this.invcode = invcode;
	}

	/**
	 * @return the ccodetrust
	 */
	public String getCcodetrust() {
		return ccodetrust;
	}

	/**
	 * @param ccodetrust
	 *            the ccodetrust to set
	 */
	public void setCcodetrust(String ccodetrust) {
		this.ccodetrust = ccodetrust;
	}

	/**
	 * @return the ccode
	 */
	public String getCcode() {
		return ccode;
	}

	/**
	 * @param ccode
	 *            the ccode to set
	 */
	public void setCcode(String ccode) {
		this.ccode = ccode;
	}

	/**
	 * @return the bcode
	 */
	public String getBcode() {
		return bcode;
	}

	/**
	 * @param bcode
	 *            the bcode to set
	 */
	public void setBcode(String bcode) {
		this.bcode = bcode;
	}

	/**
	 * @return the tenancytype
	 */
	public String getTenancytype() {
		return tenancytype;
	}

	/**
	 * @param tenancytype
	 *            the tenancytype to set
	 */
	public void setTenancytype(String tenancytype) {
		this.tenancytype = tenancytype;
	}

	/**
	 * @return the picode
	 */
	public String getPicode() {
		return picode;
	}

	/**
	 * @param picode
	 *            the picode to set
	 */
	public void setPicode(String picode) {
		this.picode = picode;
	}

	/**
	 * @return the pcode
	 */
	public String getPcode() {
		return pcode;
	}

	/**
	 * @param pcode
	 *            the pcode to set
	 */
	public void setPcode(String pcode) {
		this.pcode = pcode;
	}

	/**
	 * @return the ordcode
	 */
	public String getOrdcode() {
		return ordcode;
	}

	/**
	 * @param ordcode
	 *            the ordcode to set
	 */
	public void setOrdcode(String ordcode) {
		this.ordcode = ordcode;
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
	 * @return the changesign
	 */
	public String getChangesign() {
		return changesign;
	}

	/**
	 * @param changesign
	 *            the changesign to set
	 */
	public void setChangesign(String changesign) {
		this.changesign = changesign;
	}

	/**
	 * @return the odate
	 */
	public String getOdate() {
		return odate;
	}

	/**
	 * @param odate
	 *            the odate to set
	 */
	public void setOdate(String odate) {
		this.odate = odate;
	}

	/**
	 * @return the modifydate
	 */
	public String getModifydate() {
		return modifydate;
	}

	/**
	 * @param modifydate
	 *            the modifydate to set
	 */
	public void setModifydate(String modifydate) {
		this.modifydate = modifydate;
	}

	/**
	 * @return the invtype
	 */
	public String getInvtype() {
		return invtype;
	}

	/**
	 * @param invtype
	 *            the invtype to set
	 */
	public void setInvtype(String invtype) {
		this.invtype = invtype;
	}

	/**
	 * @return the rmb
	 */
	public String getRmb() {
		return rmb;
	}

	/**
	 * @param rmb
	 *            the rmb to set
	 */
	public void setRmb(String rmb) {
		this.rmb = rmb;
	}

	/**
	 * @return the r_flags
	 */
	public String getR_flags() {
		return r_flags;
	}

	/**
	 * @param r_flags
	 *            the r_flags to set
	 */
	public void setR_flags(String r_flags) {
		this.r_flags = r_flags;
	}

	/**
	 * @return the priId
	 */
	public String getPriId() {
		return priId;
	}

	/**
	 * @param priId
	 *            the priId to set
	 */
	public void setPriId(String priId) {
		this.priId = priId;
	}

	/**
	 * @return the syncType
	 */
	public String getSyncType() {
		return syncType;
	}

	/**
	 * @param syncType
	 *            the syncType to set
	 */
	public void setSyncType(String syncType) {
		this.syncType = syncType;
	}

	public String getPara_2() {
		return para_2;
	}

	public void setPara_2(String para_2) {
		this.para_2 = para_2;
	}

	public String getPara_3() {
		return para_3;
	}

	public void setPara_3(String para_3) {
		this.para_3 = para_3;
	}

	public String getPara_4() {
		return para_4;
	}

	public void setPara_4(String para_4) {
		this.para_4 = para_4;
	}

	public String getIndustry() {
		return industry;
	}

	public void setIndustry(String industry) {
		this.industry = industry;
	}

	public String getRemark_o() {
		return remark_o;
	}

	public void setRemark_o(String remark_o) {
		this.remark_o = remark_o;
	}

	public String getLeas_type() {
		return leas_type;
	}

	public void setLeas_type(String leas_type) {
		this.leas_type = leas_type;
	}

	public String getRemark_1() {
		return remark_1;
	}

	public void setRemark_1(String remark_1) {
		this.remark_1 = remark_1;
	}

	public String getRemark_2() {
		return remark_2;
	}

	public void setRemark_2(String remark_2) {
		this.remark_2 = remark_2;
	}
	public String getNcdeptno() {
		return ncdeptno;
	}

	public void setNcdeptno(String ncdeptno) {
		this.ncdeptno = ncdeptno;
	}

	public String getAcode() {
		return acode;
	}

	public void setAcode(String acode) {
		this.acode = acode;
	}
    
}
