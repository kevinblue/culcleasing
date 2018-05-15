/**
 * com.tenwa.culc.service
 */
package com.tenwa.culc.service;

import java.sql.SQLException;

import com.tenwa.culc.dao.CustAccountDao;
import com.tenwa.log.LogWriter;


/**
 * @author Toybaby
 * 2014-03-24
 * 用于合同审流程页面初始化判断合同银行帐号临时表中是否有数据
 *
 */
public class CustAccountOperationService {

	/**
	 * @param contract_id
	 * @param doc_id
	 * 用于合同审流程页面初始化判断合同银行帐号临时表中是否有数据
	 */
	public static void flowInitContractApproveAccountData(String contract_id,String cust_id,
			 String doc_id, String proj_id) {
		LogWriter
				.logDebug("执行合同审批[contract_cust_account_temp]合同银行帐户[contract_cust_account_temp]签约审批流程初始化数据");
		// 1先判断proj_document_temp表是否存在数据
		// 1.CustAccountDao实例化
		boolean flag = false;
		CustAccountDao custAccountDao = new CustAccountDao();
		try {
			//flag = custAccountDao.existsData(contract_id, doc_id);
			flag = custAccountDao.existsData(contract_id, doc_id,0);
			System.out.println(flag+"==========================================================1");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2存在则执行完毕
		if (flag) {
			LogWriter.logDebug("合同Id:" + contract_id + " 文档Id:" + doc_id
					+ " 数据在contract_cust_account_temp中存在");
		} else {
			// 3不存在则将正式表数据拷贝临时表
			try {
				flag = custAccountDao.existsData(contract_id, doc_id,1);
				System.out.println(flag+"==========================================================2");
				if(flag == true){
					custAccountDao.copyDataToContractTemp(contract_id, cust_id, doc_id);
				}else{
					flag = custAccountDao.existsProjData(proj_id, doc_id, 1);
					System.out.println(flag+"==========================================================3");
					if(flag == true){
						custAccountDao.copyDataFromProjToContractTemp(contract_id, cust_id, doc_id,proj_id);
					}
				}
				
				//custAccountDao.copyData(contract_id, cust_id,
				//		doc_id);
				LogWriter.logDebug("项目Id: 文档Id:" + doc_id
						+ " 数据[contract_cust_account_temp]初始化完成");
			} catch (SQLException e) {
				LogWriter.logError("项目Id: 文档Id:" + doc_id
						+ " 数据[contract_cust_account_temp]初始化异常，异常信息：\t"
						+ e.getMessage());
			}
		}

	}
	
	/**
	 * @param proj_id
	 * @param doc_id
	 * 用于合同审流程页面初始化判断合同银行帐号临时表中是否有数据
	 */
	public static void flowInitProjApproveAccountData(String proj_id,String cust_id,
			 String doc_id) {
		LogWriter
				.logDebug("执行合同审批[contract_cust_account_temp]合同银行帐户[contract_cust_account_temp]签约审批流程初始化数据");
		// 1先判断proj_document_temp表是否存在数据
		// 1.CustAccountDao实例化
		boolean flag = false;
		CustAccountDao custAccountDao = new CustAccountDao();
		try {
			flag = custAccountDao.existsProjData(proj_id, doc_id,0);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2存在则执行完毕
		if (flag) {
			LogWriter.logDebug("合同Id:" + proj_id + " 文档Id:" + doc_id
					+ " 数据在contract_cust_account_temp中存在");
		} else {
			// 3不存在则将正式表数据拷贝临时表
			try {
				flag = custAccountDao.existsProjData(proj_id, doc_id,1);
				if(flag == true){
					custAccountDao.copyDataToProjTemp(proj_id, cust_id, doc_id);
				}
				
				//custAccountDao.copyData(proj_id, cust_id,
				//		doc_id);
				LogWriter.logDebug("项目Id: 文档Id:" + doc_id
						+ " 数据[contract_cust_account_temp]初始化完成");
			} catch (SQLException e) {
				LogWriter.logError("项目Id: 文档Id:" + doc_id
						+ " 数据[contract_cust_account_temp]初始化异常，异常信息：\t"
						+ e.getMessage());
			}
		}

	}
}
