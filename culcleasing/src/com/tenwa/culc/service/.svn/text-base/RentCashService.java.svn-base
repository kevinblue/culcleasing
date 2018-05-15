/**
 * com.tenwa.culc.service
 */
package com.tenwa.culc.service;

import java.sql.SQLException;
import java.util.List;

import com.tenwa.culc.bean.RentCashBean;
import com.tenwa.culc.dao.RentCashDao;
import com.tenwa.log.LogWriter;

/**
 * @author Jaffe
 * 
 * Date:Jul 13, 2011 10:24:12 AM Email:JaffeHe@hotmail.com
 */
public class RentCashService {

	/**
	 * 保存上传Excel测算文件里现金流数据
	 * 
	 * @param rentCashList
	 * @param proj_id
	 * @param doc_id
	 */
	public static void saveUploadRentCashList(List<RentCashBean> rentCashList,
			String proj_id, String doc_id) {
		// 2. === 将数据更新 ====
		RentCashDao rentCashDao = new RentCashDao();
		// 2.1删除历史数据
		try {
			rentCashDao.deleteRentCashProjTempHisData(proj_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2.2保存最新数据
		int resVal = 0;
		try {
			resVal = rentCashDao.updateRentCashProjTempData(rentCashList);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		LogWriter.logDebug("更新proj_Id:" + proj_id + " 的项目现金流临时表数据，更新结果："
				+ (resVal == 0 ? "失败" : "成功"));
	}

	/**
	 * 保存上传Excel测算文件里合同现金流数据
	 * 
	 * @param rentCashList
	 * @param contract_id
	 * @param doc_id
	 */
	public static void saveUploadRentCashContractList(
			List<RentCashBean> rentCashList, String contract_id, String doc_id) {
		// 2. === 将数据更新 ====
		RentCashDao rentCashDao = new RentCashDao();
		// 2.1删除历史数据
		try {
			rentCashDao.deleteRentCashContractTempHisData(contract_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2.2保存最新数据
		int resVal = 0;
		try {
			resVal = rentCashDao.updateRentCashContractTempData(rentCashList);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		LogWriter.logDebug("更新contract_id:" + contract_id
				+ " 的合同现金流临时表数据，更新结果：" + (resVal == 0 ? "失败" : "成功"));
	}

	/**
	 * 流程开始的时候初始化项目现金流计划表数据
	 * 
	 * @param proj_id
	 * @param doc_id
	 */
	public static void flowInitTableData(String proj_id, String doc_id) {
		LogWriter.logDebug("执行流程初始化【项目租金现金流临时表】【fund_proj_plan_mark_temp】数据");
		// 1先判断fund_proj_plan_mark_temp表是否存在数据
		// 1.RentCashDao实例化
		boolean flag = false;
		RentCashDao rentCashDao = new RentCashDao();
		try {
			flag = rentCashDao.judgeItemExist(proj_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2存在则执行完毕
		if (flag) {
			LogWriter.logDebug("项目Id:" + proj_id + " 文档Id:" + doc_id
					+ " 数据在fund_proj_plan_mark_temp中存在");
		} else {
			// 3不存在则将proj_fund_fund_charge_plan正式表数据拷贝临时表
			try {
				rentCashDao.copyData2Temp(proj_id, doc_id);
				LogWriter.logDebug("项目Id:" + proj_id + " 文档Id:" + doc_id
						+ " 数据[项目租金现金流临时表][fund_proj_plan_mark_temp]初始化完成");
			} catch (SQLException e) {
				LogWriter
						.logError("项目Id:"
								+ proj_id
								+ " 文档Id:"
								+ doc_id
								+ " 数据[项目租金现金流临时表][fund_proj_plan_mark_temp]初始化异常，异常信息：\t"
								+ e.getMessage());
			}
		}
	}

	/**
	 * 租后流程开始的时候初始化合同现金流表数据
	 * 
	 * @param contract_id
	 * @param doc_id
	 */
	public static void flowInitContractData(String contract_id, String doc_id) {
		LogWriter.logDebug("执行流程初始化[合同现金流临时表][fund_contract_plan_mark_temp]数据");
		// 1先判断fund_contract_plan_mark_temp表是否存在数据
		// 1.RentCashDao实例化
		boolean flag = false;
		RentCashDao rentCashDao = new RentCashDao();
		try {
			flag = rentCashDao.judgeContractDataExist(contract_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2存在则执行完毕
		if (flag) {
			LogWriter.logDebug("合同Id:" + contract_id + " 文档Id:" + doc_id
					+ " 数据在[合同现金流临时表][fund_contract_plan_mark_temp]中存在");
		} else {
			// 3不存在则将proj_fund_fund_charge_plan正式表数据拷贝临时表
			try {
				rentCashDao.copyData2ContractTemp(contract_id, doc_id);
				LogWriter.logDebug("合同Id:" + contract_id + " 文档Id:" + doc_id
						+ " 数据[合同现金流临时表][fund_contract_plan_mark_temp]初始化完成");
			} catch (SQLException e) {
				LogWriter
						.logError("合同Id:"
								+ contract_id
								+ " 文档Id:"
								+ doc_id
								+ " 数据[合同现金流临时表][fund_contract_plan_mark_temp]初始化异常，异常信息：\t"
								+ e.getMessage());
			}
		}
	}

	/**
	 * 签约审批流程初始化合同现金流临时表数据
	 * 
	 * @param contract_id
	 * @param proj_id
	 * @param doc_id
	 */
	public static void flowInitContractApproveData(String contract_id,
			String proj_id, String doc_id) {
		LogWriter
				.logDebug("执行合同现金流临时表[fund_contract_plan_mark_temp]签约审批流程初始化数据");
		// 1先判断contract_condition_temp表是否存在数据
		// 1.RentPlanDao实例化
		boolean flag = false;
		RentCashDao rentCashDao = new RentCashDao();
		try {
			flag = rentCashDao.judgeItemContractExist(contract_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2存在则执行完毕
		if (flag) {
			LogWriter.logDebug("合同Id:" + contract_id + " 文档Id:" + doc_id
					+ " 数据在[fund_contract_plan_mark_temp]中存在");
		} else {
			// 3不存在则将proj_document正式表数据拷贝临时表
			try {
				rentCashDao.copyData2ContractTemp(contract_id, proj_id, doc_id);
				LogWriter.logDebug("合同Id:" + contract_id + " 文档Id:" + doc_id
						+ " 数据[fund_contract_plan_mark_temp]初始化完成");
			} catch (SQLException e) {
				LogWriter.logError("合同Id:" + contract_id + " 文档Id:" + doc_id
						+ " 数据[fund_contract_plan_mark_temp]初始化异常，异常信息：\t"
						+ e.getMessage());
			}
		}

	}
}
