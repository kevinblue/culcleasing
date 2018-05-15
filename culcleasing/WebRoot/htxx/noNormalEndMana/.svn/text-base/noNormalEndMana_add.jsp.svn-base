<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同后期管理 - 非正常结束</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT Language="Javascript" SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT Language="Javascript" SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>

</head>
<body>
<form name="form1" method="post" target="_blank" action="noNormalEndMana_save.jsp" onSubmit="return Validator.Validate(this,3);">
<style type="text/css">
body {overflow:hidden;}
</style>
<div id=bgDiv>
	
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
	String back_buyer="";
	String back_buyer_name="";
	String appoint_date="";
	String default_standard="";
	String default_rate="";
	String reason="";
	String memo="";
	
	sqlstr="select contract_abnormal_end.asset_ownership,contract_abnormal_end.back_buyer,contract_abnormal_end.appoint_date,contract_abnormal_end.default_standard,contract_abnormal_end.default_rate,contract_abnormal_end.reason,contract_abnormal_end.memo,vi_cust_all_info.cust_name from contract_abnormal_end left join vi_cust_all_info on contract_abnormal_end.back_buyer=vi_cust_all_info.cust_id where contract_abnormal_end.contract_id='"+contract_id+"'";
	//System.out.println("sqlstr==========================================="+sqlstr);
	rs=db.executeQuery(sqlstr);
	while(rs.next()){
		asset_ownership=getDBStr(rs.getString("asset_ownership"));
		back_buyer=getDBStr(rs.getString("back_buyer"));
		back_buyer_name=getDBStr(rs.getString("cust_name"));
		appoint_date=getDBDateStr(rs.getString("appoint_date"));
		default_standard=getDBStr(rs.getString("default_standard"));
		default_rate=getDBStr(rs.getString("default_rate"));
		reason=getDBStr(rs.getString("reason"));
		memo=getDBStr(rs.getString("memo"));
	}rs.close();
	db.close();
	
 %>

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">

<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	
<BUTTON class="btn_2" name="btnSave" value="计算"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">计算</button>
<!-- 
<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>
 -->
    	
<!--  	
    	<a href="" class="fontcolor" type="submit" name="btnSave"><img align="absmiddle" src="../../images/save.gif" border="0" alt="保存"> 保存</a>
    	<a href="" class="fontcolor" type="reset"><img align="absmiddle" src="../../images/hg.gif" border="0" alt="重置"> 重置</a>
    	
    	<input class="btn" name="btnSave" value="保存" type="submit">
    	<input class="btn" name="btnReset" value="重置" type="reset">
    	-->
    </td></tr>
</table>
<!--操作按钮结束-->
</td>
</tr>
<!--  
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">新 增</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
-->
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">

<div id="TD_tab_0">
<input type="hidden" name="savetype" value="add">
<input type="hidden" name="contract_id" value="<%= contract_id %>">
<input type="hidden" name="process_mode" value="<%= type %>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
<%
	if(type.equals("1")){
 %>
  <tr>
    <td>处理方式</td>
    <td><%=type_name %></td>

    <td>资产所有权</td>
    <td><select name="asset_ownership" require="ture"></select>
    <script language="javascript">dict_list("asset_ownership","asset_ownership","<%=asset_ownership%>","name");</script>
	<span class="biTian">*</span></td>
    
  </tr>
  <tr>
    <td>约定解约日</td>
    <td><input name="appoint_date" accesskey="s" type="text" size="10" readonly value="<%=appoint_date%>"><img src="../../images/tbtn_overtime.gif" widtd="20" height="19" border="0" align="absmiddle" style="cursor:pointer; "  onClick="openCalendar(appoint_date);return false"><span class="biTian">*</span></td>

    <td>违约金基准</td>
    <td><select name="default_standard" require="ture"><script>w(mSetOpt("<%=default_standard%>",'应回收租金|应回收本金','1|2'));</script></select>
	<span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>违约手续费率</td>
    <td><input name="default_rate" type="text" size="10" value="<%=default_rate%>" require="ture">%<span class="biTian">*</span></td>

    <td>解约原因类型</td>
    <td><select name="reason" require="ture"></select>
    <script language="javascript">dict_list("reason","termination_reason","<%=reason%>","name");</script>
	<span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>备注</td>
    <td colspan="3"><textarea name="memo" rows="3" maxB="800" require="false"><%=memo%></textarea></td>
  </tr>
  <%}else  if(type.equals("2")){
 %>
  <tr>
    <td>处理方式</td>
    <td colspan="3"><%=type_name %></td>
  </tr>
  <tr>
    <td>回购期</td>
    <td><input name="appoint_date" accesskey="s" type="text" size="10" readonly value="<%=appoint_date%>" require="ture"><img src="../../images/tbtn_overtime.gif" widtd="20" height="19" border="0" align="absmiddle" style="cursor:pointer; "  onClick="openCalendar(appoint_date);return false"><span class="biTian">*</span></td>

    <td>违约金基准</td>
    <td><select name="default_standard" require="ture"><script>w(mSetOpt("<%=default_standard%>",'应回收租金|应回收本金','1|2'));</script></select>
	<span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>提前还款手续费率</td>
    <td><input name="default_rate" type="text" size="10" value="<%=default_rate%>" require="ture">%<span class="biTian">*</span></td>

    <td>提前还款原因</td>
    <td><select name="reason" require="ture"></select>
    <script language="javascript">dict_list("reason","ahead_reason","<%=reason%>","name");</script>
	<span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>备注</td>
    <td colspan="3"><textarea name="memo" rows="3" maxB="800" require="false"><%=memo%></textarea></td>
  </tr>
  <%}else{
 %>
  <tr>
    <td>处理方式</td>
    <td><%=type_name %></td>

    <td>回购人</td>
    <td><input name="back_buyer_name" type="text" size="40"  Require="true" readonly value="<%=back_buyer_name%>"><input type="hidden" name="back_buyer" value="<%=back_buyer%>"> <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="OpenDataWindow('','','','','回购人','vi_cust_all_info','cust_name','cust_id','cust_name','cust_name','asc','form1.back_buyer_name','form1.back_buyer');">
	<span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>回购期</td>
    <td><input name="appoint_date" accesskey="s" type="text" size="10" readonly value="<%=appoint_date%>" require="ture"><img src="../../images/tbtn_overtime.gif" widtd="20" height="19" border="0" align="absmiddle" style="cursor:pointer; "  onClick="openCalendar(appoint_date);return false"><span class="biTian">*</span></td>

    <td>违约金基准</td>
    <td><select name="default_standard" require="ture"><script>w(mSetOpt("<%=default_standard%>",'应回收租金|应回收本金','1|2'));</script></select>
	<span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>回购手续费率</td>
    <td><input name="default_rate" type="text" size="10" value="<%=default_rate%>" require="ture">%<span class="biTian">*</span></td>

    <td>回购原因</td>
    <td><select name="reason" require="ture"></select>
    <script language="javascript">dict_list("reason","back_reason","<%=reason%>","name");</script>
	<span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>备注</td>
    <td colspan="3"><textarea name="memo" rows="3" maxB="800" require="false"><%=memo%></textarea></td>
  </tr>
  <%} %>
  
</table>
<table border="0" cellspacing="0" cellpadding="0" width="100%" align="center">
<tr bgcolor="#8DB2E3"><td>费用处理</td></tr>
<tr>
<td><iframe frameborder="0" width="100%" height="300px" src="./noNormalEndFeeHl.jsp?contract_id=<%=contract_id%>&type=<%=type%>"></iframe></td>
</tr>
</table>
</div>

<div id="TD_tab_1" style="display:none;">

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
