/**
 * com.tenwa.datasync.finance.service
 */
package com.webService.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.webService.bean.GlobalBjjsBean;
import com.webService.dao.GlobalBjjsDao;
import com.tenwa.culc.util.OperationUtil;
import com.tenwa.log.LogWriter;

public class GlobalBjjsService {
	
	public static void main(String[] args) {
		//String number = OperationUtil.getSerialNumber("本金计税表", "0001",4);
		//System.out.println(number);
		GlobalBjjsService.dataSync("220021,220022,220023,220024,220025"); //北京测试
		//GlobalBjjsService.dataSync("1105,1106,1107,1108,1112,1111");//天津测试
	}
	

	/**
	 * [利息计算表]批量数据同步
	 * 
	 * @return 本次同步数量
	 */
	
	public static  Map<String,Integer> dataSync(String sqlIds) {
		//int amount = 0;
		Map<String,Integer> amount=new HashMap<String,Integer>();
		String syncType = "本金计税表";
		// 1.从ERP数据库服务器读出数据保存在List
		List<GlobalBjjsBean> globalBjjsList = new ArrayList<GlobalBjjsBean>();
		GlobalBjjsDao globalBjjsDao = new GlobalBjjsDao();
		System.out.println("");
		try {
			// 1.1从ERP 服务器读取数据
			globalBjjsList = globalBjjsDao.readGlobalBjjsData(syncType,sqlIds);
			System.out.println("=======读取数据======"+globalBjjsList);
		} catch (SQLException e) {
			try {
				OperationUtil.ERPoperationExceptionLog("DATA_SYNC_GLOBAL_BJJS_NC",
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
			System.out.println("=============入口1==================");		
			amount=globalBjjsDao.insert2OracleData(globalBjjsList, syncType);	
				System.out.println("=============入口2==================");		
		} catch (Exception e) {
			try {
				OperationUtil.ERPoperationExceptionLog("DATA_SYNC_GLOBAL_BJJS_NC",
						"本金计税表数据同步", "读取异常：" + e.getMessage());
			} catch (SQLException e1) {
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
