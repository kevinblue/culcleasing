/**
 * 
 */
package com.tenwa.culc.calc.tx;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tenwa.culc.util.ERPDataSource;
/**
 * @author toybaby Date:Aug 8, 20114:51:04 PM Email: toybaby@mail2.tenwa.com.cn
 */
public class Tx_DataCtrolUtil_BGZ {
	private static ERPDataSource erpDataSource=null;
	// 公共参数
	private ResultSet rs = null;
	/**
	 * 把开始期次之前的数据全部拷入到his表中
	 * 
	 * @param contract_id
	 * @param txId
	 *            调息id
	 * @param czyid
	 *            创建人
	 */
	public void copyRentPlanIntoHis(String contract_id,String begin_id,String txId,String czyid) throws SQLException{
		String sql = "insert into fund_rent_plan_his " +
						"(doc_id,measure_date,contract_id,begin_id,rent_list,plan_date,pena_plan_date," +
						"curr_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage," +
						"interest_overage,curr_penalty,penalty,penalty_overage,plan_status,pena_status," +
						"plan_bank_name,plan_bank_no,mod_stuff,mod_status,mod_reason,creator," +
						"create_date,modificator,modify_date,tx_id,status) select " +
						" doc_id,getdate(),contract_id,begin_id,rent_list,plan_date,pena_plan_date," +
						"curr_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage," +
						"interest_overage,curr_penalty,penalty,penalty_overage,plan_status,pena_status," +
						"plan_bank_name,plan_bank_no,mod_stuff,mod_status,'调息',creator,create_date," +
						"modificator,modify_date,'"+txId+"','后' from fund_rent_plan where " +
						"contract_id='" +contract_id+"' and begin_id='"+begin_id+"' and rent_list<=(select rent_list_start" +
						" from fund_adjust_interest_contract where contract_id='"+contract_id+"' " +
								" and begin_id='"+begin_id+"' and adjust_id ='"+txId+"'	)";
			erpDataSource=new ERPDataSource();
			erpDataSource.executeUpdate(sql);
			erpDataSource.close();
	}
	/**
	 * 获得调息测算所需要的交易结构条件
	 * 
	 * @param contract_id
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public Map getConditionInfo(String contract_id,String begin_id,String txId) throws SQLException{
		Map<String, String> RentPlan_Map = new HashMap<String, String>();
		String sql = "select fa.left_corpus as lease_money,fa.after_rate as year_rate,bi.income_number_year," +
				"bi.income_number-fa.rent_list_start as income_number,fa.implicite_rate,fa.rent_list_start,bi.assets_value,bi.period_type,bi.ratio_param,bi.rate_float_type from " +
				"begin_info bi left join fund_adjust_interest_contract fa on " +
				"bi.contract_id=fa.contract_id and bi.begin_id=fa.begin_id where " +
				"fa.contract_id='"+contract_id+"' and fa.begin_id= '"+begin_id+"' " +
						"and adjust_id='"+txId+"' ";
		erpDataSource=new ERPDataSource();
		rs = erpDataSource.executeQuery(sql);
		if(rs.next()){
			RentPlan_Map.put("lease_money", rs.getString("lease_money"));// 剩余本金
			RentPlan_Map.put("year_rate", rs.getString("year_rate"));// 调息后的年利率
			RentPlan_Map.put("implicite_rate", rs.getString("implicite_rate"));// 调息后的年利率
			RentPlan_Map.put("income_number_year", rs.getString("income_number_year"));// 租金间隔
			RentPlan_Map.put("income_number", rs.getString("income_number"));// 剩余期数
			RentPlan_Map.put("assets_value", rs.getString("assets_value"));// 资产余值
			RentPlan_Map.put("period_type", rs.getString("period_type"));// 付租类型
			RentPlan_Map.put("rent_list_start", rs.getString("rent_list_start"));// 付租类型
			RentPlan_Map.put("ratio_param", rs.getString("ratio_param"));// 公差/比值
			RentPlan_Map.put("rate_float_type", rs.getString("rate_float_type"));// 公差/比值
		}
		erpDataSource.close();
		return RentPlan_Map;
	}
	
	/**
	 * 插入His表调息后的租金计划数据
	 * 
	 * @param contract_id
	 * @param rentInfoBox
	 *            封装租金计划
	 * @param rent_list_start
	 *            开始期次
	 * @param txId
	 *            调息id
	 * @param czyid
	 *            创建者
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public int copyRentPlanIntoHisAfter(String contract_id,String begin_id,Tx_RentInfoBox rentInfoBox,
			Map<String,String> condition_Map,String txId,String czyid) throws SQLException{
		
		int rent_list_start = Integer.parseInt(condition_Map.get("rent_list_start"));// 开始期数
		String after_rate = condition_Map.get("year_rate");// 调息后的年利率
		int flag = 0;
		List<String> l_rent = rentInfoBox.getL_rent();// 调息后的租金list
		List<String> l_corpus = rentInfoBox.getL_corpus();// 调息后的本金list
		List<String> l_interest = rentInfoBox.getL_interest();// 调息后的利息list
		List<String> l_corups_overate = rentInfoBox.getL_corpus_overage();// 调息后的剩余本金list
		String sql = "";
		erpDataSource=new ERPDataSource();
		for(int i=0;i<l_rent.size();i++){
			sql = "insert into fund_rent_plan_his " +
			"(doc_id,measure_date,contract_id,begin_id,rent_list,plan_date,pena_plan_date," +
			"curr_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage," +
			"interest_overage,curr_penalty,penalty,penalty_overage,plan_status,pena_status," +
			"plan_bank_name,plan_bank_no,mod_stuff,mod_status,mod_reason,creator," +
			"create_date,modificator,modify_date,tx_id,status,tax_rate,invoice_type) select " +
			" doc_id,getdate(),contract_id,begin_id,'"+(i+1+rent_list_start)+"',plan_date,pena_plan_date," +
			"'"+l_rent.get(i)+"','"+l_rent.get(i)+"'," +
					"'"+l_corpus.get(i)+"','"+after_rate+"','"+l_interest.get(i)
					+"',rent_overage,'"+l_corups_overate.get(i)+"'," +
			"interest_overage,curr_penalty,penalty,penalty_overage,plan_status,pena_status," +
			"plan_bank_name,plan_bank_no,mod_stuff,mod_status,'调息',creator,create_date," +
			"modificator,modify_date,'"+txId+"','后',tax_rate,invoice_type from fund_rent_plan where " +
			"contract_id='" +contract_id+"' and begin_id='"+begin_id+"' and rent_list='"+(i+1+rent_list_start)+"'";
// System.out.println("第四步SQL====="+sql);
			flag += erpDataSource.executeUpdate(sql);
			
		}
		if(flag>0) flag=1;
			erpDataSource.close();
		return flag;
	}
	
	/**
	 * 插入His表调息后的租金计划数据(针对隐含利率)
	 * 
	 * @param contract_id
	 * @param rentInfoBox
	 *            封装租金计划
	 * @param rent_list_start
	 *            开始期次
	 * @param txId
	 *            调息id
	 * @param czyid
	 *            创建者
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public int copyRentPlanIntoHisAfterForImp(String contract_id,String begin_id,Tx_RentInfoBox rentInfoBox,
			Map<String,String> condition_Map,String txId,String czyid) throws SQLException{
		
		int rent_list_start = Integer.parseInt(condition_Map.get("rent_list_start"));// 开始期数
		//String after_rate = condition_Map.get("year_rate");// 调息后的年利率
		int flag = 0;
		List<String> l_rent = rentInfoBox.getL_rent();// 调息后的租金list
		List<String> l_corpus = rentInfoBox.getL_corpus();// 调息后的本金list
		List<String> l_interest = rentInfoBox.getL_interest();// 调息后的利息list
		List<String> l_corups_overate = rentInfoBox.getL_corpus_overage();// 调息后的剩余本金list
		String sql = "";
		erpDataSource=new ERPDataSource();
		for(int i=0;i<l_rent.size();i++){
			sql = "insert into fund_rent_plan_his " +
			"(doc_id,measure_date,contract_id,begin_id,rent_list,plan_date,pena_plan_date," +
			"curr_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage," +
			"interest_overage,curr_penalty,penalty,penalty_overage,plan_status,pena_status," +
			"plan_bank_name,plan_bank_no,mod_stuff,mod_status,mod_reason,creator," +
			"create_date,modificator,modify_date,tx_id,status,tax_rate,invoice_type) select " +
			" doc_id,getdate(),contract_id,begin_id,'"+(i+1+rent_list_start)+"',plan_date,pena_plan_date," +
			"'"+l_rent.get(i)+"','"+l_rent.get(i)+"'," +
					"'"+l_corpus.get(i)+"',year_rate,'"+l_interest.get(i)
					+"',rent_overage,'"+l_corups_overate.get(i)+"'," +
			"interest_overage,curr_penalty,penalty,penalty_overage,plan_status,pena_status," +
			"plan_bank_name,plan_bank_no,mod_stuff,mod_status,'调息',creator,create_date," +
			"modificator,modify_date,'"+txId+"','后',tax_rate,invoice_type from fund_rent_plan where " +
			"contract_id='" +contract_id+"' and begin_id='"+begin_id+"' and rent_list='"+(i+1+rent_list_start)+"'";
// System.out.println("第四步SQL====="+sql);
			flag += erpDataSource.executeUpdate(sql);
			
		}
		if(flag>0) flag=1;
			erpDataSource.close();
		return flag;
	}
	
	/**
	 * 删除租金计划表开始期次之后的租金计划
	 * 
	 * @param contract_id
	 * @param rent_list_start
	 *            开始期次
	 * @throws SQLException
	 */
	public void delRentPlanAfter(String contract_id,String begin_id,int rent_list_start) throws SQLException{
	String sql = "delete from fund_rent_plan where contract_id='"+contract_id+"' " +
			"and begin_id= '"+begin_id+"' and rent_list > '"+rent_list_start+"'";
	erpDataSource=new ERPDataSource();
		erpDataSource.executeUpdate(sql);
		erpDataSource.close();
	}
	
	
	/**
	 * 把开始期次之后的数据从his表全部拷入到正式表中
	 * 
	 * @param contract_id
	 * @param txId
	 *            调息id
	 * @param czyid
	 *            创建人
	 */
	public void copyRentPlanFromHis(String contract_id,String begin_id,String txId) throws SQLException{
		String sql = "insert into fund_rent_plan " +
		"(doc_id,contract_id,begin_id,rent_list,plan_date,pena_plan_date," +
		"curr_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage," +
		"interest_overage,curr_penalty,penalty,penalty_overage,plan_status,pena_status," +
		"plan_bank_name,plan_bank_no,mod_stuff,mod_status,mod_reason,creator," +
		"create_date,modificator,modify_date,curr_corpus,curr_interest,tax_rate,invoice_type) select " +
		" doc_id,contract_id,begin_id,rent_list,plan_date,pena_plan_date," +
		"curr_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage," +
		"interest_overage,curr_penalty,penalty,penalty_overage,plan_status,pena_status," +
		"plan_bank_name,plan_bank_no,mod_stuff,mod_status,null,creator,create_date," +
		"modificator,modify_date,corpus,interest,tax_rate,invoice_type  from fund_rent_plan_his where status='后' and tx_id='"+txId+"' and " +
		"contract_id='" +contract_id+"' and begin_id='"+begin_id+"' and rent_list>(select rent_list_start" +
		" from fund_adjust_interest_contract where contract_id='"+contract_id+"' " +
				" and begin_id='"+begin_id+"' and adjust_id ='"+txId+"'	)";
System.out.println("第六步:把调息后的数据从his表拷到正式表======"+sql);
		erpDataSource=new ERPDataSource();
			erpDataSource.executeUpdate(sql);
			erpDataSource.close();
	}
	
	
	/**
	 * 把调息记录表中的调息状态更新为 是
	 * 
	 * @param contract_id
	 * @param rent_list_start
	 *            开始期次
	 * @throws SQLException
	 */
	public void updateFundAdjust(String contract_id,String begin_id,String txId) throws SQLException{
	String sql = "update fund_adjust_interest_contract set adjust_flag='是' where " +
			"contract_id='"+contract_id+"' and begin_id= '"+begin_id+"' and adjust_id ='"+txId+"'";
	erpDataSource=new ERPDataSource();
		erpDataSource.executeUpdate(sql);
		erpDataSource.close();
	}
	
