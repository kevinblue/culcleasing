<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db_gd" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db_glqy" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>客户/股东/关联企业 - 客户/股东/关联企业列表</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body onload="fun_winMax();">
<form action="bxdqcx_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				客户/股东/关联企业 &gt; 客户/股东/关联企业列表</td>
			</tr>
</table>
<!--标题结束-->

<!--副标题和操作区开始-->

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="1%">
					 
					 <%

String sqlstr="";
ResultSet rs;
ResultSet rs_gd;
ResultSet rs_glqy;
String wherestr = " where 1=1";

String proj_id = getStr( request.getParameter("proj_id") );
String cust_id = getStr( request.getParameter("cust_id") );


String show_tr_flag="";
sqlstr = "select vi_contract_info.cust_name,'' as equity_ratio, sum(case when vi_contract_info.actual_start_date is not null and isnull(vi_contract_info.actual_end_date,'2030-01-01')>convert(varchar(10),getdate(),121) then 1 else 0 end) as exe_nub, isnull(sum(case when vi_contract_info.actual_start_date is not null and isnull(vi_contract_info.actual_end_date,'2030-01-01')>convert(varchar(10),getdate(),121) then dbo.bb_getRemFxck('1970-01-01',convert(varchar(10),getdate(),121),vi_contract_info.contract_id) else 0 end),0) as remFxck, isnull(sum(case when vi_contract_info.actual_start_date is not null and isnull(vi_contract_info.actual_end_date,'2030-01-01')>convert(varchar(10),getdate(),121) and dbo.bb_getBadNub('1970-01-01',convert(varchar(10),getdate(),121),vi_contract_info.contract_id)>0 then 1 else 0 end),0) as badNub, isnull(sum(case when vi_contract_info.actual_start_date is not null and isnull(vi_contract_info.actual_end_date,'2030-01-01')>convert(varchar(10),getdate(),121) and dbo.bb_getBadNub('1970-01-01',convert(varchar(10),getdate(),121),vi_contract_info.contract_id)>0 then dbo.bb_getRemFxck('1970-01-01',convert(varchar(10),getdate(),121),vi_contract_info.contract_id) else 0 end),0) as badRemFxck from vi_contract_info where vi_contract_info.cust_id='"+cust_id+"' group by vi_contract_info.cust_name";
//System.out.println("sqlstr1=================="+sqlstr);
rs=db.executeQuery(sqlstr);

sqlstr="select proj_cust_capital_struct.shareholder,proj_cust_capital_struct.equity_ratio, sum(case when vi_contract_info.actual_start_date is not null and isnull(vi_contract_info.actual_end_date,'2030-01-01')>convert(varchar(10),getdate(),121) then 1 else 0 end) as exe_nub, isnull(sum(case when vi_contract_info.actual_start_date is not null and isnull(vi_contract_info.actual_end_date,'2030-01-01')>convert(varchar(10),getdate(),121) then dbo.bb_getRemFxck('1970-01-01',convert(varchar(10),getdate(),121),vi_contract_info.contract_id) else 0 end),0) as remFxck, isnull(sum(case when vi_contract_info.actual_start_date is not null and isnull(vi_contract_info.actual_end_date,'2030-01-01')>convert(varchar(10),getdate(),121) and dbo.bb_getBadNub('1970-01-01',convert(varchar(10),getdate(),121),vi_contract_info.contract_id)>0 then 1 else 0 end),0) as badNub, isnull(sum(case when vi_contract_info.actual_start_date is not null and isnull(vi_contract_info.actual_end_date,'2030-01-01')>convert(varchar(10),getdate(),121) and dbo.bb_getBadNub('1970-01-01',convert(varchar(10),getdate(),121),vi_contract_info.contract_id)>0 then dbo.bb_getRemFxck('1970-01-01',convert(varchar(10),getdate(),121),vi_contract_info.contract_id) else 0 end),0) as badRemFxck from proj_cust_capital_struct left join cust_info on proj_cust_capital_struct.id_number=cust_info.org_code left join vi_contract_info on cust_info.cust_id=vi_contract_info.cust_id where proj_cust_capital_struct.proj_id='"+proj_id+"' and proj_cust_capital_struct.cust_id='"+cust_id+"' and proj_cust_capital_struct.individual_flag='是' group by proj_cust_capital_struct.shareholder,proj_cust_capital_struct.equity_ratio union select proj_cust_capital_struct.shareholder,proj_cust_capital_struct.equity_ratio, sum(case when vi_contract_info.actual_start_date is not null and isnull(vi_contract_info.actual_end_date,'2030-01-01')>convert(varchar(10),getdate(),121) then 1 else 0 end) as exe_nub, isnull(sum(case when vi_contract_info.actual_start_date is not null and isnull(vi_contract_info.actual_end_date,'2030-01-01')>convert(varchar(10),getdate(),121) then dbo.bb_getRemFxck('1970-01-01',convert(varchar(10),getdate(),121),vi_contract_info.contract_id) else 0 end),0) as remFxck, isnull(sum(case when vi_contract_info.actual_start_date is not null and isnull(vi_contract_info.actual_end_date,'2030-01-01')>convert(varchar(10),getdate(),121) and dbo.bb_getBadNub('1970-01-01',convert(varchar(10),getdate(),121),vi_contract_info.contract_id)>0 then 1 else 0 end),0) as badNub, isnull(sum(case when vi_contract_info.actual_start_date is not null and isnull(vi_contract_info.actual_end_date,'2030-01-01')>convert(varchar(10),getdate(),121) and dbo.bb_getBadNub('1970-01-01',convert(varchar(10),getdate(),121),vi_contract_info.contract_id)>0 then dbo.bb_getRemFxck('1970-01-01',convert(varchar(10),getdate(),121),vi_contract_info.contract_id) else 0 end),0) as badRemFxck from proj_cust_capital_struct left join cust_ewlp_info on proj_cust_capital_struct.id_number=cust_ewlp_info.id_card_no left join vi_contract_info on cust_ewlp_info.cust_id=vi_contract_info.cust_id where proj_cust_capital_struct.proj_id='"+proj_id+"' and proj_cust_capital_struct.cust_id='"+cust_id+"' and proj_cust_capital_struct.individual_flag='否' group by proj_cust_capital_struct.shareholder,proj_cust_capital_struct.equity_ratio";
//System.out.println("sqlstr2=================="+sqlstr);
rs_gd=db_gd.executeQuery(sqlstr);

