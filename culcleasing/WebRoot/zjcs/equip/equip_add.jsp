<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租凭物件管理-租凭物件信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>
</head>

<%
	String contract_id = getStr( request.getParameter("czid") );
	System.out.println("contract_id========="+contract_id);
%>
<body onLoad="public_onload();fun_winMax();">
<form name="form1" method="post" action="equip_save.jsp" onSubmit="return Validator.Validate(this,3);">
<table  class="title_top" width=100% height=100% align="center" cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
租凭物件管理 &gt; 新增租凭物件信息
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
<div id="mydiv" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="add">
<input type="hidden" name="contract_id" value="<%=contract_id %>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
 <tr>
    <td nowrap>资产名称/型号</td>
    <td nowrap><input class="text" name="eqip_name" type="text" maxlength="50" size="3" maxB="50" Require="ture" ></td>
  
    <td nowrap>数量(台)</td>
    <td nowrap><input class="text" name="equip_num" type="text" size="50"  maxlength="50" dataType="Integer" maxB="40" Require="ture" ></td>
  </tr>
  

  <tr>
    <td nowrap>设备单价(元)</td>
    <td nowrap><input class="text" name="equip_price" type="text"  maxlength="50" dataType="Money" maxB="50" Require="ture" ></td>
  
    <td nowrap>设备总额(元)</td>
    <td nowrap><input class="text" name="total_price" type="text"  maxlength="40"  dataType="Money" maxB="40" Require="ture" ></td>
  </tr>
  <tr>
  <td nowrap>供应商</td>
    <td nowrap><input class="text" name="distributor" type="text"  maxlength="40" maxB="40" ></td>
    <td nowrap>租期(月)</td>
    <td nowrap><input class="text" name="equip_team" type="text"  maxlength="40" dataType="Integer"  maxB="40" Require="ture" ></td>
  </tr>
  <tr>
    <td nowrap>每期租金(元)</td>
    <td nowrap><input class="text" name="equip_rent" type="text"  maxlength="100"  dataType="Money" maxB="100" Require="ture" ></td>
  
    <td nowrap>产品类别</td>
    <td nowrap><input class="text" name="equip_type" type="text"  maxlength="100" maxB="100" ></td>
 </tr>
 <tr>
 <td nowrap>配置</td>
    <td nowrap><input class="text" name="equip_dispose" type="text"  maxlength="100" maxB="100" ></td>
    <td nowrap></td>
    <td nowrap></td>
  </tr>
  
  
  <tr>
    <td nowrap>备注</td>
    <td><textarea class="text" name="memo" maxB="500" rows="6"></textarea></td>
  

    <td ></td>
  </tr>

</table>

</form>


</body>
</html>
