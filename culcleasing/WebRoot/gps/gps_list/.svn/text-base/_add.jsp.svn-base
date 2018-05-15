<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>GPS管理 - GPS添加</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<script>
function checkdata(obj)
{
    return Validator.Validate(obj,3);
}
</script>
</head>
<body>


<form name="form1" method="post" action="gps_save.jsp" onSubmit="return checkdata(this);">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
GPS管理 &gt;  GPS添加 
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">新 增</td>
  
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

<input type="hidden" name="savetype" value="add">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
	<td scope="row">机身编号</td>
	<td><input name="machine_no" type="text" size="20" maxB="50" readonly ><input type="hidden" name="contract_id" value=""><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','机编号',  'contract_view','equip_sn','contract_id|cust_name|income_number|device_type','contract_id','','','form1.equip_sn','form1.contract_id|form1.cust_name|form1.lease_term|form1.machine_type');"><span class="biTian">*</span></td>
  <td>SIM卡号</td>
  <td><input name="sim_no" type="text"   Require="true" dataType="Mobile"><span class="biTian">*</span></td>
  </tr>
   <tr>
    <td scope="row" nowrap width="20%">设备型号</td>
    <td scope="row" nowrap width="30%"><input name="machine_type"></td>
    <td scope="row" nowrap width="20%"></td>
    <td scope="row" nowrap width="30%"></td>
  </tr>
 
  <tr>
  <td>GPS车载终端型号(序列号) </td>
   <td><input name="gps_index_type" type="text" ></td>
  <td>GPS车载终端型号(版本号) </td>
   <td><input name="gps_terminal_type" type="text" ></td>
   </tr>
   <tr>
    <td>安装日期</td>
   <td><input name="install_date" type="text"  readonly><img  onClick="openCalendar(install_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
   <td>融资期限(月数)</td>
   <td><input name="lease_term" type="text"  readonly></td>
  </tr>
  <tr>
  <td>车载分组 </td>
   <td><select name="car_group">
        <script>w(mSetOpt('CCFL组',"CCFL组|LSHM|Hap Seng|CMB"));</script>
        </select></td>
    <td>开通服务日期</td>
   <td><input name="service_begindate" type="text"  ><img  onClick="openCalendar(service_begindate);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
  <tr>
  <td>开通服务截止日期 </td>
   <td><input name="service_enddate" type="text" ><img  onClick="openCalendar(service_enddate);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
    <td>续费服务截止日期1</td>
   <td><input name="renewals_enddate1" type="text" ><img  onClick="openCalendar(renewals_enddate1);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
  <tr>
  <td>续费服务截止日期2 </td>
   <td><input name="renewals_enddate2" type="text" ><img  onClick="openCalendar(renewals_enddate2);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
    <td>定位测试</td>
   <td><input name="location_test" type="text" ></td>
  </tr>
  <tr>
  <td>远程控制测试 </td>
   <td><input name="remote_Control_test" type="text" ></td>
    <td>安装时的ACC统计</td>
   <td><input name="acc_statistics" type="text" ></td>
  </tr>
  <tr>
  <td>巡检状态</td>
   <td><input name="polling_state" type="text" ></td>
    <td>第一次请款时间</td>
   <td><input name="billable_date1" type="text" ><img  onClick="openCalendar(billable_date1);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
  <tr>
  <td>第二次请款时间 </td>
   <td><input name="billable_date2" type="text" ><img  onClick="openCalendar(billable_date2);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
    <td>第三次请款时间</td>
   <td><input name="billable_date3" type="text" ><img  onClick="openCalendar(billable_date3);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
  <tr>
  <td>断油断电记录 </td>
   <td><input name="stop_record" type="text" ></td>
    <td>断油断点原因</td>
   <td><input name="stop_reason" type="text" ></td>
  </tr>
  <tr>
  <td>解除断油断电记录</td>
   <td><input name="relief_record" type="text" ></td>
    <td>后期GPS是否正常</td>
   <td><select name="gps_right">
        <script>w(mSetOpt('是',"否|是"));</script>
        </select></td>
  </tr>
  <tr>
  <td>拆除否</td>
   <td><select name="dismantle">
        <script>w(mSetOpt('否',"否|是"));</script>
        </select></td>
    <td>拆除日期</td>
   <td><input name="dismantle_date" type="text" ><img  onClick="openCalendar(dismantle_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
  <tr>
  <td>备注</td>
    <td><textarea name="remark" rows="4" maxB="200"></textarea></td>
    <td>   </td>
   <td>   </td>
  </tr>
</table>


</div>
</div>

    </form>
</body>
</html>
