<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>区域信息明细 - 基础信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
String id = getStr( request.getParameter("czid") );
String sqlstr;
ResultSet rs;
sqlstr = "select jb_qyxx.id,jb_qyxx.qyid,jb_qyxx.gjid,jb_gjxx.gjmc,jb_qyxx.qymc,jb_qyxx.gxrq,jb_qyxx.czy,base_user.name from jb_qyxx  left join base_user on jb_qyxx.czy=base_user.id left join jb_gjxx on jb_qyxx.gjid=jb_gjxx.id where jb_qyxx.id='" + id+"'"; 
System.out.print(sqlstr);
rs = db.executeQuery(sqlstr); 

String qyid = "";
String qymc = "";
String gjid = "";
String gjmc = "";
String gxrq = "";
String xm = "";

if ( rs.next() ) {
	qyid = getDBStr( rs.getString("qyid") );
	qymc = getDBStr( rs.getString("qymc") );
	gjmc = getDBStr( rs.getString("gjmc") );
	gjid = getDBStr( rs.getString("gjid") );
	gxrq = getDBDateStr( rs.getString("gxrq") );
	xm = getDBStr( rs.getString("name") );
}


rs.close();
db.close();
%>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=left cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">基础信息管理 &gt; 区域信息明细</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">
	
	

<!-- end cwCellTop -->




<form action="qyxx.jsp" name="form1">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
  	<td width="20%" height="30" class="cwDDLabel">所属国家</td>
    <td height="30" class="cwDDValue">
    	<%=gjmc%>
    </td>
  </tr>
  <tr>
    <td  width="20%" height="30" class="cwDDLabel">地区代码：</td>
    <td height="30"  class="cwDDValue"><%=qyid%>&nbsp;</td>
  </tr>
 <tr>
    <td  width="20%" height="30" class="cwDDLabel">地区名称</td>
    <td height="30" class="cwDDValue"><%=qymc%>&nbsp;</td>
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
</form>

</div>





<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top">
<form action="qyxx_mod.jsp?czid=<%=id%> " target="_self">
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