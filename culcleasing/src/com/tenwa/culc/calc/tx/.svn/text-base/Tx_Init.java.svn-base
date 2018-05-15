package com.tenwa.culc.calc.tx;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.Tools;
import com.tenwa.culc.util.ERPDataSource;

/**
 * 
 * @author Administrator
 * Date:10:59:27 AM       Email: toybaby@mail2.tenwa.com.cn
 */
public class Tx_Init {
	
	
	private static ERPDataSource erpDataSource=null;

	// 公共参数
	private ResultSet rs = null;
	private String start_date = "";//调息开始日期
	private String year_rate = "";//调息前年利率
	private String implicite_rate = "";//隐含利率调整系数
	public String getYear_rate() {
		return  this.year_rate;
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
	public String getImplicite_rate() {
		return implicite_rate;
	}

	public void setImplicite_rate(String implicite_rate) {
		this.implicite_rate = implicite_rate;
	}
	
	
	/*public static void main(String[] args) {
		ERPDataSource yy=new ERPDataSource();
		System.out.println(yy.toString());
		Tx_Init tx_init = new Tx_Init();
		try {
		int x = tx_init.Tx_Int_add("13CULC202171L59", "13CULC202171L5902", "129", "admin", "次年");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	};*/
	/**
	 * @param contract_str  合同编号STR
	 * @param begin_str	起租编号STR
	 * @param txId 调息ID
	 * @param czyid 用户
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("unused")
	public  int Tx_Int_add(String contract_str,String begin_str,String txId,String czyid,String str_adjust_style) throws Exception{
		
		int flag = 0;
		String [] contract_list = contract_str.split("#");//合同编号数组
		String [] begin_list = begin_str.split("#");//起租编号数组
		String [] adjust_style = str_adjust_style.split("#");//调息方式
		String after_rate = "";//调息后利率
		String start_list = "";//开始期次
		
		System.out.println("contract_str================"+contract_str);
		
		for(int i = 0; i<contract_list.length;i++){
			/**
			 *=================================
			 * 预留部分接口处，次日次期判断条件不同（暂时只处理次期）
			 * if("次日"){
			 * 次日算法
			 * }
			 * else{
			 * 次期算法
			 * }
			 * ================================
			 */	
			after_rate = getAfter_Rate(txId,contract_list[i],begin_list[i]);
			 System.out.println("after_rate================"+after_rate);
			 start_list = getStartList(this.start_date,begin_list[i],adjust_style[i]);//计划日期大于调息日期的第一期
			 System.out.println("start_list================"+start_list);
			System.out.println("调息后年利率=="+after_rate+"before_rate="+this.year_rate+" this.implicite_rate="+this.implicite_rate+"  调息开始日期="+this.start_date+
					"  调息开始期次="+start_list);
			//调息前插入租金计划历史表
				 addRentHisBeforeInfo(contract_list[i],begin_list[i],txId);
				 //插入调息状态表
				 flag += addFundAdjustInterest(contract_list[i],begin_list[i],txId,start_list,after_rate,
						 this.year_rate,this.implicite_rate,czyid);
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
	public String getAfter_Rate(String txId,String contract_id,String begin_id) throws SQLException{
		String tx_date = "";//调息开始日期
		String base_rate_one = "";//本次调息后一年基础利率
		String base_rate_three = "";//本次调息后三年基础利率
		String base_rate_five = "";//本次调息五年基础利率
		String base_rate_abovefive = "";//本次调息后五年以上基础利率
	    String rate_one = "";//一年调息值
	    String rate_three = "";//三年调息值
	    String rate_five = "";//五年调息值
	    String rate_abovefive = "";//五年以上调息值
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
		    	rate_one = rs.getString("rate_one");
		    	rate_three = rs.getString("rate_three");
		    	rate_five = rs.getString("rate_five");
		    	rate_abovefive = rs.getString("rate_abovefive");	
				
			}
			//Map封装调息利率值
			Rate_Map.put("start_date", start_date);
			Rate_Map.put("base_rate_one", base_rate_one);
			Rate_Map.put("base_rate_three", base_rate_three);
			Rate_Map.put("base_rate_five", base_rate_five);
			Rate_Map.put("base_rate_abovefive", base_rate_abovefive);
			Rate_Map.put("rate_one", rate_one);
			Rate_Map.put("rate_three", rate_three);
			Rate_Map.put("rate_five", rate_five);
			Rate_Map.put("rate_abovefive", rate_abovefive);
			erpDataSource.close();
			after_rate = getAfter_RateByTxInfo( Rate_Map,contract_id,begin_id);
			this.start_date	= tx_date;
			
		return after_rate;
		
	}
	
	
	/**
	 * 获得合同的交易结构条件，判断调息期限相对的值
	 * @param rate_one  一年利率浮动值
	 * @param rate_three 三年利率浮动值
	 * @param rate_five 五年利率浮动值
	 * @param rate_abovefive 五年以上利率浮动值
	 * @param contract_id 合同编号
	 * @param begin_id 起租编号
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unused")
	public String getAfter_RateByTxInfo(Map<String, String> Rate_Map, String contract_id,String begin_id) throws SQLException{
		String after_rate="0";//调息后利率
		String before_rate = "";//调息前利率
		String lease_term = "";//租赁期限（月）
		String rate_float_amt = "";//利率浮动值
		String rate_float_type = "";//利率浮动类型
		String sql = "select year_rate,lease_term,rate_float_amt,rate_float_type from begin_info where " +
				"contract_id='"+contract_id+"' and begin_id='"+begin_id+"'";
		erpDataSource=new ERPDataSource();
		rs = erpDataSource.executeQuery(sql);
		if(rs.next()){
			
			before_rate = rs.getString("year_rate");
			lease_term = rs.getString("lease_term");
			rate_float_amt = rs.getString("rate_float_amt");
			rate_float_type = rs.getString("rate_float_type");
			
		}
		this.year_rate = before_rate;
		if(Integer.parseInt(lease_term)==12){//一年期
			//参数：rate_float_type 利率浮动类型  rate_float_amt利率浮动值
			//before_rate 调息前利率 Rate_Map.get("rate_one") 相对应的利率调整值
			//Rate_Map.get("base_rate_one")  相对应的本期央行利率基础值
			after_rate = getAfter_RateByOld(rate_float_type, rate_float_amt,
					before_rate,Rate_Map.get("rate_one"),Rate_Map.get("base_rate_one"));
		}else if(Integer.parseInt(lease_term)>12&&Integer.parseInt(lease_term)<=36){//一年至三年
			after_rate = getAfter_RateByOld(rate_float_type, rate_float_amt,
					before_rate, Rate_Map.get("rate_three"),Rate_Map.get("base_rate_three"));
		}else if(Integer.parseInt(lease_term)>36&&Integer.parseInt(lease_term)<=60){//三年至五年
			after_rate = getAfter_RateByOld(rate_float_type, rate_float_amt,
					before_rate,Rate_Map.get("rate_five"), Rate_Map.get("base_rate_five"));
		}else if(Integer.parseInt(lease_term)>60){//五年以上
			after_rate = getAfter_RateByOld(rate_float_type, rate_float_amt, 
					before_rate, Rate_Map.get("rate_abovefive"),Rate_Map.get("base_rate_abovefive"));
		}
		
		
		erpDataSource.close();
		
		return after_rate;
	}
	
	/**
	 * 根据浮动类型计算调息后年利率
	 * @param rate_float_type  利率浮动类型
	 * @param rate_float_amt  利率浮动值
	 * @param before_rate    调息前利率
	 * @param adjust_rate	调整值
	 * @return
	 */
	public String getAfter_RateByOld(String rate_float_type,String rate_float_amt,String before_rate,
			String adjust_rate, String base_rate){
		String after_rate = "";
		if(rate_float_type.equals("0")){//按央行利率浮动比率
//			//利率计算公式   0.20*（1+0.3）+ 5.4
//			// 央行调整值*（1+浮动值）+旧利率
//			after_rate = Tools.formatNumberDoubleTwo(String.valueOf(Double.parseDouble(adjust_rate)*(1+Double.parseDouble(rate_float_amt))
//						+Double.parseDouble(before_rate)));
//			this.implicite_rate = "0.00000";
			//2012-02-10最新修改
			//本期银行利率*（1+浮动值）
//			System.out.println("利率计算公式="+base_rate+"*(1+"+rate_float_amt+")");
			after_rate = Tools.formatNumberDoubleSix(String.valueOf(Double.parseDouble(base_rate)*(1+Double.parseDouble(rate_float_amt))));
			this.implicite_rate = "0.00000";			
		}else if(rate_float_type.equals("1")){//按央行利率加点
			//利率计算公式:5.4+0.20
			//央行调整值+旧利率
			after_rate = Tools.formatNumberDoubleSix(String.valueOf(Double.parseDouble(before_rate)+
					Double.parseDouble(adjust_rate)));
			this.implicite_rate = "0.00000";
		}else if(rate_float_type.equals("2")){//隐含利率
			//利率计算公式    1+(5.96-5.76)/5.76*0.16 ===1+0.20/(5.96-0.20)*0.16  
			//1+央行调整值/上次利率值*浮动值--------上次利率值=本次基础值-央行调整值
			this.implicite_rate = Tools.formatNumberDoubleScale(String.valueOf(1+
					Double.parseDouble(adjust_rate)/(Double.parseDouble(base_rate)-
							Double.parseDouble(adjust_rate))*Double.parseDouble(rate_float_amt)),8);
			//System.out.println("系数======="+this.implicite_rate);
			//隐含利率调整系统
			after_rate=before_rate;//利率不变，仍为调息前利率
			//System.out.println(after_rate+"=1+"+adjust_rate+"/("+base_rate+"-"+adjust_rate+")*"+rate_float_amt);
		}else if(rate_float_type.equals("3")){//保持不变
			//利息计算为同期央行利率乘以一个固定值
			//5.4*0.7  到  5.6*0.7
			//公式为    5.4*0.7+0.2*0.7
			after_rate=Tools.formatNumberDoubleSix(String.valueOf(Double.parseDouble(before_rate)+
					Double.parseDouble(adjust_rate)));
			this.implicite_rate = "0.00000";
		}
		
		return after_rate;
		
	}
	/**
	 * 查询开始期次
	 * @param start_date
	 * @param begin_id
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unused")
	public String getStartList(String start_date,String begin_id,String adjust_style) throws SQLException{
		String start_list = "";
		String total_list = "";
		String sql = null;
//		String sql = "select min(rent_list) as rent_list from fund_rent_plan " +
//				"where contract_id ='"+begin_id+"' and plan_date>+'"+start_date+"' and " +
//						"plan_status<>'已回笼'";
		if("次年".equals(adjust_style)){
			SimpleDateFormat sdf =   new SimpleDateFormat( "yyyy-MM-dd" );
			Date date=null;
			try {
				date = sdf.parse(start_date);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			Calendar now = Calendar.getInstance();
			now.setTime(date);
	        int nextyear = now.get(Calendar.YEAR)+1;//获取次年
	       String  startDate = nextyear+"-01-01";
			 sql = "select case when min(rent_list)=( " +
				"select min(rent_list) from fund_rent_plan where begin_id='"+begin_id+"' and " +
				" plan_date>='"+startDate+"') then min(rent_list) else min(rent_list)-1 end as " +
				"rent_list from fund_rent_plan frp  where begin_id='"+begin_id+"' and "+
				" plan_date>='"+startDate+"' and plan_status<>'已回笼'";
		}else{
			 sql = "select case when min(rent_list)=( " +
			"select min(rent_list) from fund_rent_plan where begin_id='"+begin_id+"' and " +
			" plan_date>='"+start_date+"') then min(rent_list) else min(rent_list)-1 end as " +
			"rent_list from fund_rent_plan frp  where begin_id='"+begin_id+"' and "+
			" plan_date>='"+start_date+"' and plan_status<>'已回笼'";
		}
		erpDataSource=new ERPDataSource();
		rs = erpDataSource.executeQuery(sql);
		if(rs.next()){
			start_list = rs.getString("rent_list");
			
		}
		if(start_list==null&&"次年".equals(adjust_style)){
			start_list="-1";
		}
		erpDataSource.close();
		return start_list;
		
	}
	
	/**
	 * 租金拷入历史表
	 * @param contract_id
	 * @param txId
	 * @throws SQLException
	 */
	public void addRentHisBeforeInfo(String contract_id,String begin_id,String txId) throws SQLException{
		erpDataSource=new ERPDataSource();
		String sql = "delete from fund_rent_plan_his where contract_id ='"+contract_id+"' " +
				"and begin_id='"+begin_id+"' and tx_id = '"+txId+"'     insert into fund_rent_plan_his " +
						"(doc_id,measure_date,contract_id,begin_id,rent_list,plan_date,pena_plan_date," +
						"curr_rent,rent,corpus,curr_corpus,year_rate,interest,curr_interest,rent_overage,corpus_overage," +
						"interest_overage,curr_penalty,penalty,penalty_overage,plan_status,pena_status," +
						"plan_bank_name,plan_bank_no,mod_stuff,mod_status,mod_reason,creator," +
						"create_date,modificator,modify_date,tx_id,status,tax_rate,invoice_type ) select " +
						" doc_id,getdate(),contract_id,begin_id,rent_list,plan_date,pena_plan_date," +
						"curr_rent,rent,corpus,curr_corpus,year_rate,interest,curr_interest,rent_overage,corpus_overage," +
						"interest_overage,curr_penalty,penalty,penalty_overage,plan_status,pena_status," +
						"plan_bank_name,plan_bank_no,mod_stuff,mod_status,'调息',creator,create_date," +
						"modificator,modify_date,'"+txId+"','前',tax_rate,invoice_type from fund_rent_plan where " +
								"contract_id='" +contract_id+"' and begin_id='"+begin_id+"'";
		erpDataSource.executeUpdate(sql);
		erpDataSource.close();
	}
	
