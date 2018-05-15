<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金垫付 - 租金垫付管理</title>
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
if (right.CheckRight("depttarget-depttarget-view",dqczy)>0) canedit=1;
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
	String sqlstr = "select base_dept_target.*,jb_gsbm.bmmc from base_dept_target left join jb_gsbm on base_dept_target.dept_id=jb_gsbm.id where base_dept_target.id=" + czid ; 
	//System.out.println("sqlstr======================"+sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 

	String	target_year = "";
	String	dept_id = "";
	String	bmmc = "";
	String	target_1_asset = "";
	String	target_1_corpus = "";
	String	target_2_asset = "";
	String	target_2_corpus = "";
	String	target_3_asset = "";
	String	target_3_corpus = "";
	String	target_4_asset = "";
	String	target_4_corpus = "";
	String	target_5_asset = "";
	String	target_5_corpus = "";
	String	target_6_asset = "";
	String	target_6_corpus = "";
	String	target_7_asset = "";
	String	target_7_corpus = "";
	String	target_8_asset = "";
	String	target_8_corpus = "";
	String	target_9_asset = "";
	String	target_9_corpus = "";
	String	target_10_asset = "";
	String	target_10_corpus = "";
	String	target_11_asset = "";
	String	target_11_corpus = "";
	String	target_12_asset = "";
	String	target_12_corpus = "";


	if ( rs.next() ) {
		target_year = getDBStr( rs.getString("target_year") );
		dept_id = getDBStr( rs.getString("dept_id") );
		bmmc = getDBStr( rs.getString("bmmc") );
		target_1_asset = formatNumberStr(getDBStr( rs.getString("target_1_asset") ),"#,##0.00");
		target_1_corpus = formatNumberStr(getDBStr( rs.getString("target_1_corpus") ),"#,##0.00");
		target_2_asset = formatNumberStr(getDBStr( rs.getString("target_2_asset") ),"#,##0.00");
		target_2_corpus = formatNumberStr(getDBStr( rs.getString("target_2_corpus") ),"#,##0.00");
		target_3_asset = formatNumberStr(getDBStr( rs.getString("target_3_asset") ),"#,##0.00");
		target_3_corpus = formatNumberStr(getDBStr( rs.getString("target_3_corpus") ),"#,##0.00");
		target_4_asset = formatNumberStr(getDBStr( rs.getString("target_4_asset") ),"#,##0.00");
		target_4_corpus = formatNumberStr(getDBStr( rs.getString("target_4_corpus") ),"#,##0.00");
		target_5_asset = formatNumberStr(getDBStr( rs.getString("target_5_asset") ),"#,##0.00");
		target_5_corpus = formatNumberStr(getDBStr( rs.getString("target_5_corpus") ),"#,##0.00");
		target_6_asset = formatNumberStr(getDBStr( rs.getString("target_6_asset") ),"#,##0.00");
		target_6_corpus = formatNumberStr(getDBStr( rs.getString("target_6_corpus") ),"#,##0.00");
		target_7_asset = formatNumberStr(getDBStr( rs.getString("target_7_asset") ),"#,##0.00");
		target_7_corpus = formatNumberStr(getDBStr( rs.getString("target_7_corpus") ),"#,##0.00");
		target_8_asset = formatNumberStr(getDBStr( rs.getString("target_8_asset") ),"#,##0.00");
		target_8_corpus = formatNumberStr(getDBStr( rs.getString("target_8_corpus") ),"#,##0.00");
		target_9_asset = formatNumberStr(getDBStr( rs.getString("target_9_asset") ),"#,##0.00");
		target_9_corpus = formatNumberStr(getDBStr( rs.getString("target_9_corpus") ),"#,##0.00");
		target_10_asset = formatNumberStr(getDBStr( rs.getString("target_10_asset") ),"#,##0.00");
		target_10_corpus = formatNumberStr(getDBStr( rs.getString("target_10_corpus") ),"#,##0.00");
		target_11_asset = formatNumberStr(getDBStr( rs.getString("target_11_asset") ),"#,##0.00");
		target_11_corpus = formatNumberStr(getDBStr( rs.getString("target_11_corpus") ),"#,##0.00");
		target_12_asset = formatNumberStr(getDBStr( rs.getString("target_12_asset") ),"#,##0.00");
		target_12_corpus = formatNumberStr(getDBStr( rs.getString("target_12_corpus") ),"#,##0.00");
		
	}
	rs.close(); 
	db.close();
%>
<body onload="fun_winMax();">

<form name="form1" method="post" action="depttarget_save.jsp" onSubmit="return checkdata(this);">	
<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
租金垫付明细
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
    		if (right.CheckRight("depttarget-depttarget-mod",dqczy)>0){
    	 %>
		<a href="depttarget_mod.jsp?czid=<%= czid %>"  accesskey="m" title="修改(Alt+M)" class="fontcolor">
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
    <td scope="row" nowrap width="20%">指标年份：</td>
    <td><%=target_year %></td>
    <td scope="row" nowrap width="20%">部门：</td>
    <td><%=bmmc %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">1月份计划完成设备金额指标：</td>
    <td><%=target_1_asset %></td>
	<td scope="row" nowrap width="20%">1月份计划完成本金指标：</td>
    <td><%=target_1_corpus %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">2月份计划完成设备金额指标：</td>
    <td><%=target_2_asset %></td>
	<td scope="row" nowrap width="20%">2月份计划完成本金指标：</td>
    <td><%=target_2_corpus %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">3月份计划完成设备金额指标：</td>
    <td><%=target_3_asset %></td>
	<td scope="row" nowrap width="20%">3月份计划完成本金指标：</td>
    <td><%=target_3_corpus %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">4月份计划完成设备金额指标：</td>
    <td><%=target_4_asset %></td>
	<td scope="row" nowrap width="20%">4月份计划完成本金指标：</td>
    <td><%=target_4_corpus %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">5月份计划完成设备金额指标：</td>
    <td><%=target_5_asset %></td>
	<td scope="row" nowrap width="20%">5月份计划完成本金指标：</td>
    <td><%=target_5_corpus %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">6月份计划完成设备金额指标：</td>
    <td><%=target_6_asset %></td>
	<td scope="row" nowrap width="20%">6月份计划完成本金指标：</td>
    <td><%=target_6_corpus %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">7月份计划完成设备金额指标：</td>
    <td><%=target_7_asset %></td>
	<td scope="row" nowrap width="20%">7月份计划完成本金指标：</td>
    <td><%=target_7_corpus %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">8月份计划完成设备金额指标：</td>
    <td><%=target_8_asset %></td>
	<td scope="row" nowrap width="20%">8月份计划完成本金指标：</td>
    <td><%=target_8_corpus %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">9月份计划完成设备金额指标：</td>
    <td><%=target_9_asset %></td>
	<td scope="row" nowrap width="20%">9月份计划完成本金指标：</td>
    <td><%=target_9_corpus %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">10月份计划完成设备金额指标：</td>
    <td><%=target_10_asset %></td>
	<td scope="row" nowrap width="20%">10月份计划完成本金指标：</td>
    <td><%=target_10_corpus %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">11月份计划完成设备金额指标：</td>
    <td><%=target_11_asset %></td>
	<td scope="row" nowrap width="20%">11月份计划完成本金指标：</td>
    <td><%=target_11_corpus %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">12月份计划完成设备金额指标：</td>
    <td><%=target_12_asset %></td>
	<td scope="row" nowrap width="20%">12月份计划完成本金指标：</td>
    <td><%=target_12_corpus %></td>
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
