<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("insurance-claims-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>保险管理 - 保险赔款确认</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>
<%
	String czid = getStr( request.getParameter("czid") );
String sqlstr = "select distinct claims_id,claims.contract_id,claims.equip_sn,views.insurer,dbo.fk_getname(views.sale_id) sale_id ,claims.claims_date,claims.claims_name,claims.claims_money,claims.repair_delaydate,claims.repair_delaymoney,claims.financing_delaydate,claims.financing_delaymoney,views.leas_mode operation_way from insurance_claims claims left join  contract_view views on views.contract_id = claims.contract_id where claims.claims_id = '"+czid+"'";
	ResultSet rs = db.executeQuery(sqlstr); 
	String	claims_id = "";
	String	equip_sn = "";
	String	contract_id = "";
	String	insurer = "";
	String	sale_id = "";
	String	claims_date = "";
	String	claims_money = "";
	String	claims_name = "";
	String	repair_delaydate = "";
	String	repair_delaymoney = "";
	String	financing_delaydate = "";
	String	financing_delaymoney = "";
	String	operation_way = "";
if ( rs.next() ) {
		claims_id = getDBStr( rs.getString("claims_id") );
		equip_sn = getDBStr( rs.getString("equip_sn") );
		contract_id = getDBStr( rs.getString("contract_id") );
		insurer = getDBStr( rs.getString("insurer") );
		sale_id = getDBStr( rs.getString("sale_id") );
		claims_date = getDBDateStr( rs.getString("claims_date") );
		claims_money = getDBStr( rs.getString("claims_money") );
		claims_name = getDBStr( rs.getString("claims_name") );
		repair_delaydate = getDBDateStr( rs.getString("repair_delaydate") );
		repair_delaymoney = getDBStr( rs.getString("repair_delaymoney") );
		financing_delaydate = getDBDateStr( rs.getString("financing_delaydate") );
		financing_delaymoney = getDBStr( rs.getString("financing_delaymoney") );
		operation_way = getDBStr( rs.getString("operation_way") );
	}
	rs.close(); 
	db.close();
%>
<body onLoad="fun_winMax();">

<form name="form1" method="post" action="claims_save.jsp" onSubmit="return checkdata(this);">	
<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
保险管理 &gt; 保险赔款确认
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
		<td><a href="claims_update.jsp?czid=<%= czid %>"  accesskey="m" title="保存(Alt+M)" class="fontcolor">
		<img src="../../images/sbtn_mod.gif" width="19" height="19" align="absmiddle" >修改</a>
	  	<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">明 细</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td>保险公司</td>
    <td><input name="insurer" type="text" size="20" maxB="50" readonly  value="<%= insurer %>"></td>
    <td>分公司</td>
    <td><input name="sale_id" type="text" size="20" maxB="50" readonly value="<%= sale_id %>"></td>
     <td>机编号</td>
    <td><input name="equip_sn" type="text" size="20" maxB="50" Require="true" readonly value="<%= equip_sn %>"><input type="hidden" name="contract_id" value="<%= contract_id %>"></td>
    
     </tr>
     <tr>
     <td>日期</td>
    <td><input name="claims_date" type="text" size="15" maxlength=	"10" dataType="Date" readonly value="<%= claims_date %>"> </td>
     <td>姓名</td>
    <td><input name="claims_name" type="text" size="20" maxB="50" readonly value="<%= claims_name %>"></td>
   
    <td>赔款金额</td>
    <td><input name="claims_money" type="text" size="20"  maxB="50" readonly  dataType="Money" value="<%= claims_money %>"></td>
     </tr>
    <tr>
    <td>确认维修欠款时间</td>
    <td><input name="repair_delaydate" type="text"  size="15"  maxlength="10" dataType="Date" readonly value="<%= repair_delaydate %>"> </td>
    <td>确认维修欠款金额</td>
    <td><input name="repair_delaymoney" type="text" size="20" maxB="50" readonly dataType="Money" value="<%= repair_delaymoney %>"></td>
    <td>融资或分期欠款时间</td>
    <td><input name="financing_delaydate" type="text" size="15" maxlength="10" dataType="Date" readonly value="<%= financing_delaydate %>"> </td>
     </tr>
     <tr>
     <td>融资或分期欠款金额</td>
    <td><input name="financing_delaymoney" type="text" size="20"  maxB="50" dataType="Money" readonly value="<%= financing_delaymoney %>"></td>
     <td>操作方式</td>
    <td><input name="operation_way" type="text" size="20" maxB="50"  readonly value="<%= operation_way %>"></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
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

</script>
</form>
<!-- end cwMain -->
</body>
</html>
