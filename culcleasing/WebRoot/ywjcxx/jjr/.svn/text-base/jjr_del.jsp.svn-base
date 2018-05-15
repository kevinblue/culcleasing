<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 09.01.05 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>节假日调整</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
</head>

<%
String czid;
String sqlstr;
ResultSet rs;
String jjr;
String hrjjr;
czid=getStr(request.getParameter("czid"));
%>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">基础信息管理 &gt; 删除节假日调整</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1" method="post" action="jjr_save.jsp">
<input type="hidden" name="savetype" value="del">
<input type="hidden" name="id" value="<%=czid%>">
<!-- end cwCellTop -->

<%
sqlstr = " SELECT * FROM hr_jjr where id='"+czid+"' "; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{ 
%>
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td width="16%" class="cwDDLabel">日期</td>
    <td width="84%" class="cwDDValue"><%=getDBDateStr(rs.getString("date"))%></td>
  </tr>
  <tr>
    <td class="cwDDLabel" scope="row">是否节假日</td>
    <%
		  jjr=getDBStr(rs.getString("ishr"));
	      hrjjr=null;
	      if(jjr.equals("1"))
		  {
			  hrjjr="是";
		  }
		  else 
			  hrjjr="否";
        %>
   
    <td class="cwDDValue"><%=hrjjr%></td>
  </tr>
    <tr>
    <td class="cwDDLabel" scope="row">备注</td>
    <td class="cwDDValue"><%=getDBStr(rs.getString("notes"))%></td>
    </tr>
  </table>
<%
}
else
{
   out.print("</center>该条记录不存在!</center>");
}
rs.close(); 
db.close();
%>
<!-- end cwDataNav -->
</table>
</div>
<!-- end cwCellContent -->
<!-- end cwCell -->
<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input class="btn3_mouseout" name="submit" value="删除" type="submit"  onClick="return(confirm('确定删除吗?'))">
</td>
<td width=8 width="12">
<td>
<input name="btnClose" value="取消" type="button" onClick="window.close();" class="btn3_mouseout">
</td>
</tr>
</table>

</div>
<!-- end cwToolbar -->
</form>


<!-- end cwMain -->
</body>
</html>