	public int addFundAdjustInterest(String contract_id,String begin_id,String txId,String start_list,
			String after_rate,String before_rate,String implicite_rate,String czyid) throws SQLException{
		int flag=0;
		String sql = " insert into fund_adjust_interest_contract (" +
						"contract_id,begin_id,adjust_id,adjust_flag,before_rate,after_rate,implicite_rate,rent_list_start" +
						",left_corpus,left_interest,creator,create_date,adjust_type) select " +
						"'"+contract_id+"','"+begin_id+"','"+txId+"','否','"+before_rate+"','"+after_rate+"','"+implicite_rate+"'," +
							"'"+start_list+"',(select corpus_overage from fund_rent_plan where " +
							"contract_id ='"+contract_id+"' and begin_id='"+begin_id+"' and rent_list ='"+start_list+"')," +
								"(select sum(interest) from  fund_rent_plan where " +
									"contract_id ='"+contract_id+"' and begin_id='"+begin_id+"' and rent_list>'"+start_list+"')," +
									  " '"+czyid+"',getdate(),(select icd.title+case bi.period_type " +
									  " when '0' then '后付' when '1' then '先付' end  from begin_info bi " +
									  " left join ifelc_conf_dictionary icd on bi.settle_method=icd.name	" +
									  " where bi.contract_id ='"+contract_id+"' and bi.begin_id='"+begin_id+"')";
		erpDataSource=new ERPDataSource();
		System.out.println("插入调息状态表SQL=============="+sql);
		flag += erpDataSource.executeUpdate(sql);
		erpDataSource.close();
		return flag;
	}


	
}
