package com.tenwa.datasync.xirr.vo;

import java.io.Serializable;
import java.util.Map;
/**
 * 用于XIrr页面显示Bean
 * @author wangyu
 *
 */
public class XIrrBean implements Serializable {
	private static final long serialVersionUID = 1L;
	private String contractId;
	private String projectName;
	
	
	private String signXirr;
	private Map<String,String> xirrMap;
	public String getContractId() {
		return contractId;
	}
	public void setContractId(String contractId) {
		this.contractId = contractId;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getSignXirr() {
		return signXirr;
	}
	public void setSignXirr(String signXirr) {
		this.signXirr = signXirr;
	}
	public Map<String, String> getXirrMap() {
		return xirrMap;
	}
	public void setXirrMap(Map<String, String> xirrMap) {
		this.xirrMap = xirrMap;
	}
	
}
