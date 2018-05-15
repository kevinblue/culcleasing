<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>首付款管理 - DownpaymentList</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("advance-downpayment-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<%

	String czid = getStr( request.getParameter("czid") );
String sqlstr = "select views.contract_id,dbo.FK_GETVouchNo(views.contract_id) VouchNo,views.equip_sn,views.device_type,stock_place,views.cust_name,views.leas_mode,views.sale_name,isnull(views.peroid_payment,0) peroid_payment,isnull(dbo.fk_getfactmoney(views.contract_id),0) factmoney,dbo.fk_getfactinfo(views.contract_id) fact_info,isnull(views.peroid_payment,0)-isnull(dbo.fk_getfactmoney(views.contract_id),0) equals,views.insurance_flag,views.insurance,views.csa_cost,confirm_date,notarial_charge,remark from contract_view views left join downpayment_info as info on(views.contract_id=info.contract_id)  where views.contract_id = '"+czid+"'";
	ResultSet rs = db.executeQuery(sqlstr); 
	String	contract_id = "";
	String	equip_sn = "";
	String	device_type = "";
	String	cust_name = "";
	String	leas_mode = "";
	String	sale_name = "";
	String	peroid_payment = "";
	String	factmoney = "";
	String	fact_info = "";
	String	equals = "";
	String	insurance_flag = "";
	String	insurance = "";
	String	csa_cost = "";
	String	remark = "";
	String	confirm_date = "";
	String	VouchNo = "";
	String	stock_place = "";
	String notarial_charge="";
if ( rs.next() ) {
	stock_place = getDBStr( rs.getString("stock_place") );
		contract_id = getDBStr( rs.getString("contract_id") );
		equip_sn = getDBStr( rs.getString("equip_sn") );
		device_type = getDBStr( rs.getString("device_type") );
		cust_name = getDBStr( rs.getString("cust_name") );
		leas_mode = getDBStr( rs.getString("leas_mode") );
		sale_name = getDBStr( rs.getString("sale_name") );
		peroid_payment = getMoneyStr( rs.getString("peroid_payment") );
		factmoney = getMoneyStr( rs.getString("factmoney") );
		fact_info = getDBStr( rs.getString("fact_info") );
		equals = getMoneyStr( rs.getString("equals") );
		insurance_flag = getDBStr( rs.getString("insurance_flag") );
		insurance = getMoneyStr( rs.getString("insurance") );
		csa_cost = getMoneyStr( rs.getString("csa_cost") );
		VouchNo = getDBStr( rs.getString("VouchNo") );
		remark = getDBStr( rs.getString("remark") );
		confirm_date = getDBDateStr( rs.getString("confirm_date") );
		notarial_charge = getDBStr( rs.getString("notarial_charge") );
	}
	rs.close();
	db.close();
%>
<body onLoad="fun_winMax();">

<form name="form1" method="post" action="downpayment_save.jsp" onSubmit="return checkdata(this);">	
<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
首付款管理 &gt; DownpaymentList
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
		<td><a href="downpayment_update.jsp?czid=<%= czid %>"  accesskey="m" title="修改(Alt+M)" class="fontcolor">
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
    <td>机编号</td>
    <td><input name="equip_sn" type="text"  size="20" maxB="50" readonly value="<%= equip_sn %>"></td>
    <td>机型</td>
    <td><input name="device_type" type="text" size="20" maxB="50" readonly value="<%= device_type %>"></td>
    <td>客户名称</td>
    <td><input name="cust_name" type="text" size="20" maxB="50" readonly value="<%= cust_name %>"> </td>
   </tr>
   <tr>
    <td>融资模式</td>
    <td><input name="leas_mode" type="text" size="20" maxB="50" readonly value="<%= leas_mode %>"></td>
    <td>库存</td>
    <td><input name="stock_place" type="text" size="20" maxB="50" readonly></td>
    <td>分公司</td> 
    <td><input name="sale_name" type="text" size="20" maxB="50" readonly value="<%= sale_name %>"></td>
  </tr>
  <tr>
    <td>初期首付总额</td>
    <td><input name="peroid_payment" type="text" size="20" maxB="50" readonly value="<%= peroid_payment %>"></td>
    <td>实收金额</td>
    <td><input name="factmoney" type="text" size="20" maxB="50" readonly value="<%= factmoney %>"></td>
    <td>实收情况</td>
    <td><textarea name="fact_info" rows="4" readonly type="text"><%= fact_info %></textarea></td>
  </tr>
  <tr>
    <td>首付差额</td>
    <td><input name="equals"  type="text" size="15" maxlength="10" readonly value="<%= equals %>"></td>
    <td>是否保险融资</td>
    <td><input name="insurance_flag" type="text" size="20" maxB="50" readonly value="<%= insurance_flag %>"></td>
    <td>保险金额</td>
    <td><input name="insurance" type="text" size="20" maxB="50" readonly value="<%= insurance %>"></td>
  </tr>
  <tr>
    <td>CSA</td>
    <td><input name="csa_cost"  type="text" size="15" maxlength="10" dataType="Date" readonly value="<%= csa_cost %>"></td>   
    <td>VouchNo</td>
    <td><input name="VouchNo" type="text" size="20" maxB="50" readonly value="<%= VouchNo %>"></td>
  </tr>
  <tr>
   <td>首付确认时间</td>
    <td><input name="confirm_date" type="text" size="20" maxB="50" readonly value="<%= confirm_date %>"></td><br>
<td>公证费 </td>
    <td><input name="notarial_charge" type="text" size="20" maxB="50" readonly value="<%= notarial_charge %>"> </td>
    <td></td><td></td><td></td>
</tr>
  <tr>
    <td>备注</td>
    <td colspan="5"><textarea name="remark" cols="20" rows="5" maxb="100" style="width:536px" readonly><%= remark %></textarea></td>
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
