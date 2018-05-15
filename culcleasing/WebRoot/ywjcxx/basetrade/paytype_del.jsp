<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>支付方式信息 - 删除</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
String id = getStr( request.getParameter("czid") );
sqlstr = "select base_paytype.*,base_user.name from dbo.base_paytype left join base_user on base_paytype.creator=base_user.id where base_paytype.id='" + id+"'"; 
rs = db.executeQuery(sqlstr); 

String pay_type_code = "";
String pay_type_name = "";
String gxrq = "";
String xm = "";

if ( rs.next() ) {
	pay_type_code = getDBStr( rs.getString("pay_type_code") );
	pay_type_name = getDBStr( rs.getString("pay_type_name") );
	gxrq = getDBDateStr( rs.getString("create_date") );
	xm = getDBStr( rs.getString("name") );
}

rs.close();
db.close();

//权限判断
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("ywjcxx_paytype_del",dqczy)>0) 
{
	canedit=1;
}
if (canedit==0) {
	response.sendRedirect("../../noright.jsp");
}
%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<form name="form1" method="post" action="paytype_save.jsp">
<input type="hidden" name="savetype" value="del">
<input type="hidden" name="id" value="<%= id %>">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">基础信息管理 &gt; 支付方式删除</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">
<!-- end cwCellTop -->

<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td height="30" scope="row">支付方式代码</td>
    <td width="84%" height="30" class="cwDDValue"><%=pay_type_code %></td>
  </tr>
  <tr>
    <td height="30" scope="row">支付方式名称</td>
    <td height="30" class="cwDDValue"><%=pay_type_name %></td>
  </tr>
  <tr>
    <td height="30" scope="row">最后更新日期</td>
    <td height="30" class="cwDDValue"><%= gxrq %></td>
  </tr>
  <tr>
    <td height="30" scope="row">操作员</td>
    <td height="30" class="cwDDValue"><%= xm %></td>
  </tr>
</table>
<!-- end cwDataNav -->
</div>
<!-- end cwCellContent -->

<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btndel" value="删除" type="submit" onClick="return(confirm('确定删除吗?'))" class="btn3_mouseout"></td>
<td>
<input name="btnClose" value="取消" type="button" onClick="window.close()" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
<!-- end cwToolbar -->
</div>
</form>
<!-- end cwMain -->
</body>
</html>
  
