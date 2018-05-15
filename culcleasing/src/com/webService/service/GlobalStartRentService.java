/**
 * com.tenwa.datasync.finance.service
 */
package com.webService.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tenwa.culc.util.OperationUtil;
import com.tenwa.log.LogWriter;
import com.webService.bean.GlobalStartRentBean;
import com.webService.dao.GlobalStartRentDao;


/**
 * 起租
 * 
 * @author toybaby Date:Sep 13, 20112:34:11 PM Email: toybaby@mail2.tenwa.com.cn
 */
public class GlobalStartRentService {

	/**
	 * [起租(应收)]批量数据同步 每晚2点
	 * 
	 * @return 本次同步数量
	 */
	public static int dataSync() {
		int amount = 0;
		String syncType = "起租";
		// 1.从ERP数据库服务器读出数据保存在List
		List<GlobalStartRentBean> globalStartRentList = new ArrayList<GlobalStartRentBean>();
		GlobalStartRentDao globalStartRentDao = new GlobalStartRentDao();

		try {
			// 1.1从ERP 服务器读取数据
			globalStartRentList = globalStartRentDao
					.readGlobalStartRentData(syncType);
		} catch (SQLException e) {
			try {
				OperationUtil.ERPoperationExceptionLog(
						"DATA_SYNC_GLOBAL_START_RENT_NC", "起租数据同步", "读取异常："
								+ e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("读取ERP Server [" + syncType + "]数据异常，\n异常信息：\n"
					+ e.getMessage());
		}

		// 2.将List数据同步到Oracle 财务接口数据库服务器
		try {
			globalStartRentDao.insert2OracleData(globalStartRentList, syncType);
		} catch (Exception e) {
			try {
				OperationUtil.ERPoperationExceptionLog(
						"DATA_SYNC_GLOBAL_START_RENT_NC", "起租数据同步", "读取异常："
								+ e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("更新Fina Interface Server [" + syncType
					+ "] 异常,\n异常信息: \n" + e.getMessage());
		}

		// 本次执行操作总数量
		amount = globalStartRentList.size();
		return amount;
	}
 public static void main(String[] args) {
	 dataSync();
}
}
