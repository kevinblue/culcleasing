<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>修改客户类别小类 - 客户信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>
<%
String czid;
czid=getStr(request.getParameter("czid"));
%>



<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">客户信息管理 &gt; 修改客户类别小类</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1"  method="post" action="khlbxl_save.jsp" onSubmit="return Validator.Validate(this,3);">



<%
String sqlstr;
ResultSet rs;
sqlstr = "select kh_lbxl.*,kh_lbdl.lbdlmc,base_user.name from kh_lbxl left join kh_lbdl on kh_lbxl.ssdl=kh_lbdl.id left join base_user on kh_lbxl.czy=base_user.id where kh_lbxl.id='"+czid+"'"; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{ 
%>
<input type="hidden" name="savetype" value="mod"><input type="hidden" name="kid" value="<%=rs.getString("id")%>">

<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td width="16%" scope="row">客户类别小类代码</td>
    <td >
      <input name="id" type="text" value="<%=getDBStr(rs.getString("id"))%>" size="10" maxlength="10"  label="" dataType="" Require="true"> <span class="biTian">*</span>
</td>
    <tr>
    <td scope="row">客户类别小类名称</td>
    <td><input name="lbxlmc" type="text" value="<%=getDBStr(rs.getString("lbxlmc"))%>"  label=""  dataType="" Require="true"> <span class="biTian">*</span></td>
  </tr>
  <tr>
    <td scope="row">所属行业大类</td>
    <td>
 <input type="text" name="ssdldata" readonly Require="true" value="<%=getDBStr(rs.getString("lbdlmc"))%>">
    <input type="hidden" name="ssdl" value="<%=getDBStr(rs.getString("ssdl"))%>">
    <img src="../../images/sbtn_more.gif" alt="选行业大类" width="19" height="19" align="absmiddle" style="cursor:pointer" onClick="OpenDataWindow('','','','','行业大类','kh_lbdl','lbdlmc','id','lbdlmc','lbdlmc','asc','form1.ssdldata','form1.ssdl');">
    <span class="biTian">*</span>

	</td>
  </tr>
  <tr>
    <td scope="row">最后更新日期</td>
    <td><%=getDBDateStr(rs.getString("gxrq"))%></td>
  </tr>
  <tr>
    <td scope="row">操作员</td>
    <td><%=getDBStr(rs.getString("name"))%></td>
  </tr>
</table>


<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
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


