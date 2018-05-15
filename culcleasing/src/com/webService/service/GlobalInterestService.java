/**
 * com.tenwa.datasync.finance.service
 */
package com.webService.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tenwa.culc.util.OperationUtil;
import com.tenwa.log.LogWriter;
import com.webService.bean.GlobalInterestBean;
import com.webService.dao.GlobalInterestDao;


/**
 * 利息计算表(应收)
 * 
 * @author toybaby Date:Sep 13, 20112:34:11 PM Email: toybaby@mail2.tenwa.com.cn
 */
public class GlobalInterestService {
	public static void main(String[] args) {
		dataSync();
	}

	/**
	 * [利息计算表(应收)]批量数据同步
	 * 
	 * @return 本次同步数量
	 */
	public static int dataSync() {
		int amount = 0;
		String syncType = "利息计算表";
		// 1.从ERP数据库服务器读出数据保存在List
		List<GlobalInterestBean> globalInterestList = new ArrayList<GlobalInterestBean>();
		GlobalInterestDao globalInterestDao = new GlobalInterestDao();

		try {
			// 1.1从ERP 服务器读取数据
			globalInterestList = globalInterestDao
					.readGlobalInterestData(syncType);
		} catch (SQLException e) {
			try {
				OperationUtil.ERPoperationExceptionLog("DATA_SYNC_GLOBAL_INTEREST_NC",
						"NC利息计算表数据同步", "读取异常：" + e.getMessage());
			}catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("读取ERP Server [" + syncType + "]数据异常，\n异常信息：\n"
					+ e.getMessage());
		}

		// 2.将List数据同步到Oracle 财务接口数据库服务器
		try {
			globalInterestDao.insert2OracleData(globalInterestList, syncType);
		} catch (Exception e) {
			try {
				OperationUtil.ERPoperationExceptionLog("DATA_SYNC_GLOBAL_INTEREST_NC",
						"NC利息计算表数据同步", "传输异常：" + e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("更新Fina Interface Server [" + syncType
					+ "] 异常,\n异常信息: \n" + e.getMessage());
		}

		// 本次执行操作总数量
		amount = globalInterestList.size();
		return amount;
	}

	
	
}
