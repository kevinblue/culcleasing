<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("gps-abnormal-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>GPS不正常跟踪- GPS管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>
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
<body onLoad="setDivHeight('divH',-55);fun_winMax();">
<form name="form1" method="post" action="gps_abnormal_save.jsp" onSubmit="return checkdata(this);">	

<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
GPS不正常跟踪
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
		<!--<td><a href="gps_abnormal_mod.jsp?id=<%= id %>"  accesskey="m" title="修改(Alt+M)" class="fontcolor">
		<img src="../../images/sbtn_mod.gif" width="19" height="19" align="absmiddle" >修改</a></td>-->
		<td><a href="#" onClick="window.close();;opener.location.reload();"  accesskey="m" title="关闭" class="fontcolor">
		<img src="../../images/sbtn_close.gif" width="19" height="19" align="absmiddle" >关闭</a></td>
	  </tr>
</table>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">明 细</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
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
<br>
<div style="text-align:left;width:98%">
<table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_s_tab_0" class="Form_tab" width=100 align=center onClick="chgTabSub()"  valign="middle">跟踪明细</td>
 </tr>
 </table>
<table border="0" cellspacing="0" cellpadding="0" width="100%"><tr><td bgcolor="#8DB2E3" width="100%"><img height="1" width="1"></td></tr></table>
<div id="TD_s_tab_0">
<iframe style="funny:expression(autoResize())" id="UserBody0" frameborder="0" width="100%" src="../gps_abnormalmx/gps_abnormalmx_list.jsp?id=<%=id%>&sim_no=<%=sim_no%>" align="center"></iframe>
</div>
</div>




<div id="TD_tab_1" style="display:none;"> 
  选择卡中的内容2
</div>
<div id="TD_tab_2" style="display:none;"> 
  选择卡中的内容3

选择卡中可能包含以下内容：

注意HTMLBody并不是选择卡中的内容，因此需要独立拿出来放在最后。

</div>

</div>
</center>
<table width=96% align=center border="0" cellspacing="0" cellpadding="0">
<tr><td width="50%"></td>
<td width="50%" valign="middle" align="right">&nbsp;</td></tr>
</table>
</td>
</tr>
</table>  
</div>
<!--添加结束-->

<!--控制选择卡和内置iframe的高度适应窗口-->
<script language="javascript">
ShowTabN(0);
ShowTabSub(0);
reinitIframe();
//外部div高度自适应
function reinitIframe(){
var divH = document.getElementById("divH");
var reinitIframe_resize=function(){
divH.style.height=window.document.body.clientHeight-100;
}
reinitIframe_resize();
window.onresize=reinitIframe_resize;
}
//内部Iframe高度自适应
function autoResize()
{
	try
	{
		document.all["UserBody0"].style.height=UserBody0.document.body.scrollHeight
	}
	catch(e)
	{}
}
</script>
</form>
<!-- end cwMain -->
</body>
</html>
