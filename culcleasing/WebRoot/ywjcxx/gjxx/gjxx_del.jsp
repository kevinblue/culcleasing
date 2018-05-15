<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>国家信息</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>


<%
String id = getStr( request.getParameter("czid") );
String sqlstr;
ResultSet rs;
sqlstr = "select jb_gjxx.*,base_user.name from dbo.jb_gjxx left join base_user on jb_gjxx.czy=base_user.id where jb_gjxx.id='"+ id+"'";
rs = db.executeQuery(sqlstr); 

String gjmc = "";
String gxrq = "";
String xm = "";

if ( rs.next() ) {
	gjmc = getDBStr( rs.getString("gjmc") );
	gxrq = getDBDateStr( rs.getString("gxrq") );
	xm = getDBStr( rs.getString("name") );
}

rs.close();
db.close();

%>

<%

String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("ywjcxx_gjxx_del",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");

%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<form name="form1" method="post" action="gjxx_save.jsp">
<input type="hidden" name="savetype" value="del">
<input type="hidden" name="id" value="<%= id %>">



<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">基础信息管理 &gt; 国家删除</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">
<!-- end cwCellTop -->





<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td height="30" scope="row">国家代码</th>
    <td width="84%" height="30" class="cwDDValue"><%=id%></td>
  </tr>
  <tr>
    <td height="30" scope="row">国家名称</th>
    <td height="30" class="cwDDValue"><%= gjmc %></td>
  </tr>
  <tr>
    <td height="30" scope="row">最后更新日期</th>
    <td height="30" class="cwDDValue"><%= gxrq %></td>
  </tr>
  <tr>
    <td height="30" scope="row">操作员</th>
    <td height="30" class="cwDDValue"><%= xm %></td>
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
<input name="btndel" value="删除" type="submit" onClick="return(confirm('确定删除吗?'))" class="btn3_mouseout"></td>
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
  
