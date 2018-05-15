<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 09.01.05 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>费用类型分类</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
</head>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">基础信息管理 &gt; 修改费用类型分类</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1"  method="post" action="fylx_save.jsp" onSubmit="return Validator.Validate(this,3);">
<!-- end cwCellTop -->

<%
String sqlstr;
String czid;
String feetype_number;
String feetype_name;
String finance_code;
String paytype;

ResultSet rs;
czid=getStr(request.getParameter("czid"));
sqlstr = " SELECT * FROM base_feetype where feetype_number='"+czid+"' ";  
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{
	feetype_number=getDBStr(rs.getString("feetype_number"));
	feetype_name=getDBStr(rs.getString("feetype_name"));
	finance_code=getDBStr(rs.getString("finance_code"));
	paytype=getDBStr(rs.getString("paytype"));
	
%>
<input type="hidden" name="savetype" value="mod"><input type="hidden" name="id" value="<%=rs.getString("feetype_number")%>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">

  <tr>
    <td  width="16%" class="cwDDLabel">费用类型编码</td>
    <td width="84%" class="cwDDValue"><input name="feetype_number" readonly type="text" value="<%=getDBStr(rs.getString("feetype_number"))%>"  label="费用类型编码" Require="true"><span class="biTian">*</span></td>
  </tr>

  <tr>
    <td scope="row">费用类型</td>
    <td><input name="feetype_name" type="text" value="<%=getDBStr(rs.getString("feetype_name"))%>"  label="费用类型" Require="true"><span class="biTian">*</span></td>
  </tr>
  
  <tr>
    <td scope="row">对应财务代码</td>
    <td><input name="finance_code" type="text" value="<%=getDBStr(rs.getString("finance_code"))%>"  label="费用类型" Require="true"><span class="biTian">*</span></td>
  </tr>
  
  <tr>
    <td scope="row">款项方式</td>
    <td>
     <select name="paytype" Require="ture">
        <script type="text/javascript">
	        w(mSetOpt('<%=paytype %>',"|收款|付款","|收款|付款"));
        </script>
     </select>
     <span class="biTian">*</span></td>
  </tr>
  
</table>
<!-- end cwDataNav -->
</div>
<!-- end cwCellContent -->
<!-- end cwCell -->
<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="保存" type="submit" class="btn3_mouseout"></td>
<td width=8 width="12">
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