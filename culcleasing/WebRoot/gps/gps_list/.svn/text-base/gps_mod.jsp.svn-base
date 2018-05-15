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
if (right.CheckRight("gps-list-mod",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>GPS修改 -GPS管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>



<body>


<form name="form1" method="post" action="gps_save.jsp" onSubmit="return Validator.Validate(this,3);">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
 GPS管理 &gt; GPS修改
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
<script>
function checkdate(date1,date2,datename1,datename2){
	
	var date_1=document.getElementsByName(date1).item(0).value;
	var date_2=document.getElementsByName(date2).item(0).value;
	if(date_1!=''&&date_2!=''){
		date_1=date_1.replace('-','/').replace('-','/');
		date_2=date_2.replace('-','/').replace('-','/');
		var date1_temp=new Date(date_1);
		var date2_temp=new Date(date_2);
		if(date2_temp.valueOf()<date1_temp.valueOf()){
			alert('您确定  '+datename2+'  要比  '+datename1+'  小吗?');
		}
	}
}
</script>
<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="gpsinfo_id" value="<%=id %>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
  <td  width="20%">客户名称</td>
   <td width="30%"><input name="cust_name" value="<%=cust_name%>" readonly></td>
    <td width="20%">设备型号</td>
    <td ><input name="machine_type" value="<%=machine_type%>" readonly></td>
  </tr>
  <tr>
  <td>SIM卡号</td>
  <td><input name="sim_no" type="text"  value="<%=sim_no%>" Require="true" dataType="Mobile"></td>
	<td >机身编号</td>
	<td><input name="machine_no" type="text"  value="<%=machine_no%>" ></td>
  </tr>
  <tr>
  <td>GPS车载终端型号(序列号) </td>
   <td><input name="gps_index_type" type="text"  value="<%=gps_index_type%>"></td>
  <td>GPS车载终端型号(版本号) </td>
   <td><input name="gps_terminal_type" type="text"  value="<%=gps_terminal_type%>"></td>
   </tr>
   <tr>
    <td>安装日期</td>
   <td><input name="install_date" type="text" readonly  value="<%=install_date%>"><img  onClick="openCalendar(install_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  <td>车载分组 </td>
   <td><select name="car_group">
        <script>w(mSetOpt('<%=car_group%>',"Hap Seng|CCFL组|LSHM|CMB"));</script>
        </select></td>
  </tr>
  <tr>
  <td>融资期限(月数)</td>
   <td><input name="lease_term" type="text"  value="<%=lease_term%>" readonly></td>
    <td>开通服务日期(入网时间)</td>
   <td><input name="service_begindate" type="text" readonly  value="<%=service_begindate%>" onPropertychange="checkdate('service_begindate','service_enddate','开通服务日期','开通服务截止日期')"><img  onClick="openCalendar(service_begindate);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
  <tr>
  <td>开通服务截止日期 </td>
   <td><input name="service_enddate" type="text" readonly  value="<%=service_enddate%>"  onPropertychange="checkdate('service_begindate','service_enddate','开通服务日期','开通服务截止日期')"><img  onClick="openCalendar(service_enddate);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
    <td>续费服务截止日期1</td>
   <td><input name="renewals_enddate1" type="text" readonly  value="<%=renewals_enddate1%>"  onPropertychange="checkdate('service_enddate','renewals_enddate1','开通服务截止日期','续费服务截止日期1')"><img  onClick="openCalendar(renewals_enddate1);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
  <tr>
  <td>续费服务截止日期2 </td>
   <td><input name="renewals_enddate2" type="text" readonly  value="<%=renewals_enddate2%>"  onPropertychange="checkdate('renewals_enddate1','renewals_enddate2','续费服务截止日期1','续费服务截止日期2')"><img  onClick="openCalendar(renewals_enddate2);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
    <td>定位测试</td>
   <td><input name="location_test" type="text"  value="<%=location_test%>"></td>
  </tr>
  <tr>
  <td>远程控制测试 </td>
   <td><input name="remote_Control_test" type="text"  value="<%=remote_Control_test%>"></td>
    <td>安装时的ACC统计</td>
   <td><input name="acc_statistics" type="text"  value="<%=acc_statistics%>"></td>
  </tr>
  <tr>
  <td>巡检状态</td>
   <td><input name="polling_state" type="text"  value="<%=polling_state%>"></td>
    <td>第一次请款时间</td>
   <td><input name="billable_date1" type="text"  readonly value="<%=billable_date1%>"onPropertychange="checkdate('billable_date1','billable_date2','第一次请款时间','第二次请款时间')"><img  onClick="openCalendar(billable_date1);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
  <tr>
  <td>第二次请款时间 </td>
   <td><input name="billable_date2" type="text" readonly  value="<%=billable_date2%>"onPropertychange="checkdate('billable_date1','billable_date2','第一次请款时间','第二次请款时间');checkdate('billable_date2','billable_date3','第二次请款时间','第三次请款时间')"><img  onClick="openCalendar(billable_date2);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
    <td>第三次请款时间</td>
   <td><input name="billable_date3" type="text" readonly  value="<%=billable_date3%>"onPropertychange="checkdate('billable_date2','billable_date3','第二次请款时间','第三次请款时间')"><img  onClick="openCalendar(billable_date3);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
  <tr>
  <td>断油断电记录 </td>
   <td><input name="stop_record" type="text"  value="<%=stop_record%>"></td>
    <td>断油断点原因</td>
   <td><input name="stop_reason" type="text"  value="<%=stop_reason%>"></td>
  </tr>
  <tr>
  <td>解除断油断电记录</td>
   <td><input name="relief_record" type="text"  value="<%=relief_record%>"></td>
    <td>后期GPS是否正常</td>
   <td><select name="gps_right">
        <script>w(mSetOpt('<%=gps_right%>',"否|是"));</script>
        </select></td>
  </tr>
  <tr>
  <td>拆除否</td>
   <td><select name="dismantle">
        <script>w(mSetOpt('<%=dismantle%>',"否|是"));</script>
        </select></td>
    <td>拆除日期</td>
   <td><input name="dismantle_date" type="text"  value="<%=dismantle_date%>" onPropertychange="checkdate('install_date','dismantle_date','安装日期','拆除日期')"><img  onClick="openCalendar(dismantle_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
  <tr>
  <td>备注</td>
    <td><textarea name="remark" rows="4" maxB="200"><%=remark%></textarea></td>
    <td>   </td>
   <td>   </td>
  </tr>
</table>
</div>
</div>

    </form>
<script language="javascript">
 dict_list("credit_rank","CredDegree","","name");
</script>

</body>
</html>
