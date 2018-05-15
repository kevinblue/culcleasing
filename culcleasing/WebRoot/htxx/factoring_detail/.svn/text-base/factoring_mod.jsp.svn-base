<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>

<%@ page import="java.sql.*" %> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>保理明细-保理管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/jquery.js"></script>
<script src="/dict/js/js_dictionary.js"></script>

	<script src="../../js/calend.js"></script>
</head>
<%
String id;
String sqlstr;

ResultSet rs;
id=getStr(request.getParameter("id"));
String wherestr=" where 1=1 ";
      	
     String where_str =wherestr;
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
	
	sqlstr = " select * from factoring_contract_info  where id="+id;  
	System.out.println("sqlstrsqlstrsqlf888str="+sqlstr);
 rs = db.executeQuery(sqlstr);
	System.out.println("sqlstr==----0099=="+sqlstr);
	
String factoring_backname="";
String factoring_account="";
String factoring_date="";
String factoring_rent="";
String factoring_corpus="";
String factoring_interest="";
String factoring_repay="";
String factoring_rate="";
	if(rs.next()){
	factoring_backname=getDBStr(rs.getString("factoring_backname"));
	factoring_account=getDBStr(rs.getString("factoring_account"));
	factoring_date=getDBDateStr(rs.getString("factoring_date"));
	factoring_rent=getDBStr(rs.getString("factoring_rent"));
	factoring_corpus = getDBStr(rs.getString("factoring_corpus"));
	factoring_interest = getDBStr(rs.getString("factoring_interest"));
	factoring_repay = getDBStr(rs.getString("factoring_repay"));
	factoring_rate = getDBStr(rs.getString("factoring_rate"));
	//System.out.println("invoice_number====="+invoice_number);
	//System.out.println("invoice_total====="+invoice_total);
	//System.out.println("invoice_date====="+invoice_date);
	//System.out.println("invoice_name====="+invoice_name);	
	
%>



<!--  
<form name="form1" method="post" action="fpgl_save.jsp" onSubmit="return checkdata(this);">	
-->
<body onLoad="public_onload();fun_winMax();">
<input type="hidden" name="where_str" id="where_str" value="<%=where_str%>" />
<!--
<form name="form1" method="post" action="fpgl_save.jsp" onSubmit="return checkdata(this);">	
-->

<form name="form1" method="post" action="factoring_save.jsp" onSubmit="return Validator.Validate(this,3);">

<div id=bgDiv>


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
保理管理&gt; 保理修改
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=98%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	    <td>
	    	
<BUTTON class="btn_2" name="btnSave" value="提交"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">提交生效</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
<img src="../../images/fdmo_37.gif" align="absmiddle" border="0">关闭</button>

	    	</td>
	  </tr>
</table>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">修改信息</td>
  
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
<!--
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
-->

<div class="linetype" id="mydiv" style="padding:12px vertical-align:top;margin:0px 12px 12px 12px;overflow:auto;height:300px">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="mod">



<table class="tab_table_title" border="0" cellspacing="0" cellpadding="0" width="100%">

 <tr>
   
	<td scope="row" colspan="5">
		
		
		
	</td>
	
        <td scope="row" colspan="1">
    保理编号&nbsp;&nbsp;<input class="text" name="factoring_num" id="factoring_num" type="text"   maxlength="60" size="10" value="<%=getDBStr(rs.getString("factoring_num"))%>"/>&nbsp;&nbsp;
    保理银行&nbsp;&nbsp;<input class="text" name="factoring_backname" id="factoring_backname" type="text"   maxlength="60" size="10" value="<%=getDBStr(rs.getString("factoring_backname"))%>"/>&nbsp;&nbsp;
    保理帐户&nbsp;&nbsp;<input class="text" name="factoring_account" id="factoring_account" type="text"   maxlength="50" size="10" value="<%= factoring_account%>"/>&nbsp;&nbsp;
    保理金额&nbsp;&nbsp;<input class="text" name="factoring_rent" id="factoring_rent" type="text" size="30" readonly="readonly" value="<%=formatNumberStr(rs.getString("factoring_rent"),"#,##0.00")%>"/></td>
	</tr>
	<tr>
	<td scope="row" colspan="5"></td>
	<td colspan="6">
	保理本金&nbsp;&nbsp;<input type="text"  class="text" name="factoring_corpus" id="factoring_corpus" readonly="readonly" size="30"  value="<%=formatNumberStr(rs.getString("factoring_corpus"),"#,##0.00")%>"/>&nbsp;&nbsp;
	保理利息&nbsp;&nbsp;<input type="text" class="text" name="factoring_interest" id="factoring_interest" readonly="readonly" size="30"  value="<%=formatNumberStr(rs.getString("factoring_interest"),"#,##0.00")%>"/>&nbsp;&nbsp;
	偿还金额&nbsp;&nbsp;<input class="text" name="factoring_repay" id="factoring_repay" size="30"  value="<%=formatNumberStr(rs.getString("factoring_repay"),"#,##0.00")%>"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	保理利率&nbsp;&nbsp;<input class="text" name="factoring_rate" id="factoring_rate" type="text" size="30"  value="<%=formatNumberStr(rs.getString("factoring_rate"),"#,##0.00")%>"/></td>

	
  </tr>
   <tr>
   	<td scope="row" colspan="5">
		
		
		
	</td>
   <td colspan="6">
   
    融资金额&nbsp;&nbsp;<input class="text" name="lease_money" id="lease_money" type="text"   maxlength="60" size="10" value="<%=getDBStr(rs.getString("lease_money"))%>"/>&nbsp;&nbsp;
    省公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input class="text" name="cust_name" id="cust_name" type="text"   maxlength="60" size="10" value="<%=getDBStr(rs.getString("cust_name"))%>"/>&nbsp;&nbsp;
    保理开始时间&nbsp;&nbsp;<input class="text" name="factoring_start_date" id="factoring_start_date" type="text" size="30" readonly="readonly" value="<%= getDBDateStr(rs.getString("factoring_start_date")) %>"/><img  onClick="openCalendar(factoring_start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">&nbsp;&nbsp;
    保理结束时间&nbsp;&nbsp;<input class="text" name="factoring_end_date" id="factoring_end_date" type="text" size="30" readonly="readonly" value="<%= getDBDateStr(rs.getString("factoring_end_date")) %>"/><img  onClick="openCalendar(factoring_end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">&nbsp;&nbsp;
   </td>
   </tr>
 
</table>
</div>
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
		
		
	//	id=getDBStr(rs.getString("id"));
	
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
</center>
<table width=96% align=center border="0" cellspacing="0" cellpadding="0">
<tr><td width="50%"></td>
<td width="50%" valign="middle" align="right">&nbsp;</td></tr>
</table>
</td>
</tr>
</table>  
</div>
<!--添加结束-->
</form>
<%
}
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
		form1.action="fpgl_mod.jsp";
	}
	return false;
}

</script>
<!-- end cwMain -->
</body>
</html>