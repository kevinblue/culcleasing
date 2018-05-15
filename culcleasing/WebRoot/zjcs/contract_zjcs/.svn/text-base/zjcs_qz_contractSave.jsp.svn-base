<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<%@page import="com.rent.calc.bg.*"%>
<%@page import="com.rent.calc.bg.CommUtil"%>
<%@page import="com.rent.calc.update.CalcUtil"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="condition" scope="page" class="com.condition.ConditionOperating" />
<jsp:useBean id="cashFlow" scope="page" class="com.condition.CashFlow" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同交易结构 - 起租租金测算数据操作页</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
</head>
<BODY>
<%
	String savaType = getStr(request.getParameter("savaType"));
	StringBuffer sql = new StringBuffer();
	ResultSet rs = null;
	int flag = 0;
	String message = "";
	//接参
    String doc_id = getStr(request.getParameter("doc_id")); //文档编号 measure_id
    String contract_id = getStr(request.getParameter("contract_id")); //合同编号
    String proj_id = getStr(request.getParameter("proj_id")); //项目编号
	String income_day = getStr(request.getParameter("income_day"));//每月偿付日
	String start_date = getStr(request.getParameter("start_date"));//起租日
	String year_rate = getStr(request.getParameter("year_rate"));//租赁年利率
    
	String currency = "";//货币类型
	String equip_amt = "";//申请金额(设备金额)
	String first_payment = "";//首付款
	String lease_money = "";//租赁本金
	String caution_money = "";//租赁保证金
	String net_lease_money = "";//净融资额
	String handling_charge = "";//手续费（经销商）
	String income_number_year = "";//付租方式
	String lease_term = "";//租赁期限(月)
	String income_number = "";//还租次数
	String nominalprice = "";//期末残值(或名义留购价)
	String period_type = "";//付租类型 period_type
	String return_amt = "";//厂商返利
	String rate_float_type = "";//利率浮动类型
	String before_interest = "";//租前息
	String rate_adjustment_modulus = "";//利率调整系数
	String pena_rate = "";//罚息利率
	String plan_irr = "";//plan_irr(内部收益率)
	String measure_type = "";//租金计算方法
	String other_income = "";//其他收入
	String other_expenditure = "";//其他支出
	String creator = "";//登记人
	String create_date = "";//登记时间
    String modify_date = "";//更新日期
	String modificator = "";//更新人
	String rate_float_amt = "";//利率调整值
	String consulting_fee = "";//咨询费 【注：新加字段】
	String rentScale = "";//圆整到
	
	String liugprice = "";//留购价款 【注：新加字段 2010-09-21 原本的留购价改成残值】
	String delay = "";//【新增字段 2010-10-20】 延迟期数
	String grace = "";//【新增字段 2010-10-20】宽限期数
	String management_fee = "";//【新增字段 2010-11-11】管理费
		
	String sumMon = "";//=(isnull(net_lease_money,0) + isnull(caution_money,0))*-1
	if(rate_float_amt.equals("") || rate_float_amt == null){
		rate_float_amt = "0";
	}
	/* 和同交易结构修改操作 */
	if(savaType.equals("mod")){
	   //拼装修改SQL语句 主键是项目编号 contract_id
	   sql.append("UPDATE contract_condition_temp ")
		  .append("SET income_day = '"+income_day+"' ")
	      .append(",start_date = '"+start_date+"' ")
	      .append(",year_rate = '"+year_rate+"' ")//【2011-05-05需求修改:开放起租的“租赁利率”修改权限，并添加着重符号（不规则时不允许起租进行租赁年利率修改）】
	 	  .append("WHERE contract_id = '"+contract_id+"' ")
	 	  .append("  and measure_id = '"+doc_id+"' ");//编号
		System.out.println("==================================================>修改SQL-->   "+sql.toString());
		flag = db.executeUpdate(sql.toString());
		message = "修改合同交易结构";
	}
	/* 合同交易结构删除操作 --暂时未验证该方法的正确性 */
	if(savaType.equals("del")){
		//根据主键‘项目编号’进行数据删除操作
		sql.append("delete from contract_condition_temp where contract_id = '"+contract_id+"'  and measure_id = '"+doc_id+"' ");
		flag = db.executeUpdate(sql.toString());
//System.out.println("删除SQL-->   "+sql.toString());
		message = "删除合同交易结构";
	}
	String query_sql = " select (isnull(net_lease_money,0) + isnull(caution_money,0)) as sumMon,* from contract_condition_temp  where contract_id = '"+contract_id+"'  and measure_id = '"+doc_id+"' ";
	rs = db.executeQuery(query_sql);
