<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>网银核销 - 修改网银核销</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>



<body onload="fun_winMax();">
<form name="form1" method="post" action="ebank_save.jsp" onSubmit="return checkdata(this);">
<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
网银核销 &gt; 修改网银核销
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
<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>

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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">修改信息</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("ebank-ebank-mod",dqczy)>0) canedit=1;
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
sqlstr = "select fund_ebank_data.order_number, fund_ebank_data.arrive_date, fund_ebank_data.account_bank, fund_ebank_data.acc_number, fund_ebank_data.client_name, fund_ebank_data.client_accnumber, isnull(fund_ebank_data.fact_money,0) as fact_money, fund_ebank_data.summary, fund_ebank_data.sn, fund_ebank_data.status, fund_ebank_data.business_flag from fund_ebank_data" + wherestr; 
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


<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="czid" value="<%= czid %>">
<table class="tab_table_title" border="0" cellspacing="0" cellpadding="0" width="100%">
  <tr>
    <td>网银编号</td>
    <td><%= czid%></td>
    <td>序号</td>
    <td><%= order_number%></td>
  </tr>
  <tr>
    <td>到帐时间</td>
    <td><%= arrive_date%></td>
    <td>到帐银行</td>
    <td><%= account_bank%></td>
  </tr>
  <tr>
    <td>到帐帐号</td>
    <td><%= acc_number%></td>
    <td>付款客户</td>
    <td><input name="client_name" type="text" size="50" value="<%= client_name%>"></td>
  </tr>
  <tr>
    <td>客户帐号</td>
    <td><%= client_accnumber%></td>
    <td>金额</td>
    <td><%= fact_money%></td>
  </tr>
  <tr>
    <td>摘要</td>
    <td><%= summary%></td>
    <td>流水号</td>
    <td><%= sn%></td>
  </tr>
  <tr>
    <td>状态</td>
    <td><select name="status"><script>w(mSetOpt("<%=status%>",'有效|无效'));</script></select></td>
    <td>是否租赁相关</td>
    <td><select name="business_flag"><script>w(mSetOpt("<%=business_flag%>",'是|否'));</script></select></td>
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
ShowTabN(0);
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
function checkdata(obj){
	var lease_acc_number;
	var client_acc_number;
	lease_acc_number=document.getElementById("lease_acc_number").value;
	client_acc_number=document.getElementById("client_acc_number").value;
	if(lease_acc_number=="" && client_acc_number==""){
		alert("甲方帐号和乙方帐号不能同时为空！");
		return false;
	}
	return Validator.Validate(obj,3);
}
//内部Iframe高度自适应
//function autoResize()
//{
//	try
//	{
//		document.all["UserBody1"].style.height=UserBody1.document.body.scrollHeight
//	}
//	catch(e)
//	{}
//}
</script>
</form>








<!-- end cwMain -->
</body>
</html>
