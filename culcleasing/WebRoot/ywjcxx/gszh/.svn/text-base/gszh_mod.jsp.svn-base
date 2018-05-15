<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<!-- 09.01.05 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>修改公司银行账户 - 公司银行账户</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
</head>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">基础信息管理 &gt; 修改公司银行账户</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1"  method="post" action="gszh_save.jsp" onSubmit="return Validator.Validate(this,3);">
<!-- end cwCellTop -->
<%

String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  //dqczy="无认证";
  //response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("gszh_mod",dqczy)>0) canedit=1;
//if (canedit==0) response.sendRedirect("../../noright.jsp");

%>
<%
String sqlstr;
String czid;
String bank_name;
String acc_number;
String account;
String subject;
String modify_date;
String modificator;
String bank_money;
String subject_no;
String ncbank_code;
ResultSet rs;
czid=getStr(request.getParameter("czid"));
sqlstr = "select id, bank_name, isnull(bank_money,0.00) as bank_money, account, acc_number,subject_no, modificator, modify_date,ncbank_code from dbo.base_account where id='"+czid+"' ";  
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{
	bank_name=getDBStr(rs.getString("bank_name"));
	acc_number=getDBStr(rs.getString("acc_number"));
	account=getDBStr(rs.getString("account"));
	subject_no=getDBStr(rs.getString("subject_no"));
	modify_date=getDBStr(rs.getString("modify_date"));
	modificator=getDBStr(rs.getString("modificator"));
	bank_money=getMoneyStr(rs.getString("bank_money"));
	ncbank_code=getDBStr(rs.getString("ncbank_code"));
	
	
%> 
<input type="hidden" name="savetype" value="mod"><input type="hidden" name="kid" value="<%=rs.getString("id")%>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td width="79" height="30" scope="row">开户银行</td>
    <td height="30" ><input name="bank_name" type="text" value="<%=getDBStr(rs.getString("bank_name"))%>"  label="开户银行" Require="true"> <span class="biTian">*</span></td>
  </tr>
  <tr>
    <td height="30" scope="row">开户名</td>
    <td height="30"><input name="account" type="text" value="<%=getDBStr(rs.getString("account"))%>"  label="开户名" Require="true"> <span class="biTian">*</span></td>
  </tr>
  <tr>
    <td height="30" scope="row">银行帐号</td>
    <td height="30"><input name="acc_number" type="text"  value="<%=acc_number%>"  label="开户帐号" Require="true"> <span class="biTian">*</span></td>
  </tr>
   
    <tr>
    <td height="30" scope="row">财务编码</td>
    <td height="30"><input name="subject_no" type="text"  value="<%=subject_no%>"  label="财务编码" Require="true"> <span class="biTian">*</span></td>
  </tr>
  
  <tr>
    <td height="30" scope="row">NC编码</td>
    <td height="30"><input name="ncbank_code" type="text"  value="<%=ncbank_code%>"  label="NC编码" Require="true"> <span class="biTian">*</span></td>
  </tr>
  
  
  <tr>
    <td height="30" scope="row">最后更新日期</td>
    <td height="30"><%=getDBDateStr(rs.getString("modify_date"))%></td>
  </tr>
  <tr>
    <td height="30" scope="row"> 操作员</td>
    <td height="30"><%=modificator%></td>
  </tr>
</table>
<!-- end cwDataNav -->
</div>
<!-- end cwCellContent -->
</div>
<!-- end cwCell -->
<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="保存" type="submit" class="btn3_mouseout"></td>

<td>
<input name="btnClose" value="取消" type="button" onClick="window.close();" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
<!-- end cwToolbar -->
    </form>
    <%
}
else
{
%>
 <center>该条记录不存在!</center>
<div id="cwToolbar" >
<input class="btn" name="btnClose" value="关闭" type="button" onClick="window.close()">
</div>
<%
}
rs.close(); 
db.close();
%>
</div>
<!-- end cwMain -->
</body>
</html>