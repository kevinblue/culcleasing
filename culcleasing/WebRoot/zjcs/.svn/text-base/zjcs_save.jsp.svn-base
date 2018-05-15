<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
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
	out.println("join@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2");
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
		String period_type = getStr(request.getParameter("period_type"));//付租类型
		String return_amt = getStr(request.getParameter("return_amt"));//厂商返利
		String year_rate = getStr(request.getParameter("year_rate"));//租赁年利率
		String rate_float_type = getStr(request.getParameter("rate_float_type"));//利率浮动类型
		//     
		String before_interest = getStr(request.getParameter("before_interest"));//租前息
		String rate_adjustment_modulus = getStr(request.getParameter("rate_adjustment_modulus"));//利率调整系数
		String pena_rate = getStr(request.getParameter("pena_rate"));//罚息利率
		String income_day = getStr(request.getParameter("income_day"));//每月偿付日
		String start_date = getStr(request.getParameter("start_date"));//起租日
		String plan_irr = getStr(request.getParameter("plan_irr"));//计划IRR
		String measure_type = getStr(request.getParameter("measure_type"));//租金计算方法
		String other_income = getStr(request.getParameter("other_income"));//其他收入
		//      
		String other_expenditure = getStr(request.getParameter("other_expenditure"));//其他支出
		String creator = getStr(request.getParameter("creator"));//登记人
		String create_date = getStr(request.getParameter("create_date"));//登记时间
	    String modify_date = getStr(request.getParameter("modify_date"));//更新日期
		String modificator = getStr(request.getParameter("modificator"));//更新人
	
//	String create_date="";
	//String modificator=(String) session.getAttribute("czyid");
//	String modify_date="";
	//String provinceName=request.getParameter("");

	//SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//格式化时间
	//String nowTime=sdf.format(new Date());//当前格式化之后的时间
	System.out.print("+++++++++++");
	if(savaType.equals("add")){
	System.out.print("join+++++++++++");
		sql.append("INSERT INTO contract_condition (proj_id ,currency ,equip_amt ,lease_money ,lease_term")
           .append(",income_number_year,income_number,year_rate,rate_float_type,period_type,income_day")
           .append(",start_date,first_payment,caution_money,handling_charge,return_amt,nominalprice")
           .append(",pena_rate,net_lease_money,plan_irr,measure_type,creator,create_date")
           .append(",modificator,modify_date,rate_adjustment_modulus,other_income,other_expenditure,remark)")
     	   .append(" VALUES ('"+proj_id+"','"+currency+"','"+equip_amt+"','"+lease_money+"'")
           .append(" ,'"+lease_term+"','"+income_number_year+"','"+income_number+"','"+year_rate+"'")
           .append(" ,'"+rate_float_type+"','"+period_type+"','"+income_day+"','"+start_date+"'")
           .append(" ,'"+first_payment+"','"+caution_money+"','"+handling_charge+"','"+return_amt+"'")
           .append(" ,'"+nominalprice+"','"+pena_rate+"','"+net_lease_money+"'")
           .append(" ,'"+plan_irr+"','"+measure_type+"','"+creator+"','"+create_date+"'")
           .append(",'"+modificator+"','"+modify_date+"','"+rate_adjustment_modulus+"'")
           .append(" ,'"+other_income+"','"+other_expenditure+"','')");
		
		System.out.print("增加拟商务条件增加SQL-->  "+sql);
		flag = db.executeUpdate(sql.toString());
		message="增加拟商务条件";
	}
	if(savaType.equals("add2")){
		
		System.out.print(sql);
		flag=db.executeUpdate(sql.toString());
		message="法人客户登记";
	}
	if(savaType.equals("mod")){
		
		System.out.print(sql);
		flag=db.executeUpdate(sql.toString());
		message="修改客户信息";
	}
	if(savaType.equals("del")){
		sql="delete from cust_info where cust_id='"+cust_id+"'";
		flag=db.executeUpdate(sql.toString());
		System.out.print(sql);
		message="删除客户信息";
	}
	if(flag>0){
		String hrefStr="";
		if(savaType.equals("del")){
%>
        <script>
		opener.window.location.href = "frkh_list.jsp";
		alert("<%=message%>成功!");
		this.close();
		</script>
<%
		}else{
		%>
        <script>
		window.location.href = "frkh.jsp?custId=<%=cust_id%>";
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