	/**
	 * 
	 * 调息成功后把交易结构条件中的年利率更新为调息后的年利率
	 * 
	 * @param contract_id
	 * @param rent_list_start
	 *            开始期次
	 * @throws SQLException
	 */
	public void updateConditionForProcess(String contract_id,String begin_id,String txId) throws SQLException{
	String sql = "update begin_info set year_rate =" +
			"(select after_rate from fund_adjust_interest_contract where " +
			"contract_id='"+contract_id+"' and begin_id='"+begin_id+"' and adjust_id ='"+txId+"' "+
			") where " +
			"contract_id='"+contract_id+"' and begin_id= '"+begin_id+"'";
		//System.out.println("sql==="+sql);
	erpDataSource=new ERPDataSource();
		erpDataSource.executeUpdate(sql);
		erpDataSource.close();
	}
	
	/**
	 * 调息撤销时删除租金计划正式表的数据
	 * 
	 * @param contract_id
	 * @param txId
	 * @throws SQLException
	 */
	public void delPlanForCancle(String contract_id,String begin_id,String txId) throws SQLException{
		String sql = "delete from fund_rent_plan where " +
		"contract_id='"+contract_id+"' and begin_id= '"+begin_id+"' and rent_list > (select rent_list_start from " +
				"fund_adjust_interest_contract where contract_id='"+contract_id+"' and begin_id= '"+begin_id+"' and " +
						"adjust_id='"+txId+"')";
		System.out.println("第1步SQL="+sql);
		erpDataSource=new ERPDataSource();
	erpDataSource.executeUpdate(sql);
	erpDataSource.close();
	}
	
