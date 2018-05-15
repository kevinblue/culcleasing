<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>删除外币管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
	
</head>
<%
//String czid;
String sqlstr;
ResultSet rs;
String id;
id=getStr(request.getParameter("id"));
//czid=getStr(request.getParameter("czid"));
//if ((czid==null) || (czid.equals("")))
//{
 //  czid="0";
//}
%>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="center">外币 &gt; 删除</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1" method="post" action="wb_save.jsp">
<input type="hidden" name="savetype" value="del">
<input type="hidden" name="id" value="<%=id%>">
<%

sqlstr="select * from  foreign_currency where id='"+id+"'";
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{
%>
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">

    <tr>
    <td class="cwDDLabel">汇率：</td>
    <td class="cwDDLabel"><%=getDBStr(rs.getString("exchange_rate"))%></td>
  </tr>
  <tr>
    <td class="cwDDLabel">利率：</td>
    <td class="cwDDLabel"><%=getDBStr(rs.getString("interest_rate"))%></td>
  </tr>
  <tr>
    <td class="cwDDLabel">对应费用的人民币金额：</td>
    <td class="cwDDLabel"><%=formatNumberStr(rs.getString("amout"),"#,##0.00")%>元</td>
  </tr>
   
  </table>


<%
}
else
{
   out.print("<center>该条记录不存在!</center>");
}
rs.close(); 
db.close();
%>

</div>

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
</form>
</body>
</html>