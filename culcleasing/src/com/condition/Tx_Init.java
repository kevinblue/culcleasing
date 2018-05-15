package com.condition;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.Tools;

import dbconn.Conn;

/**
 * <p>��Ϣ�ֽ������ݴ�������</p>
 * @author Сл
 * <p>Jan 12, 2011</p>
 */
public class Tx_Init {
	
	/**
	 * <p>��Ϣ��ʼǰ�Ƚ��ֽ���������2��his���в������ݡ�</p>
	 * @author Сл
	 * @param l_contract_id
	 * @return
	 */
	public int insert_HisTable_First(List<String> l_contract_id,String adjust_id){
		int flag = 0;
		Conn db = new Conn();
		for (int i = 0; i < l_contract_id.size(); i++) {
			//��һ��: ����֮ǰ��ɾ�� 
			String del_sql1 = " delete from fund_contract_plan_his where contract_id = '"+l_contract_id.get(i)+"' and adjust_id = '"+adjust_id+"' and status = 'ǰ' ";
			try {
				flag =  db.executeUpdate(del_sql1);
				String del_sql2  = " delete from fund_contract_plan_mark_his where contract_id = '"+l_contract_id.get(i)+"' and adjust_id = '"+adjust_id+"' and status = 'ǰ' ";
				flag =  db.executeUpdate(del_sql2); 
			} catch (Exception e) {
				e.printStackTrace();
			} 
			//�ڶ�������Ϣ֮ǰ��2��his���в������ݣ����ݴ�fund_contract_plan,fund_contract_plan_mark��ȡ
			StringBuffer sql = new StringBuffer();//�����ֽ���
			sql.append(" INSERT INTO  fund_contract_plan_his ")
				.append("            (contract_id,doc_id ")
				.append("            ,plan_date,follow_in ")
				.append("            ,follow_in_detail,follow_out ")
				.append("            ,follow_out_detail,net_follow ")
				.append("            ,creator,create_date,modificator ")
				.append("            ,modify_date,note ")
				.append("            ,mod_reason,adjust_id,status ")
				.append("            ) select contract_id,doc_id ")
				.append("            ,plan_date,follow_in ")
				.append("            ,follow_in_detail,follow_out ")
				.append("            ,follow_out_detail,net_follow ")
				.append("            ,creator,create_date,modificator ")
				.append("            ,modify_date,note, ")
				.append("            '��Ϣ','"+adjust_id+"','ǰ'  ")
				.append("            from fund_contract_plan ")
				.append("            where contract_id = '"+l_contract_id.get(i)+"'  order by plan_date ")
				//.append("            and adjust_id = '"+adjust_id+"'  ")
			    .append("  ");
			StringBuffer sql2 = new StringBuffer();//�г��ֽ���
			sql2.append(" INSERT INTO  fund_contract_plan_mark_his ")
				.append("            (contract_id,doc_id ")
				.append("            ,plan_date,follow_in ")
				.append("            ,follow_in_detail,follow_out ")
				.append("            ,follow_out_detail,net_follow ")
				.append("            ,creator,create_date,modificator ")
				.append("            ,modify_date,note ")
				.append("            ,mod_reason,adjust_id,status ")
				.append("            ) select contract_id,doc_id ")
				.append("            ,plan_date,follow_in ")
				.append("            ,follow_in_detail,follow_out ")
				.append("            ,follow_out_detail,net_follow ")
				.append("            ,creator,create_date,modificator ")
				.append("            ,modify_date,note, ")
				.append("            '��Ϣ','"+adjust_id+"','ǰ'  ")
				.append("            from fund_contract_plan_mark ")
				.append("            where contract_id = '"+l_contract_id.get(i)+"'   order by plan_date ")
				//.append("            and adjust_id = '"+adjust_id+"'  ")
				.append("  ");
			try {
				flag =  db.executeUpdate(sql.toString());
				//System.out.println("��Ϣǰ����his��--"+sql);
				//System.out.println("��Ϣǰ����market_his��--"+sql.toString());
				flag =  db.executeUpdate(sql2.toString());
			} catch (Exception e) {
				e.printStackTrace();
			} 
		}
		db.close();
		return flag;
	}
	
