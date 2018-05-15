/**
 * com.tenwa.culc.service
 */
package com.tenwa.culc.service;

import java.sql.SQLException;

import com.tenwa.culc.dao.FundChargeDao;
import com.tenwa.log.LogWriter;

/**
 * 资金计划操作类
 * 
 * @author Jaffe
 * 
 * Date:Jul 6, 2011 4:29:24 PM Email:JaffeHe@hotmail.com
 */
public class FundChargeOperationService {

	/**
	 * 项目资金计划数据初始化
	 * 
	 * @param proj_id
	 * @param contract_id
	 * @param doc_id
	 * @return
	 */
	public static int initContractFundData(String proj_id, String contract_id,
			String doc_id) {
		int dataFlag = 0;
		// 1.先判断 该合同编号 + doc_id 在contract_fund_fund_charge_plan_temp是否存在数据
		FundChargeDao fundChargeDao = new FundChargeDao();
		int flag = 0;
		try {
			flag = fundChargeDao.existsData(contract_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2.如果不存在则将
		// proj_fund_fund_charge_plan表数据拷贝到contract_fund_fund_charge_plan_temp
		if (flag == 0) {
			dataFlag = 2;
			try {
				fundChargeDao.copyData(proj_id, contract_id, doc_id);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else {
			// 3.如果存在则结束
			dataFlag = 1;
		}

		LogWriter.logDebug("执行拷贝,返回结果：" + dataFlag);

		return dataFlag;
	}

	/**
	 * 流程开始的时候初始化资金计划+资金付款前提 数据
	 * 
	 * @param proj_id
	 * @param doc_id
	 */
	public static void flowInitTableData(String proj_id, String doc_id) {
		LogWriter.logDebug("执行流程初始化【项目资金计划】【项目资金付款前提】数据");
		// 1先判断proj_fund_fund_charge_plan_temp表是否存在数据
		// 1.FundChargeDao实例化
		boolean flag = false;
		FundChargeDao fundChargeDao = new FundChargeDao();
		try {
			flag = fundChargeDao.judgeItemExist(proj_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2存在则执行完毕
		if (flag) {
			LogWriter.logDebug("项目Id:" + proj_id + " 文档Id:" + doc_id
					+ " 数据在[proj_fund_fund_charge_plan_temp]中存在");
		} else {
			// 3不存在则将proj_fund_fund_charge_plan正式表数据拷贝临时表
			try {
				fundChargeDao.copyData2Temp(proj_id, doc_id);
				LogWriter.logDebug("项目Id:" + proj_id + " 文档Id:" + doc_id
						+ " 数据[项目资金计划][项目资金付款前提]初始化完成");
			} catch (SQLException e) {
				LogWriter
						.logError("项目Id:" + proj_id + " 文档Id:" + doc_id
								+ " 数据[项目资金计划][项目资金付款前提]初始化异常，异常信息：\t"
								+ e.getMessage());
			}
		}
	}

	/**
	 * 租后流程开始的时候初始化合同资金计划、合同付款前提表数据
	 * 
	 * @param contract_id
	 * @param doc_id
	 */
	public static void flowInitContractData(String contract_id, String doc_id) {
		LogWriter
				.logDebug("执行流程初始化[合同资金计划][合同资金付款前提][contract_fund_fund_charge_plan_temp][contract_fund_fund_charge_condition_temp]数据");
		// 1先判断contract_fund_fund_charge_plan_temp表是否存在数据
		// 1.FundChargeDao实例化
		boolean flag = false;
		FundChargeDao fundChargeDao = new FundChargeDao();
		try {
			flag = fundChargeDao.judgeContractDataExist(contract_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2存在则执行完毕
		if (flag) {
			LogWriter.logDebug("合同Id:" + contract_id + " 文档Id:" + doc_id
					+ " 数据在[合同资金计划][contract_fund_fund_charge_plan_temp]中存在");
		} else {
			// 3不存在则将proj_fund_fund_charge_plan正式表数据拷贝临时表
			try {
				fundChargeDao.copyData2ContractTemp(contract_id, doc_id);
				LogWriter
						.logDebug("合同Id:"
								+ contract_id
								+ " 文档Id:"
								+ doc_id
								+ " 数据[合同资金计划][contract_fund_fund_charge_plan_temp]初始化完成");
			} catch (SQLException e) {
				LogWriter
						.logError("合同Id:"
								+ contract_id
								+ " 文档Id:"
								+ doc_id
								+ " 数据[合同资金计划][contract_fund_fund_charge_plan_temp]初始化异常，异常信息：\t"
								+ e.getMessage());
			}
		}
	}
	/**
	 * 方案2
	 * 租后流程开始的时候初始化合同资金计划、合同付款前提表数据  
	 * 
	 * @param contract_id
	 * @param doc_id
	 */
	public static void flowInitContractData2(String contract_id, String doc_id) {
		LogWriter
				.logDebug("执行流程初始化[合同资金计划][合同资金付款前提][contract_fund_fund_charge_plan_temp][contract_fund_fund_charge_condition_temp]数据");
		// 1先判断contract_fund_fund_charge_plan_temp表是否存在数据
		// 1.FundChargeDao实例化
		boolean flag = false;
		FundChargeDao fundChargeDao = new FundChargeDao();
		try {
			flag = fundChargeDao.judgeContractDataExist(contract_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2存在则执行完毕
		if (flag) {
			LogWriter.logDebug("合同Id:" + contract_id + " 文档Id:" + doc_id
					+ " 数据在[合同资金计划][contract_fund_fund_charge_plan_temp]中存在");
		} else {
			// 3不存在则将proj_fund_fund_charge_plan正式表数据拷贝临时表
			try {
				fundChargeDao.copyData2ContractTemp2(contract_id, doc_id);
				LogWriter
						.logDebug("合同Id:"
								+ contract_id
								+ " 文档Id:"
								+ doc_id
								+ " 数据[合同资金计划][contract_fund_fund_charge_plan_temp]初始化完成");
			} catch (SQLException e) {
				LogWriter
						.logError("合同Id:"
								+ contract_id
								+ " 文档Id:"
								+ doc_id
								+ " 数据[合同资金计划][contract_fund_fund_charge_plan_temp]初始化异常，异常信息：\t"
								+ e.getMessage());
			}
		}
	}

	/**
	 * 资金计划上报 - 拷贝未核销资金进行修改资金付款日期
	 * 
	 * @param contract_id
	 * @param doc_id
	 */
	public static void initContractFundDataZJJHSB(String contract_id,
			String doc_id) {
		LogWriter
				.logDebug("执行流程[资金计划上报][contract_fund_fund_charge_plan_temp]拷贝未核销资金数据");
		// 1先判断contract_fund_fund_charge_plan_temp表是否存在数据
		// 1.FundChargeDao实例化
		boolean flag = false;
		FundChargeDao fundChargeDao = new FundChargeDao();
		try {
			flag = fundChargeDao.judgeContractDataExist(contract_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2存在则执行完毕
		if (flag) {
			LogWriter.logDebug("合同Id:" + contract_id + " 文档Id:" + doc_id
					+ " 数据在[合同资金计划][contract_fund_fund_charge_plan_temp]中存在");
		} else {
			// 3不存在则将proj_fund_fund_charge_plan正式表数据拷贝临时表
			try {
				fundChargeDao.copyData2ContractTempZJJHSB(contract_id, doc_id);
				LogWriter
						.logDebug("合同Id:"
								+ contract_id
								+ " 文档Id:"
								+ doc_id
								+ " 数据[合同资金计划][contract_fund_fund_charge_plan_temp]初始化完成");
			} catch (SQLException e) {
				LogWriter
						.logError("合同Id:"
								+ contract_id
								+ " 文档Id:"
								+ doc_id
								+ " 数据[合同资金计划][contract_fund_fund_charge_plan_temp]初始化异常，异常信息：\t"
								+ e.getMessage());
			}
		}
	}

	/**
	 * 商务方案修订 - 拷贝未核销资金进行修改资金付款日期
	 * 
	 * @param contract_id
	 * @param doc_id
	 */
	public static void initContractFundDataSWFAXD(String contract_id,
			String doc_id) {
		LogWriter
				.logDebug("执行流程[商务方案修订][contract_fund_fund_charge_plan_temp]拷贝未核销资金数据");
		// 1先判断contract_fund_fund_charge_plan_temp表是否存在数据
		// 1.FundChargeDao实例化
		boolean flag = false;
		FundChargeDao fundChargeDao = new FundChargeDao();
		try {
			flag = fundChargeDao.judgeContractDataExist(contract_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2存在则执行完毕
		if (flag) {
			LogWriter.logDebug("合同Id:" + contract_id + " 文档Id:" + doc_id
					+ " 数据在[合同资金计划][contract_fund_fund_charge_plan_temp]中存在");
		} else {
			// 3不存在则将proj_fund_fund_charge_plan正式表数据拷贝临时表
			try {
				fundChargeDao.copyData2ContractTempSWFAXD(contract_id, doc_id);
				LogWriter
						.logDebug("合同Id:"
								+ contract_id
								+ " 文档Id:"
								+ doc_id
								+ " 数据[合同资金计划][contract_fund_fund_charge_plan_temp]初始化完成");
			} catch (SQLException e) {
				LogWriter
						.logError("合同Id:"
								+ contract_id
								+ " 文档Id:"
								+ doc_id
								+ " 数据[合同资金计划][contract_fund_fund_charge_plan_temp]初始化异常，异常信息：\t"
								+ e.getMessage());
			}
		}
	}
	/**
	 * 先将  type等于22 的 租前期确认
	 * 
	 * @param contract_id
	 * @param doc_id
	 */
	public static void initContractFundDataZQQQR(String contract_id,
			String doc_id) {
		LogWriter
				.logDebug("执行流程[租前期确认][contract_fund_fund_charge_plan_temp]拷贝未核销资金数据");
		// 1先判断contract_fund_fund_charge_plan_temp表是否存在数据
		// 1.FundChargeDao实例化
		boolean flag = false;
		FundChargeDao fundChargeDao = new FundChargeDao();
		try {
			flag = fundChargeDao.judgeContractDataExist(contract_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2存在则执行完毕
		if (flag) {
			LogWriter.logDebug("合同Id:" + contract_id + " 文档Id:" + doc_id
					+ " 数据在[合同资金计划][contract_fund_fund_charge_plan_temp]中存在");
		} else {
			// 3不存在则将proj_fund_fund_charge_plan正式表数据拷贝临时表
			try {
				fundChargeDao.copyData2ContractTempZQQQR(contract_id, doc_id);
				LogWriter
						.logDebug("合同Id:"
								+ contract_id
								+ " 文档Id:"
								+ doc_id
								+ " 数据[合同资金计划][contract_fund_fund_charge_plan_temp]初始化完成");
			} catch (SQLException e) {
				LogWriter
						.logError("合同Id:"
								+ contract_id
								+ " 文档Id:"
								+ doc_id
								+ " 数据[合同资金计划][contract_fund_fund_charge_plan_temp]初始化异常，异常信息：\t"
								+ e.getMessage());
			}
		}
	}

	/**
	 * 签约审批流程初始化合同资金计划、合同资金付款前提
	 * 
	 * @param contract_id
	 * @param proj_id
	 * @param doc_id
	 */
	public static void flowInitContractApproveData(String contract_id,
			String proj_id, String doc_id) {
		LogWriter
				.logDebug("执行合同资金计划[contract_fund_fund_charge_plan_temp]合同资金付款前提[contract_fund_fund_charge_condition_temp]签约审批流程初始化数据");
		// 1先判断proj_document_temp表是否存在数据
		// 1.FundChargeDao实例化
		boolean flag = false;
		FundChargeDao fundChargeDao = new FundChargeDao();
		try {
			flag = fundChargeDao.judgeItemContractExist(contract_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2存在则执行完毕
		if (flag) {
			LogWriter.logDebug("合同Id:" + contract_id + " 文档Id:" + doc_id
					+ " 数据在contract_fund_fund_charge_plan_temp中存在");
		} else {
			// 3不存在则将proj_document正式表数据拷贝临时表
			try {
				fundChargeDao.copyData2ContractTemp(contract_id, proj_id,
						doc_id);
				LogWriter.logDebug("项目Id:" + proj_id + " 文档Id:" + doc_id
						+ " 数据[contract_document_temp]初始化完成");
			} catch (SQLException e) {
				LogWriter.logError("项目Id:" + proj_id + " 文档Id:" + doc_id
						+ " 数据[contract_document_temp]初始化异常，异常信息：\t"
						+ e.getMessage());
			}
		}

	}
}