//System.out.println("====> : "+query_sql);
	while(rs.next()){
		 currency = getStr(rs.getString("currency"));//货币类型
		 equip_amt = formatNumberDoubleTwo(getZeroStr(getStr(rs.getString("equip_amt"))));//申请金额(设备金额)
		 first_payment = formatNumberDoubleTwo(getZeroStr(getStr(rs.getString("first_payment"))));//首付款
		 lease_money = formatNumberDoubleTwo(getZeroStr(getStr(rs.getString("lease_money"))));//租赁本金
		 caution_money = formatNumberDoubleTwo(getZeroStr(getStr(rs.getString("caution_money"))));//租赁保证金
		 net_lease_money = formatNumberDoubleTwo(getZeroStr(getStr(rs.getString("net_lease_money"))));//净融资额
		 handling_charge = formatNumberDoubleTwo(getZeroStr(getStr(rs.getString("handling_charge"))));//手续费（经销商）
		 income_number_year = getStr(rs.getString("income_number_year"));//付租方式
		 lease_term = getStr(rs.getString("lease_term"));//租赁期限(月)
		 income_number = getZeroStr(getStr(rs.getString("income_number")));//还租次数
		 nominalprice = formatNumberDoubleTwo(getZeroStr(getStr(rs.getString("nominalprice"))));//期末残值(或名义留购价)
		 period_type = getStr(rs.getString("period_type"));//付租类型 period_type
		 return_amt = formatNumberDoubleTwo(getZeroStr(getStr(rs.getString("return_amt"))));//厂商返利
		 year_rate = getStr(rs.getString("year_rate"));//租赁年利率
		 rate_float_type = getStr(rs.getString("rate_float_type"));//利率浮动类型
		 before_interest = formatNumberDoubleTwo(getZeroStr(getStr(rs.getString("before_interest"))));//租前息
		 rate_adjustment_modulus = getStr(rs.getString("rate_adjustment_modulus"));//利率调整系数
		 pena_rate = getZeroStr(getStr(rs.getString("pena_rate")));//罚息利率
		 plan_irr = getZeroStr(getStr(rs.getString("plan_irr")));//plan_irr(内部收益率)
		 measure_type = getStr(rs.getString("measure_type"));//租金计算方法
		 other_income = formatNumberDoubleTwo(getZeroStr(getStr(rs.getString("other_income"))));//其他收入
		 other_expenditure = formatNumberDoubleTwo(getZeroStr(getStr(rs.getString("other_expenditure"))));//其他支出
		 creator = getStr(rs.getString("creator"));//登记人
		 create_date = getStr(rs.getString("create_date"));//登记时间
	     modify_date = getStr(rs.getString("modify_date"));//更新日期
		 modificator = getStr(rs.getString("modificator"));//更新人
		 rate_float_amt = getZeroStr(getStr(rs.getString("rate_float_amt")));//利率调整值
		 consulting_fee = formatNumberDoubleTwo(getZeroStr(getStr(rs.getString("consulting_fee"))));//咨询费 【注：新加字段】
		 rentScale = getDBStr(getStr(rs.getString("rentScale")));//圆整到
		 sumMon = formatNumberDoubleTwo(getStr(rs.getString("sumMon")));//
		 liugprice = getZeroStr(getStr(rs.getString("liugprice")));//留购价款 【注：新加字段 2010-09-21 原本的留购价改成残值】
		 delay = getZeroStr(getStr(rs.getString("delay")));//【新增字段 2010-10-20】36 延迟期数
		 grace = getZeroStr(getStr(rs.getString("grace")));//【新增字段 2010-10-20】37 宽限期数
		 management_fee = getZeroStr(getStr(rs.getString("management_fee")));//【新增字段 2010-11-11】38管理费
	}
 	String old_start_date = start_date;		//用于现金流
  	
