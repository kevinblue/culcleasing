<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>GPS巡检报告明细 - GPS管理 </title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("gps-tzxj-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<body>

<%
String id = getStr( request.getParameter("id") );
String tzpolling_id = "";
String gpstpye="";
String cai_no="";
String sim_no = "";
String import_date="";
String province = "";
String city = "";
String address="";
String state = "";
String cusname = "";
String branch_company = "";
ResultSet rs;
String sqlstr = "select * from vi_tzexamine_details where tzexamine_details='" + id + "'"; 
rs = db.executeQuery(sqlstr); 
if (rs.next()){
  tzpolling_id = getDBStr( rs.getString("tzpolling_id") );
  gpstpye = getDBStr( rs.getString("gpstpye") );	
  cai_no = getDBStr( rs.getString("cai_no") );
  sim_no = getDBStr( rs.getString("sim_no") );	
  import_date = getDBDateStr( rs.getString("import_date") );		
  province = getDBStr( rs.getString("province") );
  city = getDBStr( rs.getString("city") );
  state = getDBStr( rs.getString("state") );
  cusname = getDBStr( rs.getString("cusname") );
  branch_company = getDBStr( rs.getString("branch_company") );
}
rs.close();
//重新读出省市数据
/*sqlstr="selcet  , ,   from   ";
rs = db.executeQuery(sqlstr); 
if (rs.next()){
	//读出三行数据
}
rs.close();*/
db.close();
%>

<form name="form1" method="post" action="gps_tzxjmx_mod.jsp" onSubmit="return Validator.Validate(this,3);">

<table  class="title_top" width=100% height=100% align="center" cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
GPS管理 &gt;  GPS巡检报告明细
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
<a href="gps_tzxjmx_mod.jsp?id=<%= id %>"  accesskey="m" title="修改(Alt+M)" class="fontcolor">
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
    <td width="20%">巡检明细id</td>
    <td><%=id%>
	</td>
    <td width="20%">巡检报告id</td>
    <td><%=tzpolling_id%></td>
  </tr>
    <tr>
  <td>客户名称 </td>
   <td><%=cusname%></td>
    <td>分公司</td>
   <td><%=branch_company%></td>
  </tr>
  <tr>
  <td>SIM卡号</td>
   <td><%=sim_no%></td>
	<td >GPS型号</td>
	<td><%=gpstpye%></td>
  </tr>
  <tr>
   <td>车牌号</td>
  <td><%=cai_no%></td>
    <td>巡检日期</td>
   <td><%=import_date%></td>
  </tr>
  <tr>
  <td>省</td>
   <td><%=province%></td>
   <td>市</td>
   <td><%=city%></td>
  </tr>
  <tr>
  <td>区</td>
   <td><%=address%></td>
    <td>状态</td>
   <td><%=state%></td>
  </tr>
</table>


</div>
</div>

    </form>

</body>
</html>
