<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同后期管理 - 非正常结束</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>

</head>
<%
	String sqlstr;
	ResultSet rs;
	String contract_id = getStr( request.getParameter("contract_id") );
	String type = getStr( request.getParameter("type") );
	String type_name="";
	if(type.equals("1")){
		type_name="解约";
	}else if(type.equals("2")){
		type_name="提前还款";
	}else{
		type_name="回购";
	}
	
	String asset_ownership="";
	String asset_ownership_name="";
	String back_buyer="";
	String back_buyer_name="";
	String appoint_date="";
	String default_standard="";
	String default_standard_name="";
	String default_rate="";
	String reason="";
	String reason_name="";
	String memo="";
	
	sqlstr="select contract_abnormal_end.asset_ownership,contract_abnormal_end.back_buyer,contract_abnormal_end.appoint_date,contract_abnormal_end.default_standard,contract_abnormal_end.default_rate,contract_abnormal_end.reason,contract_abnormal_end.memo,vi_cust_all_info.cust_name,ifelc_conf_dictionary.title as asset_ownership_name,ifelc_conf_dictionary2.title as reason_name from contract_abnormal_end left join vi_cust_all_info on contract_abnormal_end.back_buyer=vi_cust_all_info.cust_id left join ifelc_conf_dictionary on contract_abnormal_end.asset_ownership=ifelc_conf_dictionary.name left join ifelc_conf_dictionary ifelc_conf_dictionary2 on contract_abnormal_end.reason=ifelc_conf_dictionary2.name where contract_abnormal_end.contract_id='"+contract_id+"'";
	//System.out.println("sqlstr==========================================="+sqlstr);
	rs=db.executeQuery(sqlstr);
	while(rs.next()){
		asset_ownership=getDBStr(rs.getString("asset_ownership"));
		asset_ownership_name=getDBStr(rs.getString("asset_ownership_name"));
		back_buyer=getDBStr(rs.getString("back_buyer"));
		back_buyer_name=getDBStr(rs.getString("cust_name"));
		appoint_date=getDBDateStr(rs.getString("appoint_date"));
		default_standard=getDBStr(rs.getString("default_standard"));
		default_standard_name=default_standard.equals("1")?"应回收租金":default_standard.equals("2")?"应回收本金":default_standard;
		
		default_rate=getDBStr(rs.getString("default_rate"));
		reason=getDBStr(rs.getString("reason"));
		reason_name=getDBStr(rs.getString("reason_name"));
		memo=getDBStr(rs.getString("memo"));
	}rs.close();
	db.close();
%>
<body>
<form name="form1" method="post" action="htgf_save.jsp" onSubmit="return checkdata(this);">	
<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<!-- 
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
合同后期管理 - 非正常结束
</td>
</tr>
 -->
<tr valign="top">
<td  align=center width=100% height=100%>
<!-- 
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
 -->
<!--操作按钮开始-->
<!-- 
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr style="displan:none">
		<td><a href="htgf_mod.jsp?czid=<%= 1 %>"  accesskey="m" title="修改(Alt+M)" class="fontcolor">
		<img src="../../images/sbtn_mod.gif" width="19" height="19" align="absmiddle" >修改</a>
	  	<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
		<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button></td>
	  </tr>
</table>
-->
<!--操作按钮结束-->
<!-- 
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
-->
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
<%
	if(type.equals("1")){
 %>
  <tr>
    <td scope="row" nowrap width="20%">处理方式：</td>
    <td><%=type_name %></td>
    <td scope="row" nowrap width="20%">资产所有权：</td>
    <td><%=asset_ownership_name %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">约定解约日：</td>
    <td><%=appoint_date %></td>
	<td scope="row" nowrap width="20%">违约金基准：</td>
    <td><%=default_standard_name %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">违约手续费率：</td>
    <td><%=default_rate %>%</td>
	<td scope="row" nowrap width="20%">解约原因类型：</td>
    <td><%=reason_name %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">备注：</td>
    <td colspan="3"><%=memo %></td>
  </tr>
  <%}else  if(type.equals("2")){
 %>
  <tr>
    <td scope="row" nowrap width="20%">处理方式：</td>
    <td colspan="3"><%=type_name %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">回购期：</td>
    <td><%=appoint_date %></td>
	<td scope="row" nowrap width="20%">违约金基准：</td>
    <td><%=default_standard_name %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">提前还款手续费率：</td>
    <td><%=default_rate %>%</td>
	<td scope="row" nowrap width="20%">提前还款原因：</td>
    <td><%=reason_name %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">备注：</td>
    <td colspan="3"><%=memo %></td>
  </tr>
  <%}else{
 %>
  <tr>
    <td scope="row" nowrap width="20%">处理方式：</td>
    <td><%=type_name %></td>
    <td scope="row" nowrap width="20%">回购人：</td>
    <td><%=back_buyer_name %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">回购期：</td>
    <td><%=appoint_date %></td>
    <td scope="row" nowrap width="20%">违约金基准：</td>
    <td><%=default_standard_name %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">回购手续费率：</td>
    <td><%=default_rate %>%</td>
    <td scope="row" nowrap width="20%">回购原因：</td>
    <td><%=reason_name %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">备注：</td>
    <td colspan="3"><%=memo %></td>
  </tr>
  <%} %>
</table>
<br>

<div id="TD_tab_1"> 
<table border="0" cellspacing="0" cellpadding="0" width="100%" align="center">
<tr bgcolor="#8DB2E3"><td>费用处理</td></tr>
<tr>
<td><iframe frameborder="0" width="100%" src="./noNormalEndFeeHl_read.jsp?contract_id=<%=contract_id%>&type=<%=type%>"></iframe></td>
</tr>
</table>
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

</form>
<!-- end cwMain -->
</body>
</html>
