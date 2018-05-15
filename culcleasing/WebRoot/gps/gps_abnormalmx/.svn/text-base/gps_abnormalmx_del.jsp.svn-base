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
<title> GPS不正常跟踪明细删除 - GPS管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>



<body>


<form name="form1" method="post" action="gps_abnormalmx_save.jsp" onSubmit="">

<table  class="title_top" width=100% height=100% align="center" cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
GPS管理 &gt;  GPS不正常跟踪明细删除
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
String sim_no = getStr( request.getParameter("sim_no") );
String track_date = "";
String fixed_state="";
String track_state="";
String track_memo = "";
String creator="";

ResultSet rs;
String sqlstr = "select id,track_date,track_state,fixed_state,track_memo,dbo.getusername(creator) as creator from dbo.gps_abnormal_track_detail as detail left join gps_abnormal_track as track on (detail.gpsinfo_id=track.gpsinfo_id) where id='" + id + "'"; 
rs = db.executeQuery(sqlstr); 
if (rs.next()){
	track_state = getDBStr( rs.getString("track_state") );
  fixed_state = getDBStr( rs.getString("fixed_state") );
  track_memo = getDBStr( rs.getString("track_memo") );	
  creator = getDBStr( rs.getString("creator") );
  track_date = getDBDateStr( rs.getString("track_date") );	
}
rs.close();
db.close();
%>
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="del">
<input type="hidden" name="czid" value="<%=id %>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td >SIM卡号</td>
    <td><%=sim_no%>
	</td>
    <td>跟踪日期</td>
    <td><%=track_date%></td>
  </tr>
  <tr>
  <td>是否正常</td>
  <td><%=track_state%></td>
  <td>定位状态</td>
   <td><%=fixed_state%></td>
  </tr>
  <tr>
  <td>跟踪情况</td>
   <td><%=track_memo%></td>
   <td>操作员</td>
   <td><%=creator%></td>
  </tr>
</table>
</div>
</div>
    </form>
</body>
</html>
