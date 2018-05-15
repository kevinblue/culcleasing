<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合成GPS客户巡检报告删除 - GPS管理</title>
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
if (right.CheckRight("gps-hcxj-del",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>

<body>


<form name="form1" method="post" action="gps_hcxj_save.jsp" onSubmit="">

<table  class="title_top" width=100% height=100% align="center" cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
GPS管理 &gt;  合成GPS客户巡检报告删除
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

<input type="hidden" name="savetype" value="del">
<input type="hidden" name="czid" value="<%=id %>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr><td scope="row" nowrap width="20%">SIM卡号：</td>
    <td><%=sim_no%></td>
    <td scope="row" nowrap width="20%"></td>
    <td></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">车辆类型:  </td>
    <td><%= car_type %></td>
    <td scope="row" nowrap width="20%">车辆型号：</td>
    <td><%= car_model %></td>
  </tr>
   <tr>
    <td scope="row" nowrap width="20%">车牌号:  </td>
    <td><%= car_no %></td>
     <td scope="row" nowrap width="20%">总部：</td>
    <td><%= headquarters %></td>
  </tr>
   <tr>
    <td scope="row" nowrap width="20%">省份：</td>
    <td><%= province %></td>
    <td scope="row" nowrap width="20%">市：</td>
    <td><%=city%></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">区：</td>
    <td><%= address %></td>
    <td scope="row" nowrap width="20%">代理商：</td>
    <td><%=agents%></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">车辆服务状态：</td>
    <td><%= carservices_state %></td>
    <td scope="row" nowrap width="20%">巡检日期：</td>
    <td><%=polling_date%></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">巡检条件：</td>
    <td><%= polling_condition %></td>
    <td scope="row" nowrap width="20%">巡检失败天数：</td>
    <td><%=fall_time%></td>
  </tr>
</table>
</div>
</div>
    </form>
</body>
</html>