	/**
	 * 调息撤销时把调息前的租金计划从his表中拷入正式表
	 * 
	 * @param contract_id
	 * @param txId
	 * @throws SQLException
	 */
	public void copPlanForCancle(String contract_id,String begin_id,String txId) throws SQLException{
		String sql = "insert into fund_rent_plan " +
		"(doc_id,contract_id,begin_id,rent_list,plan_date,pena_plan_date," +
		"curr_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage," +
		"interest_overage,curr_penalty,penalty,penalty_overage,plan_status,pena_status," +
		"plan_bank_name,plan_bank_no,mod_stuff,mod_status,mod_reason,creator," +
		"create_date,modificator,modify_date,curr_corpus,curr_interest,tax_rate,invoice_type) select " +
		" doc_id,contract_id,begin_id,rent_list,plan_date,pena_plan_date," +
		"curr_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage," +
		"interest_overage,curr_penalty,penalty,penalty_overage,plan_status,pena_status," +
		"plan_bank_name,plan_bank_no,mod_stuff,mod_status,null,creator,create_date," +
		"modificator,modify_date,curr_corpus,curr_interest,tax_rate,invoice_type from fund_rent_plan_his where " +
		"contract_id='" +contract_id+"' and begin_id= '"+begin_id+"' and rent_list>(select rent_list_start" +
		" from fund_adjust_interest_contract where contract_id='"+contract_id+"' " +
				" and begin_id= '"+begin_id+"' and adjust_id ='"+txId+"'	) and tx_id = '"+txId+"' and status='前'";
		System.out.println("第2步SQL="+sql);
		erpDataSource=new ERPDataSource();
	erpDataSource.executeUpdate(sql);
	erpDataSource.close();
	}
	
