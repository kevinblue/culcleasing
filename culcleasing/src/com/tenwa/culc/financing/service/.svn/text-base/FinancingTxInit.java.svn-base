package com.tenwa.culc.financing.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import com.tenwa.culc.util.ERPDataSource;

/**
 * 调息初始化
 * @author toybaby
 * Date:Oct 12, 20115:38:40 PM       Email: toybaby@mail2.tenwa.com.cn
 */
public class FinancingTxInit {
	private static ERPDataSource erpDataSource=null;

	// 公共参数
	private ResultSet rs = null;
	private String start_date = "";//调息开始日期
	private String year_rate = "";//调息前年利率
	private String drawings_rate_float_type = "";//融职调息利率浮动类型
	public String getDrawings_rate_float_type() {
		return drawings_rate_float_type;
	}

	public void setDrawings_rate_float_type(String drawings_rate_float_type) {
		this.drawings_rate_float_type = drawings_rate_float_type;
	}

	public String getYear_rate() {
		return year_rate;
	}

	public void setYear_rate(String year_rate) {
		this.year_rate = year_rate;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	/**
	 * @param drawings_str 提款编号字符串
	 * @param txId  调息编号
	 * @param czyid 用户
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unused")
	public int Tx_Int_add(String drawings_str,String txId,String czyid) throws SQLException{
		int flag = 0;
		String [] drawings_list = drawings_str.split("#");//提款编号数组
		String after_rate = "";//调息后利率
		String start_list = "";//开始期次
		
		System.out.println("contract_str================"+drawings_str);
		
		for(int i = 0; i<drawings_list.length;i++){
			 after_rate = getAfter_Rate(txId,drawings_list[i]);
			 start_list = getStartList(this.start_date,drawings_list[i]);
			System.out.println("调息后年利率=="+after_rate+"before_rate="+this.year_rate+"   调息开始日期="+this.start_date+
					"  调息开始期次="+start_list);
			//调息前插入融资还款计划历史表
			addFinancingHisBeforeInfo(drawings_list[i],txId);
			//插入调息状态表
			flag += addFinancingAdjustInterest(drawings_list[i],txId,start_list,after_rate,
					this.year_rate,czyid);
			
			
		}
		return flag;
		
	}
	
	/**
	 * @function 获得调息后的利率
	 * @param txId
	 * @param contract_id  合同编号
	 * @param begin_id 起租编号
	 * @return
	 */
	@SuppressWarnings("unused")
	public String getAfter_Rate(String txId,String drawings_id) throws SQLException{
		String tx_date = "";//调息开始日期
		String base_rate_one = "";//本次调息后一年基础利率
		String base_rate_three = "";//本次调息后三年基础利率
		String base_rate_five = "";//本次调息五年基础利率
		String base_rate_abovefive = "";//本次调息后五年以上基础利率
		String after_rate = "";//调息后利率
		Map<String, String> Rate_Map = new HashMap<String, String>(); 
		String sql = "select * from fund_standard_interest where id= '"+txId+"'";
		// 1.获取连接、会话
		erpDataSource=new ERPDataSource();
		
			rs = erpDataSource.executeQuery(sql);
			if (rs.next()){
		    	tx_date = rs.getString("start_date");
		    	base_rate_one = rs.getString("base_rate_one");
		    	base_rate_three = rs.getString("base_rate_three");
		    	base_rate_five = rs.getString("base_rate_five");
		    	base_rate_abovefive = rs.getString("base_rate_abovefive");
			}
			//Map封装调息利率值
			Rate_Map.put("start_date", start_date);
			Rate_Map.put("base_rate_one", base_rate_one);
			Rate_Map.put("base_rate_three", base_rate_three);
			Rate_Map.put("base_rate_five", base_rate_five);
			Rate_Map.put("base_rate_abovefive", base_rate_abovefive);
			erpDataSource.close();
			after_rate = getAfter_RateByTxInfo( Rate_Map,drawings_id);
			this.start_date	= tx_date;
			
		return after_rate;
		
	}
	
	/**
	 * @param rate_Map
	 * @param drawings_id 提款编号
	 * @return
	 * @throws SQLException 
	 */
	@SuppressWarnings({ "unused", "unchecked" })
	public String getAfter_RateByTxInfo(Map rate_Map,String drawings_id) throws SQLException{
		String after_rate="";
		String drawings_rate_para1="";
		String drawings_rate_para2="";
		String drawings_rate_para3="";
		String drawings_rate_float_type = "";
		String sql = "select drawings_rate_para1,drawings_rate_para2,drawings_rate_para3, ";
			   sql += "drawings_rate_float_type from financing_drawings where drawings_id='"+drawings_id+"'";
				// 1.获取连接、会话
			   erpDataSource=new ERPDataSource();
				rs = erpDataSource.executeQuery(sql);
				if(rs.next()){
					drawings_rate_para1 = rs.getString("drawings_rate_para1");
					drawings_rate_para2 = rs.getString("drawings_rate_para2");
					drawings_rate_para3 = rs.getString("drawings_rate_para3");
					drawings_rate_float_type = rs.getString("drawings_rate_float_type");
				}
				//测试用数据（模拟）
				this.year_rate="6.5";
				after_rate="7.5";
				this.drawings_rate_float_type=drawings_rate_float_type;
				erpDataSource.close();
				
			   return after_rate;
	}
	
	/**
	 * 获得调息开始期次
	 * @param start_date 调息开始日期
	 * @param drawings_id  提款编号
	 * @return
	 * @throws SQLException 
	 */
	public String getStartList(String start_date,String drawings_id) throws SQLException{
		String start_list = "";
		String sql = "select min(refund_list) refund_list from financing_refund_plan " +
				"where drawings_id='"+drawings_id+"' and refund_plan_date >'"+start_date+"' and refund_status='未还款'";
		erpDataSource=new ERPDataSource();
		rs = erpDataSource.executeQuery(sql);
		if(rs.next()){
			start_list = rs.getString("refund_list");
		}
		erpDataSource.close();
		return start_list;
	}
	/**
	 * 把还款计划插入到历史表中
	 * @param drawings_id
	 * @param tixId
	 * @throws SQLException 
	 */
	public void addFinancingHisBeforeInfo(String drawings_id,String txId) throws SQLException{
		String sql="insert into financing_refund_plan_his(drawings_id,refund_list,refund_plan_date," +
				"refund_corpus,refund_interest,refund_money,refund_otherfee_money,refund_otherfee_type," +
				"refund_subtotal,refund_status,remark,state,flag,mod_stuff,mod_status,mod_reason," +
				"creator,create_date,modifactor,modify_date,tx_id) " +
				
				"select drawings_id,refund_list,refund_plan_date,refund_corpus,refund_interest," +
				"refund_money,refund_otherfee_money,refund_otherfee_type,refund_subtotal,refund_status," +
				"remark,state,flag,mod_stuff,'前','调息',creator,create_date,modifactor," +
				"modify_date,'"+txId+"' from financing_refund_plan " +
						"where drawings_id='"+drawings_id+"'";
//		System.out.println("还款计划插入历史表中=="+sql);
		erpDataSource=new ERPDataSource();
		erpDataSource.executeUpdate(sql);
		erpDataSource.close();	
		
	}
	
	/**
	 * 插入调息记录表
	 * @param drawings_id
	 * @param txId
	 * @param start_list
	 * @param after_rate
	 * @param year_rate
	 * @param czyid
	 * @throws SQLException 
	 */
	public int addFinancingAdjustInterest(String drawings_id,String txId,String start_list,String after_rate,
			String year_rate,String czyid) throws SQLException{
		int flag = 0;
		String sql="insert financing_adjust_interest_drawings(drawings_id,adjust_id,adjust_flag," +
				"adjust_amt,adjust_type,before_rate,after_rate,rent_list_start,left_corpus,left_interest," +
				"creator,create_date,modificator,modify_date) select '"+drawings_id+"','"+txId+"','否'," +
						"null,'"+this.drawings_rate_float_type+"','"+year_rate+"','"+after_rate+"','"+start_list+"'," +
								" sum(refund_corpus),sum(refund_corpus),'"+czyid+"',getdate(),'"+czyid+"',getdate() from financing_refund_plan where " +
								"drawings_id='"+drawings_id+"' and refund_list>='"+start_list+"'" ;
		System.out.println("插入调息中间表======"+sql);
		erpDataSource=new ERPDataSource();
		flag=erpDataSource.executeUpdate(sql);
		erpDataSource.close();
		return flag;
	}
}
