<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<%@page import="com.rent.calc.bg.* "%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="condition" scope="page" class="com.condition.ConditionOperating" />
<jsp:useBean id="cashFlow" scope="page" class="com.condition.CashFlow" />
<html>
<head>
<title>合同交易结构--租金调整</title>
<!-- 不规则  -->
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%  //该页面是租金调整租金测算页面，主要是针对【租金计算方法】为‘不规则’时的计算，
    //至于‘规则（等额租金/等额本金）’情况下的租金测算详细代码见zjcs_businessOperating.jsp页面
    /* 接参 */
	String doc_id = getStr( request.getParameter("doc_id") );//文档编号 measure_id
	String proj_id = getStr( request.getParameter("proj_id"));//项目编号 
	String contract_id = getStr( request.getParameter("contract_id"));//合同编号
	
	String equip_amt = getZeroStr(getStr( request.getParameter("equip_amt")));//设备款
	String caution_money = getZeroStr(getStr( request.getParameter("caution_money")));//保证金
	String handling_charge = getZeroStr(getStr( request.getParameter("handling_charge")));//手续费
	String start_date = getStr( request.getParameter("start_date"));//起租日
	String year_rate = getZeroStr(getStr( request.getParameter("year_rate")));//年利率
	String income_number = getZeroStr(getStr( request.getParameter("income_number")));//期数
	String lease_money = getZeroStr(getStr( request.getParameter("lease_money")));//租赁本金
	String period_type = getStr( request.getParameter("period_type"));//付租类型
	String income_number_year = getStr( request.getParameter("income_number_year"));//付租方式
	String measure_type = getStr( request.getParameter("measure_type"));//租金计算方法
	String consulting_fee = getZeroStr(getStr( request.getParameter("consulting_fee")));//咨询费
	int countSize = Integer.parseInt(getStr(request.getParameter("countSize")));//分期总数
	int flag = 0;
	
	//现金流存入的需要
	String creator = getStr( request.getParameter("creator"));//创建人
	String create_date = getStr( request.getParameter("create_date"));//创建日期
	String modificator = getStr( request.getParameter("modificator"));//修改人
	String modify_date = getStr( request.getParameter("modify_date"));//修改日期
	String old_start_date = start_date;		//用于现金流
	//新增取值 【修改时间2010-06-29】
	String other_income = getZeroStr(getStr(request.getParameter("other_income")));//其他收入
	String other_expenditure = getZeroStr(getStr(request.getParameter("other_expenditure")));//其他支出
	String first_payment = getZeroStr(getStr(request.getParameter("first_payment")));//首付款
	String return_amt = getZeroStr(getStr(request.getParameter("return_amt")));//厂商返利
	String income_day = getStr(request.getParameter("income_day"));//每月偿付日
	String net_lease_money = getZeroStr(getStr(request.getParameter("net_lease_money")));//净融资额
	String nominalprice = getZeroStr(getStr(request.getParameter("nominalprice")));//期末残值(或名义留购价)
	
	//新增取值【2010-07-23】
	String before_interest = getZeroStr(getStr(request.getParameter("before_interest")));//租前息
	//新增取值【2010-08-20】
	String rentScale = getZeroStr(getStr(request.getParameter("rentScale")));//圆整到
	
		
	String zjtz = "";
	//封装资金流和自即日起的数组
	List<String> list_cash = new ArrayList<String>();
	List<String> list_date = new ArrayList<String>();
	//封装 ‘不规则’租金测算之租金列表  ‘租金’+‘调整租金’组成新的租金列表
	List<String> list_cashRent = new ArrayList<String>();
	
	//修改：-净融资额 net_lease_money-保证金 caution_money  算财务IRR
	Double list_mon =( Double.parseDouble(net_lease_money) + Double.parseDouble(caution_money) )*-1;
	list_cash.add(list_mon.toString());
	list_date.add(start_date);
	
	//装入 租赁本金，咨询费，手续费
	//String money = "-"+lease_money;
	//装入租赁本金
	//list_cash.add(money);
	//list_date.add(start_date);
	//装入咨询费
	//list_cash.add("-"+consulting_fee);
	//list_date.add(start_date);
	//装入手续费
	//list_cash.add(handling_charge);	
	//list_date.add(start_date);

	if(countSize > 0){
		for(int i = 0;i< countSize;i++){
			String zjtzName = "zjtz"+i;
			String nameValue = getStr(request.getParameter(zjtzName));
			String plan_dateName = "plan_date"+i;
			String rentDate = getStr(request.getParameter(plan_dateName));
			//如果调整租金具体行的输入框未输入值表示 该期租金未做任何调整反之则调整
			if(nameValue.equals("") || nameValue == null){
				//未作调整则取出对应行中原本的租金值
				String tentName = "rent"+i;
				String rentValue = getStr(request.getParameter(tentName));
				//list_cash.add(rentValue);//未调整则取对应的原本租金装入list
				list_cashRent.add(rentValue);
			}else{//进行租金调整则取输入的调整租金装入list
				String zjtzValue = getStr(request.getParameter(zjtzName));
				//list_cash.add(zjtzValue);
				list_cashRent.add(zjtzValue);
			}
			//装入现金流对应的日期
			//list_date.add(rentDate);
		}		
	}
	
	String now_start_date = start_date.substring(0,8)+income_day;
	//租金测算程序
	List l_plan_date = new ArrayList();
	List l_rent = new ArrayList();
	List l_corpus = new ArrayList();
	List l_interest = new ArrayList();
	List l_corpus_overage = new ArrayList();
	//具体测算
	RentCalc rent = new RentCalc();
	//封装 资金流 例如 租赁本金，手续费，保证金
	rent.setPreCash(list_cash);//
    rent.setPreDate(list_date);//
    //封装租金测算的条件	
	rent.setYear_rate(year_rate); //年利率   
	rent.setIncome_number(income_number);//期数 
	rent.setLease_money(lease_money);//租赁本金
	rent.setFuture_money(nominalprice);//留购价  【2010-08-04 修改前是“0”】
	rent.setPeriod_type(period_type);//1,期初 0,期未的值 
	rent.setIrr_type("2");//1,为按月份的处; 2,为按租金间隔的处理 暂时是2
	rent.setScale("8");//irr的小数位数 暂时就是8位
	rent.setLease_interval(income_number_year);//租金间隔 (付租方式)
	rent.setPlan_date(start_date);//起租日  
	rent.setContract_id(contract_id);//计算具体合同现金流的KEY
	rent.setRentScale(rentScale);//圆整到 【新增字段 2010-08-20】

	//新增四个字段  【**************** 测算市场IRR所需的附加条件 *****************】【修改时间2010-06-29】
	Double mon = Double.parseDouble(net_lease_money)+ Double.parseDouble(caution_money);
	rent.setCle_cau_Money(mon.toString());//净融资额 net_lease_money+保证金 caution_money
	rent.setCauti_Money(caution_money);//保证金
	rent.setFuture_money(nominalprice);//期末残值 【注：加负号变为负数】【2010-08-04 修改去掉负号】
	rent.setStart_date(now_start_date);//保证金的流入时间
	
	//for(int i = 0; i< list_cashRent.size();i++){
	//   System.out.println("^^^^^^^^^^^^^^^list_cash为"+list_cashRent.get(i));
	//    System.out.println("^^^^^^^^^^^^^^^list_date为"+list_date.get(i));
	//    System.out.println("");
	//}
	//‘不规则’情况下，租金具体测算如下：
	List rent_list = list_cashRent;// 得到租金list,注意不规则时的租金list (只是新的租金的LIST，不包含 手续费那些现金)
	//getPlanDateList(参数一,参数二)   参数一 上方数组，租金list 参数二 期初(1)or期末支付(0)
	List l_plan_date_ = rent.getPlanDateList(rent_list, rent.getPeriod_type());// 计划时间 
	//租金计算方式 不规则按等额租金计算
	String str_temp = measure_type;
	if(measure_type.equals("0")){
		str_temp = "1";
	}
	//参数说明 getHashRentPlan(参数一,参数二,参数三) 
	//参数一代表：measure_type租金计算方法，参数二代表：上方的list 封装的所有租金列表 
	//参数三 l_plan_date_ 上方数组 封装时间的结果集
	HashMap hm = rent.getHashRentPlan(str_temp, rent_list, l_plan_date_);
	//取值
	l_plan_date = (List)hm.get("plan_date");//租金偿还日期
	l_rent = (List)hm.get("rent");//租金
	l_corpus = (List)hm.get("corpus");//本金
	l_interest = (List)hm.get("interest");//利息
	l_corpus_overage = (List)hm.get("corpus_overage");//剩余本金
	
	//计算irr  
	//String getIrr = rent.getV_irr();
	Double getIrr = Double.parseDouble(rent.getV_irr())*100;	
	//市场IRR 【修改时间2010-06-29】
	Double Markirr = Double.parseDouble(rent.getMarket_irr())*100;
	//修改合同交易结构临时表contract_condition_temp中的计划IRR的值
	String sqlstr = "update contract_condition_temp set plan_irr="+getIrr+",market_irr = "+Markirr+" where contract_id='"+contract_id+"' and measure_id='"+doc_id+"' ";
	flag = db.executeUpdate(sqlstr);
		
	//System.out.println("join0--------------------------------------------------------------------->");
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
	
	
	String  measure_id = doc_id;//文档编号 对应表fund_rent_plan_temp中的测算编号
	//删除对应 ‘项目编号’和‘文档编号’在表fund_rent_plan_temp中以前的租金测算计划
	sqlstr = "delete from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+measure_id+"'";
	flag = db.executeUpdate(sqlstr);
	sqlstr = "";
	//拼装新的租金测算增加语句，往表fund_rent_plan_temp中将测算后的值插入数据,成功后刷新该页面的父页
	for(int i=0;i<l_rent.size();i++){
	//文档编号(测算编号),合同编号,回笼状态,租金,本金,租息,本金余额,年利率
		sqlstr+="  insert into fund_rent_plan_temp"+
		       "(measure_id,contract_id,"+
		       "rent_list,plan_date,plan_status,rent,corpus,"+
		       "interest,corpus_overage,year_rate,corpus_market,interest_market,corpus_overage_market) "+
		       "select '"+doc_id+"','"+contract_id+"',"+(i+1)+","+
		       "'"+l_plan_date.get(i)+"','未回笼',"+l_rent.get(i)+","+
		       ""+l_corpus.get(i)+","+l_interest.get(i)+","+
		       ""+l_corpus_overage.get(i)+","+year_rate+","+
		       l_corpus_market.get(i)+","+l_interest_market.get(i)+","+l_corpus_overage_market.get(i)+" ;";
	}
	//System.out.println("===sqlo===:"+sqlstr);
	flag = db.executeUpdate(sqlstr);
	
	
	//************************************************************************************************
	//                                            现金流
	//************************************************************************************************
	//【修改日：2010-07-26】现金流加入保证金抵扣（得到保证金抵扣租金List）,参数：租金List，保证金
	List l_RentDetails = rent.getRentDetails(l_rent,caution_money);

	//每次插入之前需删除之前插入的数据 注意合同这里传入的是contract_id而不是项目编号
	String del_sql = " delete from fund_contract_plan where contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"'";
	flag = cashFlow.execProjORcontract_xjl(l_plan_date,l_rent,lease_money,
				 consulting_fee, handling_charge, equip_amt,
				 other_expenditure, caution_money, return_amt,
				 other_income, first_payment, old_start_date,
				 period_type, proj_id, doc_id,
				 creator, create_date, modificator, modify_date,del_sql,contract_id,"plan_irr",
				 "fund_contract_plan_temp",before_interest);//
	
	//市场现金流 
	//得到保证金抵扣租金List rent_list  租金List,caut_money  保证金
	List new_rent = rent.getRentCautNew(l_rent,caution_money);
	String new_del_sql = " delete from fund_contract_plan_mark where contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"'";
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
			query_count_cw = query_count_cw + " and plan_date = ( select max(plan_date) from fund_contract_plan_temp where contract_id = '"+contract_id+"' ) ";
			query_count_cw = query_count_cw + " and id = ( select max(id) from fund_contract_plan_temp where contract_id = '"+contract_id+"' ) ";
			System.out.println("查询合同不规则财务现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值 ==> "+query_count_cw);
			//调用通用方法,进行‘留购价’的修改操作
			flag = cashFlow.update_xjl_cw(query_count_cw, nominalprice,"fund_contract_plan_temp","",contract_id);//财务
			
			//市场现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值
			String  query_count_market = " select * from fund_contract_plan_mark_temp  where  contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"'";
			query_count_market = query_count_market + " and plan_date = ( select max(plan_date) from fund_contract_plan_mark_temp where contract_id = '"+contract_id+"' ) ";
			query_count_market = query_count_market + " and id = ( select max(id) from fund_contract_plan_mark_temp where contract_id = '"+contract_id+"' ) ";
			System.out.println("查询合同不规则市场现金流最大一期的 流入量，流入量清单，净流浪 三个字段的值 ==> "+query_count_cw);
			//调用通用方法
			flag = cashFlow.update_xjl_market(query_count_market, nominalprice,"fund_contract_plan_mark_temp","",contract_id);//市场
		}
	}
				 
	db.close();
	if(flag > 0){
%>
		<script>
			alert("租金调整成功!");
			opener.parent.location.reload();
			window.close();
		</script>
<%
	}else{
%>
        <script>
			alert("租金调整失败!");
			opener.parent.location.reload();
			window.close();
		</script>
<%	
	}
%>
