/**
 * 
 */
package com.tenwa.culc.financing.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tenwa.culc.util.ERPDataSource;

/**
 * 
 * @author toybaby
 * Date:Oct 14, 20116:47:43 PM       Email: toybaby@mail2.tenwa.com.cn
 */

public class Tx_DataCtrolUtil {
	private static ERPDataSource erpDataSource=null;
	// 公共参数
	private ResultSet rs = null;
	
	/**
	 * 把开始期次之前的还款计划拷到历史表中（调息执行）
	 * @param drawings_id
	 * @param txId
	 * @param czyid
	 * @throws SQLException 
	 */
	public void copyRefundPlanIntoHis(String drawings_id,String txId,String czyid) throws SQLException{
		String sql="insert into financing_refund_plan_his(drawings_id,refund_list,refund_plan_date," +
		"refund_corpus,refund_interest,refund_money,refund_otherfee_money,refund_otherfee_type," +
		"refund_subtotal,refund_status,remark,state,flag,mod_stuff,mod_status,mod_reason," +
		"creator,create_date,modifactor,modify_date,tx_id) " +
		"select drawings_id,refund_list,refund_plan_date,refund_corpus,refund_interest," +
		"refund_money,refund_otherfee_money,refund_otherfee_type,refund_subtotal,refund_status," +
		"remark,state,flag,mod_stuff,'后','调息',creator,create_date,modifactor," +
		"modify_date,'"+txId+"' from financing_refund_plan " +
				"where drawings_id='"+drawings_id+"' and refund_list<(select rent_list_start from " +
						"financing_adjust_interest_drawings where  drawings_id='"+drawings_id+"' and adjust_id='"+txId+"')";
		System.out.println("把开始期次之前的还款计划拷到历史表===="+sql);
		erpDataSource=new ERPDataSource();
		erpDataSource.executeUpdate(sql);
		erpDataSource.close();
	}
	
	/**
	 * 获得调息中间表的所需的调息的基本数据（调息分配）
	 * @param drawings_id
	 * @param txId
	 * @return
	 * @throws SQLException
	 */
	public Map<String,String> getConditionInfo(String drawings_id,String txId) throws SQLException{
		String adjust_type = "";
		String after_rate = "";
		String rent_list_start = "";
		Map<String, String> InfoMap = new HashMap<String, String>();
		String sql = "select adjust_type,after_rate,rent_list_start from " +
				"dbo.financing_adjust_interest_drawings where drawings_id='"+drawings_id+"' " +
						"and adjust_id='"+txId+"'" ;
		erpDataSource=new ERPDataSource();
		rs=erpDataSource.executeQuery(sql);
		if(rs.next()){
			adjust_type = rs.getString("adjust_type");
			after_rate = rs.getString("after_rate");
			rent_list_start = rs.getString("rent_list_start");
		}
		InfoMap.put("adjust_type", adjust_type);
		InfoMap.put("after_rate", after_rate);
		InfoMap.put("rent_list_start", rent_list_start);
		erpDataSource.close();
		
		return InfoMap;
	}
	/**
	 * 获得还款计划（调息分配）
	 * @param drawings_id
	 * @param txId
	 * @return
	 * @throws SQLException 
	 */
	public List<Map<String,String>> getRefundPlan(String drawings_id, String start_list) throws SQLException{
		List<Map<String,String>> RefundPlanList = new ArrayList<Map<String,String>>();
		String refund_list = "";
		String refund_corpus = "";
		String sql = "select refund_list,refund_corpus from financing_refund_plan " +
				"where drawings_id = '"+drawings_id+"' and refund_list>='"+start_list+"'";
		erpDataSource=new ERPDataSource();
		rs=erpDataSource.executeQuery(sql);
		while(rs.next()){
			Map<String,String> PlanMap = new HashMap<String, String>();
			refund_list = rs.getString("refund_list");
			refund_corpus = rs.getString("refund_corpus");
			PlanMap.put("refund_list", refund_list);
			PlanMap.put("refund_corpus",refund_corpus );
			RefundPlanList.add(PlanMap);
		}
		erpDataSource.close();
		return RefundPlanList;
		
	}
	/**把调息后的计划插入到正式表中
	 * @param drawings_id
	 * @param NewRefundPlanList
	 * @param txId
	 * @param czyid
	 * @return
	 * @throws SQLException
	 */
	public int copyRentPlanIntoHisAfter(String drawings_id,List <Map<String, String>> 
			NewRefundPlanList,String txId,String czyid) throws SQLException{
		Map<String,String> newRefundPlanMap = new HashMap<String, String>();
		erpDataSource=new ERPDataSource();
		int flag = 0;
		for(int i=0;i<NewRefundPlanList.size();i++){
			newRefundPlanMap = NewRefundPlanList.get(i);
			System.out.println("newRefundPlanMap=="+newRefundPlanMap);
			String sql="insert into financing_refund_plan_his(drawings_id,refund_list,refund_plan_date," +
			"refund_corpus,refund_interest,refund_money,refund_otherfee_money,refund_otherfee_type," +
			"refund_subtotal,refund_status,remark,state,flag,mod_stuff,mod_status,mod_reason," +
			"creator,create_date,modifactor,modify_date,tx_id) " +
			"select drawings_id,refund_list,refund_plan_date,refund_corpus,'"+newRefundPlanMap.
			get("refund_interest")+"'," +"'"+newRefundPlanMap.get("refund_money")+"'," +
					"refund_otherfee_money,refund_otherfee_type,refund_subtotal,refund_status," +
			"remark,state,flag,mod_stuff,'后','调息',creator,create_date,modifactor," +
			"modify_date,'"+txId+"' from financing_refund_plan where drawings_id='"+drawings_id+"' and " +
					"refund_list='"+newRefundPlanMap.get("refund_list")+"'" ;
			System.out.println("sql==="+sql);
			flag +=erpDataSource.executeUpdate(sql);
		}
		if(flag>0){
			flag=1;
		}
		erpDataSource.close();
		return flag;
	}
	
