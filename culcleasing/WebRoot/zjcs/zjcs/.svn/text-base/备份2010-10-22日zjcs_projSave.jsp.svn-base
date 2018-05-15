<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<%@page import="com.rent.calc.bg.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="condition" scope="page" class="com.condition.ConditionOperating" />
<jsp:useBean id="cashFlow" scope="page" class="com.condition.CashFlow" />
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金测算 - 拟商务条件 - 数据操作页</title>
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
	    String doc_id = getStr(request.getParameter("doc_id")); //文档编号 measure_id
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
		String nominalprice = getZeroStr(getStr(request.getParameter("nominalprice")));//期末残值(或名义留购价)
		String period_type = getStr(request.getParameter("period_type"));//付租类型 period_type
		String return_amt = getZeroStr(getStr(request.getParameter("return_amt")));//厂商返利
		String year_rate = getZeroStr(getStr(request.getParameter("year_rate")));//租赁年利率
		String rate_float_type = getStr(request.getParameter("rate_float_type"));//利率浮动类型
		String before_interest = getZeroStr(getStr(request.getParameter("before_interest")));//租前息
		String rate_adjustment_modulus = getStr(request.getParameter("rate_adjustment_modulus"));//利率调整系数
		String pena_rate = getZeroStr(getStr(request.getParameter("pena_rate")));//罚息利率
		String income_day = getStr(request.getParameter("income_day"));//每月偿付日
		String start_date = getStr(request.getParameter("start_date"));//起租日
		String plan_irr = getZeroStr(getStr(request.getParameter("plan_irr")));//计划IRR
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
		String liugprice = getZeroStr(getStr(request.getParameter("liugprice")));//留购价 【注：新加字段 2010-09-21 原本的留购价改成残值】
		
		String delay = getDBStr(getStr(request.getParameter("delay")));//延迟期数 【注：新加字段 2010-10-20】
		String grace = getDBStr(getStr(request.getParameter("grace")));//宽限期数 【注：新加字段 2010-10-20】
		//SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//格式化时间
		//String nowTime=sdf.format(new Date());//当前格式化之后的时间
		//System.out.println("savaType+++++++++++++++++++&"+savaType+"&++++++++++++++++++++++++++++++++++++++++");
		
		String market_irr = getZeroStr(getStr(request.getParameter("market_irr")));//市场IRR 【注：新加字段】
		String old_start_date = start_date;	

	/* 拟商务条件添加操作 */
	if(savaType.equals("add")){
		//拼装添加‘拟商务条件’sql语句
		sql.append("INSERT INTO proj_condition_temp (proj_id ,currency ,equip_amt ,lease_money ,lease_term")
           .append(",income_number_year,income_number,year_rate,rate_float_type,period_type,income_day")
           .append(",start_date,first_payment,caution_money,handling_charge,return_amt,nominalprice")
           .append(",pena_rate,net_lease_money,plan_irr,measure_type,creator,create_date")
           .append(",modificator,modify_date,before_interest,rate_adjustment_modulus,")
           .append(" other_income,other_expenditure,measure_id,rate_float_amt,consulting_fee")
           .append(" ,market_irr ")//新增字段 市场irr
           .append(" ,lease_money_proportion ")//净融资额比例 【注：新加字段 2010-07-27】
           .append(" ,accountPrincipal ")//会计核算本金 【注：新加字段 2010-08-06】
           .append(" ,rentScale ")//圆整到 【注：新加字段 2010-08-20】
           .append(" ,liugprice ")//留购价 【注：新加字段 2010-09-21 原本的留购价改成残值】
           .append(" ,delay ")//延迟期数 【注：新加字段 2010-10-20】
           .append(" ,grace ")//宽限期数 【注：新加字段 2010-10-20】
           .append(" )")
     	   .append(" VALUES ('"+proj_id+"','"+currency+"','"+equip_amt+"','"+lease_money+"'")
           .append(" ,'"+lease_term+"','"+income_number_year+"','"+income_number+"','"+year_rate+"'")
           .append(" ,'"+rate_float_type+"','"+period_type+"','"+income_day+"','"+start_date+"'")
           .append(" ,'"+first_payment+"','"+caution_money+"','"+handling_charge+"','"+return_amt+"'")
           .append(" ,'"+nominalprice+"','"+pena_rate+"','"+net_lease_money+"'")
           .append(" ,'"+plan_irr+"','"+measure_type+"','"+creator+"','"+create_date+"'")
           .append(",'"+modificator+"','"+modify_date+"','"+before_interest+"','"+rate_adjustment_modulus+"'")
           .append(" ,'"+other_income+"','"+other_expenditure+"','"+doc_id+"','"+rate_float_amt+"','"+consulting_fee+"' ")
           .append(" ,'"+market_irr+"'")//新增字段 市场irr
           .append(" ,'"+lease_money_proportion+"'")//净融资额比例 【注：新加字段 2010-07-27】
           .append(" ,'"+accountPrincipal+"'")//会计核算本金 【注：新加字段 2010-08-06】
           .append(" ,'"+rentScale+"'")//圆整到 【注：新加字段 2010-08-20】
           .append(" ,'"+liugprice+"'")//留购价 【注：新加字段 2010-09-21 原本的留购价改成残值】
            .append(" ,'"+delay+"'" )//延迟期数 【注：新加字段 2010-10-20】
           .append(" ,'"+grace+"'" )//宽限期数 【注：新加字段 2010-10-20】
           .append(" )");
		//System.out.println("增加拟商务条件增加SQL-->   "+sql.toString());
		//执行添加sql语句
		flag = db.executeUpdate(sql.toString());
		message="增加拟商务条件";
	} 
	/* 拟商务条件修改操作 */
	if(savaType.equals("mod")){
	   //拼装修改SQL语句 主键是项目编号
	   sql.append("UPDATE proj_condition_temp ")
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
	      .append(",rate_float_amt = '"+rate_float_amt+"' ")//利率调整值
	      .append(",rate_adjustment_modulus = '"+rate_adjustment_modulus+"' ")
	      .append(",other_income = '"+other_income+"' ")
	      .append(",other_expenditure = '"+other_expenditure+"' ")
	      .append(",consulting_fee = '"+consulting_fee+"' ")//咨询费
	      .append(",before_interest = '"+before_interest+"' ")
	      .append(",market_irr = '"+market_irr+"' ")//新增字段 市场irr
	      .append(",lease_money_proportion = '"+lease_money_proportion+"' ")//净融资额比例 【注：新加字段 2010-07-27】
	      .append(",accountPrincipal = '"+accountPrincipal+"' ")//会计核算本金【注：新加字段 2010-08-06】
	      .append(",rentScale = '"+rentScale+"' ")//圆整到【注：新加字段 2010-08-20】
	      .append(",liugprice = '"+liugprice+"' ")//留购价 【注：新加字段 2010-09-21 原本的留购价改成残值】
	      .append(" ,delay = '"+delay+"'" )//延迟期数 【注：新加字段 2010-10-20】
          .append(" ,grace = '"+grace+"'" )//宽限期数 【注：新加字段 2010-10-20】
	 	  .append("WHERE proj_id = '"+proj_id+"' ")
	 	  .append("  and measure_id = '"+doc_id+"' ");
		//System.out.println("1                                                        ");
		//System.out.println("2                                                        ");
		//System.out.println("3                                                        ");
		//System.out.println("4                                                        ");
		System.out.println("拟商务条件修改123123123123123123123123123SQL-->   "+sql.toString());
		flag = db.executeUpdate(sql.toString());
		//System.out.println("1                                                        "+flag);
		message = "修改拟商务条件";
	}
	/* 拟商务条件删除操作 --暂时未验证该方法的正确性 */
	if(savaType.equals("del")){
		//根据主键‘项目编号’进行数据删除操作
		sql.append("delete from proj_condition_temp where proj_id = '"+proj_id+"'");
		flag=db.executeUpdate(sql.toString());
		//System.out.println("增加拟商务条件删除SQL-->   "+sql.toString());
		message = "删除拟商务条件";
	}
