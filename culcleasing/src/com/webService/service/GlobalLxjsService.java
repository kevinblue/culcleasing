/**
 * com.tenwa.datasync.finance.service
 */
package com.webService.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tenwa.culc.util.OperationUtil;
import com.tenwa.log.LogWriter;
import com.webService.bean.GlobalBjjsBean;
import com.webService.dao.GlobalLxjsDao;


public class GlobalLxjsService {
	
	
	
	public static void main(String[] args) {
		GlobalLxjsService.dataSync("215826,251121");
	}
	/**
	 * [利息计算表]批量数据同步
	 * 
	 * @return 本次同步数量
	 */
	public static Map<String,Integer> dataSync(String sqlIds) {
	//	int amount = 0;
		Map<String,Integer> amount=new HashMap<String,Integer>();

		String syncType = "利息计税表";
		// 1.从ERP数据库服务器读出数据保存在List
		List<GlobalBjjsBean> globalLxjsList = new ArrayList<GlobalBjjsBean>();
		GlobalLxjsDao globalLxjsDao = new GlobalLxjsDao();
		System.out.println("");
		try {
			// 1.1从ERP 服务器读取数据
			globalLxjsList = globalLxjsDao.readGlobalBjjsData(syncType,sqlIds);
//			System.out.println("============="+globalBjjsList);
		} catch (SQLException e) {
			try {
				OperationUtil.ERPoperationExceptionLog("DATA_SYNC_GLOBAL_LXJS_NC",
						"利息计税表数据同步", "读取异常：" + e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("读取ERP Server [" + syncType + "]数据异常，\n异常信息：\n"
					+ e.getMessage());
		}

		// 2.将List数据同步到Oracle 财务接口数据库服务器
		try {
			System.out.println("=============入口==================");
			amount=globalLxjsDao.insert2OracleData(globalLxjsList, syncType);
		} catch (Exception e) {
			try {
				OperationUtil.ERPoperationExceptionLog("DATA_SYNC_GLOBAL_LXJS_NC",
						"利息计税表数据同步", "读取异常：" + e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("更新Fina Interface Server [" + syncType
					+ "] 异常,\n异常信息: \n" + e.getMessage());
		}

		// 本次执行操作总数量
	//	amount = globalLxjsList.size();
		return amount;
	}

}
