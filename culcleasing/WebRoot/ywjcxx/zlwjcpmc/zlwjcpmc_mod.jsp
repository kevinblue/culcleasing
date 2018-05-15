

<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>修改租赁物件产品名称 - 基础信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1" method="post" action="zlwjcpmc_save.jsp" onSubmit="return Validator.Validate(this,3);">

<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt"  >基础信息管理</td>
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
        <td id="cwCellTopTitTxt">修改租赁物件产品名称</td>
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
String czid;
ResultSet rs;
czid=getStr(request.getParameter("czid"));
sqlstr = "select jb_zlwjlb.lxmc as zlmc, jb_zlwjlx.*,v_yhxx.xm from v_yhxx right outer join jb_zlwjlx on v_yhxx.id = jb_zlwjlx.czy left outer join jb_zlwjlb on jb_zlwjlx.zlid = jb_zlwjlb.id where jb_zlwjlx.id='"+czid+"'"; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{ 
%>
<input type="hidden" name="savetype" value="mod"><input type="hidden" name="kid" value="<%=rs.getString("id")%>">
<table class="cwDataInput"  border="0" cellspacing="5" cellpadding="2">
  <tr>
    <th width="109" scope="row">所属总类</th>
    <td width="246">
<input type="text" name="zliddata" readonly label="" dataType="" Require="true" value="<%=getDBStr(rs.getString("zlmc"))%>"><input type="hidden" name="zlid" value="<%=getDBStr(rs.getString("zlid"))%>"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="popUpWindow('zlsel.jsp',250,350);"> <span class="biTian">*</span>

</td>
  </tr>
  <tr>
    <th width="109" scope="row">租赁物件产品名称代码</th>
    <td width="246">
      <input name="id" type="text" size="30" maxlength="10" label="" dataType="" Require="true" value="<%=getDBStr(rs.getString("id"))%>"> <span class="biTian">*</span>
</td>
  </tr>
 <tr>
    <th width="109" scope="row">租赁物件产品名称</th>
    <td width="246">
      <input name="lxmc" type="text" size="30" maxlength="50" label="" dataType="" Require="true"  value="<%=getDBStr(rs.getString("lxmc"))%>"> 
      <span class="biTian">*</span>
</td>
  </tr>
  <tr>
    <th scope="row">最后更新日期</th>
    <td><%=getDBStr(rs.getString("gxrq"))%></td>
  </tr>
  <tr>
    <th scope="row"> 操作员</th>
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
   out.print("</center>该条记录不存在!</center>");
}
rs.close(); 
db.close();
%>
</div>
<!-- end cwMain -->
</body>
</html>
