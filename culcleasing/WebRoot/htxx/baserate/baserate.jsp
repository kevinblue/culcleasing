<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>利率信息 - 央行基准利率</title>
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
if (right.CheckRight("htxx-baserate-view",dqczy)>0) canedit=1;
%>
<script>
if (<%=canedit%>==0){
	window.close();
	opener.alert("您没有操作权限！");
}

</script>
<%
//--------以上为权限控制-----------------------------
	String czid = getStr( request.getParameter("czid") );
	
	String sqlstr = "select fund_standard_interest.id,fund_standard_interest.start_date,fund_standard_interest.rate_half,fund_standard_interest.rate_one,fund_standard_interest.rate_three,fund_standard_interest.rate_five,fund_standard_interest.rate_abovefive,fund_standard_interest.base_rate_half,fund_standard_interest.base_rate_one,fund_standard_interest.base_rate_three,fund_standard_interest.base_rate_five,fund_standard_interest.base_rate_abovefive from fund_standard_interest where fund_standard_interest.id='"+czid+"'"; 
	//System.out.println("sqlstr======================"+sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 

	String	start_date = "";
	String	rate_half = "";
	String	rate_one = "";
	String	rate_three = "";
	String	rate_five = "";
	
	String	rate_abovefive = "";
	String	base_rate_half = "";
	String	base_rate_one = "";
	String	base_rate_three = "";
	String	base_rate_five = "";
	String	base_rate_abovefive = "";


	if ( rs.next() ) {
		start_date = getDBDateStr( rs.getString("start_date") );
		rate_half = getDBDecStr( rs.getBigDecimal("rate_half",4) ).toString();
		rate_one = getDBDecStr( rs.getBigDecimal("rate_one",4) ).toString();
		rate_three = getDBDecStr( rs.getBigDecimal("rate_three",4) ).toString();
		rate_five = getDBDecStr( rs.getBigDecimal("rate_five",4) ).toString();
		rate_abovefive = getDBDecStr( rs.getBigDecimal("rate_abovefive",4) ).toString();
		base_rate_half = getDBDecStr( rs.getBigDecimal("base_rate_half",4) ).toString();
		base_rate_one = getDBDecStr( rs.getBigDecimal("base_rate_one",4) ).toString();
		base_rate_three = getDBDecStr( rs.getBigDecimal("base_rate_three",4) ).toString();
		base_rate_five = getDBDecStr( rs.getBigDecimal("base_rate_five",4) ).toString();
		base_rate_abovefive = getDBDecStr( rs.getBigDecimal("base_rate_abovefive",4) ).toString();
	}
	rs.close(); 
	db.close();
%>
<body onload="fun_winMax();">

<form name="form1" method="post" action="baserate_save.jsp" onSubmit="return checkdata(this);">	
<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
央行基准利率
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
		<%
			if (right.CheckRight("htxx-baserate-mod",dqczy)>0){
		%>
		<a href="baserate_mod.jsp?czid=<%= czid %>"  accesskey="m" title="修改(Alt+M)" class="fontcolor">
		<img src="../../images/sbtn_mod.gif" width="19" height="19" align="absmiddle" >修改</a>
		<%} %>
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
    <td scope="row" nowrap width="20%">利率开始执行日期：</td>
    <td colspan="3"><%=start_date %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">利息央行基准_六月：</td>
    <td><%=base_rate_half %>%</td>

	<td scope="row" nowrap width="20%">利息调整幅度_六月：</td>
    <td><%=rate_half %>%</td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">利息央行基准_1年：</td>
    <td><%=base_rate_one %>%</td>

	<td scope="row" nowrap width="20%">利息调整幅度_1年：</td>
    <td><%=rate_one %>%</td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">利息央行基准_3年：</td>
    <td><%=base_rate_three %>%</td>

	<td scope="row" nowrap width="20%">利息调整幅度_3年：</td>
    <td><%=rate_three %>%</td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">利息央行基准_5年：</td>
    <td><%=base_rate_five %>%</td>

	<td scope="row" nowrap width="20%">利息调整幅度_5年：</td>
    <td><%=rate_five %>%</td>
  </tr>
  
  <tr>
    <td scope="row" nowrap width="20%">利息央行基准_5年以上：</td>
    <td><%=base_rate_abovefive %>%</td>

	<td scope="row" nowrap width="20%">利息调整幅度_5年以上：</td>
    <td><%=rate_abovefive %>%</td>
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
