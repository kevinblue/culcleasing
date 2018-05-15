<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@page import="com.Tools"%> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">



<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>财务报表 - 地方财力信息</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
</head>
<style type="text/css">
.gridtable{

	border:2px solid #999999; 
	border-collapse:collapse; 
	cellpadding:0px;
	cellspacing:0px;
	
}
.gridtable tr {
	font-family: verdana,arial,sans-serif;
	font-size:20px;
	color:#333333;
	width:10px;
	height:10px;
	border-width: 1px;
	border-color: #666666;
	background-color: #fff;
}
.gridtable td {
	border-width: 1px;
	height:30px;
	padding: 8px;
	border-style: solid;
	border-color: #666666;
	border-collapse:collapse; 
	background-color: #fff;
	border-bottom:1px solid #999999; 
	 empty-cells : show;
	
}

</style>
</script>
<% 
	String custId = getStr( request.getParameter("custId"));
	String sqlcom="select * from dbo.financial_resource_info  fr where "+
					"cust_id='"+custId+"'"+
					"and uuid=(select fb1.uuid from dbo.financial_base_info fb1 where fb1.cust_id='"+custId+"' "+
					"and fb1.create_date  =( "+
					"select MAX(fbs.create_date)  from dbo.financial_base_info fbs  "+
					"where fbs.cust_id='"+custId+"' "+
					"group by fbs.cust_id)) ";
	
	String sqlstr = "DECLARE @sql_str VARCHAR(8000) "+
					"DECLARE @sql_col VARCHAR(8000) "+
					"SELECT @sql_col = ISNULL(@sql_col + ',','') + QUOTENAME([financial_year]) FROM [financial_resource_info] "+
					"where "+
					"cust_id='"+custId+"'"+
					"and uuid=(select fb1.uuid from dbo.financial_base_info fb1 where fb1.cust_id='"+custId+"' "+
					"and fb1.create_date  =( "+
					"select MAX(fbs.create_date)  from dbo.financial_base_info fbs  "+
					"where fbs.cust_id='"+custId+"' "+
					"group by fbs.cust_id)) "+
					"GROUP BY [financial_year]  "+
					"SET @sql_str = ' "+
					"SELECT * FROM ( "+
					"SELECT [row_num],[index_title],[financial_subject],[financial_year],[financial_subdata] FROM [financial_resource_info]) p PIVOT  "+
					"(max([financial_subdata]) FOR [financial_year] IN ( '+ @sql_col +') ) AS pvt  "+
					"ORDER BY cast(pvt.[row_num] as int) asc'  "+
					"PRINT (@sql_str) "+
					"EXEC (@sql_str)";
	ResultSet rs0 = db.executeQuery(sqlcom);
	if(rs0.next()){
		ResultSet rs = db.executeQuery(sqlstr);
		ResultSetMetaData rsm = rs.getMetaData();
		rs.last(); 
		int rowCount = rs.getRow(); 
		rs.beforeFirst();
		int count=0;	
		String tbodyname1="";
		String tbodyname2="";
		String tbodyname3="";
		String subjectname="";
		String tbodyname4="";
		String tbodyname5="";
		String tbodyname6="";
		String tbodyname7="";
		String tbodyname8="";
		String tbodyname9="";
%>
<body >

<div style="vertical-align:top;width:100%;height:500px;overflow-y:scroll;position:relative;left: 0px; top: 0px" id="mydiv_one";>
<table class="gridtable" width='100%'   id='list_table'>

	<tr>
      	<!-- 针对具体数据行进行修改删除操作  -->
        <td align="center" nowrap><%=getDBStr("序号") %></td>
		<td align="center" nowrap><%=getDBStr("指标标题") %></td>
        <td align="center" nowrap width="100px"><%=getDBStr("科目/单位:万元") %></td>
		<td align="center" nowrap width="130px"><%=getDBStr(rsm.getColumnName(4)) %></td>
		<td align="center" nowrap width="130px"><%=getDBStr(rsm.getColumnName(5)) %></td>
		<td align="center" nowrap width="130px"><%=getDBStr(rsm.getColumnName(7)) %></td>
		<td align="center" nowrap width="130px"><%=getDBStr(rsm.getColumnName(9)) %></td>	
		<td align="center" nowrap width="130px"><%=getDBStr(rsm.getColumnName(6)) %></td>	
		<td align="center" nowrap width="130px"><%=getDBStr(rsm.getColumnName(8)) %></td>	
      </tr>

<%		  
		while(count<rowCount&&rs.next()){
		count++;
		 tbodyname1=getDBStr(rs.getString(rs.findColumn("row_num")));
		 tbodyname2=getDBStr(rs.getString(rs.findColumn("index_title")));
		 tbodyname3=getDBStr(rs.getString(rs.findColumn("financial_subject")));
		 subjectname=rs.getString(rs.findColumn("financial_subject"));
		 tbodyname4=Tools.formatStringRate(subjectname,rs.getString(4),2);
		 tbodyname5=Tools.formatStringRate(subjectname,rs.getString(5),2);
		 tbodyname6=Tools.formatStringRate(subjectname,rs.getString(7),2);
		 tbodyname7=Tools.formatStringRate(subjectname,rs.getString(9),2);
		 tbodyname8=Tools.formatStringRate(subjectname+"率",rs.getString(6),2);
		 tbodyname9=Tools.formatStringRate(subjectname+"率",rs.getString(8),2); 
%>
		<tr>
        <td align="right" nowrap><%=tbodyname1 %></td>
		<td align="right" nowrap><%=tbodyname2 %></td>
        <td align="right" nowrap width="100px"><%=tbodyname3 %></td>
		<td align="right" nowrap width="130px"><%=tbodyname4 %></td>
		<td align="right" nowrap width="130px"><%=tbodyname5 %></td>
		<td align="right" nowrap width="130px"><%=tbodyname6 %></td>
		<td align="right" nowrap width="130px"><%=tbodyname7 %></td>		
		<td align="right" nowrap width="130px"><%=tbodyname8 %></td>
		<td align="right" nowrap width="130px"><%=tbodyname9 %></td>	
</tr>
<%
	
	}
	rs.close();
	db.close();
}
%>
  </table>
  </div>

</body>
</html>