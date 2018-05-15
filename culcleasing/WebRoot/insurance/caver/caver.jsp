<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>保险管理 - 保险是否覆盖融资期限表</title>
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
if (right.CheckRight("insurance-caver-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");



	String czid = getStr( request.getParameter("czid") );
String sqlstr = "select caver.caver_id,views.contract_id,views.cust_name,device_type,views.equip_sn,views.equip_num,views.lease_term months,views.years,views.start_date,views.end_date,views.insurance_date,views.insurance_enddate,views.insurer,views.days,caver.insurance_state,caver.insurance_result from  contract_view views left join insurance_caver caver on views.contract_id = caver.contract_id where views.contract_id = '"+czid+"'";
	ResultSet rs = db.executeQuery(sqlstr);
	String	contract_id = "";
	String	cust_name = "";
	String	device_type = "";
	String	equip_sn = "";
	String	equip_num = "";
	String	months = "";
	String	years = "";
	String	start_date = "";
	String	end_date = "";
	String	insurance_date = "";
	String	insurance_enddate = "";
	String	insurer = "";
	String	days = "";
	String	insurance_state = "";
	String	insurance_result = "";
	String caver_id = "";
if ( rs.next() ) {
		caver_id = getDBStr( rs.getString("caver_id") );
		contract_id = getDBStr( rs.getString("contract_id") );
		cust_name = getDBStr( rs.getString("cust_name") );
		device_type = getDBStr( rs.getString("device_type") );
		equip_sn = getDBStr( rs.getString("equip_sn") );
		equip_num = getDBStr( rs.getString("equip_num") );
		months = getDBStr( rs.getString("months") );
		years = getDBStr( rs.getString("years") );
		start_date = getDBDateStr( rs.getString("start_date") );
		end_date = getDBDateStr( rs.getString("end_date") );
		insurance_date = getDBDateStr( rs.getString("insurance_date") );
		insurance_enddate = getDBDateStr( rs.getString("insurance_enddate") );
		insurer = getDBStr( rs.getString("insurer") );
		days = getDBStr( rs.getString("days") );
		insurance_state = getDBStr( rs.getString("insurance_state") );
		insurance_result = getDBStr( rs.getString("insurance_result") );
	}
	rs.close(); 
	db.close();
%>
<body onLoad="fun_winMax();">

<form name="form1" method="post" action="caver_save.jsp" onSubmit="return checkdata(this);">	
<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
保险管理 &gt; 保险是否覆盖融资期限表
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
		<td><a href="caver_update.jsp?czid=<%= czid %>"  accesskey="m" title="修改(Alt+M)" class="fontcolor">
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
    <td>合同号</td>
    <td><input name="contract_id" type="text" value="<%= contract_id %>" size="20" maxB="50" readonly ></td>
    <td>客户名</td>
    <td><input name="cust_name" type="text" value="<%= cust_name %>" size="20" maxB="50" readonly ></td>
    <td>型号</td>
    <td><input name="device_type" type="text" value="<%= device_type %>" size="20" maxB="50" readonly></td>
   </tr>
   <tr>
    <td>机编号</td>
    <td><input name="equip_sn" type="text" value="<%= equip_sn %>" size="20" maxB="50" readonly></td>
    <td>台数</td>
    <td><input name="equip_num" type="text" value="<%= equip_num %>" size="20" maxB="50" readonly></td>
    <td>融资期限（月）</td>
    <td><input name="months" type="text" value="<%= months %>" size="20" maxB="50" readonly></td>
  </tr>
  <tr>
    <td>融资期限（年）</td>
    <td><input name="years" type="text" value="<%= years %>" size="20" maxB="50" readonly></td>
    <td>租赁起始日</td>
    <td><input name="start_date" type="text" value="<%= start_date %>" size="20" maxB="50" readonly></td>
    <td>租赁截止日</td>
    <td><input name="end_date" type="text" value="<%= end_date %>" size="20" maxB="50" readonly></td>
  </tr>
  <tr>
    <td>保险起始日</td>
    <td><input name="insurance_date" type="text" value="<%= insurance_date %>" size="20" maxB="50" readonly></td>
    <td>保险截止日</td>
    <td><input name="insurance_enddate" type="text" value="<%= insurance_enddate %>" size="20" maxB="50" readonly></td>
    <td>保险公司</td>
    <td><input name="insurer" type="text" value="<%= insurer %>" size="20" maxB="50" readonly></</td>
  </tr>
  <tr>
    <td>覆盖误差(天数)</td>
    <td><input name="days" type="text" value="<%= days %>" size="20" maxB="50" readonly ></td>
    <td>处理状态</td>
    <td>
    <input name="insurance_state" type="text" value="<%= "1".equals(insurance_state) ? "已处理"  :"待处理" %>" readonly size="20" maxB="50" readonly></td>
    <td>处理结果</td>
    <td><input name="insurance_result" type="text" value="<%= insurance_result %>" readonly size="20" maxB="50" readonly></td>
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
