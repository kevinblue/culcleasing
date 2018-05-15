<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %>
<%@page import="com.rent.calc.bg.AbnormalCalc"%>
<%@page import="com.rent.calc.bg.RentCalc"%> 

<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="cashFlow" scope="page" class="com.condition.CashFlow" />
<%@page import="com.rent.calc.update.CalcUtil"%>

<html>
<head>
<title>不规则测算处理页</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
	int flag = 0;
	String message = "";
	String sqlstr;
	ResultSet rs;
	String dqczy = (String) session.getAttribute("czyid");
	String czid = getStr(request.getParameter("czid") );
	String curr_date = getSystemDate(0);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//格式化时间
	String nowDateTime = sdf.format(new Date());//当前格式化之后的时间
	
	
	String temp = getStr(request.getParameter("temp") );//判断是否是项目还是合同
	String	contract_id = getStr(request.getParameter("contract_id") );
	String	proj_id = getStr(request.getParameter("proj_id") );
	String	measure_id = getStr(request.getParameter("measure_id") );
	
	
	//**********************************************************************************************************************
	//【2011-04-07 新增需求：生成数据前判断市场的最后一期升本本金是否大于0，大于0则不允许生成财务数据】
	//第一步：获取表名以及条件
		String table_name = "";
		String table_name_frpt = "";
		String where_s = "";
		if (temp.equals("proj_zjcs")){
			 table_name_frpt = " fund_rent_plan_proj_temp ";
			 table_name = " proj_condition_temp where  proj_id = '"+proj_id+"' and measure_id = '"+measure_id+"' ";//交易结构
			 where_s = " fund_rent_plan_proj_temp where   proj_id = '"+proj_id+"' and measure_id = '"+measure_id+"'  ";// 租金计划表
		}
		//合同
		if (temp.equals("contract_zjcs")){
			 table_name_frpt = " fund_rent_plan_temp ";
			 table_name = " contract_condition_temp where contract_id = '"+contract_id+"' and measure_id = '"+measure_id+"' ";//交易结构 
			 where_s = " fund_rent_plan_temp  where contract_id = '"+contract_id+"' and measure_id = '"+measure_id+"' ";//租金计划表
		}
		//查询最大一起偿还计划的本金余额
		String query_m = " select isnull(corpus_overage_market,0) as corpus_overage_market from  "+where_s;
		query_m = query_m + " and rent_list = (select max(rent_list) as rent_list from "+where_s+" ) ";
		rs = db.executeQuery(query_m);
		String corpus_overage_market_last = "";
		System.out.println("查询最大一起偿还计划的本金余额"+query_m);
		if(rs.next()){
			corpus_overage_market_last = rs.getString("corpus_overage_market");
		}
		
		System.out.println("Double.valueOf(corpus_overage_market_last) > Double.valueOf(0.00)---"+(Double.valueOf(corpus_overage_market_last) > Double.valueOf("0.00")));
		if(Double.valueOf(corpus_overage_market_last) > Double.valueOf("0.00")){
		%>
				<script>
					alert("最后一期市场本金余额为<%=corpus_overage_market_last%>大于0无法进行对应财务数据生成操作!");
					window.close();
					opener.opener.parent.location.reload();
				</script>
		<%
		}else{
			//**********************************************************************************************************************
			//第一步：生成数据必须的变量
			String ctbName = ""; // 交易结构表
		    String ftbName = "";// 租金计划表
			String contractColum = ""; // 合同号列名
			String contractId = "";// 合同号
			String docId = "";// 流程号
			String docColumn = "";// 流程号列名
			String table_where = "";
			String xjl_table_cw = "";//财务现金流的表名
			String xjl_table_mar = "";//市场现金流的表名
			String xjl_table_cw_where = "";//财务现金流的表名加条件
			String xjl_table_mar_where = "";//市场现金流的表名加条件
			String xjl_temp = "";//现金流第一期加上管理费用到的一个值
			//项目
			if (temp.equals("proj_zjcs")){
			     xjl_table_cw_where = " fund_proj_plan_temp where   proj_id = '"+proj_id+"' and doc_id = '"+measure_id+"' ";//财务现金流的表名加条件
			     xjl_table_mar_where = " fund_proj_plan_mark_temp  where  proj_id = '"+proj_id+"' and doc_id = '"+measure_id+"' ";//市场现金流的表名加条件
				 table_where = " proj_condition_temp where  proj_id = '"+proj_id+"' and measure_id = '"+measure_id+"'";
				 xjl_temp = "proj";
				 ctbName = "proj_condition_temp"; // 交易结构表
			     ftbName = "fund_rent_plan_proj_temp";// 租金计划表
				 contractColum = "proj_id"; // 项目号列名
				 contractId = proj_id;// 项目号
				 docId = measure_id;// 流程号
				 docColumn = "measure_id";// 流程号列名
				 xjl_table_cw = "fund_proj_plan_temp";
				 xjl_table_mar = "fund_proj_plan_mark_temp";
			}
			//合同
			if (temp.equals("contract_zjcs")){
			     xjl_table_cw_where = " fund_contract_plan_temp where   contract_id = '"+contract_id+"' and doc_id = '"+measure_id+"' ";//财务现金流的表名加条件
			     xjl_table_mar_where = " fund_contract_plan_mark_temp  where  contract_id = '"+contract_id+"' and doc_id = '"+measure_id+"' ";//市场现金流的表名加条件
				table_where = " contract_condition_temp where contract_id = '"+contract_id+"' and measure_id = '"+measure_id+"'";
				 xjl_temp = "contract";
				 ctbName = "contract_condition_temp"; // 交易结构表
			     ftbName = "fund_rent_plan_temp";// 租金计划表
				 contractColum = "contract_id"; // 合同号列名
				 contractId = contract_id;// 合同号
				 docId = measure_id;// 流程号
				 docColumn = "measure_id";// 流程号列名
				 xjl_table_cw = "fund_contract_plan_temp";
				 xjl_table_mar = "fund_contract_plan_mark_temp";
			}
			//第二步：写入值  ctbName, ftbName, contractColum,contractId, docId, docColumn
			AbnormalCalc abnormalCalc = new AbnormalCalc();
			abnormalCalc.setCtbName(ctbName);
		    abnormalCalc.setFtbName(ftbName);
			abnormalCalc.setContractColum(contractColum);
			abnormalCalc.setContractId(contractId);
			abnormalCalc.setDocId(docId);
			abnormalCalc.setDocColumn(docColumn);
			//第三步：查询交易结构
			sqlstr = " select * from  "+table_where;
			rs =  db.executeQuery(sqlstr);
			System.out.println("不规则测算--生成数据前查询交易结构-->"+sqlstr);
			String net_lease_money = "";//净融资额
			String caution_money = "";//租赁保证金
			//以下几个是现金流需要用到的数据
			String lease_money = "";//租赁本金
			String consulting_fee = "";//咨询费
			String handling_charge = "";//手续费
			String equip_amt = "";//申请金额(设备金额)
			String other_expenditure = "";//其他支出
			String return_amt = "";//厂商返利
			String other_income = "";//其他收入
			String first_payment = "";//首付款
			String start_date = "";//期租日
			String period_type = "";//付租类型
			String creator = "";//登记人
			String create_date = "";//登记日期
			String modificator = "";//修改人
			String modify_date = "";//修改日期
			String before_interest = "";//租前息
			String nominalprice = "";//期末残值
			String management_fee = "";//管理费
			while(rs.next()){
				net_lease_money = getZeroStr(rs.getString("net_lease_money"));
				caution_money = getZeroStr(rs.getString("caution_money"));
				
				 lease_money = getZeroStr(rs.getString("lease_money"));//租赁本金
			 	 consulting_fee = getZeroStr(rs.getString("consulting_fee"));//咨询费
				 handling_charge = getZeroStr(rs.getString("handling_charge"));//手续费
				 equip_amt = getZeroStr(rs.getString("equip_amt"));//申请金额(设备金额)
				 other_expenditure = getZeroStr(rs.getString("other_expenditure"));//其他支出
				 return_amt = getZeroStr(rs.getString("return_amt"));//厂商返利
				 other_income = getZeroStr(rs.getString("other_income"));//其他收入
				 first_payment = getZeroStr(rs.getString("first_payment"));//首付款
				 start_date = getDBStr(getStr(rs.getString("start_date")));//期租日
				 period_type = getZeroStr(rs.getString("period_type"));//付租类型
				 creator =  getDBStr(getStr(rs.getString("creator")));//登记人
				 create_date =  getDBStr(getStr(rs.getString("create_date")));//登记日期
				 modificator =  getDBStr(getStr(rs.getString("modificator")));//修改人
				 modify_date =  getDBStr(getStr(rs.getString("modify_date")));//修改日期
				 before_interest = getZeroStr(rs.getString("before_interest"));//租前息
				 nominalprice = getZeroStr(rs.getString("nominalprice"));//期末残值
				 management_fee = getZeroStr(rs.getString("management_fee"));//管理费
			}
			rs.close();
			String money = String.valueOf(Double.valueOf(caution_money) + Double.valueOf(net_lease_money));
			//第四步：进行数据的生成操作
			//  @param markIrrValue  市场现金流交易结构值 (净融资额)
			//  @param finIrrValue　财务现金流交易结构值  (租赁保证金+净融资额)
			//  @param finCalcValue 财务租金计划测算值　 (租赁保证金+净融资额)
			Hashtable  ht =  abnormalCalc.getPlanInfo(net_lease_money,  money, money);
			//第五步：取出租金和日期结果集
			List date_list = (List) ht.get("l_date");//日期
			List rent_list = (List) ht.get("rent_list");//租金
			
			//第六步： 现金流加入保证金抵扣（得到保证金抵扣租金List）,参数：租金List，保证金
			//财务现金流用到的租金list
			List l_rent_new = CalcUtil.getNewList(rent_list);//2010-11-30修改 财务现金流用到
			RentCalc rent = new RentCalc();
			//市场现金流用
			List l_RentDetails = rent.getRentDetails(rent_list,caution_money);//得到保证金抵扣后的流入流出明细值
			List new_rent = rent.getRentCautNew(rent_list,caution_money);//得到保证金抵扣租金List
			
			//第七步：生成新的现金流
			//每次插入之前需删除之前插入的数据 【2010-7-30修改，增加项目的现金流表，不再和合同的现金流表共用一张表了】
			//财务现金流表
			String del_sql = " delete  "+xjl_table_cw_where;
			flag = cashFlow.execProjORcontract_xjl(date_list,l_rent_new,lease_money,
						 consulting_fee, handling_charge, equip_amt,
						 other_expenditure, caution_money, return_amt,
						 other_income, first_payment, start_date,
						 period_type, proj_id, measure_id,
						 creator, create_date, modificator, modify_date,del_sql,contract_id,"plan_irr",
						 xjl_table_cw,before_interest);//财务现金流不需要进行保证金抵扣 
			//	System.out.println("2                                                        "+flag);			 
			//市场现金流 
			String new_del_sql = " delete  "+xjl_table_mar_where;//xjl_table_mar+" where proj_id = '"+proj_id+"' and doc_id = '"+measure_id+"'";
			flag = cashFlow.execProjORcontract_xjl_mark(date_list,new_rent,lease_money,
						 consulting_fee, handling_charge, equip_amt,
						 other_expenditure, caution_money, return_amt,
						 other_income, first_payment, start_date,
						 period_type, proj_id, measure_id,
						 creator, create_date, modificator, modify_date,new_del_sql,contract_id,"market_irr",
						 xjl_table_mar,before_interest,l_RentDetails);//
			 //	System.out.println("3                                                        "+flag);
			 	//现金流补充代码【2010-08-06】
				if(!nominalprice.equals("")){//
					double t_num = Double.valueOf(nominalprice); 
					if(t_num > 0){//留购价大于0才进行此操作
						//财务现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值
						String  query_count_cw = " select * from  "+xjl_table_cw_where;
						query_count_cw = query_count_cw + " and plan_date = ( select max(plan_date) from  "+xjl_table_cw_where+" ) ";
						query_count_cw = query_count_cw + " and id = ( select max(id) from "+xjl_table_cw_where+" ) ";
						System.out.println("查询项目财务现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值 ==> "+query_count_cw);
						//调用通用方法,进行‘留购价’的修改操作
						flag = cashFlow.update_xjl_cw(query_count_cw, nominalprice,xjl_table_cw,proj_id,contract_id);//财务
						//System.out.println("4                                                        "+flag);			
						//市场现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值
						String  query_count_market = " select * from  "+xjl_table_mar_where;
						query_count_market = query_count_market + " and plan_date = ( select max(plan_date) from "+xjl_table_mar_where+" ) ";
						query_count_market = query_count_market + " and id = ( select max(id) from "+xjl_table_mar_where+"  ) ";
						System.out.println("查询项目市场现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值 ==> "+query_count_cw);
						//调用通用方法
						flag = cashFlow.update_xjl_market(query_count_market, nominalprice,xjl_table_mar,proj_id,contract_id);//市场
						//System.out.println("5                                                       "+flag);
					}
				}
				//需求增加,现金流补充代码【2010-11-30】 现金流第一期加上管理费，加入所有流入中
				if(!"".equals(management_fee) && management_fee != null && (!"0.00".equals(management_fee) && !"0".equals(management_fee))){
					//follow_in,follow_in_detail,follow_out,follow_out_detail,net_follow
					//查询财务现金流第一期的数据
					String  query_min_cw = " select * from  "+xjl_table_cw_where;//fund_proj_plan_temp where   proj_id = '"+proj_id+"' and doc_id = '"+measure_id+"'
						query_min_cw = query_min_cw + " and id = ( select min(id) from "+xjl_table_cw_where+" ) ";
					System.out.println("查询项目财务现金流最小一期的值 ==> "+query_min_cw);
					//调用公用方法将管理费加到所有流入	
					//参数:String sql,String management_fee,String proj_id,String contract_id,String doc_id,String model
					flag = cashFlow.updat_xjl(query_min_cw,management_fee,proj_id,"",measure_id,xjl_temp,"cw");
					//查询市场第一期的数据
					String  query_min_market = " select * from "+xjl_table_mar_where;// fund_proj_plan_mark_temp  where  proj_id = '"+proj_id+"' and doc_id = '"+measure_id+"'
						query_min_market = query_min_market + " and id = ( select min(id) from "+xjl_table_mar_where+" ) ";
					System.out.println("查询项目市场现金流最小一期的值 ==> "+query_min_market);
					//调用公用方法将管理费加到所有流入	
					flag = cashFlow.updat_xjl(query_min_market,management_fee,proj_id,"",measure_id,xjl_temp,"market");
				}
				//**********************************************************************************************************************
				//【2011-04-07 新增需求：将市场的本金余额重新测算一次，每期的剩余本金=上一期剩余本金减去本期的本金】
				//第一步见最上方： 
				//第二步：先查询总的剩余本金是多少 交易结构中的租赁本金
				String q_condition = " select isnull(lease_money,0) as lease_money from  "+table_name;
				String lease_money_t = "";
				System.out.println("q_condition---->"+q_condition);
				ResultSet rs_c = db.executeQuery(q_condition);
				if(rs_c.next()){
					lease_money_t = rs_c.getString("lease_money");
				}
				//第三步：查询租金偿还计划表中的每期的本金 
				String q_cm = " select id,isnull(corpus_market,0) as corpus_market from  "+where_s;
				System.out.println("q_cm---->"+q_cm);
				String corpus_market = "";//市场本金
				String corpus_market_id = "";//市场本金修改对应的逐渐id
				rs_c = db.executeQuery(q_cm);
				List corpus_market_l = new ArrayList();
				List id_l = new ArrayList();
				while(rs_c.next()){
					corpus_market = rs_c.getString("corpus_market");
					corpus_market_id = rs_c.getString("id");
					corpus_market_l.add(corpus_market);
					id_l.add(corpus_market_id);
				}
				rs_c.close();
				//第四步：调用后台方法重新计算市场的剩余本金
				List corpusOvergeMarket_l = rent.getCorpusOvergeList(lease_money_t,corpus_market_l);
				//第五步：循环修改条件：市场本金对应的id进行修改所有市场本金的操作
				StringBuffer uSql =  new StringBuffer();
				for(int i = 0 ;i < id_l.size();i++){
					uSql.append(" update  ")
					    .append(table_name_frpt)
					    .append(" set corpus_overage_market = '"+corpusOvergeMarket_l.get(i)+"' ")
					    .append(" where id =  "+id_l.get(i))
					    .append(" ");
				}
				db.executeUpdate(uSql.toString());
				System.out.println("修改市场剩余本金---->"+uSql);
				//**********************************************************************************************************************
		
		System.out.println("flag---------------->"+flag);
			if(flag != 0){
		%>
				<script>
					//alert(opener.opener.rate_float_type.value);
					//alert("生成数据成功!");
					//window.close();
					//opener.parent.refreshOpener();
					//opener.opener.parent.location.reload();
					
					window.close();
					opener.alert("成功!");
					//opener.location.reload();//刷新list页面
					window.opener.parent.parent.location.reload();
					//opener.opener.window.navigate('../zjcs/main.jsp');
					//opener.parent.parent.opener.parent.location.reload();
				</script>
		<%
			}else{
		%>
				<script>
					alert("生成数据失败!");
					window.close();
					opener.opener.parent.location.reload();
				</script>
		<%
			}
	}
	db.close();
%>