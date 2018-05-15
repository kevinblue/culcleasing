package com.condition;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dbconn.Conn;

/**
 * <p>资产包处理类。</p>
 * @author 小谢
 * <p>Jan 26, 2011</p>
 */
public class ZC_Package {
	
	/**
	 * <p>根据传入的值生成一个以日期开头的唯一标识编码。</p>
	 * @author 小谢
	 * @param num
	 * @return
	 */
	public String get_Id(){
		String id = "";
//		Conn db = new Conn();
//		String sql = "select newid() as number ";
//		try {
//			ResultSet rs = db.executeQuery(sql);
//			while(rs.next()){
//				id = rs.getString("number");
//			}
//			rs.close();
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}finally{
//			db.close();
//		}
		//sql形式的
		//select replace(replace(replace(replace(convert(varchar,getdate(),21),'-',''),':',''),'.',''),' ','')
		//long time = System.currentTimeMillis();//获取系统当前时间精确到毫秒
		//id = String.valueOf(time);//拼装日志表的唯一主键
		//日期精确到毫秒形式的编号
		long time = System.currentTimeMillis();//获取系统当前时间精确到毫秒
		id = String.valueOf(time);//拼装日志表的唯一主键
		return id;
	}
	/**
	 * <p>根据资产编号计算偿还计划中总的租金，本金，利息金额值。</p>
	 * @author 小谢
	 * @param Zc_num
	 * @return
	 */
	public List<String> querySumMoney(String Zc_num){
		 List<String> list = new ArrayList<String>();
		Conn db = new Conn();
		String sum_rent = "";
		String sum_corpus = "";
		String sum_interest = "";
		String q_sum_rent = " select isnull(SUM(rent),'0') as rent,ISNULL(SUM(corpus),'0') as corpus,ISNULL(SUM(interest),'0') as interest from fund_rent_plan ";
		q_sum_rent = q_sum_rent +" where id  in ( ";
		q_sum_rent = q_sum_rent +" select Chjx_id from fund_Assets_rent_Corresponding where Zc_num = '"+Zc_num+"' ";
		q_sum_rent = q_sum_rent +" ) ";
		System.out.println("总共有多少租金本金利息需要开发票==>"+q_sum_rent);
		ResultSet rs;
		try {
			rs = db.executeQuery(q_sum_rent);
			while(rs.next()){
				sum_rent = getDBStr(rs.getString("rent"));
				sum_corpus = getDBStr(rs.getString("corpus"));
				sum_interest = getDBStr(rs.getString("interest"));
				//
				list.add(sum_rent);
				list.add(sum_corpus);
				list.add(sum_interest);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			db.close();
		}		
		return list;
	}
	/**
	 * <p>根据资产编号计算发票表中已开的租金，本金，利息金额值。</p>
	 * @author 小谢
	 * @param Zc_num
	 * @return
	 */
	public List<String> querySumMoney_Fp(String Zc_num){
		List<String> list = new ArrayList<String>();
		Conn db = new Conn();
		String yk_Fp_countMoney = "";
		String yk_Fp_corpus = "";
		String yk_Fp_interest = "";
		String Fp_rate = "";
		String q_s = " select isnull(sum(Fp_rate),'0') as Fp_rate ,ISNULL(SUM(Fp_countMoney),'0') as Fp_countMoney, ";
		q_s = q_s + " ISNULL(SUM(Fp_corpus),'0') as Fp_corpus, ";
		q_s = q_s + " ISNULL(SUM(Fp_interest),'0') as Fp_interest  from  fund_Assets_Invoice "; 
		q_s = q_s + " where id  in ( ";
		q_s = q_s + " 	select Fp_id from fund_Assets_Invoice_Corresponding where Zc_num = '"+Zc_num+"' ";
		q_s = q_s + " ) ";
		System.out.println("已开了多少发票比例 以及多少金额==>"+q_s);
		ResultSet rs;
		try {
			rs = db.executeQuery(q_s);
			while(rs.next()){
				yk_Fp_countMoney = getDBStr(rs.getString("Fp_countMoney"));
				yk_Fp_corpus = getDBStr(rs.getString("Fp_corpus"));
				yk_Fp_interest = getDBStr(rs.getString("Fp_interest"));
				Fp_rate = getDBStr(rs.getString("Fp_rate"));
				//
				list.add(yk_Fp_countMoney);
				list.add(yk_Fp_corpus);
				list.add(yk_Fp_interest);
				list.add(Fp_rate);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			db.close();
		}		
		return list;
	}
	/**
	 * 
	 * <p>根据资产编号查询发票表查看发票编号是否存在，任意一个不存在则表示发票不是最完整的。</p>
	 * @author 小谢
	 * @param zc_num
	 * @return
	 */
	public boolean  queryFpNum(String zc_num){
		List<String> list = new ArrayList<String>();
		boolean flag = false;
		String sql = "select fp_num from fund_Assets_Invoice where id in  ( ";
		       sql =  sql + " select Fp_id from fund_Assets_Invoice_Corresponding where Zc_num = '"+zc_num+"'";
		       sql =  sql + ")";
       Conn db = new Conn();
       String fp_num = "";
       ResultSet rs;
		try {
			rs = db.executeQuery(sql);
			while(rs.next()){
				fp_num = getDBStr(rs.getString("fp_num"));
				list.add(fp_num);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		if(list.size() > 0){
			for (int i = 0; i < list.size(); i++) {
				if("".equals(list.get(i)) || list.get(i) == null){
					flag = false;
					break;
				}else{
					flag = true;
				}
			}
		}else{
			flag = false;
		}
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
	
	public static void main(String[] args) {
		long time = System.currentTimeMillis();//获取系统当前时间精确到毫秒
		System.out.println(String.valueOf(time)+"_"+"001");//拼装日志表的唯一主键
	}
}