sqlstr="select proj_cust_affiliatedco.affiliatedco,proj_cust_affiliatedco.equity_ratio, sum(case when vi_contract_info.actual_start_date is not null and isnull(vi_contract_info.actual_end_date,'2030-01-01')>convert(varchar(10),getdate(),121) then 1 else 0 end) as exe_nub, isnull(sum(case when vi_contract_info.actual_start_date is not null and isnull(vi_contract_info.actual_end_date,'2030-01-01')>convert(varchar(10),getdate(),121) then dbo.bb_getRemFxck('1970-01-01',convert(varchar(10),getdate(),121),vi_contract_info.contract_id) else 0 end),0) as remFxck, isnull(sum(case when vi_contract_info.actual_start_date is not null and isnull(vi_contract_info.actual_end_date,'2030-01-01')>convert(varchar(10),getdate(),121) and dbo.bb_getBadNub('1970-01-01',convert(varchar(10),getdate(),121),vi_contract_info.contract_id)>0 then 1 else 0 end),0) as badNub, isnull(sum(case when vi_contract_info.actual_start_date is not null and isnull(vi_contract_info.actual_end_date,'2030-01-01')>convert(varchar(10),getdate(),121) and dbo.bb_getBadNub('1970-01-01',convert(varchar(10),getdate(),121),vi_contract_info.contract_id)>0 then dbo.bb_getRemFxck('1970-01-01',convert(varchar(10),getdate(),121),vi_contract_info.contract_id) else 0 end),0) as badRemFxck from proj_cust_affiliatedco left join cust_info on proj_cust_affiliatedco.id_number=cust_info.org_code left join vi_contract_info on cust_info.cust_id=vi_contract_info.cust_id where proj_cust_affiliatedco.proj_id='"+proj_id+"' and proj_cust_affiliatedco.cust_id='"+cust_id+"' and proj_cust_affiliatedco.individual_flag='是' group by proj_cust_affiliatedco.affiliatedco,proj_cust_affiliatedco.equity_ratio union select proj_cust_affiliatedco.affiliatedco,proj_cust_affiliatedco.equity_ratio, sum(case when vi_contract_info.actual_start_date is not null and isnull(vi_contract_info.actual_end_date,'2030-01-01')>convert(varchar(10),getdate(),121) then 1 else 0 end) as exe_nub, isnull(sum(case when vi_contract_info.actual_start_date is not null and isnull(vi_contract_info.actual_end_date,'2030-01-01')>convert(varchar(10),getdate(),121) then dbo.bb_getRemFxck('1970-01-01',convert(varchar(10),getdate(),121),vi_contract_info.contract_id) else 0 end),0) as remFxck, isnull(sum(case when vi_contract_info.actual_start_date is not null and isnull(vi_contract_info.actual_end_date,'2030-01-01')>convert(varchar(10),getdate(),121) and dbo.bb_getBadNub('1970-01-01',convert(varchar(10),getdate(),121),vi_contract_info.contract_id)>0 then 1 else 0 end),0) as badNub, isnull(sum(case when vi_contract_info.actual_start_date is not null and isnull(vi_contract_info.actual_end_date,'2030-01-01')>convert(varchar(10),getdate(),121) and dbo.bb_getBadNub('1970-01-01',convert(varchar(10),getdate(),121),vi_contract_info.contract_id)>0 then dbo.bb_getRemFxck('1970-01-01',convert(varchar(10),getdate(),121),vi_contract_info.contract_id) else 0 end),0) as badRemFxck from proj_cust_affiliatedco left join cust_ewlp_info on proj_cust_affiliatedco.id_number=cust_ewlp_info.id_card_no left join vi_contract_info on cust_ewlp_info.cust_id=vi_contract_info.cust_id where proj_cust_affiliatedco.proj_id='"+proj_id+"' and proj_cust_affiliatedco.cust_id='"+cust_id+"' and proj_cust_affiliatedco.individual_flag='否' group by proj_cust_affiliatedco.affiliatedco,proj_cust_affiliatedco.equity_ratio";
System.out.println("sqlstr3=================="+sqlstr);
rs_glqy=db_glqy.executeQuery(sqlstr);

