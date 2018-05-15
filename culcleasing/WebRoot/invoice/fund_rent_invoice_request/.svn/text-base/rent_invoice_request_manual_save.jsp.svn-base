<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<!-- 2010-08-05修改为：com.rent.calc.tx.TransRateNew 以前的值为：com.rent.calc.TransRate -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/calend.js"></script>
</head>

<BODY>
<%

System.out.println("租金发票手工维护保存：manual_saveaaaaaa");
String czyid = (String) session.getAttribute("czyid");
String datestr = getSystemDate(0);//获取系统时间


String sqlIds = getStr( request.getParameter("sqlIds") );
String [] sqlIds_arr =sqlIds.split("#");

String plan_id=getStr( request.getParameter("plan_id") );
String contract_id=getStr( request.getParameter("contract_id") );
String begin_id=getStr( request.getParameter("begin_id") );
String cust_name=getStr( request.getParameter("cust_name") );
String project_name=getStr( request.getParameter("project_name") );
String parent_deptname=getStr( request.getParameter("parent_deptname") );
String dept_name=getStr( request.getParameter("dept_name") );
String proj_manage_name=getStr( request.getParameter("proj_manage_name") );
String rent_num=getStr( request.getParameter("rent_num") );
String plan_date=getStr( request.getParameter("plan_date") );
String last_hire_date=getStr( request.getParameter("last_hire_date") );
String rent = getStr( request.getParameter("rent") );
String interest = getStr( request.getParameter("interest") );
String corpus = getStr( request.getParameter("corpus") );
System.out.println("plan_id:---"+plan_id);
System.out.println("contract_id:---"+contract_id);
System.out.println("begin_id:---"+begin_id);
System.out.println("cust_name:---"+cust_name);
System.out.println("project_name:---"+project_name);
System.out.println("parent_deptname:---"+parent_deptname);
System.out.println("dept_name:---"+dept_name);
System.out.println("proj_manage_name:---"+proj_manage_name);
System.out.println("rent_num:---"+rent_num);
System.out.println("plan_date:---"+plan_date);
System.out.println("last_hire_date:---"+last_hire_date);
System.out.println("rent:---"+rent);
System.out.println("interest:---"+interest);
System.out.println("corpus:---"+corpus);


Map<String,String> param=new HashMap<String,String>();
					param.put("manual_plan_id" ,plan_id);
					param.put("manual_contract_id" ,contract_id);
					param.put("manual_begin_id" ,begin_id);
					param.put("manual_cust_name" ,cust_name);
					param.put("manual_project_name" ,project_name);
					param.put("manual_parent_deptname" ,parent_deptname);
					param.put("manual_dept_name" ,dept_name);
					param.put("manual_proj_manage_name" ,proj_manage_name);
					param.put("manual_rent_num" ,rent_num);
					param.put("manual_plan_date" ,plan_date);
					param.put("manual_last_hire_date" ,last_hire_date);
					param.put("manual_rent" ,rent);
					param.put("manual_interest" ,interest);
					param.put("manual_corpus" ,corpus);
String sqlstr="";
ResultSet rs;
	//更新手工录入表
	 String column="";
	 for(int  i=0;i<sqlIds_arr.length;i++){
		 column="";
		 for(String key:param.keySet()){
			    if(column.length()>0){column+=",";}
		         column+=key+"='"+param.get(key)+"'";
		    }
			sqlstr+="update manual_open_invoice_info  set "+column+" where out_no='"+sqlIds_arr[i]+"'";
	 }
	
	//更新租金计划表  fund_rent_plan  add invoice_status 
	sqlstr+="update fund_rent_plan  set invoice_status='已手工开票' where id='"+plan_id+"'";
         System.out.println("sqlstrsqlstr=="+sqlstr);		
		int i=0;
		i=db.executeUpdate(sqlstr); 
		if(i!=0){
%>
		<script>			
		//window.close();
		//opener.alert("手工维护成功!");
		//opener.location.reload();
		window.alert("手工维护成功!");
		window.opener.location.reload();
		window.opener=null;
		window.open("","_self");
		setTimeout("self.close()",100);
		</script>
<%
		}else{
%>
		<script>
			window.alert("手工维护失败失败!");
			window.history.go(-1);
		</script>
<%
		}
db.close();
%>


</BODY>
</HTML>
