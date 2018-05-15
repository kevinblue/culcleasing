<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 

<%@ page import="dbconn.*"%>
<%@ page import="com.tenwa.culc.util.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<%@ include file="../../func/common_simple.jsp"%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/calend.js"></script>

</head>

<BODY>
<%
String uuid=CommonTool.getUUID().replace("-", "")+Math.random();
String cust_id = getStr( request.getParameter("cust_id") );
String cust_name = getStr( request.getParameter("cust_name") );
String tax_payer_no = getStr( request.getParameter("tax_payer_no") );
String address = getStr( request.getParameter("address") );
String phone = getStr( request.getParameter("phone") );
String bank_name = getStr( request.getParameter("bank_name") );
String account_number = getStr( request.getParameter("account_number") );
String remark = getStr( request.getParameter("remark") );
String product_number = getStr( request.getParameter("product_number") );
String product_name = getStr( request.getParameter("product_name") );
String commercial_specification = getStr( request.getParameter("commercial_specification") );
String unit = getStr( request.getParameter("unit") );
String unit_price = getStr( request.getParameter("unit_price") );
String rate = getStr( request.getParameter("rate") );
String quantity = getStr( request.getParameter("quantity") );
String include_tax_money=getStr( request.getParameter("include_tax_money") );
String invoice_type=getStr( request.getParameter("invoice_type") );
String tax_classfy_code=getStr( request.getParameter("tax_classfy_code") );
String if_erp=getStr( request.getParameter("if_erp") );
String stype = getStr( request.getParameter("savetype") );
Map<String,String>param=new HashMap<String,String>();
param.put("out_no" ,uuid);
param.put("cust_id" ,getStr( request.getParameter("cust_id")));
param.put("cust_name" ,getStr( request.getParameter("cust_name")));
param.put("tax_payer_no" ,getStr( request.getParameter("tax_payer_no")));
param.put("address" ,getStr( request.getParameter("address")));
param.put("phone" ,getStr( request.getParameter("phone")));

param.put("bank_name" ,getStr( request.getParameter("bank_name")));
param.put("account_number" ,getStr( request.getParameter("account_number")));
param.put("remark" ,getStr( request.getParameter("remark")));
param.put("product_number" ,getStr( request.getParameter("product_number")));
param.put("product_name" ,getStr( request.getParameter("product_name")));

param.put("commercial_specification" ,getStr( request.getParameter("commercial_specification")));
param.put("unit" ,getStr( request.getParameter("unit")));
param.put("unit_price" ,getStr( request.getParameter("unit_price")));
param.put("rate" ,getStr( request.getParameter("rate")));
param.put("quantity" ,getStr( request.getParameter("quantity")));
param.put("if_tax" ,getStr( request.getParameter("if_tax")));
param.put("include_tax_money" ,getStr( request.getParameter("include_tax_money")));
param.put("invoice_type" ,getStr( request.getParameter("invoice_type")));
param.put("if_erp" ,getStr( request.getParameter("if_erp")));
param.put("creator" ,getStr( request.getParameter("creator")));
param.put("create_date" ,getStr( request.getParameter("create_date")));
String sqlstr="";
ResultSet rs;
String datestr = getSystemDate(1); //获取系统时间

if ( stype.equals("add") ){      //修改操作	
		String column="";
		String values="";
		for(String key:param.keySet()){
		   if(column.length()>0){column+=",";values+=",";}
	       column+=key;
		   values+="'"+param.get(key)+"'";
	    }
		sqlstr="insert into manual_open_invoice_info ("+column+") values ("+values+");";
		System.out.println("sqlstrsqlstr1=="+sqlstr);
		int i=0;
		i=db.executeUpdate(sqlstr); 
		if(i!=0){
%>
		<script>			
		window.close();
		opener.alert("新增成功!");
		opener.location.reload();
		</script>
<%
		}else{
%>
		<script>
			window.alert("新增失败!");
			window.history.go(-1);
		</script>
<%
		}
}
db.close();
%>
</BODY>
</HTML>
