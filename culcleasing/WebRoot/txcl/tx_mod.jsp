<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common_simple.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>调息管理 - 修改调息记录</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>

<body onload="fun_winMax();">
<form name="form1" method="post" action="tx_save.jsp" onSubmit="return Validator.Validate(this,3);">
<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
调息管理 &gt; 修改调息记录
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
//--------以上为权限控制-----------------------------

	String czid = getStr( request.getParameter("czid") );
	String sqlstr = "select base_adjust_interest.* from base_adjust_interest where base_adjust_interest.id='" + czid + "'"; 
	//System.out.println("sqlstr======================"+sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 

	String	base_rate = "";
	String	base_adjust_rate = "";
	String	base_date = "";
	String	start_date = "";
	String	rate_limit = "";
	String	adjust_flag = "";
	String	yh_adjust_rate = "";
	String	nx = "";

	if ( rs.next() ) {
		base_rate = getDBStr( rs.getString("base_rate") );
		base_adjust_rate = getDBStr( rs.getString("base_adjust_rate") );
		base_date = getDBDateStr( rs.getString("base_date") );
		start_date = getDBDateStr( rs.getString("start_date") );
		rate_limit = getDBStr( rs.getString("rate_limit") );
		adjust_flag = getDBStr( rs.getString("adjust_flag") );
		yh_adjust_rate = getDBStr( rs.getString("yh_adjust_rate") );
		nx = getDBStr( rs.getString("nx") );
	}
	rs.close(); 
	db.close();
%>


<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="czid" value="<%= czid %>">
<table class="tab_table_title" border="0" cellspacing="0" cellpadding="0" width="100%">
  <tr>
    <td>央行基础利率</td>
    <td><input name="base_rate" value="<%=base_rate %>" type="text" size="10" maxB="50" dataType="Rate" Require="true">%
	<span class="biTian">*</span></td>
	<td>租赁公司基础利率</td>
    <td><input name="base_adjust_rate" value="<%=base_adjust_rate %>" type="text" size="10" maxB="50" dataType="Rate" Require="true">%
	<span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>央行利率调整日期</td>
    <td><input name="base_date" value="<%=base_date %>" type="text" size="10" readonly maxlength="10" dataType="Date" Require="ture"> <img  onClick="openCalendar(base_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	<span class="biTian">*</span></td>
	<td>系统租金变更执行日期</td>
    <td><input name="start_date" value="<%=start_date %>" type="text" size="10" readonly maxlength="10" dataType="Date" Require="ture"> <img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	<span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>央行调整后利率</td>
    <td><input name="yh_adjust_rate" value="<%=yh_adjust_rate %>" type="text" size="10" maxB="50" dataType="Rate" Require="true">%
	<span class="biTian">*</span></td>
    <td>期限</td>
    <td><input name="nx" value="<%=nx %>" type="text" size="10" maxB="50" dataType="Rate" Require="true">
	<span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>利率差下限</td>
    <td><input name="rate_limit" value="<%=rate_limit %>" type="text" size="10" maxB="50" dataType="Rate" Require="true">%
	<span class="biTian">*</span></td>
	<td>是否调息完</td>
	<td><select name="adjust_flag"><script>w(mSetOpt("<%=adjust_flag %>",'否|是'));</script></select></td>
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
