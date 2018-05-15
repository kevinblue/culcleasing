<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<%@page import="com.rent.calc.bg.* "%>
<%@page import="com.rent.calc.update.CalcUtil"%>
<%@page import="com.rent.calc.bg.CommUtil"%>
<%@page import="com.rent.calc.settlaw.SettledLaw"%>
<%@page import="com.condition.Rent_init"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="condition" scope="page" class="com.condition.ConditionOperating" />
<jsp:useBean id="cashFlow" scope="page" class="com.condition.CashFlow" />
<jsp:useBean id="tools" scope="page" class="com.Tools" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同交易结构 - 租金测算数据操作页</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
</head>

<BODY>
<%
	String savaType = getStr(request.getParameter("savaType"));
	//System.out.println("savaType+-------------------------------->"+savaType);
	StringBuffer sql = new StringBuffer();
	ResultSet rs = null;
	int flag = 0;
	String message = "";
	    String doc_id = getStr(request.getParameter("doc_id")); //文档编号 measure_id
	    String contract_id = getStr(request.getParameter("contract_id")); //合同编号
		//接参
	    String proj_id = getStr(request.getParameter("proj_id")); //项目编号
		String currency = getStr(request.getParameter("currency"));//货币类型
		String equip_amt = getZeroStr(getStr(request.getParameter("equip_amt")));//申请金额(设备金额)
		String first_payment = getZeroStr(getStr(request.getParameter("first_payment")));//首付款
		String lease_money = getZeroStr(getStr(request.getParameter("lease_money")));//租赁本金
		String caution_money = getZeroStr(getStr(request.getParameter("caution_money")));//租赁保证金
		String net_lease_money = getZeroStr(getStr(request.getParameter("net_lease_money")));//净融资额
		String handling_charge = getZeroStr(getStr(request.getParameter("handling_charge")));//手续费（经销商）
		String income_number_year = getStr(request.getParameter("income_number_year"));//付租方式
		String lease_term = getStr(request.getParameter("lease_term"));//租赁期限(月)
		String income_number = getZeroStr(getStr(request.getParameter("income_number")));//还租次数
		String nominalprice = getZeroStr(getStr(request.getParameter("nominalprice")));//期末残值(或名义留购价) 2010-09-21 名称改成资产余值
		String period_type = getStr(request.getParameter("period_type"));//付租类型 period_type
		String return_amt = getZeroStr(getStr(request.getParameter("return_amt")));//厂商返利
		String year_rate = getStr(request.getParameter("year_rate"));//租赁年利率
		String rate_float_type = getStr(request.getParameter("rate_float_type"));//利率浮动类型
		String before_interest = getZeroStr(getStr(request.getParameter("before_interest")));//租前息
		String rate_adjustment_modulus = getStr(request.getParameter("rate_adjustment_modulus"));//利率调整系数
		String pena_rate = getZeroStr(getStr(request.getParameter("pena_rate")));//罚息利率
		String income_day = getStr(request.getParameter("income_day"));//每月偿付日
		String start_date = getStr(request.getParameter("start_date"));//起租日
		String plan_irr = getZeroStr(getStr(request.getParameter("plan_irr")));//plan_irr(内部收益率)
		String measure_type = getStr(request.getParameter("measure_type"));//租金计算方法
		String other_income = getZeroStr(getStr(request.getParameter("other_income")));//其他收入
		String other_expenditure = getZeroStr(getStr(request.getParameter("other_expenditure")));//其他支出
		String creator = getStr(request.getParameter("creator"));//登记人
		String create_date = getStr(request.getParameter("create_date"));//登记时间
	    String modify_date = getStr(request.getParameter("modify_date"));//更新日期
		String modificator = getStr(request.getParameter("modificator"));//更新人
		String rate_float_amt = getZeroStr(getStr(request.getParameter("rate_float_amt")));//利率调整值
		String consulting_fee = getZeroStr(getStr(request.getParameter("consulting_fee")));//咨询费 【注：新加字段】
		String lease_money_proportion = getZeroStr(getStr(request.getParameter("lease_money_proportion")));//净融资额比例 【注：新加字段 2010-07-27】
		String accountPrincipal = getZeroStr(getStr(request.getParameter("accountPrincipal")));//会计核算本金 【注：新加字段 2010-08-06】
		String rentScale = getZeroStr(getStr(request.getParameter("rentScale")));//圆整到 【注：新加字段 2010-08-20】
		String liugprice = getZeroStr(getStr(request.getParameter("liugprice")));//留购价款 【注：新加字段 2010-09-21 原本的留购价改成残值】
		String delay = getZeroStr(getStr(request.getParameter("delay")));//【新增字段 2010-10-20】36 延迟期数
		String grace = getZeroStr(getStr(request.getParameter("grace")));//【新增字段 2010-10-20】37 宽限期数
		String management_fee = getZeroStr(getStr(request.getParameter("management_fee")));//【新增字段 2010-11-11】38管理费
		String ajdustStyle = getDBStr(getStr(request.getParameter("ajdustStyle")));//调息方式【注：新增字段 2010-11-23】  
		String amt_return = getDBStr(getStr(request.getParameter("amt_return")));//设备是否退还【注：新增字段 2011-01-10】   		
		String old_start_date = start_date;	//用于现金流
		if(rate_float_amt.equals("") || rate_float_amt == null){
			rate_float_amt = "0";
		}
		String market_irr = getZeroStr(getStr(request.getParameter("market_irr")));//市场IRR 【注：新加字段】
		
		
	//SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//格式化时间
	//String nowTime=sdf.format(new Date());//当前格式化之后的时间
	//System.out.println("savaType+++++++++++++++++++&"+savaType+"&++++++++++++++++++++++++++++++++++++++++");
	/* 拟商务条件添加操作 */
	if(savaType.equals("add")){
		//拼装添加‘合同交易结构’sql语句
		sql.append("INSERT INTO contract_condition_temp (contract_id ,currency ,equip_amt ,lease_money ,lease_term")
           .append(",income_number_year,income_number,year_rate,rate_float_type,period_type,income_day")
           .append(",start_date,first_payment,caution_money,handling_charge,return_amt,nominalprice")
           .append(",pena_rate,net_lease_money,plan_irr,measure_type,creator,create_date")
           .append(",modificator,modify_date,before_interest,rate_adjustment_modulus,other_income ")
           .append(" ,other_expenditure,measure_id,rate_float_amt,consulting_fee ")
           .append(" ,market_irr ")//新增字段 市场irr
           .append(" ,lease_money_proportion ")//净融资额比例 【注：新加字段 2010-07-27】
           .append(" ,accountPrincipal ")//会计核算本金 【注：新加字段 2010-08-06】
           .append(" ,rentScale ")//圆整到 【注：新加字段 2010-08-20】
           .append(" ,liugprice ")//留购价 【注：新加字段 2010-09-21 原本的留购价改成残值】
           .append(" ,delay ")//延迟期数 【注：新加字段 2010-10-20】
           .append(" ,grace ")//宽限期数 【注：新加字段 2010-10-20】
           .append(" ,management_fee  ")//管理费【新增字段 2010-11-11】
           .append(" ,ajdustStyle  ")// 
           .append(" ,amt_return  ")//设备是否退还【注：新增字段 2011-01-10】   
           .append(" )")
     	   .append(" VALUES ('"+contract_id+"','"+currency+"','"+equip_amt+"','"+lease_money+"'")
           .append(" ,'"+lease_term+"','"+income_number_year+"','"+income_number+"','"+year_rate+"'")
           .append(" ,'"+rate_float_type+"','"+period_type+"','"+income_day+"','"+start_date+"'")
           .append(" ,'"+first_payment+"','"+caution_money+"','"+handling_charge+"','"+return_amt+"'")
           .append(" ,'"+nominalprice+"','"+pena_rate+"','"+net_lease_money+"'")
           .append(" ,'"+plan_irr+"','"+measure_type+"','"+creator+"','"+create_date+"'")
           .append(",'"+modificator+"','"+modify_date+"','"+before_interest+"','"+rate_adjustment_modulus+"'")
           .append(" ,'"+other_income+"','"+other_expenditure+"','"+doc_id+"','"+rate_float_amt+"','"+consulting_fee+"'")
           .append(" ,'"+market_irr+"'")//新增字段 市场irr
           .append(" ,'"+lease_money_proportion+"'")//净融资额比例 【注：新加字段 2010-07-27】
           .append(" ,'"+accountPrincipal+"'")//会计核算本金 【注：新加字段 2010-08-06】
           .append(" ,'"+rentScale+"'")//圆整到 【注：新加字段 2010-08-20】
           .append(" ,'"+liugprice+"'")//留购价 【注：新加字段 2010-09-21 原本的留购价改成残值】
           .append(" ,'"+delay+"'" )//延迟期数 【注：新加字段 2010-10-20】
           .append(" ,'"+grace+"'" )//宽限期数 【注：新加字段 2010-10-20】
           .append(" ,'"+management_fee+"'" )//管理费【新增字段 2010-11-11】
           .append(" ,'"+ajdustStyle+"'" )//调息方式【新增字段 2010-11-23】
           .append(" ,'"+amt_return+"'" )// 
           .append(" )");
		
		System.out.println("----------------------------------------------------------------合同交易结构增加SQL-->   "+sql.toString());
		//执行添加sql语句
		flag = db.executeUpdate(sql.toString());
		message="增加合同交易结构";
	} 
	/* 和共同交易结构修改操作 */
	if(savaType.equals("mod")){
	   //拼装修改SQL语句 主键是项目编号 contract_id
	   sql.append("UPDATE contract_condition_temp ")
		  .append("SET currency = '"+currency+"' ,equip_amt = '"+equip_amt+"' ")
		  .append(",lease_money = '"+lease_money+"' ,lease_term = '"+lease_term+"' ")
	      .append(",income_number_year = '"+income_number_year+"' ")
	      .append(",income_number = '"+income_number+"' ")
	      .append(",year_rate = '"+year_rate+"' ")
	      .append(",rate_float_type = '"+rate_float_type+"' ")
	      .append(",period_type = '"+period_type+"' ")
	      .append(",income_day = '"+income_day+"' ")
	      .append(",start_date = '"+start_date+"' ")
	      .append(",first_payment = '"+first_payment+"' ")
	      .append(",caution_money = '"+caution_money+"' ")
	      .append(",handling_charge = '"+handling_charge+"' ")
	      .append(",return_amt = '"+return_amt+"' ")
	      .append(",nominalprice = '"+nominalprice+"' ")
	      .append(",pena_rate = '"+pena_rate+"' ")
	      .append(",net_lease_money = '"+net_lease_money+"' ")
	      .append(",plan_irr = '"+plan_irr+"' ")
	      .append(",measure_type = '"+measure_type+"' ")
	      .append(",creator = '"+creator+"' ")
	      .append(",create_date = '"+create_date+"' ")
	      .append(",modificator = '"+modificator+"' ")
	      .append(",modify_date = '"+modify_date+"' ")
	      .append(",rate_adjustment_modulus = '"+rate_adjustment_modulus+"' ")
	      .append(",other_income = '"+other_income+"' ")
	      .append(",rate_float_amt = '"+rate_float_amt+"' ")//利率调整值
	      .append(",consulting_fee = '"+consulting_fee+"' ")//咨询费
	      .append(",other_expenditure = '"+other_expenditure+"' ")
	      .append(",before_interest = '"+before_interest+"' ")
	      .append(",market_irr = '"+market_irr+"' ")//新增字段 市场irr
	      .append(",lease_money_proportion = '"+lease_money_proportion+"' ")//净融资额比例 【注：新加字段 2010-07-27】
	      .append(",accountPrincipal = '"+accountPrincipal+"' ")//会计核算本金【注：新加字段 2010-08-06】
	      .append(",rentScale = '"+rentScale+"' ")//圆整到 【注：新加字段 2010-08-20】
	      .append(",liugprice = '"+liugprice+"' ")//留购价 【注：新加字段 2010-09-21 原本的留购价改成残值】
	      .append(" ,delay = '"+delay+"'" )//延迟期数 【注：新加字段 2010-10-20】
          .append(" ,grace = '"+grace+"'" )//宽限期数 【注：新加字段 2010-10-20】
          .append(" ,management_fee = '"+management_fee+"'" )//管理费【新增字段 2010-11-11】
          .append(" ,ajdustStyle = '"+ajdustStyle+"'" )//调息方式【新增字段 2010-11-23】
          .append(" ,amt_return = '"+amt_return+"'" )//设备是否退还【注：新增字段 2011-01-10】   
	 	  .append("WHERE contract_id = '"+contract_id+"' ")
	 	  .append("  and measure_id = '"+doc_id+"' ");//编号
		//System.out.println("==================================================>修改SQL-->   "+sql.toString());
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
	
//*****************************************************************************************************	
//***                                  租金测算                                                                                             				   ****
//*****************************************************************************************************	
	start_date = start_date.substring(0,8)+income_day;
	//租金测算程序
	List l_plan_date = new ArrayList();
	List l_rent = new ArrayList();
	List l_rent_new = new ArrayList();//2010-11-30新加
	List l_corpus = new ArrayList();
	List l_interest = new ArrayList();
	List l_corpus_overage = new ArrayList();
	//现金流用到的2个list
	List l_RentDetails = new ArrayList(); 
	List new_rent = new ArrayList(); 
	//delay	int 延迟期数//grace int宽限期数
	//RentDelayGraceCalc延迟付款,宽限期规则租金测算//RentGraceCalc宽限期规则租金测算//RentDelayCalc延迟付款规则租金测算
	int tem_delay = Integer.parseInt(delay);//延迟期数
	int tem_grace = Integer.parseInt(grace);//宽限期数

	//判断是不规则调整还是正常的租金测算、
	if("0".equals(measure_type)){
		flag = 99;
	}else if("5".equals(measure_type)){//平息法
		SettledLaw settledLaw = new SettledLaw();
		Rent_init rent_init = new Rent_init();
		 ///**
		 //* 平息法租金测算
		 //【2011-03-15 需求修改】市场测算总本金：租赁本金＝设备款－首付款  财务测算本金：净融资额 +保证金 
		 String zlbj_market = String.valueOf(Double.valueOf(formatNumberDoubleSix(Double.valueOf(equip_amt) - Double.valueOf(first_payment))));
		 String zlbj_cw = String.valueOf(Double.valueOf(formatNumberDoubleSix(Double.valueOf(net_lease_money) + Double.valueOf(caution_money))));
		//市场：流入-流出 = 市场现金流净流量
		//流入量：
	    //  management_fee 管理费 caution_money 保证金  handling_charge 手续费 return_amt 厂商返佣   other_income 其他收入   first_payment 首付款   before_interest 租前息 
	    //流出量： 设备款 equip_amt   咨询费 consulting_fee   其他支出 other_expenditure
	     Double in_money_mark = Double.valueOf(management_fee) + Double.valueOf(caution_money) + Double.valueOf(handling_charge) + Double.valueOf(return_amt) + Double.valueOf(other_income) + Double.valueOf(first_payment) + Double.valueOf(before_interest);
	     Double out_money_mark = Double.valueOf(equip_amt) + Double.valueOf(consulting_fee) + Double.valueOf(other_expenditure) ;
	     String jl_money_mark = String.valueOf(Double.valueOf(formatNumberDoubleSix(in_money_mark - out_money_mark)));//市场现金流净流量
	    //Double.valueOf(formatNumberDoubleSix())
		 //会计现金流： 流入-流出 = 财务现金流净流量
		 //流入量： 管理费 management_fee  手续费 handling_charge   厂商返佣 return_amt  其他收入 other_income   首付款 first_payment   租前息 before_interest
		 //流出量： 设备款 equip_amt   咨询费 consulting_fee   其他支出 other_expenditure
	     Double in_money_cw = in_money_mark -  Double.valueOf(caution_money);//间接等于市场现金流净流量减去保证金
		 Double out_money_cw = out_money_mark;
		 String jl_money_cw = String.valueOf(Double.valueOf(formatNumberDoubleSix(in_money_cw - out_money_cw)));
		System.out.println("市场现金流净流量:" + jl_money_mark);
		System.out.println("财务现金流净流量:" + jl_money_cw);
		 
		Hashtable ht = settledLaw.getPlanInfo(zlbj_market,zlbj_cw,income_number,year_rate,income_number_year,jl_money_mark,jl_money_cw,period_type,start_date,rentScale,grace,delay);
		//之前的方式:Hashtable ht = settledLaw.getPlanInfo(equip_amt,income_number,year_rate,income_number_year,"-"+equip_amt,"-"+equip_amt,period_type,now_start_date,rentScale,grace,delay);
		System.out.println("市场irr:" + ht.get("market_irr").toString());
		System.out.println("财务irr:" + ht.get("finac_irr").toString());
		
		//计算irr  
		String irr = ht.get("finac_irr").toString();
		System.out.println("市场irr:" + tools.formatNumberDoubleScale(irr,8));
		//市场IRR 【修改时间2010-06-29】
		String Markirr = ht.get("market_irr").toString();
		//	/**
		//	 * <p>更新交易结构中的财务IRR和市场IRR。</p>
		//	 * @author 小谢
		//	 * @param irr 财务irr
		//	 * @param Markirr 市场irr
		//	 * @param proj_id 项目编号
		//	 * @param doc_id 文档编号
		//	 * @param contract_id 合同编号
		//	 * @param tabelNmae 表名
		//	 * @return 返回更新成功与否
		//	 */
		flag = rent_init.init_irr(irr,Markirr,proj_id,doc_id,contract_id,"contract_condition_temp");
			
		List date_list = (List) ht.get("date_list");
		List rent_list = (List) ht.get("rent_list");
		//财务
		List corpus_fina_list = (List) ht.get("corpus_fina_list");
		List inter_fina_list = (List) ht.get("inter_fina_list");
		List corpusOverage_fina_list = (List) ht.get("corpusOverage_fina_list");
		//市场
		List l_corpus_market = new ArrayList();
		List l_interest_market = new ArrayList();
		List l_corpus_overage_market = new ArrayList();
		l_corpus_market = (List) ht.get("corpus_market");//市场本金
		l_interest_market = (List) ht.get("inter_list");//市场利息
	    l_corpus_overage_market = (List) ht.get("corpusOverge_market");//市场本金余额
	    //	/**********************************************************************************
		//	 * <p>根据传入的条件更新对应的租金偿还计划表。</p>
		//	 * @author 小谢
		//	 * @param tableName 表名
		//	 * @param l_plan_date 偿还日期list
		//	 * @param l_rent 租金list
		//	 * @param l_corpus 财务本金list
		//	 * @param l_interest 财务利息list
		//	 * @param l_corpus_overage 财务剩余本金list
		//	 * @param year_rate 年利率
		//	 * @param l_corpus_market 市场本金list
		//	 * @param l_interest_market 市场利息list
		//	 * @param l_corpus_overage_market 市场剩余本金list
		//	 * @param doc_id 文档编号
		//	 * @param proj_id 项目编号
		//	 * @param contract_id 合同编号
		//	 * @return 更新成功与否
		//	 */
	    flag = rent_init.init_Rent("fund_rent_plan_temp",date_list,
	    							rent_list,corpus_fina_list,inter_fina_list,corpusOverage_fina_list,
	    							year_rate,
	    							l_corpus_market,l_interest_market,l_corpus_overage_market,
	    							doc_id,proj_id,contract_id);
		//现金流处理///////////////////////////////////////////////
		List list_r1 = CalcUtil.getNewList(rent_list);//得到新装的2个租金list防止原本的租金list被改写过
		List list_r2 = CalcUtil.getNewList(rent_list);
		List list_r3 = CalcUtil.getNewList(rent_list);
		//财务现金流
		l_rent_new = CalcUtil.getNewList(rent_list);
		//市场现金流 保证金抵扣 
		RentCalc rent = new RentCalc();
		//重构下得到加入延迟期的新的租金list 【2011-03-15 ********************************】
		CommUtil commUtil = new CommUtil(); 
		list_r2 = commUtil.getDelayRent(list_r2, delay);
		l_RentDetails = rent.getRentDetails(list_r2,caution_money);
		new_rent = rent.getRentCautNew(list_r1,caution_money);
		l_plan_date =  date_list;
		l_rent = list_r3;
	}else{
		Rent_init rent_init = new Rent_init();
		//正常情况
		if(tem_delay == 0 && tem_grace == 0){
			//租金测算之封装租金测算条件 9个
			RentCalc rent = new RentCalc();
			rent.setYear_rate(year_rate); //年利率   
			rent.setIncome_number(income_number);//期数 
			rent.setLease_money(lease_money);//租赁本金
			rent.setFuture_money(nominalprice);//留购价  【2010-08-04 修改前是“0”】
			rent.setPeriod_type(period_type);//1,期初 0,期未的值 
			rent.setIrr_type("2");//1,为按月份的处; 2,为按租金间隔的处理 暂时是2
			rent.setScale("8");//irr的小数位数 暂时就是8位
			rent.setLease_interval(income_number_year);//租金间隔 (付租方式)
			rent.setPlan_date(start_date);//起租日
			rent.setRentScale(rentScale);//圆整到 【新增字段 2010-08-20】
			//新增四个字段  【**************** 测算市场IRR所需的附加条件 *****************】【修改时间2010-06-29】
			Double mon = Double.parseDouble(net_lease_money)+ Double.parseDouble(caution_money);
			rent.setCle_cau_Money(mon.toString());//净融资额 net_lease_money+保证金 caution_money
			rent.setCauti_Money(caution_money);//保证金
			rent.setFuture_money(nominalprice);//期末残值 【注：加负号变为负数】【2010-08-04 修改去掉负号】
			rent.setStart_date(start_date);//保证金的流入时间
			
			System.out.println("----------------------------------------------------------------");	
			System.out.println("^%^^^^^^^^^^^^^^^^^^^^^^^^^^^year_rate年利率"+year_rate);	
			System.out.println("^%^^^^^^^^^^^^^^^^^^^^^^^^^^^income_number期数"+income_number);	
			System.out.println("^%^^^^^^^^^^^^^^^^^^^^^^^^^^^lease_money租赁本金"+lease_money);	
			System.out.println("^%^^^^^^^^^^^^^^^^^^^^^^^^^^^nominalprice留购价"+nominalprice);	
			System.out.println("^%^^^^^^^^^^^^^^^^^^^^^^^^^^^period_type1,期初0,期未的值"+period_type);	
			System.out.println("^%^^^^^^^^^^^^^^^^^^^^^^^^^^^income_number_year租金间隔 (付租方式)"+income_number_year);	
			System.out.println("^%^^^^^^^^^^^^^^^^^^^^^^^^^^^start_date起租日"+start_date);	
			System.out.println("^%^^^^^^^^^^^^^^^^^^^^^^^^^^^rentScale圆整到"+rentScale);	
			System.out.println("^%^^^^^^^^^^^^^^^^^^^^^^^^^^^mon净融资额 net_lease_money+保证金 caution_money"+mon);	
			System.out.println("^%^^^^^^^^^^^^^^^^^^^^^^^^^^^caution_money保证金"+caution_money);	
			System.out.println("^%^^^^^^^^^^^^^^^^^^^^^^^^^^^nominalprice期末残值"+nominalprice);	
			System.out.println("^%^^^^^^^^^^^^^^^^^^^^^^^^^^^start_date保证金的流入时间"+start_date);	
			System.out.println("----------------------------------------------------------------");	
			 
			//租金测算的现金流封装 主要是 设备金额，手续费，咨询费 等
			List<String> llist_case = new ArrayList<String>();//
			List<String> list_date = new ArrayList<String>();//
			//修改：-净融资额 net_lease_money-保证金 caution_money  算财务IRR
			Double list_mon =( Double.parseDouble(net_lease_money) + Double.parseDouble(caution_money) )*-1;
			llist_case.add(list_mon.toString());
			list_date.add(start_date);
			rent.setPreCash(llist_case);//
		    rent.setPreDate(list_date);// 
		    
			//‘规则’情况下，租金具体测算如下：
			List rent_list = rent.eqRentList(rent.getYear_rate());// 得到租金list,注意不规则时的租金list (只是新的租金的LIST，不包含 手续费那些现金)
			//getPlanDateList(参数一,参数二)   参数一 上方数组，租金list 参数二 期初(1)or期末支付(0)
			List l_plan_date_ = rent.getPlanDateList(rent_list, rent.getPeriod_type());// 计划时间 
			//参数说明 getHashRentPlan(参数一,参数二,参数三) 
			//参数一代表：measure_type租金计算方法，参数二代表：上方的list 封装的所有租金列表 
			//参数三 l_plan_date_ 上方数组 封装时间的结果集
			HashMap hm = rent.getHashRentPlan(measure_type, rent_list, l_plan_date_);
			//取值
			l_plan_date = (List)hm.get("plan_date");//租金偿还日期
			l_rent = (List)hm.get("rent");//租金
			l_rent_new = CalcUtil.getNewList(l_rent);//2010-11-30修改 财务现金流用到
			l_corpus = (List)hm.get("corpus");//本金
			l_interest = (List)hm.get("interest");//利息
			l_corpus_overage = (List)hm.get("corpus_overage");//剩余本金
			
			//计算irr  
			String getIrr = rent.getV_irr();
			//市场IRR 【修改时间2010-06-29】
			String Markirr = rent.getMarket_irr();
			//	/**
			//	 * <p>更新交易结构中的财务IRR和市场IRR。</p>
			//	 * @author 小谢
			//	 * @param irr 财务irr
			//	 * @param Markirr 市场irr
			//	 * @param proj_id 项目编号
			//	 * @param doc_id 文档编号
			//	 * @param contract_id 合同编号
			//	 * @param tabelNmae 表名
			//	 * @return 返回更新成功与否
			//	 */
			flag = rent_init.init_irr(getIrr,Markirr,proj_id,doc_id,contract_id,"contract_condition_temp");
			//**【修改时间：2010-07-26】
			//* 得到 市场的租金计划的一些信息
			//* 
			//* @param p_year_rate //每一期的利息 (市场IRR/100/12(月份))*租金间隔
			//* @param rent_c_list 租金 list       l_rent
			//* @param lease_money_p  所要测算的本金   等同于 租赁本金lease_money 这个字段
			//* @param period_type_p  期初或期末      
			//* @return
			//*/
			Double temp_num = (Double.parseDouble(year_rate)/100/12)*Double.parseDouble(income_number_year);
			//新增三个字段【市场本金，市场利息，市场本金余额】
			HashMap hx = rent.getPlanMarketByEqRent(String.valueOf(temp_num),l_rent,lease_money,period_type);
			List l_corpus_market = new ArrayList();
			List l_interest_market = new ArrayList();
			List l_corpus_overage_market = new ArrayList();
			l_corpus_market = (List) hx.get("corpus_market");//市场本金
			l_interest_market = (List) hx.get("interest_market");//市场利息
		    l_corpus_overage_market = (List) hx.get("corpus_overage_market");//市场本金余额
			//	/**********************************************************************************
			//	 * <p>根据传入的条件更新对应的租金偿还计划表。</p>
			flag = rent_init.init_Rent("fund_rent_plan_temp",l_plan_date,
	    							rent_list,l_corpus,l_interest,l_corpus_overage,
	    							year_rate,
	    							l_corpus_market,l_interest_market,l_corpus_overage_market,
	    							doc_id,proj_id,contract_id);
			//【修改日：2010-07-26】现金流加入保证金抵扣（得到保证金抵扣租金List）,参数：租金List，保证金
			l_RentDetails = rent.getRentDetails(l_rent,caution_money);
			new_rent = rent.getRentCautNew(l_rent,caution_money);
		}
		//*****************************************************************************************************
		//*****************************************************************************************************
		//*****************************************************************************************************
		else if(tem_delay == 0 && tem_grace > 0){//宽大于0延=0
			System.out.println("join宽大于0延=0======================================>");
			RentGraceCalc rent = new RentGraceCalc();
			rent.setYear_rate(year_rate); //年利率   
			rent.setIncome_number(income_number);//期数 
			rent.setLease_money(lease_money);//租赁本金
			rent.setFuture_money(nominalprice);//留购价  【2010-08-04 修改前是“0”】
			rent.setPeriod_type(period_type);//1,期初 0,期未的值 
			rent.setIrr_type("2");//1,为按月份的处; 2,为按租金间隔的处理 暂时是2
			rent.setScale("8");//irr的小数位数 暂时就是8位
			rent.setLease_interval(income_number_year);//租金间隔 (付租方式)
			rent.setPlan_date(start_date);//起租日
			rent.setRentScale(rentScale);//圆整到 【新增字段 2010-08-20】
			rent.setGrace(grace);//设置宽限属性 【新增字段 2010-10-20】
			
			//新增四个字段  【**************** 测算市场IRR所需的附加条件 *****************】【修改时间2010-06-29】
			Double mon = Double.parseDouble(net_lease_money)+ Double.parseDouble(caution_money);
			rent.setCle_cau_Money(mon.toString());//净融资额 net_lease_money+保证金 caution_money
			rent.setCauti_Money(caution_money);//保证金
			rent.setFuture_money(nominalprice);//期末残值 【注：加负号变为负数】【2010-08-04 修改去掉负号】
			rent.setStart_date(start_date);//保证金的流入时间
			 
			//租金测算的现金流封装 主要是 设备金额，手续费，咨询费 等
			List<String> llist_case = new ArrayList<String>();//
			List<String> list_date = new ArrayList<String>();//
			//修改：-净融资额 net_lease_money-保证金 caution_money  算财务IRR
			Double list_mon =( Double.parseDouble(net_lease_money) + Double.parseDouble(caution_money) )*-1;
			llist_case.add(list_mon.toString());
			list_date.add(start_date);
			rent.setPreCash(llist_case);//
		    rent.setPreDate(list_date);// 
		    
			//‘规则’情况下，租金具体测算如下：
			List rent_list = rent.eqRentList(rent.getYear_rate(),tem_grace);// 得到租金list,注意不规则时的租金list (只是新的租金的LIST，不包含 手续费那些现金)
			//getPlanDateList(参数一,参数二)   参数一 上方数组，租金list 参数二 期初(1)or期末支付(0)
			List l_plan_date_ = rent.getPlanDateList(rent_list, rent.getPeriod_type());// 计划时间 
			
			//参数说明 getHashRentPlan(参数一,参数二,参数三) 
			//参数一代表：measure_type租金计算方法，参数二代表：上方的list 封装的所有租金列表 
			//参数三 l_plan_date_ 上方数组 封装时间的结果集
			HashMap hm = rent.getHashRentPlan(measure_type, rent_list, l_plan_date_);
			//取值
			l_plan_date = (List)hm.get("plan_date");//租金偿还日期
			l_rent = (List)hm.get("rent");//租金
			l_rent_new = CalcUtil.getNewList(l_rent);//2010-11-30修改 财务现金流用到
			l_corpus = (List)hm.get("corpus");//本金
			l_interest = (List)hm.get("interest");//利息
			l_corpus_overage = (List)hm.get("corpus_overage");//剩余本金
			
			//计算irr  
			String getIrr = rent.getV_irr();
			//市场IRR 【修改时间2010-06-29】
			String Markirr = rent.getMarket_irr();
			//	/**
			//	 * <p>更新交易结构中的财务IRR和市场IRR。</p>
			//	 * @author 小谢
			//	 * @param irr 财务irr
			//	 * @param Markirr 市场irr
			//	 * @param proj_id 项目编号
			//	 * @param doc_id 文档编号
			//	 * @param contract_id 合同编号
			//	 * @param tabelNmae 表名
			//	 * @return 返回更新成功与否
			//	 */
			flag = rent_init.init_irr(getIrr,Markirr,proj_id,doc_id,contract_id,"contract_condition_temp");
			
			//**【修改时间：2010-07-26】
			//* 得到 市场的租金计划的一些信息
			//* 
			//* @param p_year_rate //每一期的利息 (市场IRR/100/12(月份))*租金间隔
			//* @param rent_c_list 租金 list       l_rent
			//* @param lease_money_p  所要测算的本金   等同于 租赁本金lease_money 这个字段
			//* @param period_type_p  期初或期末      
			//* @return
			//*/
			Double temp_num = (Double.parseDouble(year_rate)/100/12)*Double.parseDouble(income_number_year);
			//新增三个字段【市场本金，市场利息，市场本金余额】
			HashMap hx = rent.getPlanMarketByEqRent(String.valueOf(temp_num),l_rent,lease_money,period_type);
			List l_corpus_market = new ArrayList();
			List l_interest_market = new ArrayList();
			List l_corpus_overage_market = new ArrayList();
			l_corpus_market = (List) hx.get("corpus_market");//市场本金
			l_interest_market = (List) hx.get("interest_market");//市场利息
		    l_corpus_overage_market = (List) hx.get("corpus_overage_market");//市场本金余额
			//	/**********************************************************************************
			//	 * <p>根据传入的条件更新对应的租金偿还计划表。</p>
			flag = rent_init.init_Rent("fund_rent_plan_temp",l_plan_date,
	    							rent_list,l_corpus,l_interest,l_corpus_overage,
	    							year_rate,
	    							l_corpus_market,l_interest_market,l_corpus_overage_market,
	    							doc_id,proj_id,contract_id);
			
			//【修改日：2010-07-26】现金流加入保证金抵扣（得到保证金抵扣租金List）,参数：租金List，保证金
			l_RentDetails = rent.getRentDetails(l_rent,caution_money);
			new_rent = rent.getRentCautNew(l_rent,caution_money);
		}
		//*****************************************************************************************************
		//*****************************************************************************************************
		//*****************************************************************************************************
		else if(tem_delay > 0 && tem_grace == 0){//宽=0延>0
			RentDelayCalc rent = new RentDelayCalc();
			rent.setYear_rate(year_rate); //年利率   
			rent.setIncome_number(income_number);//期数 
			rent.setLease_money(lease_money);//租赁本金
			rent.setFuture_money(nominalprice);//留购价  【2010-08-04 修改前是“0”】
			rent.setPeriod_type(period_type);//1,期初 0,期未的值 
			rent.setIrr_type("2");//1,为按月份的处; 2,为按租金间隔的处理 暂时是2
			rent.setScale("8");//irr的小数位数 暂时就是8位
			rent.setLease_interval(income_number_year);//租金间隔 (付租方式)
			rent.setPlan_date(start_date);//起租日
			rent.setRentScale(rentScale);//圆整到 【新增字段 2010-08-20】
			rent.setDelay(delay);//设置延迟属性 【新增字段 2010-10-20】
			
			//新增四个字段  【**************** 测算市场IRR所需的附加条件 *****************】【修改时间2010-06-29】
			Double mon = Double.parseDouble(net_lease_money)+ Double.parseDouble(caution_money);
			rent.setCle_cau_Money(mon.toString());//净融资额 net_lease_money+保证金 caution_money
			rent.setCauti_Money(caution_money);//保证金
			rent.setFuture_money(nominalprice);//期末残值 【注：加负号变为负数】【2010-08-04 修改去掉负号】
			rent.setStart_date(start_date);//保证金的流入时间
			 
			//租金测算的现金流封装 主要是 设备金额，手续费，咨询费 等
			List<String> llist_case = new ArrayList<String>();//
			List<String> list_date = new ArrayList<String>();//
			//修改：-净融资额 net_lease_money-保证金 caution_money  算财务IRR
			Double list_mon =( Double.parseDouble(net_lease_money) + Double.parseDouble(caution_money) )*-1;
			llist_case.add(list_mon.toString());
			list_date.add(start_date);
			rent.setPreCash(llist_case);//
		    rent.setPreDate(list_date);// 
		    //*************************************
			//‘规则’情况下，租金具体测算如下：
			List rent_list = rent.eqRentList(rent.getYear_rate());// 得到租金list,注意不规则时的租金list (只是新的租金的LIST，不包含 手续费那些现金)
			//getPlanDateList(参数一,参数二)   参数一 上方数组，租金list 参数二 期初(1)or期末支付(0)
			List l_plan_date_ = rent.getPlanDateList(rent_list, rent.getPeriod_type(),tem_delay);// 计划时间 
			
			//参数说明 getHashRentPlan(参数一,参数二,参数三) 
			//参数一代表：measure_type租金计算方法，参数二代表：上方的list 封装的所有租金列表 
			//参数三 l_plan_date_ 上方数组 封装时间的结果集
			HashMap hm = rent.getHashRentPlan(measure_type, rent_list, l_plan_date_);
			//取值
			l_plan_date = (List)hm.get("plan_date");//租金偿还日期
			l_rent = (List)hm.get("rent");//租金
			l_rent_new = CalcUtil.getNewList(l_rent);//2010-11-30修改 财务现金流用到
			l_corpus = (List)hm.get("corpus");//本金
			l_interest = (List)hm.get("interest");//利息
			l_corpus_overage = (List)hm.get("corpus_overage");//剩余本金
			
			//计算irr  
			String getIrr = rent.getV_irr();
			//市场IRR 【修改时间2010-06-29】
			String Markirr = rent.getMarket_irr();
			//	/**
			//	 * <p>更新交易结构中的财务IRR和市场IRR。</p>
			//	 * @author 小谢
			//	 * @param irr 财务irr
			//	 * @param Markirr 市场irr
			//	 * @param proj_id 项目编号
			//	 * @param doc_id 文档编号
			//	 * @param contract_id 合同编号
			//	 * @param tabelNmae 表名
			//	 * @return 返回更新成功与否
			//	 */
			flag = rent_init.init_irr(getIrr,Markirr,proj_id,doc_id,contract_id,"contract_condition_temp");
			//**【修改时间：2010-07-26】
			//* 得到 市场的租金计划的一些信息
			//* 
			//* @param p_year_rate //每一期的利息 (市场IRR/100/12(月份))*租金间隔
			//* @param rent_c_list 租金 list       l_rent
			//* @param lease_money_p  所要测算的本金   等同于 租赁本金lease_money 这个字段
			//* @param period_type_p  期初或期末      
			//* @return
			//*/
			Double temp_num = (Double.parseDouble(year_rate)/100/12)*Double.parseDouble(income_number_year);
			//新增三个字段【市场本金，市场利息，市场本金余额】
			HashMap hx = rent.getPlanMarketByEqRent(String.valueOf(temp_num),l_rent,lease_money,period_type);
			List l_corpus_market = new ArrayList();
			List l_interest_market = new ArrayList();
			List l_corpus_overage_market = new ArrayList();
			l_corpus_market = (List) hx.get("corpus_market");//市场本金
			l_interest_market = (List) hx.get("interest_market");//市场利息
		    l_corpus_overage_market = (List) hx.get("corpus_overage_market");//市场本金余额
			//	/**********************************************************************************
			//	 * <p>根据传入的条件更新对应的租金偿还计划表。</p>
			flag = rent_init.init_Rent("fund_rent_plan_temp",l_plan_date,
	    							rent_list,l_corpus,l_interest,l_corpus_overage,
	    							year_rate,
	    							l_corpus_market,l_interest_market,l_corpus_overage_market,
	    							doc_id,proj_id,contract_id);
			CommUtil cu = new CommUtil(); 
			List new_rent_1 = cu.getDelayRent(l_rent, delay);//延迟情况下获取新的市场租金,用于现金流的拼装
			//【修改日：2010-07-26】现金流加入保证金抵扣（得到保证金抵扣租金List）,参数：租金List，保证金
			l_RentDetails = rent.getRentDetails(new_rent_1,caution_money);
			new_rent = rent.getRentCautNew(new_rent_1,caution_money);	
		}
		
		else{//tem_delay > 0 && tem_grace > 0//宽>0延>0
			System.out.println("join宽>0延>0======================================>");
			RentDelayGraceCalc  rent = new RentDelayGraceCalc();
			rent.setYear_rate(year_rate); //年利率   
			rent.setIncome_number(income_number);//期数 
			rent.setLease_money(lease_money);//租赁本金
			rent.setFuture_money(nominalprice);//留购价  【2010-08-04 修改前是“0”】
			rent.setPeriod_type(period_type);//1,期初 0,期未的值 
			rent.setIrr_type("2");//1,为按月份的处; 2,为按租金间隔的处理 暂时是2
			rent.setScale("8");//irr的小数位数 暂时就是8位
			rent.setLease_interval(income_number_year);//租金间隔 (付租方式)
			rent.setPlan_date(start_date);//起租日
			rent.setRentScale(rentScale);//圆整到 【新增字段 2010-08-20】
			rent.setDelay(delay);//设置延迟属性 【新增字段 2010-10-20】
			rent.setGrace(grace);//设置宽限属性 【新增字段 2010-10-20】
			//新增四个字段  【**************** 测算市场IRR所需的附加条件 *****************】【修改时间2010-06-29】
			Double mon = Double.parseDouble(net_lease_money)+ Double.parseDouble(caution_money);
			rent.setCle_cau_Money(mon.toString());//净融资额 net_lease_money+保证金 caution_money
			rent.setCauti_Money(caution_money);//保证金
			rent.setFuture_money(nominalprice);//期末残值 【注：加负号变为负数】【2010-08-04 修改去掉负号】
			rent.setStart_date(start_date);//保证金的流入时间
			 
			//租金测算的现金流封装 主要是 设备金额，手续费，咨询费 等
			List<String> llist_case = new ArrayList<String>();//
			List<String> list_date = new ArrayList<String>();//
			//修改：-净融资额 net_lease_money-保证金 caution_money  算财务IRR
			Double list_mon =( Double.parseDouble(net_lease_money) + Double.parseDouble(caution_money) )*-1;
			llist_case.add(list_mon.toString());
			list_date.add(start_date);
			rent.setPreCash(llist_case);//
		    rent.setPreDate(list_date);// 
		    //*************************************
			//‘规则’情况下，租金具体测算如下：
			List rent_list = rent.eqRentList(rent.getYear_rate(),tem_grace);// 得到租金list,注意不规则时的租金list (只是新的租金的LIST，不包含 手续费那些现金)
			//getPlanDateList(参数一,参数二)   参数一 上方数组，租金list 参数二 期初(1)or期末支付(0)
			List l_plan_date_ = rent.getPlanDateList(rent_list, rent.getPeriod_type(),tem_delay);// 计划时间 
			
			//参数说明 getHashRentPlan(参数一,参数二,参数三) 
			//参数一代表：measure_type租金计算方法，参数二代表：上方的list 封装的所有租金列表 
			//参数三 l_plan_date_ 上方数组 封装时间的结果集
			HashMap hm = rent.getHashRentPlan(measure_type, rent_list, l_plan_date_);
			//取值
			l_plan_date = (List)hm.get("plan_date");//租金偿还日期
			l_rent = (List)hm.get("rent");//租金
			l_rent_new = CalcUtil.getNewList(l_rent);//2010-11-30修改 财务现金流用到
			l_corpus = (List)hm.get("corpus");//本金
			l_interest = (List)hm.get("interest");//利息
			l_corpus_overage = (List)hm.get("corpus_overage");//剩余本金
			//计算irr  
			String getIrr = rent.getV_irr();
			//市场IRR 【修改时间2010-06-29】
			String Markirr = rent.getMarket_irr();
			//	/**
			//	 * <p>更新交易结构中的财务IRR和市场IRR。</p>
			//	 * @author 小谢
			//	 * @param irr 财务irr
			//	 * @param Markirr 市场irr
			//	 * @param proj_id 项目编号
			//	 * @param doc_id 文档编号
			//	 * @param contract_id 合同编号
			//	 * @param tabelNmae 表名
			//	 * @return 返回更新成功与否
			//	 */
			flag = rent_init.init_irr(getIrr,Markirr,proj_id,doc_id,contract_id,"contract_condition_temp");
			//**【修改时间：2010-07-26】
			//* 得到 市场的租金计划的一些信息
			//* 
			//* @param p_year_rate //每一期的利息 (市场IRR/100/12(月份))*租金间隔
			//* @param rent_c_list 租金 list       l_rent
			//* @param lease_money_p  所要测算的本金   等同于 租赁本金lease_money 这个字段
			//* @param period_type_p  期初或期末      
			//* @return
			//*/
			Double temp_num = (Double.parseDouble(year_rate)/100/12)*Double.parseDouble(income_number_year);
			//新增三个字段【市场本金，市场利息，市场本金余额】
			HashMap hx = rent.getPlanMarketByEqRent(String.valueOf(temp_num),l_rent,lease_money,period_type);
			List l_corpus_market = new ArrayList();
			List l_interest_market = new ArrayList();
			List l_corpus_overage_market = new ArrayList();
			l_corpus_market = (List) hx.get("corpus_market");//市场本金
			l_interest_market = (List) hx.get("interest_market");//市场利息
		    l_corpus_overage_market = (List) hx.get("corpus_overage_market");//市场本金余额
			//	/**********************************************************************************
			//	 * <p>根据传入的条件更新对应的租金偿还计划表。</p>
			flag = rent_init.init_Rent("fund_rent_plan_temp",l_plan_date,
	    							rent_list,l_corpus,l_interest,l_corpus_overage,
	    							year_rate,
	    							l_corpus_market,l_interest_market,l_corpus_overage_market,
	    							doc_id,proj_id,contract_id);	
			CommUtil cu = new CommUtil(); 
			List new_rent_1 = cu.getDelayRent(l_rent, delay);//延迟情况下获取新的市场租金,用于现金流的拼装
			//【修改日：2010-07-26】现金流加入保证金抵扣（得到保证金抵扣租金List）,参数：租金List，保证金
			l_RentDetails = rent.getRentDetails(new_rent_1,caution_money);
			new_rent = rent.getRentCautNew(new_rent_1,caution_money);
		}
	}//else结束标识符
	
	//不规则测算有单独的现金流测算
	if(flag != 99){
			//************************************************************************************************
			//                                            现金流
			//************************************************************************************************
			CommUtil commUtil = new CommUtil(); 
			if(tem_delay > 0){//延迟期大于0
				l_plan_date = commUtil.getDelayPlanDateList(l_rent,period_type,delay,income_number_year,start_date);
				l_rent_new = commUtil.getDelayRent(l_rent_new, delay);//延迟情况下获取新的财务租金,用于现金流的拼装
			}
			if("5".equals(measure_type) && tem_delay > 0){
				new_rent = commUtil.getDelayRent(new_rent, delay);//市场的  和财务的区别在于传入的租金list是做过保证金抵扣的
			}
			//市场现金流--得到保证金抵扣租金List rent_list  租金List,caut_money  保证金
			
			//每次插入之前需删除之前插入的数据
			String del_sql = " delete  fund_contract_plan_temp where contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"'";
			//财务现金流 
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
					System.out.println("查询合同财务现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值 ==> "+query_count_cw);
					//调用通用方法,进行‘留购价’的修改操作
					flag = cashFlow.update_xjl_cw(query_count_cw, nominalprice,"fund_contract_plan_temp","",contract_id);//财务
					
					//市场现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值
					String  query_count_market = " select * from fund_contract_plan_mark_temp  where  contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"'";
					query_count_market = query_count_market + " and plan_date = ( select max(plan_date) from fund_contract_plan_mark_temp where contract_id = '"+contract_id+"'  and doc_id = '"+doc_id+"' ) ";
					query_count_market = query_count_market + " and id = ( select max(id) from fund_contract_plan_mark_temp where contract_id = '"+contract_id+"'  and doc_id = '"+doc_id+"' ) ";
					System.out.println("查询合同市场现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值 ==> "+query_count_cw);
					//调用通用方法
					flag = cashFlow.update_xjl_market(query_count_market, nominalprice,"fund_contract_plan_mark_temp","",contract_id);//市场
				}
			}
			//需求增加,现金流补充代码【2010-11-30】 现金流第一期加上管理费，加入所有流入中
			if(!"".equals(management_fee) && management_fee != null && (!"0.00".equals(management_fee) && !"0".equals(management_fee))){
				//follow_in,follow_in_detail,follow_out,follow_out_detail,net_follow
				//查询财务现金流第一期的数据
				String  query_min_cw = " select * from fund_contract_plan_temp where   contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"' ";
					//query_min_cw = query_min_cw + " and plan_date = ( select min(plan_date) from fund_contract_plan_temp where contract_id = '"+contract_id+"'  and doc_id = '"+doc_id+"' ) ";
					query_min_cw = query_min_cw + " and id = ( select min(id) from fund_contract_plan_temp where contract_id = '"+contract_id+"'  and doc_id = '"+doc_id+"' ) ";
				System.out.println("查询合同财务现金流最小一期的值 ==> "+query_min_cw);
				//调用公用方法将管理费加到所有流入	
				//参数:String sql,String management_fee,String proj_id,String contract_id,String doc_id,String model
				flag = cashFlow.updat_xjl(query_min_cw,management_fee,proj_id,contract_id,doc_id,"contract","cw");
				//查询市场第一期的数据
				String  query_min_market = " select * from fund_contract_plan_mark_temp  where  contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"'";
					//query_min_market = query_min_market + " and plan_date = ( select min(plan_date) from fund_contract_plan_mark_temp where contract_id = '"+contract_id+"'  and doc_id = '"+doc_id+"' ) ";
					query_min_market = query_min_market + " and id = ( select min(id) from fund_contract_plan_mark_temp where contract_id = '"+contract_id+"'  and doc_id = '"+doc_id+"' ) ";
				System.out.println("查询合同市场现金流最小一期的值 ==> "+query_min_market);
				//调用公用方法将管理费加到所有流入	
				flag = cashFlow.updat_xjl(query_min_market,management_fee,proj_id,contract_id,doc_id,"contract","market");
			}
	}
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
		   if(flag == 99){
%>
	<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
			<iframe frameborder="0" name="rentplan123" width="100%" height="1000" 
			src="../zjcs_sg/zjcs_sg_list.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id%>&temp=contract_zjcs">
			</iframe>
	</div>		
	        <script>
	        	//window.open('../zjcs_sg/zjcs_sg_list.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id%>&temp=contract_zjcs','不规则调整','top=100,left=200,toolbar=no,menubar=no,scrollbars=no,resizable=yes,location=no,status=no');
				//alert("租金测算成功!");
				//opener.parent.location.reload();
				//window.close();
				//opener.location.reload();
				//this.close();
			</script>
<%
			}else{
%>
        <script>
			alert("合同租金测算成功!");
			opener.parent.location.reload();
			window.close();
		</script>
<%
		}
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