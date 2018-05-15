/**
 * com.tenwa.datasync.finance.service
 */
package com.webService.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tenwa.culc.util.OperationUtil;
import com.tenwa.log.LogWriter;
import com.webService.bean.GlobalPaiedBean;
import com.webService.dao.GlobalPaiedDao;

/**
 * 付款单Service操作 -每晚2点执行
 * 
 * @author toybaby Date:Sep 13, 20112:34:11 PM Email: toybaby@mail2.tenwa.com.cn
 */
public class GlobalPaiedService {
	
	public static void main(String[] args) {
		dataSync();
	}

	/**
	 * [付款单]批量数据同步
	 * 
	 * @return 本次同步数量
	 */
	public static int dataSync() {
		int amount = 0;
		String syncType = "付款单";
		// 1.从ERP数据库服务器读出数据保存在List
		List<GlobalPaiedBean> globalPaiedList = new ArrayList<GlobalPaiedBean>();
		GlobalPaiedDao globalPaiedDao = new GlobalPaiedDao();

		try {
			// 1.1从ERP 服务器读取数据
			globalPaiedList = globalPaiedDao.readGlobalPaiedData(syncType);
			System.out.println("-------------付款单取值-----------");
		} catch (SQLException e) {
			try {
				OperationUtil.ERPoperationExceptionLog("DATA_SYNC_GLOBAL_PAIED_NC",
						"nc付款单财务接口数据同步", "读取异常：" + e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("读取ERP Server [" + syncType + "]数据异常，\n异常信息：\n"
					+ e.getMessage());
			System.out.println("-------------付款单异常一-----------");
		}

		// 2.将List数据同步到nc财务接口服务器
		try {
			globalPaiedDao.insert2OracleData(globalPaiedList, syncType);
			System.out.println("-------------付款单传值-----------");
		} catch (Exception e) {
			try {
				OperationUtil.ERPoperationExceptionLog("DATA_SYNC_GLOBAL_PAIED_NC",
						"nc付款单财务接口数据同步", "传输异常：" + e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("更新Fina Interface Server [" + syncType
					+ "] 异常,\n异常信息: \n" + e.getMessage());
			System.out.println("-------------付款单异常二-----------");
		}

		// 本次执行操作总数量
		amount = globalPaiedList.size();
		return amount;
	}
}