	/**
	 * 调息后的数据从his表回拷到正式表
	 * @param drawings_id
	 * @param start_list
	 * @param tx_id
	 * @throws SQLException
	 */
	public void copyReFundPlanFromHis(String drawings_id,String start_list,String tx_id) throws SQLException{
		
		erpDataSource=new ERPDataSource();
		String sql="insert into financing_refund_plan(drawings_id,refund_list,refund_plan_date," +
		"refund_corpus,refund_interest,refund_money,refund_otherfee_money,refund_otherfee_type," +
		"refund_subtotal,refund_status,remark,state,flag,mod_stuff,mod_status,mod_reason," +
		"creator,create_date,modifactor,modify_date) " + 
		"select drawings_id,refund_list,refund_plan_date,refund_corpus,refund_interest," +
		"refund_money,refund_otherfee_money,refund_otherfee_type,refund_subtotal,refund_status," +
		"remark,state,flag,mod_stuff,null,null,creator,create_date,modifactor," +
		"modify_date from financing_refund_plan_his  where drawings_id='"+drawings_id+"' " +
				"and tx_id='"+tx_id+"'and refund_list>='"+start_list+"'";
		erpDataSource.executeUpdate(sql);
		erpDataSource.close();
	}
	/**
	 * 把调息状态更新为是
	 * @param drawings_id
	 * @param tx_id
	 * @throws SQLException
	 */
	public void updateFundAdjust(String drawings_id,String tx_id) throws SQLException{
		String sql = "update financing_adjust_interest_drawings set adjust_flag='是' " +
				"where drawings_id='"+drawings_id+"' and adjust_id='"+tx_id+"' ";
		erpDataSource=new ERPDataSource();
		erpDataSource.executeUpdate(sql);
		erpDataSource.close();
	}
	
	/**更改新的年利率
	 * @param drawings_id
	 */
	public void updateConditionForProcess(String drawings_id,String txId){
		
	}
	/**
	 * 删除正式表开始期次以后的的数据 (调息撤销)（调息执行通用）
	 * @param drawings_id
	 * @throws SQLException 
	 */
	public void delPlanForCancle(String drawings_id,String tx_id) throws SQLException{
		String sql="delete from financing_refund_plan where drawings_id='"+drawings_id+"' and " +
				"refund_list>=(select rent_list_start from financing_adjust_interest_drawings where " +
				"drawings_id='"+drawings_id+"' and adjust_id='"+tx_id+"')";
		erpDataSource=new ERPDataSource();
		erpDataSource.executeUpdate(sql);
		
		erpDataSource.close();
		
	}
	
	/**
	 * 第二步:把his表开始期次以后的数据拷到正式表 (调息撤销)
	 * @param drawings_id
	 * @param tx_id
	 * @throws SQLException 
	 */
	public void copPlanForCancle(String drawings_id,String tx_id) throws SQLException{
		String sql="insert into financing_refund_plan(drawings_id,refund_list,refund_plan_date," +
		"refund_corpus,refund_interest,refund_money,refund_otherfee_money,refund_otherfee_type," +
		"refund_subtotal,refund_status,remark,state,flag,mod_stuff,mod_status,mod_reason," +
		"creator,create_date,modifactor,modify_date) " + 
		"select drawings_id,refund_list,refund_plan_date,refund_corpus,refund_interest," +
		"refund_money,refund_otherfee_money,refund_otherfee_type,refund_subtotal,refund_status," +
		"remark,state,flag,mod_stuff,null,null,creator,create_date,modifactor," +
		"modify_date from financing_refund_plan_his  " +
		"where drawings_id='"+drawings_id+"' and mod_status='前' and mod_reason='调息' and " +
				"tx_id='"+tx_id+"'and refund_list>=(select rent_list_start from " +
		"financing_adjust_interest_drawings where  drawings_id='"+drawings_id+"' and adjust_id='"+tx_id+"')";
		erpDataSource=new ERPDataSource();
		erpDataSource.executeUpdate(sql);
		
		erpDataSource.close();	
	}
	
	/**
	 * 把financing_drawings的年利率恢复到调息前的年利率 (调息撤销)
	 * @param drawings_id
	 * @param tx_id
	 */
	public void updateConditionForCancle(String drawings_id,String tx_id){
		//String sql="";
	}
	/**
	 * 把his表的数据删除 (调息撤销)
	 * @param drawings_id
	 * @param tx_id
	 * @throws SQLException 
	 */
	public void delPlanHisForCancle(String drawings_id,String tx_id) throws SQLException{
		
		
		String sql = "delete from financing_refund_plan_his where drawings_id='"+drawings_id+"' " +
				"and tx_id='"+tx_id+"'";
		erpDataSource=new ERPDataSource();
		erpDataSource.executeUpdate(sql);
		
		erpDataSource.close();			
	}
	
	/**
	 * 第五步:删除调息记录表的记录(调息撤销)
	 * @param drawings_id
	 * @param tx_id
	 * @throws SQLException
	 */
	public int delFundAdjustForCancle(String drawings_id,String tx_id) throws SQLException{
		int flag=0;
		String sql = "delete from financing_adjust_interest_drawings where drawings_id='"+drawings_id+"' " +
		"and adjust_id='"+tx_id+"'";
		erpDataSource=new ERPDataSource();
		flag=erpDataSource.executeUpdate(sql);
		
		erpDataSource.close();
		return flag;
	}
}
