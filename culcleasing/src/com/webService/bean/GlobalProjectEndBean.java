package com.webService.bean;

/**
 * 合同结清表 - 每晚2点执行
 * 
 * @author Jaffe
 * 
 * Date:Feb 22, 2012 4:08:14 PM Email:JaffeHe@hotmail.com
 */
public class GlobalProjectEndBean {
	private int id;// 关联id号
	private String invcode;// 单据号 年+项目+流水号
	private String ccodetrust;// 承租客户 传入对应的南北客户码
	private String bcode;// 项目经理 传入对应的南北编码
	private String acode;// 收/付款帐户 传入对应的南北编码
	private String odate;// 实际收/付日期 示例格式为：2008-1-1
	private String ccode;// 承租客户 传入对应的南北编码
	private String ncode;//客商编码
	private String ncdeptno;//客商编码
	

	
	private String remark;// 款项名称
	private String rmb;// 金额
	private String modifydate;// 传输时间 示例格式为：2008-1-1
	/*
	 * 870：保证金 886：租金 878：罚息 890：留购价格 891：项目清算款
	 */
	private String invtype;// 款项内容
	private String ordcode;// 合同号
	private String picode;// 项目编号
	private String pcode;// 项目名称

	private String r_flags;// 导入标识 该字段为南北做是否从中间表取数标识使用，智联不需要导入该字段任何值
	private String remark_o;// 备注
	private String industry;// 内部行业

	// 特殊字段
	private String para_2;// 参数2
	private String para_3;// 参数3
	private String syncType;// 操作类型
	private String priId;// 主键
	private String para_4;// 参数4
	
	private String leas_type;//租赁类型
	private String remark_1;//备注
	private String remark_2;//备注

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getInvcode() {
		return invcode;
	}

	public void setInvcode(String invcode) {
		this.invcode = invcode;
	}

	public String getCcode() {
		return ccode;
	}

	public void setCcode(String ccode) {
		this.ccode = ccode;
	}

	public String getBcode() {
		return bcode;
	}

	public void setBcode(String bcode) {
		this.bcode = bcode;
	}

	public String getAcode() {
		return acode;
	}

	public void setAcode(String acode) {
		this.acode = acode;
	}

	public String getPicode() {
		return picode;
	}

	public void setPicode(String picode) {
		this.picode = picode;
	}

	public String getPcode() {
		return pcode;
	}

	public void setPcode(String pcode) {
		this.pcode = pcode;
	}

	public String getOrdcode() {
		return ordcode;
	}

	public void setOrdcode(String ordcode) {
		this.ordcode = ordcode;
	}

	public String getCcodetrust() {
		return ccodetrust;
	}

	public void setCcodetrust(String ccodetrust) {
		this.ccodetrust = ccodetrust;
	}

	public String getModifydate() {
		return modifydate;
	}

	public void setModifydate(String modifydate) {
		this.modifydate = modifydate;
	}

	public String getInvtype() {
		return invtype;
	}

	public void setInvtype(String invtype) {
		this.invtype = invtype;
	}

	public String getOdate() {
		return odate;
	}

	public void setOdate(String odate) {
		this.odate = odate;
	}

	public String getRmb() {
		return rmb;
	}

	public void setRmb(String rmb) {
		this.rmb = rmb;
	}

	public String getR_flags() {
		return r_flags;
	}

	public void setR_flags(String r_flags) {
		this.r_flags = r_flags;
	}

	public String getRemark_o() {
		return remark_o;
	}

	public void setRemark_o(String remark_o) {
		this.remark_o = remark_o;
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

	public String getSyncType() {
		return syncType;
	}

	public void setSyncType(String syncType) {
		this.syncType = syncType;
	}

	public String getPriId() {
		return priId;
	}

	public void setPriId(String priId) {
		this.priId = priId;
	}

	public String getPara_4() {
		return para_4;
	}

	public void setPara_4(String para_4) {
		this.para_4 = para_4;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getIndustry() {
		return industry;
	}

	public void setIndustry(String industry) {
		this.industry = industry;
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
	public String getNcode() {
		return ncode;
	}

	public void setNcode(String ncode) {
		this.ncode = ncode;
	}
	public String getNcdeptno() {
		return ncdeptno;
	}

	public void setNcdeptno(String ncdeptno) {
		this.ncdeptno = ncdeptno;
	}

	
}
