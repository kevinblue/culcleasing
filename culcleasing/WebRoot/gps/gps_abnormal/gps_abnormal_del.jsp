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
if (right.CheckRight("gps-abnormal-del",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>GPS不正常跟踪删除 - GPS管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>



<body>


<form name="form1" method="post" action="gps_abnormal_save.jsp" onSubmit="">

<table  class="title_top" width=100% height=100% align="center" cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
GPS管理 &gt;  GPS不正常跟踪删除
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
	String sqlstr = "select track.gpsinfo_id,cust_name,sim_no,machine_no,service_begindate,service_enddate,track.track_state from dbo.gps_abnormal_track as track left join vi_sim_no as sim on  track.gpsinfo_id=sim.gpsinfo_id where track.gpsinfo_id='"+id +"'"; 
	System.out.println(sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 
	String cust_name="";
	String sim_no="";
	String machine_no="";
	String service_begindate="";
	String service_enddate="";
	String track_state="";
	if ( rs.next() ) {
		cust_name=getDBStr( rs.getString("cust_name") );
		sim_no=getDBStr( rs.getString("sim_no") );
		machine_no=getDBStr( rs.getString("machine_no") );
		service_begindate=getDBDateStr( rs.getString("service_begindate") );
		service_enddate=getDBDateStr( rs.getString("service_enddate") );
		track_state=getDBStr( rs.getString("track_state") );
	rs.close(); 
	db.close();
	}
%>
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="del">
<input type="hidden" name="gpsinfo_id" value="<%=id %>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td scope="row" nowrap width="20%">客户名称</td>
    <td><%= cust_name %></td>

    <td scope="row" nowrap width="20%">SIM卡号</td>
    <td><%= sim_no %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">机编号  </td>
    <td><%= machine_no %></td>
    <td scope="row" nowrap width="20%">入网时间  </td>
    <td><%= service_begindate %></td>
  </tr>
   <tr>
    <td scope="row" nowrap width="20%">服务截止日期</td>
    <td><%= service_enddate %></td>
    <td scope="row" nowrap width="20%">是否正常</td>
    <td><%=track_state%></td>
  </tr>
</table>
</div>
</div>
    </form>
</body>
</html>
