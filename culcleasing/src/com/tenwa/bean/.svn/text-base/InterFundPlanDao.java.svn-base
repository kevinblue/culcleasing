package com.tenwa.bean;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.service.YYSqlGenerateUtil;
import com.service.YYSqlTableUtil;
import com.tenwa.bean.InterFundPlan;
import com.tenwa.culc.calc.util.YongYouDataSource;
import com.tenwa.culc.util.CommonTool;
import com.tenwa.culc.util.ERPDataSource;

import com.tenwa.log.LogWriter;



public class InterFundPlanDao {
	// 公共参数
    
	private ResultSet rs = null;
	private String sync_type_name = "[合同资金计划]";
	/**
	 * 读取合同资金计划信息
	 * 
	 * @return
	 * @throws SQLException
	 */
	
	public List<InterFundPlan>  readFundPlanDaoData(String contract_id) throws SQLException{
		List<InterFundPlan>  list=new  ArrayList<InterFundPlan>();
		InterFundPlan ifp = null;
		// 1获取连接
		ERPDataSource erpDataSource = new ERPDataSource();
		StringBuffer selectsql = new StringBuffer();
		if(null!=contract_id && !"".equals(contract_id)){
			selectsql.append("select * from vi_inter_fund_plan where contract_id='"+contract_id+"'");
		}else{
			selectsql.append("select top 10000 c.*  from vi_inter_fund_plan c where  not exists (")
			.append("select 1 from YY_ERP_DATA_SYNC_INFO_CONTRACT info where info.plan_type_name='[合同资金计划]' and  info.proj_id "
					+ "= c.proj_id and info.contract_id = c.contract_id")
			.append("  and info.plan_id=c.plan_id and info.plan_status=c.plan_status)  ");
		}
		rs=erpDataSource.executeQuery(selectsql.toString());
		
		
		while (rs.next()) {
			ifp = new InterFundPlan();
			ifp=(InterFundPlan) YYSqlTableUtil.getResultSetObj(ifp, rs, "vi_inter_fund_plan");
			list.add(ifp);
		}
		rs.close();
		erpDataSource.close();
		
		return list;
		
	}
	/**
	 * @param list   INTER_FUND_PLAN 表原数据改为废弃
	 * @param table_name
	 * @param contract_id
	 * @throws SQLException
	 */
	public void updateInterFundPlanDaoFlag(String table_name,String column_name, String column_value) throws SQLException {
		YongYouDataSource YYDataSource = new YongYouDataSource();
		String sqlStr = YYSqlGenerateUtil.generateUpdateProjInfoFlag("INTER_FUND_PLAN", column_name, column_value);
		LogWriter.logDebug("更新用友表中数据为废弃，表名："+table_name+" 参数 "+column_name+" = "+column_value +"" );
		
		System.out.println(sqlStr);
		YYDataSource.executeUpdate(sqlStr);
		// 4.关闭资源
		YYDataSource.close();
	}



	/**
	 * 插入中间库
	 * @param beanList
	 * @throws SQLException
	 */
	public int insert2HostData(List<InterFundPlan> beanList)	throws SQLException {
		
		int updAmount = 0;// 修改数据数据量
		int insAmount = 0;// 插入数据数据量
		if (beanList.size() < 1) {
			LogWriter.logDebug("当前没有"+sync_type_name+"数据需要同步");
		} else {
				String oper_id = CommonTool.getUUID();// 操作Id
				YongYouDataSource yyDataSource=new YongYouDataSource();
				ERPDataSource erpDataSource = new ERPDataSource();
				try{
					
				
				String sqlStr = "";
			    String deleteoraclesql="";
			    String deletesqlservicesql="";
				// 1.遍历所有List数据
			    System.out.println(beanList.size());
				for (InterFundPlan interProjInfoBean : beanList) {
					//1.1先删除oracle的数据
					if(interProjInfoBean.getContract_id()!=null&&interProjInfoBean.getPlan_id()!=null){
						deleteoraclesql=" delete from INTER_FUND_PLAN irp where irp.flag = 0 and irp.contract_id='"+interProjInfoBean.getContract_id()
						+"' and irp.plan_id='"+interProjInfoBean.getPlan_id()+"'";
						deletesqlservicesql="delete  from YY_ERP_DATA_SYNC_INFO_CONTRACT  where exists  (select 1  from vi_inter_fund_plan c  where "
							+" c.CONTRACT_id='"+interProjInfoBean.getContract_id()+"' and c.PLAN_ID='"+interProjInfoBean.getPlan_id()+"' " +
									"and YY_ERP_DATA_SYNC_INFO_CONTRACT.proj_id = c.proj_id"
							+" and YY_ERP_DATA_SYNC_INFO_CONTRACT.contract_id = c.contract_id and " +
									"YY_ERP_DATA_SYNC_INFO_CONTRACT.plan_id = c.plan_id and YY_ERP_DATA_SYNC_INFO_CONTRACT.plan_status = c.plan_status)";
					}
					interProjInfoBean.setOPER_ID(oper_id);
					sqlStr = YYSqlTableUtil.getAllFiledInsertSQL(interProjInfoBean,"INTER_FUND_PLAN");
					insAmount++;
					System.out.println(insAmount);
				   if(!"".equals(deletesqlservicesql)) {
					   erpDataSource.executeUpdate(deletesqlservicesql);
				   }		
				     if(!"".equals(deleteoraclesql)) {
							yyDataSource.executeUpdate(deleteoraclesql);
				      }	
					// 2.1.3执行操作
					if (!"".equals(sqlStr)) {
						yyDataSource.executeUpdate(sqlStr);
					}
				}
				}catch(Exception e){
					e.printStackTrace();
				}finally{
					
				
				LogWriter.logDebug("本次执行"+sync_type_name+"数据同步，插入数据[" + insAmount+ "]条");
				// 文件日志
				LogWriter.operationLog("本次执行"+sync_type_name+"数据同步，插入数据[" + insAmount+ "]条");
				// 数据库日志
				writeDataSyncDBLog(insAmount, updAmount, oper_id);
				// 同步数据信息
				writeDataSyncDBInfo(beanList,oper_id);
				erpDataSource.close();
				yyDataSource.close();
				}
			}
		return insAmount;
}

	