	/**
	 * <p>��Ϣ�������ɵ��ֽ���������2��his���в������ݡ�</p>
	 * @author Сл
	 * @param l_contract_id
	 * @return
	 */
	public int insert_HisTable_End(List<String> l_contract_id,String adjust_id){
		int flag = 0;
		Conn db = new Conn();
		for (int i = 0; i < l_contract_id.size(); i++) {
			//��һ��: ����֮ǰ��ɾ�� 
			String del_sql1 = " delete from fund_contract_plan_his where contract_id = '"+l_contract_id.get(i)+"' and adjust_id = '"+adjust_id+"'  and status = '��'";
			try {
				flag =  db.executeUpdate(del_sql1);
				String del_sql2  = " delete from fund_contract_plan_mark_his where contract_id = '"+l_contract_id.get(i)+"' and adjust_id = '"+adjust_id+"'  and status = '��' ";
				flag =  db.executeUpdate(del_sql2); 
			} catch (Exception e) {
				e.printStackTrace();
			} 
			//�ڶ�������Ϣ֮ǰ��2��his���в������ݣ����ݴ�fund_contract_plan,fund_contract_plan_mark��ȡ
			StringBuffer sql = new StringBuffer();//����
			sql.append(" INSERT INTO  fund_contract_plan_his ")
				.append("            (contract_id,doc_id ")
				.append("            ,plan_date,follow_in ")
				.append("            ,follow_in_detail,follow_out ")
				.append("            ,follow_out_detail,net_follow ")
				.append("            ,creator,create_date,modificator ")
				.append("            ,modify_date,note ")
				.append("            ,mod_reason,adjust_id,status ")
				.append("            ) select contract_id,doc_id ")
				.append("            ,plan_date,follow_in ")
				.append("            ,follow_in_detail,follow_out ")
				.append("            ,follow_out_detail,net_follow ")
				.append("            ,creator,create_date,modificator ")
				.append("            ,modify_date,note, ")
				.append("            '��Ϣ','"+adjust_id+"','��'  ")
				.append("            from fund_contract_plan ")
				.append("            where contract_id = '"+l_contract_id.get(i)+"'  order by plan_date ")
				//.append("            and adjust_id = '"+adjust_id+"'  ")
			    .append("  ");
			StringBuffer sql2 = new StringBuffer();//�г�
			sql2.append(" INSERT INTO  fund_contract_plan_mark_his ")
				.append("            (contract_id,doc_id ")
				.append("            ,plan_date,follow_in ")
				.append("            ,follow_in_detail,follow_out ")
				.append("            ,follow_out_detail,net_follow ")
				.append("            ,creator,create_date,modificator ")
				.append("            ,modify_date,note ")
				.append("            ,mod_reason,adjust_id,status ")
				.append("            ) select contract_id,doc_id ")
				.append("            ,plan_date,follow_in ")
				.append("            ,follow_in_detail,follow_out ")
				.append("            ,follow_out_detail,net_follow ")
				.append("            ,creator,create_date,modificator ")
				.append("            ,modify_date,note, ")
				.append("            '��Ϣ','"+adjust_id+"','��'  ")
				.append("            from fund_contract_plan_mark ")
				.append("            where contract_id = '"+l_contract_id.get(i)+"'  order by plan_date ")
				//.append("            and adjust_id = '"+adjust_id+"'  ")
				.append("  ");
			try {
				flag =  db.executeUpdate(sql.toString());
				System.out.println("��Ϣ�����his��--"+sql);
				flag =  db.executeUpdate(sql2.toString());
				System.out.println("��Ϣ�����market_his��--"+sql);
			} catch (Exception e) {
				e.printStackTrace();
			} 
		}
		db.close();
		return flag;
	}
	
