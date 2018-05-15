<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>修改保险公司 - 基础信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->


<%
String code = getStr( request.getParameter("czid") );
sqlstr = "select insurer_info.*,base_user.name from dbo.insurer_info left join base_user on insurer_info.creator=base_user.id where insurer_info.insurer_code='" + code+"'"; 
rs = db.executeQuery(sqlstr); 

String insurer_code = "";
String insurer_name = "";
String simple_name = "";
String modify_date = "";
String name = "";

if ( rs.next() ) {
	insurer_code = getDBStr( rs.getString("insurer_code") );
	insurer_name = getDBStr( rs.getString("insurer_name") );
	simple_name = getDBStr( rs.getString("simple_name") );
	modify_date = getDBDateStr( rs.getString("modify_date") );
	name = getDBStr( rs.getString("name") );
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

<form name="form1"  method="post" action="insurer_save.jsp" onSubmit="return Validator.Validate(this,3);">
<!-- end cwCellTop -->


<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="kid" value="<%=insurer_code %>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
 
  <tr>
    <td scope="row">保险公司名称</td>
    <td><input name="insurer_name" type="text"  value="<%=insurer_name %>" Require="ture"><span class="biTian">*</span></td>
  </tr>
   <tr>
    <td scope="row">保险公司简称</td>
    <td scope="row"><input name="simple_name" type="text" value="<%=simple_name %>" Require="ture"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td scope="row">最后更新日期</td>
    <td><%= modify_date %></td>
  </tr>
  <tr>
    <td scope="row"> 操作员</td>
    <td><%=name %></td>
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


