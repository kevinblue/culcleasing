<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ include file="../../func/common_simple.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>调息管理 - 记录明细</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>
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
<body onload="fun_winMax();">

<form name="form1" method="post" action="tx_save.jsp" onSubmit="return checkdata(this);">	
<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
调息记录明细
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
		<td><a href="tx_mod.jsp?czid=<%= czid %>"  accesskey="m" title="修改(Alt+M)" class="fontcolor">
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
    <td scope="row" nowrap width="20%">央行基础利率：</td>
    <td><%=base_rate %>%</td>

    <td scope="row" nowrap width="20%">租赁公司基础利率：</td>
    <td><%=base_adjust_rate %>%</td>
  </tr>
  
  <tr>
    <td scope="row" nowrap width="20%">央行利率调整日期：</td>
    <td><%=base_date %></td>
    <td scope="row" nowrap width="20%">系统租金变更执行日期：</td>
    <td><%=start_date %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">央行调整后利率：</td>
    <td><%=yh_adjust_rate %>%</td>

    <td scope="row" nowrap width="20%">期限：</td>
    <td><%=nx %></td>
  </tr>
  
  <tr>
    <td scope="row" nowrap width="20%">利率差下限：</td>
    <td><%=rate_limit %>%</td>
    <td scope="row" nowrap width="20%">是否调息完成：</td>
    <td><%=adjust_flag %></td>
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
</form>
<!-- end cwMain -->
</body>
</html>
