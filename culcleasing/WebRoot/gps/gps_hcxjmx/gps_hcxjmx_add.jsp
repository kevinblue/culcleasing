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
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("gps-hcxj-add",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>GPS���� - GPSѲ�챨����ϸ���</title>
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
String hcpolling_id=getStr( request.getParameter("id") );
%>
<form name="form1" method="post" action="gps_hcxjmx_save.jsp" onSubmit="return Validator.Validate(this,3);">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
GPS���� &gt; GPSѲ�챨����ϸ��� 
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--������ť��ʼ-->
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	
<BUTTON class="btn_2" name="btnSave" value="����"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">����</button>
<BUTTON class="btn_2" name="btnReset" value="ȡ��" onClick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">ȡ��</button>
    </td></tr>
</table>
<!--������ť����-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">�� ��</td>
  
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
<input type="hidden" name="hcpolling_id" value="<%=hcpolling_id%>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
  <td>SIM����</td>
   <td><input name="sim_no" type="text" readonly><img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','SIM����',  'vi_sim_no','sim_no','service_begindate|service_enddate','sim_no','sim_no','asc','form1.sim_no','form1.online_time|form1.services_endtime');"></td>
  <td>���ƺ�</td>
  <td><input name="cai_no" type="text"  ></td>  
  </tr>
  <tr>
  <td>������</td>
   <td><input name="agents" type="text"  ></td>
   <td>Ѳ������</td>
   <td><input name="polling_date" type="text"  readonly Require="true"><img  onClick="openCalendar(polling_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span></td>
  </tr>
  <tr>
  <td>����</td>
   <td><input name="longitude" type="text"  ></td>
    <td>γ��</td>
   <td><input name="latitude" type="text"  ></td>
  </tr>
  <tr>
  <td>�ٶ� </td>
   <td><input name="speed" type="text"  ></td>
    <td>�ۼƹ���Сʱ��</td>
   <td><input name="worktime" type="text"  dateType="Number"></td>
  </tr>
  <td>״̬ </td>
   <td><select name="state">
        <script>w(mSetOpt('����',"����|�ػ�"));</script>
        </select></td>
    <td>����״̬</td>
   <td><select name="lock_state">
        <script>w(mSetOpt('����',"����|δ��"));</script>
        </select></td>
  </tr>
   <td>�ٶ� </td>
   <td><input name="speed" type="text"  ></td>
    <td>��λ״̬</td>
   <td><select name="fixed_state">
        <script>w(mSetOpt('��Ч',"��Ч|��Ч"));</script>
        </select></td>
  </tr>
   <td>����ʱ�� </td>
   <td><input name="online_time" type="text"  readonly ></td>
    <td>�����ֹʱ��</td>
   <td><input name="services_endtime" type="text"  readonly></td>
  </tr>
</table>
</div>
</div>

    </form>
</body>
</html>
