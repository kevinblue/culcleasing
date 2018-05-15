<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<%@ page import="com.rent.*"%>
<%@page import="com.rent.calc.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<!--  租金偿还计划变更--变更测算页  -->
<%
	//String czyid = (String)session.getAttribute("czyid");
	//String datestr = getSystemDate(0);
	
	String sqlstr;
	ResultSet rs;
	
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号
	String contract_id = getStr(request.getParameter("contract_id"));//项目编号 proj_id
	
	String start_list = getStr(request.getParameter("start_list"));//调整开始期数
	String adjust_list = getStr(request.getParameter("adjust_list"));//调整后期数
	String year_rate = getStr(request.getParameter("year_rate"));//年利率
	String lease_money = getStr(request.getParameter("lease_money"));//本金总额
	String handling_charge = getStr(request.getParameter("handling_charge"));//手续费
	String start_date = getStr(request.getParameter("start_date"));//对应调整期数的起租日
	String period_type = "";// 0期初，1期末 付 
	String income_number_year = "";//付租方式 1月 3季 6半年 12年
	//调整后期数 - 调整前期数 = 需调整的总期数 (注意:包含本期需要加1)
	int countDate = Integer.parseInt(adjust_list) - Integer.parseInt(start_list) + 1;//调整后总期数
	String count_adjust = String.valueOf(countDate);//最终需要调整的期数
	
	handling_charge = "0";
	//修改交易结构中关于租金偿还计划变更所更改的‘租赁年利率’以及‘换租次数’,后续需要更改再加...............................?
	StringBuffer sql_update = new StringBuffer();
	//income_number 还租次数  租赁年利率year_rate 
	sql_update.append(" update contract_condition  set ")
			  .append(" income_number = '"+adjust_list+"', ")
			  .append(" year_rate = '"+year_rate+"' ")
			  .append(" where proj_id = '"+contract_id+"' ");
	db.executeUpdate(sql_update.toString());
	//查询需要进行租金测算的一些条件
	sqlstr = " select * from contract_condition where proj_id = '"+contract_id+"'  ";
	rs = db.executeQuery(sqlstr);
	sqlstr = "";
	if(rs.next()){
		period_type = getDBStr(rs.getString("period_type"));//
		income_number_year = getDBStr(rs.getString("income_number_year"));//
	}
	//*******************************************************************************************
	//进行租金测算 
	List l_plan_date = new ArrayList();
	List l_rent = new ArrayList();
	List l_corpus = new ArrayList();
	List l_interest = new ArrayList();
	List l_corpus_overage = new ArrayList();
	//存入租金测算条件
	RentCalc rent = new RentCalc();
	rent.setYear_rate(year_rate); //年利率   
	rent.setIncome_number(count_adjust);//期数 (从具体调整的期数算起)
	rent.setLease_money(lease_money);//融资额 (剩余本金总额)
	rent.setFuture_money("0");//未来值 
	rent.setPeriod_type(period_type);//1,期初 0,期未的值 
	rent.setIrr_type("2");//1,为按月份的处; 2,为按租金间隔的处理 暂时是2
	rent.setScale("2");//irr的小数位数 暂时就是2位
	rent.setLease_interval(income_number_year);//租金间隔 (付租方式)
	rent.setPlan_date(start_date);//起租日  
	//计算前的现金流存入
	//???????????????????????????????????????????????????????????????????????????
	//具体测算
	HashMap hm = rent.getHashRentPlan(period_type);
	l_plan_date = (List)hm.get("plan_date");
	l_rent = (List)hm.get("rent");
	l_corpus = (List)hm.get("corpus");
	l_interest = (List)hm.get("interest");
	l_corpus_overage = (List)hm.get("corpus_overage");
System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^count_adjust"+count_adjust);	
	//计算irr  
	String irr = "";
	irr = String.valueOf(Double.parseDouble(rent.getV_irr())*100);
	//修改‘拟商务条件’表中计划IRR的值
	String update_irr = "update contract_condition set plan_irr="+irr+" where proj_id='"+contract_id+"'";
	db.executeUpdate(update_irr);
	
	//租金测算表  fund_rent_plan_temp //测算编号 等于 文档编号
	StringBuffer sql_del_frpt = new StringBuffer();
	//删除从第几期开始操作租金偿还计划变更的租金测算列表
	sql_del_frpt.append(" delete from fund_rent_plan_temp where measure_id='"+doc_id+"'  ")
	            .append(" and contract_id ='"+contract_id+"' ")
	            .append(" and measure_id = '"+doc_id+"' ")
	            .append(" and rent_list >= '"+start_list+"' ")//从开始调整的那期删除后面的所有期
	            ;//.append(" and plan_status  ");//后面存在回笼的期暂时未需求$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$?
	db.executeUpdate(sql_del_frpt.toString());
	for(int i=0;i<l_rent.size();i++){
	//插入字段顺序:文档编号(测算编号),合同编号,回笼状态,租金,本金,租息,本金余额,年利率
		sqlstr="insert into fund_rent_plan_temp"+
		       "(measure_id,contract_id,"+
		       "rent_list,plan_date,plan_status,rent,corpus,"+
		       "interest,corpus_overage,year_rate) "+//期数是接着调整开始的期数开始的
		       "select '"+doc_id+"','"+contract_id+"',"+(i+Integer.parseInt(start_list))+","+
		       "'"+l_plan_date.get(i)+"','未回笼',"+l_rent.get(i)+","+
		       ""+l_corpus.get(i)+","+l_interest.get(i)+","+
		       ""+l_corpus_overage.get(i)+","+year_rate;
//System.out.println("^^^^^^^^^^^^^^^sqlstr2====="+sqlstr);
		db.executeUpdate(sqlstr);
	}	
db.close();
%>
<script>
	opener.alert("成功!");
	//暂时不刷新父页的所有窗口
	//opener.parent.location.reload();
	window.close();
</script>
