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
if (right.CheckRight("gps-hcxj-mod",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合成GPS客户巡检报告修改 - GPS修改</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>
<body>
<form name="form1" method="post" action="gps_hcxj_save.jsp" onSubmit="">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
 GPS管理 &gt; 合成GPS客户巡检报告修改
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
	String sqlstr = "select * from vi_hcexamine_info where hcpolling_id='" + id + "'"; //SQL查询语句
	System.out.println(sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 
	String hcpolling_id="";
	String headquarters="";
	String car_type="";
	String car_no="";
	String car_model="";
	String sim_no="";
	String province="";
	String city="";
	String address="";
	String agents="";
	String carservices_state="";
	String polling_condition="";
	String polling_date="";
	String fall_time="";
	if ( rs.next() ) {
		hcpolling_id=getDBStr( rs.getString("hcpolling_id") );
		headquarters=getDBStr( rs.getString("headquarters") );
		car_type=getDBStr( rs.getString("car_type") );
		car_no=getDBStr( rs.getString("car_no") );
		car_model=getDBStr( rs.getString("car_model") );
		sim_no=getDBStr( rs.getString("sim_no") );
		province=getDBStr( rs.getString("province") );
		city=getDBStr( rs.getString("city") );
		address=getDBStr( rs.getString("address") );
		agents=getDBStr( rs.getString("agents") );
		carservices_state=getDBStr( rs.getString("carservices_state") );
		polling_condition=getDBStr( rs.getString("polling_condition") );
		polling_date=getDBDateStr( rs.getString("polling_date") );
		fall_time=getDBStr( rs.getString("fall_time") );
	}
	rs.close(); 
	db.close();
%>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="czid" value="<%=id %>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
<tr>
 	 <td>SIM卡号 </td>
   	<td><input name="sim_no" type="text" value="<%= sim_no %>" readonly></td>
	<td scope="row"></td>
	<td><input name="car_model" type="hidden" ></td>
    </tr><tr>
  <td>车辆类型</td>
  <td><input name="car_type" type="text" value="<%= car_type %>" readonly></td>
  <td>车辆型号</td>
  <td><input name="car_model_name" type="text" value="<%= car_model %>" readonly></td>
  </tr>
  <tr>
  <td>车牌号 </td>
   <td><input name="car_no" type="text" value="<%= car_no %>"></td>
   <td scope="row">总部  </td>
	<td><input name="headquarters" type="text" value="<%= headquarters %>"></td>
  </tr>
  <tr>
  <td>省份 </td>
   <td><input type="text" name="province" readonly Require="ture" value="<%=province%>"><!--<input type="hidden" name="province" value="" onPropertychange="form1.csdata.value='';form1.city.value='';"> <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','省份','jb_ssxx','sfmc','id','sfmc','sfmc','asc','form1.sfdata','form1.province');">--></td>
   <td>市 </td>
   <td><input type="text" name="city" readonly Require="ture" value="<%=city%>"><!--<input type="hidden" name="city" value="" > <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('form1.province','省份','sfid','string','城市','jb_csxx','csmc','id','csmc','csmc','asc','form1.csdata','form1.city');">--></td>
  </tr>
  <tr>
  <td>区</td>
   <td><input name="address" type="text"  value="<%= address %>"></td>
   <td>代理商 </td>
   <td><input name="agents" type="text"  value="<%= agents %>"></td>
  </tr>
  <tr>
  <td>车辆服务状态</td>
   <td><select name="carservices_state">
        <script>w(mSetOpt('<%= carservices_state %>',"服务有效期|服务已过期"));</script>
        </select></td>
   <td>巡检日期</td>
   <td><input name="polling_date" type="text"  value="<%= polling_date %>" readonly><img  onClick="openCalendar(polling_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
  <tr>
  <td>巡检条件</td>
   <td><select name="polling_condition">
        <script>w(mSetOpt('<%= polling_condition %>',"定位无效|定位失败"));</script>
        </select></td>
   <td>巡检失败天数 </td>
   <td><input name="fall_time" type="text"  value="<%= fall_time %>"></td>
  </tr>
</table>
</div>
</div>

    </form>
</body>
</html>
