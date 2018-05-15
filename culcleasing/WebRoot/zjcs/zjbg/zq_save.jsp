<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<%@ page import="com.rent.*"%>
<%@page import="com.rent.calc.*"%>
<%@page import="com.rent.calc.bg.RentCalc"%>
<%@page import="com.condition.Tx_Init"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<!--  租金偿还计划变更--变更测算页  -->
<jsp:useBean id="condition" scope="page" class="com.condition.ConditionOperating" />
<jsp:useBean id="cashFlow" scope="page" class="com.condition.CashFlow" />
<jsp:useBean id="tools" scope="page" class="com.Tools" />
<jsp:directive.page import="com.rent.calc.rentcharge.RentChange"/>
<%
	//String czyid = (String)session.getAttribute("czyid");
	//String datestr = getSystemDate(0);
	String sqlstr;
	ResultSet rs;
	String message = "";
	
	int flag = 0;
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号
	String contract_id = getStr(request.getParameter("contract_id"));//项目编号 proj_id
	String start_list = getZeroStr(getStr(request.getParameter("start_list")));//调整开始期数
	String adjust_list = getZeroStr(getStr(request.getParameter("adjust_list")));//调整后期数
	String year_rate = getZeroStr(getStr(request.getParameter("year_rate")));//年利率
	String lease_money = getZeroStr(getStr(request.getParameter("lease_money")));//除去已回笼的剩余本金总额
	String handling_charge = getZeroStr(getStr(request.getParameter("handling_charge")));//手续费
	String start_date = getStr(request.getParameter("start_date"));//对应调整期数的起租日
	String tz_date = getStr(request.getParameter("tz_date"));//对应调整期数的日期 【新增字段：2010-11-26】
	//第一步：根据变更的start_list期项查询出对应的日期  注意这里查询的是正式表
	String query_date_s = " select plan_date from fund_rent_plan  where contract_id = '"+contract_id+"' and measure_id='"+doc_id+"'";
	query_date_s = query_date_s + " and rent_list =  '"+start_list+"'";
	String bg_plan_date = "";
	ResultSet rs_d = null;
	rs_d = db.executeQuery(query_date_s);
	System.out.println("查询bg_plan_date-->"+query_date_s);
	while(rs_d.next()){
		bg_plan_date = getDBDateStr(rs_d.getString("plan_date"));
	}
	System.out.println("bg_plan_date-->"+bg_plan_date);
		
		
	String measure_type = "";//租金计算方式
	String period_type = "";// 0期初，1期末 付 
	String income_number_year = "";//付租方式 1月 3季 6半年 12年
	String  equip_amt = "";//设备金额
	String  caution_money = "";//保证金
	String  zulinbenjin_money = "";//合同交易结构表中的租赁本金
	String  consulting_fee = "";//咨询费
	String  other_expenditure = "";//其他支出 【修改时间：2010-12-07】
	String  other_income = "";//其他收入 【修改时间：2010-12-07】
	String  return_amt = "";// 【修改时间：2010-12-07】
	String  first_payment = "";//首付款 【修改时间：2010-12-07】
	String  before_interest = "";//租前息 【修改时间：2010-12-07】
	
	String creator = "";//
	String create_date = "";//
	String modificator = "";//
	String modify_date = "";//
	
	//******************************************************************************************************
	//调整后期数 - 调整前期数 = 需调整的总期数 (注意:包含本期需要加1)
	int countDate = Integer.parseInt(adjust_list) - Integer.parseInt(start_list) + 1;//调整后总期数
	String count_adjust = String.valueOf(countDate);//最终需要调整的期数
	
	//修改交易结构中关于租金偿还计划变更所更改的‘租赁年利率’以及‘换租次数’,后续需要更改再加...............................?
	StringBuffer sql_update = new StringBuffer();
	//income_number 还租次数  租赁年利率year_rate 
	sql_update.append(" update contract_condition_temp  set ")
			  .append(" income_number = '"+adjust_list+"', ")
			  .append(" year_rate = '"+year_rate+"', ")
			  .append(" income_day = '"+tz_date+"' ")
			  .append(" where contract_id = '"+contract_id+"' ")
			  .append(" and measure_id='"+doc_id+"' ");
	db.executeUpdate(sql_update.toString());
	System.out.println("修改交易结构==>  : "+sql_update);
	
	//【2011-03-29 需求增加，新增一张表fund_rent_adjust用于记录变更的的一些操作】
	//插入先先删除
	sqlstr = " delete from fund_rent_adjust where contract_id = '"+contract_id+"' and measure_id='"+doc_id+"' ";
	db.executeUpdate(sqlstr);
	sqlstr = " ";
	sqlstr = " insert into fund_rent_adjust (measure_id,contract_id,adjust_type,start_list,income_number,income_day,corpus_overage,year_rate,create_date) ";
	sqlstr = sqlstr  + " values ('"+doc_id+"','"+contract_id+"','租金变更','"+start_list+"','"+adjust_list+"','"+tz_date+"','"+lease_money+"','"+year_rate+"',GETDATE()) ";
	db.executeUpdate(sqlstr);
	System.out.println("记录变更==>  : "+sqlstr);
	sqlstr = " ";
	//查询需要进行租金测算的一些条件
	sqlstr = " select * from contract_condition_temp where contract_id = '"+contract_id+"' and measure_id='"+doc_id+"'  ";
	rs = db.executeQuery(sqlstr);
	System.out.println("sql==>sql==>  : "+sqlstr);
	rs.last();
	int count_data = rs.getRow();
	rs.beforeFirst();
	if(count_data > 0){
		sqlstr = "";
		while(rs.next()){
			period_type = getZeroStr(getDBStr(rs.getString("period_type")));//期初期末
			income_number_year = getZeroStr(getDBStr(rs.getString("income_number_year")));//
			handling_charge = getZeroStr(getDBStr(rs.getString("handling_charge")));//手续费
			equip_amt = getZeroStr(getDBStr(rs.getString("equip_amt")));//设备金额
			caution_money = getZeroStr(getDBStr(rs.getString("caution_money")));//保证金
			zulinbenjin_money = getZeroStr(getDBStr(rs.getString("lease_money")));//租赁本金
			measure_type = getDBStr(rs.getString("measure_type"));//租金计算方式
			consulting_fee = getZeroStr(getDBStr(rs.getString("consulting_fee")));//咨询费
			
			creator = getDBStr(rs.getString("creator"));
			create_date = getDBStr(rs.getString("create_date"));
			modificator = getDBStr(rs.getString("modificator"));
			modify_date = getDBStr(rs.getString("modify_date"));
			
			other_expenditure = getDBStr(rs.getString("other_expenditure"));
			other_income = getDBStr(rs.getString("other_income"));
			return_amt = getDBStr(rs.getString("return_amt"));
			first_payment = getDBStr(rs.getString("first_payment"));
			before_interest = getDBStr(rs.getString("before_interest"));
		}
	
	//?进入页面要将租金测算表中的数据移动到临时表中去
	RentChange rc = new RentChange();
	Hashtable ht = 	rc.getRentChargePlan(contract_id,start_list,year_rate,String.valueOf(countDate),tz_date);
	String market_irr = ht.get("market_irr").toString();//市场irr
	String finac_irr = ht.get("finac_irr").toString();//财务irr
	//修改irr
	List date_list = (List) ht.get("l_date");//日期
	List rent_list = (List) ht.get("rent_list");//租金
	List corpus_market = (List) ht.get("corpus_market_list");// 市场本金
	List inter_list = (List) ht.get("inter_list");// 市场利息
	List corpusOverge_market = (List) ht.get("corpusOverge_market_list");// 市场本金余额
	List inter_fina_list = (List) ht.get("inter_fina_list");// 财务利息
	List corpus_fina_list = (List) ht.get("corpus_fina_list");// 财务本金
	List corpusOverage_fina_list = (List) ht.get("corpusOverage_fina_list");// 财务本金余额
	//删除从第几期开始调整的租金偿还计划用于下方插入新生产的偿还计划
	StringBuffer in_sql = new StringBuffer();
	//得到之前租金计划插入到偿还计划表中
	//in_sql.append(" insert into fund_rent_plan_temp  ")
	//      .append(" (measure_id,contract_id,rent_list,plan_date,plan_status,rent,corpus, ") 
	//      .append(" interest,corpus_overage,year_rate,corpus_market,interest_market,corpus_overage_market) ") 
	//      .append(" select measure_id,contract_id,rent_list,plan_date,plan_status,rent,corpus, ") 
	//      .append("  interest,corpus_overage,  ") 
	//      .append(year_rate)
	//      .append(" ,corpus_market,interest_market,corpus_overage_market ") 
	//      .append(" from  fund_rent_plan_temp ") 
	//      .append(" where contract_id = '"+contract_id+"' and measure_id='"+doc_id+"' ") 
	//      .append(" and rent_list <  ")
	//      .append(start_list) 
	//      .append("  "); 
	 in_sql.append(" delete from fund_rent_plan_temp ")
	       .append(" where contract_id = '"+contract_id+"' and measure_id='"+doc_id+"'  ")      
	       .append(" and rent_list >= ")      
	       .append(start_list)       
	       .append("  ");      
	 System.out.println("删除从第几期开始的偿还计划==>  : "+in_sql);
	    db.executeUpdate(in_sql.toString());
	    //将调整后的接着插入到租金偿还计划表中      
	    for(int i=0;i<rent_list.size();i++){
		//插入字段顺序:文档编号(测算编号),合同编号,回笼状态,租金,本金,租息,本金余额,年利率
			sqlstr="insert into fund_rent_plan_temp"+
			       "(measure_id,contract_id,"+
			       "rent_list,plan_date,plan_status,rent,corpus,"+
			       "interest,corpus_overage,year_rate,corpus_market,interest_market,corpus_overage_market) "+//期数是接着调整开始的期数开始的
			       "select '"+doc_id+"','"+contract_id+"',"+(i+Integer.parseInt(start_list))+","+
			       "'"+date_list.get(i)+"','未回笼',"+rent_list.get(i)+","+
			       ""+corpus_fina_list.get(i)+","+inter_fina_list.get(i)+","+
			       ""+corpusOverage_fina_list.get(i)+","+year_rate+","+
			       corpus_market.get(i)+","+inter_list.get(i)+","+corpusOverge_market.get(i)+" ;";
			System.out.println("^^^^^^^^^^^^^^^插入新的偿还计划====="+sqlstr);
			flag = db.executeUpdate(sqlstr);
		}	
	//income_number 还租次数  租赁年利率year_rate 
	//计算irr  
	String getIrr = finac_irr;
	//市场IRR 【修改时间2010-06-29】
	String Markirr = market_irr;
	//plan_irr="+tools.formatNumberDoubleScale(getIrr,8)+"*100,market_irr = "+tools.formatNumberDoubleScale(Markirr,8)+"*100
	String update_s = "update contract_condition_temp set plan_irr="+tools.formatNumberDoubleScale(getIrr,8)+"*100,market_irr = "+tools.formatNumberDoubleScale(Markirr,8)+"*100   where contract_id='"+contract_id+"' and measure_id = '"+doc_id+"' ";
	flag = db.executeUpdate(update_s);	
		
		
		//************************************************************************************************
		//                                            现金流2010-12-07
		//************************************************************************************************
		System.out.println("rent_list。size-->"+rent_list.size());
		//第一步在上面
		//第二步：删除现金流中已经变更的租金计划重新生成新的xjl
		String del_sql1 = " delete from fund_contract_plan_temp  where contract_id = '"+contract_id+"' and doc_id='"+doc_id+"' and  plan_date >= '"+bg_plan_date+"' ";
		String del_sql2 = " delete from fund_contract_plan_mark_temp  where contract_id = '"+contract_id+"' and doc_id='"+doc_id+"' and  plan_date >= '"+bg_plan_date+"' ";
		flag = db.executeUpdate(del_sql1);
		System.out.println("删除财务现金流-->"+del_sql1);
		flag = db.executeUpdate(del_sql2);
		System.out.println("删除市场现金流-->"+del_sql2);
		//第三步：查询第2期的租金偿还计划对应的日期用于下方第四步的集合操作
		String query_date_2 = " select plan_date from fund_rent_plan_temp  where contract_id = '"+contract_id+"' and measure_id='"+doc_id+"'";
		query_date_2 = query_date_2 + " and  rent_list =  '2'";
		rs_d = db.executeQuery(query_date_2);
		System.out.println("查询第二期的plan_date-->"+query_date_2);
		String plan_date_2 = "";
		while(rs_d.next()){
			plan_date_2 = getDBDateStr(rs_d.getString("plan_date"));
		}
		System.out.println("plan_date_2-->"+plan_date_2);
		//第四步:查询现金流表中是除去第一期到变更前所有流出的sum（follow_out）,用交易结构中的保证金减去该值得到最终的保证金用于第五步操作
		String qy_s = " select isnull(SUM(isnull(follow_out,0)),0)  as sumMon from  fund_contract_plan_temp ";
		qy_s = qy_s + " where contract_id = '"+contract_id+"' and doc_id='"+doc_id+"' ";
		qy_s = qy_s + " and plan_date >= '"+plan_date_2+"' and plan_date < '"+bg_plan_date+"'";
		rs_d = db.executeQuery(qy_s);
		System.out.println("查询sumMon-->"+qy_s);
		String sumMon = "";
		while(rs_d.next()){
			sumMon = getDBStr(rs_d.getString("sumMon"));
		}
		System.out.println("sumMon-->"+sumMon);
		Double t_money = Double.valueOf(caution_money) - Double.valueOf(sumMon);
		System.out.println("t_money-->"+t_money);
		//第五步：得到保证金抵扣的租金list 市场现金流用到	这里的保证金经过了第四步的处理防止前几期已经做了保证金抵扣操作,这里的得到的值用于第七步操作
		RentCalc rent = new RentCalc();	
		List mark_rent = rent.getRentDetails(rent_list,String.valueOf(t_money));	
		String proj_id = "";
		//第六步：财务现金流变更部分重新生成后续部分的现金流
		flag = cashFlow.zjbg_cw_xjl(date_list,rent_list,lease_money,
				 consulting_fee, handling_charge, equip_amt,
				 other_expenditure, caution_money, return_amt,
				 other_income, first_payment, start_date,
				 period_type, proj_id, doc_id,
				 creator, create_date, modificator, modify_date,del_sql1,contract_id,"plan_irr",
				 "fund_contract_plan_temp",before_interest);//
		//第七步:市场现金流处理 和财务现金流的区别在于传入的租金list是经过保证金抵扣的租金list
		flag = cashFlow.zjbg_mark_xjl(date_list,rent_list,lease_money,
				 consulting_fee, handling_charge, equip_amt,
				 other_expenditure, caution_money, return_amt,
				 other_income, first_payment, start_date,
				 period_type, proj_id, doc_id,
				 creator, create_date, modificator, modify_date,del_sql2,contract_id,"market_irr",
				 "fund_contract_plan_mark_temp",before_interest,mark_rent);//
				 
		rs_d.close();
	}
	
	
	//新加需求 更新合同交易结构的irr IRR根据现金流的净流量重新做过计算
	Tx_Init tx_Init =  new Tx_Init();
	flag = tx_Init.js_irr_temp(contract_id,doc_id);
	db.close();
	
	
	
	

	if(flag > 0){
		message = "租金变更操作成功!";	
	}else{
		message = "租金变更失败,原因可能为对应编号的交易结构数据不存在或者已更改!";
	}
%>
<script>
	window.close();
	opener.alert("<%=message%>");
	opener.parent.location.reload();
</script>