%>



<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<td></td>
		<td></td>
		<td><br><br></td>
    </tr>
</table>
<!--操作按钮结束-->
</td>
					 <td align="right" width="90%">
					 	
					 	
<!--翻页控制开始-->




<table border="0" cellspacing="0" cellpadding="0">
  <tr class="maintab">
	
 </tr>
</table>

</td>
</tr>
</table>

<!--翻页控制结束-->






<!--报表开始-->

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv";>

   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th>客户/股东/关联企业</th>
        <th>持股比例</th>
        <th>在执行合同数</th>
        <th>总风险敞口</th>
        <th>逾期合同数</th>
        <th>逾期风险敞口</th>
      </tr>
      <tr>
		<td colspan="6">客户</td>
      </tr>
  

<%	  
	while( rs.next() ) {
	show_tr_flag="0";
%>

      <tr>
		<td><%= getDBStr( rs.getString("cust_name") ) %></td> 	 	
		<td><%= getDBStr( rs.getString("equity_ratio") ) %></td>
		<td><%= getDBStr( rs.getString("exe_nub") ) %></td>
		<td><%= formatNumberStr(getDBStr( rs.getString("remFxck") ),"#,##0.00") %></td> 	 	
		<td><%= getDBStr( rs.getString("badNub") ) %></td>
		<td><%= formatNumberStr(getDBStr( rs.getString("badRemFxck") ),"#,##0.00") %></td>
      </tr>
<%
		
	}rs.close();
	if(show_tr_flag.equals("")){
	
	%>
	<tr><td colspan="6">无数据</td></tr>
	<%
	}
	show_tr_flag="";
	
%>
	  <tr>
		<td colspan="6">股东</td>
      </tr>
  

<%	  
	while( rs_gd.next() ) {
	show_tr_flag="0";
%>

      <tr>
		<td><%= getDBStr( rs_gd.getString("shareholder") ) %></td> 	 	
		<td><%= getDBStr( rs_gd.getString("equity_ratio") ) %></td>
		<td><%= getDBStr( rs_gd.getString("exe_nub") ) %></td>
		<td><%= formatNumberStr(getDBStr( rs_gd.getString("remFxck") ),"#,##0.00") %></td> 	 	
		<td><%= getDBStr( rs_gd.getString("badNub") ) %></td>
		<td><%= formatNumberStr(getDBStr( rs_gd.getString("badRemFxck") ),"#,##0.00") %></td>
      </tr>
<%
		
	}rs_gd.close();
	if(show_tr_flag.equals("")){
	
	%>
	<tr><td colspan="6">无数据</td></tr>
	<%
	}
	show_tr_flag="";
%>
	  <tr>
		<td colspan="6">关联企业及分支机构</td>
      </tr>
  

<%	  
	while( rs_glqy.next() ) {
	show_tr_flag="0";
%>

      <tr>
		<td><%= getDBStr( rs_glqy.getString("affiliatedco") ) %></td> 	 	
		<td><%= getDBStr( rs_glqy.getString("equity_ratio") ) %></td>
		<td><%= getDBStr( rs_glqy.getString("exe_nub") ) %></td>
		<td><%= formatNumberStr(getDBStr( rs_glqy.getString("remFxck") ),"#,##0.00") %></td> 	 	
		<td><%= getDBStr( rs_glqy.getString("badNub") ) %></td>
		<td><%= formatNumberStr(getDBStr( rs_glqy.getString("badRemFxck") ),"#,##0.00") %></td>
      </tr>
<%
		
	}rs_glqy.close();
if(show_tr_flag.equals("")){
	
	%>
	<tr><td colspan="6">无数据</td></tr>
	<%
	}
db.close();
db_gd.close();
db_glqy.close();
%>
    </table>
</div>

<!--报表结束-->
</form>
</body>
</html>