	/**
	 * 
	 * 调息撤销时把交易结构条件中的年利率更新为调息前的年利率
	 * 
	 * @param contract_id
	 * @param rent_list_start
	 *            开始期次
	 * @throws SQLException
	 */
	public void updateConditionForCancle(String contract_id,String begin_id,String txId) throws SQLException{
	String sql = "update begin_info set year_rate =" +
			"(select before_rate from fund_adjust_interest_contract where " +
			"contract_id='"+contract_id+"' and begin_id= '"+begin_id+"' and adjust_id ='"+txId+"' "+
			") where " +
			"contract_id='"+contract_id+"' and begin_id= '"+begin_id+"' ";
	System.out.println("第3步SQL="+sql);
	erpDataSource=new ERPDataSource();
		erpDataSource.executeUpdate(sql);
		erpDataSource.close();
	}
	
	/**
	 * 调息撤销时删除租金计划His表的数据
	 * 
	 * @param contract_id
	 * @param txId
	 * @throws SQLException
	 */
	public void delPlanHisForCancle(String contract_id,String begin_id,String txId) throws SQLException{
		String sql = "delete from fund_rent_plan_his where " +
		"contract_id='"+contract_id+"' and begin_id= '"+begin_id+"' and tx_id ='"+txId+"' ";
		System.out.println("第4步SQL="+sql);
		erpDataSource=new ERPDataSource();
	erpDataSource.executeUpdate(sql);
	erpDataSource.close();
	}
	