//*****************************************************************************************************	
//***                                  租金测算                                                             ****
//*****************************************************************************************************	
 	start_date = start_date.substring(0,8)+income_day;
 	
 	//【2011-04-13增加需求，不规则的时候不进行租金测算操作，只是进行修改日期的操作】
 	if("0".equals(measure_type)){//等额租金|等额本金|不规则","1|2|0
 		//先查询每期的偿还日期
 		String sql_q = "select * from  fund_rent_plan_temp where contract_id = '"+contract_id+"'  and measure_id = '"+doc_id+"' ";
 		rs = db.executeQuery(sql_q);
 		StringBuffer usql = new StringBuffer();
 		while(rs.next()){
 			String plan_date = getDBDateStr(rs.getString("plan_date"));
 			String key = rs.getString("id");
 			String new_date = plan_date.substring(0,8)+income_day;
 			usql.append(" update  fund_rent_plan_temp  ")
 			    .append(" set plan_date = '"+new_date+"'  ")
 			    .append(" where id = "+key+" ;");
	 	}
	 	System.out.println("不规则时候修改SQL-->   "+usql.toString());
	 	flag = db.executeUpdate(usql.toString());
 	}else{
	 	//
	 	String sql_q = "select * from  fund_rent_plan_temp where contract_id = '"+contract_id+"'  and measure_id = '"+doc_id+"' ";
	 	rs = db.executeQuery(sql_q);
	 	List l_rent = new ArrayList();//租金
	 	List l_corpus = new ArrayList();//本金
	 	List l_interest = new ArrayList();//利息
	 	List l_corpus_overage = new ArrayList();//剩余本金
	 	List l_corpus_market = new ArrayList();
		List l_interest_market = new ArrayList();
		List l_corpus_overage_market = new ArrayList();
	 	while(rs.next()){
	 		l_rent.add(getZeroStr(getStr(rs.getString("rent"))));
	 		l_corpus.add(getZeroStr(getStr(rs.getString("corpus"))));
	 		l_interest.add(getZeroStr(getStr(rs.getString("interest"))));
	 		l_corpus_overage.add(getZeroStr(getStr(rs.getString("corpus_overage"))));
	 		l_corpus_market.add(getZeroStr(getStr(rs.getString("corpus_market"))));
	 		l_interest_market.add(getZeroStr(getStr(rs.getString("interest_market"))));
	 		l_corpus_overage_market.add(getZeroStr(getStr(rs.getString("corpus_overage_market"))));
	 	}
	 	rs.close();
	 	//RentCalc rentCalc = new RentCalc();
	 	//rentCalc.setPlan_date(start_date);//设置新的期租日
		//rentCalc.setPeriod_type(period_type);//期初期末
		//rentCalc.setLease_interval(income_number_year);//付租方式 租金间隔
		//List l_plan_date = rentCalc.getPlanDateList(l_rent, income_number_year);///?????
		
		//2010-11-30修改  加入了延迟和宽限的判断操作
	 	List l_rent_new = CalcUtil.getNewList(l_rent);//2010-11-30修改 财务现金流用到
		CommUtil commUtil = new CommUtil(); 
		List l_plan_date = commUtil.getPlanDateList(l_rent,period_type,delay,income_number_year,start_date);
		List new_rent_1 = commUtil.getDelayRent(l_rent, delay);//延迟情况下获取新的市场租金,用于现金流的拼装
		
		
			//租金测算表  fund_rent_plan_temp //测算编号 等于 文档编号
			String sqlstr = "delete from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
			db.executeUpdate(sqlstr);
			for(int i=0;i<l_rent.size();i++){
			//插入字段顺序:文档编号(测算编号),合同编号,回笼状态,租金,本金,租息,本金余额,年利率
				sqlstr="insert into fund_rent_plan_temp"+
				       "(measure_id,contract_id,"+
				       "rent_list,plan_date,plan_status,rent,corpus,"+
				       "interest,corpus_overage,year_rate,corpus_market,interest_market,corpus_overage_market) "+
				       "select '"+doc_id+"','"+contract_id+"',"+(i+1)+","+
				       "'"+l_plan_date.get(i)+"','未回笼',"+l_rent.get(i)+","+
				       ""+l_corpus.get(i)+","+l_interest.get(i)+","+
				       ""+l_corpus_overage.get(i)+","+year_rate+","+
				       l_corpus_market.get(i)+","+l_interest_market.get(i)+","+l_corpus_overage_market.get(i)+" ;";
				System.out.println(i+"^^^^^^^^^^^^^^^合同租金测算添加sqlstr2====="+sqlstr);
				System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
				db.executeUpdate(sqlstr);
			}
		
		RentCalc rent = new RentCalc();
		//【修改日：2010-07-26】现金流加入保证金抵扣（得到保证金抵扣租金List）,参数：租金List，保证金
		List l_RentDetails = rent.getRentDetails(new_rent_1,caution_money);
		List new_rent = rent.getRentCautNew(new_rent_1,caution_money);
	
		//System.out.println("^^^^^^^^^^^^^^^flag====="+flag);	
		//************************************************************************************************
		//                                            现金流
		//************************************************************************************************
		if(Integer.parseInt(delay) > 0){//延迟期大于0  2010-12-01新增
			l_plan_date = commUtil.getDelayPlanDateList(l_rent,period_type,delay,income_number_year,start_date);
			l_rent_new = commUtil.getDelayRent(l_rent_new, delay);//延迟情况下获取新的财务租金,用于现金流的拼装
		}
		//每次插入之前需删除之前插入的数据
		String del_sql = " delete  fund_contract_plan_temp where contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"'";
		flag = cashFlow.execProjORcontract_xjl(l_plan_date,l_rent_new,lease_money,
					 consulting_fee, handling_charge, equip_amt,
					 other_expenditure, caution_money, return_amt,
					 other_income, first_payment, old_start_date,
					 period_type, proj_id, doc_id,
					 creator, create_date, modificator, modify_date,del_sql,contract_id,"plan_irr",
					 "fund_contract_plan_temp",before_interest);//
		//市场现金流 
		String new_del_sql = " delete  fund_contract_plan_mark_temp where contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"'";
		flag = cashFlow.execProjORcontract_xjl_mark(l_plan_date,new_rent,lease_money,
					 consulting_fee, handling_charge, equip_amt,
					 other_expenditure, caution_money, return_amt,
					 other_income, first_payment, old_start_date,
					 period_type, proj_id, doc_id,
					 creator, create_date, modificator, modify_date,new_del_sql,contract_id,"market_irr",
					 "fund_contract_plan_mark_temp",before_interest,l_RentDetails);//
			
		//现金流补充代码【2010-08-06】
		if(!nominalprice.equals("")){//
			double t_num = Double.valueOf(nominalprice); 
			if(t_num > 0){//留购价大于0才进行此操作
			
				//财务现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值
				String  query_count_cw = " select * from fund_contract_plan_temp where   contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"' ";
				query_count_cw = query_count_cw + " and plan_date = ( select max(plan_date) from fund_contract_plan_temp where contract_id = '"+contract_id+"'  and doc_id = '"+doc_id+"' ) ";
				query_count_cw = query_count_cw + " and id = ( select max(id) from fund_contract_plan_temp where contract_id = '"+contract_id+"'  and doc_id = '"+doc_id+"' ) ";
				System.out.println("查询合同起租财务现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值 ==> "+query_count_cw);
				//调用通用方法,进行‘留购价’的修改操作
				flag = cashFlow.update_xjl_cw(query_count_cw, nominalprice,"fund_contract_plan_temp","",contract_id);//财务
				
				//市场现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值
				String  query_count_market = " select * from fund_contract_plan_mark_temp  where  contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"'";
				query_count_market = query_count_market + " and plan_date = ( select max(plan_date) from fund_contract_plan_mark_temp where contract_id = '"+contract_id+"'  and doc_id = '"+doc_id+"' ) ";
				query_count_market = query_count_market + " and id = ( select max(id) from fund_contract_plan_mark_temp where contract_id = '"+contract_id+"'  and doc_id = '"+doc_id+"' ) ";
				System.out.println("查询合同起租市场现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值 ==> "+query_count_cw);
				//调用通用方法
				flag = cashFlow.update_xjl_market(query_count_market, nominalprice,"fund_contract_plan_mark_temp","",contract_id);//市场
			}
		}
		//需求增加,现金流补充代码【2010-11-30】 现金流第一期加上管理费，加入所有流入中
		if(!"".equals(management_fee) && management_fee != null && (!"0.00".equals(management_fee) && !"0".equals(management_fee))){
			//follow_in,follow_in_detail,follow_out,follow_out_detail,net_follow
			//查询财务现金流第一期的数据
			String  query_min_cw = " select * from fund_contract_plan_temp where   contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"' ";
				//query_min_cw = query_min_cw + " and plan_date = ( select max(plan_date) from fund_contract_plan_temp where contract_id = '"+contract_id+"'  and doc_id = '"+doc_id+"' ) ";
				query_min_cw = query_min_cw + " and id = ( select max(id) from fund_contract_plan_temp where contract_id = '"+contract_id+"'  and doc_id = '"+doc_id+"' ) ";
			System.out.println("查询合同财务现金流最小一期的值 ==> "+query_min_cw);
			//调用公用方法将管理费加到所有流入	
			//参数:String sql,String management_fee,String proj_id,String contract_id,String doc_id,String model
			flag = cashFlow.updat_xjl(query_min_cw,management_fee,proj_id,contract_id,doc_id,"contract","cw");
			//查询市场第一期的数据
			String  query_min_market = " select * from fund_contract_plan_mark_temp  where  contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"'";
				//query_min_market = query_min_market + " and plan_date = ( select max(plan_date) from fund_contract_plan_mark_temp where contract_id = '"+contract_id+"'  and doc_id = '"+doc_id+"' ) ";
				query_min_market = query_min_market + " and id = ( select max(id) from fund_contract_plan_mark_temp where contract_id = '"+contract_id+"'  and doc_id = '"+doc_id+"' ) ";
			System.out.println("查询合同市场现金流最小一期的值 ==> "+query_min_market);
			//调用公用方法将管理费加到所有流入	
			flag = cashFlow.updat_xjl(query_min_market,management_fee,proj_id,contract_id,doc_id,"contract","market");
		}
 	}//不规则判断else结束
	
	db.close();

// ***********************************************************
	if(flag > 0){
		String hrefStr="";
		if(savaType.equals("del")){//删除成功
%>
        <script>
		//opener.window.location.href = "frkh_list.jsp";
		alert("<%=message%>成功!");
		this.close();
		</script>
<%
		}else{//修改添加成功
%>
        <script>
			alert("合同租金测算成功!");
			opener.parent.location.reload();
			//opener.location.reload();
			window.close();
		</script>
<%
		}
	}else{
%>
        <script>
			alert("合同租金测算失败!");
			opener.location.reload();
			this.close();
		</script>
<%	
	}
	db.close();
%>