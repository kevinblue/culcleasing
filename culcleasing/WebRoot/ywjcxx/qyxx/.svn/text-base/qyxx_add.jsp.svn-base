<%@ page contentType="text/html; charset=gbk" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>新增地区信息 - 基础信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>
<%

String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("ywjcxx_dqxx_add",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");

%>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">基础信息管理 &gt; 新增地区信息</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">
<form name="form1" method="post" action="qyxx_save.jsp" onSubmit="return Validator.Validate(this,3);">


<input type="hidden" name="savetype" value="add">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
  	<td width="20%" height="30">所属国家</td>
    <td height="30">
    	<input type="text" name="gjmc" readonly Require="true">
    <input type="hidden" name="gjid">
    <img src="../../images/sbtn_more.gif" alt="选国家" width="19" height="19" align="absmiddle" style="cursor:pointer" onClick="OpenDataWindow('','','','','国家','jb_gjxx','gjmc','id','gjmc','gjmc','asc','form1.gjmc','form1.gjid');">
    <span class="biTian">*</span>
    </td>
  </tr>
  <tr>
    <td height="30" scope="row">地区代码</td>
    <td height="30" scope="row">
      <input name="qyid" type="text" size="3" maxlength="3" Require="ture"><span class="biTian">*</span>
	</td>
  </tr>
  <tr>
    <td height="30" scope="row">地区名称</td>
    <td height="30" scope="row" ><input name="qymc" type="text"  Require="ture"><span class="biTian">*</span></td>
  </tr>
</table>

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
</div>
<!-- end cwMain -->
</body>
</html>