	/**
	 * 删除调息撤销时调息记录表的数据
	 * 
	 * @param contract_id
	 * @param txId
	 * @throws SQLException
	 */
	public int delFundAdjustForCancle(String contract_id,String begin_id,String txId) throws SQLException{
		int flag = 0;
		String sql = "delete from fund_adjust_interest_contract where " +
		"contract_id='"+contract_id+"' and begin_id= '"+begin_id+"' and adjust_id ='"+txId+"' ";
		System.out.println("第5步SQL="+sql);
		erpDataSource=new ERPDataSource();
	flag = erpDataSource.executeUpdate(sql);
	erpDataSource.close();
	return flag;
	}
	
	/**
	 * 获得调息前的租金，本金计划
	 * @param contract_id
	 * @param begin_id
	 * @param rent_list_start 调息开始期次
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public Map getRentInfoMap(String contract_id,String begin_id,String rent_list_start,String txId) throws SQLException{
		Map<String, List<String>> rentInfo_Map = new HashMap<String, List<String>>();//租金，本金list
		List<String> l_rent = new ArrayList<String>();//租金
		List<String> l_rent_list = new ArrayList<String>();//期次
		List<String> l_corpus = new ArrayList<String>();//本金
		List<String> l_corpus_overage = new ArrayList<String>();//剩余本金
		List<String> l_rent_date = new ArrayList<String>();//计划日期
		List<String> startDateList = new ArrayList<String>();//计划日期
		String rent="0";
		String rent_list="0";
		String rent_date ="";
		String corpus="0";
		String corpus_overage="0";
		String startDate="";
		String sql = "select plan_date,rent_list,rent,corpus,corpus_overage from fund_rent_plan where contract_id='"+contract_id+"' " +
				"and begin_id= '"+begin_id+"' and rent_list>'"+rent_list_start+"' order by rent_list asc ";
		System.out.println("获得调息前的租金，本金计划sql="+sql);
		
		String sqlStartDate = " select t2.plan_date startDate from fund_adjust_interest_contract t1 "+
		" left join fund_rent_plan t2  on t2.contract_id = t1.contract_id "+
		" and t2.begin_id = t1.begin_id "+
		" and t1.rent_list_start = t2.rent_list "+
		" where adjust_id ='"+txId+"' "+
		" and t1.begin_id ='"+begin_id+"' "+
		" and  t1.contract_id ='"+contract_id+"' ";
		
		erpDataSource=new ERPDataSource();
		rs = erpDataSource.executeQuery(sql);
		while(rs.next()){
			rent = rs.getString("rent");
			rent_list = rs.getString("rent_list");
			corpus = rs.getString("corpus");
			rent_date = rs.getString("plan_date");
			corpus_overage = rs.getString("corpus_overage");
			l_rent.add(rent);
			l_rent_list.add(rent_list);
			l_corpus.add(corpus);
			l_corpus_overage.add(corpus_overage);
			l_rent_date.add(rent_date);
		}
		rentInfo_Map.put("l_rent", l_rent);
		rentInfo_Map.put("l_corpus", l_corpus);
		rentInfo_Map.put("corpus_overage", l_corpus_overage);
		rentInfo_Map.put("l_old_rent_date", l_rent_date);
		
		rs = erpDataSource.executeQuery(sqlStartDate);
		if(rs.next()){
			startDate = rs.getString("startDate");
			startDateList.add(startDate);
		}
		rentInfo_Map.put("startDate", startDateList);
		erpDataSource.close();
		return rentInfo_Map;
	}
	/**获得原始的交易结构条件（针对平息法调息）
	 * @param contract_id
	 * @param begin_id
	 * @return
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public Map getOldConditionMap(String contract_id,String begin_id) throws SQLException{
		Map<String, String> oldCondition_Map = new HashMap<String, String>();
		String lease_money = "";//租赁本金
		String lease_term = "";//租赁期限
		String income_number_year = "";//付租类型
		String assets_value = "";//资产余值
		String sql ="select lease_money,lease_term,income_number_year,assets_value from begin_info where contract_id='"+contract_id+"' " +
				"and begin_id= '"+begin_id+"'";
		erpDataSource=new ERPDataSource();
		rs = erpDataSource.executeQuery(sql);
		if(rs.next()){

			lease_money = rs.getString("lease_money");
			lease_term = rs.getString("lease_term");
			income_number_year = rs.getString("income_number_year");
			assets_value = rs.getString("assets_value");
		}
		oldCondition_Map.put("lease_money", lease_money);
		oldCondition_Map.put("lease_term", lease_term);
		oldCondition_Map.put("income_number_year", income_number_year);
		oldCondition_Map.put("assets_value", assets_value);
		erpDataSource.close();
		return oldCondition_Map;
	}
	/**
	 * 获得最大期次，针对次日调息判断需要
	 * @param string
	 * @param txId
	 * @param czyid
	 * @return
	 * @throws SQLException 
	 */
	public int getMaxRentList(String begin_id) throws SQLException {
		int max_list = 0;
		String sql = "select max(rent_list) max_list from fund_rent_plan where begin_id='"+begin_id+"'";
		erpDataSource=new ERPDataSource();
		rs = erpDataSource.executeQuery(sql);
		if(rs.next()){
			max_list = Integer.parseInt(rs.getString("max_list"));
		}
		erpDataSource.close();
		return max_list;
	}
	/**
	 * 计算次日调息
	 * @param string
	 * @param rent_list_start
	 * @param txId
	 * （当期的剩余本金+当期的本金）*（当期计划日期-调息日期）*（调息后利率-调息前利率）
	 * @return
	 * @throws SQLException 
	 */
	public double getAdjust_Interest(String begin_id, int rent_list_start,
			String txId) throws SQLException {
		double adjust_interest =  0.00;
		
		String sql = "select round((corpus+corpus_overage)*datediff(dd,(select start_date from " +
					"fund_standard_interest where id='"+txId+"'),plan_date)*(select after_rate-before_rate from " +
					"fund_adjust_interest_contract where adjust_id='"+txId+"' and begin_id='"+begin_id+"' and rent_list='"+
					rent_list_start+"')*0.01/360.0,2) as adjust_interest from fund_rent_plan where" +
							" begin_id='"+begin_id+"' and rent_list='"+rent_list_start+"'";
		erpDataSource=new ERPDataSource();
		rs = erpDataSource.executeQuery(sql);
		if(rs.next()){
			adjust_interest = Double.parseDouble(rs.getString("adjust_interest"));
		}
		erpDataSource.close();
		return adjust_interest;
	}
	/**
	 * 次日调息中，当期的租金计划是否已经核销
	 * @param string
	 * @param rent_list_start
	 * @return
	 * @throws SQLException 
	 */
	public String getIsRentHire(String begin_id, int rent_list_start) throws SQLException {
		String is_hire="是";
		String sql = "select plan_status from fund_rent_plan where begin_id='"+begin_id+"' " +
				"and rent_list = '"+rent_list_start+"' and plan_status='未回笼' ";
		erpDataSource=new ERPDataSource();
		rs = erpDataSource.executeQuery(sql);
		if(rs.next()){
			is_hire="否";
		}
		
		erpDataSource.close();
		return is_hire;
	}
	/**
	 * 次日调息后更新His表中当期增加的利息值
	 * @param begin_id
	 * @param rent_list_start
	 * @param txId
	 * @throws SQLException 
	 */
	public void updateRentAfterHis(String begin_id,double adjust_interest, int rent_list_start,
			String txId) throws SQLException {
		String sql = "update fund_rent_plan_his set interest=interest+'"+adjust_interest+"'," +
				"rent=rent+'"+adjust_interest+"' where " +
				"tx_id='"+txId+"' and begin_id='"+begin_id+"' and rent_list ='"+rent_list_start+"'" +
						" and status='后'";
		erpDataSource=new ERPDataSource();
		erpDataSource.executeUpdate(sql);
		sql = " update fund_rent_plan_his set year_rate=(Select year_rate from begin_info where begin_id='" + begin_id + "')  ";
	    sql = sql + " where tx_id='" + txId + "' and begin_id='" + begin_id + "' and rent_list ='" + rent_list_start + "' and status='后'";
	    erpDataSource.executeUpdate(sql);
		erpDataSource.close();	
	}
	/**
	 * 次日调息后更新His表中当期增加的利息值
	 * @param begin_id
	 * @param adjust_interest
	 * @param rent_list_start
	 * @throws SQLException 
	 */
	public void updateRentAfter(String begin_id, double adjust_interest,
			int rent_list_start) throws SQLException {
		String sql = "update fund_rent_plan set interest=interest+'"+adjust_interest+"'," +
				"rent=rent+'"+adjust_interest+"'  where " +
		" begin_id='"+begin_id+"' and rent_list ='"+rent_list_start+"'" ;
		erpDataSource=new ERPDataSource();
		erpDataSource.executeUpdate(sql);
		sql = " update fund_rent_plan set year_rate=(Select year_rate from begin_info where begin_id='" + begin_id + "')  ";
	    sql = sql + " where  begin_id='" + begin_id + "' and rent_list ='" + rent_list_start + "'";
	    System.out.println("次日调息后更新His表中当期增加的利息值--更新当期租金期次：" + rent_list_start + " 租赁年利率");

	    System.out.println("Sql22222::" + sql);
	    erpDataSource.executeUpdate(sql);
		erpDataSource.close();			
	}
	/**
	 * 次日调息中的撤销操作中，对当期进行单独更新操作
	 * @param begin_id
	 * @param txId
	 * @throws SQLException 
	 */
	public void updateRentAfterCancle(String begin_id, String txId) throws SQLException {
		/*String sql = "update fund_rent_plan set interest=(select interest from fund_rent_plan_his " +
				"where begin_id='"+begin_id+"' and tx_id='"+txId+"' and status='前'),rent=(select rent from fund_rent_plan_his " +
				"where begin_id='"+begin_id+"' and tx_id='"+txId+"' and status='前') where " +
		" begin_id='"+begin_id+"' and rent_list =(select rent_list_start from fund_adjust_interest_contract where " +
				"begin_id='"+begin_id+"' and adjust_id='"+txId+"')" ;*/
		
		String sql = 
			"update fund_rent_plan set interest=tt.interest, rent=tt.rent,year_rate = tt.year_rate "+
			" from fund_rent_plan_his tt where "+
			 " tt.begin_id='"+begin_id+"' and tt.tx_id='"+txId+"' and status='前' and tt.rent_list =(select rent_list_start from fund_adjust_interest_contract where begin_id='"+begin_id+"' and adjust_id='"+txId+"')"+
			 " and fund_rent_plan.begin_id='"+begin_id+"' "+
			" and fund_rent_plan.rent_list =(select rent_list_start from fund_adjust_interest_contract where begin_id='"+begin_id+"' and adjust_id='"+txId+"')";
		System.out.println("sql======"+sql);
		erpDataSource=new ERPDataSource();
		erpDataSource.executeUpdate(sql);
		erpDataSource.close();			
	}
	/**
	 * 计算次年调息当期的利息差
	 * @param string
	 * @param rent_list_start
	 * @param txId
	 * （当期的剩余本金+当期的本金）*（当期计划日期-调息日期）*（调息后利率-调息前利率）
	 * @return
	 * @throws SQLException 
	 */
	public double getAdjust_Interest2(String begin_id, int rent_list_start,
			String txId) throws SQLException {
		double adjust_interest =  0.00;
		
		String sql = "select round((corpus+corpus_overage)*datediff(dd,(select cast(YEAR(start_date) as char(4))+'-12-31' from " +
					"fund_standard_interest where id='"+txId+"'),plan_date)*(select after_rate-before_rate from " +
					"fund_adjust_interest_contract where adjust_id='"+txId+"' and begin_id='"+begin_id+"' and rent_list='"+
					rent_list_start+"')*0.01/360.0,2) as adjust_interest from fund_rent_plan where" +
							" begin_id='"+begin_id+"' and rent_list='"+rent_list_start+"'";
		erpDataSource=new ERPDataSource();
		rs = erpDataSource.executeQuery(sql);
		if(rs.next()){
			adjust_interest = Double.parseDouble(rs.getString("adjust_interest"));
		}
		erpDataSource.close();
		return adjust_interest;
	}
	
