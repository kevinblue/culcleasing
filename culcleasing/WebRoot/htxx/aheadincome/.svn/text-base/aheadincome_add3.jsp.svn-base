<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同后期管理 - 提前还款</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT Language="Javascript" SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT Language="Javascript" SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>

</head>
<body onload="public_onload(0);">
<form name="form1" method="post" target="_blank" action="aheadincome_save3.jsp" onSubmit="return Validator.Validate(this,3);">
<style type="text/css">
body {overflow:hidden;}
</style>
<div id=bgDiv>
	
<%
	String sqlstr;
	ResultSet rs;
	String contract_id = getStr( request.getParameter("contract_id") );
	String doc_id = getStr( request.getParameter("doc_id") );
	
	String agree_amt="";
	String difference_amt="";
	String difference_memo="";
	
	sqlstr="select contract_ahead_repayment.agree_amt, contract_ahead_repayment.difference_amt, contract_ahead_repayment.difference_memo from contract_ahead_repayment where contract_ahead_repayment.doc_id='"+doc_id+"'";
	//System.out.println("sqlstr==========================================="+sqlstr);
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		agree_amt=getDBDecStr(rs.getBigDecimal("agree_amt",2)).toString();
		difference_amt=getDBDecStr(rs.getBigDecimal("difference_amt",2)).toString();
		difference_memo=getDBStr( rs.getString("difference_memo"));
		
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
<!-- 
<BUTTON class="btn_2" name="btnSave" value="计算"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">计算</button>

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
<input type="hidden" name="doc_id" value="<%= doc_id %>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
	
  <tr>
    <td>协议留购价</td>
    <td><input name="agree_amt" type="text" size="20" value="<%=agree_amt%>"></td>
    <td>金额差异</td>
    <td><input name="difference_amt" type="text" size="20" value="<%=difference_amt%>" readonly><BUTTON class="btn_2" name="btnSave" value="计算"  type="submit" >
	<img src="../../images/save.gif" align="absmiddle" border="0">计算</button></td>
  </tr>
  <tr>
    <td>差异说明</td>
    <td colspan="3"><textarea name="difference_memo" rows="4" maxB="1000"><%=difference_memo%></textarea></td>
  </tr>
  
</table>
<!-- 
<table border="0" cellspacing="0" cellpadding="0" width="100%" align="center">
<tr bgcolor="#8DB2E3"><td>费用处理</td></tr>
<tr>
<td><iframe frameborder="0" width="100%" height="500px" src="./aheadincomeHl.jsp?contract_id=<%=contract_id%>"></iframe></td>
</tr>
</table>
-->
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
