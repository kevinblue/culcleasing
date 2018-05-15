package com.webService.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tenwa.culc.util.OperationUtil;
import com.tenwa.log.LogWriter;
import com.webService.bean.GlobalProjectEndBean;
import com.webService.dao.GlobalProjectEndDao;


public class GlobalProjectEndService {

	/**
	 * [合同结清(收款单)]批量数据同步 每日晚2点执行
	 * 
	 * @return 本次同步数量
	 */
	public static int dataSync() {
		int amount = 0;
		String syncType = "合同结清";
		// 1.从ERP数据库服务器读出数据保存在List
		List<GlobalProjectEndBean> globalProjectEndBeanList = new ArrayList<GlobalProjectEndBean>();
		GlobalProjectEndDao globalProjectEndDao = new GlobalProjectEndDao();

		try {
			// 1.1从ERP 服务器读取数据
			globalProjectEndBeanList = globalProjectEndDao
					.readGlobalInterestSubsidy(syncType);
			System.out.println("-------------取值-----------");
		} catch (SQLException e) {
			try {
				OperationUtil.ERPoperationExceptionLog(
						"DATA_SYNC_GLOBAL_PROJECTEND_NC", "合同结清数据同步", "读取异常："
								+ e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("读取ERP Server [" + syncType + "]数据异常，\n异常信息：\n"
					+ e.getMessage());
			System.out.println("-------------报错一-----------");
		}

		// 2.将List数据同步到Oracle 财务接口数据库服务器
		try {
			globalProjectEndDao.insert2OracleData(globalProjectEndBeanList,syncType);
			System.out.println("-------------传值-----------");
		} catch (Exception e) {
			try {
				OperationUtil.ERPoperationExceptionLog(
						"DATA_SYNC_GLOBAL_PROJECTEND_NC", "合同结清数据同步", "读取异常："
								+ e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("更新Fina Interface Server [" + syncType
					+ "] 异常,\n异常信息: \n" + e.getMessage());
			System.out.println("-------------报错二-----------");
		}

		// 本次执行操作总数量
		amount = globalProjectEndBeanList.size();
		return amount;
	}
	
	public static void main(String[] args) {
		dataSync();
		
		
	}
}