	/**
	 * 次年调息，当次年没有期次，直接把plan表copy到his表
	 * 
	 * @param contract_id
	 * @param txId
	 *            调息id
	 * @param czyid
	 *            创建人
	 */
	
	/*public static void main(String[] args) {
		try {
			copyRentPlanAllIntoHis("12CULC011471L53","12CULC011471L5350","130","admin");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}*/
	public static void copyRentPlanAllIntoHis(String contract_id,String begin_id,String txId,String czyid) throws SQLException{
		String sql = "insert into fund_rent_plan_his " +
						"(doc_id,measure_date,contract_id,begin_id,rent_list,plan_date,pena_plan_date," +
						"curr_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage," +
						"interest_overage,curr_penalty,penalty,penalty_overage,plan_status,pena_status," +
						"plan_bank_name,plan_bank_no,mod_stuff,mod_status,mod_reason,creator," +
						"create_date,modificator,modify_date,tx_id,status,tax_rate,invoice_type) select " +
						" doc_id,getdate(),contract_id,begin_id,rent_list,plan_date,pena_plan_date," +
						"curr_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage," +
						"interest_overage,curr_penalty,penalty,penalty_overage,plan_status,pena_status," +
						"plan_bank_name,plan_bank_no,mod_stuff,mod_status,'调息',creator,create_date," +
						"modificator,modify_date,'"+txId+"','后',tax_rate,invoice_type from fund_rent_plan where " +
						"contract_id='" +contract_id+"' and begin_id='"+begin_id+"' ";
			erpDataSource=new ERPDataSource();
			erpDataSource.executeUpdate(sql);
			erpDataSource.close();
	}
}
