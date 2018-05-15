<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>发票明细 - </title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>

<% 
   String dqczy = (String) session.getAttribute("czyid");
     // String plan_id = getStr( request.getParameter("plan_id"));
      String wherestr=" where 1=1 ";
      	
     String where_str =wherestr;
     // System.out.println("plan_id"+plan_id);
   String id = getStr( request.getParameter("id"));
 System.out.println("id^^^^="+id);
	ResultSet rs=null;
	String cust_name="";
	
String project_name="";
String net_lease_money="";
String contract_id="";
String rent_list="";
String income_number="";
String rent="";
String plan_date="";
String corpus="";
String interest="";
String memo="";
String sqlstr="";


	sqlstr = " select * from factoring_contract_info  where id="+id;  
	ResultSet rs1 = db.executeQuery(sqlstr);
	
String factoring_backname="";
String factoring_account="";
String factoring_date="";
String factoring_rent="";
String factoring_corpus="";
String factoring_interest="";
String factoring_repay="";
String factoring_rate="";
	if(rs1.next()){
	factoring_backname=getDBStr(rs1.getString("factoring_backname"));
	factoring_account=getDBStr(rs1.getString("factoring_account"));
	factoring_date=getDBDateStr(rs1.getString("factoring_date"));
	factoring_rent=getDBStr(rs1.getString("factoring_rent"));
	factoring_corpus = getDBStr(rs1.getString("factoring_corpus"));
	factoring_interest = getDBStr(rs1.getString("factoring_interest"));
	factoring_repay = getDBStr(rs1.getString("factoring_repay"));
	factoring_rate = getDBStr(rs1.getString("factoring_rate"));
	}
//	System.out.println(invoice_number+"12invoice_number");
	//rs1.close(); 
	//db.close();
%>

<body onLoad="">

<input type="hidden" name="where_str" id="where_str" value="<%=where_str%>" />

<form name="form1" method="post" action="fpgl.jsp" onSubmit="return checkdata(this);">	

<div id=bgDiv>

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
保理明细
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	    <td>
	    	





<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
<img src="../../images/fdmo_37.gif" align="absmiddle" border="0">关闭</button>


	    	</td>
	  </tr>
</table>
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">明 细</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table>
   <script language="javascript">
ShowTabN(0);
</script>
 </td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<table border="0" cellspacing="0" cellpadding="0" width="100%" align="center" class="tab_table_title">
<tr class="maintab">
	<td align="left" colspan="4"></td>
</tr>
 <tr>
	
   <td class="row"> 保理编号&nbsp;&nbsp;<%=getDBStr(rs1.getString("factoring_num"))%>&nbsp;&nbsp;</td>
   <td class="row"> 保理银行&nbsp;&nbsp;<%=getDBStr(rs1.getString("factoring_backname"))%>&nbsp;&nbsp;</td>
   <td class="row"> 保理帐户&nbsp;&nbsp;<%= factoring_account%>&nbsp;&nbsp;</td>
  <td class="row">  保理金额&nbsp;&nbsp;<%=formatNumberStr(rs1.getString("factoring_rent"),"#,##0.00")%></td>
	</tr>
	<tr>
	
	
	<td class="row">保理本金&nbsp;&nbsp;<%=formatNumberStr(rs1.getString("factoring_corpus"),"#,##0.00")%>&nbsp;&nbsp;</td>
	<td class="row">保理利息&nbsp;&nbsp;<%=formatNumberStr(rs1.getString("factoring_interest"),"#,##0.00")%>&nbsp;&nbsp;</td>
	<td class="row">偿还金额&nbsp;&nbsp;<%=formatNumberStr(rs1.getString("factoring_repay"),"#,##0.00")%>&nbsp;&nbsp;</td>
	<td class="row">保理利率&nbsp;&nbsp;<%=formatNumberStr(rs1.getString("factoring_rate"),"#,##0.00")%></td>

	
  </tr>
  <tr>
  <td class="row">融资金额&nbsp;&nbsp;<%= getDBStr(rs1.getString("lease_money"))%></td>
  <td class="row">省公司&nbsp;&nbsp;<%= getDBStr(rs1.getString("cust_name"))%></td>
  <td class="row">保理开始时间&nbsp;&nbsp;<%= getDBDateStr(rs1.getString("factoring_start_date")) %>&nbsp;&nbsp;</td>
  <td class="row">保理结束时间&nbsp;&nbsp;<%= getDBDateStr(rs1.getString("factoring_end_date")) %>&nbsp;&nbsp;</td>
   </tr>
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative;left: 0px; top: 0px;"
				id="mydiv";>
				<input type="hidden" name="savetype" value="dao">
				<input type="hidden" name="id" value="<%=id %>">
