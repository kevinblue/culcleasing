<%@ page contentType="text/html; charset=gbk" language="java" %>

<%@ page import="java.sql.*" %>
<%@page import="com.tenwa.util.CurrencyUtil"%> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db2" scope="page" class="dbconn.Conn" /> 

<%@ include file="../../func/common_simple.jsp"%>
<html> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title>明细 - 代理公司付款(首期付款)</title>
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
	<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
	<script Language="Javascript" src="../../js/jquery.js"></script>
	<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
	<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>


<body onload="public_onload(0);">
<form name="dataNav" method="post" action="leasing.jsp" target="new">

<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
	<td class="tree_title_txt"  height=26 valign="middle">
	明细 - 代理公司付款(首期付款)
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
	<BUTTON class="btn_2" name="btnReset" value="关闭" onclick="window.close();">
	<img src="../../images/hg.gif" align="absmiddle" border="0">关闭</button>
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">详细信息</td>
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:80%;overflow:auto;">
<div id="TD_tab_0">

<%
String sqlstr="";
String partSql="";
ResultSet rs = null;
ResultSet rs2 = null;
String czid = getStr( request.getParameter("czid") );

sqlstr = "select *,dict.title as paymethod from apply_info left join dbo.ifelc_conf_dictionary dict on dict.name=apply_info.pay_method where apply_info.id='"+czid+"'";

String dld_id ="";
String dld_name ="";
String pay_method="";
//pay_method,pay_date,pay_amt,proj_number,effe_date
String pay_date="";
String pay_amt="";
String proj_number="";
String effe_date="";
 
rs=db.executeQuery(sqlstr); 
if (rs.next()) { 
	dld_id=getDBStr(rs.getString("dld_name"));
	dld_name=getDBStr(rs.getString("dld_name"));
	pay_method=getDBStr(rs.getString("paymethod"));
	
	pay_date=getDBDateStr(rs.getString("pay_date"));
	pay_amt=formatNumberDoubleTwo(rs.getString("pay_amt"));
	proj_number=getDBStr(rs.getString("proj_number"));
	effe_date=getDBDateStr(rs.getString("effe_date"));
}
%>

<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
 <tr>
    <td scope="row">代 理 商:&nbsp;&nbsp;<b style="color:#E46344;"><%=dld_name %></b></td>
    <td> 
	&nbsp;
	</td>
	 <td scope="row">付款方式:&nbsp;&nbsp;<b style="color:#E46344;"><%=pay_method %></b></td>
    <td>&nbsp;
    </td>
    
     <td scope="row">应&nbsp;付&nbsp;&nbsp;日&nbsp;期:&nbsp;&nbsp;<b style="color:#E46344;"><%=pay_date %></b></td>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td scope="row">付款金额:&nbsp;&nbsp;<b style="color:#E46344;"><%=pay_amt %></b></td>
    <td>&nbsp;</td>
	 <td scope="row">项目数量:&nbsp;&nbsp;<b style="color:#E46344;"><%=proj_number %></b></td>
    <td>&nbsp; </td>
	<td scope="row">实际付款日期:&nbsp;<b style="color:#E46344;">
    <%="".equals(request.getParameter("fact_date"))?"--未核销--":getStr( request.getParameter("fact_date") ) %></td>
    <td>&nbsp;</td>
	<th scope="row"></th>
    <td> 
	</td>
  </tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">				
<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"
		class="maintab_content_table">
	<tr class="maintab_content_table_title">
		 <th>项目编号</th>
		 <th>客户名称</th>
		 
		 <th>租赁物类型</th>
		 <th>制造商</th>
		 <th>机型</th>
		 <th>出厂编号</th>
		 <th>租赁物购买价款</th>
			 
		 <th>1起租租金</th>
		 <th>2保证金</th>
		 <th>3第一期租金</th>
		 <th>4保险费</th>
		 <th>5手续费</th>
		 <th>6担保费</th>
		 <th>7留购价款</th>
		 <th>计划日期</th>
		 <th>首期付款合计</th>
		 <th>备注</th>
	</tr>
<tbody id="data">
<%
String projRemark = "";
sqlstr="select  v.* from vi_zjfwy_detail v where proj_id in( select proj_id from apply_info_detail where apply_id='"+czid+"')  order by v.dld asc";

rs = db.executeQuery(sqlstr); 
int i=0;
while (rs.next()){
%>
	<tr>
		<td align="center"><%=getDBStr(rs.getString("proj_id"))%></td>
		<td align="center"><%=getDBStr(rs.getString("khmc")) %></td>

		<td align="center"><%=getDBStr(rs.getString("prod_id")) %></td>
		<td align="center"><%=getDBStr(rs.getString("manufacturer")) %></td>
		<td align="center"><%=getDBStr(rs.getString("model_id")) %></td>
		<td align="center"><%=getDBStr(rs.getString("equip_sn")) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("equip_amt")) %></td>
	
		<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("qzzj")) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("bzj")) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("dyqzj")) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("bxf")) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("sxf")) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("dbf")) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("lgjk")) %></td>
	
		<td align="center"><%=getDBDateStr(rs.getString("sfk_plan_date")) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("first_total_money")) %></td>
		<%
			partSql = "select top 1 remark from apply_info_detail where proj_id='"+rs.getString("proj_id")+"'";
			rs2 = db2.executeQuery(partSql);
			if(rs2.next()){
				projRemark = getDBStr(rs2.getString("remark"));
			}else{
				projRemark = "";
			}
		%>
		<td align="center"><%=projRemark %></td>
	</tr>		
<%	} %>
</tbody>
</table>

</div>
</div>
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
<!--添加结束-->
<%
rs.close(); 
db.close();
%>
</form>
<!-- end cwMain -->
</body>
</html>
