<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>发票类型-修改</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js">
</script><script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>
<script src="../../js/delitem.js"></script>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
</head>

<%
	String id = getStr( request.getParameter("id") );

String sqlstr="select invoice_type,tax_type_invoice from contract_fund_fund_charge_plan where id ='" + id+"'";
System.out.println("aaaaaaaaaaaaaa"+sqlstr);
	
	
	ResultSet rs = db.executeQuery(sqlstr);
	if( rs.next() ){
	
	String invoice_type=  rs.getString("invoice_type");
	String tax_type_invoice=  rs.getString("tax_type_invoice");
	    
		
%>
<body  onload="public_onload();fun_winMax();" >
<form name="form1" method="post" action="fund_invoice_save.jsp" onSubmit="return Validator.Validate(this,3);">
<table  class="title_top" width=100% height=100% align="center" cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
发票类型
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td >
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">修 改</td>
  
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
<!-- end cwCellTop -->
<div id="mydiv" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="id" value="<%=id%>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">


    <tr>	
   <td nowrap>税种:</td>
    <td nowrap class="text"><select class="text" Require="true" name="invoice_type"><script>w(mSetOpt("<%=invoice_type%>","|增值税|营业税"));</script></select>
     <span class="biTian">*</span></td>
    </td>	      	
	<td nowrap>发票类型:</td>
    <td nowrap class="text"><select class="text" Require="true" name="tax_type_invoice"><script>w(mSetOpt("<%=tax_type_invoice%>","|增值税普通发票|增值税专用发票"));</script></select>
     <span class="biTian">*</span></td>
    </td>
 
 <tr>

</table>
	<%
	}
rs.close();
db.close();
%>

<!-- end cwDataNav -->
</div>
<!-- end cwCellContent -->
</div>
<!-- end cwToolbar -->
</td></tr></table>
</form>

<!-- end cwMain -->
</body>
</html>
