<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>修改资料类别小类 - 基础信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>
<%
String czid;
czid=getStr(request.getParameter("czid"));
%>



<body>

<div id="cwMain" >
<form name="form1" method="post" action="zllbxl_save.jsp"  onSubmit="return Validator.Validate(this,3);">


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt">基础信息管理</td>
      <td id="cwTopTitRight"></td>
    </tr>
</table>  
</div>
<!-- end cwTop -->



<div id="cwCell">





<div id="cwCellTop">

	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">修改资料类别小类</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>
	
<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
        <td>&nbsp;</td>
      </tr>
</table>
	
</div>
<!-- end cwCellTop -->




<div id="cwCellContent">


<%
String sqlstr;
ResultSet rs;
sqlstr = "SELECT jb_zlxl.*,jb_zldl.lbdlmc,V_yhxx.xm FROM jb_zldl RIGHT OUTER JOIN jb_zlxl ON jb_zldl.id = jb_zlxl.ssdl LEFT OUTER JOIN V_yhxx ON jb_zlxl.czy = V_yhxx.id where jb_zlxl.id='"+czid+"'"; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{ 
%>
<input type="hidden" name="savetype" value="mod"><input type="hidden" name="kid" value="<%=rs.getString("id")%>">

<table class="cwDataInput"  border="0" cellspacing="5" cellpadding="2">
  <tr>
    <th width="112" scope="row">资料类别小类代码</th>
    <td width="304">
      <input name="id" type="text" value="<%=getDBStr(rs.getString("id"))%>" size="10" maxlength="10"  label="" dataType="" Require="true"> <span class="biTian">*</span>
</td>
    <tr>
    <th scope="row">资料类别小类名称</th>
    <td><input name="lbxlmc" type="text" value="<%=getDBStr(rs.getString("lbxlmc"))%>" size="40" maxlength="40" label=""  dataType="" Require="true"> <span class="biTian">*</span></td>
  </tr>
  <tr>
    <th scope="row">所属大类</th>
    <td>
<input type="text" name="ssdldata" readonly label="" dataType="" Require="true" value="<%=getDBStr(rs.getString("lbdlmc"))%>"><input type="hidden" name="ssdl" value="<%=getDBStr(rs.getString("ssdl"))%>"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="SimpleDataWindow('','','kh_lbdl','lbdlmc','id','','','id','form1.ssdldata','form1.ssdl');"> <span class="biTian">*</span>


	</td>
  </tr>
  <tr>
    <th scope="row">最后更新日期</th>
    <td><%=getDBDateStr(rs.getString("gxrq"))%></td>
  </tr>
  <tr>
    <th scope="row">操作员</th>
    <td><%=getDBStr(rs.getString("xm"))%></td>
  </tr>
</table>


<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->





<div id="cwToolbar" >
<input class="btn" name="submit" value="保存" type="submit">
<input class="btn" name="btnClose" value="取消" type="button" onClick="cfClose()"><input class="btn" name="btnOk" value="重置" type="reset">
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


