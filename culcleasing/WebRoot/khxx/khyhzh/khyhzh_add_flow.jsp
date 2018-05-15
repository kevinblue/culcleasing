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


<form name="form1" method="post" action="khyhzh_save_flow.jsp" onSubmit="return Validator.Validate(this,3);">

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
	String contract_id = getStr( request.getParameter("contract_id") );
	String doc_id = getStr( request.getParameter("doc_id") );
	String cust_name = "";
	String cust_category = "";
	ResultSet rs;
	String sqlstr = "select cust_name,cust_category from vi_cust_all_info where cust_id='" + cust_id + "'"; 

	rs = db.executeQuery(sqlstr); 
	if (rs.next()){
		cust_name = getDBStr( rs.getString("cust_name") );
		cust_category = getDBStr( rs.getString("cust_category") );
	}
	rs.close();
	db.close();
%>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="add">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td scope="row" nowrap>客户名称：</td>
    <td><input name="cust_name" type="text" value="<%= cust_name %>"  Require="true"  readonly>
    <input name="cust_name_title" type="hidden"  onpropertychange="document.getElementById('acc_number').value=''"  readonly>
    <img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','客户名称','vi_select_cust_all_info_type','showtitle','cust_name|cust_id|cust_category','cust_name','cust_name','asc','form1.cust_name_title','form1.cust_name|form1.cust_id|form1.cust_category');">
	</td>

    <td scope="row" nowrap>客户类型：</td>
    <td><input name="cust_category" type="text"  maxlength="40" maxB="40" value="<%=cust_category %>"  readonly>
    </td>
  </tr>

  <tr>
    <td scope="row" nowrap>客户编号：</td>
    <td><input name="cust_id" type="text" value="<%= cust_id %>" readonly>
	</td>

    <td scope="row" nowrap>银行帐号：</td>
    <td><input name="acc_number" id="acc_number" type="text"  maxlength="40" maxB="40"  readonly>
    <input name="id" type="hidden">
    <input name="acc_showtitle" type="hidden">
    <input name="contract_id" type="hidden" value="<%=contract_id %>">
    <input name="doc_id" type="hidden"  value="<%=doc_id %>">
    <img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('form1.cust_id','客户编号','cust_id','String','银行帐户类型','vi_cust_account','showTitle','acc_number|id|bank_name|bank_addr|account|acc_status|em_type|memo','acc_number','acc_number','asc','form1.acc_showtitle','form1.acc_number|form1.id|form1.bank_name|form1.bank_addr|form1.account|form1.acc_status|form1.em_type|form1.memo');">
    </td>
  </tr>
  <tr>
	<td scope="row" nowrap>开户银行：</td>
	<td><input name="bank_name" type="text"  maxlength="50" maxB="50" readonly></td>
  <td scope="row" nowrap>开户银行地址：</td>
	<td><input name="bank_addr" type="text"  maxlength="50" maxB="50" readonly></td>
    
  </tr>
  <tr>
  <td scope="row" nowrap>银行帐户名称：</td>
    <td><input name="account" type="text"  maxlength="50" maxB="50" readonly></td>
    <td scope="row" nowrap>帐户使用情况：</td>
  
    <td scope="row" nowrap>
    <input name="acc_status" type="text" readonly>
													
   </td>
  </tr>
    <tr>
	<td scope="row" nowrap>银行帐户类型：</td>
	<td><input name="em_type" type="text"  maxlength="50" maxB="50" readonly></td>
	<td scope="row" nowrap></td>
	<td></td>
	<!-- 
  <td scope="row" nowrap>备注：</td>
	<td><input name="memo" type="text"  maxlength="50" maxB="50" readonly></td>
	 -->
    
  </tr>
	<tr>
		<td>
			备注：
		</td>
		<td scope="row" nowrap colspan="3">
			<textarea name="memo" rows="3" cols="50"></textarea>
		</td>
	</tr>
</table>


</div>
</div>
</td></tr></table>
    </form>


</body>
</html>
