<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*"%>
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

String id = getStr( request.getParameter("id") );

String cust_name=getStr( request.getParameter("cust_name") );
String cust_id=getStr( request.getParameter("cust_id") );
String tax_payer_no=getStr( request.getParameter("tax_payer_no") );
String tax_type_invoice=getStr( request.getParameter("tax_type_invoice") );
String address=getStr( request.getParameter("address") );
String tel=getStr( request.getParameter("tel") );
String bank_name=getStr( request.getParameter("bank_name") );
String bank_no=getStr( request.getParameter("bank_no") );
String wh_modificator = getStr( request.getParameter("wh_modificator") );
String wh_modify_date = getStr( request.getParameter("wh_modify_date") );
String wh_confirm_user = getStr( request.getParameter("wh_confirm_user") );
String stype = getStr( request.getParameter("savetype") );
String wh_status ="已申请";
Map<String,String> param=new HashMap<String,String>();
					param.put("tax_payer_no" ,getStr( request.getParameter("tax_payer_no")));
					param.put("tax_type_invoice" ,getStr( request.getParameter("tax_type_invoice")));
					param.put("address" ,getStr( request.getParameter("address")));
					param.put("tel" ,getStr( request.getParameter("tel")));
					param.put("bank_name" ,getStr( request.getParameter("bank_name")));
					param.put("bank_no" ,getStr( request.getParameter("bank_no")));
					param.put("wh_modificator" ,getStr( request.getParameter("wh_modificator")));
					param.put("wh_modify_date" ,getStr( request.getParameter("wh_modify_date")));
					param.put("wh_confirm_user" ,getStr( request.getParameter("wh_confirm_user")));
					param.put("wh_status" ,"已申请");
String sqlstr="";
ResultSet rs;
String datestr = getSystemDate(1); //获取系统时间

if ( stype.equals("mod") ){      //修改操作	
	 String column="";
		for(String key:param.keySet()){
		    if(column.length()>0){column+=",";}
	         column+=key+"='"+param.get(key)+"'";
	    }
		sqlstr="update base_taxPayer  set "+column+" where id='"+id+"'";
         System.out.println("sqlstrsqlstr=="+sqlstr);		
		int i=0;
		i=db.executeUpdate(sqlstr); 
		if(i!=0){
%>
		<script>			
		window.close();
		opener.alert("修改成功!");
		opener.location.reload();
		</script>
<%
		}else{
%>
		<script>
			window.alert("修改失败!");
			window.history.go(-1);
		</script>
<%
		}
}
db.close();
%>


</BODY>
</HTML>
