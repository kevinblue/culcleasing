package com.condition;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.Tools;

import dbconn.Conn;

/**
 * <p>调息现金流备份处理方法。</p>
 * @author 小谢
 * <p>Jan 12, 2011</p>
 */
public class Tx_Init {
	
	/**
	 * <p>调息开始前先将现金流数据往2张his表中插入数据。</p>
	 * @author 小谢
	 * @param l_contract_id
	 * @return
	 */
	public int insert_HisTable_First(List<String> l_contract_id,String adjust_id){
		int flag = 0;
		Conn db = new Conn();
		for (int i = 0; i < l_contract_id.size(); i++) {
			//第一步: 插入之前先删除 
			String del_sql1 = " delete from fund_contract_plan_his where contract_id = '"+l_contract_id.get(i)+"' and adjust_id = '"+adjust_id+"' and status = '前' ";
			try {
				flag =  db.executeUpdate(del_sql1);
				String del_sql2  = " delete from fund_contract_plan_mark_his where contract_id = '"+l_contract_id.get(i)+"' and adjust_id = '"+adjust_id+"' and status = '前' ";
				flag =  db.executeUpdate(del_sql2); 
			} catch (Exception e) {
				e.printStackTrace();
			} 
			//第二步：调息之前往2张his表中插入数据，数据从fund_contract_plan,fund_contract_plan_mark中取
			StringBuffer sql = new StringBuffer();//财务现金流
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
				.append("            '调息','"+adjust_id+"','前'  ")
				.append("            from fund_contract_plan ")
				.append("            where contract_id = '"+l_contract_id.get(i)+"'  order by plan_date ")
				//.append("            and adjust_id = '"+adjust_id+"'  ")
			    .append("  ");
			StringBuffer sql2 = new StringBuffer();//市场现金流
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
				.append("            '调息','"+adjust_id+"','前'  ")
				.append("            from fund_contract_plan_mark ")
				.append("            where contract_id = '"+l_contract_id.get(i)+"'   order by plan_date ")
				//.append("            and adjust_id = '"+adjust_id+"'  ")
				.append("  ");
			try {
				flag =  db.executeUpdate(sql.toString());
				//System.out.println("调息前插入his表--"+sql);
				//System.out.println("调息前插入market_his表--"+sql.toString());
				flag =  db.executeUpdate(sql2.toString());
			} catch (Exception e) {
				e.printStackTrace();
			} 
		}
		db.close();
		return flag;
	}
	
	/**
	 * <p>调息后将新生成的现金流数据往2张his表中插入数据。</p>
	 * @author 小谢
	 * @param l_contract_id
	 * @return
	 */
	public int insert_HisTable_End(List<String> l_contract_id,String adjust_id){
		int flag = 0;
		Conn db = new Conn();
		for (int i = 0; i < l_contract_id.size(); i++) {
			//第一步: 插入之前先删除 
			String del_sql1 = " delete from fund_contract_plan_his where contract_id = '"+l_contract_id.get(i)+"' and adjust_id = '"+adjust_id+"'  and status = '后'";
			try {
				flag =  db.executeUpdate(del_sql1);
				String del_sql2  = " delete from fund_contract_plan_mark_his where contract_id = '"+l_contract_id.get(i)+"' and adjust_id = '"+adjust_id+"'  and status = '后' ";
				flag =  db.executeUpdate(del_sql2); 
			} catch (Exception e) {
				e.printStackTrace();
			} 
			//第二步：调息之前往2张his表中插入数据，数据从fund_contract_plan,fund_contract_plan_mark中取
			StringBuffer sql = new StringBuffer();//财务
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
				.append("            '调息','"+adjust_id+"','后'  ")
				.append("            from fund_contract_plan ")
				.append("            where contract_id = '"+l_contract_id.get(i)+"'  order by plan_date ")
				//.append("            and adjust_id = '"+adjust_id+"'  ")
			    .append("  ");
			StringBuffer sql2 = new StringBuffer();//市场
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
				.append("            '调息','"+adjust_id+"','后'  ")
				.append("            from fund_contract_plan_mark ")
				.append("            where contract_id = '"+l_contract_id.get(i)+"'  order by plan_date ")
				//.append("            and adjust_id = '"+adjust_id+"'  ")
				.append("  ");
			try {
				flag =  db.executeUpdate(sql.toString());
				System.out.println("调息后插入his表--"+sql);
				flag =  db.executeUpdate(sql2.toString());
				System.out.println("调息后插入market_his表--"+sql);
			} catch (Exception e) {
				e.printStackTrace();
			} 
		}
		db.close();
		return flag;
	}
	
