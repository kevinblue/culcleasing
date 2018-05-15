<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>抵押物明细 - 抵押物 </title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>

<body>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("contract-dyw-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<%
String id = getStr( request.getParameter("id") );
String contract_id = "";
String cust_name="";
String eqip_name = "";
String equip_invoice="";
String actual_start_date = "";
String actual_end_date = "";
String creator="";
String create_date = "";
String deal_info = "";
String deal_date = "";

ResultSet rs;
String sqlstr = "select equip.id,equip.contract_id,dbo.getcustnamebycontractid(equip.contract_id)as cust_name,eqip_name,equip_invoice,actual_start_date,dateadd(dd,lease_term,actual_start_date)as actual_end_date,dbo.getusername(equip.creator) as creator,equip.create_date,deal_info,deal_date from dbo.contract_guarantee_equip as equip left join contract_condition as condition on (equip.contract_id=condition.contract_id) where equip.id='" + id + "'"; 
rs = db.executeQuery(sqlstr); 
if (rs.next()){
  contract_id = getDBStr( rs.getString("contract_id") );
  cust_name = getDBStr( rs.getString("cust_name") );
  eqip_name = getDBStr( rs.getString("eqip_name") );	
  equip_invoice = getDBStr( rs.getString("equip_invoice") );
  actual_start_date = getDBDateStr( rs.getString("actual_start_date") );		
  actual_end_date = getDBDateStr( rs.getString("actual_end_date") );
  creator = getDBStr( rs.getString("creator") );
  create_date = getDBDateStr( rs.getString("create_date") );
  deal_info = getDBStr( rs.getString("deal_info") );
  deal_date = getDBDateStr( rs.getString("deal_date") );
}
rs.close();
db.close();
%>

<form name="form1" method="post" action="dyw_mod.jsp" onSubmit="return Validator.Validate(this,3);">

<table  class="title_top" width=100% height=100% align="center" cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
抵押物 &gt;  抵押物明细
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	
<a href="dyw_mod.jsp?id=<%= id %>"  accesskey="m" title="修改(Alt+M)" class="fontcolor">
		<img src="../../images/sbtn_mod.gif" width="19" height="19" align="absmiddle" >修改</a>
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>

    </td></tr>
</table>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">详细信息</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<!-- end cwTop -->
<!-- end cwCellTop -->

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="czid" value="<%=id %>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
  <td>客户名</td>
  <td><%=cust_name%></td>
  <td>合同号</td>
   <td><%=contract_id%></td>
  </tr>
  <tr>
    <td >封存号</td>
    <td><%=equip_invoice%>
	</td>
    <td>抵押物名称</td>
    <td><%=eqip_name%></td>
  </tr>
  <tr>
  <td>租赁起始日</td>
   <td><%=actual_start_date%></td>
   <td>租赁到期日</td>
   <td><%=actual_end_date%></td>
  </tr>
  <tr>
  <td>处理情况</td>
   <td><%=deal_info%></td>
    <td>处理日期</td>
   <td><%=deal_date%></td>
  </tr>
  <tr>
  <td>修改人 </td>
   <td><%=creator%></td>
    <td>修改日期</td>
   <td><%=create_date%></td>
  </tr>
</table>


</div>
</div>

    </form>

</body>
</html>