	/**
	 * <p>��Ϣ�ع�����ʱ���²���IRR���½��׽ṹ�е�ֵ��</p>
	 * @author Сл
	 * @param contract_id
	 * @return
	 */
	@SuppressWarnings("static-access")
	public int js_irr(String contract_id){
		int flag = 0;
		Conn db = new Conn();
		ResultSet rs = null;
		//���ݺ�ͬ�Ų�ѯ���׽ṹ
		String sql = " select * from contract_condition where contract_id = '"+contract_id+"' ";
		String income_number_year = "";
		try {
			rs = db.executeQuery(sql);
			while(rs.next()){
				income_number_year = getZeroStr(rs.getString("income_number_year"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		String query_cw_xjl = " select * from fund_contract_plan  where  contract_id = '"+contract_id+"'  order by plan_date";
		String query_market_xjl = " select * from fund_contract_plan_mark  where contract_id = '"+contract_id+"'  order by plan_date";
		//��һ������IRR�Ĳ��� �������б�
		List<String> l_inflow_pour = new ArrayList<String>();
		String cw_net_follow = "";//������
		try{	
			rs = db.executeQuery(query_cw_xjl);
			System.out.println("��Ϣ�ֽ������ѯ����IRR��Ҫ�ľ�����SQL==�� "+query_cw_xjl);
			while(rs.next()){
				cw_net_follow = getDBStr(rs.getString("net_follow"));
				l_inflow_pour.add(cw_net_follow);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//��һ���г�IRR�Ĳ��� �������б�
		List<String> l_inflow_pour_market = new ArrayList<String>();
		String market_net_follow = "";//������
		try{	
			rs = db.executeQuery(query_market_xjl);
			System.out.println("��Ϣ�ֽ������ѯ�г�IRR��Ҫ�ľ�����SQL==�� "+query_cw_xjl);
			while(rs.next()){
				market_net_follow = getDBStr(rs.getString("net_follow"));
				l_inflow_pour_market.add(market_net_follow);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		int sum = 12/Integer.parseInt(income_number_year);
		//���ü���IRR�ķ���
		String plan_irr = com.rent.calc.tx.bg.IrrCalc.getIRR(l_inflow_pour,income_number_year,income_number_year,String.valueOf(sum));
		String market_irr = com.rent.calc.tx.bg.IrrCalc.getIRR(l_inflow_pour_market,income_number_year,income_number_year,String.valueOf(sum));
		Tools tools = new Tools();
		String sqlstr = "update contract_condition  set plan_irr="+tools.formatNumberDoubleScale(plan_irr,8)+"*100,market_irr = "+tools.formatNumberDoubleScale(market_irr,8)+"*100  where contract_id='"+contract_id+"'   ";
		try {
			flag =db.executeUpdate(sqlstr);
		} catch (Exception e) {
			e.printStackTrace();
		}
		db.close();
		return flag;
	}
	/**
	 * <p>�����ֽ�����ʱ�����²���IRR���½��׽ṹ�е�ֵ��</p>
	 * @author Сл
	 * @param contract_id ��ͬ��
	 * @param doc_id �ĵ���
	 * @return
	 */
	@SuppressWarnings("static-access")
	public int js_irr_temp(String contract_id,String doc_id){
		int flag = 0;
		Conn db = new Conn();
		ResultSet rs = null;
		//���ݺ�ͬ�Ų�ѯ���׽ṹ
		String sql = " select * from contract_condition_temp where contract_id = '"+contract_id+"' and measure_id = '"+doc_id+"'";
		String income_number_year = "";
		try {
			rs = db.executeQuery(sql);
			while(rs.next()){
				income_number_year = getZeroStr(rs.getString("income_number_year"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		String query_cw_xjl = " select * from fund_contract_plan_temp  where  contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"'  order by plan_date";
		String query_market_xjl = " select * from fund_contract_plan_mark_temp  where contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"'  order by plan_date";
		//��һ������IRR�Ĳ��� �������б�
		List<String> l_inflow_pour = new ArrayList<String>();
		String cw_net_follow = "";//������
		try{	
			rs = db.executeQuery(query_cw_xjl);
			System.out.println("������ֽ������ѯ����IRR��Ҫ�ľ�����SQL==�� "+query_cw_xjl);
			while(rs.next()){
				cw_net_follow = getDBStr(rs.getString("net_follow"));
				l_inflow_pour.add(cw_net_follow);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//��һ���г�IRR�Ĳ��� �������б�
		List<String> l_inflow_pour_market = new ArrayList<String>();
		String market_net_follow = "";//������
		try{	
			rs = db.executeQuery(query_market_xjl);
			System.out.println("������ֽ������ѯ�г�IRR��Ҫ�ľ�����SQL==�� "+query_cw_xjl);
			while(rs.next()){
				market_net_follow = getDBStr(rs.getString("net_follow"));
				l_inflow_pour_market.add(market_net_follow);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		int sum = 12/Integer.parseInt(income_number_year);
		//���ü���IRR�ķ���
		String plan_irr = com.rent.calc.tx.bg.IrrCalc.getIRR(l_inflow_pour,income_number_year,income_number_year,String.valueOf(sum));
		String market_irr = com.rent.calc.tx.bg.IrrCalc.getIRR(l_inflow_pour_market,income_number_year,income_number_year,String.valueOf(sum));
		Tools tools = new Tools();
		String sqlstr = "update contract_condition_temp  set plan_irr="+tools.formatNumberDoubleScale(plan_irr,8)+"*100,market_irr = "+tools.formatNumberDoubleScale(market_irr,8)+"*100  where contract_id='"+contract_id+"'  and measure_id = '"+doc_id+"'  ";
		try {
			flag =db.executeUpdate(sqlstr);
		} catch (Exception e) {
			e.printStackTrace();
		}
		db.close();
		return flag;
	}
	
	/**
	 * <p>��Ϣ�ع��󽫶�Ӧ�ֽ�����his���лع�����ʽ���У�������г��ģ��ع�ǰ��ɾ����</p>
	 * @author Сл
	 * @param contract_id
	 * @param adjust_id
	 * @return
	 */
	public int insert_ZS_Table(String contract_id,String adjust_id){
		int flag = 0;
		Conn db = new Conn();
			//��һ��: ����֮ǰ��ɾ�� 
			String del_sql1 = " delete from fund_contract_plan  where contract_id = '"+contract_id+"'  ";
			try {
				flag =  db.executeUpdate(del_sql1);
				String del_sql2  = " delete from fund_contract_plan_mark  where contract_id = '"+contract_id+"'  ";
				flag =  db.executeUpdate(del_sql2); 
			} catch (Exception e) {
				e.printStackTrace();
			} 
			//�ڶ�������Ϣ֮ǰ��2����ʽ���в������ݣ����ݴ�fund_contract_plan_his,fund_contract_plan_mark_his��ȡ
			StringBuffer sql = new StringBuffer();//�����ֽ���
			sql.append(" INSERT INTO  fund_contract_plan ")
				.append("            (contract_id,doc_id ")
				.append("            ,plan_date,follow_in ")
				.append("            ,follow_in_detail,follow_out ")
				.append("            ,follow_out_detail,net_follow ")
				.append("            ,creator,create_date,modificator ")
				.append("            ,modify_date,note,adjust_id ")
				.append("            ) select contract_id,doc_id ")
				.append("            ,plan_date,follow_in ")
				.append("            ,follow_in_detail,follow_out ")
				.append("            ,follow_out_detail,net_follow ")
				.append("            ,creator,create_date,modificator ")
				.append("            ,modify_date,note,adjust_id ")
				.append("            from fund_contract_plan_his ")
				.append("            where contract_id = '"+contract_id+"'  ")
				.append("            and adjust_id = '"+adjust_id+"'  ")
			    .append("            and status = 'ǰ'   order by plan_date");
			StringBuffer sql2 = new StringBuffer();//�г��ֽ���
			sql2.append(" INSERT INTO  fund_contract_plan_mark ")
				.append("            (contract_id,doc_id ")
				.append("            ,plan_date,follow_in ")
				.append("            ,follow_in_detail,follow_out ")
				.append("            ,follow_out_detail,net_follow ")
				.append("            ,creator,create_date,modificator ")
				.append("            ,modify_date,note,adjust_id ")
				.append("            ) select contract_id,doc_id ")
				.append("            ,plan_date,follow_in ")
				.append("            ,follow_in_detail,follow_out ")
				.append("            ,follow_out_detail,net_follow ")
				.append("            ,creator,create_date,modificator ")
				.append("            ,modify_date,note,adjust_id ")
				.append("              ")
				.append("            from fund_contract_plan_mark_his ")
				.append("            where contract_id = '"+contract_id+"'  ")
				.append("            and adjust_id = '"+adjust_id+"'  ")
				.append("            and status = 'ǰ'   order by plan_date");
			try {
				flag =  db.executeUpdate(sql.toString());
				System.out.println("��Ϣ�ع������ֽ�����--"+sql);
				flag =  db.executeUpdate(sql2.toString());
				System.out.println("��Ϣ�ع��г��ֽ�����--"+sql);
			} catch (Exception e) {
				e.printStackTrace();
			} 
		db.close();
		return flag;
	}
	
	/**
	 * <p>DB�ַ���ȡ������</p>
	 * @author common.jsp
	 * @param str �����ַ���
	 * @return �ַ���Ϊ�շ��ؿմ�
	 */
	public String getDBStr(String str){
		try
		{
	        String temp_n = str;
	        if ((temp_n == null) || (temp_n.equals("")) || (temp_n.equals("null"))){
	        	temp_n = "";
	        }
	        return temp_n; 
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	/**
	 * <p>�����ַ���ת��Ϊ"0"��</p>
	 * @author common.jsp
	 * @param str
	 * @return
	 */
	public String getZeroStr(String str){
		try{
			String temp_n = str;
			if(temp_n == null || temp_n.equals("") || temp_n.equals("null")){
				temp_n = "0";
			}
			return temp_n;
		}catch(Exception e){
		
		}
		return "0";
	}
}
