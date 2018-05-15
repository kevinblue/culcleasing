<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>GPS巡检报告明细修改 -GPS管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
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
if (right.CheckRight("gps-hcxj-mod",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>


<body>


<form name="form1" method="post" action="gps_hcxjmx_save.jsp" onSubmit="return Validator.Validate(this,3);">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
 GPS管理 &gt; GPS巡检报告明细修改
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
<BUTTON class="btn_2" name="btnSave" value="保存"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">保存</button>
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">修 改</td>
  
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
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="id" value="<%=id %>">
<input type="hidden" name="hcpolling_id" value="<%=hcpolling_id%>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td>SIM卡号</td>
   <td><input name="sim_no" type="text"  value="<%=sim_no%>" readonly></td>
  
  <td>车牌号</td>
  <td><input name="cai_no" type="text"  value="<%=cai_no%>"></td>
  </tr>
  <tr>
  <td>代理商</td>
   <td><input name="agents" type="text"  value="<%=agents%>"></td>
   <td>巡检日期</td>
   <td><input name="polling_date" type="text"  readonly value="<%=polling_date%>" Require="true"><img  onClick="openCalendar(polling_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span></td>
  </tr>
  <tr>
  <td>经度</td>
   <td><input name="longitude" type="text"  value="<%=longitude%>"></td>
    <td>纬度</td>
   <td><input name="latitude" type="text"  value="<%=latitude%>"></td>
  </tr>
  <tr>
  <td>速度 </td>
   <td><input name="speed" type="text"  value="<%=speed%>"></td>
    <td>累计工作小时数</td>
   <td><input name="worktime" type="text"  value="<%=worktime%>" dateType="Number"></td>
  </tr>
  <td>状态 </td>
   <td><select name="state">
        <script>w(mSetOpt('<%=state%>',"开机|关机"));</script>
        </select></td>
    <td>锁车状态</td>
   <td><select name="lock_state">
        <script>w(mSetOpt('<%=lock_state%>',"已锁|未锁"));</script>
        </select></td>
  </tr>
   <td>速度 </td>
   <td><input name="speed" type="text"  value="<%=speed%>"></td>
    <td>定位状态</td>
   <td><select name="fixed_state">
        <script>w(mSetOpt('<%=fixed_state%>',"有效|无效"));</script>
        </select></td>
  </tr>
   <td>入网时间 </td>
   <td><input name="online_time" type="text"  readonly value="<%=online_time%>"> </td>
    <td>服务截止时间</td>
   <td><input name="services_endtime" type="text"  readonly value="<%=services_endtime%>"></td>
  </tr>
</table>
</div>
</div>

    </form>
</body>
</html>
