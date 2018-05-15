<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>修改地区信息 - 基础信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
String id = getStr( request.getParameter("czid") );
String sqlstr;
ResultSet rs;
sqlstr = "select jb_qyxx.id,jb_qyxx.qyid,jb_qyxx.gjid,jb_gjxx.gjmc,jb_qyxx.qymc,jb_qyxx.gxrq,jb_qyxx.czy,base_user.name from jb_qyxx  left join base_user on jb_qyxx.czy=base_user.id left join jb_gjxx on jb_qyxx.gjid=jb_gjxx.id where jb_qyxx.id='"+id+"'"; 
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


<%

String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("ywjcxx_dqxx_mod",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");

%>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">基础信息管理 &gt; 修改地区信息</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1"  method="post" action="qyxx_save.jsp" onSubmit="return Validator.Validate(this,3);">
<!-- end cwCellTop -->





<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="kid" value="<%= id %>">
<input type="hidden" name="mid" value="<%=qyid%>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
	<tr>
    	<td width="20%">所属国家</td>
        <td>
        <input type="text" name="gjmc" readonly Require="true" value="<%=gjmc%>">
    <input type="hidden" name="gjid" value="<%=gjid%>">
    <img src="../../images/sbtn_more.gif" alt="选国家" width="19" height="19" align="absmiddle" style="cursor:pointer" onClick="OpenDataWindow('','','','','国家','jb_gjxx','gjmc','id','gjmc','gjmc','asc','form1.gjmc','form1.gjid');">
    <span class="biTian">*</span>
        </td>
    </tr>
  <tr>
    <td scope="row">地区代码</td>
    <td >
      <input name="id" type="text" size="3" maxlength="3" value="<%= qyid %>" Require="ture"><span class="biTian">*</span>
	</td>
  </tr>
  <tr>
    <td scope="row">地区名称</td>
    <td><input name="qymc" type="text"  value="<%= qymc %>" Require="ture"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td scope="row">最后更新日期</td>
    <td><%= gxrq %></td>
  </tr>
  <tr>
    <td scope="row"> 操作员</td>
    <td><%= xm %></td>
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
<input name="btnReset" value="重置" type="reset" class="btn3_mouseout"></td>
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