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
import com.webService.dao.GlobalBjjsYYDao;


public class GlobalBjjsYYService {
  
	
	public static void main(String[] args) {
		//GlobalBjjsYYService.dataSync("68812,68813,68814,68815,68816");
		GlobalBjjsYYService.dataSync("1105,1106,1107,1108,1109,1110");//天津测试
	}
	/**
	 * [利息计算表]批量数据同步
	 * 本金计税（营业税）接口
	 * @return 本次同步数量
	 */
	public static Map<String,Integer> dataSync(String sqlIds) {
		//int amount = 0;
		Map<String,Integer> amount=new HashMap<String,Integer>();
		String syncType = "本金计税表";
		// 1.从ERP数据库服务器读出数据保存在List
		List<GlobalBjjsBean> globalBjjsList = new ArrayList<GlobalBjjsBean>();
		GlobalBjjsYYDao globalBjjsYYDao = new GlobalBjjsYYDao();
		System.out.println("");
		try {
			// 1.1从ERP 服务器读取数据
			globalBjjsList = globalBjjsYYDao.readGlobalBjjsData(syncType,sqlIds);
//			System.out.println("============="+globalBjjsList);
		} catch (SQLException e) {
			try {
				OperationUtil.ERPoperationExceptionLog("DATA_SYNC_GLOBAL_BJJS_YY_NC",
						"本金计税表数据同步", "读取异常：" + e.getMessage());
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
		 amount=globalBjjsYYDao.insert2OracleData(globalBjjsList, syncType);
		} catch (Exception e) {
			try {
				OperationUtil.ERPoperationExceptionLog("DATA_SYNC_GLOBAL_BJJS_YY_NC",
						"本金计税表数据同步", "读取异常：" + e.getMessage());
			}catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("更新Fina Interface Server [" + syncType
					+ "] 异常,\n异常信息: \n" + e.getMessage());
		}

		// 本次执行操作总数量
		//amount = globalBjjsList.size();
		return amount;
	}

}
