package com.tenwa.datasync.xirr.vo;

public class XIrrNewVo {
	/**
	 * 用于数据库存储Bean
	 */
	private String contractId;
	private Integer curYear;
	private String jan;
	private String feb;
	private String mar;
	private String apr;
	private String may;
	private String jun;
	private String jul;
	private String aug;
	private String sep;
	private String oct;
	private String nov;
	private String dece;
	private String signXIrr;
	private String projectName;
	public String get(int i){
		switch(i){
		case 1:
			return this.getJan();
		case 2:
			return this.getFeb();
		case 3:
			return this.getMar();
		case 4:
			return this.getApr();
		case 5:
			return this.getMay();
		case 6:
			return this.getJun();
		case 7:
			return this.getJul();
		case 8:
			return this.getAug();
		case 9:
			return this.getSep();
		case 10:
			return this.getOct();
		case 11:
			return this.getNov();
		case 12:
			return this.getDece();
		}
		return "";
	}
	public String getContractId() {
		return contractId;
	}
	public void setContractId(String contractId) {
		this.contractId = contractId;
	}
	public Integer getCurYear() {
		return curYear;
	}
	public void setCurYear(Integer curYear) {
		this.curYear = curYear;
	}
	public String getJan() {
		return jan;
	}
	public void setJan(String jan) {
		this.jan = jan;
	}
	public String getFeb() {
		return feb;
	}
	public void setFeb(String feb) {
		this.feb = feb;
	}
	public String getMar() {
		return mar;
	}
	public void setMar(String mar) {
		this.mar = mar;
	}
	public String getApr() {
		return apr;
	}
	public void setApr(String apr) {
		this.apr = apr;
	}
	public String getMay() {
		return may;
	}
	public void setMay(String may) {
		this.may = may;
	}
	public String getJun() {
		return jun;
	}
	public void setJun(String jun) {
		this.jun = jun;
	}
	public String getJul() {
		return jul;
	}
	public void setJul(String jul) {
		this.jul = jul;
	}
	public String getAug() {
		return aug;
	}
	public void setAug(String aug) {
		this.aug = aug;
	}
	public String getSep() {
		return sep;
	}
	public void setSep(String sep) {
		this.sep = sep;
	}
	public String getOct() {
		return oct;
	}
	public void setOct(String oct) {
		this.oct = oct;
	}
	public String getNov() {
		return nov;
	}
	public void setNov(String nov) {
		this.nov = nov;
	}
	
	public String getDece() {
		return dece;
	}
	public void setDece(String dece) {
		this.dece = dece;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getSignXIrr() {
		return signXIrr;
	}
	public void setSignXIrr(String signXIrr) {
		this.signXIrr = signXIrr;
	}
	
}