	/**
	 * 数据同步信息
	 * 
	 * @param equipMedLibList
	 * @throws SQLException
	 */
	private void writeDataSyncDBInfo(List<InterFundPlan> beanList,	String oper_id) throws SQLException {
		ERPDataSource erpDataSource = new ERPDataSource();
		String sqlStr = "";
		// 1.遍历所有List数据
		for (InterFundPlan interProjInfoBean : beanList) {
			// 插入
			sqlStr = YYSqlGenerateUtil.getDataSyncDBPlanInfoALL(oper_id, interProjInfoBean.getProj_id(),
					interProjInfoBean.getContract_id(),String.valueOf(interProjInfoBean.getPlan_id()),interProjInfoBean.getProj_status(),interProjInfoBean.getPlan_status(),sync_type_name);

			// 执行操作
			System.out.println(sync_type_name+"同步信息插入日志SQL" + sqlStr);
			erpDataSource.executeUpdate(sqlStr);
		}
		erpDataSource.close();
	}

	/**
	 * 服务器数据库日志
	 * 
	 * @param insAmount
	 * @param updAmount
	 * @param oper_id
	 * @throws SQLException
	 */
	private void writeDataSyncDBLog(int insAmount, int updAmount, String oper_id)
			throws SQLException {
		// 1.获取连接
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.更新数据
		String sqlStr = YYSqlGenerateUtil.generateDataSyncProjInfoLog(
				insAmount, updAmount, oper_id,sync_type_name,"DATA_SYNC_INTER_FUND_PLAN");

		erpDataSource.executeUpdate(sqlStr);

		// 3.释放
		erpDataSource.close();
	}
	public List<InterFundPlan>  readPlanDaoData() throws SQLException {
		List<InterFundPlan> list=new ArrayList<InterFundPlan>();
		InterFundPlan inp=null;
	    ERPDataSource erpDataSource = new ERPDataSource();
		String contract_id=""; 
		String plan_id=""; 
		String selectplansql="select contract_id,plan_id from YY_ERP_DATA_SYNC_INFO_CONTRACT yy where yy.plan_type_name='[合同资金计划]' "
             +" and not exists(select 1 from vi_inter_fund_plan c where c.CONTRACT_id = "
             +"yy.contract_id and c.PLAN_ID = yy.plan_id)";
		ResultSet rss = erpDataSource.executeQuery(selectplansql);;
		while (rss.next()) {
			inp=new InterFundPlan();
		    plan_id=rss.getString("plan_id");
		    inp.setContract_id(rss.getString("contract_id"));
		    inp.setPlan_id(Integer.parseInt(rss.getString("plan_id")));
		    list.add(inp);
		}
		rss.close();
		erpDataSource.close();
		return list;
	}
	
	/**
	 * 删除资金计划变更的数据
	 * @param beanList
	 * @throws SQLException
	 */
	public int  deletefundplan(List<InterFundPlan> list) throws SQLException  {
	  String deleteoraclesql="";
	  String deleteserversql="";
	  String contract_id="";
	  String plan_id="";
	  int sumremove=0;
	  ERPDataSource erpDataSource = new ERPDataSource();
	  YongYouDataSource YYDataSource = new YongYouDataSource();
		for(int i=0;i<list.size();i++){
			InterFundPlan inp=  list.get(i);
			 contract_id=inp.getContract_id(); 
			 plan_id=String.valueOf(inp.getPlan_id()); 
			deleteoraclesql=" delete from INTER_FUND_PLAN irp where irp.flag = 0 and irp.contract_id='"+contract_id+"' and plan_id='"+plan_id+"'";
			deleteserversql=" delete from YY_ERP_DATA_SYNC_INFO_CONTRACT  where "
				            +" not exists(select 1 from vi_inter_fund_plan c where c.CONTRACT_id = "
				            +" YY_ERP_DATA_SYNC_INFO_CONTRACT.contract_id and c.PLAN_ID = YY_ERP_DATA_SYNC_INFO_CONTRACT.plan_id) "
				            +" and plan_type_name='[合同资金计划]' and "
			   	            +" contract_id='"+contract_id+"' and plan_id='"+plan_id+"'";
			   if(!"".equals(deleteoraclesql)) {
					  YYDataSource.executeUpdate(deleteoraclesql);
				   }
			   if(!"".equals(deleteserversql)) {
					  erpDataSource.executeUpdate(deleteserversql);
				   }
			   sumremove++;
             }
		YYDataSource.close();
		erpDataSource.close();
		return sumremove;
	  }
}
