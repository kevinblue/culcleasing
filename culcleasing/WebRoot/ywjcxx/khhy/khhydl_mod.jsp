<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>修改客户行业大类 - 客户信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">客户信息管理 &gt; 修改客户行业大类</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1"  method="post" action="khhydl_save.jsp" onSubmit="return Validator.Validate(this,3);">

<%
String sqlstr;
String czid;
ResultSet rs;
czid=getStr(request.getParameter("czid"));
sqlstr = "select kh_hydl_gb.*,kh_hyml_gb.hymlbh,kh_hyml_gb.hymlmc,base_user.name from kh_hydl_gb left join kh_hyml_gb on kh_hydl_gb.hymlbh=kh_hyml_gb.hymlbh left join base_user on kh_hydl_gb.czy=base_user.id where kh_hydl_gb.hydlbh='"+czid+"'"; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{ 
%>
<input type="hidden" name="savetype" value="mod"><input type="hidden" name="kid" value="<%=getDBStr(rs.getString("hydlbh"))%>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td width="16%" height="30" scope="row">客户行业大类代码</td>
    <td height="30" >
      <input name="hydldm" type="text" size="2" maxlength="2"  label=""  Require="true" value="<%=getDBStr(rs.getString("hydlbh"))%>"> <span class="biTian">*</span>
</td>
  </tr>
  <tr>
    <td height="30" scope="row">客户行业大类名称</td>
    <td height="30"><input name="hydlmc" type="text"  label=""  Require="true" value="<%=getDBStr(rs.getString("hydlmc"))%>"> <span class="biTian">*</span></td>
  </tr>
   <tr>
    <td height="30" scope="row">所属客户行业门类代码</td>
    <td height="30">
    <input type="text" name="hymlmc" readonly Require="true" value="<%=getDBStr(rs.getString("hymlmc"))%>">
    <input type="hidden" name="hymlbh" value="<%=getDBStr(rs.getString("hymlbh"))%>">
    <img src="../../images/sbtn_more.gif" alt="选门类" width="19" height="19" align="absmiddle" style="cursor:pointer" onClick="OpenDataWindow('','','','','门类','kh_hyml_gb','hymlmc','hymlbh','hymlmc','hymlbh','asc','form1.hymlmc','form1.hymlbh');"><span class="biTian">*</span>
    </td>
  </tr>
   <tr>
    <td height="30" scope="row">最后更新日期</td>
    <td height="30"><%=getDBDateStr(rs.getString("gxrq"))%></td>
  </tr>
  <tr>
    <td height="30" scope="row"> 操作员</td>
    <td height="30"><%=getDBStr(rs.getString("name"))%></td>
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
   out.print("</center>该条记录不存在!</center>");
}
rs.close(); 
db.close();
%>
</div>
<!-- end cwMain -->
</body>
</html>


