package com.invoiceSync.bean;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import com.tenwa.culc.calc.util.FieldName;
import com.tenwa.culc.calc.util.Scale;


@Entity
@FieldName(name = "开票信息导出")
@Table(name="INVOICE_INFO_EXPORT")
public class InvoiceInfoExport {
		
	@FieldName(name="ERP单据号")
	@Column(name="OUT_NO")
	private String out_no;
	
	@FieldName(name="客户编码")
	@Column(name="CUST_ID")
	private String cust_id;
	
	@FieldName(name="客户名称")
	@Column(name="CUST_NAME")
	private String cust_name;
	
	@FieldName(name="税号")
	@Column(name="TAX_PAYER_NO")
	private String tax_payer_no;

	@FieldName(name="地址电话")
	@Column(name="ADDRESS_PHONE")
	private String address_phone;
	
	@FieldName(name="银行账号")
	@Column(name="ACCOUNT_NUMBER")
	private String account_number;
	
	@FieldName(name="备注")
	@Column(name="REMARK")
	private String remark;
	
	@FieldName(name="商品编码")
	@Column(name="PRODUCT_NUMBER")
	private String product_number;

	@FieldName(name="商品名称")
	@Column(name="PRODUCT_NAME")
	private String product_name;
	
	@FieldName(name="规格型号")
	@Column(name="COMMERCIAL_SPECIFICATION")
	private String commercial_specification;
	
	@FieldName(name="计量单位")
	@Column(name="UNIT")
	private String unit;

	@FieldName(name="税率")
	@Column(name="RATE")
	private String rate;
	
	@FieldName(name="销售数量")
	@Column(name="QUANTITY")
	private String quantity;

	@FieldName(name="是否含税")
	@Column(name="IF_TAX")
	private String if_tax; 
	
	@FieldName(name="含税金额")
	@Column(name="INCLUDE_TAX_MONEY", precision = 22,scale = Scale.DEFAULT)
	private String include_tax_money; 
	
	@FieldName(name = "发票类型")
     @Column(name="INVOICE_TYPE")
	private String invoice_type;
	
	
	
	@FieldName(name="数据来源标识")
	@Column(name="FLAG")
	private String flag;


	
	@FieldName(name="备用字段1")
	@Column(name="SPHARE_COLUMN1")
	private String sphare_column1;
	
	@FieldName(name="备用字段2")
	@Column(name="SPHARE_COLUMN2")
	private String sphare_column2;
	
	@FieldName(name="备用字段3")
	@Column(name="SPHARE_COLUMN3")
	private String sphare_column3;
	
	@FieldName(name="备用字段4")
	@Column(name="SPHARE_COLUMN4")
	private String sphare_column4;
	
	@FieldName(name="备用字段5")
	@Column(name="SPHARE_COLUMN5")
	private String sphare_column5;

	public String getOut_no() {
		return out_no;
	}

	public void setOut_no(String outNo) {
		out_no = outNo;
	}

	public String getCust_id() {
		return cust_id;
	}

	public void setCust_id(String custId) {
		cust_id = custId;
	}

	public String getCust_name() {
		return cust_name;
	}

	public void setCust_name(String custName) {
		cust_name = custName;
	}

	
	public String getTax_payer_no() {
		return tax_payer_no;
	}

	public void setTax_payer_no(String taxPayerNo) {
		tax_payer_no = taxPayerNo;
	}

	public String getAddress_phone() {
		return address_phone;
	}

	public void setAddress_phone(String addressPhone) {
		address_phone = addressPhone;
	}



	public String getAccount_number() {
		return account_number;
	}

	public void setAccount_number(String accountNumber) {
		account_number = accountNumber;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getProduct_number() {
		return product_number;
	}

	public void setProduct_number(String productNumber) {
		product_number = productNumber;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String productName) {
		product_name = productName;
	}

	public String getCommercial_specification() {
		return commercial_specification;
	}

	public void setCommercial_specification(String commercialSpecification) {
		commercial_specification = commercialSpecification;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}

	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	

	public String getIf_tax() {
		return if_tax;
	}

	public void setIf_tax(String ifTax) {
		if_tax = ifTax;
	}

	public String getInvoice_type() {
		return invoice_type;
	}

	public void setInvoice_type(String invoiceType) {
		invoice_type = invoiceType;
	}

	


	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getSphare_column1() {
		return sphare_column1;
	}

	public void setSphare_column1(String sphareColumn1) {
		sphare_column1 = sphareColumn1;
	}

	public String getSphare_column2() {
		return sphare_column2;
	}

	public void setSphare_column2(String sphareColumn2) {
		sphare_column2 = sphareColumn2;
	}

	public String getSphare_column3() {
		return sphare_column3;
	}

	public void setSphare_column3(String sphareColumn3) {
		sphare_column3 = sphareColumn3;
	}

	public String getSphare_column4() {
		return sphare_column4;
	}

	public void setSphare_column4(String sphareColumn4) {
		sphare_column4 = sphareColumn4;
	}

	public String getSphare_column5() {
		return sphare_column5;
	}

	public void setSphare_column5(String sphareColumn5) {
		sphare_column5 = sphareColumn5;
	}

	public String getInclude_tax_money() {
		return include_tax_money;
	}

	public void setInclude_tax_money(String includeTaxMoney) {
		include_tax_money = includeTaxMoney;
	}
	
   


}
