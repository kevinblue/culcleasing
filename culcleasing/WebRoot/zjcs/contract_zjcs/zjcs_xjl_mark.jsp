<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同租金测算 - 市场现金流列表</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript">
</script>
</head>
<body>
<%
	//权限处理 
	//String dqczy = (String) session.getAttribute("czyid");
	//if ((dqczy == null) || (dqczy.equals("")))
	//{
	//  dqczy = "无认证";
	//  response.sendRedirect("../../noright.jsp");
	//}
	//int canedit=0;
	//if (right.CheckRight("zjcs-tx-list",dqczy) > 0) canedit=1;
	//if (canedit == 0) response.sendRedirect("../../noright.jsp");
%>

<%
	String str = "";
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//格式化时间
	String nowDateTime = sdf.format(new Date());//当前格式化之后的时间
	ResultSet rs;
	String wherestr = " where 1=1 ";
	//央行基准利率表
	String sqlstr = " select * from fund_contract_plan_mark_temp where 1=1  "; 
	//获取查询条件
	String contract_id = getStr(request.getParameter("contract_id"));
	String doc_id = getStr(request.getParameter("doc_id")); 
	String start_plan_date = getStr(request.getParameter("start_plan_date")); 
	String end_plan_date = getStr(request.getParameter("end_plan_date")); 
	String market_irr = getStr(request.getParameter("market_irr"));//市场IRR
		
	//if(start_plan_date.equals("") || start_plan_date == null){
	//	start_plan_date = nowDateTime;
	//}
	//if(end_plan_date.equals("") || end_plan_date == null){
	//	end_plan_date = nowDateTime;
	//}
	
	if(!contract_id.equals("") && contract_id != null){
		sqlstr = sqlstr + " and  contract_id = '"+contract_id+"'";
	}
	if(!doc_id.equals("") && doc_id != null){
		sqlstr = sqlstr + " and  doc_id = '"+doc_id+"'";
	}
	if(!start_plan_date.equals("") && start_plan_date != null){
		sqlstr = sqlstr + " and  plan_date >= '"+start_plan_date+"' ";
	}
	if(!end_plan_date.equals("") && end_plan_date != null){
		sqlstr = sqlstr + " and  plan_date <= '"+end_plan_date+"' ";
	}
	sqlstr = sqlstr + " order by id";
	System.out.println("sqlstr查询sql语句==>> "+sqlstr);
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
       <!-- 
		<td nowrap align="center"><%=getDBStr(rs.getString("contract_id"))%></td>
		<td nowrap align="center"><%=getDBStr(rs.getString("doc_id"))%></td>
		 -->
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
	  		合同编号为:<%=contract_id%>&nbsp;|&nbsp;文档编号为:<%=doc_id%>&nbsp;|&nbsp;市场IRR为:<%=getDBStr(market_irr)%>&nbsp;%
	  	</font>
	  	</td>
	  </tr>
    </table>
  </div>
  </div>
  

</form>
</body>
</html>