	/**
	 * <p>调息回滚操作时重新测算IRR更新交易结构中的值。</p>
	 * @author 小谢
	 * @param contract_id
	 * @return
	 */
	@SuppressWarnings("static-access")
	public int js_irr(String contract_id){
		int flag = 0;
		Conn db = new Conn();
		ResultSet rs = null;
		//根据合同号查询交易结构
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
		//第一个财务IRR的参数 净流量列表
		List<String> l_inflow_pour = new ArrayList<String>();
		String cw_net_follow = "";//净流量
		try{	
			rs = db.executeQuery(query_cw_xjl);
			System.out.println("调息现金流后查询财务IRR需要的净流量SQL==》 "+query_cw_xjl);
			while(rs.next()){
				cw_net_follow = getDBStr(rs.getString("net_follow"));
				l_inflow_pour.add(cw_net_follow);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//第一个市场IRR的参数 净流量列表
		List<String> l_inflow_pour_market = new ArrayList<String>();
		String market_net_follow = "";//净流量
		try{	
			rs = db.executeQuery(query_market_xjl);
			System.out.println("调息现金流后查询市场IRR需要的净流量SQL==》 "+query_cw_xjl);
			while(rs.next()){
				market_net_follow = getDBStr(rs.getString("net_follow"));
				l_inflow_pour_market.add(market_net_follow);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		int sum = 12/Integer.parseInt(income_number_year);
		//调用计算IRR的方法
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
	 * <p>根据现金流临时表重新测算IRR更新交易结构中的值。</p>
	 * @author 小谢
	 * @param contract_id 合同号
	 * @param doc_id 文档号
	 * @return
	 */
	@SuppressWarnings("static-access")
	public int js_irr_temp(String contract_id,String doc_id){
		int flag = 0;
		Conn db = new Conn();
		ResultSet rs = null;
		//根据合同号查询交易结构
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
		//第一个财务IRR的参数 净流量列表
		List<String> l_inflow_pour = new ArrayList<String>();
		String cw_net_follow = "";//净流量
		try{	
			rs = db.executeQuery(query_cw_xjl);
			System.out.println("租金变更现金流后查询财务IRR需要的净流量SQL==》 "+query_cw_xjl);
			while(rs.next()){
				cw_net_follow = getDBStr(rs.getString("net_follow"));
				l_inflow_pour.add(cw_net_follow);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//第一个市场IRR的参数 净流量列表
		List<String> l_inflow_pour_market = new ArrayList<String>();
		String market_net_follow = "";//净流量
		try{	
			rs = db.executeQuery(query_market_xjl);
			System.out.println("租金变更现金流后查询市场IRR需要的净流量SQL==》 "+query_cw_xjl);
			while(rs.next()){
				market_net_follow = getDBStr(rs.getString("net_follow"));
				l_inflow_pour_market.add(market_net_follow);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		int sum = 12/Integer.parseInt(income_number_year);
		//调用计算IRR的方法
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
	 * <p>调息回滚后将对应现金流从his表中回滚到正式表中，财务和市场的，回滚前先删除。</p>
	 * @author 小谢
	 * @param contract_id
	 * @param adjust_id
	 * @return
	 */
	public int insert_ZS_Table(String contract_id,String adjust_id){
		int flag = 0;
		Conn db = new Conn();
			//第一步: 插入之前先删除 
			String del_sql1 = " delete from fund_contract_plan  where contract_id = '"+contract_id+"'  ";
			try {
				flag =  db.executeUpdate(del_sql1);
				String del_sql2  = " delete from fund_contract_plan_mark  where contract_id = '"+contract_id+"'  ";
				flag =  db.executeUpdate(del_sql2); 
			} catch (Exception e) {
				e.printStackTrace();
			} 
			//第二步：调息之前往2张正式表中插入数据，数据从fund_contract_plan_his,fund_contract_plan_mark_his中取
			StringBuffer sql = new StringBuffer();//财务现金流
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
			    .append("            and status = '前'   order by plan_date");
			StringBuffer sql2 = new StringBuffer();//市场现金流
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
				.append("            and status = '前'   order by plan_date");
			try {
				flag =  db.executeUpdate(sql.toString());
				System.out.println("调息回滚财务现金流表--"+sql);
				flag =  db.executeUpdate(sql2.toString());
				System.out.println("调息回滚市场现金流表--"+sql);
			} catch (Exception e) {
				e.printStackTrace();
			} 
		db.close();
		return flag;
	}
	
	/**
	 * <p>DB字符串取出处理。</p>
	 * @author common.jsp
	 * @param str 传入字符串
	 * @return 字符串为空返回空串
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
	 * <p>将空字符串转换为"0"。</p>
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
