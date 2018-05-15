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



	String sql="select * from dbo.proj_invoice where id='"+id+"'";
	ResultSet rs1 = db.executeQuery(sql);
String invoice_number="";
String invoice_total="";
String invoice_date="";
	if(rs1.next()){
	invoice_total=getDBStr(rs1.getString("invoice_total"));
		invoice_number=getDBStr(rs1.getString("invoice_number"));
	    invoice_date=getDBStr(rs1.getString("invoice_date"));
	    memo=getDBStr(rs1.getString("memo"));
	}
	System.out.println(invoice_number+"12invoice_number");
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
发票信息明细
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
	    	


<BUTTON class="btn_2" name="btnExport" value="导出"  type="submit"  onclick="return isExport();" >
<img src="../../images/save.gif" align="absmiddle" border="0">导出</button>


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
	<td align="left" colspan="10"></td>
</tr>
 <tr>
 
    <td scope="row">发票号:
      <%=invoice_number %>
    </td>
    
	 <td scope="row">发票金额:
 <%=formatNumberStr(rs1.getString("invoice_total"),"#,##0.00")%>
	</td>
	<td scope="row"> 备注：
	<%=memo %></td>
     <td scope="row">发票开据日期: <%=invoice_date %>
    
	</td>
  </tr>
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
					
						String sqls = "select vi_invoice.* from proj_invoice left join proj_invoice_detail on proj_invoice.id=proj_invoice_detail.proj_invoice_id left join vi_invoice on vi_invoice.id=proj_invoice_detail.plan_id  "+where_str+" and  proj_invoice.id="+id+"";
						System.out.println("sqls第二个((查询="+sqls);
						rs=db.executeQuery(sqls);

						int n=0;
					   while(rs.next()){
		
		//id=getDBStr(rs.getString("id"));
		id=getDBStr(rs.getString("id"));
		project_name=getDBStr(rs.getString("project_name"));
	    net_lease_money=getDBStr(rs.getString("net_lease_money"));
	    cust_name=getDBStr(rs.getString("cust_name"));
	    rent_list=getDBStr(rs.getString("rent_list"));
	    interest=getDBStr(rs.getString("interest_market"));
	    corpus=getDBStr(rs.getString("corpus_market"));
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
		<td align="center"><%= getDBStr( rs.getString("corpus_market") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("interest_market") ) %></td>
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