//*****************************************************************************************************	
//***                                  租金测算                                                             ****
//*****************************************************************************************************	

	String now_start_date = start_date.substring(0,8)+income_day;
	System.out.println("now_start_date=====================>"+now_start_date);
	//租金测算程序
	List l_plan_date = new ArrayList();
	List l_rent = new ArrayList();
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
	//情况一  正常情况下
	if(tem_delay == 0 && tem_grace == 0){
		//租金测算之封装租金测算条件 9个
		RentCalc rent = new RentCalc();
		rent.setYear_rate(year_rate); //年利率   
		rent.setIncome_number(income_number);//期数 
		rent.setLease_money(lease_money);//租赁本金 （租赁本金 = 设备金额 - 首付款）
		rent.setFuture_money(nominalprice);//留购价  【2010-08-04 修改前是“0”】
		rent.setPeriod_type(period_type);//1,期初 0,期未的值 
		rent.setIrr_type("2");//1,为按月份的处; 2,为按租金间隔的处理 暂时是2
		rent.setScale("8");//irr的小数位数 暂时就是8位
		rent.setLease_interval(income_number_year);//租金间隔 (付租方式)
		rent.setPlan_date(now_start_date);//每月偿付日 替换 起租日 的具体日期 
		rent.setContract_id(proj_id);//计算具体项目现金流的KEY
		rent.setRentScale(rentScale);//圆整到 【新增字段 2010-08-20】
		
		//封装租金测算所有的条件
		Map<String,String> map = new HashMap<String, String>();
		/* 第一部分 */
		map.put("year_rate",year_rate);//年利率  
		map.put("income_number",income_number);//期数 
		map.put("lease_money",lease_money);//租赁本金 
		map.put("nominalprice",nominalprice);//期末残值(或名义留购价)
		map.put("period_type",period_type);//1,期初 0,期未的值 
		map.put("income_number_year",income_number_year);//租金间隔 (付租方式)
		map.put("now_start_date",now_start_date);//每月偿付日替换起租日的具体日期
		map.put("proj_id",proj_id);//计算具体项目现金流的KEY 
		map.put("rentScale",rentScale);//圆整到
		/* 第二部分 */
		map.put("net_lease_money",net_lease_money);//净融资额
		map.put("caution_money",caution_money);//租赁保证金
		/* 第三部分 */
		map.put("now_start_date",now_start_date);//保证金的流入时间
		map.put("equip_amt",equip_amt);//设备款
		map.put("start_date",start_date);//日期
		map.put("measure_type",measure_type);//租金计算方法
		map.put("doc_id",doc_id);//doc_id
		map.put("proj_id",proj_id);//proj_id
		map.put("year_rate",year_rate);//租赁年利率
		map.put("delay",delay);//延迟期数
		map.put("grace",grace);//宽限期数
		
		//新增四个字段  【**************** 测算市场IRR所需的附加条件 *****************】【修改时间2010-06-29】
		Double mon = Double.parseDouble(net_lease_money)+ Double.parseDouble(caution_money);
		rent.setCle_cau_Money(mon.toString());//净融资额 net_lease_money+保证金 caution_money
		rent.setCauti_Money(caution_money);//保证金
		rent.setFuture_money(nominalprice);//期末残值 【注：加负号变为负数】【2010-08-04 修改去掉负号】
		rent.setStart_date(now_start_date);//保证金的流入时间
		
		//租金测算的现金流封装 主要是 租赁本金，手续费，咨询费 等
		List<String> llist_case = new ArrayList<String>();//
		List<String> list_date = new ArrayList<String>();//
		//修改：-净融资额 net_lease_money-保证金 caution_money  算财务IRR
		Double list_mon =( Double.parseDouble(net_lease_money) + Double.parseDouble(caution_money) )*-1;
		llist_case.add(list_mon.toString());
		list_date.add(start_date);
		rent.setPreCash(llist_case);//
	    rent.setPreDate(list_date);//
		System.out.println("净融资额为==>"+net_lease_money);
		System.out.println("保证金==>"+caution_money);
		System.out.println("设备款==>"+equip_amt);
		System.out.println("值为==>"+formatNumberDoubleTwo(list_mon));
		System.out.println("日期==>"+start_date);
		//‘规则’情况下，租金具体测算如下：
		List rent_list = rent.eqRentList(rent.getYear_rate());// 得到租金list,注意不规则时的租金list (只是新的租金的LIST，不包含 手续费那些现金)
		//getPlanDateList(参数一,参数二)   参数一 上方数组，租金list 参数二 期初(1)or期末支付(0)
		List l_plan_date_ = rent.getPlanDateList(rent_list, rent.getPeriod_type());// 计划时间 
		//参数说明 getHashRentPlan(参数一,参数二,参数三) 
		//参数一代表：measure_type租金计算方法，参数二代表：上方的list 封装的所有租金列表  参数三 l_plan_date_ 上方数组 封装时间的结果集
		String m_type = getStr(measure_type);
		if ("0".equals(m_type)) {
			m_type="1";
		}
		HashMap hm = rent.getHashRentPlan(m_type, rent_list, l_plan_date_);
		//取值
		l_plan_date = (List)hm.get("plan_date");//租金偿还日期
		l_rent = (List)hm.get("rent");//租金
		l_corpus = (List)hm.get("corpus");//本金
		l_interest = (List)hm.get("interest");//利息
		l_corpus_overage = (List)hm.get("corpus_overage");//剩余本金
		//计算irr  
		Double irr = Double.parseDouble(rent.getV_irr())*100;
		//市场IRR 【修改时间2010-06-29】
		Double Markirr = Double.parseDouble(rent.getMarket_irr())*100;
		//修改‘拟商务条件’表中计划IRR的值
		String sqlstr = "update proj_condition_temp set plan_irr="+irr+",market_irr = "+Markirr+"   where proj_id='"+proj_id+"' and measure_id = '"+doc_id+"' ";
		db.executeUpdate(sqlstr);
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
		//System.out.println("join1------------------------------>"+l_corpus_market.size());
		//租金测算表  fund_rent_plan_temp //测算编号 等于 文档编号
		sqlstr = "delete from fund_rent_plan_proj_temp where proj_id='"+proj_id+"' and measure_id='"+doc_id+"'";
		db.executeUpdate(sqlstr);
		for(int i=0;i<l_rent.size();i++){
		//插入字段顺序:文档编号(测算编号),合同编号,回笼状态,租金,本金,租息,本金余额,年利率
			sqlstr="insert into fund_rent_plan_proj_temp"+
			       "(measure_id,proj_id,"+
			       "rent_list,plan_date,plan_status,rent,corpus,"+
			       "interest,corpus_overage,year_rate,corpus_market,interest_market,corpus_overage_market) "+
			       "select '"+doc_id+"','"+proj_id+"',"+(i+1)+","+
			       "'"+l_plan_date.get(i)+"','未回笼',"+l_rent.get(i)+","+
			       ""+l_corpus.get(i)+","+l_interest.get(i)+","+
			       ""+l_corpus_overage.get(i)+","+year_rate+","+
			       l_corpus_market.get(i)+","+l_interest_market.get(i)+","+l_corpus_overage_market.get(i)+" ;";
			System.out.println("^^^^^^^^^^^^^^^租金添加sql=====> "+sqlstr);
			db.executeUpdate(sqlstr);
		}
		//【修改日：2010-07-26】现金流加入保证金抵扣（得到保证金抵扣租金List）,参数：租金List，保证金
		l_RentDetails = rent.getRentDetails(l_rent,caution_money);
		//得到保证金抵扣租金List rent_list  租金List,caut_money  保证金
		new_rent = rent.getRentCautNew(l_rent,caution_money);
	}
	//*****************************************************************************************************
	//*****************************************************************************************************
	//*****************************************************************************************************
	else if(tem_delay == 0 && tem_grace > 0){//宽大于0延=0
		System.out.println("join宽大于0延=0======================================>");
		RentGraceCalc rent = new RentGraceCalc();
		//租金测算之封装租金测算条件 9个
		rent.setYear_rate(year_rate); //年利率   
		rent.setIncome_number(income_number);//期数 
		rent.setLease_money(lease_money);//租赁本金 （租赁本金 = 设备金额 - 首付款）
		rent.setFuture_money(nominalprice);//留购价  【2010-08-04 修改前是“0”】
		rent.setPeriod_type(period_type);//1,期初 0,期未的值 
		rent.setIrr_type("2");//1,为按月份的处; 2,为按租金间隔的处理 暂时是2
		rent.setScale("8");//irr的小数位数 暂时就是8位
		rent.setLease_interval(income_number_year);//租金间隔 (付租方式)
		rent.setPlan_date(now_start_date);//每月偿付日 替换 起租日 的具体日期 
		rent.setContract_id(proj_id);//计算具体项目现金流的KEY
		rent.setRentScale(rentScale);//圆整到 【新增字段 2010-08-20】
		rent.setGrace(grace);//设置宽限属性 【新增字段 2010-10-20】
		
		//新增四个字段  【**************** 测算市场IRR所需的附加条件 *****************】【修改时间2010-06-29】
		Double mon = Double.parseDouble(net_lease_money)+ Double.parseDouble(caution_money);
		rent.setCle_cau_Money(mon.toString());//净融资额 net_lease_money+保证金 caution_money
		rent.setCauti_Money(caution_money);//保证金
		rent.setFuture_money(nominalprice);//期末残值 【注：加负号变为负数】【2010-08-04 修改去掉负号】
		rent.setStart_date(now_start_date);//保证金的流入时间
		
		//租金测算的现金流封装 主要是 租赁本金，手续费，咨询费 等
		List<String> llist_case = new ArrayList<String>();//
		List<String> list_date = new ArrayList<String>();//
		//修改：-净融资额 net_lease_money-保证金 caution_money  算财务IRR
		Double list_mon =( Double.parseDouble(net_lease_money) + Double.parseDouble(caution_money) )*-1;
		llist_case.add(list_mon.toString());
		list_date.add(start_date);
		rent.setPreCash(llist_case);//
	    rent.setPreDate(list_date);//
		System.out.println("净融资额为==>"+net_lease_money);
		System.out.println("保证金==>"+caution_money);
		System.out.println("设备款==>"+equip_amt);
		System.out.println("值为==>"+formatNumberDoubleTwo(list_mon));
		System.out.println("日期==>"+start_date);
		//‘规则’情况下，租金具体测算如下：
		List rent_list = rent.eqRentList(rent.getYear_rate(),tem_grace);// 得到租金list,注意不规则时的租金list (只是新的租金的LIST，不包含 手续费那些现金)
		//getPlanDateList(参数一,参数二)   参数一 上方数组，租金list 参数二 期初(1)or期末支付(0)
		List l_plan_date_ = rent.getPlanDateList(rent_list, rent.getPeriod_type());// 计划时间 
		//参数说明 getHashRentPlan(参数一,参数二,参数三) 
		//参数一代表：measure_type租金计算方法，参数二代表：上方的list封装的所有租金列表  参数三 l_plan_date_ 上方数组 封装时间的结果集
		String m_type = getStr(measure_type);
		if ("0".equals(m_type)) {
			m_type="1";
		}
		HashMap hm = rent.getHashRentPlan(m_type, rent_list, l_plan_date_);
		//取值
		l_plan_date = (List)hm.get("plan_date");//租金偿还日期
		l_rent = (List)hm.get("rent");//租金
		l_corpus = (List)hm.get("corpus");//本金
		l_interest = (List)hm.get("interest");//利息
		l_corpus_overage = (List)hm.get("corpus_overage");//剩余本金
		//计算irr  
		Double irr = Double.parseDouble(rent.getV_irr())*100;
		//市场IRR 【修改时间2010-06-29】
		Double Markirr = Double.parseDouble(rent.getMarket_irr())*100;
		//修改‘拟商务条件’表中计划IRR的值
		String sqlstr = "update proj_condition_temp set plan_irr="+irr+",market_irr = "+Markirr+"   where proj_id='"+proj_id+"' and measure_id = '"+doc_id+"' ";
		db.executeUpdate(sqlstr);
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
		//System.out.println("join1------------------------------>"+l_corpus_market.size());
		//租金测算表  fund_rent_plan_temp //测算编号 等于 文档编号
		sqlstr = "delete from fund_rent_plan_proj_temp where proj_id='"+proj_id+"' and measure_id='"+doc_id+"'";
		db.executeUpdate(sqlstr);
		for(int i=0;i<l_rent.size();i++){
			//插入字段顺序:文档编号(测算编号),合同编号,回笼状态,租金,本金,租息,本金余额,年利率
			sqlstr="insert into fund_rent_plan_proj_temp"+
			       "(measure_id,proj_id,"+
			       "rent_list,plan_date,plan_status,rent,corpus,"+
			       "interest,corpus_overage,year_rate,corpus_market,interest_market,corpus_overage_market) "+
			       "select '"+doc_id+"','"+proj_id+"',"+(i+1)+","+
			       "'"+l_plan_date.get(i)+"','未回笼',"+l_rent.get(i)+","+
			       ""+l_corpus.get(i)+","+l_interest.get(i)+","+
			       ""+l_corpus_overage.get(i)+","+year_rate+","+
			       l_corpus_market.get(i)+","+l_interest_market.get(i)+","+l_corpus_overage_market.get(i)+" ;";
			System.out.println("^^^^^^^^^^^^^^^租金添加sql=====> "+sqlstr);
			db.executeUpdate(sqlstr);
		}
		//【修改日：2010-07-26】现金流加入保证金抵扣（得到保证金抵扣租金List）,参数：租金List，保证金
		l_RentDetails = rent.getRentDetails(l_rent,caution_money);
		//得到保证金抵扣租金List rent_list  租金List,caut_money  保证金
		new_rent = rent.getRentCautNew(l_rent,caution_money);
	}
	
	//*****************************************************************************************************
	//*****************************************************************************************************
	//*****************************************************************************************************
	else if(tem_delay > 0 && tem_grace == 0){//宽=0延>0
		RentDelayCalc rent = new RentDelayCalc();
		//租金测算之封装租金测算条件 9个
		rent.setYear_rate(year_rate); //年利率   
		rent.setIncome_number(income_number);//期数 
		rent.setLease_money(lease_money);//租赁本金 （租赁本金 = 设备金额 - 首付款）
		rent.setFuture_money(nominalprice);//留购价  【2010-08-04 修改前是“0”】
		rent.setPeriod_type(period_type);//1,期初 0,期未的值 
		rent.setIrr_type("2");//1,为按月份的处; 2,为按租金间隔的处理 暂时是2
		rent.setScale("8");//irr的小数位数 暂时就是8位
		rent.setLease_interval(income_number_year);//租金间隔 (付租方式)
		rent.setPlan_date(now_start_date);//每月偿付日 替换 起租日 的具体日期 
		rent.setContract_id(proj_id);//计算具体项目现金流的KEY
		rent.setRentScale(rentScale);//圆整到 【新增字段 2010-08-20】
		rent.setDelay(delay);//设置延迟属性 【新增字段 2010-10-20】
		
		//新增四个字段  【**************** 测算市场IRR所需的附加条件 *****************】【修改时间2010-06-29】
		Double mon = Double.parseDouble(net_lease_money)+ Double.parseDouble(caution_money);
		rent.setCle_cau_Money(mon.toString());//净融资额 net_lease_money+保证金 caution_money
		rent.setCauti_Money(caution_money);//保证金
		rent.setFuture_money(nominalprice);//期末残值 【注：加负号变为负数】【2010-08-04 修改去掉负号】
		rent.setStart_date(now_start_date);//保证金的流入时间
		
		//租金测算的现金流封装 主要是 租赁本金，手续费，咨询费 等
		List<String> llist_case = new ArrayList<String>();//
		List<String> list_date = new ArrayList<String>();//
		//修改：-净融资额 net_lease_money-保证金 caution_money  算财务IRR
		Double list_mon =( Double.parseDouble(net_lease_money) + Double.parseDouble(caution_money) )*-1;
		llist_case.add(list_mon.toString());
		list_date.add(start_date);
		rent.setPreCash(llist_case);//
	    rent.setPreDate(list_date);//
		System.out.println("净融资额为==>"+net_lease_money);
		System.out.println("保证金==>"+caution_money);
		System.out.println("设备款==>"+equip_amt);
		System.out.println("值为==>"+formatNumberDoubleTwo(list_mon));
		System.out.println("日期==>"+start_date);
		//‘规则’情况下，租金具体测算如下：
		List rent_list = rent.eqRentList(rent.getYear_rate());// 得到租金list,注意不规则时的租金list (只是新的租金的LIST，不包含 手续费那些现金)
		//getPlanDateList(参数一,参数二)   参数一 上方数组，租金list 参数二 期初(1)or期末支付(0)
		List l_plan_date_ = rent.getPlanDateList(rent_list, rent.getPeriod_type(),tem_delay);// 计划时间 
		//参数说明 getHashRentPlan(参数一,参数二,参数三) 
		//参数一代表：measure_type租金计算方法，参数二代表：上方的list 封装的所有租金列表  参数三 l_plan_date_ 上方数组 封装时间的结果集
		String m_type = getStr(measure_type);
		if ("0".equals(m_type)) {
			m_type="1";
		}
		HashMap hm = rent.getHashRentPlan(m_type, rent_list, l_plan_date_);
		//取值
		l_plan_date = (List)hm.get("plan_date");//租金偿还日期
		l_rent = (List)hm.get("rent");//租金
		l_corpus = (List)hm.get("corpus");//本金
		l_interest = (List)hm.get("interest");//利息
		l_corpus_overage = (List)hm.get("corpus_overage");//剩余本金
		//计算irr  
		Double irr = Double.parseDouble(rent.getV_irr())*100;
		//市场IRR 【修改时间2010-06-29】
		Double Markirr = Double.parseDouble(rent.getMarket_irr())*100;
		//修改‘拟商务条件’表中计划IRR的值
		String sqlstr = "update proj_condition_temp set plan_irr="+irr+",market_irr = "+Markirr+"   where proj_id='"+proj_id+"' and measure_id = '"+doc_id+"' ";
		db.executeUpdate(sqlstr);
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
		//System.out.println("join1------------------------------>"+l_corpus_market.size());
		//租金测算表  fund_rent_plan_temp //测算编号 等于 文档编号
		sqlstr = "delete from fund_rent_plan_proj_temp where proj_id='"+proj_id+"' and measure_id='"+doc_id+"'";
		db.executeUpdate(sqlstr);
		for(int i=0;i<l_rent.size();i++){
		//插入字段顺序:文档编号(测算编号),合同编号,回笼状态,租金,本金,租息,本金余额,年利率
			sqlstr="insert into fund_rent_plan_proj_temp"+
			       "(measure_id,proj_id,"+
			       "rent_list,plan_date,plan_status,rent,corpus,"+
			       "interest,corpus_overage,year_rate,corpus_market,interest_market,corpus_overage_market) "+
			       "select '"+doc_id+"','"+proj_id+"',"+(i+1)+","+
			       "'"+l_plan_date.get(i)+"','未回笼',"+l_rent.get(i)+","+
			       ""+l_corpus.get(i)+","+l_interest.get(i)+","+
			       ""+l_corpus_overage.get(i)+","+year_rate+","+
			       l_corpus_market.get(i)+","+l_interest_market.get(i)+","+l_corpus_overage_market.get(i)+" ;";
			System.out.println("^^^^^^^^^^^^^^^租金添加sql=====> "+sqlstr);
			db.executeUpdate(sqlstr);
		}
		//【修改日：2010-07-26】现金流加入保证金抵扣（得到保证金抵扣租金List）,参数：租金List，保证金
		l_RentDetails = rent.getRentDetails(l_rent,caution_money);
		//得到保证金抵扣租金List rent_list  租金List,caut_money  保证金
		new_rent = rent.getRentCautNew(l_rent,caution_money);
	}

	else{//tem_delay > 0 && tem_grace > 0//宽>0延>0
		System.out.println("join宽>0延>0======================================>");
		 RentDelayGraceCalc  rent = new RentDelayGraceCalc();
		//租金测算之封装租金测算条件 9个
		rent.setYear_rate(year_rate); //年利率   
		rent.setIncome_number(income_number);//期数 
		rent.setLease_money(lease_money);//租赁本金 （租赁本金 = 设备金额 - 首付款）
		rent.setFuture_money(nominalprice);//留购价  【2010-08-04 修改前是“0”】
		rent.setPeriod_type(period_type);//1,期初 0,期未的值 
		rent.setIrr_type("2");//1,为按月份的处; 2,为按租金间隔的处理 暂时是2
		rent.setScale("8");//irr的小数位数 暂时就是8位
		rent.setLease_interval(income_number_year);//租金间隔 (付租方式)
		rent.setPlan_date(now_start_date);//每月偿付日 替换 起租日 的具体日期 
		rent.setContract_id(proj_id);//计算具体项目现金流的KEY
		rent.setRentScale(rentScale);//圆整到 【新增字段 2010-08-20】
		rent.setDelay(delay);//设置延迟属性 【新增字段 2010-10-20】
		rent.setGrace(grace);//设置宽限属性 【新增字段 2010-10-20】
		
		//新增四个字段  【**************** 测算市场IRR所需的附加条件 *****************】【修改时间2010-06-29】
		Double mon = Double.parseDouble(net_lease_money)+ Double.parseDouble(caution_money);
		rent.setCle_cau_Money(mon.toString());//净融资额 net_lease_money+保证金 caution_money
		rent.setCauti_Money(caution_money);//保证金
		rent.setFuture_money(nominalprice);//期末残值 【注：加负号变为负数】【2010-08-04 修改去掉负号】
		rent.setStart_date(now_start_date);//保证金的流入时间
		
		//租金测算的现金流封装 主要是 租赁本金，手续费，咨询费 等
		List<String> llist_case = new ArrayList<String>();//
		List<String> list_date = new ArrayList<String>();//
		//修改：-净融资额 net_lease_money-保证金 caution_money  算财务IRR
		Double list_mon =( Double.parseDouble(net_lease_money) + Double.parseDouble(caution_money) )*-1;
		llist_case.add(list_mon.toString());
		list_date.add(start_date);
		rent.setPreCash(llist_case);//
	    rent.setPreDate(list_date);//
		System.out.println("净融资额为==>"+net_lease_money);
		System.out.println("保证金==>"+caution_money);
		System.out.println("设备款==>"+equip_amt);
		System.out.println("值为==>"+formatNumberDoubleTwo(list_mon));
		System.out.println("日期==>"+start_date);
		//‘规则’情况下，租金具体测算如下：
		List rent_list = rent.eqRentList(rent.getYear_rate(),tem_grace);// 得到租金list,注意不规则时的租金list (只是新的租金的LIST，不包含 手续费那些现金)
		//getPlanDateList(参数一,参数二)   参数一 上方数组，租金list 参数二 期初(1)or期末支付(0)
		List l_plan_date_ = rent.getPlanDateList(rent_list, rent.getPeriod_type(),tem_delay);// 计划时间 
		//参数说明 getHashRentPlan(参数一,参数二,参数三) 
		//参数一代表：measure_type租金计算方法，参数二代表：上方的list 封装的所有租金列表  参数三 l_plan_date_ 上方数组 封装时间的结果集
		String m_type = getStr(measure_type);
		if ("0".equals(m_type)) {
			m_type="1";
		}
		HashMap hm = rent.getHashRentPlan(m_type, rent_list, l_plan_date_);
		//取值
		l_plan_date = (List)hm.get("plan_date");//租金偿还日期
		l_rent = (List)hm.get("rent");//租金
		l_corpus = (List)hm.get("corpus");//本金
		l_interest = (List)hm.get("interest");//利息
		l_corpus_overage = (List)hm.get("corpus_overage");//剩余本金
		//计算irr  
		Double irr = Double.parseDouble(rent.getV_irr())*100;
		//市场IRR 【修改时间2010-06-29】
		Double Markirr = Double.parseDouble(rent.getMarket_irr())*100;
		//修改‘拟商务条件’表中计划IRR的值
		String sqlstr = "update proj_condition_temp set plan_irr="+irr+",market_irr = "+Markirr+"   where proj_id='"+proj_id+"' and measure_id = '"+doc_id+"' ";
		db.executeUpdate(sqlstr);
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
		//System.out.println("join1------------------------------123>");
		//System.out.println("join1------------------------------>"+l_corpus_market.get(0));
		//System.out.println("join1------------------------------>"+l_corpus_market.size());
		//租金测算表  fund_rent_plan_temp //测算编号 等于 文档编号
		sqlstr = "delete from fund_rent_plan_proj_temp where proj_id='"+proj_id+"' and measure_id='"+doc_id+"'";
		db.executeUpdate(sqlstr);
		for(int i=0;i<l_rent.size();i++){
		//插入字段顺序:文档编号(测算编号),合同编号,回笼状态,租金,本金,租息,本金余额,年利率
			sqlstr="insert into fund_rent_plan_proj_temp"+
			       "(measure_id,proj_id,"+
			       "rent_list,plan_date,plan_status,rent,corpus,"+
			       "interest,corpus_overage,year_rate,corpus_market,interest_market,corpus_overage_market) "+
			       "select '"+doc_id+"','"+proj_id+"',"+(i+1)+","+
			       "'"+l_plan_date.get(i)+"','未回笼',"+l_rent.get(i)+","+
			       ""+l_corpus.get(i)+","+l_interest.get(i)+","+
			       ""+l_corpus_overage.get(i)+","+year_rate+","+
			       l_corpus_market.get(i)+","+l_interest_market.get(i)+","+l_corpus_overage_market.get(i)+" ;";
			System.out.println("^^^^^^^^^^^^^^^租金添加sql=====> "+sqlstr);
			db.executeUpdate(sqlstr);
		}
		//【修改日：2010-07-26】现金流加入保证金抵扣（得到保证金抵扣租金List）,参数：租金List，保证金
		l_RentDetails = rent.getRentDetails(l_rent,caution_money);
		//得到保证金抵扣租金List rent_list  租金List,caut_money  保证金
		new_rent = rent.getRentCautNew(l_rent,caution_money);
	}
	
		
	
	//************************************************************************************************
	//                                            现金流:财务现金流，市场现金流
	//************************************************************************************************
	
	
	//每次插入之前需删除之前插入的数据 【2010-7-30修改，增加项目的现金流表，不再和合同的现金流表共用一张表了】
	String del_sql = " delete  fund_proj_plan_temp where proj_id = '"+proj_id+"' and doc_id = '"+doc_id+"'";
	flag = cashFlow.execProjORcontract_xjl(l_plan_date,l_rent,lease_money,
				 consulting_fee, handling_charge, equip_amt,
				 other_expenditure, caution_money, return_amt,
				 other_income, first_payment, old_start_date,
				 period_type, proj_id, doc_id,
				 creator, create_date, modificator, modify_date,del_sql,"","plan_irr",
				 "fund_proj_plan_temp",before_interest);//财务现金流不需要进行保证金抵扣 
