package com.condition;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Hashtable;
import com.rent.calc.bg.RentCalc;

import dbconn.Conn;

/**
 * <p>调息现金流实现类。</p>
 * @author 小谢
 * <p>Jun 10, 2010</p>
 */
public class 备份 {
		
		/**
		 * <p>根据传入的合同编号list循环查询合同交易结构查询需要进行现金流的字段。</p>
		 * @author 小谢
		 * @param contractId_list 装有contract_id的list
		 * @param adjust_id 央行基准利率表编号
		 * @return 现金流插入成功与否
		 */
		@SuppressWarnings("unchecked")
		public int addCashFlow(List<String> contractId_list,String adjust_id){
			int flag = 0;
			StringBuffer query_sql = new StringBuffer();
			StringBuffer query_rent_sql = new StringBuffer();
			//循环
			for(int i = 0;i < contractId_list.size();i++){
				query_sql = new StringBuffer();
				//第一步：根据合同编号查询对应的交易结构信息
				query_sql.append(" select * from contract_condition  ")
				         .append(" where contract_id =  ")
				         .append(" '"+contractId_list.get(i) +"' ");
				//第二步：根据合同编号查询租金列表plan_date,rent 
				query_rent_sql = new StringBuffer();
				query_rent_sql.append(" select * from fund_rent_plan ")
							  .append(" where contract_id = ")
							  .append(" '"+contractId_list.get(i) +"' ");
				System.out.println("调息现金流join1==>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ : ");
				System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
				
				//查询 交易结构数据 进行处理     【一步操作】
				List<String> contract_condition_list = this.execute_contract_condition_sql(query_sql.toString());
				System.out.println("调息现金流join2==>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ : "+query_rent_sql.toString());
				System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
				
				//查询 租金偿还计划 进行处理     【两步操作】
				Hashtable  data_table = this.execute_fund_rent_plan(query_rent_sql.toString());
				System.out.println("调息现金流join3==>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ : ");
				System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
				
				//执行现金流插入操作             【三步操作】
				String contract_id = contractId_list.get(i);
				System.out.println("调息现金流join4==>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ contract_id: "+contract_id);
				//flag = this.getCashFlowList(contract_condition_list, data_table, contract_id, adjust_id);
				//【2010-08-05 修改】
				flag = this.exec_cashFlow(contract_condition_list, data_table, contract_id, adjust_id);
				System.out.println("调息现金流join5==>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ flag: "+flag);
				System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
				
				//拼装计算财务IRR和市场IRR的查询语句 【四步操作】
				String query_cw_xjl = " select * from fund_contract_plan  where  contract_id = '"+contract_id+"' ";
				String query_market_xjl = " select * from fund_contract_plan_mark  where contract_id = '"+contract_id+"'";
				flag = this.update_contract_condition(contractId_list, contract_condition_list, query_cw_xjl, query_market_xjl);
				System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
				
				//IRR更新完后更新财务和市场的现金流量表 【五步操作】
				//根据合同编号查询现金流量表最大一期，流入量 字段 加上 留购价 以及流入量清单 判断留购价大于0 
				//同时 净流量 + 留购价  注意：同样普通的租金测算的现金流也需要更新
				String nominalprice = contract_condition_list.get(18);//先得到留购价
				if(!nominalprice.equals("") ){
					int num_t = Integer.parseInt(nominalprice);
					if(num_t > 0){//留购价大于0才进行此操作
						//查询财务现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值
						String  query_count_cw = " select * from fund_contract_plan where  contract_id = '"+contract_id+"'";
						query_count_cw = query_count_cw + " and plan_date = ( select max(plan_date) from fund_contract_plan where contract_id = '"+contract_id+"' ) ";
						query_count_cw = query_count_cw + " and id = ( select max(id) from fund_contract_plan where contract_id = '"+contract_id+"' ) ";
						System.out.println("查询财务现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值 ==> "+query_count_cw);
						System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
						
						//查询市场现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值
						String  query_count_market = " select * from fund_contract_plan_mark  where  contract_id = '"+contract_id+"'";
						query_count_market = query_count_market + " and plan_date = ( select max(plan_date) from fund_contract_plan where contract_id = '"+contract_id+"' ) ";
						query_count_market = query_count_market + " and id = ( select max(id) from fund_contract_plan where contract_id = '"+contract_id+"' ) ";
						System.out.println("查询市场现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值 ==> "+query_count_cw);
						System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
						flag = this.update_xjl_cw(query_count_cw, nominalprice,"fund_contract_plan");//财务
						flag = this.update_xjl_market(query_count_market, nominalprice,"fund_contract_plan_mark");//市场
					}
				}
				
			}
			System.out.println("最终调息现金流的返回值为flag==> : "+flag);
			return flag;
		}
		/**
		 * <p>根据传入的留购价更新现金流的流入量、流入量清单、净流量三个字段的值。</p>
		 * @author 小谢
		 * @param query_count_cw 查询财务现金流三个字段的SQL
		 * @param nominalprice 留购价
		 * @param tableName 传入的表名，用于将方法变成通用利用留购价的更改这三个参数的方法 因为 项目合同起租等模块都要用到
		 * @return
		 */
		public int update_xjl_cw(String  query_count_cw,String nominalprice,String tableName){
			int flag = 0;
			Conn db = new Conn();
			ResultSet rs;
			String  follow_in = "";//流入量
			String  follow_in_detail = "";//流入量清单
			String  net_follow = "";//净流量
			try {
				rs = db.executeQuery(query_count_cw);
				while(rs.next()){
					follow_in = getDBStr(rs.getString("follow_in"));
					follow_in_detail = getDBStr(rs.getString("follow_in_detail"));
					net_follow = getDBStr(rs.getString("net_follow"));
				}
				
				//拼装新的流入量清单以及计算新的流入，净流量的值
				Double now_follow_in = Double.valueOf(follow_in) + Double.valueOf(nominalprice);
				String now_follow_in_detail = follow_in_detail + " 留购价:"+nominalprice;
				Double now_net_follow = Double.valueOf(net_follow) + Double.valueOf(nominalprice);
				String update_fund_contract_plan = " update  "+tableName+"  set follow_in= '"+formatNumberDoubleTwo(now_follow_in)+"' ";
				update_fund_contract_plan = update_fund_contract_plan + "  ,follow_in_detail = '"+now_follow_in_detail+"' ";
				update_fund_contract_plan = update_fund_contract_plan + "  ,net_follow = '"+formatNumberDoubleTwo(now_net_follow)+"' ";
				flag = db.executeUpdate(update_fund_contract_plan);
				System.out.println("更新财务现金流加入留购价后三个字段的SQL == 》 "+update_fund_contract_plan);
				//formatNumberDoubleTwo(
				String new_follow_in_detail = "";
				String new_net_follow = "";
			} catch (Exception e) {
				e.printStackTrace();
			}
			return flag;
		}
		/**
		 * <p>根据传入的留购价更新市场现金流的流入量、流入量清单、净流量三个字段的值。</p>
		 * @author 小谢
		 * @param query_count_market 查询市场现金流字段的SQL
		 * @param nominalprice 留购价
		 * @param tableName 传入的表名，用于将方法变成通用利用留购价的更改这三个参数的方法 因为 项目合同起租等模块都要用到
		 * @return
		 */
		public int update_xjl_market(String  query_count_market,String nominalprice,String tableName){
			int flag = 0;
			Conn db = new Conn();
			ResultSet rs;
			String  follow_in = "";//流入量
			String  follow_in_detail = "";//流入量清单
			String  net_follow = "";//净流量
			try {
				rs = db.executeQuery(query_count_market);
				while(rs.next()){
					follow_in = getDBStr(rs.getString("follow_in"));
					follow_in_detail = getDBStr(rs.getString("follow_in_detail"));
					net_follow = getDBStr(rs.getString("net_follow"));
				}
				
				//拼装新的流入量清单以及计算新的流入，净流量的值
				Double now_follow_in = Double.valueOf(follow_in) + Double.valueOf(nominalprice);
				String now_follow_in_detail = follow_in_detail + " 留购价:"+nominalprice;
				Double now_net_follow = Double.valueOf(net_follow) + Double.valueOf(nominalprice);
				String fund_contract_plan_mark = " update  "+tableName+"  set follow_in= '"+formatNumberDoubleTwo(now_follow_in)+"' ";
				fund_contract_plan_mark = fund_contract_plan_mark + "  ,follow_in_detail = '"+now_follow_in_detail+"' ";
				fund_contract_plan_mark = fund_contract_plan_mark + "  ,net_follow = '"+formatNumberDoubleTwo(now_net_follow)+"' ";
				flag = db.executeUpdate(fund_contract_plan_mark);
				System.out.println("更新市场现金流加入留购价后三个字段的SQL == 》 "+fund_contract_plan_mark);
				//formatNumberDoubleTwo(
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return flag;
		}
		/**
		 * <p>现金流操作完成后查询更新后的现金流列表中的净流量列表进行财务和市场IRR的重新计算，然后更新合同交易结构正式表。</p>
		 * @author 小谢
		 * @param contractId_list 合同编号集合  
		 * @param contract_condition_list 交易结构  
		 * @param query_cw_xjl 查询财务现金流净流量的sql
		 * @param query_market_xjl 查询市场现金流净流量的sql
		 * @return
		 */
		private int update_contract_condition(List<String> contractId_list,List<String> contract_condition_list,String query_cw_xjl,String query_market_xjl){
			int flag = 0;
			Conn db = new Conn();
			ResultSet rs = null;
			//第二个和第三个参数值相同
			String income_number_year  = contract_condition_list.get(16);//付租方式 16  付租方式（月付|季付|半年付|年付","1|3|6|12）
			//第四个参数
			String income_number  = contract_condition_list.get(17);//年环阻次数 17 
			
			//第一个财务IRR的参数 净流量列表
			List<String> l_inflow_pour = new ArrayList<String>();
			String cw_net_follow = "";//净流量
			try{	
				rs = db.executeQuery(query_cw_xjl);
				System.out.println("调息现金流后查询财务IRR需要的净流量SQL==》 "+query_cw_xjl);
				System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
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
				rs = db.executeQuery(query_cw_xjl);
				System.out.println("调息现金流后查询市场IRR需要的净流量SQL==》 "+query_cw_xjl);
				System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
				while(rs.next()){
					market_net_follow = getDBStr(rs.getString("net_follow"));
					l_inflow_pour_market.add(market_net_follow);
				}
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
 			db.close();
 			//调用计算IRR的方法
 			String plan_irr = com.rent.calc.tx.bg.IrrCalc.getIRR(l_inflow_pour,income_number_year,income_number_year,income_number);
 			String market_irr = com.rent.calc.tx.bg.IrrCalc.getIRR(l_inflow_pour_market,income_number_year,income_number_year,income_number);
 			flag = this.update_Irr(contractId_list, plan_irr, market_irr);
			return flag;
		}
		
		/**
		 * <p>根据合同编号list和传入的IRR进行合同交易结构正式表的更新操作。</p>
		 * @author 小谢
		 * @param contractId_list 合同编号集合
		 * @param plan_irr 财务IRR
		 * @param market_irr 市场IRR
		 * @return
		 */
		private int update_Irr(List<String> contractId_list,String plan_irr,String market_irr){
			int flag = 0;
			Conn db = new Conn();
			ResultSet rs = null;
			//更新交易结构表的2个IRR
			String update_sql = "";
			for(int i = 0;i < contractId_list.size();i++){
				update_sql = " update contract_condition set plan_irr="+plan_irr+",market_irr = "+market_irr+"  where contract_id='"+contractId_list.get(i)+"' '  ";
				try {
					flag = db.executeUpdate(update_sql);
					System.out.println("调息现金流操作完成后进行的修改IRR SQL==> "+update_sql);
					System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			db.close();
			return flag;
		}
		/**
		 * <p>根据交易结构和偿还计划数据拼装最终需要更新的现金流数据，分为财务现金流和市场现金流。</p>
		 * @author 小谢
		 * @param contract_condition_list 交易结构
		 * @param data_table list_date:封装有日期的list，list_rent：封装有每期租金的list
		 * @param contract_id 合同编号
		 * @param adjust_id 央行基准利率表编号
		 * @date 2010-08-05添加
		 * @return 现金流更新成功与否
		 */
		@SuppressWarnings("unchecked")
		private int exec_cashFlow(List<String> contract_condition_list,Hashtable  data_table,String contract_id,String adjust_id){
			int flag = 0;
			//取交易结构参数
			String lease_money = contract_condition_list.get(0);//租赁本金 0
			String consulting_fee = contract_condition_list.get(1);//咨询费 1
			String handling_charge = contract_condition_list.get(2);//手续费 2
			String period_type = contract_condition_list.get(3);//1期初,0期末支付 3
			String creator = contract_condition_list.get(4);//创建人 4
			String create_date = contract_condition_list.get(5);//创建时间 5
			String modificator = contract_condition_list.get(6);//修改人 6
			String modify_date = contract_condition_list.get(7);//修改时间 7
			String start_date = contract_condition_list.get(8);//起租日 8
			//【2010-08-05修改 增加字段】
			String equip_amt  = contract_condition_list.get(9);//设备款 9
			String other_expenditure  = contract_condition_list.get(10);//其它支出 10
			String caution_money  = contract_condition_list.get(11);//保证金 11
			String return_amt  = contract_condition_list.get(12);//厂商返佣 12
			String other_income  = contract_condition_list.get(13);//其他收入 13
			String first_payment  = contract_condition_list.get(14);//首付款  14
			String before_interest  = contract_condition_list.get(15);//租前息 15
			
			//得到偿还日期和偿还租金列表的list
			List<String> l_plan_date = (List<String>) data_table.get("list_date");
			List<String> l_rent = (List<String>) data_table.get("list_rent");
			
			//现金流加入保证金抵扣（得到保证金抵扣租金List）,参数：租金List，保证金 市场irr
			RentCalc rent = new RentCalc();
			List l_RentDetails = rent.getRentDetails(l_rent,caution_money);
			
			String proj_id = "";//合同的不管项目编号，为空处理
			//财务现金流
			String del_sql = " delete  fund_contract_plan where contract_id = '"+contract_id+"' ";
			flag = this.execProjORcontract_xjl(l_plan_date,l_rent,lease_money,
						 consulting_fee, handling_charge, equip_amt,
						 other_expenditure, caution_money, return_amt,
						 other_income, first_payment, start_date,
						 period_type, proj_id, adjust_id,
						 creator, create_date, modificator, modify_date,del_sql,contract_id,"plan_irr",
						 "fund_contract_plan",before_interest);//
			
			//市场现金流 
			//得到保证金抵扣租金List rent_list  租金List,caut_money  保证金
			List new_rent = rent.getRentCautNew(l_rent,caution_money);
			String new_del_sql = " delete  fund_contract_plan_mark where contract_id = '"+contract_id+"' ";
			flag = this.execProjORcontract_xjl_mark(l_plan_date,new_rent,lease_money,
						 consulting_fee, handling_charge, equip_amt,
						 other_expenditure, caution_money, return_amt,
						 other_income, first_payment, start_date,
						 period_type, proj_id, adjust_id,
						 creator, create_date, modificator, modify_date,new_del_sql,contract_id,"market_irr",
						 "fund_contract_plan_mark",before_interest,l_RentDetails);//
			
			return flag;
		}

		/**
		 * <p>查询交易结构SQL,返回结果集。</p>
		 * @author 小谢
		 * @param sql String
		 * @return List<String> list
		 */
		private List<String> execute_contract_condition_sql(String sql){
			Conn db = new Conn();
			ResultSet rs;
			List<String> list = new ArrayList<String>();
			try {
				rs = db.executeQuery(sql);//执行查询交易结构
				System.out.println("调息现金流之查询交易结构sql==> : "+sql);
				System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
				//初始化
				String lease_money = "";//租赁本金
				String consulting_fee = "";//咨询费
				String handling_charge = "";//手续费
				String period_type = "";//1期初,0期末支付
				String creator = "";//创建人
				String create_date = "";//创建时间
				String modificator = "";//修改人
				String modify_date = "";//修改时间
				String start_date = "";//起租日
				//【2010-08-05修改 增加字段】
				String equip_amt  = "";//设备款 9
				String other_expenditure  = "";//其它支出 10
				String caution_money  = "";//保证金 11
				String return_amt  = "";//厂商返佣 12
				String other_income  = "";//其他收入 13
				String first_payment  = "";//首付款  14
				String before_interest  = "";//租前息 15
				//【重新计算财务和市场IRR需要的参数条件】
				String  income_number_year = "";//付租方式 16  付租方式（月付|季付|半年付|年付","1|3|6|12）
				String  income_number = "";//年环阻次数 17 
				String  nominalprice = "";//留购价 18
				
				//doc_id 文档编号 == adjust_id tableName需更新的表名   contract_id 合同编号 proj_id 项目编号
				String model_temp = "";//用于判断是财务IRR的现金流（plan_irr）还是市场IRR的现金流（market_irr） 
				//取值
				while(rs.next()){
					lease_money = getZeroStr(getStr(rs.getString("lease_money")));//租赁本金
					consulting_fee = getZeroStr(getStr(rs.getString("consulting_fee")));//咨询费
					handling_charge = getZeroStr(getStr(rs.getString("handling_charge")));//手续费
					//下面字段不需要进行特殊处理
					period_type = getDBStr(rs.getString("period_type"));
					creator = getDBStr(rs.getString("creator"));
					create_date = getDBStr(rs.getString("create_date"));
					modificator = getDBStr(rs.getString("modificator"));
					modify_date = getDBStr(rs.getString("modify_date"));
					start_date = getStr(rs.getString("start_date"));
					//【2010-08-05修改 增加字段】
					equip_amt  = getDBStr(rs.getString("equip_amt"));//设备款 9
					other_expenditure  = getDBStr(rs.getString("other_expenditure"));//其它支出 10
					caution_money  = getDBStr(rs.getString("caution_money"));//保证金 11
					return_amt  = getDBStr(rs.getString("return_amt"));//厂商返佣 12
					other_income  = getDBStr(rs.getString("other_income"));//其他收入 13
					first_payment  = getDBStr(rs.getString("first_payment"));//首付款  14
					before_interest  = getDBStr(rs.getString("before_interest"));//租前息 15
					income_number_year  = getDBStr(rs.getString("income_number_year"));//付租方式 16  
					income_number  = getDBStr(rs.getString("income_number"));//年环阻次数 17 
					nominalprice  = getDBStr(rs.getString("nominalprice"));//18
				}
				//封装值
				list.add(lease_money);//0
				list.add(consulting_fee);//1
				list.add(handling_charge);//2
				list.add(period_type);//3
				list.add(creator);//4
				list.add(create_date);//5
				list.add(modificator);//6
				list.add(modify_date);//7
				list.add(start_date);//8
				//【2010-08-05修改 增加字段】
				list.add(equip_amt);//9
				list.add(other_expenditure);//10
				list.add(caution_money);//11
				list.add(return_amt);//12
				list.add(other_income);//13
				list.add(first_payment);//14
				list.add(before_interest);//15
				list.add(income_number_year);//16
				list.add(income_number);//17
				list.add(nominalprice);//18
				
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			db.close();
			return list;
		}
		/**
		 * <p>查询合同租金列表的SQL。</p>
		 * @author 小谢
		 * @param sql String
		 * @return Hashtable list_date:封装有日期的list，list_rent：封装有每期租金的list
		 */
		@SuppressWarnings("unchecked")
		private Hashtable execute_fund_rent_plan(String sql){
			Conn db = new Conn();
			ResultSet rs;
			Hashtable  data_table = new Hashtable();
			try {
				rs = db.executeQuery(sql);
				System.out.println("调息现金流之合同租金偿还计划sql==> : "+sql);
				System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
				String plan_date = "";
				String rent = "";
				List<String> list_date = new ArrayList<String>();
				List<String> list_rent = new ArrayList<String>();
				while(rs.next()){
					plan_date = getStr(getStr(rs.getString("plan_date")));//偿还日期
					rent = getZeroStr(getStr(rs.getString("rent")));//每期租金
					list_date.add(plan_date);
					list_rent.add(rent);
				}
				data_table.put("list_date", list_date);
				data_table.put("list_rent", list_rent);
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			db.close();
			return data_table;
		}
		
		/**
		 * <p>项目(合同)租金测算中财务IRR的现金流操作方法。</p>
		 * @author sea
		 * @param l_plan_date 偿还日期列表List
		 * @param l_rent 租金列表List
		 * @param lease_money 租赁本金
		 * @param consulting_fee 咨询费
		 * @param handling_charge 手续费
		 * @param equip_amt 设备款
		 * @param other_expenditure 其它支出
		 * @param caution_money 保证金
		 * @param return_amt 厂商返佣
		 * @param other_income 其他收入
		 * @param first_payment 首付款 
		 * @param other_expenditure 其它支出
		 * @param old_start_date 起租日
		 * @param period_type 1,期初 0,期未的值
		 * @param proj_id 项目编号
		 * @param doc_id 文档编号
		 * @param creator 创建人
		 * @param create_date 创建日期
		 * @param modificator 修改人
		 * @param modify_date 修改日期
		 * @param contract_id 合同编号
		 * @param model_temp 用于判断是财务IRR的现金流（plan_irr）还是市场IRR的现金流（market_irr） 
		 * @param tableName 需更新的表名 
		 * @param before_interest 租前息
		 * @return 现金流插入成功与否
		 */
		@SuppressWarnings("unchecked")
		public int execProjORcontract_xjl(List l_plan_date,List l_rent,String lease_money,
				String consulting_fee,String handling_charge,String equip_amt,
				String other_expenditure,String caution_money,String return_amt,
				String other_income,String first_payment,String old_start_date,
				String period_type,String proj_id,String doc_id,
				String creator,String create_date,String modificator,String modify_date,
				String del_sql,String contract_id,String model_temp,String tableName,
				String before_interest){
			//
			Conn db = new Conn();
			int flag = 0;
			//初始化6个数组：日期 plan_date_list,流入量 follow_in_list,流入量清单 follow_in_detail_list
			//流出量 follow_out_list,流出量清单 follow_out_detail_list,净流量 net_follow_list
			List<String> plan_date_list = new ArrayList<String>();//
			List<String> follow_in_list = new ArrayList<String>();//
			List<String> follow_in_detail_list = new ArrayList<String>();//
			List<String> follow_out_list = new ArrayList<String>();//
			List<String> follow_out_detail_list = new ArrayList<String>();//
			List<String> net_follow_list = new ArrayList<String>();//
			//判断期初期末，
			String l_money = "-"+lease_money;//租赁本金
			String l_consulting_fee = "-"+consulting_fee;//咨询费
			//【新增2个变量】【修改时间2010-06-29】
			String l_equip_amt = "-"+equip_amt;//设备款
			String l_other_expenditure = "-"+other_expenditure;//其它支出
			
			Double count_money = 0.00;//净流量
			String follow_in_detailTemp = "";//流入量清单拼装
			String follow_out_detailTemp = "";//流出量清单拼装
			Double follow_out_money = 0.00;//流出量现金
			Double follow_in_money = 0.00;//流入量现金
			Double temp_in = 0.00;
			Double temp_out = 0.00;
			
			//净融资额=设备款-保证金-手续费-厂商返佣-其他收入+咨询费+其他支出-首付款 -租前息【新增条件2010-07-23】
			//第一期现金流入量需加入：-保证金-手续费-厂商返佣-其他收入-首付款 -租前息【2010-07-23修改】
			//2010-07-14修改 流入去掉 保证金 
			if(model_temp.equals("plan_irr")){
				//Double.valueOf(caution_money) +
				temp_in =  Double.valueOf(handling_charge) + Double.valueOf(return_amt) + Double.valueOf(other_income) + Double.valueOf(first_payment)+Double.valueOf(before_interest);
			}else{//market_irr
				//市场IRR的现金流不包含保证金	
				temp_in = Double.valueOf(handling_charge) + Double.valueOf(return_amt) + Double.valueOf(other_income) + Double.valueOf(first_payment)+Double.valueOf(before_interest);
			}
			//第一期现金流出量需加入: 设备款 咨询费 其他支出 租赁本金
			// + Double.valueOf(l_money) 2010-07-14修改 流出去掉 租赁本金
			temp_out = Double.valueOf(l_equip_amt) + Double.valueOf(l_consulting_fee) + Double.valueOf(l_other_expenditure);
			//不需要负号
			Double now_temp_out = Double.valueOf(equip_amt) + Double.valueOf(consulting_fee) + Double.valueOf(other_expenditure);
			//流入量清单：期初 加上第一期租金的清单 期末则不加	
			String str_follow_in_detailTemp = "";
			if(model_temp.equals("plan_irr")){
				////2010-07-14修改 流入去掉 保证金 
				str_follow_in_detailTemp = "";
				//str_follow_in_detailTemp = str_follow_in_detailTemp + " 保证金:"+caution_money;
			}else{//market_irr
				str_follow_in_detailTemp = "";
			}
			str_follow_in_detailTemp = str_follow_in_detailTemp + " 手续费:"+handling_charge;
			str_follow_in_detailTemp = str_follow_in_detailTemp + " 厂商返佣:"+return_amt;
			str_follow_in_detailTemp = str_follow_in_detailTemp + " 其他收入:"+other_income;
			str_follow_in_detailTemp = str_follow_in_detailTemp + " 首付款:"+first_payment;
			str_follow_in_detailTemp = str_follow_in_detailTemp + " 租前息:"+before_interest;
			//流出量清单 期初期末一致	
			String str_follow_out_detailTemp = "";
			str_follow_out_detailTemp = str_follow_out_detailTemp + " 设备款:"+equip_amt;
			str_follow_out_detailTemp = str_follow_out_detailTemp + " 咨询费:"+consulting_fee;
			str_follow_out_detailTemp = str_follow_out_detailTemp + " 其他支出:"+other_expenditure;
			// 2010-07-14修改 流出去掉 租赁本金
			//str_follow_out_detailTemp = str_follow_out_detailTemp + " 租赁本金:"+lease_money;
					
			//期初：要加第一期租金  (period_type 1,期初 0,期未的值)
			if(period_type.equals("1")){
				String first_rent = l_rent.get(0).toString();//第一期租金 【注意】
				//第一期现金流入量需加入【第一期租金】
				follow_in_money = temp_in + Double.valueOf(first_rent);//最终净流入量
				//第一期现金流出量
				follow_out_money = now_temp_out;//最终净流出量 
				//净流量 流入 - 流出 
				count_money = follow_in_money - follow_out_money;
				plan_date_list.add(old_start_date);//第一个现金流对应日期，以起租日为准
				follow_in_list.add(formatNumberDoubleTwo(String.valueOf(follow_in_money)));//第一个现金静流入量
				//流入量清单
				follow_in_detailTemp = str_follow_in_detailTemp + " 第一期租金:"+first_rent+"";
				follow_in_detail_list.add(follow_in_detailTemp);//第一个现金流入量清单数据
				follow_out_list.add(String.valueOf(formatNumberDoubleTwo(follow_out_money)));//第一个现金静流出量
				//流出量清单
				follow_out_detailTemp = str_follow_out_detailTemp;
				follow_out_detail_list.add(follow_out_detailTemp);//第一个现金流出量清单
				//第一个现金净流量
				net_follow_list.add(formatNumberDoubleTwo(String.valueOf(count_money)));
				//期初租金list从第二个开始取值下标为1
				for(int i = 1;i < l_rent.size();i++){
					plan_date_list.add(l_plan_date.get(i).toString());//日期
					follow_in_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()));//流入
					follow_in_detailTemp = "租金:"+l_rent.get(i);
					follow_in_detail_list.add(follow_in_detailTemp);//流入清单
					follow_out_list.add("0.00");//流出
					follow_out_detail_list.add("");//流出清单
					net_follow_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()));//净流量
				}
			}else{//期末不包括第一期租金 
				follow_in_money = temp_in;//第一个流入量为：手续费
				plan_date_list.add(old_start_date);//第一个日期
				follow_in_list.add(formatNumberDoubleTwo(temp_in.toString()));//第一个流入
				
				follow_in_detailTemp = str_follow_in_detailTemp;//第一个流入清单
				follow_in_detail_list.add(follow_in_detailTemp);
				follow_out_money = now_temp_out;//
				follow_out_list.add(formatNumberDoubleTwo(String.valueOf(follow_out_money)));//流出量
				follow_out_detailTemp = str_follow_out_detailTemp;//第一个现金流出量清单
				follow_out_detail_list.add(follow_out_detailTemp);
				count_money =  follow_out_money - follow_in_money;//
				net_follow_list.add(formatNumberDoubleTwo(String.valueOf(count_money)));//净流量
				for(int i = 1;i < l_rent.size();i++){
					plan_date_list.add(l_plan_date.get(i).toString());//日期
					follow_in_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()));//流入
					follow_in_detailTemp = "租金:"+l_rent.get(i);
					follow_in_detail_list.add(follow_in_detailTemp);//流入清单
					follow_out_list.add("0.00");//流出
					follow_out_detail_list.add("");//流出清单
					net_follow_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()));//净流量
				}
			}
			try {
				//每次插入之前需删除之前插入的数据
				flag = db.executeUpdate(del_sql);
				System.out.println("现金流数据插入前的删除语句==> :"+del_sql);
				ConditionOperating condition = new ConditionOperating();
				if(contract_id.equals("") || contract_id == null){
					flag = condition.update_fund_proj_plan(proj_id,doc_id,plan_date_list,follow_in_list,follow_in_detail_list,follow_out_list,follow_out_detail_list,net_follow_list, creator, create_date,modificator, modify_date,tableName);
				}else{
					flag = condition.update_fund_contract_plan(contract_id,doc_id,plan_date_list,follow_in_list,follow_in_detail_list,follow_out_list,follow_out_detail_list,net_follow_list, creator, create_date,modificator, modify_date,tableName);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return flag;
		}
		/**
		 * <p>项目（合同）租金测算中市场IRR的现金流操作方法。</p>
		 * @author sea
		 * @param l_plan_date 偿还日期列表List
		 * @param l_rent 租金列表List
		 * @param lease_money 租赁本金
		 * @param consulting_fee 咨询费
		 * @param handling_charge 手续费
		 * @param equip_amt 设备款
		 * @param other_expenditure 其它支出
		 * @param caution_money 保证金
		 * @param return_amt 厂商返佣
		 * @param other_income 其他收入
		 * @param first_payment 首付款 
		 * @param other_expenditure 其它支出
		 * @param old_start_date 起租日
		 * @param period_type 1,期初 0,期未的值
		 * @param proj_id 项目编号
		 * @param doc_id 文档编号
		 * @param creator 创建人
		 * @param create_date 创建日期
		 * @param modificator 修改人
		 * @param modify_date 修改日期
		 * @param contract_id 合同编号
		 * @param model_temp 用于判断是财务IRR的现金流（plan_irr）还是市场IRR的现金流（market_irr） 
		 * @param tableName 需更新的表名 
		 * @param before_interest 租前息
		 * @param l_RentDetails 保证金抵扣租金List 其中封装的是hashmap，hashmap中封装了五个值
		 * @return 现金流插入成功与否
		 */
		@SuppressWarnings("unchecked")
		public int execProjORcontract_xjl_mark(List l_plan_date,List l_rent,String lease_money,
				String consulting_fee,String handling_charge,String equip_amt,
				String other_expenditure,String caution_money,String return_amt,
				String other_income,String first_payment,String old_start_date,
				String period_type,String proj_id,String doc_id,
				String creator,String create_date,String modificator,String modify_date,
				String del_sql,String contract_id,String model_temp,String tableName,
				String before_interest,List l_RentDetails){
			//先处理保证金抵扣租金List
			List new_follow_in = new ArrayList();//流入量
			List new_follow_in_detail = new ArrayList();//流入量清单
			List new_follow_out = new ArrayList();//流出量
			List new_follow_out_detail = new ArrayList();//流出量清单
			List new_net_follow = new ArrayList();//净流入量
			if(l_RentDetails.size() > 0){
				for(int i = 0;i < l_RentDetails.size();i++){
					Hashtable map = new Hashtable<String, String>();
					map = (Hashtable) l_RentDetails.get(i);
					new_follow_in.add(map.get("follow_in"));
					new_follow_in_detail.add(map.get("follow_in_detail"));
					new_follow_out.add(map.get("follow_out"));
					new_follow_out_detail.add(map.get("follow_out_detail"));
					new_net_follow.add(map.get("net_follow"));
				}
			}
			Conn db = new Conn();
			int flag = 0;
			//初始化6个数组：日期 plan_date_list,流入量 follow_in_list,流入量清单 follow_in_detail_list
			//流出量 follow_out_list,流出量清单 follow_out_detail_list,净流量 net_follow_list
			List<String> plan_date_list = new ArrayList<String>();//
			List<String> follow_in_list = new ArrayList<String>();//
			List<String> follow_in_detail_list = new ArrayList<String>();//
			List<String> follow_out_list = new ArrayList<String>();//
			List<String> follow_out_detail_list = new ArrayList<String>();//
			List<String> net_follow_list = new ArrayList<String>();//
			//判断期初期末，
			String l_money = "-"+lease_money;//租赁本金
			String l_consulting_fee = "-"+consulting_fee;//咨询费
			//【新增2个变量】【修改时间2010-06-29】
			String l_equip_amt = "-"+equip_amt;//设备款
			String l_other_expenditure = "-"+other_expenditure;//其它支出
			
			Double count_money = 0.00;//净流量
			String follow_in_detailTemp = "";//流入量清单拼装
			String follow_out_detailTemp = "";//流出量清单拼装
			Double follow_out_money = 0.00;//流出量现金
			Double follow_in_money = 0.00;//流入量现金
			Double temp_in = 0.00;
			Double temp_out = 0.00;
			
			//净融资额=设备款-保证金-手续费-厂商返佣-其他收入+咨询费+其他支出-首付款 -租前息【新增条件2010-07-23】
			//第一期现金流入量需加入：-保证金-手续费-厂商返佣-其他收入-首付款 -租前息【2010-07-23修改】
			//2010-07-14修改 流入去掉 保证金 ----- 2010-07-28修改 市场加上保证金
			if(model_temp.equals("market_irr")){
				//Double.valueOf(caution_money) +
				temp_in =  Double.valueOf(caution_money) +Double.valueOf(handling_charge) + Double.valueOf(return_amt) + Double.valueOf(other_income) + Double.valueOf(first_payment)+Double.valueOf(before_interest);
			}else{//market_irr
				//财务IRR的现金流不包含保证金	Double.valueOf(caution_money) +
				temp_in = Double.valueOf(handling_charge) + Double.valueOf(return_amt) + Double.valueOf(other_income) + Double.valueOf(first_payment)+Double.valueOf(before_interest);
			}
			//第一期现金流出量需加入: 设备款 咨询费 其他支出 租赁本金
			// + Double.valueOf(l_money) 2010-07-14修改 流出去掉 租赁本金
			temp_out = Double.valueOf(l_equip_amt) + Double.valueOf(l_consulting_fee) + Double.valueOf(l_other_expenditure);
			//不需要负号
			Double now_temp_out = Double.valueOf(equip_amt) + Double.valueOf(consulting_fee) + Double.valueOf(other_expenditure);
			//流入量清单：期初 加上第一期租金的清单 期末则不加	
			String str_follow_in_detailTemp = "";
			if(model_temp.equals("market_irr")){//market_irr
				////2010-07-14修改 流入去掉 保证金 -- 2010-07-28修改 市场加上保证金
				str_follow_in_detailTemp = "";
				str_follow_in_detailTemp = str_follow_in_detailTemp + " 保证金:"+caution_money;
			}else{//财务IRR 保证金不加入###########
				str_follow_in_detailTemp = "";
			}
			str_follow_in_detailTemp = str_follow_in_detailTemp + " 手续费:"+handling_charge;
			str_follow_in_detailTemp = str_follow_in_detailTemp + " 厂商返佣:"+return_amt;
			str_follow_in_detailTemp = str_follow_in_detailTemp + " 其他收入:"+other_income;
			str_follow_in_detailTemp = str_follow_in_detailTemp + " 首付款:"+first_payment;
			str_follow_in_detailTemp = str_follow_in_detailTemp + " 租前息:"+before_interest;
			//流出量清单 期初期末一致	
			String str_follow_out_detailTemp = "";
			str_follow_out_detailTemp = str_follow_out_detailTemp + " 设备款:"+equip_amt;
			str_follow_out_detailTemp = str_follow_out_detailTemp + " 咨询费:"+consulting_fee;
			str_follow_out_detailTemp = str_follow_out_detailTemp + " 其他支出:"+other_expenditure;
			// 2010-07-14修改 流出去掉 租赁本金
			//str_follow_out_detailTemp = str_follow_out_detailTemp + " 租赁本金:"+lease_money;
			
			//期初：要加第一期租金  (period_type 1,期初 0,期未的值)
			if(period_type.equals("1")){
				String first_rent = l_rent.get(0).toString();//第一期租金 【注意】
				//第一期现金流入量需加入【第一期租金】
				follow_in_money = temp_in + Double.valueOf(first_rent);//最终净流入量
				//第一期现金流出量
				follow_out_money = now_temp_out;//最终净流出量 
				//净流量 流入 - 流出 
				count_money = follow_in_money - follow_out_money;
				plan_date_list.add(old_start_date);//第一个现金流对应日期，以起租日为准
				follow_in_list.add(formatNumberDoubleTwo(String.valueOf(follow_in_money)));//第一个现金静流入量
				//流入量清单
				follow_in_detailTemp = str_follow_in_detailTemp + " 第一期租金:"+first_rent+"";
				follow_in_detail_list.add(follow_in_detailTemp);//第一个现金流入量清单数据
				follow_out_list.add(String.valueOf(formatNumberDoubleTwo(follow_out_money)));//第一个现金静流出量
				//流出量清单
				follow_out_detailTemp = str_follow_out_detailTemp;
				follow_out_detail_list.add(follow_out_detailTemp);//第一个现金流出量清单
				//第一个现金净流量
				net_follow_list.add(formatNumberDoubleTwo(String.valueOf(count_money)));
				//期初租金list从第二个开始取值下标为1
				for(int i = 1;i < l_rent.size();i++){
					plan_date_list.add(l_plan_date.get(i).toString());//日期
					follow_in_list.add(formatNumberDoubleTwo(new_follow_in.get(i).toString()));//流入量
					//follow_in_detailTemp = "租金:"+new_follow_in.get(i);
					follow_in_detail_list.add(new_follow_in_detail.get(i).toString());//流入量清单
					follow_out_list.add(formatNumberDoubleTwo(new_follow_out.get(i).toString()));//流出量
					follow_out_detail_list.add(new_follow_out_detail.get(i).toString());//流出量清单
					net_follow_list.add(formatNumberDoubleTwo(new_net_follow.get(i).toString()));//净流量
				}
			}else{//期末不包括第一期租金 
				follow_in_money = temp_in;//第一个流入量为：手续费
				plan_date_list.add(old_start_date);//第一个日期
				follow_in_list.add(formatNumberDoubleTwo(temp_in.toString()));//第一个流入
				
				follow_in_detailTemp = str_follow_in_detailTemp;//第一个流入清单
				follow_in_detail_list.add(follow_in_detailTemp);
				follow_out_money = now_temp_out;//
				follow_out_list.add(formatNumberDoubleTwo(String.valueOf(follow_out_money)));//流出量
				follow_out_detailTemp = str_follow_out_detailTemp;//第一个现金流出量清单
				follow_out_detail_list.add(follow_out_detailTemp);
				count_money = follow_out_money - follow_in_money ;//
				net_follow_list.add(formatNumberDoubleTwo(String.valueOf(count_money)));//净流量
				for(int i = 1;i < l_rent.size();i++){
					plan_date_list.add(l_plan_date.get(i).toString());//日期
					follow_in_list.add(formatNumberDoubleTwo(new_follow_in.get(i).toString()));//流入量
					follow_in_detail_list.add(new_follow_in_detail.get(i).toString());//流入量清单
					follow_out_list.add(formatNumberDoubleTwo(new_follow_out.get(i).toString()));//流出量
					follow_out_detail_list.add(new_follow_out_detail.get(i).toString());//流出量清单
					net_follow_list.add(formatNumberDoubleTwo(new_net_follow.get(i).toString()));//净流量
				}
			}
			try {
				//每次插入之前需删除之前插入的数据
				flag = db.executeUpdate(del_sql);
				System.out.println("现金流数据插入前的删除语句==> :"+del_sql);
				ConditionOperating condition = new ConditionOperating();
				if(contract_id.equals("") || contract_id == null){//如果合同编号为空的话 则是项目的现金流 进入现金流的保存方法
					flag = condition.update_fund_proj_plan(proj_id,doc_id,plan_date_list,follow_in_list,follow_in_detail_list,follow_out_list,follow_out_detail_list,net_follow_list, creator, create_date,modificator, modify_date,tableName);
				}else{//否则进入合同现金流的保存方法
					flag = condition.update_fund_contract_plan(contract_id,doc_id,plan_date_list,follow_in_list,follow_in_detail_list,follow_out_list,follow_out_detail_list,net_follow_list, creator, create_date,modificator, modify_date,tableName);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return flag;
		}
		/**
		 * <p>request字符串中文处理。</p>
		 * @author common.jsp
		 * @param str
		 * @return
		 */
		public String getStr(String str) 
		{
			try
			{
				String temp_p = str;
				byte[] temp_t = temp_p.getBytes("ISO8859-1");
				String temp = new String(temp_t);
				return temp;
			}catch(Exception e) {
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
		 * <p>数字格式化为2位小数。</p>
		 * @author common.jsp
		 * @param str
		 * @return
		 */
		public String formatNumberDoubleTwo(String str){
			try
			{
		        String temp_num=str;
		            if ((temp_num==null) || (temp_num.equals("")))
		        {
		        temp_num="";
		        }
		        else
		        {
				 java.text.DecimalFormat ft =  new java.text.DecimalFormat("###0.00");
				 //java.text.DecimalFormat ft =  new java.text.DecimalFormat(style); 
				 BigDecimal bd = new BigDecimal(temp_num);
				 temp_num=ft.format(bd);
		 
		        }
		        return temp_num; 
			}
			catch(Exception e)
			{
			}
			return "";
		}
		/**
		 * <p>数字格式化为2位小数。</p>
		 * @author common.jsp
		 * @param str
		 * @return
		 */
		public String formatNumberDoubleTwo(double str){
			try
			{
		        String temp_num=String.valueOf(str);
		            if ((temp_num==null) || (temp_num.equals("")))
		        {
		        temp_num="";
		        }
		        else
		        {
				 java.text.DecimalFormat ft =  new java.text.DecimalFormat("###0.00");
				 BigDecimal bd=new BigDecimal(temp_num);
				 temp_num=ft.format(bd);
		 
		        }
		        return temp_num; 
			}
			catch(Exception e)
			{
			}
			return "";
		}
		//****************************************【2010-08-05修改 重写新的调息现金流方法 见上方方法】		
//		/**
//		 * <p>根据交易结构和偿还计划数据拼装最终需要操作的6个list并执行。</p>
//		 * @author 小谢
//		 * @param contract_condition_list 交易结构
//		 * @param data_table list_date:封装有日期的list，list_rent：封装有每期租金的list
//		 * @param contract_id 合同编号
//		 * @param adjust_id 央行基准利率表编号
//		 * @return
//		 */
//		@SuppressWarnings("unchecked")
//		private int getCashFlowList(List<String> contract_condition_list,Hashtable  data_table,String contract_id,String adjust_id){
//			int flag = 0;
//			Conn db = new Conn();
//			//初始化6个数组：日期 plan_date_list,流入量 follow_in_list,流入量清单 follow_in_detail_list
//			//流出量 follow_out_list,流出量清单 follow_out_detail_list,净流量 net_follow_list
//			List<String> plan_date_list = new ArrayList<String>();//
//			List<String> follow_in_list = new ArrayList<String>();//
//			List<String> follow_in_detail_list = new ArrayList<String>();//
//			List<String> follow_out_list = new ArrayList<String>();//
//			List<String> follow_out_detail_list = new ArrayList<String>();//
//			List<String> net_follow_list = new ArrayList<String>();//
//			//交易结构数据
//			String lease_money = contract_condition_list.get(0);//租赁本金
//			String consulting_fee = contract_condition_list.get(1);//咨询费
//			String handling_charge = contract_condition_list.get(2);//手续费
//			String period_type = contract_condition_list.get(3);//1期初,0期末支付
//			String creator = contract_condition_list.get(4);//创建人
//			String create_date = contract_condition_list.get(5);//
//			String modificator = contract_condition_list.get(6);//
//			String modify_date = contract_condition_list.get(7);//
//			String start_date = contract_condition_list.get(8);//起租日
//			//处理最终形成的费用
//			String l_money = "-"+lease_money;//租赁本金
//			String l_consulting_fee = "-"+consulting_fee;//咨询费
//			String l_handling_charge = handling_charge;//手续费
//			//租金偿还列表数据
//			List<String> l_plan_date = (List<String>) data_table.get("list_date");
//			List<String> l_rent = (List<String>) data_table.get("list_rent");
//			//
//			Double count_money = 0.00;//净流量
//			String follow_in_detailTemp = "";//流入量清单拼装
//			String follow_out_detailTemp = "";//流出量清单拼装
//			Double follow_out_money = 0.00;//流出量现金
//			Double follow_in_money = 0.00;//流入量现金
//			//
//			//期初：咨询费+租赁本金+手续费+第一期租金  (period_type 1,期初 0,期未的值)
//			if(period_type.equals("1")){
//				String first_rent = l_rent.get(0).toString();//第一期租金
//				follow_in_money = Double.valueOf(l_handling_charge)+Double.valueOf(first_rent);//手续费+第一期租金 流入量
//				follow_out_money = Double.valueOf(l_money)+Double.valueOf(l_consulting_fee);//租赁本金+咨询费  流出量 
//				count_money = follow_out_money+follow_in_money;//净流量
//				plan_date_list.add(start_date);//第一个现金流对应日期，以起租日为准
//				follow_in_list.add(formatNumberDoubleTwo(String.valueOf(follow_in_money)));//第一个现金流入量数据
//				follow_in_detailTemp = "手续费:"+l_handling_charge+" 第一期租金:"+first_rent+" ";
//				follow_in_detail_list.add(follow_in_detailTemp);//第一个现金流入量清单数据
//				follow_out_list.add(String.valueOf(formatNumberDoubleTwo(follow_out_money)));//第一个现金流出量
//				follow_out_detailTemp = ":租赁本金"+lease_money+" 咨询费:"+consulting_fee+"";//第一个现金流出量清单
//				follow_out_detail_list.add(follow_out_detailTemp);
//				net_follow_list.add(formatNumberDoubleTwo(String.valueOf(count_money)));//第一个现金净流量
//				//期初租金list从第二个开始取值下标为1
//				for(int i = 1;i < l_rent.size();i++){
//					plan_date_list.add(l_plan_date.get(i).toString());//日期
//					follow_in_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()));//租金
//					follow_in_detailTemp = "租金:"+l_rent.get(i);
//					follow_in_detail_list.add(follow_in_detailTemp);//流入清单
//					follow_out_list.add("-0.00");//流出
//					follow_out_detail_list.add("");//流出清单
//					net_follow_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()));//净流量
//				}
//			}else{//期末不包括第一期租金 
//				follow_in_money = Double.valueOf(l_handling_charge);//第一个流入量为：手续费
//				plan_date_list.add(start_date);//第一个日期
//				follow_in_list.add(formatNumberDoubleTwo(Double.valueOf(follow_in_money).toString()));//第一个流入
//				follow_in_detailTemp = "手续费:"+l_handling_charge;//第一个清单
//				follow_in_detail_list.add(follow_in_detailTemp);
//				follow_out_money = Double.valueOf(l_money)+Double.valueOf(l_consulting_fee);//租赁本金+咨询费
//				follow_out_list.add(formatNumberDoubleTwo(String.valueOf(follow_out_money)));//流出量
//				follow_out_detailTemp = ":租赁本金"+lease_money+" 咨询费:"+consulting_fee+"";//第一个现金流出量清单
//				follow_out_detail_list.add(follow_out_detailTemp);
//				count_money = follow_in_money+follow_out_money;//
//				net_follow_list.add(formatNumberDoubleTwo(String.valueOf(count_money)));//净流量
//				for(int i = 0;i < l_rent.size();i++){
//					plan_date_list.add(l_plan_date.get(i).toString());//日期
//					follow_in_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()));//租金
//					follow_in_detailTemp = "租金:"+l_rent.get(i);
//					follow_in_detail_list.add(follow_in_detailTemp);//流入清单
//					follow_out_list.add("-0.00");//流出
//					follow_out_detail_list.add("");//流出清单
//					net_follow_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()));//净流量
//				}
//			}
//			//每次插入之前需删除之前插入的数据
//			String del_sql = " delete from fund_contract_plan where contract_id = '"+contract_id+"' and adjust_id = '"+adjust_id+"' and note = '调息'";
//			try {
//				System.out.println("delete from fund_contract_plan更新SQL语句为==> : "+del_sql);
//				flag = db.executeUpdate(del_sql);//adjust_id == doc_id
//				flag = this.update_fund_contract_plan(contract_id,adjust_id,plan_date_list,follow_in_list,follow_in_detail_list,follow_out_list,follow_out_detail_list,net_follow_list, creator, create_date,modificator, modify_date);
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//			db.close();
//			return flag;
//		}
//		/**
//		 * <p>跟新表fund_contract_plan操作。</p>
//		 * @author 小谢
//		 * @param contract_id 合同编号
//		 * @param doc_id  文档编号
//		 * @param plan_date_list 日期list
//		 * @param follow_in_list 现金流入量list
//		 * @param follow_in_detail_list 现金流入量清单list
//		 * @param follow_out_list  现金流出量list
//		 * @param follow_out_detail_list 现金流出量清单list
//		 * @param net_follow_list 净流量list
//		 * @param creator 创建人
//		 * @param create_date 创建日期
//		 * @param modify_date 修改日期
//		 * @param modificator 修改人
//		 * @return 更新结果 0:更新失败 >0更新成功 返回类型:INT 
//		 */
//		public int update_fund_contract_plan(String contract_id,String doc_id,List<String> plan_date_list,List<String> follow_in_list,List<String> follow_in_detail_list,List<String> follow_out_list,List<String> follow_out_detail_list,List<String> net_follow_list,String creator,String create_date,String modify_date,String modificator){
//			//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//格式化时间
//			//String nowTime = sdf.format(new Date());//当前格式化之后的时间
//			//初始化6个数组：日期 plan_date_list,流入量 follow_in_list,流入量清单 follow_in_detail_list
//			//流出量 follow_out_list,流出量清单 follow_out_detail_list,净流量 net_follow_list
//			System.out.println("join类方法");
//			int count = 0;
//			Conn db = new Conn();
//			StringBuffer sql = new StringBuffer();
//			for(int i = 0;i < plan_date_list.size();i++){
//				sql.append(" INSERT INTO fund_contract_plan ")
//				.append(" (contract_id ,doc_id ,plan_date ,follow_in ")
//				.append(" ,follow_in_detail ,follow_out ,follow_out_detail ")
//				.append(" ,net_follow ,creator ,create_date ,modificator ,modify_date,note) ")
//				.append(" VALUES ")
//				.append(" ('"+contract_id+"','"+doc_id+"' ")
//				.append(" ,'"+plan_date_list.get(i)+"' ")//日期 formatNumberDoubleTwo
//				.append(" ,'"+follow_in_list.get(i)+"' ")//流入
//				.append(" ,'"+follow_in_detail_list.get(i)+"' ")//流入清单
//				.append(" ,'"+follow_out_list.get(i)+"' ")//流出
//				.append(" ,'"+follow_out_detail_list.get(i)+"' ")//流出清单
//				.append(" ,'"+net_follow_list.get(i)+"' ")//净流量
//				.append(" ,'"+creator+"' ")//创建人
//				.append(" ,'"+create_date+"' ")//创建日期
//				.append(" ,'"+modify_date+"' ")//修改日期 
//				.append(" ,'"+modificator+"','调息'); ");//修改人
//				// System.out.println("更新SQL语句为==> : "+sql.toString());
//			}
//			
//			try {
//				count = db.executeUpdate(sql.toString());
//				System.out.println("INSERT INTO fund_contract_plan更新SQL语句为==> : "+sql.toString());
//			} catch (Exception e) {
//				e.printStackTrace();
//			}finally{
//				db.close();
//			}
//			return count;
//		}
}
