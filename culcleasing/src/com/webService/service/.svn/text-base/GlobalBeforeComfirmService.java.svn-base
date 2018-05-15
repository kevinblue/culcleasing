/**
 * com.tenwa.datasync.finance.service
 */
package com.webService.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tenwa.culc.util.OperationUtil;
import com.tenwa.log.LogWriter;
import com.webService.bean.GlobalBeforeConfirmBean;
import com.webService.dao.GlobalBeforeConfirmDao;

/**
 * 国内收款单Service操作 -每晚2点执行
 * 
 * @author Jaffe
 * 
 * Date:Sep 12, 2011 6:03:09 PM Email:JaffeHe@hotmail.com
 */
public class GlobalBeforeComfirmService {
	
	public static void main(String[] args) {
		dataSync();
	}

	/**
	 * [国内收款单]批量数据同步
	 * 
	 * @return 本次同步数量
	 */
	public static int dataSync() {
		int amount = 0;
		String syncType = "提前终止合同收款单";
		// 1.从ERP数据库服务器读出数据保存在List
		List<GlobalBeforeConfirmBean> globalBeforeConfirmList = new ArrayList<GlobalBeforeConfirmBean>();
		GlobalBeforeConfirmDao globalBeforeConfirmDao = new GlobalBeforeConfirmDao();
		
		try {
			// 1.1从ERP 服务器读取数据
			globalBeforeConfirmList = globalBeforeConfirmDao
					.readGlobalBeforeConfirmData(syncType);
		} catch (SQLException e) {
			try {
				OperationUtil.ERPoperationExceptionLog(
						"DATA_SYNC_GLOBAL_BEFORE_CONFIRM_NC", "提前终止合同收款单数据同步", "读取异常："
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
			globalBeforeConfirmDao.insert2OracleData(globalBeforeConfirmList, syncType);
		} catch (Exception e) {
			try {
				OperationUtil.ERPoperationExceptionLog(
						"DATA_SYNC_GLOBAL_BEFORE_CONFIRM_NC", "提前终止合同收款单数据同步", "传输异常："
								+ e.getMessage());
			}catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("更新Fina Interface Server [" + syncType
					+ "] 异常,\n异常信息: \n" + e.getMessage());
		}

		// 本次执行操作总数量
		amount = globalBeforeConfirmList.size();
		return amount;
	}
}