//	System.out.println("2                                                        "+flag);			 
	//市场现金流 
	
	String new_del_sql = " delete  fund_proj_plan_mark_temp where proj_id = '"+proj_id+"' and doc_id = '"+doc_id+"'";
	flag = cashFlow.execProjORcontract_xjl_mark(l_plan_date,new_rent,lease_money,
				 consulting_fee, handling_charge, equip_amt,
				 other_expenditure, caution_money, return_amt,
				 other_income, first_payment, old_start_date,
				 period_type, proj_id, doc_id,
				 creator, create_date, modificator, modify_date,new_del_sql,"","market_irr",
				 "fund_proj_plan_mark_temp",before_interest,l_RentDetails);//
	 //	System.out.println("3                                                        "+flag);
	//现金流补充代码【2010-08-06】
	if(!nominalprice.equals("")){//
		double t_num = Double.valueOf(nominalprice); 
		if(t_num > 0){//留购价大于0才进行此操作
		
			//财务现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值
			String  query_count_cw = " select * from fund_proj_plan_temp where   proj_id = '"+proj_id+"' and doc_id = '"+doc_id+"' ";
			query_count_cw = query_count_cw + " and plan_date = ( select max(plan_date) from fund_proj_plan_temp where proj_id = '"+proj_id+"'  and doc_id = '"+doc_id+"' ) ";
			query_count_cw = query_count_cw + " and id = ( select max(id) from fund_proj_plan_temp where proj_id = '"+proj_id+"'  and doc_id = '"+doc_id+"'  and doc_id = '"+doc_id+"' ) ";
			System.out.println("查询项目财务现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值 ==> "+query_count_cw);
			//调用通用方法,进行‘留购价’的修改操作
			flag = cashFlow.update_xjl_cw(query_count_cw, nominalprice,"fund_proj_plan_temp",proj_id,"");//财务
			//System.out.println("4                                                        "+flag);			
			//市场现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值
			String  query_count_market = " select * from fund_proj_plan_mark_temp  where  proj_id = '"+proj_id+"' and doc_id = '"+doc_id+"'";
			query_count_market = query_count_market + " and plan_date = ( select max(plan_date) from fund_proj_plan_mark_temp where proj_id = '"+proj_id+"'  and doc_id = '"+doc_id+"' ) ";
			query_count_market = query_count_market + " and id = ( select max(id) from fund_proj_plan_mark_temp where proj_id = '"+proj_id+"'  and doc_id = '"+doc_id+"' ) ";
			System.out.println("查询项目市场现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值 ==> "+query_count_cw);
			//调用通用方法
			flag = cashFlow.update_xjl_market(query_count_market, nominalprice,"fund_proj_plan_mark_temp",proj_id,"");//市场
			//System.out.println("5                                                       "+flag);
		}
	}
	
	db.close();
	//所有操作成功后转向页面暂时未有明确需求未做 ***********************************************************
	if(flag>0){
		String hrefStr="";
		if(savaType.equals("del")){//删除成功
%>
        <script>
		//opener.window.location.href = "frkh_list.jsp";
		alert("<%=message%>成功!");
		//opener.location.reload();
		this.close();
		</script>
<%
		}else{//修改添加成功
%>
        <script>
			alert("租金测算成功!");
			opener.parent.location.reload();
			//window.close();
			//opener.location.reload();
			this.close();
		</script>
<%
		}
	}else{
%>
        <script>
			alert("<%=message%>失败!");
			opener.location.reload();
			this.close();
		</script>
<%	
	}
	db.close();
%>
