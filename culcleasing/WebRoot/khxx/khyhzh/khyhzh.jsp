<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>银行账号详细信息 - 客户信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>

<%
	String id = getStr( request.getParameter("czid") );
	String cust_name = "";
	String cust_id = "";
	String acc_number = "";
	String bank_name = "";
	String account = "";
	String acc_status = "";
	String bank_addr="";
	String em_type = "";
	String memo = "";
	
	String creator = "";
	String create_date  = "";
	String modificator = "";
	String modify_date = "";
	
	ResultSet rs;
	String sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator) from vi_cust_account_n where id='" + id + "'"; 

	rs = db.executeQuery(sqlstr); 
	if (rs.next()){
	    bank_addr=getDBStr(rs.getString("bank_addr"));
		cust_id = getDBStr( rs.getString("cust_id") );
		acc_number = getDBStr( rs.getString("acc_number") );
		bank_name = getDBStr( rs.getString("bank_name") );
		account = getDBStr( rs.getString("account") );
		acc_status = getDBStr( rs.getString("acc_status") );
		em_type = getDBStr( rs.getString("em_type") );
		memo = getDBStr( rs.getString("memo") );
		creator = getDBStr( rs.getString("dengjiren") );
		create_date = getDBDateStr( rs.getString("create_date") );
		modificator = getDBStr( rs.getString("xiugairen") );
		modify_date = getDBDateStr( rs.getString("modify_date") );
	}
	rs.close();
	sqlstr="select cust_name from vi_cust_all_info where cust_id='"+cust_id+"'";
	rs = db.executeQuery(sqlstr); 
	if (rs.next()){
		cust_name = getDBStr( rs.getString("cust_name") );
	}
	rs.close();
	db.close();
%>
<body>
<form name="form1" method="post" action="khyhzh_save.jsp" onSubmit="return Validator.Validate(this,3);">
<table  class="title_top" width=100% height=100% align="center" cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
客户信息管理 &gt; 银行账号详细信息
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
<a href="khyhzh_mod.jsp?czid=<%= id %>"  accesskey="m" title="修改(Alt+M)" class="fontcolor">
	<!-- 	<img src="../../images/btn_edit.gif" width="19" height="19" align="absmiddle" >修改</a> -->
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
<img src="../../images/btn_close.gif" align="absmiddle" border="0">关闭</button>
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">详细信息</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table>
   <script language="javascript">
ShowTabN(0);
</script> 
 </td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<!-- end cwTop -->

<!-- end cwCellTop -->
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<input type="hidden" name="savetype" value="del">
<input type="hidden" name="czid" value="<%=id %>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td scope="row" nowrap width="20%">客户编号：</td>
    <td><%= cust_id %>
	</td>

    <td scope="row" nowrap width="20%">银行帐号：</td>
    <td><%=acc_number %></td>
  </tr>
  <tr>
	<td scope="row" nowrap width="20%">开户银行：</td>
	<td><%=bank_name %></td>
  
    <td scope="row" nowrap width="20%">帐户名称：</td>
    <td><%=account %></td>
  </tr>
  <tr>
  
    <td scope="row" nowrap width="20%">开户银行地址：</td>
    <td><%=bank_addr %></td>
    <td scope="row" nowrap width="20%">帐户使用情况：</td>
    <td><%=acc_status %></td>
  
    <td></td>
  </tr>
    <tr>
	<td scope="row" nowrap width="20%">帐户类型：</td>
	<td><%=em_type %></td>
  
    <td scope="row" nowrap width="20%">备注：</td>
    <td><%=memo %></td>
  </tr>
  
</table></div></div></td></tr></table>
    </form>
</body>
</html>
