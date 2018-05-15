<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("duning-directives-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title> 主管领导指示详细信息 - 主管领导指示</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>
<%
	String id = getStr( request.getParameter("czid") );
	String directiver = "";
	String directive_date = "";
	String directive_info = "";
	String cust_name = "";
	
	ResultSet rs;
	String sqlstr = "select dbo.getcustname(cust_id) as cust_name,directive_date,directive_info,directiver from dunning_directives where directive_id='" + id + "'"; 

	rs = db.executeQuery(sqlstr); 
	if (rs.next()){
		cust_name = getDBStr( rs.getString("cust_name") );
		directive_date = getDBDateStr( rs.getString("directive_date") );
		directive_info = getDBStr( rs.getString("directive_info") );
		directiver = getDBStr( rs.getString("directiver") );
	}
	rs.close();
	sqlstr="select name from base_user where id='"+directiver+"'";
	rs = db.executeQuery(sqlstr); 
	if (rs.next()){
		directiver = getDBStr( rs.getString("name") );
	}
	rs.close();
	db.close();
%>
<body>
<form name="form1" method="post" action="directives_save.jsp" onSubmit="return Validator.Validate(this,3);">
<table  class="title_top" width=100% height=100% align="center" cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
主管领导指示 &gt;  主管领导指示详细信息
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	
<a href="directives_mod.jsp?czid=<%= id %>"  accesskey="m" title="修改(Alt+M)" class="fontcolor">
		<img src="../../images/sbtn_mod.gif" width="19" height="19" align="absmiddle" >修改</a>
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>
</td></tr>
</table>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">详细信息</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<!-- end cwTop -->

<!-- end cwCellTop -->
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<input type="hidden" name="czid" value="<%=id %>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
   <td scope="row" nowrap width="20%">客户名称</td>
    <td><%=cust_name %></td>
    <td scope="row" nowrap width="20%">指示人</td>
    <td><%= directiver %>
	</td>

   
  </tr>
  <tr>
   <td scope="row" nowrap width="20%">指示日期</td>
    <td><%=directive_date %></td>
    <td scope="row" nowrap width="20%">指示内容</td>
  </tr>
  <tr>
  <td colspan="4"><%=directive_info%></td>
  </tr>
</table>

</div>
</div>
    </form>
</body>
</html>
