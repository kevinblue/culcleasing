package com.webService.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tenwa.culc.util.OperationUtil;
import com.tenwa.log.LogWriter;
import com.webService.bean.GlobalInterestSubsidyBean;
import com.webService.dao.GlobalInterestSubsidyDao;



public class GlobalInterestSubsidyService {
	
	public static void main(String[] args) {
		dataSync();
	}

	/**
	 * [确认利息补贴(应收)]批量数据同步
	 * 
	 * 每月10号执行程序
	 * 
	 * @return 本次同步数量
	 */
	public static int dataSync() {
		int amount = 0;
		String syncType = "确认利息补贴";
		// 1.从ERP数据库服务器读出数据保存在List
		List<GlobalInterestSubsidyBean> globalInterestSubsidyList = new ArrayList<GlobalInterestSubsidyBean>();
		GlobalInterestSubsidyDao globalInterestSubsidyDao = new GlobalInterestSubsidyDao();

		try {
			// 1.1从ERP 服务器读取数据
			globalInterestSubsidyList = globalInterestSubsidyDao
					.readGlobalInterestSubsidy(syncType);
		}catch (SQLException e) {
			try {
				OperationUtil.ERPoperationExceptionLog(
						"DATA_SYNC_GLOBAL_INTERESTSUBSIDY_NC", "NC确认利息补贴数据同步",
						"读取异常：" + e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("读取ERP Server [" + syncType + "]数据异常，\n异常信息：\n"
					+ e.getMessage());
		}

		// 2.将List数据同步到Oracle 财务接口数据库服务器
		try {
			globalInterestSubsidyDao.insert2OracleData(
					globalInterestSubsidyList, syncType);
		} catch (Exception e) {
			try {
				OperationUtil.ERPoperationExceptionLog(
						"DATA_SYNC_GLOBAL_INTERESTSUBSIDY_NC", "NC确认利息补贴数据同步",
						"传输异常：" + e.getMessage());
			}catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("更新Fina Interface Server [" + syncType
					+ "] 异常,\n异常信息: \n" + e.getMessage());
		}

		// 本次执行操作总数量
		amount = globalInterestSubsidyList.size();
		return amount;
	}
}
