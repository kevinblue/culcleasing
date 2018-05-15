<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>国家信息明细 - 基础信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
String id = getStr( request.getParameter("czid") );
String sqlstr;
ResultSet rs;
sqlstr = "select jb_gjxx.*,base_user.name from dbo.jb_gjxx left join base_user on jb_gjxx.czy=base_user.id where jb_gjxx.id='" + id+"'"; 
System.out.print(sqlstr);
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
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=left cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">基础信息管理 &gt; 国家信息明细</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">
	
	

<!-- end cwCellTop -->





<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td  width="20%" height="30" class="cwDDLabel">国家代码：</td>
    <td height="30"  class="cwDDValue"><%=id%>&nbsp;</td>
  </tr>
 <tr>
    <td  width="20%" height="30" class="cwDDLabel">国家名称</td>
    <td height="30" class="cwDDValue"><%=gjmc%>&nbsp;</td>
  </tr>
   <tr>
    <td  width="20%" height="30" class="cwDDLabel">最后更新日期</td>
    <td height="30" class="cwDDValue"><%=gxrq%>&nbsp;</td>
  </tr>
   <tr>
    <td  width="20%" height="30" class="cwDDLabel">操作员</td>
    <td height="30" class="cwDDValue"><%=xm%>&nbsp;</td>
  </tr>
</table>


</div>





<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top">
<form action="gjxx_mod.jsp?czid=<%=id%> " target="_self">
<input name="czid" value="<%=id%>" type="hidden">
<td>
<input name="btnMod" value="修改" type="submit" class="btn3_mouseout">
</td>
</form>
<td>&nbsp;&nbsp;
<input name="btnClose" value="关闭" type="button" onClick="window.close()" class="btn3_mouseout">
</td>


</tr>
</table>

<!-- end cwToolbar -->
    </form>
  
</div>
<!-- end cwMain -->
<!--
-->
</body>
</html>



