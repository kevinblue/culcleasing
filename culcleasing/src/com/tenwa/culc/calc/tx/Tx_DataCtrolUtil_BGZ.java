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
	// ��������
	private ResultSet rs = null;
	/**
	 * �ѿ�ʼ�ڴ�֮ǰ������ȫ�����뵽his����
	 * 
	 * @param contract_id
	 * @param txId
	 *            ��Ϣid
	 * @param czyid
	 *            ������
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
						"plan_bank_name,plan_bank_no,mod_stuff,mod_status,'��Ϣ',creator,create_date," +
						"modificator,modify_date,'"+txId+"','��' from fund_rent_plan where " +
						"contract_id='" +contract_id+"' and begin_id='"+begin_id+"' and rent_list<=(select rent_list_start" +
						" from fund_adjust_interest_contract where contract_id='"+contract_id+"' " +
								" and begin_id='"+begin_id+"' and adjust_id ='"+txId+"'	)";
			erpDataSource=new ERPDataSource();
			erpDataSource.executeUpdate(sql);
			erpDataSource.close();
	}
	/**
	 * ��õ�Ϣ��������Ҫ�Ľ��׽ṹ����
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
			RentPlan_Map.put("lease_money", rs.getString("lease_money"));// ʣ�౾��
			RentPlan_Map.put("year_rate", rs.getString("year_rate"));// ��Ϣ���������
			RentPlan_Map.put("implicite_rate", rs.getString("implicite_rate"));// ��Ϣ���������
			RentPlan_Map.put("income_number_year", rs.getString("income_number_year"));// �����
			RentPlan_Map.put("income_number", rs.getString("income_number"));// ʣ������
			RentPlan_Map.put("assets_value", rs.getString("assets_value"));// �ʲ���ֵ
			RentPlan_Map.put("period_type", rs.getString("period_type"));// ��������
			RentPlan_Map.put("rent_list_start", rs.getString("rent_list_start"));// ��������
			RentPlan_Map.put("ratio_param", rs.getString("ratio_param"));// ����/��ֵ
			RentPlan_Map.put("rate_float_type", rs.getString("rate_float_type"));// ����/��ֵ
		}
		erpDataSource.close();
		return RentPlan_Map;
	}
	
	/**
	 * ����His���Ϣ������ƻ�����
	 * 
	 * @param contract_id
	 * @param rentInfoBox
	 *            ��װ���ƻ�
	 * @param rent_list_start
	 *            ��ʼ�ڴ�
	 * @param txId
	 *            ��Ϣid
	 * @param czyid
	 *            ������
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public int copyRentPlanIntoHisAfter(String contract_id,String begin_id,Tx_RentInfoBox rentInfoBox,
			Map<String,String> condition_Map,String txId,String czyid) throws SQLException{
		
		int rent_list_start = Integer.parseInt(condition_Map.get("rent_list_start"));// ��ʼ����
		String after_rate = condition_Map.get("year_rate");// ��Ϣ���������
		int flag = 0;
		List<String> l_rent = rentInfoBox.getL_rent();// ��Ϣ������list
		List<String> l_corpus = rentInfoBox.getL_corpus();// ��Ϣ��ı���list
		List<String> l_interest = rentInfoBox.getL_interest();// ��Ϣ�����Ϣlist
		List<String> l_corups_overate = rentInfoBox.getL_corpus_overage();// ��Ϣ���ʣ�౾��list
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
			"plan_bank_name,plan_bank_no,mod_stuff,mod_status,'��Ϣ',creator,create_date," +
			"modificator,modify_date,'"+txId+"','��',tax_rate,invoice_type from fund_rent_plan where " +
			"contract_id='" +contract_id+"' and begin_id='"+begin_id+"' and rent_list='"+(i+1+rent_list_start)+"'";
// System.out.println("���Ĳ�SQL====="+sql);
			flag += erpDataSource.executeUpdate(sql);
			
		}
		if(flag>0) flag=1;
			erpDataSource.close();
		return flag;
	}
	
	/**
	 * ����His���Ϣ������ƻ�����(�����������)
	 * 
	 * @param contract_id
	 * @param rentInfoBox
	 *            ��װ���ƻ�
	 * @param rent_list_start
	 *            ��ʼ�ڴ�
	 * @param txId
	 *            ��Ϣid
	 * @param czyid
	 *            ������
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public int copyRentPlanIntoHisAfterForImp(String contract_id,String begin_id,Tx_RentInfoBox rentInfoBox,
			Map<String,String> condition_Map,String txId,String czyid) throws SQLException{
		
		int rent_list_start = Integer.parseInt(condition_Map.get("rent_list_start"));// ��ʼ����
		//String after_rate = condition_Map.get("year_rate");// ��Ϣ���������
		int flag = 0;
		List<String> l_rent = rentInfoBox.getL_rent();// ��Ϣ������list
		List<String> l_corpus = rentInfoBox.getL_corpus();// ��Ϣ��ı���list
		List<String> l_interest = rentInfoBox.getL_interest();// ��Ϣ�����Ϣlist
		List<String> l_corups_overate = rentInfoBox.getL_corpus_overage();// ��Ϣ���ʣ�౾��list
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
			"plan_bank_name,plan_bank_no,mod_stuff,mod_status,'��Ϣ',creator,create_date," +
			"modificator,modify_date,'"+txId+"','��',tax_rate,invoice_type from fund_rent_plan where " +
			"contract_id='" +contract_id+"' and begin_id='"+begin_id+"' and rent_list='"+(i+1+rent_list_start)+"'";
// System.out.println("���Ĳ�SQL====="+sql);
			flag += erpDataSource.executeUpdate(sql);
			
		}
		if(flag>0) flag=1;
			erpDataSource.close();
		return flag;
	}
	
	/**
	 * ɾ�����ƻ���ʼ�ڴ�֮������ƻ�
	 * 
	 * @param contract_id
	 * @param rent_list_start
	 *            ��ʼ�ڴ�
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
	 * �ѿ�ʼ�ڴ�֮������ݴ�his��ȫ�����뵽��ʽ����
	 * 
	 * @param contract_id
	 * @param txId
	 *            ��Ϣid
	 * @param czyid
	 *            ������
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
		"modificator,modify_date,corpus,interest,tax_rate,invoice_type  from fund_rent_plan_his where status='��' and tx_id='"+txId+"' and " +
		"contract_id='" +contract_id+"' and begin_id='"+begin_id+"' and rent_list>(select rent_list_start" +
		" from fund_adjust_interest_contract where contract_id='"+contract_id+"' " +
				" and begin_id='"+begin_id+"' and adjust_id ='"+txId+"'	)";
System.out.println("������:�ѵ�Ϣ������ݴ�his������ʽ��======"+sql);
		erpDataSource=new ERPDataSource();
			erpDataSource.executeUpdate(sql);
			erpDataSource.close();
	}
	
	
	/**
	 * �ѵ�Ϣ��¼���еĵ�Ϣ״̬����Ϊ ��
	 * 
	 * @param contract_id
	 * @param rent_list_start
	 *            ��ʼ�ڴ�
	 * @throws SQLException
	 */
	public void updateFundAdjust(String contract_id,String begin_id,String txId) throws SQLException{
	String sql = "update fund_adjust_interest_contract set adjust_flag='��' where " +
			"contract_id='"+contract_id+"' and begin_id= '"+begin_id+"' and adjust_id ='"+txId+"'";
	erpDataSource=new ERPDataSource();
		erpDataSource.executeUpdate(sql);
		erpDataSource.close();
	}
	
	/**
	 * 
	 * ��Ϣ�ɹ���ѽ��׽ṹ�����е������ʸ���Ϊ��Ϣ���������
	 * 
	 * @param contract_id
	 * @param rent_list_start
	 *            ��ʼ�ڴ�
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
	 * ��Ϣ����ʱɾ�����ƻ���ʽ�������
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
		System.out.println("��1��SQL="+sql);
		erpDataSource=new ERPDataSource();
	erpDataSource.executeUpdate(sql);
	erpDataSource.close();
	}
	
	/**
	 * ��Ϣ����ʱ�ѵ�Ϣǰ�����ƻ���his���п�����ʽ��
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
				" and begin_id= '"+begin_id+"' and adjust_id ='"+txId+"'	) and tx_id = '"+txId+"' and status='ǰ'";
		System.out.println("��2��SQL="+sql);
		erpDataSource=new ERPDataSource();
	erpDataSource.executeUpdate(sql);
	erpDataSource.close();
	}
	
	/**
	 * 
	 * ��Ϣ����ʱ�ѽ��׽ṹ�����е������ʸ���Ϊ��Ϣǰ��������
	 * 
	 * @param contract_id
	 * @param rent_list_start
	 *            ��ʼ�ڴ�
	 * @throws SQLException
	 */
	public void updateConditionForCancle(String contract_id,String begin_id,String txId) throws SQLException{
	String sql = "update begin_info set year_rate =" +
			"(select before_rate from fund_adjust_interest_contract where " +
			"contract_id='"+contract_id+"' and begin_id= '"+begin_id+"' and adjust_id ='"+txId+"' "+
			") where " +
			"contract_id='"+contract_id+"' and begin_id= '"+begin_id+"' ";
	System.out.println("��3��SQL="+sql);
	erpDataSource=new ERPDataSource();
		erpDataSource.executeUpdate(sql);
		erpDataSource.close();
	}
	
	/**
	 * ��Ϣ����ʱɾ�����ƻ�His�������
	 * 
	 * @param contract_id
	 * @param txId
	 * @throws SQLException
	 */
	public void delPlanHisForCancle(String contract_id,String begin_id,String txId) throws SQLException{
		String sql = "delete from fund_rent_plan_his where " +
		"contract_id='"+contract_id+"' and begin_id= '"+begin_id+"' and tx_id ='"+txId+"' ";
		System.out.println("��4��SQL="+sql);
		erpDataSource=new ERPDataSource();
	erpDataSource.executeUpdate(sql);
	erpDataSource.close();
	}
	
	/**
	 * ɾ����Ϣ����ʱ��Ϣ��¼�������
	 * 
	 * @param contract_id
	 * @param txId
	 * @throws SQLException
	 */
	public int delFundAdjustForCancle(String contract_id,String begin_id,String txId) throws SQLException{
		int flag = 0;
		String sql = "delete from fund_adjust_interest_contract where " +
		"contract_id='"+contract_id+"' and begin_id= '"+begin_id+"' and adjust_id ='"+txId+"' ";
		System.out.println("��5��SQL="+sql);
		erpDataSource=new ERPDataSource();
	flag = erpDataSource.executeUpdate(sql);
	erpDataSource.close();
	return flag;
	}
	
	/**
	 * ��õ�Ϣǰ����𣬱���ƻ�
	 * @param contract_id
	 * @param begin_id
	 * @param rent_list_start ��Ϣ��ʼ�ڴ�
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public Map getRentInfoMap(String contract_id,String begin_id,String rent_list_start,String txId) throws SQLException{
		Map<String, List<String>> rentInfo_Map = new HashMap<String, List<String>>();//��𣬱���list
		List<String> l_rent = new ArrayList<String>();//���
		List<String> l_rent_list = new ArrayList<String>();//�ڴ�
		List<String> l_corpus = new ArrayList<String>();//����
		List<String> l_corpus_overage = new ArrayList<String>();//ʣ�౾��
		List<String> l_rent_date = new ArrayList<String>();//�ƻ�����
		List<String> startDateList = new ArrayList<String>();//�ƻ�����
		String rent="0";
		String rent_list="0";
		String rent_date ="";
		String corpus="0";
		String corpus_overage="0";
		String startDate="";
		String sql = "select plan_date,rent_list,rent,corpus,corpus_overage from fund_rent_plan where contract_id='"+contract_id+"' " +
				"and begin_id= '"+begin_id+"' and rent_list>'"+rent_list_start+"' order by rent_list asc ";
		System.out.println("��õ�Ϣǰ����𣬱���ƻ�sql="+sql);
		
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
	/**���ԭʼ�Ľ��׽ṹ���������ƽϢ����Ϣ��
	 * @param contract_id
	 * @param begin_id
	 * @return
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public Map getOldConditionMap(String contract_id,String begin_id) throws SQLException{
		Map<String, String> oldCondition_Map = new HashMap<String, String>();
		String lease_money = "";//���ޱ���
		String lease_term = "";//��������
		String income_number_year = "";//��������
		String assets_value = "";//�ʲ���ֵ
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
	 * �������ڴΣ���Դ��յ�Ϣ�ж���Ҫ
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
	 * ������յ�Ϣ
	 * @param string
	 * @param rent_list_start
	 * @param txId
	 * �����ڵ�ʣ�౾��+���ڵı���*�����ڼƻ�����-��Ϣ���ڣ�*����Ϣ������-��Ϣǰ���ʣ�
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
	 * ���յ�Ϣ�У����ڵ����ƻ��Ƿ��Ѿ�����
	 * @param string
	 * @param rent_list_start
	 * @return
	 * @throws SQLException 
	 */
	public String getIsRentHire(String begin_id, int rent_list_start) throws SQLException {
		String is_hire="��";
		String sql = "select plan_status from fund_rent_plan where begin_id='"+begin_id+"' " +
				"and rent_list = '"+rent_list_start+"' and plan_status='δ����' ";
		erpDataSource=new ERPDataSource();
		rs = erpDataSource.executeQuery(sql);
		if(rs.next()){
			is_hire="��";
		}
		
		erpDataSource.close();
		return is_hire;
	}
	/**
	 * ���յ�Ϣ�����His���е������ӵ���Ϣֵ
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
						" and status='��'";
		erpDataSource=new ERPDataSource();
		erpDataSource.executeUpdate(sql);
		sql = " update fund_rent_plan_his set year_rate=(Select year_rate from begin_info where begin_id='" + begin_id + "')  ";
	    sql = sql + " where tx_id='" + txId + "' and begin_id='" + begin_id + "' and rent_list ='" + rent_list_start + "' and status='��'";
	    erpDataSource.executeUpdate(sql);
		erpDataSource.close();	
	}
	/**
	 * ���յ�Ϣ�����His���е������ӵ���Ϣֵ
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
	    System.out.println("���յ�Ϣ�����His���е������ӵ���Ϣֵ--���µ�������ڴΣ�" + rent_list_start + " ����������");

	    System.out.println("Sql22222::" + sql);
	    erpDataSource.executeUpdate(sql);
		erpDataSource.close();			
	}
	/**
	 * ���յ�Ϣ�еĳ��������У��Ե��ڽ��е������²���
	 * @param begin_id
	 * @param txId
	 * @throws SQLException 
	 */
	public void updateRentAfterCancle(String begin_id, String txId) throws SQLException {
		/*String sql = "update fund_rent_plan set interest=(select interest from fund_rent_plan_his " +
				"where begin_id='"+begin_id+"' and tx_id='"+txId+"' and status='ǰ'),rent=(select rent from fund_rent_plan_his " +
				"where begin_id='"+begin_id+"' and tx_id='"+txId+"' and status='ǰ') where " +
		" begin_id='"+begin_id+"' and rent_list =(select rent_list_start from fund_adjust_interest_contract where " +
				"begin_id='"+begin_id+"' and adjust_id='"+txId+"')" ;*/
		
		String sql = 
			"update fund_rent_plan set interest=tt.interest, rent=tt.rent,year_rate = tt.year_rate "+
			" from fund_rent_plan_his tt where "+
			 " tt.begin_id='"+begin_id+"' and tt.tx_id='"+txId+"' and status='ǰ' and tt.rent_list =(select rent_list_start from fund_adjust_interest_contract where begin_id='"+begin_id+"' and adjust_id='"+txId+"')"+
			 " and fund_rent_plan.begin_id='"+begin_id+"' "+
			" and fund_rent_plan.rent_list =(select rent_list_start from fund_adjust_interest_contract where begin_id='"+begin_id+"' and adjust_id='"+txId+"')";
		System.out.println("sql======"+sql);
		erpDataSource=new ERPDataSource();
		erpDataSource.executeUpdate(sql);
		erpDataSource.close();			
	}
	/**
	 * ��������Ϣ���ڵ���Ϣ��
	 * @param string
	 * @param rent_list_start
	 * @param txId
	 * �����ڵ�ʣ�౾��+���ڵı���*�����ڼƻ�����-��Ϣ���ڣ�*����Ϣ������-��Ϣǰ���ʣ�
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
	 * �����Ϣ��������û���ڴΣ�ֱ�Ӱ�plan��copy��his��
	 * 
	 * @param contract_id
	 * @param txId
	 *            ��Ϣid
	 * @param czyid
	 *            ������
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
						"plan_bank_name,plan_bank_no,mod_stuff,mod_status,'��Ϣ',creator,create_date," +
						"modificator,modify_date,'"+txId+"','��',tax_rate,invoice_type from fund_rent_plan where " +
						"contract_id='" +contract_id+"' and begin_id='"+begin_id+"' ";
			erpDataSource=new ERPDataSource();
			erpDataSource.executeUpdate(sql);
			erpDataSource.close();
	}
}
