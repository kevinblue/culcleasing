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
String sqlIds = getStr( request.getParameter("sqlIds") );//选择项
System.out.println("dddddddd"+sqlIds);	
String stype = "mod";
String wh_status ="已确认";
Map<String,String> param=new HashMap<String,String>();
					param.put("wh_status" ,"已确认");
String sqlstr="";
ResultSet rs;
String datestr = getSystemDate(1); //获取系统时间

if ( stype.equals("mod") ){      //修改操作	
	 String column="";
		for(String key:param.keySet()){
		    if(column.length()>0){column+=",";}
	         column+=key+"='"+param.get(key)+"'";
	    }
		sqlstr="update base_taxPayer  set "+column+" where id in ("+sqlIds+")";
         System.out.println("sqlstrsqlstr=="+sqlstr);		
		int i=0;
		i=db.executeUpdate(sqlstr); 
		if(i!=0){
%>
		<script>			
		window.close();
		opener.alert("确认成功!");
		opener.location.reload();
		</script>
<%
		}else{
%>
		<script>
			window.alert("确认失败!");
			window.history.go(-1);
		</script>
<%
		}
}
db.close();
%>


</BODY>
</HTML>
