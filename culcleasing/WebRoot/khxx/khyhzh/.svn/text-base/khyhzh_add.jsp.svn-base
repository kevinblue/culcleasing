<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>新增银行账号信息 - 客户信息管理</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>



<body>


<form name="form1" method="post" action="khyhzh_save.jsp" onSubmit="return Validator.Validate(this,3);">

<table  class="title_top" width=100% height=100% align="center" cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
客户信息管理 &gt; 新增银行账号信息
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">新 增</td>
  
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

<%
	String cust_id = getStr( request.getParameter("cust_id") );
	String cust_name = "";
	ResultSet rs;
	String sqlstr = "select cust_name from vi_cust_all_info where cust_id='" + cust_id + "'"; 

	rs = db.executeQuery(sqlstr); 
	if (rs.next()){
		cust_name = getDBStr( rs.getString("cust_name") );
	}
	rs.close();
	db.close();
%>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="add">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td scope="row" nowrap>客户编号：</td>
    <td><input name="cust_id"  value="<%= cust_id %>" readonly><input name="cust_id" type="hidden" value="<%= cust_id %>">
	</td>

    <td scope="row" nowrap>银行帐号：</td>
    <td><input name="acc_number" type="text"  maxlength="40" maxB="40"  dataType="Number"></td>
  </tr>
  <tr>
	<td scope="row" nowrap>开户银行：</td>
	<td><input name="bank_name" type="text"  maxlength="50" maxB="50" ></td>
  <td scope="row" nowrap>开户银行地址：</td>
	<td><input name="bank_addr" type="text"  maxlength="50" maxB="50" ></td>
    
  </tr>
  <tr>
  <td scope="row" nowrap>银行帐户名称：</td>
    <td><input name="account" type="text"  maxlength="50" maxB="50"></td>
    <td scope="row" nowrap>帐户使用情况：</td>
  
    <td scope="row" nowrap>
													<input name="acc_status" type="radio" value="否" checked="checked">
													否
													<input name="acc_status" type="radio" value="是">
													是
													
   </td>
  
    <td></td>
    <td></td>
  </tr>
  

</table>


</div>
</div>
</td></tr></table>
    </form>


</body>
</html>
