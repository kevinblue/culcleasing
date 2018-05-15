/**
 * com.tenwa.datasync.finance.service
 */
package com.webService.service;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;



import com.tenwa.culc.util.OperationUtil;
import com.tenwa.log.LogWriter;
import com.webService.bean.GlobalFundPlanBean;
import com.webService.dao.GlobalFundPlanDao;



/**
 * 资金收付计划 - 每日晚上2点导入
 * 
 * @author toybaby Date:Sep 13, 20112:34:11 PM Email: toybaby@mail2.tenwa.com.cn
 */
public class GlobalFundPlanService {

	/**
	 * [资金收付计划(付款单)]批量数据同步
	 * 
	 * @return 本次同步数量
	 */
	
	public static void main(String[] args) {
		dataSync() ;
	}
	public static int dataSync() {
		
		int amount = 0;
		String syncType = "资金收付计划";
		// 1.从ERP数据库服务器读出数据保存在List
		List<GlobalFundPlanBean> globalFundPlanList = new ArrayList<GlobalFundPlanBean>();
		GlobalFundPlanDao globalFundPlanDao = new GlobalFundPlanDao();

		try {
			// 1.1从ERP 服务器读取数据
		/*	if("many".equals(projid.trim())){
				globalFundPlanList = globalFundPlanDao.readGlobalFundPlanData(syncType,"many");
			}else{
				globalFundPlanList = globalFundPlanDao.readGlobalFundPlanData(syncType,projid.trim());
			}*/
			globalFundPlanList = globalFundPlanDao.readGlobalFundPlanData(syncType);
			System.out.println("-------------资金收付计划取值-----------");
		} catch (SQLException e) {
			try {
				OperationUtil.ERPoperationExceptionLog(
						"DATA_SYNC_GLOBAL_FUNDPLAN_NC", "资金收付计划数据同步", "读取异常："
								+ e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("读取ERP Server [" + syncType + "]数据异常，\n异常信息：\n"
					+ e.getMessage());
			System.out.println("-------------资金收付计划异常1-----------");
		}

		// 2.将List数据同步到Oracle 财务接口数据库服务器
		try {
			globalFundPlanDao.insert2OracleData(globalFundPlanList, syncType);
			System.out.println("-------------资金收付计划传值-----------");
		} catch (Exception e) {

			// 写错误日志到数据库
			try {
				OperationUtil.ERPoperationExceptionLog(
						"DATA_SYNC_GLOBAL_FUNDPLAN_NC", "资金收付计划数据同步", "保存日志异常："
								+ e.getMessage());
			}catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("更新Fina Interface Server [" + syncType
					+ "] 异常,\n异常信息: \n" + e.getMessage());
			System.out.println("-------------资金收付计划异常2-----------");
		}

		// 本次执行操作总数量
		amount = globalFundPlanList.size();
		return amount;
	}
  
}
