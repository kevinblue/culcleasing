/**
 * com.tenwa.culc.service
 */
package com.tenwa.culc.service;

import java.sql.SQLException;

import com.tenwa.culc.dao.ProjMaterDao;
import com.tenwa.log.LogWriter;

/**
 * 项目资料Service
 * 
 * @author Jaffe
 * 
 * Date:Jul 14, 2011 10:13:05 AM Email:JaffeHe@hotmail.com
 */
public class ProjMaterService {

	/**
	 * 流程开始的时候初始化项目资料清单表数据
	 * 
	 * @param proj_id
	 * @param doc_id
	 */
	public static void flowInitTableData(String proj_id, String doc_id) {
		LogWriter.logDebug("执行项目资料流程初始化数据");
		// 1先判断proj_document_temp表是否存在数据
		// 1.ProjMaterDao实例化
		boolean flag = false;
		ProjMaterDao projMaterDao = new ProjMaterDao();
		try {
			flag = projMaterDao.judgeItemExist(proj_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2存在则执行完毕
		if (flag) {
			LogWriter.logDebug("项目Id:" + proj_id + " 文档Id:" + doc_id
					+ " 数据在proj_document_temp中存在");
		} else {
			// 3不存在则将proj_document正式表数据拷贝临时表
			try {
				projMaterDao.copyData2Temp(proj_id, doc_id);
				LogWriter.logDebug("项目Id:" + proj_id + " 文档Id:" + doc_id
						+ " 数据初始化完成");
			} catch (SQLException e) {
				LogWriter.logError("项目Id:" + proj_id + " 文档Id:" + doc_id
						+ " 数据初始化异常，异常信息：\t" + e.getMessage());
			}
		}
	}

	/**
	 * 组后流程启动合同表数据拷贝
	 * 
	 * @param contract_id
	 * @param doc_id
	 */
	public static void flowInitContractData(String contract_id, String doc_id) {
		LogWriter.logDebug("执行合同资料流程初始化数据");
		// 1先判断contract_document_temp表是否存在数据
		// 1.ProjMaterDao实例化
		boolean flag = false;
		ProjMaterDao projMaterDao = new ProjMaterDao();
		try {
			flag = projMaterDao.judgeContractItemExist(contract_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2存在则执行完毕
		if (flag) {
			LogWriter.logDebug("合同Id:" + contract_id + " 文档Id:" + doc_id
					+ " 数据在[contract_document_temp]中存在");
		} else {
			// 3不存在则将proj_document正式表数据拷贝临时表
			try {
				projMaterDao.copyData2ContractTemp(contract_id, doc_id);
				LogWriter.logDebug("合同Id:" + contract_id + " 文档Id:" + doc_id
						+ " 数据[contract_document_temp]初始化完成");
			} catch (SQLException e) {
				LogWriter.logError("合同Id:" + contract_id + " 文档Id:" + doc_id
						+ " 数据[contract_document_temp]初始化异常，异常信息：\t" + e.getMessage());
			}
		}
	}

	/**
	 * 签约审批流程初始化项目资料数据
	 * 
	 * @param contract_id
	 * @param proj_id
	 * @param doc_id
	 */
	public static void flowInitContractApproveData(String contract_id,
			String proj_id, String doc_id) {
		LogWriter.logDebug("执行项目资料[contract_document_temp]签约审批流程初始化数据");
		// 1先判断proj_document_temp表是否存在数据
		// 1.ProjMaterDao实例化
		boolean flag = false;
		ProjMaterDao projMaterDao = new ProjMaterDao();
		try {
			flag = projMaterDao.judgeItemContractExist(contract_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2存在则执行完毕
		if (flag) {
			LogWriter.logDebug("合同Id:" + contract_id + " 文档Id:" + doc_id
					+ " 数据在contract_document_temp中存在");
		} else {
			// 3不存在则将proj_document正式表数据拷贝临时表
			try {
				projMaterDao
						.copyData2ContractTemp(contract_id, proj_id, doc_id);
				LogWriter.logDebug("合同Id:" + contract_id + " 文档Id:" + doc_id
						+ " 数据[contract_document_temp]初始化完成");
			} catch (SQLException e) {
				LogWriter.logError("合同Id:" + contract_id + " 文档Id:" + doc_id
						+ " 数据[contract_document_temp]初始化异常，异常信息：\t"
						+ e.getMessage());
			}
		}

	}
}
