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
if (right.CheckRight("gps-hcxj-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<body>

<%
String id = getStr( request.getParameter("id") );
String hcpolling_id = "";
String cai_no="";
String sim_no = "";
String agents="";
String polling_date = "";
String longitude = "";
String latitude="";
String speed = "";
String worktime = "";
String state = "";
String lock_state = "";
String fixed_state = "";
String online_time = "";
String services_endtime = "";

ResultSet rs;
String sqlstr = "select * from vi_hcexamine_details where hcexamine_details='" + id + "'"; 
rs = db.executeQuery(sqlstr); 
if (rs.next()){
  hcpolling_id = getDBStr( rs.getString("hcpolling_id") );
  cai_no = getDBStr( rs.getString("cai_no") );
  sim_no = getDBStr( rs.getString("sim_no") );	
  agents = getDBStr( rs.getString("agents") );
  polling_date = getDBDateStr( rs.getString("polling_date") );		
  longitude = getDBStr( rs.getString("longitude") );
  latitude = getDBStr( rs.getString("latitude") );
  speed = getDBStr( rs.getString("speed") );
  worktime = getDBStr( rs.getString("worktime") );
  state = getDBStr( rs.getString("state") );
  lock_state = getDBStr( rs.getString("lock_state") );
  fixed_state = getDBStr( rs.getString("fixed_state") );
  online_time = getDBStr( rs.getString("online_time") );
  services_endtime = getDBDateStr( rs.getString("services_endtime") );
}
rs.close();
db.close();
%>

<form name="form1" method="post" action="gps_hcxjmx_mod.jsp" onSubmit="return Validator.Validate(this,3);">

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
<a href="gps_hcxjmx_mod.jsp?id=<%= id %>"  accesskey="m" title="修改(Alt+M)" class="fontcolor">
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
  <td>SIM卡号</td>
   <td><%=sim_no%></td>
  <td>车牌号</td>
  <td><%=cai_no%></td>  
  </tr>
  <tr>
  <td>代理商</td>
   <td><%=agents%></td>
   <td>巡检日期</td>
   <td><%=polling_date%></td>
  </tr>
  <tr>
  <td>经度</td>
   <td><%=longitude%></td>
    <td>纬度</td>
   <td><%=latitude%></td>
  </tr>
  <tr>
  <td>速度 </td>
   <td><%=speed%></td>
    <td>累计工作小时数</td>
   <td><%=worktime%></td>
  </tr>
  <td>状态 </td>
   <td><%=state%></td>
    <td>锁车状态</td>
   <td><%=lock_state%></td>
  </tr>
   <td>速度 </td>
   <td><%=speed%></td>
    <td>定位状态</td>
   <td><%=fixed_state%></td>
  </tr>
   <td>入网时间 </td>
   <td><%=online_time%></td>
    <td>服务截止时间</td>
   <td><%=services_endtime%></td>
  </tr>
</table>


</div>
</div>

    </form>

</body>
</html>
