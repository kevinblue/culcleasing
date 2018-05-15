<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>

<%@ page import="java.sql.*" %> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金管理-发票管理</title>
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
	
	sqlstr = " select * from dbo.proj_invoice where id="+id;  
	System.out.println("sqlstrsqlstrsqlf888str="+sqlstr);
 rs = db.executeQuery(sqlstr);
	System.out.println("sqlstr==----0099=="+sqlstr);
	
	String invoice_number="";
	String invoice_total="";
	String invoice_date="";
	

	if(rs.next()){
	invoice_number=getDBStr(rs.getString("invoice_number"));
	invoice_total=getDBStr(rs.getString("invoice_total"));
	invoice_date=getDBStr(rs.getString("invoice_date"));
	System.out.println("invoice_number====="+invoice_number);
	System.out.println("invoice_total====="+invoice_total);
	System.out.println("invoice_date====="+invoice_date);
		
	
%>



<!--  
<form name="form1" method="post" action="fpgl_save.jsp" onSubmit="return checkdata(this);">	
-->
<body onLoad="public_onload();fun_winMax();">
<input type="hidden" name="where_str" id="where_str" value="<%=where_str%>" />
<!--
<form name="form1" method="post" action="fpgl_save.jsp" onSubmit="return checkdata(this);">	
-->

<form name="form1" method="post" action="fpgl_save.jsp" onSubmit="return Validator.Validate(this,3);">

<div id=bgDiv>


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
资产管理&gt; 担保物修改
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
    <td scope="row">发票总额：</td>
    <td><%=formatNumberStr(rs.getString("invoice_total"),"#,##0.00")%></td>

  
  </tr>
  <tr>
   <td scope="row">发票号：</td>
    <td>
        <input class="text" type="text" name="invoice_number" value="<%=invoice_number %>" Require="true"  maxlength="40" dataType="Number"><span class="biTian">*</span></td>
    <td scope="row">开据时间:</td>
    <td>
        <input class="text" type="text" name="invoice_date" value="<%=invoice_date %>"  Require="true" maxlength="40" readonly>
     
 <img onClick="openCalendar(invoice_date);return false;" style="cursor:pointer; " src="../../images/fdmo_63.gif" border="0" align="absmiddle">
 <span class="biTian">*</span></td>
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
						
												
       						<th>序号</th>
	    <th>项目名称</th>
	    <th>合同额</th>
	    <th>合同编号</th>
	    <th>发票抬头</th>
	    <th>本期数</th>
	    <th>总期数</th>
	    <th>租金</th>
	    <th>还款日期</th>
		<th>本金</th>
		<th>利息</th>
						</tr>
					
						<%
					
						String sqls = "select vi_invoice.* from proj_invoice left join proj_invoice_detail on proj_invoice.id=proj_invoice_detail.proj_invoice_id left join vi_invoice on vi_invoice.id=proj_invoice_detail.plan_id "+where_str+"  and  proj_invoice.id="+id+"";
						System.out.println("sqls第二个((查询="+sqls);
						rs=db.executeQuery(sqls);

						int n=0;
					   while(rs.next()){
		
		
		id=getDBStr(rs.getString("id"));
		project_name=getDBStr(rs.getString("project_name"));
	    net_lease_money=getDBStr(rs.getString("net_lease_money"));
	    cust_name=getDBStr(rs.getString("cust_name"));
	    rent_list=getDBStr(rs.getString("rent_list"));
	    interest=getDBStr(rs.getString("interest"));
	    corpus=getDBStr(rs.getString("corpus"));
	    plan_date=getDBStr(rs.getString("plan_date"));
	    income_number=getDBStr(rs.getString("income_number"));
	    contract_id=getDBStr(rs.getString("contract_id"));
	    rent=getDBStr(rs.getString("rent"));
						 %>
						
						<tr>
						
	        				
	     <td align="center"><%= getDBStr( rs.getString(("id") )) %></td>
<input id="plan_id" name="<%= getDBStr( rs.getString(("id") )) %>" type="hidden" >
		<td align="center">
		<%= getDBStr( rs.getString("project_name") ) %></td>
		<td align="center"><%= getDBStr( rs.getString(("net_lease_money") )) %></td>
	   <td align="center"><%= getDBStr( rs.getString("contract_id") ) %></td>
	   <td align="center"><%= getDBStr( rs.getString("cust_name") ) %></td>
	    <td align="center"><%= getDBStr( rs.getString("rent_list") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("income_number") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("rent") ) %></td>
		<td align="center"><%= getDBDateStr( rs.getString("plan_date") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("corpus") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("interest") ) %></td>
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