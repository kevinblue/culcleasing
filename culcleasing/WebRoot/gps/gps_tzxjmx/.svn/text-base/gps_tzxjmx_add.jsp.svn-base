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
if (right.CheckRight("gps-tzxj-add",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>GPS管理 - GPS巡检报告明细添加</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>
<body>
<%
String tzpolling_id=getStr( request.getParameter("id") );
%>
<form name="form1" method="post" action="gps_tzxjmx_save.jsp" onSubmit="">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
GPS管理 &gt; GPS巡检报告明细添加 
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
<input type="hidden" name="tzpolling_id" value="<%=tzpolling_id%>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
  <td>SIM卡号</td>
   <td><input name="sim_no" type="text" readonly Require="true"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','SIM卡号',  'vi_sim_no','sim_no','cust_name|cust_id|sale_id|sale_name','sim_no','sim_no','asc','form1.sim_no','form1.cusname|form1.cust_id|form1.sale_id|form1.sale_name');"><span class="biTian">*</span></td>
   <td>客户名称</td>
   <td><input name="cusname" type="text" readonly><input name="cust_id" type="hidden"></td>	
  </tr>
    <tr>  
    <td>分公司</td>
   <td><input name="sale_name" type="text" readonly><input name="sale_id" type="hidden"></td>
   <td scope="row">GPS型号</td>
	<td><input name="gpstpye" type="text"  ></td>
  </tr>
  <tr>
  <td>车牌号</td>
  <td><input name="cai_no" type="text"  ></td>
    <td>巡检日期</td>
   <td><input name="import_date" type="text"  ><img  onClick="openCalendar(import_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
  <tr>
  <td>省 </td>
   <td><input type="text" name="province"  Require="ture" value=""><!--<input type="hidden" name="province" value="" onPropertychange="form1.csdata.value='';form1.city.value='';"> <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','省份','jb_ssxx','sfmc','id','sfmc','sfmc','asc','form1.sfdata','form1.province');">--></td>
    <td>市</td>
   <td><input type="text" name="city"  Require="ture" value=""><!--<input type="hidden" name="city" value="" > <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('form1.province','省份','sfid','string','城市','jb_csxx','csmc','id','csmc','csmc','asc','form1.csdata','form1.city');">--></td>
  </tr>
  <tr>
  <td>区 </td>
   <td><input name="address" type="text" ></td>
    <td>状态</td>
   <td><select name="state">
        <script>w(mSetOpt('关机',"开机|关机"));</script>
        </select></td>
  </tr>
</table>

</div>
</div>

    </form>
</body>
</html>
