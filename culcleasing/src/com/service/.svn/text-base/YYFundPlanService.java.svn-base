package com.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tenwa.bean.InterFundPlan;
import com.tenwa.culc.calc.util.YongYouOperationUtil;

import com.tenwa.bean.InterFundPlanDao;


import com.tenwa.log.LogWriter;


public class YYFundPlanService {
//合同资金计划同步数据包含项目没有做过合同资金计划数据、状态含（10立项、15咨询评估），
	private static String sync_type_name = "[合同资金计划]";
	/**5
	 * 指定合同资金计划数据同步
	 * 
	 * @param contract_id
	 *            合同编号
	 * @return
	 */
	
	
	 
	public static int dataSync(String contract_id) {
		int res = 0;
		InterFundPlanDao  fldao=new InterFundPlanDao();
		List<InterFundPlan>   list =new  ArrayList<InterFundPlan>();
		List<InterFundPlan> planlist=new ArrayList<InterFundPlan>();
		try {
			// 1.1从Client1 服务器读取数据
			list = fldao.readFundPlanDaoData(contract_id);
			System.out.println("加载数据条数："+list.size());
		} catch (SQLException e) {
			e.printStackTrace();
			LogWriter.logError("读取[" + contract_id + "]Client Server "+sync_type_name+"数据异常");
			try {
				YongYouOperationUtil.operationExceptionLog("DATA_SYNC_INTER_FUND_PLAN",sync_type_name+"数据同步", "读取异常：" + e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		// .将List数据同步到Server数据库服务器
		try {
			//2先将server服务器的数据置可不可用
			//通用方法，传参数 表名和字段名，统一进行更新不可用。
			fldao.updateInterFundPlanDaoFlag( "INTER_FUND_PLAN", "CONTRACT_ID",contract_id);
			//3 将数据同步到Server服务器				
			res += fldao.insert2HostData(list);
			
		} catch (SQLException e) {
			try {
				YongYouOperationUtil.operationExceptionLog("DATA_SYNC_INTER_FUND_PLAN",sync_type_name+"数据同步", "插入异常：" + e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("更新Host Server "+sync_type_name+" 异常,异常信息: "	+ e.getMessage());
		}
		try {
			// 3.1资金计划变更后，中间库也同步变更
			planlist = fldao.readPlanDaoData();
			int sumremove=0;
			if(planlist.size()>0){
				sumremove=fldao.deletefundplan(planlist);
			}
			LogWriter.logError("资金计划变更"+sumremove+"条数据");
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				YongYouOperationUtil.operationExceptionLog("DATA_SYNC_INTER_RENT_PLAN",sync_type_name+"数据同步", "读取异常：" + e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}

		// 本次执行是否成功
		return res;
	}
 public static void main(String[] args) {
	int i=YYFundPlanService.dataSync("08D0110005");
	System.out.println(i);
  }
}
