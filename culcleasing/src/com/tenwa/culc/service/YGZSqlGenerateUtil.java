package com.tenwa.culc.service;

import com.tenwa.culc.bean.ContractPlanBean;
import com.tenwa.culc.bean.VbadinfoBean;
import com.tenwa.culc.bean.VendProBean;
/**
 * 
 * @ClassName YGZSqlGenerateUtil

 * @Description 回写CRM所需要的sql语句

 * @Author 崔天帅

 * @Date 2013-6-12下午04:33:10
 */
public class YGZSqlGenerateUtil {
	
	/**
	 * 
	 * @Title generateSelectERPProjEquipInfoSql
	
	 * @Param contractId 合同编号
	
	 * @Description 获取租赁物件编号equip_id 添加条件leas_form = '直租'2013-07-26
	
	 * @Return String
	
	 * @throw
	 */
	public static String generateSelectERPProjEquipInfoSql(String contractId) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr.append("select equip_id from vi_contract_htzx_erp_crm where contract_id='"+contractId + "' and fact_date <> '' and leas_form = '直租'");
		// 3返回
		return sqlStr.toString();
	}
	//cui添加条件leas_form = '直租'2013-07-26
	public static String generateSelectERPVendProjInfoSql(String contractId,String equip_id) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr.append("select * from vi_contract_htzx_erp_crm where contract_id='"+contractId+"' and equip_id='"+equip_id+"' and leas_form='直租'");
		// 3返回
		return sqlStr.toString();
	}
	//cui
	public static String generateSelectERPVendProjInfoSql(String contractId) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr.append("select * from vi_contract_htzx_erp_crm where contract_id='"+contractId+"'");
		// 3返回
		return sqlStr.toString();
	}
	/**
	 * 
	 * @Title getInsertVendProOfSql
	
	 * @Param vendProBean 供应商项目信息Bean
	
	 * @Description 插入供应商租赁项目信息sql
	
	 * @Return String
	
	 * @throw
	 */
	public static String getInsertVendProOfSql(VendProBean vendProBean) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr.append("insert into vend_pro(id,sname,idpro,idvendor,ventype,equip,models,producer,darrive,days,idowner,iddep,sflag,equipid,created,certific,dvalid)" +
				" values(lower(replace(newid(),'-','')),'"+vendProBean.getSname()+"','"+vendProBean.getIdpro()+"','"+vendProBean.getIdvendor()
				+"','"+vendProBean.getVentype()+"','"+vendProBean.getEquip()+"','"+vendProBean.getModels()+"','"+vendProBean.getProducer()
				+"','"+vendProBean.getDarrive()+"',datediff(d,'"+vendProBean.getPlan_date()+"','"+vendProBean.getDarrive()+"'),'"+vendProBean.getIdowner()
				+"','"+vendProBean.getIddep()+"','"+vendProBean.getSflag()+"','"+vendProBean.getEquip_id()+"',getdate(),'"+vendProBean.getQualification_name()+"',(case when '"+vendProBean.getQualification_date()+"' = '1900-01-01' then null else '"+vendProBean.getQualification_date()+"' end))");
		// 3返回
		
		return sqlStr.toString();
	}
	
	/**
	 * 
	 * @Title getUpdateVendProOfSql
	
	 * @Param vendProBean 供应商项目信息Bean
	
	 * @Description 更新供应商租赁项目信息sql
	
	 * @Return String
	
	 * @throw
	 */
	public static String getUpdateVendProOfSql(VendProBean vendProBean) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr.append("update vend_pro set days = datediff(d,'"+vendProBean.getPlan_date()+"','"+vendProBean.getDarrive()+"'),darrive='"+vendProBean.getDarrive()+"',ventype='"+
				vendProBean.getVentype()+"' where idpro='"+
				vendProBean.getIdpro()+"' and equipid='"+vendProBean.getEquip_id()+"'");
		// 3返回
		return sqlStr.toString();
	}
	//获取项目名称与ID
	public static String generateSelectERPProjBadInfoSql(String contractId) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr.append("select proj_id,project_name from contract_info where contract_id='"+contractId+"'");
		// 3返回
		return sqlStr.toString();
	}
	/**
	 * 
	 * @Title getInsertVbadOfSql
	
	 * @Param @param vbadinfoBean
	
	 * @Description 插入不良信息Sql
	
	 * @Return String
	
	 * @throw
	 */
	public static String getInsertVbadOfSql(VbadinfoBean vbadinfoBean) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr.append("insert into vbadinfo (id,sname,iddep,idowner,idpro,idvendor,delivery,created,sflag)" +
				" values(lower(replace(newid(),'-','')),'"+vbadinfoBean.getSname()+"','"+vbadinfoBean.getIddep()+"','"+
				vbadinfoBean.getIdowner()+"','"+vbadinfoBean.getIdpro()
				+"','"+vbadinfoBean.getIdvendor()+"','"+vbadinfoBean.getDelivery()+"',getdate(),'1')");
		// 3返回
		return sqlStr.toString();
	}
	/**
	 * 
	 * @Title getUpdateBadOfSql
	 * @Param @param vbadinfoBean
	 * @Description 更新不良信息Sql
	
	 * @Return String
	
	 * @throw
	 */
	public static String getUpdateBadOfSql(VbadinfoBean vbadinfoBean) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr.append("update vbadinfo set delivery='"+vbadinfoBean.getDelivery()+"',sflag='2' where idpro='"+vbadinfoBean.getIdpro()+"' and idvendor='"+vbadinfoBean.getIdvendor()+"'");
		// 3返回
		return sqlStr.toString();
	}

	/**
	 * 
	 * @Title generateSelectERPProjZJJHInfoSql
	
	 * @Param @param contractId
	
	 * @Description 获取供应商银行账号信息sql 2013-07-26修改ca.acc_number、添加 and cf.pay_bank_no is not null
	
	 * @Return String
	
	 * @throw
	 */
	public static String generateSelectERPProjZJJHInfoSql(String contractId) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr.append("select DISTINCT cf.contract_id,cf.pay_obj,ca.crm_account_id,cf.pay_bank_no " +
				"from contract_fund_fund_charge_plan cf left join contract_info ci on cf.contract_id = ci.contract_id left join cust_account ca " +
				"on cf.pay_obj=ca.cust_id and replace(cf.pay_bank_no,' ','')=replace(ca.acc_number,' ','') " +
				"where cf.contract_id='"+contractId+"' and ci.leas_form = '直租' and cf.pay_way='付款' and cf.fee_type='17' and cf.pay_bank_no is not null");
		// 3返回
		return sqlStr.toString();
	}
	/**
	 * 
	 * @Title getInsertGysxmOfSql
	
	 * @Param @param contractPlanBean
	 * @Param @param uuid
	
	 * @Description 插入供应商项目信息Sql
	
	 * @Return String
	
	 * @throw
	 */
	public static String getInsertGysxmOfSql(ContractPlanBean contractPlanBean){
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr.append("insert into gysxm(id,sname,idpro,idvendor,idbank,sopening,iddep,idowner,created,sflag,idperson,sphone)" +
				" values(lower(replace(newid(),'-','')),'"+contractPlanBean.getProjname()+"',(case when '"+contractPlanBean.getProj_id()
				+"' = 'null' then NULL else '"+contractPlanBean.getProj_id()+"' end),'"+contractPlanBean.getPay_obj()+"','"+contractPlanBean.getPay_bank_name()+
				"','"+contractPlanBean.getPay_bank_no()+"','"+contractPlanBean.getId_dept()+"','"+
				contractPlanBean.getId_owner()+"',getdate(),'1','"+contractPlanBean.getId_person()+"','"+contractPlanBean.getPhone()+"')");
		// 3返回
		return sqlStr.toString();
	}
}
