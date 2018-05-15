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
if (right.CheckRight("gps-list-del",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>GPS删除 - GPS管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>



<body>


<form name="form1" method="post" action="gps_save.jsp" onSubmit="">

<table  class="title_top" width=100% height=100% align="center" cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
GPS管理 &gt;  GPS删除
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
<BUTTON class="btn_2" name="btnSave" value="删除"  type="submit" >
<img src="../../images/sbtn_del.gif" align="absmiddle" border="0">删除</button>
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">删 除</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<!-- end cwTop -->
<!-- end cwCellTop -->

<%
String id = getStr( request.getParameter("id") );
String machine_type = "";
String machine_no="";
String sim_no="";
String gps_terminal_type = "";
String gps_index_type= "";
String install_date="";
String gpsinfo_id = "";
String contract_id = "";
String car_group="";
String service_begindate = "";
String service_enddate = "";
String renewals_enddate1 = "";
String renewals_enddate2 = "";
String location_test = "";
String remote_Control_test = "";
String acc_statistics = "";
String polling_state = "";
String billable_date1="";
String billable_date2 = "";
String billable_date3 = "";
String stop_record = "";
String stop_reason = "";
String relief_record = "";
String gps_right = "";
String dismantle = "";
String dismantle_date = "";
String remark = "";
String cust_name="";
String lease_term="";
ResultSet rs;
String sqlstr = "select * from vi_examine_info where gpsinfo_id='" + id + "'"; 
rs = db.executeQuery(sqlstr); 
if (rs.next()){
  gpsinfo_id = getDBStr( rs.getString("gpsinfo_id") );
  contract_id = getDBStr( rs.getString("contract_id") );
  gps_terminal_type = getDBStr( rs.getString("gps_terminal_type") );
  gps_index_type = getDBStr( rs.getString("gps_index_type") );
  machine_type = getDBStr( rs.getString("machine_type") );
  machine_no = getDBStr( rs.getString("machine_no") );
  sim_no = getDBStr( rs.getString("sim_no") );
  car_group = getDBStr( rs.getString("car_group") );	
  install_date = getDBDateStr( rs.getString("install_date") );
  service_begindate = getDBDateStr( rs.getString("service_begindate") );		
  service_enddate = getDBDateStr( rs.getString("service_enddate") );
  renewals_enddate1 = getDBDateStr( rs.getString("renewals_enddate1") );
  renewals_enddate2 = getDBDateStr( rs.getString("renewals_enddate2") );
  location_test = getDBStr( rs.getString("location_test") );
  remote_Control_test = getDBStr( rs.getString("remote_Control_test") );
  acc_statistics = getDBStr( rs.getString("acc_statistics") );
  polling_state = getDBStr( rs.getString("polling_state") );
  billable_date1 = getDBDateStr( rs.getString("billable_date1") );
  billable_date2 = getDBDateStr( rs.getString("billable_date2") );
  billable_date3 = getDBDateStr( rs.getString("billable_date3") );
  stop_record = getDBStr( rs.getString("stop_record") );
  stop_reason = getDBStr( rs.getString("stop_reason") );
  relief_record = getDBStr( rs.getString("relief_record") );
  dismantle = getDBStr( rs.getString("dismantle") );
  dismantle_date = getDBDateStr( rs.getString("dismantle_date") );
  remark = getDBStr( rs.getString("remark") );		
  lease_term=rs.getString("lease_term");
  cust_name=rs.getString("cust_name");
}
rs.close();
db.close();
%>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="del">
<input type="hidden" name="gpsinfo_id" value="<%=id %>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
  <td  width="20%">客户名称</td>
   <td width="30%"><%=cust_name%></td>
    <td width="20%">设备型号</td>
    <td ><%=machine_type%></td>
  </tr>
  <tr>
  <td>SIM卡号</td>
  <td><%=sim_no%></td>
	<td >机身编号</td>
	<td><%=machine_no%></td>
  
  </tr>
  <tr>
  <td>GPS车载终端型号(序列号) </td>
   <td><%=gps_index_type%></td>
   <td>GPS车载终端型号(版本号) </td>
   <td><%=gps_terminal_type%></td>
   </tr>
   <tr>
    <td>安装日期</td>
   <td><%=install_date%></td>
   <td>车载分组 </td>
   <td><%=car_group%></td>
  </tr>
  <tr>
  <td>融资期限(月数)</td>
   <td><%=lease_term%></td>
    <td>开通服务日期(入网时间)</td>
   <td><%=service_begindate%></td>
  </tr>
  <tr>
  <td>开通服务截止日期 </td>
   <td><%=service_enddate%></td>
    <td>续费服务截止日期1</td>
   <td><%=renewals_enddate1%></td>
  </tr>
  <tr>
  <td>续费服务截止日期2 </td>
   <td><%=renewals_enddate2%></td>
    <td>定位测试</td>
   <td><%=location_test%></td>
  </tr>
  <tr>
  <td>远程控制测试 </td>
   <td><%=remote_Control_test%></td>
    <td>安装时的ACC统计</td>
   <td><%=acc_statistics%></td>
  </tr>
  <tr>
  <td>巡检状态</td>
   <td><%=polling_state%></td>
    <td>第一次请款时间</td>
   <td><%=billable_date1%></td>
  </tr>
  <tr>
  <td>第二次请款时间 </td>
   <td><%=billable_date2%></td>
    <td>第三次请款时间</td>
   <td><%=billable_date3%></td>
  </tr>
  <tr>
  <td>断油断电记录</td>
   <td><%=stop_record%></td>
    <td>断油断点原因</td>
   <td><%=stop_reason%></td>
  </tr>
  <tr>
  <td>解除断油断电记录</td>
   <td><%=relief_record%></td>
    <td>后期GPS是否正常</td>
   <td><%=gps_right%></td>
  </tr>
  <tr>
  <td>拆除否</td>
   <td><%=dismantle%></td>
    <td>拆除日期</td>
   <td><%=dismantle_date%></td>
  </tr>
  <tr>
  <td>备注</td>
    <td><%=remark%></td>
    <td>   </td>
   <td>   </td>
  </tr>
</table>
</div>
</div>
    </form>
</body>
</html>
