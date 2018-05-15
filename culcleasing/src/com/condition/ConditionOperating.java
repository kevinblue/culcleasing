package com.condition;

import java.sql.*;
import java.util.List;

import dbconn.Conn;
/**
 * <p>租金测算交易结构初始化数据公用类。</p>
 * @author 小谢
 * <p>Jun 7, 2010</p>
 */
public class ConditionOperating {
	
	
	/**
	 * <p>自动生成资金计划proj_fund_fund_charge_plan_temp</p>
	 * <p>
	 * 	  具体作用：根据传入的proj_id去查交易结构临时表生成资金计划
	 * </p>
	 * @param proj_id
	 * @param doc_id
	 * @param creator
	 * @param equip_amt
	 * @param first_payment
	 * @param insure_money
	 * @param return_amt
	 * @param handling_charge
	 * @param caution_money
	 * @param management_fee
	 * @param consulting_fee_in
	 * @param consulting_fee
	 * @param other_income
	 * @param other_expenditure
	 * @param before_interest
	 * @param discount_rate
	 * @param rate_subsidy
	 * @param nominalprice
	 */
	public void make_proj_fund_fund_charge_plan_temp(String proj_id,String doc_id,String creator,String equip_amt,String first_payment,
			String insure_money,String return_amt,String handling_charge,String caution_money,String management_fee,String consulting_fee_in,
			String consulting_fee,String other_income,String other_expenditure,
			String before_interest,String discount_rate,String rate_subsidy,String nominalprice){
		Conn db = new Conn();
		ResultSet rs = null;
		String sql = "";
//		收付编号	payment_id	varchar(60)	TRUE	FALSE	TRUE
//		measure_id	measure_id	varchar(200)	FALSE	FALSE	FALSE
//		项目编号	proj_id	varchar(50)	FALSE	FALSE	FALSE
//		款项方式	pay_type	varchar(600)	FALSE	FALSE	FALSE
//		款项内容	fee_type	varchar(30)	FALSE	FALSE	FALSE
//		序号	fee_num	int	FALSE	FALSE	FALSE
//		计划收付日期	plan_date	datetime	FALSE	FALSE	FALSE
//		金额	plan_money	decimal(18,2)	FALSE	FALSE	FALSE
//		币种	currency	varchar(15)	FALSE	FALSE	FALSE
//		付款对象	pay_obj	varchar(30)	FALSE	FALSE	FALSE
//		付款对象帐号	pay_bank_no	varchar(30)	FALSE	FALSE	FALSE
//		结算方式	pay_way	varchar(15)	FALSE	FALSE	FALSE
//		备注	fpnote	varchar(5000)	FALSE	FALSE	FALSE
//		登记人	creator	varchar(15)	FALSE	FALSE	FALSE
//		登记时间	create_date	datetime	FALSE	FALSE	FALSE
//		更新人	modificator	varchar(15)	FALSE	FALSE	FALSE
//		更新日期	modify_date	datetime	FALSE	FALSE	FALSE
		String pay_obj = "";
		String pay_bank_name = "";
		String pay_bank_no = "";
		sql = "select top 1 cust_id,bank_name,acc_number vi_cust_account where isnull(acc_status,'是')='是' and cust_id =(select cust_id from proj_info where proj_id='"+proj_id+"') ";
		try {
			rs = db.executeQuery(sql);
			if(rs.next()){
				pay_obj = rs.getString("cust_id");
				pay_bank_name = rs.getString("bank_name");
				pay_bank_no = rs.getString("acc_number");
			}
			//拼接sql插入资金计划
			StringBuffer sqlStr = new StringBuffer();
			sqlStr.append("insert into proj_fund_fund_charge_plan_temp()");
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
//		名称	收支情况
//		1-设备金额	支
//		2-首付款	收
//		3-租赁保证金	收
//		4-租赁手续费	收
//		5-管理费	收
//		6-残值收入	收
//		7-厂商返利	收
//		8-租前息	收
//		9-利息补贴	收
//		10-贴现息	支
//		11-其他收入	收
//		12-其他支出	支
//		13-咨询费收入	收
//		14-咨询费支出	支
//		15-保费金额	支
	}
	/**
	 * <p>初始化合同交易结构临时表Contract_Condition_Temp</p>
	 * <p>
	 * 		  具体作用：根据传入的三个主键，依次查询‘合同交易结构临时表’,‘合同交易结构正式表’,‘项目交易结构正式表’,
	 *       合同交易结构临时表存在数据则不查询后2张表，临时表不存在数据则查询第二张表，第二张表存在数据，
	 *       将第二张表的数据插入到合同交易结构临时表中，第二章不存在则查询第三张，做同第二张表相同操作
	 * </p>
	 * @author 小谢
	 * @param proj_id 项目编号
	 * @param doc_id  文档编号
	 * @param contract_id 合同编号
	 * @return  model 返回类型：String 用于下不操作判断
	 */
	public String Oper_Contract_Condition_Temp(String proj_id,String doc_id,String contract_id){
		Conn db = new Conn();
		ResultSet rs;
		System.out.println("初始化交易结构---------------------------------------------------");
		String model = "";
		String sql = "select * from contract_condition_temp where contract_id = '"+contract_id+"' and measure_id = '"+doc_id+"'";
		String contract_conditionSql  =  " select * from  contract_condition  where contract_id = '"+contract_id+"'";//合同交易结构正式表
		String proj_conditionSql = " select * from proj_condition where proj_id = '"+proj_id+"' ";//项目交易结构
		
	 	try {
			rs = db.executeQuery(sql);
			rs.last(); //移到最后一行
			int rowCount = rs.getRow(); //得到当前行号，也就是记录数
			rs.beforeFirst(); //还要用到记录集，就把指针再移到初始化的位置
			if(rowCount <= 0){//临时表无数据
				System.out.println("初始化交易结构-------临时表没数据查询正式表--------------------------------------------");
		    	//合同临时表没有数据则查询合同正式表
				rs = db.executeQuery(contract_conditionSql);
				rs.last(); //移到最后一行
			    rowCount = rs.getRow(); //得到当前行号，也就是记录数
			    rs.beforeFirst();
			    if(rowCount > 0){//正式表有数据
					//拼装往‘合同交易结构临时表’中插入数据的语句，注意：临时表中存在 measure_id 正式表中不存在
					String insert_sql = this.PJ_sql(proj_id, doc_id, contract_id, 0);
					db.executeUpdate(insert_sql); 
					model = "mod";//从合同正式表插入合同临时表后，存在数据，视为修改合同临时表的操作
			    }else{//合同正式表没有数据则查询项目交易结构正式表proj_condition
			    	rs = db.executeQuery(proj_conditionSql);
					rs.last(); //移到最后一行
				    rowCount = rs.getRow(); //得到当前行号，也就是记录数
				    rs.beforeFirst();
				    //项目交易结构正式表有数据则将项目交易结构表中对应 proj_id 的数据插入到合同交易结构临时表中
				    //插入时注意：合同交易结构临时表中不存在 proj_id 字段 只有 contract_id 和 measure_id
				    if(rowCount > 0){//项目交易结构正式表proj_condition有数据
				    	String insert_sql = this.PJ_sql(proj_id, doc_id, contract_id, 1);
						db.executeUpdate(insert_sql); 
						model = "mod";//从项目正式表插入到合同临时表后，存在数据，视为修改合同临时表的操作
				    }else{
				    	//项目交易结构正式表proj_condition没有数据则视为新增操作
				    	model = "add";
				    }
			    }
			}else{
				//合同临时表中存在数据，则视为对该数据的修改操作
				model = "mod";
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		return model;
	}
	
	/**
	 * <p>拼接插入合同交易临时表的SQL语句。</p>
	 * @author 小谢
	 * @param proj_id 项目编号
	 * @param doc_id 文档编号
	 * @param contract_id 合同编号
	 * @param num 0：表示从合同正式表取数据插入 1：表示从项目正式表取数据插入
	 * @return 最终执行的SQL语句
	 */
	private String PJ_sql(String proj_id,String doc_id,String contract_id,int num){
		String	sql = this.sql(proj_id, doc_id, contract_id, num);
		return sql.toString();
	} 
	/**
	 * <p>拼装具体的插入语句,进入页面初始化合同交易结构，顺序是：合同交易临时表--正式表--项目正式。</p>
	 * @author 小谢
	 * @param proj_id 项目编号
	 * @param doc_id 文档编号
	 * @param contract_id 合同编号
	 * @param temp 0：表示从合同正式表取数据插入 1：表示从项目正式表取数据插入
	 * @return 拼装好的SQL语句
	 */
	private String sql(String proj_id,String doc_id,String contract_id,int temp){
		StringBuffer sql  = new StringBuffer();
		sql.append(" INSERT INTO contract_condition_temp ")
		   .append("(contract_id,apply_contract_number,equip_amt,lease_money ")
	       .append(",lease_term,income_number_year,income_number,year_rate ")
	       .append(",rate_float_type,rate_float_amt,period_type,settle_method ")
	       .append(",income_day,start_date,end_date,first_date ")
	       .append(",second_date,first_payment_ratio,first_payment,first_payment_in_ratio ")
	       .append(" ")
		   .append(",first_payment_in,caution_money_ratio,caution_money ,lessee_caution_ratio")
	       .append(",lessee_caution_money,vndr_caution_ratio,vndr_caution_money,sale_caution_ratio ")
	       .append(",sale_caution_money,caution_deduction_ratio,caution_deduction_money,handling_charge_ratio ")
	       .append(",handling_charge,return_ratio,return_amt,supervision_fee_ratio ")
	       .append(",supervision_fee,consulting_fee,nominalprice,insurance_method ")
	       .append(",insurance_lessor,insurance_lessee,redressalk,pena_rate")
	       .append(",total_amt,actual_fund ,rough_earn,year_earn ")
	       .append(",plan_irr,creator,create_date,modify_date ")
	       .append(",modificator,currency,net_lease_money,before_interest ")
	       .append(",rate_adjustment_modulus,measure_type,other_income,other_expenditure ")
	       
	       .append(" ,measure_id   ")
		   .append(" ,market_irr   ")//新增字段市场IRR
		   .append(" ,accountPrincipal   ")//会计核算本金 【2010-08-06】
		   .append(" ,liugprice   ")//留购价 【2010-09-21 之前的留购价改成资产于值】35
		   
		   .append(" ,rentScale  ")//【新增字段 2010-08-20】34 圆整到
		   .append(" ,delay  ")//【新增字段 2010-10-20】36 延迟期数
		   .append(" ,grace  ")//【新增字段 2010-10-20】37 宽限期数
		   .append(" ,management_fee  ")//【新增字段 2010-11-11】38 管理费 
		   .append(" ,ajdustStyle  ")//【新增字段 2010-11-23】39调息方式
		    .append(" ,amt_return  ")//【新增字段 2011-01-10】40 设备是否退还
		   .append(" )");
		if(temp == 0){//合同正式表
			sql.append(" select ")  	    	
	           .append("contract_id,apply_contract_number,equip_amt,lease_money ")
	           .append(",lease_term,income_number_year,income_number,year_rate ")
	           .append(",rate_float_type,rate_float_amt,period_type,settle_method ")
	           .append(",income_day,start_date,end_date,first_date ")
	           .append(",second_date,first_payment_ratio,first_payment,first_payment_in_ratio ")
	           .append(" ")
			   .append(",first_payment_in,caution_money_ratio,caution_money,lessee_caution_ratio ")
	           .append(",lessee_caution_money,vndr_caution_ratio,vndr_caution_money,sale_caution_ratio ")
	           .append(",sale_caution_money,caution_deduction_ratio,caution_deduction_money,handling_charge_ratio ")
	           .append(",handling_charge,return_ratio,return_amt,supervision_fee_ratio ")
	           .append(",supervision_fee,consulting_fee,nominalprice,insurance_method ")
	           .append(",insurance_lessor,insurance_lessee,redressalk,pena_rate ")
	           .append(",total_amt,actual_fund,rough_earn,year_earn ")
	           .append(",plan_irr,creator,create_date,modify_date ")
	           .append(",modificator,currency,net_lease_money,before_interest ")
	           .append(",rate_adjustment_modulus,measure_type,other_income,other_expenditure ")
	           
	           .append(" ,'"+doc_id+"'  ") 
	           .append(" ,market_irr   ")//新增字段市场IRR
	           .append(" ,accountPrincipal   ")//会计核算本金 【2010-08-06】
	           .append(" ,liugprice   ")//留购价 【2010-09-21 之前的留购价改成残值】
	           
	           .append(" ,rentScale  ")//【新增字段 2010-08-20】34 圆整到
	           .append(" ,delay  ")//【新增字段 2010-10-20】36 延迟期数
	           .append(" ,grace  ")//【新增字段 2010-10-20】37 宽限期数
		   	   .append(" ,management_fee  ")//【新增字段 2010-11-11】38 管理费 
		   	   .append(" ,ajdustStyle  ")//【新增字段 2010-11-23】39调息方式
		   	    .append(" ,amt_return  ")//【新增字段 2011-01-10】40 设备是否退还
	           .append(" from contract_condition ")
	           .append(" where contract_id = '"+contract_id+"' ");//合同交易结构正式表唯一主键contract_id 
		}
		if(temp == 1){//项目正式表
			sql.append(" select ")  	    	
			   .append("'"+contract_id+"',apply_contract_number,equip_amt,lease_money ")
	           .append(",lease_term,income_number_year,income_number,year_rate ")
	           .append(",rate_float_type,rate_float_amt,period_type,settle_method ")
	           .append(",income_day,start_date,end_date,first_date ")
	           .append(",second_date,first_payment_ratio,first_payment,first_payment_in_ratio ")
	           .append(" ")
			   .append(",first_payment_in,caution_money_ratio,caution_money,lessee_caution_ratio ")
	           .append(",lessee_caution_money,vndr_caution_ratio,vndr_caution_money,sale_caution_ratio ")
	           .append(",sale_caution_money,caution_deduction_ratio,caution_deduction_money,handling_charge_ratio ")
	           .append(",handling_charge,return_ratio,return_amt,supervision_fee_ratio ")
	           .append(",supervision_fee,consulting_fee,nominalprice,insurance_method ")
	           .append(",insurance_lessor,insurance_lessee,redressalk,pena_rate ")
	           .append(",total_amt,actual_fund,rough_earn,year_earn ")
	           .append(",plan_irr,creator,create_date,modify_date ")
	           .append(",modificator,currency,net_lease_money,before_interest ")
	           .append(",rate_adjustment_modulus,measure_type,other_income,other_expenditure ")
	           
	       	   .append(" ,'"+doc_id+"'  ")  
	       	   .append(" ,market_irr   ")//新增字段市场IRR
	       	   .append(" ,accountPrincipal   ")//会计核算本金 【2010-08-06】
	       	    .append(" ,liugprice   ")//留购价 【2010-09-21 之前的留购价改成残值】
	       	    
	       	   .append(" ,rentScale  ")//【新增字段 2010-08-20】34 圆整到
	       	   .append(" ,delay  ")//【新增字段 2010-10-20】36 延迟期数
	       	   .append(" ,grace  ")//【新增字段 2010-10-20】37 宽限期数
	       	   .append(" ,management_fee  ")//【新增字段 2010-11-11】38 管理费 
	       	   .append(" ,ajdustStyle  ")//【新增字段 2010-11-23】39调息方式
	       	    .append(" ,amt_return  ")//【新增字段 2011-01-10】40 设备是否退还
	 		   .append(" from proj_condition ")	
	 		   .append(" where proj_id = '"+proj_id+"' ");//proj_id 为项目交易结构表proj_condition的唯一主键
		}
		return sql.toString();
	}
	
	/**
	 * <p>项目交易结构的临时表。</p>
	 * @author 小谢
	 * @param proj_id 项目编号
	 * @param doc_id 文档编号
	 * @return
	 */
	public String oper_proj_condition_temp(String proj_id,String doc_id){
		Conn db = new Conn();
		ResultSet rs;
		String model = "";
		String proj_condition_tempSql = "select proj_id from proj_condition_temp where proj_id = '"+proj_id+"' and measure_id = '"+doc_id+"'";
		try {
			rs = db.executeQuery(proj_condition_tempSql);
			rs.last();//移到最后一行
			int rowCount = rs.getRow(); //得到当前行号，也就是记录数
			//临时表中无数据则查询对应正式表中的数据
			if(rowCount <= 0){//临时表没有数据就进入查询正式表
				String proj_conditionSql = " select proj_id from  proj_condition where proj_id = '"+proj_id+"'";
				rs = db.executeQuery(proj_conditionSql);
				rs.last(); 
				rowCount = rs.getRow();//判断正式表中是否有值
				rs.beforeFirst(); //还要用到记录集，就把指针再移到初始化的位置
				if(rowCount > 0){//正式项目交易结构表中有值则将正式表中的数据插入项目临时表中
					String insert_proj_conditionTempSql = this.getProj_conditionSql(proj_id, doc_id);
					db.executeUpdate(insert_proj_conditionTempSql);
					//System.out.println("sql语句为:==========>"+insert_proj_conditionTempSql.toString());
					model = "mod";
				}else{//如果交易结构正式表中也没有数据，则是新增
					model = "add";
				}
			}else{
				model = "mod";
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		return model;
	}
	/**
	 * <p>根据项目编号和文档编号拼装插入项目临时表的SQL语句。</p>
	 * @author 小谢
	 * @param proj_id 项目编号
	 * @param doc_id 文档编号
	 * @return sql语句的string形式
	 */
	private String getProj_conditionSql(String proj_id,String doc_id){
		StringBuffer sql = new StringBuffer();
		sql.append(" INSERT INTO proj_condition_temp  ")
			.append(" (proj_id ,currency ,equip_amt ,lease_money ,lease_term ")
			.append(" ,income_number_year,income_number,year_rate ")
			.append(" ,rate_float_type,period_type,income_day ")
			.append(" ,start_date,first_payment,caution_money ")
			.append(" ,handling_charge,return_amt,nominalprice ")
			.append(" ,pena_rate,net_lease_money,plan_irr ")
			.append(" ,measure_type,creator,create_date ")
			.append(" ,modificator,modify_date,before_interest,rate_adjustment_modulus ")
			.append(" ,other_income,other_expenditure,rate_float_amt ")
			.append(" ,measure_id ")
			.append(" ,market_irr  ")//新增字段市场IRR date:2010-06-28
			.append(" ,lease_money_proportion  ")//【新增字段 2010-07-27】 净融资额比例
			.append(" ,accountPrincipal   ")//会计核算本金 【新增字段 2010-08-06】
			.append(" ,rentScale  ")//【新增字段 2010-08-20】34 圆整到
			.append(" ,liugprice   ")//留购价 【2010-09-21 之前的留购价改成资产于值】35
		   .append(" ,delay  ")//【新增字段 2010-10-20】36 延迟期数
		   .append(" ,grace  ")//【新增字段 2010-10-20】37 宽限期数
		   .append(" ,management_fee  ")//【新增字段 2010-11-11】38 管理费 
		   .append(" ,ajdustStyle  ")//【新增字段 2010-11-23】39调息方式
		   .append(" ,amt_return  ")//【新增字段 2011-01-10】40 设备是否退还
		   .append(" ,into_batch  ")//【新增字段 2011-05-01】41 是否批量调息
		   .append(" ,discount_rate  ")//【新增字段 2011-05-01】42 贴现息
		   .append(" ,insure_type  ")//【新增字段 2011-05-01】43 投保方式
		   .append(" ,insure_money  ")//【新增字段 2011-05-01】44 保费金额
		   .append(" ,consulting_fee_in  ")//【新增字段 2011-05-01】45 咨询费收入
		   .append(" ,free_defa_inter_day  ")//【新增字段 2011-05-01】46 逾期宽限日
		   .append(" ,rate_subsidy  ")//【新增字段 2011-05-01】47 利息补贴
			.append("  )")
			.append(" select  ")
			.append(" proj_id ,currency ,equip_amt ,lease_money ,lease_term ,income_number_year,income_number,year_rate")
			.append(" ,rate_float_type,period_type,income_day,start_date,first_payment,caution_money ")
			.append(" ,handling_charge,return_amt,nominalprice,pena_rate,net_lease_money,plan_irr,measure_type,creator,create_date ")
			.append(" ,modificator,modify_date,before_interest,rate_adjustment_modulus ")
			.append(" ,other_income,other_expenditure,rate_float_amt, ")
			.append("'"+doc_id+"'")
			.append(" ,market_irr   ")//新增字段市场IRR
			.append(" ,lease_money_proportion   ")//【新增字段 2010-07-27】 净融资额比例
			.append(" ,accountPrincipal   ")//会计核算本金 【新增字段 2010-08-06】
			.append(" ,rentScale  ")//【新增字段 2010-08-20】34 圆整到
			.append(" ,liugprice   ")//留购价 【2010-09-21 之前的留购价改成资产于值】35
		   .append(" ,delay  ")//【新增字段 2010-10-20】36 延迟期数
		   .append(" ,grace  ")//【新增字段 2010-10-20】37 宽限期数
		   .append(" ,management_fee  ")//【新增字段 2010-11-11】38 管理费 
		   .append(" ,ajdustStyle  ")//【新增字段 2010-11-23】39调息方式
		   .append(" ,amt_return  ")//【新增字段 2011-01-10】40 设备是否退还
		   //--环球新增字段
		   .append(" ,into_batch  ")//【新增字段 2011-05-01】41 是否批量调息
		   .append(" ,discount_rate  ")//【新增字段 2011-05-01】42 贴现息
		   .append(" ,insure_type  ")//【新增字段 2011-05-01】43 投保方式
		   .append(" ,insure_money  ")//【新增字段 2011-05-01】44 保费金额
		   .append(" ,consulting_fee_in  ")//【新增字段 2011-05-01】45 咨询费支出
		   .append(" ,free_defa_inter_day  ")//【新增字段 2011-05-01】46 逾期宽限日
		   .append(" ,rate_subsidy  ")//【新增字段 2011-05-01】47 利息补贴
			.append(" from  proj_condition ")
			.append("  where proj_id = '"+proj_id+"' ");
		return sql.toString();
	}
	
	/**
	 * <p>跟新表现金流表的操作。</p>
	 * @author 小谢
	 * @param contract_id 合同编号
	 * @param doc_id  文档编号
	 * @param plan_date_list 日期list
	 * @param follow_in_list 现金流入量list
	 * @param follow_in_detail_list 现金流入量清单list
	 * @param follow_out_list  现金流出量list
	 * @param follow_out_detail_list 现金流出量清单list
	 * @param net_follow_list 净流量list
	 * @param creator 创建人
	 * @param create_date 创建日期
	 * @param modify_date 修改日期
	 * @param modificator 修改人
	 * @param tableName 需更新的表名
	 * @return 更新结果 0:更新失败 >0更新成功 返回类型:int 
	 */
	public int update_fund_contract_plan(String contract_id,String doc_id,List<String> plan_date_list,
			List<String> follow_in_list,List<String> follow_in_detail_list,List<String> follow_out_list,List<String> follow_out_detail_list,List<String> net_follow_list,String creator,
			String create_date,String modify_date,String modificator,String tableName){
		//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//格式化时间
		//String nowTime = sdf.format(new Date());//当前格式化之后的时间
		//初始化6个数组：日期 plan_date_list,流入量 follow_in_list,流入量清单 follow_in_detail_list
		//流出量 follow_out_list,流出量清单 follow_out_detail_list,净流量 net_follow_list
		System.out.println("join类方法");
		int count = 0;
		Conn db = new Conn();
		StringBuffer sql = new StringBuffer();
		for(int i = 0;i < plan_date_list.size();i++){
			sql.append(" INSERT INTO  ")
			.append(tableName)
			.append("  (contract_id ,doc_id ,plan_date ,follow_in ")
			.append(" ,follow_in_detail ,follow_out ,follow_out_detail ")
			.append(" ,net_follow ,creator ,create_date ,modificator ,modify_date) ")
			.append(" VALUES ")
			.append(" ('"+contract_id+"','"+doc_id+"' ")
			.append(" ,'"+plan_date_list.get(i)+"' ")//日期 formatNumberDoubleTwo
			.append(" ,'"+follow_in_list.get(i)+"' ")//流入
			.append(" ,'"+follow_in_detail_list.get(i)+"' ")//流入清单
			.append(" ,'"+follow_out_list.get(i)+"' ")//流出
			.append(" ,'"+follow_out_detail_list.get(i)+"' ")//流出清单
			.append(" ,'"+net_follow_list.get(i)+"' ")//净流量
			.append(" ,'"+creator+"' ")//创建人
			.append(" ,'"+create_date+"' ")//创建日期
			.append(" ,'"+modify_date+"' ")//修改日期 
			.append(" ,'"+modificator+"'); ");//修改人
			// System.out.println("更新现金流SQL语句为==> : "+sql.toString());
		}
		
		try {
			count = db.executeUpdate(sql.toString());
			//System.out.println("更新现金流SQL语句为==> : "+sql.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		return count;
	}
	
	/**
	 * <p>跟新表fund_proj_plan操作。</p>
	 * @author 小谢
	 * @param proj_id 项目编号
	 * @param doc_id  文档编号
	 * @param plan_date_list 日期list
	 * @param follow_in_list 现金流入量list
	 * @param follow_in_detail_list 现金流入量清单list
	 * @param follow_out_list  现金流出量list
	 * @param follow_out_detail_list 现金流出量清单list
	 * @param net_follow_list 净流量list
	 * @param creator 创建人
	 * @param create_date 创建日期
	 * @param modify_date 修改日期
	 * @param modificator 修改人
	 * @param tableName 需更新的表名
	 * @return 更新结果 0:更新失败 >0更新成功 返回类型:int 
	 */
	public int update_fund_proj_plan(String proj_id,String doc_id,List<String> plan_date_list,
			List<String> follow_in_list,List<String> follow_in_detail_list,List<String> follow_out_list,List<String> follow_out_detail_list,List<String> net_follow_list,String creator,
			String create_date,String modify_date,String modificator,String tableName){
		int count = 0;
		Conn db = new Conn();
		StringBuffer sql = new StringBuffer();
		for(int i = 0;i < plan_date_list.size();i++){
			sql.append(" INSERT INTO  ")
			.append(tableName)
			.append("  (proj_id ,doc_id ,plan_date ,follow_in ")
			.append(" ,follow_in_detail ,follow_out ,follow_out_detail ")
			.append(" ,net_follow ,creator ,create_date ,modificator ,modify_date) ")
			.append(" VALUES ")
			.append(" ('"+proj_id+"','"+doc_id+"' ")
			.append(" ,'"+plan_date_list.get(i)+"' ")//日期 formatNumberDoubleTwo
			.append(" ,'"+follow_in_list.get(i)+"' ")//流入
			.append(" ,'"+follow_in_detail_list.get(i)+"' ")//流入清单
			.append(" ,'"+follow_out_list.get(i)+"' ")//流出
			.append(" ,'"+follow_out_detail_list.get(i)+"' ")//流出清单
			.append(" ,'"+net_follow_list.get(i)+"' ")//净流量
			.append(" ,'"+creator+"' ")//创建人
			.append(" ,'"+create_date+"' ")//创建日期
			.append(" ,'"+modify_date+"' ")//修改日期 
			.append(" ,'"+modificator+"'); ");//修改人
			//System.out.println("<======更新项目现金流SQL语句为==> : "+sql.toString());
		}
		
		try {
			count = db.executeUpdate(sql.toString());
			//System.out.println("更新项目现金流SQL语句为==> : "+sql.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		return count;
	}
	/**
	 * <p>初始化合同租金偿还计划方法。</p>
	 * @author 小谢
	 * @param contract_id
	 * @param doc_id
	 * @param proj_id
	 * @return
	 */
	public int init_fund_rent_plan_temp(String contract_id,String doc_id,String proj_id){
		int flag = 0;
		Conn db = new Conn();
		ResultSet rs = null;
//		//防止重复刷新页面出现数据重复
//		String del_sql = " delete fund_rent_plan_temp where  contract_id='"+contract_id+"' and measure_id='"+doc_id+"'  ";
//		try {
//			db.executeUpdate(del_sql);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		
		//步骤一查询：合同租金测算临时表fund_rent_plan_temp 主键是：contract_id，measure_id
		String sqlstr = "select * from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"' ";
		//步骤二查询：合同租金测算正式表fund_rent_plan 主键是：contract_id
		String fund_rent_planSql = " select * from fund_rent_plan where  contract_id='"+contract_id+"' ";
		//步骤三查询：合同租金测算before表fund_rent_plan_before 主键是：contract_id，measure_id
		String before_planSql = " select * from fund_rent_plan_before where contract_id='"+contract_id+"' ";//and measure_id='"+doc_id+"' ";
		//步骤四查询：//项目租金计划表fund_rent_plan_proj 主键是：proj_id 注意从项目租金测算插入合同租金测算 contract_id,measure_id 这2个主键需要自己拼装
		String fund_rent_plan_projSql = " select * from fund_rent_plan_proj where proj_id = '"+proj_id+"' ";
		try {
			rs = db.executeQuery(sqlstr);
			//【第一步查询】
			rs.last(); //移到最后一行
			int rowCount = rs.getRow(); //得到当前行号，也就是记录数
			rs.beforeFirst(); //还要用到记录集，就把指针再移到初始化的位置
			if(rowCount <= 0){//合同租金测算临时表无数据
				//查询合同租金测算正式表
				rs = db.executeQuery(fund_rent_planSql);//【第二步查询】
				rs.last(); //移到最后一行
				rowCount = rs.getRow(); //得到当前行号，也就是记录数
				rs.beforeFirst(); //还要用到记录集，就把指针再移到初始化的位置
				StringBuffer insert_sql	= new StringBuffer();
				//拼装插入语句的公用部分
				insert_sql.append(" insert into fund_rent_plan_temp ")
				.append("(contract_id,measure_id,rent_list,plan_status,plan_date ")
				.append(",eptd_rent,rent,corpus,year_rate,interest,rent_overage ")
				.append(",corpus_overage,interest_overage,penalty_overage,penalty ")
				.append(",rent_type,creator,create_date,modificator,modify_date")
				.append(",corpus_market,interest_market,corpus_overage_market)")//【新增三个字段 2010-07-27】
				.append("  select ");
				if(rowCount > 0){//合同租金测算正式表存在数据则将这些数据插入合同租金测算临时表
					insert_sql.append("  contract_id, ");//contract_id在项目租金测算表中不存在
					if(doc_id.equals("") || doc_id == null){
						insert_sql.append(" '' "); //		
					}else{
						insert_sql.append(" '"+doc_id+"' "); //measure_id		
					}
					insert_sql.append("  ,rent_list,plan_status,plan_date ")
					.append(",eptd_rent,rent,corpus,year_rate,interest,rent_overage ")
					.append(",corpus_overage,interest_overage,penalty_overage,penalty ")
					.append(",rent_type,creator,create_date,modificator,modify_date ")
					.append(",corpus_market,interest_market,corpus_overage_market")//【新增三个字段 2010-07-27】
					.append(" from fund_rent_plan ")
					.append(" where contract_id = '"+contract_id+"' ");
					flag = db.executeUpdate(insert_sql.toString()); //将合同租金测算正式表的数据插入到合同租金测算临时表后再查询合同租金测算临时表
				}else{//合同租金测算正式表不存在数据，则查询第三步before表
					rs = db.executeQuery(before_planSql);//【第三步查询】
					rs.last(); //移到最后一行
					rowCount = rs.getRow(); //得到当前行号，也就是记录数
					rs.beforeFirst(); //还要用到记录集，就把指针再移到初始化的位置
					if(rowCount > 0){//before表存在数据，则将这些书籍插入到合同租金测算临时表中
						insert_sql.append("  contract_id, ");//contract_id在项目租金测算表中不存在
						if(doc_id.equals("") || doc_id == null){
							insert_sql.append(" '' "); //		
						}else{
							insert_sql.append(" '"+doc_id+"' "); //measure_id		
						}
						insert_sql.append(",rent_list,plan_status,plan_date ")
						.append(",eptd_rent,rent,corpus,year_rate,interest,rent_overage ")
						.append(",corpus_overage,interest_overage,penalty_overage,penalty ")
						.append(",rent_type,creator,create_date,modificator,modify_date ")	
						.append(",corpus_market,interest_market,corpus_overage_market")//【新增三个字段 2010-07-27】
						.append(" from fund_rent_plan_before ")	
						.append(" where contract_id = '"+contract_id+"' ");
						//.append(" and measure_id='"+doc_id+"' ");	
						flag = db.executeUpdate(insert_sql.toString());
					}else{//before表中不存在数据，则查询第四步项目租金表
						rs = db.executeQuery(fund_rent_plan_projSql);//【第四步查询】
						rs.last(); //移到最后一行
						rowCount = rs.getRow(); //得到当前行号，也就是记录数
						rs.beforeFirst();
						if(rowCount > 0){//项目租金测算表存在数据，则将该数据插入到合同租金测算临时表
							insert_sql.append(" '"+contract_id+"', ")//contract_id在项目租金测算表中不存在
							.append(" '"+doc_id+"' ") //measure_id在项目租金测算表中不存在			
							.append(" ,rent_list,plan_status,plan_date ")
							.append(",eptd_rent,rent,corpus,year_rate,interest,rent_overage ")
							.append(",corpus_overage,interest_overage,penalty_overage,penalty ")
							.append(",rent_type,creator,create_date,modificator,modify_date ")
							.append(",corpus_market,interest_market,corpus_overage_market")//【新增三个字段 2010-07-27】			
							.append(" from fund_rent_plan_proj ")
							.append(" where proj_id = '"+proj_id+"' "); 
							flag = db.executeUpdate(insert_sql.toString());			
						}//如果项目租金表也不存在数据，目前未做任何操作
					}
				}
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		db.close();
		return flag;
	}

	/**
	 * <p>项目租金偿还计划初始化数据。</p>
	 * @author 小谢
	 * @param proj_id
	 * @param doc_id
	 * @return
	 */
	public int init_fund_rent_plan_proj_temp(String proj_id,String doc_id){
		int flag = 0;
		Conn db = new Conn();
		ResultSet rs = null;
		//String del_sql = "delete from fund_rent_plan_proj_temp where   proj_id='"+proj_id+"' and measure_id='"+doc_id+"' ";
		String sqlstr = "select * from fund_rent_plan_proj_temp where   proj_id='"+proj_id+"' and measure_id='"+doc_id+"' order by rent_list";
		try {
			//先删除操作
		//	db.executeUpdate(del_sql);
			rs = db.executeQuery(sqlstr);
			rs.last(); 
			int rowCount = rs.getRow();//判断临时表中是否有值
			rs.beforeFirst(); //还要用到记录集，就把指针再移到初始化的位置
			if(rowCount <= 0){//临时表中无值则查询正式表，正式表存在值则将正式表中的数据插入到对应的租金临时表中
				String query_sql =  "select * from fund_rent_plan_proj   where  proj_id = '"+proj_id+"' ";
				rs = db.executeQuery(query_sql);
				rs.last(); 
				rowCount = rs.getRow();// 
				rs.beforeFirst(); // 
				if(rowCount > 0){
					StringBuffer insert_sql = new StringBuffer();
					insert_sql.append(" INSERT INTO fund_rent_plan_proj_temp( ")
					.append(" proj_id,rent_list,plan_status,plan_date,eptd_rent, ")
					.append(" rent,corpus,year_rate,interest,rent_overage,corpus_overage, ")
					.append(" interest_overage,penalty_overage,penalty,rent_type ")
					.append(" ,creator,create_date,modificator,modify_date ")
					.append(" ,measure_id ")//该字段正式表中没有
					.append(" ,corpus_market ")//市场本金 【新增字段 2010-07-27】
					.append(" ,interest_market ")//市场利息 【新增字段 2010-07-27】
					.append(" ,corpus_overage_market) ")//市场本金余额【新增字段 2010-07-27】
					.append(" select ")
					.append(" proj_id,rent_list,plan_status,plan_date,eptd_rent ")
					.append(" ,rent,corpus,year_rate,interest,rent_overage,corpus_overage ")
					.append(" ,interest_overage,penalty_overage,penalty,rent_type ")
					.append(" ,creator,create_date,modificator,modify_date ")
					.append(" ,'"+doc_id+"'")
					.append(" ,corpus_market,interest_market,corpus_overage_market") //【新增字段 2010-07-27】
					.append(" from fund_rent_plan_proj ")
					.append("  where  proj_id = '"+proj_id+"'  ");
					flag = db.executeUpdate(insert_sql.toString());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
	/**
	 * <p>初始化财务现金流表。</p>
	 * @author 小谢
	 * @param doc_id
	 * @param contract_id
	 */
	public int init_fund_contract_plan_temp(String doc_id,String contract_id){
		int flag = 0;
		Conn db = new Conn();
		String del_1 = " delete from fund_contract_plan_temp where contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"'";
		//String del_2 = " delete from fund_contract_plan_mark_temp where contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"'";
		//拼装初始化合同财务现金流表的sql
		StringBuffer sql1 = new StringBuffer();
		sql1.append(" INSERT INTO fund_contract_plan_temp ( ") 
		   .append("             contract_id ,doc_id ,plan_date ") 
		   .append("            ,follow_in ,follow_in_detail ") 
		   .append("            ,follow_out ,follow_out_detail ") 
		   .append("            ,net_follow ,creator ") 
		   .append("            ,create_date  ,modificator ") 
		   .append("            ,modify_date ,note ") 
		   .append("            ,adjust_id ") 
		   .append("            )   ")
		   .append(" select contract_id ,'"+doc_id+"' ,plan_date ")
		   .append(" ,follow_in ,follow_in_detail ")
		   .append(" ,follow_out ,follow_out_detail  ")
		   .append(" ,net_follow ,creator,create_date  ,modificator  ")
		   .append(" ,modify_date ,note,adjust_id  ")
		   .append(" from fund_contract_plan where contract_id = '"+contract_id+"';");
//		//拼装初始化合同市场现金流表的sql
//		StringBuffer sql2 = new StringBuffer();
//		sql2.append(" INSERT INTO fund_contract_plan_mark_temp( ")
//			.append(" 			  contract_id,doc_id,plan_date ")
//			.append("            ,follow_in,follow_in_detail ")
//			.append("            ,follow_out,follow_out_detail ")
//			.append("            ,net_follow,creator ")
//			.append("            ,create_date,modificator ")
//			.append("            ,modify_date,note,adjust_id ")
//			.append("            ,proj_id) ")
//			.append(" select contract_id ,'"+doc_id+"' ,plan_date ")
//		    .append(" ,follow_in ,follow_in_detail ")
//		    .append(" ,follow_out ,follow_out_detail  ")
//		    .append(" ,net_follow ,creator,create_date  ,modificator  ")
//		    .append(" ,modify_date ,note,adjust_id,''  ")
//		    .append(" from fund_contract_plan  where contract_id = '"+contract_id+"';");
		 try {
			flag =   db.executeUpdate(del_1);
			System.out.println("起租现金流的初始化前删除1-->"+del_1);
			System.out.println("起租现金流的初始化1-->"+sql1);
//			flag =   db.executeUpdate(del_2);
//			System.out.println("起租现金流的初始化前删除2-->"+del_2);
//			System.out.println("起租现金流的初始化2-->"+sql2);
//			flag =    db.executeUpdate(sql2.toString());
			flag =    db.executeUpdate(sql1.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		db.close();
		return flag ;
	}
	/**
	 * <p>初始化市场现金流表。</p>
	 * @author 小谢
	 * @param doc_id
	 * @param contract_id
	 */
	public int init_fund_contract_plan_mark_temp(String doc_id,String contract_id){
		int flag = 0;
		Conn db = new Conn();
		String del_2 = " delete from fund_contract_plan_mark_temp where contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"'";
		//拼装初始化合同市场现金流表的sql
		StringBuffer sql2 = new StringBuffer();
		sql2.append(" INSERT INTO fund_contract_plan_mark_temp( ")
		.append(" 			  contract_id,doc_id,plan_date ")
		.append("            ,follow_in,follow_in_detail ")
		.append("            ,follow_out,follow_out_detail ")
		.append("            ,net_follow,creator ")
		.append("            ,create_date,modificator ")
		.append("            ,modify_date,note,adjust_id ")
		.append("            ,proj_id) ")
		.append(" select contract_id ,'"+doc_id+"' ,plan_date ")
		.append(" ,follow_in ,follow_in_detail ")
		.append(" ,follow_out ,follow_out_detail  ")
		.append(" ,net_follow ,creator,create_date  ,modificator  ")
		.append(" ,modify_date ,note,adjust_id,''  ")
		.append(" from fund_contract_plan  where contract_id = '"+contract_id+"';");
		try {
			flag =   db.executeUpdate(del_2);
			System.out.println("起租现金流的初始化前删除2-->"+del_2);
			System.out.println("起租现金流的初始化2-->"+sql2);
			flag =    db.executeUpdate(sql2.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		db.close();
		return flag ;
	}
}
