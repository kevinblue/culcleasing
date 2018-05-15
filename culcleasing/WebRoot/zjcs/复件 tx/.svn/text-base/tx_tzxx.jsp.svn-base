<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>调息 - 添加调息信息</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>
<%
	String contract_id = (String) request.getParameter("contract_id");
	String lease_money = "";
	String fund_id = (String )request.getParameter("fund_id");
	String volume = (String )request.getParameter("volume");
	String sql = "";
	if(fund_id!=null&&!fund_id.equals("")){
		sql = "select sum(corpus) as sum_corpus from fund_rent_plan where contract_id='"+contract_id+"' and id>="+fund_id;
		System.out.println(sql);
		ResultSet rssum = db.executeQuery(sql);
		if(rssum.next()){
			lease_money = getDBStr(rssum.getString("sum_corpus"));
		}
	}
 %>
<body>
<form name="form1" method="post" action="tx_save.jsp" onSubmit="return Validator.Validate(this,3);">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
调息 &gt; 添加调息信息
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	
<BUTTON class="btn_2" name="btnSave" value="保存"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">保存</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>
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
</table>
<!-- end cwTop -->
<!-- end cwCellTop -->
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<input type="hidden" name="savetype" value="tx">
<input type="hidden" name="contract_id" value="<%=contract_id %>">
<input type="hidden" name="lease_money" value="<%=lease_money %>">
<input type="hidden" name="fund_id" value="<%=fund_id %>">
<input type="hidden" name="volume" value="<%=volume %>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <th scope="row">利率调整</th>
    <td><select name="adjust_type"  Require="true"><script>w(mSetOpt('0',"提高|降低","0|1"));</script></select><span class="biTian">*</span>
	</td>

    <th>调整方式</th>
    <td><select name="adjust_style"  Require="true"><script>w(mSetOpt('0',"按基准利率|按百份比","0|1"));</script></select><span class="biTian">*</span></td>
  </tr>
  <tr>
   	<th>调息日期</th>
    <td><input type="text" name="rate_date" Require="true"dataType="Date"> <img  onClick="openCalendar(rate_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span></td>
    <th scope="row">调整开始期项</th>
    <td><%=volume %>
	</td>
  </tr>
</table>
</div>
</div></td></tr></table>
</form>
</body>
</html>
<%db.close();%>
