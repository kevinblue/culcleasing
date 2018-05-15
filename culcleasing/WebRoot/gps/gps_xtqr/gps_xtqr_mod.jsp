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
if (right.CheckRight("gps-xtqr-mod",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>GPS如系统前确定 - GPS修改</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>
<body>
<form name="form1" method="post" action="gps_xtqr_save.jsp" onSubmit="">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
 GPS管理 &gt; GPS入系统前确认
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
	String sqlstr = "select * from vi_gps_sure where gpsinfo_id='" + id + "'"; //SQL查询语句
	System.out.println(sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 
	String machine_no="";
	String machine_type="";
	String sim_no="";
	String install_date="";
	String service_begindate="";
	String service_enddate="";
	String gpsinfo_id="";
	String yes_date="";
	String fixed_state="";
	String sfmc="";
	String csmc="";
	String address="";
	String memo="";
	String gps_index_type="";
	String cust_name="";//客户名
	String expect_start_date="";//起租日期
	String term="";//期限
	String province="";
	String city="";
	
	if ( rs.next() ) {
		cust_name=getDBStr( rs.getString("cust_name") );
		machine_no=getDBStr( rs.getString("machine_no") );
		machine_type=getDBStr( rs.getString("machine_type") );
		sim_no=getDBStr( rs.getString("sim_no") );
		install_date=getDBStr( rs.getString("install_date") );
		gpsinfo_id=getDBStr( rs.getString("gpsinfo_id") );
		csmc=getDBStr( rs.getString("csmc") );
		address=getDBStr( rs.getString("address") );
		service_begindate=getDBDateStr( rs.getString("service_begindate") );
		service_enddate=getDBDateStr( rs.getString("service_enddate") );
		expect_start_date=getDBDateStr( rs.getString("expect_start_date") );
		yes_date=getDBDateStr( rs.getString("yes_date") );
		fixed_state=getDBStr( rs.getString("fixed_state") );
		sfmc=getDBStr( rs.getString("sfmc") );
		gps_index_type=getDBStr( rs.getString("gps_index_type") );
		memo=getDBStr( rs.getString("memo"));
		province=getDBStr( rs.getString("province"));
		city=getDBStr( rs.getString("city"));
		term=getDBStr( rs.getString("term") );
	}
	rs.close(); 
	db.close();
%>
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="czid" value="<%=id %>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
             <tr>
             <td >SIM卡号：</td>
                <td><%=sim_no%></td>
                <td >客户名：</td>
                <td><%=cust_name  %></td>
                
              </tr>
              <tr>
                <td >机编号: </td>
                <td><%= machine_no %></td>
                <td >型号: </td>
                <td><%= machine_type %></td>
              </tr>
              <tr>
                <td >起租日期：</td>
                <td><%=expect_start_date  %></td>
                <td >查询日期：</td>
                <td><%= install_date %></td>
              </tr>
              <tr>
                <td >GPS车载终端序号：</td>
                <td><%=gps_index_type%></td>
                
                <td >期限：</td>
                <td><%=term %></td>
              </tr>
              <tr>
                <td >入网时间：</td>
                <td><%=service_begindate%></td>
                <td >服务截止时间：</td>
                <td><%=service_enddate %></td>
                 </tr>
              <tr>
                <td >正常日期：</td>
                <td><input name="yes_date" type="text"  value="<%=yes_date%>" readonly><img  onClick="openCalendar(yes_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
             
                <td >定位状态：</td>
                <td><select name="fixed_state">
        <script>w(mSetOpt('<%=fixed_state%>',"|定位有效|定位无效|定位失败"));</script>
        </select></td>
              </tr>
              <tr>
                <td >省份：</td>
                <td><input type="text" name="sfdata" readonly Require="ture" value="<%=sfmc%>"><input type="hidden" name="province" value="<%=province%>" onPropertychange="form1.csdata.value='';form1.city.value='';"> <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','省份','jb_ssxx','sfmc','id','sfmc','sfmc','asc','form1.sfdata','form1.province');"></td>
                <td >市：</td>
                <td><input type="text" name="csdata" readonly Require="ture" value="<%=csmc%>"><input type="hidden" name="city" value="<%=city%>" > <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('form1.province','省份','sfid','string','城市','jb_csxx','csmc','id','csmc','csmc','asc','form1.csdata','form1.city');"></td>
              </tr>
              <tr>
                <td >区：</td>
                <td><input name="address" type="text"  size="40" value="<%=address%>"></td>
                <td></td><td></td>
                </tr><tr>
                <td >备注：</td>
                <td><textarea name="memo" cols="40" rows="5"><%=memo%></textarea></td>
                <td></td><td></td>
              </tr>
            </table>
</div>
</div>
</td></tr></table>
    </form>
</body>
</html>
