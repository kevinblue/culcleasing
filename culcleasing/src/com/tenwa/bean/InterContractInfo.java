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
 * @info 项目基本信息表
 * @Copyright 
 * Tenwa
 */
@Entity
@FieldName(name = "合同基本信息表")
@Table(name="INTER_CONTRACT_INFO")
public class InterContractInfo {
	@Id
    @GeneratedValue(generator = "paymentableGenerator")     
    @GenericGenerator(name = "paymentableGenerator", strategy = "uuid") 
    @Column(length=32)
	private String id;
	
	@FieldName(name="公司名称")
	@Column(name="COMPANY_NAME")
	private String companyName;
	
	@FieldName(name="ERP项目编号")
	@Column(name="PROJ_ID")
	private String projId;
	
	@FieldName(name="ERP合同编号")
	@Column(name="CONTRACT_ID")
	private String contractId;
	
	@FieldName(name="合同类型")
	@Column(name="CONTRACT_TYPE")
	private String contractType;
	
	@FieldName(name="项目名称")
	@Column(name="PROJECT_NAME")
	private String projectName;
	
	@FieldName(name="客户名称")
	@Column(name="CUST_NAME")
	private String custName;
	
	@FieldName(name="租赁利率")
	@Column(name="CONT_RATIO", precision = 22,scale = Scale.DEFAULT)
	private BigDecimal contRatio;
	
	@FieldName(name="项目部门")
	@Column(name="PROJ_DEPT")
	private String projDept;
	
	@FieldName(name="大区")
	@Column(name="PROJ_AREA")
	private String projArea;
	
	@FieldName(name="项目行业")
	@Column(name="INDUSTRY_TYPE")
	private String industryType;
	
	@FieldName(name="租赁类型")
	@Column(name="LEAS_TYPE")
	private String leasType;
	
	@FieldName(name="医疗药品收入")
	@Column(name="MEDICAL_REVENUE")
	private String medicalRevenue;
	
	@FieldName(name="医院等级规模")
	@Column(name="HOSPITAL_SCALE_LEVEL")
	private String hospitalScaleLevel;
	
	@FieldName(name="客户资质等级")
	@Column(name="QUALIFICATION_GRADE")
	private String qualificationGrade;
	
	@FieldName(name="客户行业小类")
	@Column(name="HYXLMC")
	private String hyxlmc;
	
	@FieldName(name="项目经理")
	@Column(name="PROJ_MANAGER")
	private String projManager;
	
	@FieldName(name="立项日期")
	@Column(name="SIGN_DATE")
	private String signDate;
	
	@FieldName(name="项目状态")
	@Column(name="PROJ_STATUS")
	private String projStatus;
	
	@FieldName(name="备用字段1")
	@Column(name="SPARE_COLUMN1")
	private String spareColumn1;
	
	@FieldName(name="备用字段2")
	@Column(name="SPARE_COLUMN2")
	private String spareColumn2;
	
	@FieldName(name="备用字段3")
	@Column(name="SPARE_COLUMN3")
	private String spareColumn3;
	
	@FieldName(name="备用字段4")
	@Column(name="SPARE_COLUMN4")
	private String spareColumn4;
	
	@FieldName(name="备用字段5")
	@Column(name="SPARE_COLUMN5")
	private String spareColumn5;
	
	@FieldName(name="备用字段6")
	@Column(name="SPARE_COLUMN6")
	private String spareColumn6;
	
	@FieldName(name="备用字段7")
	@Column(name="SPARE_COLUMN7")
	private String spareColumn7;
	
	@FieldName(name="备用字段8")
	@Column(name="SPARE_COLUMN8")
	private String spareColumn8;
	
	@FieldName(name="备用字段9")
	@Column(name="SPARE_COLUMN9")
	private String spareColumn9;
	
	@FieldName(name="备用字段10")
	@Column(name="SPARE_COLUMN10")
	private String spareColumn10;
	
	@FieldName(name="用友读取标志")
	@Column(name="READ_FLAG")
	private Integer readFlag;
	
	@FieldName(name="用友读取时间")
	@Column(name="READ_DATE")
	private String readDate;
	
	@FieldName(name="用友读取失败标记")
	@Column(name = "READ_MEMO", length = 1000)
	private String readMemo;
	
	@FieldName(name="创建人")
	@Column(name="CREATOR")
	private String creator;
	
	@FieldName(name="创建日期")
	@Column(name="CREATE_DATE")
	private String createDate;
	
	@FieldName(name="修改人")
	@Column(name="MODIFICATOR")
	private String modificator;

	@FieldName(name="修改日期")
	@Column(name="MODIFY_DATE")
	private String modifyDate;
	
	@FieldName(name="数据状态")
	@Column(name="FLAG")
	private Integer flag;
	
	@FieldName(name="操作ID")
	@Column(name="OPER_ID")
	private String OPER_ID;

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

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}


	public String getContractId() {
		return contractId;
	}

	public void setContractId(String contractId) {
		this.contractId = contractId;
	}

	public String getContractType() {
		return contractType;
	}

	public void setContractType(String contractType) {
		this.contractType = contractType;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getCustName() {
		return custName;
	}

	public void setCustName(String custName) {
		this.custName = custName;
	}


	public BigDecimal getContRatio() {
		return contRatio;
	}

	public void setContRatio(BigDecimal contRatio) {
		this.contRatio = contRatio;
	}

	public String getProjDept() {
		return projDept;
	}

	public void setProjDept(String projDept) {
		this.projDept = projDept;
	}

	public String getProjArea() {
		return projArea;
	}

	public void setProjArea(String projArea) {
		this.projArea = projArea;
	}

	

	public String getIndustryType() {
		return industryType;
	}

	public void setIndustryType(String industryType) {
		this.industryType = industryType;
	}

	public String getLeasType() {
		return leasType;
	}

	public void setLeasType(String leasType) {
		this.leasType = leasType;
	}

	public String getMedicalRevenue() {
		return medicalRevenue;
	}

	public void setMedicalRevenue(String medicalRevenue) {
		this.medicalRevenue = medicalRevenue;
	}

	public String getHospitalScaleLevel() {
		return hospitalScaleLevel;
	}

	public void setHospitalScaleLevel(String hospitalScaleLevel) {
		this.hospitalScaleLevel = hospitalScaleLevel;
	}

	public String getQualificationGrade() {
		return qualificationGrade;
	}

	public void setQualificationGrade(String qualificationGrade) {
		this.qualificationGrade = qualificationGrade;
	}

	public String getHyxlmc() {
		return hyxlmc;
	}

	public void setHyxlmc(String hyxlmc) {
		this.hyxlmc = hyxlmc;
	}

	public String getProjManager() {
		return projManager;
	}

	public void setProjManager(String projManager) {
		this.projManager = projManager;
	}


	public String getSignDate() {
		return signDate;
	}

	public void setSignDate(String signDate) {
		this.signDate = signDate;
	}

	public String getProjStatus() {
		return projStatus;
	}

	public void setProjStatus(String projStatus) {
		this.projStatus = projStatus;
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

	public String getProjId() {
		return projId;
	}

	public void setProjId(String projId) {
		this.projId = projId;
	}

	
}
