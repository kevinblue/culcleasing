<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<%@ page import="com.rent.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金测算 - 拟商务条件 - 数据操作页</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
</head>

<!-- 表单字段及对应中文描述 以备修改使用 
//proj_id currency equip_amt first_payment lease_money caution_money  net_lease_money handling_charge 
//  income_number_year lease_term income_number nominalprice period_type return_amt year_rate rate_float_type
//  before_interest rate_adjustment_modulus pena_rate income_day start_date plan_irr measure_type other_income
//  other_expenditure creator create_date modify_date modificator
// 项目编号 货币类型 申请金额(设备金额) 首付款 租赁本金 租赁保证金 净融资额 手续费（经销商）付租方式 
// 租赁期限(月)  还租次数 期末残值(或名义留购价) 付租类型 厂商返利 租赁年利率 利率浮动类型 租前息 before_interest
//      利率调整系数 罚息利率 每月偿付日 起租日 计划IRR 租金计算方法 其他收入 其他支出 登记人 登记时间 更新日期 更新人 
 -->
<BODY>
<%
	String savaType = getStr(request.getParameter("savetype"));
	StringBuffer sql = new StringBuffer();
	ResultSet rs = null;
	int flag = 0;
	String message = "";
		//接参
	    String proj_id = getStr(request.getParameter("proj_id")); //项目编号
		String currency = getStr(request.getParameter("currency"));//货币类型
		String equip_amt = getStr(request.getParameter("equip_amt"));//申请金额(设备金额)
		String first_payment = getStr(request.getParameter("first_payment"));//首付款
		String lease_money = getStr(request.getParameter("lease_money"));//租赁本金
		String caution_money = getStr(request.getParameter("caution_money"));//租赁保证金
		String net_lease_money = getStr(request.getParameter("net_lease_money"));//净融资额
		String handling_charge = getStr(request.getParameter("handling_charge"));//手续费（经销商）
		String income_number_year = getStr(request.getParameter("income_number_year"));//付租方式
		String lease_term = getStr(request.getParameter("lease_term"));//租赁期限(月)
		String income_number = getStr(request.getParameter("income_number"));//还租次数
		String nominalprice = getStr(request.getParameter("nominalprice"));//期末残值(或名义留购价)
		String period_type = getStr(request.getParameter("period_type"));//付租类型 period_type
		String return_amt = getStr(request.getParameter("return_amt"));//厂商返利
		String year_rate = getStr(request.getParameter("year_rate"));//租赁年利率
		String rate_float_type = getStr(request.getParameter("rate_float_type"));//利率浮动类型
		String before_interest = getStr(request.getParameter("before_interest"));//租前息
		String rate_adjustment_modulus = getStr(request.getParameter("rate_adjustment_modulus"));//利率调整系数
		String pena_rate = getStr(request.getParameter("pena_rate"));//罚息利率
		String income_day = getStr(request.getParameter("income_day"));//每月偿付日
		String start_date = getStr(request.getParameter("start_date"));//起租日
		String plan_irr = getStr(request.getParameter("plan_irr"));//计划IRR
		String measure_type = getStr(request.getParameter("measure_type"));//租金计算方法
		String other_income = getStr(request.getParameter("other_income"));//其他收入
		String other_expenditure = getStr(request.getParameter("other_expenditure"));//其他支出
		String creator = getStr(request.getParameter("creator"));//登记人
		String create_date = getStr(request.getParameter("create_date"));//登记时间
	    String modify_date = getStr(request.getParameter("modify_date"));//更新日期
		String modificator = getStr(request.getParameter("modificator"));//更新人
	//SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//格式化时间
	//String nowTime=sdf.format(new Date());//当前格式化之后的时间
	System.out.print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
	if(savaType.equals("add")){//拟商务条件添加操作
	System.out.print("拟商务条件添加join$$$##########################################");
		//拼装添加‘拟商务条件’sql语句
		sql.append("INSERT INTO contract_condition (proj_id ,currency ,equip_amt ,lease_money ,lease_term")
           .append(",income_number_year,income_number,year_rate,rate_float_type,period_type,income_day")
           .append(",start_date,first_payment,caution_money,handling_charge,return_amt,nominalprice")
           .append(",pena_rate,net_lease_money,plan_irr,measure_type,creator,create_date")
           .append(",modificator,modify_date,before_interest,rate_adjustment_modulus,other_income,other_expenditure,remark)")
     	   .append(" VALUES ('"+proj_id+"','"+currency+"','"+equip_amt+"','"+lease_money+"'")
           .append(" ,'"+lease_term+"','"+income_number_year+"','"+income_number+"','"+year_rate+"'")
           .append(" ,'"+rate_float_type+"','"+period_type+"','"+income_day+"','"+start_date+"'")
           .append(" ,'"+first_payment+"','"+caution_money+"','"+handling_charge+"','"+return_amt+"'")
           .append(" ,'"+nominalprice+"','"+pena_rate+"','"+net_lease_money+"'")
           .append(" ,'"+plan_irr+"','"+measure_type+"','"+creator+"','"+create_date+"'")
           .append(",'"+modificator+"','"+modify_date+"','"+before_interest+"','"+rate_adjustment_modulus+"'")
           .append(" ,'"+other_income+"','"+other_expenditure+"','')");
		
		System.out.print("增加拟商务条件增加SQL-->   "+sql.toString());
		//执行添加sql语句
		flag = db.executeUpdate(sql.toString());
		message="增加拟商务条件";
	} 
	if(savaType.equals("mod")){//修改拟商务条件
		//拼装修改SQL语句 主键是项目编号
		sql.append("UPDATE contract_condition ")
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
	      .append(",other_expenditure = '"+other_expenditure+"' ")
	      //.append(",remark = '"+remark+"' ")//备注暂时未加
	      .append(",before_interest = '"+before_interest+"' ")
	 	  .append("WHERE proj_id = '"+proj_id+"' ");
		System.out.print("增加拟商务条件修改SQL-->   "+sql.toString());
		flag = db.executeUpdate(sql.toString());
		message = "修改拟商务条件";
	}
	if(savaType.equals("del")){//删除数据
		//根据主键‘项目编号’进行数据删除操作
		sql.append("delete from contract_condition where proj_id = '"+proj_id+"'");
		flag=db.executeUpdate(sql.toString());
		System.out.print("增加拟商务条件删除SQL-->   "+sql.toString());
		message = "删除拟商务条件";
	}
	
	//租金测算程序
	List l_plan_date = new ArrayList();
	List l_rent = new ArrayList();
	List l_corpus = new ArrayList();
	List l_interest = new ArrayList();
	List l_corpus_overage = new ArrayList();
	//租金测算主方法
	//year_rate -->租赁年利率  income_number -->期数 lease_money -->净融资额  "0"-->本金未来值
	//period_type -->期末起初(付租类型) income_number_year -->付租方式 start_date -->预计起租日期
	Rent rent_hm = new Rent(year_rate, income_number, lease_money,
				"0", period_type, income_number_year, start_date);
				
	HashMap hm = rent_hm.getPlan();
	l_plan_date = (List)hm.get("plan_date");
	l_rent = (List)hm.get("rent");
	l_corpus = (List)hm.get("corpus");
	l_interest = (List)hm.get("interest");
	l_corpus_overage = (List)hm.get("corpus_overage");
	
	//irr
	String irr = "0";                                                                              //Double.parseDouble(0) supervision_fee表示管理费
	String lease_money_irr = ""+(Double.parseDouble(lease_money)-Double.parseDouble(caution_money)-Double.parseDouble("0")-Double.parseDouble(nominalprice));
	System.out.println("lease_money_irr的值为====="+lease_money_irr);
	Irr i_rr = new Irr();
	irr = i_rr.getIRR(i_rr.getCashFlow(l_plan_date,l_rent,period_type,income_number_year,lease_money_irr));
	irr = Tools.formatNumberDoubleTwo(String.valueOf(Double.parseDouble(irr)*100));
	//修改‘拟商务条件’中计划IRR的值
	String sqlstr = "update contract_condition set plan_irr="+irr+" where proj_id='"+proj_id+"'";
	db.executeUpdate(sqlstr);
	//直线法利息
	List l_straight_interest = new ArrayList();
	l_straight_interest = Tools.getStInterest(l_interest);
	//租金测算表  fund_rent_plan_temp
	//测算编号如何来的？？？？？？？？？？？？？？？？？？？？？？？？？？？？
	String  measure_id = "123";//临时测试用
	sqlstr = "delete from fund_rent_plan_temp where contract_id='"+proj_id+"' and measure_id='"+measure_id+"'";
	db.executeUpdate(sqlstr);
	for(int i=0;i<l_rent.size();i++){
		sqlstr="insert into fund_rent_plan_temp"+
		       "(measure_id,contract_id,straight_interest,"+
		       "rent_list,plan_date,plan_status,rent,corpus,"+
		       "interest,corpus_overage,year_rate) "+
		       "select '"+measure_id+"','"+proj_id+"',"+
		       " "+l_straight_interest.get(i)+","+(i+1)+","+
		       "'"+l_plan_date.get(i)+"','未回笼',"+l_rent.get(i)+","+
		       ""+l_corpus.get(i)+","+l_interest.get(i)+","+
		       ""+l_corpus_overage.get(i)+","+year_rate;
		//System.out.println("sqlstr2====="+sqlstr);
		db.executeUpdate(sqlstr);
	}
	db.close();
				
//所有操作成功后转向页面暂时未有明确需求未做 ***********************************************************
	if(flag>0){
		String hrefStr="";
		if(savaType.equals("del")){
%>
        <script>
		//opener.window.location.href = "frkh_list.jsp";
		alert("<%=message%>成功!");
		this.close();
		</script>
<%
		}else{
		%>
        <script>
		//window.location.href = "frkh.jsp?custId=";
		alert("<%=message%>成功!");
		opener.location.reload();
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