<table border="0" style="border-collapse:collapse;" align="center"
						cellpadding="0" cellspacing="0" width="100%"
						class="maintab_content_table">
						<tr class="maintab_content_table_title">
						
												
  	    <th>合同号</th>
	    <th>承租人</th>
	    <th>项目名称</th>
	    <th>合同期数</th>
	    <th>保理期数</th>
	    <th>保理租金</th>
	    <th>保理本金</th>
	    <th>保理利息</th>
	    <th>保理日期</th>
						</tr>
					
						<%
					
						String sqls = " select vfr.* from factoring_contract_Corresponding fcc left join vi_factoring_statistics vfr on fcc.contract_id=vfr.contract_id and fcc.factoring_date=vfr.factoring_date where factoring_num="+id;  
						System.out.println("sqls第二个((查询="+sqls);
						rs=db.executeQuery(sqls);


						int n=0;
					   while(rs.next()){
		
		//id=getDBStr(rs.getString("id"));

						 %>
						
						<tr>
						
	        				
	        				
        				<td align="center"><%= getDBStr( rs.getString(("contract_id") )) %></td>
	        <td align="center">
		<%= getDBStr( rs.getString("cust_name") ) %></td>
	   <td align="center"><%= getDBStr( rs.getString("project_name") ) %></td>
	   	<td align="center"><%= getDBStr( rs.getString(("lease_term") )) %></td>
	   <td align="center"><%= getDBStr( rs.getString("rent_lsit") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("factoring_rent") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("factoring_pringcipal") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("factoring_rantal") ) %></td>
		<td align="center"><%= getDBDateStr( rs.getString("factoring_date") ) %></td>
	
						</tr>
					
						<%
						
						n++;
						}
						 %>
				
</table>
</div>



<br>
<div style="text-align:left;width:98%">

<table border="0" cellspacing="0" cellpadding="0" width="100%"><tr><td bgcolor="#8DB2E3" width="100%"><img height="1" width="1"></td></tr></table>

</div>

<div id="TD_tab_1" style="display:none;"> 
  选择卡中的内容2
</div>
<div id="TD_tab_2" style="display:none;"> 
  选择卡中的内容3

选择卡中可能包含以下内容：

注意HTMLBody并不是选择卡中的内容，因此需要独立拿出来放在最后。
</div>
</center>
<table width=96% align=center border="0" cellspacing="0" cellpadding="0">
<tr><td width="50%"></td>
<td width="50%" valign="middle" align="right">&nbsp;</td></tr>
</table>
</td>
</tr>
</table>  
</div>
<%
rs1.close(); 
rs.close(); 
db.close();

 %>
<script>

//导出Excel
function isExport() {
	if (confirm("是否确认导出Excel!")) {
		// alert("jjjj"+<%=wherestr%>);
		form1.action="export_save.jsp";
		
		document.getElementById("where_str").value="<%=wherestr%>";
  		form1.submit();
		form1.action="fpgl.jsp";
	}
	return false;
}

</script>
</form>
<!-- end cwMain -->
</body>
	
</html>
