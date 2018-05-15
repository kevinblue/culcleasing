package com.condition;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.rent.calc.bg.RentCalc;

import dbconn.Conn;

/**
 * <p>调息现金流实现类。</p>
 * @author 小谢
 * <p>Jun 10, 2010</p>
 */
public class CashFlow {
		
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
				//【2010-08-05 修改】
				flag = this.exec_cashFlow(contract_condition_list, data_table, contract_id, adjust_id);
				System.out.println("调息现金流join5==flag>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ flag: "+flag);
				System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
				
				//拼装计算财务IRR和市场IRR的查询语句 【四步操作】
				String query_cw_xjl = " select * from fund_contract_plan  where  contract_id = '"+contract_id+"'  order by plan_date";
				String query_market_xjl = " select * from fund_contract_plan_mark  where contract_id = '"+contract_id+"'  order by plan_date";
				flag = this.update_contract_condition(contract_id, contract_condition_list, query_cw_xjl, query_market_xjl);
				System.out.println("修改IRR结果join6==flag>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ flag: "+flag);
				System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
				
				//IRR更新完后更新财务和市场的现金流量表 【五步操作】
				//根据合同编号查询现金流量表最大一期，流入量 字段 加上 留购价 以及流入量清单 判断留购价大于0 
				//同时 净流量 + 留购价  注意：同样普通的租金测算的现金流也需要更新
				String nominalprice = contract_condition_list.get(18);//先得到留购价
				if(!nominalprice.equals("") ){
					//int num_t = Integer.parseInt(nominalprice);
					double t_num = Double.valueOf(nominalprice); 
					if(t_num > 0){//留购价大于0才进行此操作
						//查询财务现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值
						String  query_count_cw = " select * from fund_contract_plan where  contract_id = '"+contract_id+"'";
						query_count_cw = query_count_cw + " and plan_date = ( select max(plan_date) from fund_contract_plan where contract_id = '"+contract_id+"' ) ";
						query_count_cw = query_count_cw + " and id = ( select max(id) from fund_contract_plan where contract_id = '"+contract_id+"' ) ";
						System.out.println("查询财务现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值 ==> "+query_count_cw);
						System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
						
						//查询市场现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值
						String  query_count_market = " select * from fund_contract_plan_mark  where  contract_id = '"+contract_id+"'";
						query_count_market = query_count_market + " and plan_date = ( select max(plan_date) from fund_contract_plan_mark where contract_id = '"+contract_id+"' ) ";
						query_count_market = query_count_market + " and id = ( select max(id) from fund_contract_plan_mark where contract_id = '"+contract_id+"' ) ";
						System.out.println("查询市场现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值 ==> "+query_count_cw);
						System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
						flag = this.update_xjl_cw(query_count_cw, nominalprice,"fund_contract_plan","",contract_id);//财务
						flag = this.update_xjl_market(query_count_market, nominalprice,"fund_contract_plan_mark","",contract_id);//市场
					}
				}
				
			}
			System.out.println("最终调息现金流的返回值为flag==> : "+flag);
			return flag;
		}
		/**
		 * <p>根据 字段的值。</p>
		 * @author 小谢
		 * @param query_count_cw 查询财务现金流三个字段的SQL
		 * @param nominalprice 留购价
		 * @param tableName 传入的表名，用于将方法变成通用利用留购价的更改这三个参数的方法 因为 项目合同起租等模块都要用到
		 * @param proj_id 项目编号
		 * @return
		 */
		public int update_xjl_cw(String  query_count_cw,String nominalprice,String tableName,String proj_id,String contract_id){
			int flag = 0;
			Conn db = new Conn();
			ResultSet rs = null;
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
				String now_follow_in_detail = "";
				if(!"0.00".equals(nominalprice) && !"0".equals(nominalprice)){
					 now_follow_in_detail = follow_in_detail + " 留购价:"+nominalprice;
				}
				Double now_net_follow = Double.valueOf(net_follow) + Double.valueOf(nominalprice);
				String update_fund_contract_plan = " update  "+tableName+"  set follow_in= '"+formatNumberDoubleTwo(now_follow_in)+"' ";
				update_fund_contract_plan = update_fund_contract_plan + "  ,follow_in_detail = '"+now_follow_in_detail+"' ";
				update_fund_contract_plan = update_fund_contract_plan + "  ,net_follow = '"+formatNumberDoubleTwo(now_net_follow)+"' ";
				if(proj_id.equals("") || proj_id == null){//项目编号为空，以 合同编号 为主键条件查询
					update_fund_contract_plan = update_fund_contract_plan + "   where  id = ( select max(id) from  "+tableName+"  where contract_id = '"+contract_id+"') ";
				}else{
					update_fund_contract_plan = update_fund_contract_plan + "   where  id = ( select max(id) from  "+tableName+"  where proj_id = '"+proj_id+"') ";
				}
				flag = db.executeUpdate(update_fund_contract_plan);
				System.out.println("更新财务现金流加入留购价后三个字段的SQL == 》 "+update_fund_contract_plan);
				//formatNumberDoubleTwo(
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			db.close();
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
		public int update_xjl_market(String  query_count_market,String nominalprice,String tableName,String proj_id,String contract_id){
			int flag = 0;
			Conn db = new Conn();
			ResultSet rs = null;
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
				String now_follow_in_detail =  "";
				if(!"0.00".equals(nominalprice) && !"0".equals(nominalprice)){
					 now_follow_in_detail = follow_in_detail + " 留购价:"+nominalprice;
				}
				Double now_net_follow = Double.valueOf(net_follow) + Double.valueOf(nominalprice);
				String fund_contract_plan_mark = " update  "+tableName+"  set follow_in= '"+formatNumberDoubleTwo(now_follow_in)+"' ";
				fund_contract_plan_mark = fund_contract_plan_mark + "  ,follow_in_detail = '"+now_follow_in_detail+"' ";
				fund_contract_plan_mark = fund_contract_plan_mark + "  ,net_follow = '"+formatNumberDoubleTwo(now_net_follow)+"' ";
				if(proj_id.equals("") || proj_id == null){//项目编号为空，以 合同编号 为主键条件查询
					//修改的是最大一期的数据
					fund_contract_plan_mark = fund_contract_plan_mark + " where  id = ( select max(id) from   "+tableName+"   where contract_id = '"+contract_id+"' )";
				}else{
					fund_contract_plan_mark = fund_contract_plan_mark + "   where  id = ( select max(id) from  "+tableName+"  where proj_id = '"+proj_id+"') ";
				}
				
				flag = db.executeUpdate(fund_contract_plan_mark);
				System.out.println("更新市场现金流加入留购价后三个字段的SQL == 》 "+fund_contract_plan_mark);
				//formatNumberDoubleTwo(
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			db.close();
			return flag;
		}
		/**
		 * <p>现金流操作完成后查询更新后的现金流列表中的净流量列表进行财务和市场IRR的重新计算，然后更新合同交易结构正式表。</p>
		 * @author 小谢
		 * @param contract_id 合同编号  
		 * @param contract_condition_list 交易结构  
		 * @param query_cw_xjl 查询财务现金流净流量的sql
		 * @param query_market_xjl 查询市场现金流净流量的sql
		 * @return
		 */
		private int update_contract_condition(String contract_id,List<String> contract_condition_list,String query_cw_xjl,String query_market_xjl){
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
				rs = db.executeQuery(query_market_xjl);
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
 			int sum = 12/Integer.parseInt(income_number_year);
 			//调用计算IRR的方法
 			String plan_irr = com.rent.calc.tx.bg.IrrCalc.getIRR(l_inflow_pour,income_number_year,income_number_year,String.valueOf(sum));
 			String market_irr = com.rent.calc.tx.bg.IrrCalc.getIRR(l_inflow_pour_market,income_number_year,income_number_year,String.valueOf(sum));
 			flag = this.update_Irr(contract_id, plan_irr, market_irr);
			return flag;
		}
		
		/**
		 * <p>根据合同编号list和传入的IRR进行合同交易结构正式表的更新操作。</p>
		 * @author 小谢
		 * @param contract_id 合同编号
		 * @param plan_irr 财务IRR
		 * @param market_irr 市场IRR
		 * @return
		 */
		private int update_Irr(String contract_id,String plan_irr,String market_irr){
			int flag = 0;
			Conn db = new Conn();
			//更新交易结构表的2个IRR
			String update_sql = "";
			//IRR格式化为6位小数 乘于100
			String p_irr = formatNumberDoubleSix(Double.valueOf(plan_irr)*100);
			String m_irr = formatNumberDoubleSix(Double.valueOf(market_irr)*100);
			System.out.println("p_irr==>"+p_irr+"<==m_irr>"+m_irr);
			System.out.println("                                   ");
			update_sql = " update contract_condition set plan_irr='"+p_irr+"',market_irr = '"+m_irr+"'  where contract_id='"+contract_id+"'   ";
			try {
				flag = db.executeUpdate(update_sql);
				System.out.println("调息现金流操作完成后进行的修改IRR SQL==> "+update_sql);
				System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
			} catch (Exception e) {
				e.printStackTrace();
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
			List<String> l_ren1t = (List<String>) data_table.get("list_rent");
			
			//现金流加入保证金抵扣（得到保证金抵扣租金List）,参数：租金List，保证金 市场irr
			RentCalc rent = new RentCalc();
			List l_RentDetails = rent.getRentDetails(l_ren1t,caution_money);
			
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
			//List new_rent = rent.getRentCautNew(l_rent,caution_money);
			String new_del_sql = " delete  fund_contract_plan_mark where contract_id = '"+contract_id+"' ";
			flag = this.execProjORcontract_xjl_mark(l_plan_date,l_ren1t,lease_money,
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
			ResultSet rs = null;
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
			ResultSet rs = null;
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
			if(!"0.00".equals(handling_charge) && !"0".equals(handling_charge)){
				str_follow_in_detailTemp = str_follow_in_detailTemp + " 手续费:"+formatNumberStr(handling_charge,"#,##0.00");
			}
			if(!"0.00".equals(return_amt) && !"0".equals(return_amt)){
				str_follow_in_detailTemp = str_follow_in_detailTemp + " 厂商返佣:"+formatNumberStr(return_amt,"#,##0.00");
			}
			if(!"0.00".equals(other_income) && !"0".equals(other_income)){
				str_follow_in_detailTemp = str_follow_in_detailTemp + " 其他收入:"+formatNumberStr(other_income,"#,##0.00");
			}
			if(!"0.00".equals(first_payment) && !"0".equals(first_payment)){
				str_follow_in_detailTemp = str_follow_in_detailTemp + " 首付款:"+formatNumberStr(first_payment,"#,##0.00");
			}
			if(!"0.00".equals(before_interest) && !"0".equals(before_interest)){
				str_follow_in_detailTemp = str_follow_in_detailTemp + " 租前息:"+formatNumberStr(before_interest,"#,##0.00");
			}
			//流出量清单 期初期末一致	
			String str_follow_out_detailTemp = "";
			if(!"0.00".equals(equip_amt) && !"0".equals(equip_amt)){
				str_follow_out_detailTemp = str_follow_out_detailTemp + " 设备款:"+formatNumberStr(equip_amt,"#,##0.00");
			}
			if(!"0.00".equals(consulting_fee) && !"0".equals(consulting_fee)){
				str_follow_out_detailTemp = str_follow_out_detailTemp + " 咨询费:"+formatNumberStr(consulting_fee,"#,##0.00");
			}
			if(!"0.00".equals(other_expenditure) && !"0".equals(other_expenditure)){
				str_follow_out_detailTemp = str_follow_out_detailTemp + " 其他支出:"+formatNumberStr(other_expenditure,"#,##0.00");
			}
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
				follow_in_detailTemp = str_follow_in_detailTemp + " 第一期租金:"+formatNumberStr(first_rent,"#,##0.00")+"";
				follow_in_detail_list.add(follow_in_detailTemp);//第一个现金流入量清单数据
				follow_out_list.add(String.valueOf(formatNumberDoubleTwo(follow_out_money)));//第一个现金静流出量
				//流出量清单
				follow_out_detailTemp = str_follow_out_detailTemp;
				follow_out_detail_list.add(follow_out_detailTemp);//第一个现金流出量清单
				//第一个现金净流量
				net_follow_list.add(formatNumberDoubleTwo(String.valueOf(count_money)));
				//期初租金list从第二个开始取值下标为1
				for(int i = 1;i < l_rent.size();i++){
					follow_in_detailTemp = "";
					plan_date_list.add(l_plan_date.get(i).toString());//日期
					follow_in_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()));//流入
					follow_in_detailTemp = "租金:"+formatNumberStr(l_rent.get(i).toString(),"#,##0.00");
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
				count_money =  follow_in_money - follow_out_money ;//
				net_follow_list.add(formatNumberDoubleTwo(String.valueOf(count_money)));//净流量
				for(int i = 0;i < l_rent.size();i++){
					follow_in_detailTemp = "";
					plan_date_list.add(l_plan_date.get(i).toString());//日期
					follow_in_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()));//流入
					follow_in_detailTemp = "租金:"+formatNumberStr(l_rent.get(i).toString(),"#,##0.00");
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
			db.close();
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
				if(!"0.00".equals(caution_money) || !"0".equals(caution_money)){
					str_follow_in_detailTemp = str_follow_in_detailTemp + " 保证金:"+formatNumberStr(caution_money,"#,##0.00");
				}
			}else{//财务IRR 保证金不加入###########
				str_follow_in_detailTemp = "";
			}
			if(!"0.00".equals(handling_charge) && !"0".equals(handling_charge)){
				str_follow_in_detailTemp = str_follow_in_detailTemp + " 手续费:"+formatNumberStr(handling_charge,"#,##0.00");
			}
			if(!"0.00".equals(return_amt) && !"0".equals(return_amt)){
				str_follow_in_detailTemp = str_follow_in_detailTemp + " 厂商返佣:"+formatNumberStr(return_amt,"#,##0.00");
			}
			if(!"0.00".equals(other_income) && !"0".equals(other_income)){
				str_follow_in_detailTemp = str_follow_in_detailTemp + " 其他收入:"+formatNumberStr(other_income,"#,##0.00");
			}
			if(!"0.00".equals(first_payment) && !"0".equals(first_payment)){
				str_follow_in_detailTemp = str_follow_in_detailTemp + " 首付款:"+formatNumberStr(first_payment,"#,##0.00");
			}
			if(!"0.00".equals(before_interest) && !"0".equals(before_interest)){
				str_follow_in_detailTemp = str_follow_in_detailTemp + " 租前息:"+formatNumberStr(before_interest,"#,##0.00");
			}
			//流出量清单 期初期末一致	
			String str_follow_out_detailTemp = "";
			if(!"0.00".equals(equip_amt) && !"0".equals(equip_amt)){
				str_follow_out_detailTemp = str_follow_out_detailTemp + " 设备款:"+formatNumberStr(equip_amt,"#,##0.00");
			}
			if(!"0.00".equals(consulting_fee) && !"0".equals(consulting_fee)){
				str_follow_out_detailTemp = str_follow_out_detailTemp + " 咨询费:"+formatNumberStr(consulting_fee,"#,##0.00");
			}
			if(!"0.00".equals(other_expenditure) && !"0".equals(other_expenditure)){
				str_follow_out_detailTemp = str_follow_out_detailTemp + " 其他支出:"+formatNumberStr(other_expenditure,"#,##0.00");
			}
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
				follow_in_detailTemp = str_follow_in_detailTemp + " 第一期租金:"+formatNumberStr(first_rent,"#,##0.00")+"";
				follow_in_detail_list.add(follow_in_detailTemp);//第一个现金流入量清单数据
				follow_out_list.add(String.valueOf(formatNumberDoubleTwo(follow_out_money)));//第一个现金静流出量
				//流出量清单
				follow_out_detailTemp = str_follow_out_detailTemp;
				follow_out_detail_list.add(follow_out_detailTemp);//第一个现金流出量清单
				//第一个现金净流量
				net_follow_list.add(formatNumberDoubleTwo(String.valueOf(count_money)));
				//TODO:现金流根据延迟期加入2条数据了
				
				//期初租金list从第二个开始取值下标为1
				for(int i = 1;i < l_rent.size();i++){
					follow_in_detailTemp = "";
					plan_date_list.add(l_plan_date.get(i).toString());//日期
					follow_in_list.add(formatNumberDoubleTwo(new_follow_in.get(i).toString()));//流入量
					follow_in_detailTemp = "租金:"+formatNumberStr(new_follow_in.get(i).toString(),"#,##0.00");
					follow_in_detail_list.add(follow_in_detailTemp);//流入量清单
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
				count_money = follow_in_money - follow_out_money ;//
				net_follow_list.add(formatNumberDoubleTwo(String.valueOf(count_money)));//净流量
				//TODO:现金流根据延迟期加入3条数据了
				
				for(int i = 0;i < l_rent.size();i++){
					follow_in_detailTemp = "";
					plan_date_list.add(l_plan_date.get(i).toString());//日期
					follow_in_list.add(formatNumberDoubleTwo(new_follow_in.get(i).toString()));//流入量
					follow_in_detailTemp = "租金:"+formatNumberStr(new_follow_in.get(i).toString(),"#,##0.00");
					follow_in_detail_list.add(follow_in_detailTemp);//流入量清单
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
			db.close();
			return flag;
		}
		
		
		/**
		 * <p>根据传入的查询SQL为现金流的第一期加上管理费，加入到所有流入中。</p>
		 * <p>需要修改4个字段：follow_in-流入,follow_in_detail-流入清单,net_follow-净流量,follow_out-流出金额。</p>
		 * @author 小谢
		 * @param sql
		 * @param management_fee 管理费
		 * @param tableName 表名
		 * @param proj_id 项目号
		 * @param contract_id 合同号
		 * @param doc_id 文档编号
		 * @param model 用于判断是项目的管理费加入现金流还是合同的， proj：表示项目，contract：表示合同和起租
		 * @param type 用于判断是财务的还是市场的， cw：表示财务，market：表示市场
		 * @return
		 */
		public int updat_xjl(String sql,String management_fee,String proj_id,String contract_id,String doc_id,String model,String type){
			int flag = 0;
			Conn db = new Conn();
			try {
				ResultSet rs = db.executeQuery(sql);
				//System.out.println("为现金流的第一期加上管理费前的查询-->"+sql);
				String follow_in = "";//
				String follow_in_detail = "";//
				String net_follow = "";//
				String follow_out = "";//
				while(rs.next()){
					 follow_in = this.getZeroStr(rs.getString("follow_in"));//
					 follow_in_detail = this.getDBStr(rs.getString("follow_in_detail"));//
					 net_follow = this.getZeroStr(rs.getString("net_follow"));//
					 follow_out = this.getZeroStr(rs.getString("follow_out"));//
				}
				rs.close();
				//流入加上管理费操作
				Double money_in = Double.valueOf(follow_in) + Double.valueOf(management_fee);
				Double money_net = money_in - Double.valueOf(follow_out);//净流量 = 流入 - 流出
				System.out.println("加了管理费的净流量"+formatNumberDoubleSix(money_net));
				net_follow = formatNumberDoubleSix(money_net);
				String end_follow_in_detail = "管理费: "+management_fee+" "+follow_in_detail;//最终的第一期现金流入清单
				String end_sql = "";//最终的sql语句
				if("proj".equals(model)){//项目
					String up_proj_cw = "";
					String up_proj_market = "";
					if("cw".equals(type)){
						up_proj_cw = " update fund_proj_plan_temp set follow_in = "+money_in;
						up_proj_cw = up_proj_cw + " ,follow_in_detail = '"+end_follow_in_detail+"' ";
						up_proj_cw = up_proj_cw + " ,net_follow =  "+net_follow;
						up_proj_cw = up_proj_cw + " where   proj_id = '"+proj_id+"' and doc_id = '"+doc_id+"'";
						up_proj_cw = up_proj_cw + "  and id = ( select min(id) from fund_proj_plan_temp where proj_id = '"+proj_id+"'  and doc_id = '"+doc_id+"'  and doc_id = '"+doc_id+"' )";
					}else{
						up_proj_market = " update fund_proj_plan_mark_temp set follow_in = "+money_in;
						up_proj_market = up_proj_market + " ,follow_in_detail = '"+end_follow_in_detail+"' ";
						up_proj_market = up_proj_market + " ,net_follow =  "+net_follow;
						up_proj_market = up_proj_market + " where   proj_id = '"+proj_id+"' and doc_id = '"+doc_id+"'";
						up_proj_market = up_proj_market + " and id = ( select min(id) from fund_proj_plan_mark_temp where proj_id = '"+proj_id+"'  and doc_id = '"+doc_id+"' ) ";
					}
					end_sql = up_proj_cw + ";" + up_proj_market;
				}
				if("contract".equals(model)){//合同
					String up_con_cw = "";
					String up_con_market = "";
					if("cw".equals(type)){
						up_con_cw = " update fund_contract_plan_temp set follow_in = "+money_in;
						up_con_cw = up_con_cw + " ,follow_in_detail = '"+end_follow_in_detail+"' ";
						up_con_cw = up_con_cw + " ,net_follow =  "+net_follow;
						up_con_cw = up_con_cw + " where   contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"'";
						up_con_cw = up_con_cw + "  and id = ( select min(id) from fund_contract_plan_temp where contract_id = '"+contract_id+"'  and doc_id = '"+doc_id+"' ) ";
					}else{
						up_con_market = " update fund_contract_plan_mark_temp set follow_in = "+money_in;
						up_con_market = up_con_market + " ,follow_in_detail = '"+end_follow_in_detail+"' ";
						up_con_market = up_con_market + " ,net_follow =  "+net_follow;
						up_con_market = up_con_market + " where   contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"'";
						up_con_market = up_con_market + "  and id = ( select min(id) from fund_contract_plan_mark_temp where contract_id = '"+contract_id+"'  and doc_id = '"+doc_id+"' ) ";
					}
					end_sql = up_con_cw + ";" + up_con_market;
				}
				//执行更新语句
				flag = db.executeUpdate(end_sql);
				System.out.println("现金流第一期加上管理费的修改语句-->"+end_sql);
			} catch (Exception e) {
				e.printStackTrace();
			}
			db.close();
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
		/**
		 * <p>数字格式化为6位小数。</p>
		 * @author common.jsp
		 * @param str
		 * @return
		 */
		public String formatNumberDoubleSix(double str){
			try
			{
				String temp_num=String.valueOf(str);
				if ((temp_num==null) || (temp_num.equals("")))
				{
					temp_num="";
				}
				else
				{
					java.text.DecimalFormat ft =  new java.text.DecimalFormat("###0.000000");
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
		/**
		 * <p>数字格式化为:X,XXX,XXX.XX。</p>
		 * @author common.jsp
		 * @param str
		 * @return
		 */
		public String formatNumberStr(String numstr,String style)  
		{
			try
			{
		        String temp_num=numstr;
		            if ((temp_num==null) || (temp_num.equals("")))
		        {
		        temp_num="";
		        }
		        else
		        {
		 java.text.DecimalFormat ft =  new java.text.DecimalFormat(style); 
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
		
		
		/**
		 * <p>租金变更对应的财务现金流操作方法。</p>
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
		public int zjbg_cw_xjl(List l_plan_date,List l_rent,String lease_money,
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
			String follow_in_detailTemp = "";//流入量清单拼装
			//拼装租金变更后的现金流
			for(int i = 0;i < l_rent.size();i++){
				follow_in_detailTemp = "";
				plan_date_list.add(l_plan_date.get(i).toString());//日期
				follow_in_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()));//流入
				follow_in_detailTemp = "租金:"+formatNumberStr(l_rent.get(i).toString(),"#,##0.00");
				follow_in_detail_list.add(follow_in_detailTemp);//流入清单
				follow_out_list.add("0.00");//流出
				follow_out_detail_list.add("");//流出清单
				net_follow_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()));//净流量
			}
			try {
				//每次插入之前需删除之前插入的数据
				flag = db.executeUpdate(del_sql);
				System.out.println("现金流数据插入前的删除语句==> :"+del_sql);
				ConditionOperating condition = new ConditionOperating();
				flag = condition.update_fund_contract_plan(contract_id,doc_id,plan_date_list,follow_in_list,follow_in_detail_list,follow_out_list,follow_out_detail_list,net_follow_list, creator, create_date,modificator, modify_date,tableName);
			} catch (Exception e) {
				e.printStackTrace();
			}
			db.close();
			return flag;
		}
		/**
		 * <p>租金变更对应的合同现金流操作方法。</p>
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
		public int zjbg_mark_xjl(List l_plan_date,List l_rent,String lease_money,
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
			String follow_in_detailTemp = "";//流入量清单拼装
			
			for(int i = 0;i < new_follow_in.size();i++){
				follow_in_detailTemp = "";
				plan_date_list.add(l_plan_date.get(i).toString());//日期
				follow_in_list.add(formatNumberDoubleTwo(new_follow_in.get(i).toString()));//流入量
				follow_in_detailTemp = "租金:"+formatNumberStr(new_follow_in.get(i).toString(),"#,##0.00");
				follow_in_detail_list.add(follow_in_detailTemp);//流入量清单
				follow_out_list.add(formatNumberDoubleTwo(new_follow_out.get(i).toString()));//流出量
				follow_out_detail_list.add(new_follow_out_detail.get(i).toString());//流出量清单
				net_follow_list.add(formatNumberDoubleTwo(new_net_follow.get(i).toString()));//净流量
			}
			try {
				//每次插入之前需删除之前插入的数据
				flag = db.executeUpdate(del_sql);
				System.out.println("现金流数据插入前的删除语句==> :"+del_sql);
				ConditionOperating condition = new ConditionOperating();
				flag = condition.update_fund_contract_plan(contract_id,doc_id,plan_date_list,follow_in_list,follow_in_detail_list,follow_out_list,follow_out_detail_list,net_follow_list, creator, create_date,modificator, modify_date,tableName);
			} catch (Exception e) {
				e.printStackTrace();
			}
			db.close();
			return flag;
		}
}
