<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>网银核销 - 修改网银数据</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="fun_winMax();">
<form name="form1" method="post" action="ebank_save.jsp" onSubmit="return checkdata(this);">
<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
网银挂账 &gt; 修改网银数据
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
//--------以上为权限控制-----------------------------
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
String czid = getStr( request.getParameter("czid") );

String col_str="ebdata_id,up_id,own_bank,own_account,own_acc_number,client_bank,client_account,client_acc_number,client_name,money_type,";
col_str += "fact_money,fact_date,used_money,left_money,sn,status,business_flag,summary,upload_date";

sqlstr = "select "+col_str+" from fund_ebank_data where ebdata_id='"+czid+"'";

rs = db.executeQuery(sqlstr); 

String ebdata_id = "";
String own_bank = ""; //本方银行
String own_account = ""; //本方账户
String own_acc_number = "";//本方账号
String client_bank = ""; //对方银行
String client_account = "";//对方账户
String client_acc_number = "";//对方账号
String client_name = "";//付款人
String money_type = "";//到账金额类型
String fact_money = "";//到账金额
String fact_date = "";//到账时间
String used_money = "";//已使用金额
String left_money = "";//有效金额
String sn = "";//流水号
String status = "";//状态 0代表 有效  1代表 无效
String business_flag = ""; //是否租赁相关 0有关 1无关
String summary = "";//备注 、摘要
String upload_date = "";//上传时间

if ( rs.next() ) {
	own_bank = getDBStr( rs.getString("own_bank") );
	own_account = getDBStr( rs.getString("own_account") );
	own_acc_number = getDBStr( rs.getString("own_acc_number") );
	client_bank = getDBStr( rs.getString("client_bank") );
	client_account = getDBStr( rs.getString("client_account") );
	client_acc_number = getDBStr( rs.getString("client_acc_number") );
	
	client_name = getDBStr( rs.getString("client_name") );
	money_type = getDBStr( rs.getString("money_type") );
	fact_money = getDBStr( rs.getString("fact_money") );
	fact_date = getDBDateStr( rs.getString("fact_date") );

	used_money = getDBStr( rs.getString("used_money") );
	left_money = getDBStr( rs.getString("left_money") );
	sn = getDBStr( rs.getString("sn") );
	
	status = getDBStr( rs.getString("status") );
	business_flag = getDBStr( rs.getString("business_flag") );
	summary = getDBStr( rs.getString("summary") );
	upload_date = getDBDateStr( rs.getString("upload_date") );
}
rs.close(); 
db.close();
%>
<% if( !"0.00".equals(used_money) ){ 
%>
<h1 style="color: red;font-weight: bold;font-size: 20px;">抱歉，该笔款项已经核销，不允许该操作！</h1>
<%	
}else{
%>	
<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="czid" value="<%=czid %>">
<table class="tab_table_title" border="0" cellspacing="0" cellpadding="0" width="100%">
  <tr>
    <td>网银编号</td>
    <td><%= czid %></td>
    <td>到账银行</td>
    <td><%=own_bank %></td>
  </tr>
  <tr>
    <td>到账账号</td>
    <td><%=own_acc_number %></td>
    <td>摘要</td>
    <td><%=summary %></td>
  </tr>
  <tr>
    <td>付款客户</td>
    <td><%=client_name %></td>
    <td>付款账号</td>
    <td><%=client_acc_number %></td>
  </tr>
  <tr>
    <td>到帐金额</td>
    <td><%=CurrencyUtil.convertFinance(fact_money) %></td>
    <td>到帐时间</td>
    <td><%=fact_date %></td>
  </tr>
  <tr>
    <td>状态</td>
    <td><%= "0".equals(status)?"有效":"无效" %></td>
    <td>是否租赁相关</td>
    <td><select name="business_flag"><script type="text/javascript">w(mSetOpt("<%=business_flag%>",'有关|没关'));</script></select></td>
  </tr>
</table>
<% } %>

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
//	var lease_acc_number;
//	var client_acc_number;
//	lease_acc_number=document.getElementById("lease_acc_number").value;
//	client_acc_number=document.getElementById("client_acc_number").value;
//	if(lease_acc_number=="" && client_acc_number==""){
//		alert("甲方帐号和乙方帐号不能同时为空！");
//		return false;
//	}
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
