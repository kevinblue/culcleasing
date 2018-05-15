<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>修改内部行业 - 基础信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->


<%
String id = getStr( request.getParameter("czid") );
sqlstr = "select base_trade.*,base_user.name from dbo.base_trade left join base_user on base_trade.czy=base_user.id where base_trade.id='" + id+"'"; 
rs = db.executeQuery(sqlstr); 

String code = "";
String trade = "";
String gxrq = "";
String xm = "";

if ( rs.next() ) {
	code = getDBStr( rs.getString("code") );
	trade = getDBStr( rs.getString("trade") );
	gxrq = getDBDateStr( rs.getString("gxrq") );
	xm = getDBStr( rs.getString("name") );
}

rs.close();
db.close();
%>
<%--
//权限判断
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("ywjcxx_paytype_mod",dqczy)>0) 
{
	canedit=1;
}
if (canedit==0) {
	response.sendRedirect("../../noright.jsp");
}
--%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">基础信息管理 &gt; 修改内部行业信息</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1"  method="post" action="basetrade_save.jsp" onSubmit="return Validator.Validate(this,3);">
<!-- end cwCellTop -->


<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="kid" value="<%=id %>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td scope="row">内部行业代码</td>
    <td>
      <input name="code" type="text"   value="<%=code %>" Require="ture" readonly="readonly"><span class="biTian">*必须唯一</span>
	</td>
  </tr>
  <tr>
    <td scope="row">内部行业名称</td>
    <td><input name="trade" type="text"  value="<%=trade %>" Require="ture"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td scope="row">最后更新日期</td>
    <td><%= gxrq %></td>
  </tr>
  <tr>
    <td scope="row"> 操作员</td>
    <td><%= xm %></td>
  </tr>

</table>

<!-- end cwDataNav -->

<!-- end cwCellContent -->
</div>
<!-- end cwCell -->

<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="保存" type="submit" class="btn3_mouseout"></td>
<td>
<input name="btnReset" value="重置" type="reset" class="btn3_mouseout"></td>
<td>
<input name="btnClose" value="取消" type="button" onClick="window.close()" class="btn3_mouseout">
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


