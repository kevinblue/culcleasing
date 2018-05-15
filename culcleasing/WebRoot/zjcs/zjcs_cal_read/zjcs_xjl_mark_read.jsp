<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<%@page import="java.util.Date"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>项目不规则租金测算 - 市场现金流列表</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript">
</script>
</head>

<body onLoad="public_onload(0)">
<%
	ResultSet rs = null;
	//市场现金流
	String sqlstr = " select * from fund_proj_plan_mark_temp where 1=1  "; 
	//获取查询条件
	String proj_id = getStr(request.getParameter("proj_id"));
	String doc_id = getStr(request.getParameter("doc_id")); 
		
	if(!proj_id.equals("") && proj_id != null){
		sqlstr = sqlstr + " and  proj_id = '"+proj_id+"'";
	}else{
		sqlstr+= " and 1=2 ";
	}
	if(!doc_id.equals("") && doc_id != null){
		sqlstr = sqlstr + " and  doc_id = '"+doc_id+"'";
	}
	
	sqlstr = sqlstr + " order by id";
	System.out.println("合同现金流 -- sqlstr查询sql语句==>> "+sqlstr);
	rs = db.executeQuery(sqlstr);
%>
<form name="form1" action="zjcs_xjl_mark.jsp"  onSubmit="return goPage()">
<div style="vertical-align:top;width:100%; overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
<div id="TD_tab_0">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" height="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <!-- 
	    <th>合同编号/项目编号</th>
	    <th>文档编号</th>
	     -->
	    <th>期项</th>
	    <th>日期</th>
		<th>流入量</th>
		<th>流入量清单</th>
		<th>流出量</th>
		<th>流出量清单</th>
		<th>净流量</th>
      </tr>
<%	  
	int i = 1;
	while(rs.next()) {
%>
      <tr>
       <%--  
		<td nowrap align="center"><%=getDBStr(rs.getString("proj_id"))%></td>
		<td nowrap align="center"><%=getDBStr(rs.getString("doc_id"))%></td>
       --%>
      	<td nowrap align="center"><%=i%></td>
      	<td nowrap align="center"><%=getDBDateStr(rs.getString("plan_date")).substring(0,7)%></td>
		<td nowrap align="center"><%=formatNumberStr(getDBStr(rs.getString("follow_in")),"#,##0.00")%></td>
		<td align="center"><%=getDBStr(rs.getString("follow_in_detail"))%></td>
		<td nowrap align="center"><%=formatNumberStr(getDBStr(rs.getString("follow_out")),"#,##0.00")%></td>
		<td align="center"><%=getDBStr(rs.getString("follow_out_detail"))%></td>
		<td nowrap align="center"><%=formatNumberStr(getDBStr(rs.getString("net_follow")),"#,##0.00")%></td>				
      </tr>
      
<%
		i++;
	}
rs.close(); 
db.close();
%>
	  <tr>
	  	<td nowrap align="left" colspan="7">
	  	<font color="red">
	  		项目编号为:<%=proj_id%>&nbsp;|&nbsp;文档编号为:<%=doc_id%>&nbsp;
	  	</font>
	  	</td>
	  </tr>
    </table>
  </div>
  </div>
  
</form>
</body>
</html>
