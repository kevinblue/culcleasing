<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>网银核销 - 网银核销明细</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("ebank-ebank-view",dqczy)>0) canedit=1;
%>
<script>
if (<%=canedit%>==0){
	window.close();
	opener.alert("您没有操作权限！");
}

</script>
<%
//--------以上为权限控制-----------------------------
String sqlstr;
ResultSet rs;
String wherestr;
String czid = getStr( request.getParameter("czid") );

wherestr = " where 1=1";
wherestr+=" and fund_ebank_data.ebdata_id='"+czid+"'";
sqlstr = "select fund_ebank_data.order_number, fund_ebank_data.arrive_date, fund_ebank_data.account_bank, fund_ebank_data.acc_number, fund_ebank_data.client_name, fund_ebank_data.client_accnumber, fund_ebank_data.item_method, isnull(fund_ebank_data.fact_money,0) as fact_money, fund_ebank_data.summary, fund_ebank_data.sn, fund_ebank_data.status, fund_ebank_data.business_flag from fund_ebank_data" + wherestr; 
//System.out.println("sqlstr======================"+sqlstr);
rs = db.executeQuery(sqlstr); 


String	order_number = "";
String	arrive_date = "";
String	account_bank = "";
String	acc_number = "";
String	client_name = "";
String	client_accnumber = "";
String	fact_money = "";
String	summary = "";
String	sn = "";
String	status = "";
String	business_flag = "";


if ( rs.next() ) {
	order_number = getDBStr( rs.getString("order_number") );
	arrive_date = getDBDateStr( rs.getString("arrive_date") );
	account_bank = getDBStr( rs.getString("account_bank") );
	acc_number = getDBStr( rs.getString("acc_number") );
	client_name = getDBStr( rs.getString("client_name") );
	client_accnumber = getDBStr( rs.getString("client_accnumber") );
	fact_money = formatNumberStr(getDBStr( rs.getString("fact_money") ),"#,##0.00");
	sn = getDBStr( rs.getString("sn") );
	status = getDBStr( rs.getString("status") );
	business_flag = getDBStr( rs.getString("business_flag") );
}
rs.close(); 
db.close();
%>
<body onload="fun_winMax();">

<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
网银核销明细
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
		<td><a href="ebank_mod.jsp?czid=<%= czid %>"  accesskey="m" title="修改(Alt+M)" class="fontcolor">
		<img src="../../images/sbtn_mod.gif" width="19" height="19" align="absmiddle" >修改</a>
	  	<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
		<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button></td>
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">明 细</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td scope="row" nowrap width="20%">网银编号：</td>
    <td><%=czid %></td>
    <td scope="row" nowrap width="20%">序号：</td>
    <td><%=order_number %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">到帐时间：</td>
    <td><%=arrive_date %></td>
	<td scope="row" nowrap width="20%">到帐银行：</td>
    <td><%=account_bank %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">到帐帐号：</td>
    <td><%=acc_number %></td>
	<td scope="row" nowrap width="20%">付款客户：</td>
    <td><%=client_name %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">客户帐号：</td>
    <td><%=client_accnumber %></td>
    <td scope="row" nowrap width="20%">金额：</td>
    <td><%=fact_money %></td>
  </tr>
  <tr>
	<td scope="row" nowrap width="20%">摘要：</td>
    <td><%=summary %></td>
    <td scope="row" nowrap width="20%">流水号：</td>
    <td><%=sn %></td>
  </tr>
  <tr>
	<td scope="row" nowrap width="20%">状态：</td>
    <td><%=status %></td>
    <td scope="row" nowrap width="20%">租赁相关标志：</td>
    <td><%=business_flag %></td>
  </tr>
</table>
<br>

<div id="TD_tab_1" style="display:none;"> 
  选择卡中的内容2
</div>
<div id="TD_tab_2" style="display:none;"> 
  选择卡中的内容3

选择卡中可能包含以下内容：

注意HTMLBody并不是选择卡中的内容，因此需要独立拿出来放在最后。

</div>

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

<!--控制选择卡和内置iframe的高度适应窗口-->
<script language="javascript">
ShowTabN(0);
ShowTabSub(0);
reinitIframe();
//外部div高度自适应
function reinitIframe(){
var divH = document.getElementById("divH");
var reinitIframe_resize=function(){
divH.style.height=window.document.body.clientHeight-100;
}
reinitIframe_resize();
window.onresize=reinitIframe_resize;
}
</script>
<!-- end cwMain -->
</body>
</html>
