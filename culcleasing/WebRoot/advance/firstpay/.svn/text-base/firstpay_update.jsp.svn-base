<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>首付款还款明细 - 首付款管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>

<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
	dqczy="无认证";
}
int canmod=0;


	String czid = getStr( request.getParameter("czid") );
String sqlstr = "select views.equip_sn,views.contract_id,views.cust_name,views.sale_name,views.leas_mode,views.out_time,isnull(views.peroid_payment,0) peroid_payment,isnull(dbo.fk_getfactmoney(views.contract_id),0) factmoney,advance.special_date_number,advance.special_date from contract_view views left join fund_rent_advance advance on views.contract_id = advance.contract_id where views.contract_id = '"+czid+"'";
	ResultSet rs = db.executeQuery(sqlstr); 
	String	equip_sn = "";
	String	contract_id = "";
	String	cust_name = "";
	String	sale_name = "";
	String	leas_mode = "";
	String	out_time = "";
	String	peroid_payment = "";
	String	factmoney = "";
	String	special_date_number = "";
	String	special_date = "";
if ( rs.next() ) {
		equip_sn = getDBStr( rs.getString("equip_sn") );
		contract_id = getDBStr( rs.getString("contract_id") );
		cust_name = getDBStr( rs.getString("cust_name") );
		sale_name = getDBStr( rs.getString("sale_name") );
		leas_mode =getDBStr( rs.getString("leas_mode") );
		out_time = getDBDateStr( rs.getString("out_time") );
		peroid_payment = getMoneyStr( rs.getString("peroid_payment") );
		factmoney = getMoneyStr( rs.getString("factmoney") );
		special_date_number = getDBStr( rs.getString("special_date_number") );
		special_date = getDBDateStr( rs.getString("special_date") );
	}
	rs.close(); 
	db.close();
%>
<body onLoad="fun_winMax();">
<form name="form1" method="post" action="firstpay_save.jsp" onSubmit="return Validator.Validate(this,3);">
<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
首付款管理 &gt; 首付款还款明细
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
	    	
<BUTTON class="btn_2" name="btnSave" value="保存"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">保存</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>

	    	</td>
	  </tr>
</table>
<!--操作按钮结束-->

<!--操作按钮开始-->

<!--操作按钮结束-->
</td>
</tr>

<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
<center>



<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="czid" value="<%= czid %>">
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td>机编号</td>
    <td><input name="equip_sn" type="text" value="<%= equip_sn %>" size="20" maxB="50" readonly ></td>
    <td>合同号</td>
    <td><input name="contract_id" type="text" value="<%= contract_id %>" size="20" maxB="50" readonly></td>
    <td>客户</td>
    <td><input name="cust_name" type="text" value="<%= cust_name %>" size="20" maxB="50" readonly></td>
   </tr>
   <tr>
    <td>分公司</td>
    <td><input name="sale_id" type="text" value="<%= sale_name %>" size="20" maxB="50" readonly></td>
    <td>融资模式</td>
    <td><input name="advance_amt" type="text" value="<%= leas_mode %>" onChange="delay()" size="20" maxB="50" readonly></td>
    <td>放机日期</td>
    <td><input name="special_flag" type="text" value="<%= out_time %>" size="20" maxB="50" readonly></td>
  </tr>
  <tr>    
    <td>初期首付总额</td>
    <td><input name="out_time" type="text" value="<%= peroid_payment %>" size="20" maxB="50" readonly></td>
    <td>实收总额</td>
    <td><input name="special_date_number" type="text" value="<%= factmoney %>" size="20" maxB="50" readonly></td>
    <td>特批延期付款天数</td>
    <td><input name="special_date"  type="text" value="<%= special_date_number %>" size="15" maxlength="10" dataType="Number" ></td>
  </tr>
  <tr>    
    <td>最终还款期限</td>
    <td><input name="income_total" type="text"  value="<%= special_date %>" size="20" maxB="50" readonly></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
</table>
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

<!--控制选择卡和内置iframe的高度适应窗口-->
<script language="javascript">

</script>
</form>








<!-- end cwMain -->
</body>
</html>
ss