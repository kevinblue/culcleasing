<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>修改租赁物件供应商情况 - 租赁物件供应商情况</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1" method="post" action="zlwjgys_save.jsp" onSubmit="return chkForm(this);">

<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt"  >租赁物件供应商情况</td>
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
        <td id="cwCellTopTitTxt">修改租赁物件供应商情况</td>
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
String bz;
String czy;
String gxrq;
ResultSet rs;
czid=getStr(request.getParameter("czid"));
sqlstr = "SELECT jb_zlwjxx.wjmc, V_yhxx.xm, jb_zlwjgys.*,jb_bzxx.bz as bzmc, kh_mpxx.khmc FROM jb_zlwjgys LEFT OUTER JOIN kh_mpxx ON jb_zlwjgys.gysid = kh_mpxx.khbh LEFT OUTER JOIN jb_bzxx ON jb_zlwjgys.bz = jb_bzxx.id LEFT OUTER JOIN V_yhxx ON jb_zlwjgys.czy = V_yhxx.id LEFT OUTER JOIN jb_zlwjxx ON jb_zlwjgys.wjid = jb_zlwjxx.id where jb_zlwjgys.id='"+czid+"'"; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{ 
bz=rs.getString("bz");
czy=rs.getString("xm");
gxrq=rs.getString("gxrq");
%>
<input type="hidden" name="savetype" value="mod"><input type="hidden" name="kid" value="<%=rs.getString("id")%>">
<table class="cwDataInput"  border="0" cellspacing="5" cellpadding="2">
  <tr> 
    <th scope="row">租赁物件</th>
    <td><input name="wjid" type="text" size="20" maxlength="20" value="<%=rs.getString("wjmc")%>">
    </td>
  </tr>
  <tr> 
    <th scope="row">租赁物件供应商</th>
    <td><input name="gysid" type="text" size="20" maxlength="20" value="<%=rs.getString("khmc")%>">
    </td>
  </tr>
  <tr>
    <th scope="row">单价</th>
    <td><input name="dj" type="text" size="20" maxlength="20" label="单价" conttyp="double" value="<%=rs.getString("dj")%>"></td>
  </tr>
  <tr> 
    <th scope="row">币种</th>
    <td> 
	  <select name=bz>
<%
ResultSet rs2;
sqlstr = "select id,bz from jb_bzxx order by id"; 
rs2=db.executeQuery(sqlstr); 
while (rs2.next())
{
if (rs2.getString("id").equals(bz)){
%>    
    <option value="<%=rs2.getString("id")%>" selected="true"><%=rs2.getString("bz")%></option>
<%
}
else{
%>
    <option value="<%=rs2.getString("id")%>"><%=rs2.getString("bz")%></option>
<%
}
}
rs2.close();
%>
      </select>
    </td>
  </tr>
  <tr> 
    <th scope="row">信息状态</th>
    <td> 
	<select name=zt>
    <option>
    <option selected>
  </select>
    </td>
  </tr>
  <tr>
    <th>登记人</th>
    <td><%=czy%></td>
  </tr>
  <tr>
    <th>登记时间</th>
    <td><%=gxrq%></td>
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


