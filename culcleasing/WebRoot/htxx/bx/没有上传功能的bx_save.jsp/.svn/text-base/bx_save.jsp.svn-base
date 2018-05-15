<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资产管理 - 保险管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
	<script src="../../js/calend.js"></script>
</head>
<BODY>
<%
	System.out.print("join@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2");
	String savaType=getStr(request.getParameter("savetype"));
		String czy = (String) session.getAttribute("czyid");
	String sql = "";
	ResultSet rs=null;
	int flag=0;
	String message="";
	String cust_id=getStr(request.getParameter("cust_id"));
	String id = getStr(request.getParameter("id"));
	 System.out.println("id="+id);
	String stype = getStr(request.getParameter("savetype"));
	 //保险字段
	 String contract_id=getStr(request.getParameter("contract_id"));
	 System.out.println("contract_id="+contract_id);
	 String insurance_my=getStr(request.getParameter("insurance_my"));
	 String insurance_id=getStr(request.getParameter("insurance_id"));
	 System.out.println("insurance_id="+insurance_id);
	 String buy_insuranceself=getStr(request.getParameter("buy_insuranceself"));
	 String period_insurance=getStr(request.getParameter("period_insurance"));
	 System.out.println("1.period_insurance="+period_insurance);
	 String colleaction_date=getStr(request.getParameter("colleaction_date"));
	 String insurance_type=getStr(request.getParameter("insurance_type"));
	    System.out.println("insurance_type="+insurance_type);
	 String payments=getStr(request.getParameter("payments"));
	 String pay_date=getStr(request.getParameter("pay_date"));
	   System.out.println("pay_date="+pay_date);
	   String proj_id=getStr(request.getParameter("proj_id"));

    String insurance_company=getStr(request.getParameter("insurance_company"));
  // String insurance_id=getStr(request.getParameter("insurance_id"));
   String insured=getStr(request.getParameter("insured"));
   String b_insured=getStr(request.getParameter("b_insured"));
  // String colleaction_date=getStr(request.getParameter("colleaction_date"));
	// String payments=getStr(request.getParameter("payments"));
	// String pay_date=getStr(request.getParameter("pay_date"));
	// String buy_insuranceself=getStr(request.getParameter("buy_insuranceself"));
	// String period_insurance=getStr(request.getParameter("period_insurance"));
	// insured_amount=getStr(request.getParameter("insured_amount"));
     String insurance_coverage=getStr(request.getParameter("insurance_coverage"));
	String price_coverage=getStr(request.getParameter("price_coverage"));
	String price_appraisal=getStr(request.getParameter("price_appraisal"));
	String assessment_company=getStr(request.getParameter("assessment_company"));
    String production_date=getStr(request.getParameter("production_date"));
	String total_insurance=getStr(request.getParameter("total_insurance"));
	String deductible_accident=getStr(request.getParameter("deductible_accident"));
	String premium_rate=getStr(request.getParameter("premium_rate"));
	String general_insurance=getStr(request.getParameter("general_insurance"));
	String jurisdiction=getStr(request.getParameter("jurisdiction"));
	String beneficiaries=getStr(request.getParameter("beneficiaries"));
System.out.println("%%%%%%%%%%"+beneficiaries);
	String memo=getStr(request.getParameter("memo"));
	String attachment=getStr(request.getParameter("attachment"));

    String insured_amount=getStr(request.getParameter("insured_amount"));
	//SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	//String nowTime=sdf.format(new Date());//当前格式化之后的时间
			String systemDate = getSystemDate(0);
	//System.out.print("+++++====+"+nowTime);
	String sqlstr;
			
	if(savaType.equals("add")){
	System.out.print("+++++++++++");
		//sql="insert into contract_insurance(contract_id,insurance_my,insurance_id,buy_insuranceself,period_insurance,colleaction_date,insurance_type,pay_date,payments,creator,create_date,modificator,modify_date)"+
		//"values('"+contract_id+"','"+insurance_my+"','"+insurance_id+"','"+buy_insuranceself+"','"+period_insurance+"','"+colleaction_date+"','"+insurance_type+"','"+pay_date+"','"+payments+"','"+dqczy+"','"+systemDate+"','"+dqczy+"','"+systemDate+"') ";
		
               sql="insert into contract_insurance(contract_id,insurance_my,insurance_id,buy_insuranceself,period_insurance,colleaction_date,insurance_type,pay_date,payments,insured_amount,insurance_company,insured,b_insured,insurance_coverage,price_coverage,price_appraisal,assessment_company,production_date,total_insurance,deductible_accident,premium_rate,general_insurance,jurisdiction,beneficiaries,memo,attachment,creator,create_date,modificator,modify_date)"+
		"values('"+contract_id+"','"+insurance_my+"','"+insurance_id+"','"+buy_insuranceself+"','"+period_insurance+"','"+colleaction_date+"','"+insurance_type+"','"+pay_date+"','"+payments+"','"+insured_amount+"','"+insurance_company+"','"+insured+"','"+b_insured+"','"+insurance_coverage+"','"+price_coverage+"','"+price_appraisal+"','"+assessment_company+"','"+production_date+"','"+total_insurance+"','"+deductible_accident+"','"+premium_rate+"','"+general_insurance+"','"+jurisdiction+"','"+beneficiaries+"','"+memo+"','"+attachment+"','"+czy+"','"+systemDate+"','"+czy+"','"+systemDate+"') ";
		System.out.print(sql+"+++++++++++++++++");
		
		flag=db.executeUpdate(sql);
		
		message="保险登记";
	}
	//if(savaType.equals("add2")){
	//	sql="update contract_insurance set "+
	//	"id='"+id+"',insurance_my='"+insurance_my+"',insurance_id='"+insurance_id+"',buy_insuranceself='"+buy_insuranceself+"',period_insurance='"+period_insurance+"',"+
	//	"colleaction_date='"+colleaction_date+"',insurance_type='"+insurance_type+"', pay_date='"+pay_date+"',payments='"+payments+"'"+
		//"where id='"+id+"'";
	///	System.out.print(sql);
	//	flag=db.executeUpdate(sql);
	//	message="保险登记";
	//}
	if(savaType.equals("mod")){
		//	sql="update contract_insurance set "+
		//"insurance_my='"+insurance_my+"',insurance_id='"+insurance_id+"',buy_insuranceself='"+buy_insuranceself+"',period_insurance='"+period_insurance+"',"+
		//"colleaction_date='"+colleaction_date+"',insurance_type='"+insurance_type+"',creator='"+czy+"',create_date='"+systemDate+"',modificator='"+czy+"',modify_date='"+systemDate+"',pay_date='"+pay_date+"',payments='"+payments+"'"+
		//"where id='"+id+"'";
		sql="update contract_insurance set "+
		"insurance_my='"+insurance_my+"',insurance_id='"+insurance_id+"',buy_insuranceself='"+buy_insuranceself+"',period_insurance='"+period_insurance+"',"+
		"colleaction_date='"+colleaction_date+"',insurance_type='"+insurance_type+"',creator='"+czy+"',create_date='"+systemDate+"',modificator='"+czy+"',modify_date='"+systemDate+"',pay_date='"+pay_date+"',insured_amount='"+insured_amount+"',payments='"+payments+"',"+
		"insurance_company='"+insurance_company+"',insured='"+insured+"',b_insured='"+b_insured+"',insurance_coverage='"+insurance_coverage+"',price_coverage='"+price_coverage+"',price_appraisal='"+price_appraisal+"',assessment_company='"+assessment_company+"',production_date='"+production_date+"',total_insurance='"+total_insurance+"',deductible_accident='"+deductible_accident+"',premium_rate='"+premium_rate+"',general_insurance='"+general_insurance+"',jurisdiction='"+jurisdiction+"',beneficiaries='"+beneficiaries+"',memo='"+memo+"',attachment='"+attachment+"'"+
		"where id='"+id+"'";
		System.out.print("xiugaisql"+sql);
		flag=db.executeUpdate(sql);
		message="修改保险信息";
	}
	if(savaType.equals("del")){
		sql="delete from contract_insurance where id='"+id+"'";
		flag=db.executeUpdate(sql);
		System.out.print(sql);
		message="删除保险信息";
	}
	if(flag>0){
		String hrefStr="";
		if(savaType.equals("del")){
%>
        <script>
       
        //  window.close();
             //   opener.alert("添加成功!");
		//opener.location.reload();
		opener.window.location.href = "bx_list.jsp";
		alert("<%=message%>成功!");
		this.close();
		</script>
<%
		}else{
		%>
        <script>
        
        // / window.close();
              // / opener.alert("添加成功!");
		///opener.location.reload();
		opener.window.location.href = "bx_list.jsp";
		alert("<%=message%>成功!");
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