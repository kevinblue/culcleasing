<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>GPSѲ�챨����ϸ�޸� -GPS����</title>
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
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("gps-tzxj-mod",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>


<body>


<form name="form1" method="post" action="gps_tzxjmx_save.jsp" onSubmit="">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
 GPS���� &gt; GPSѲ�챨����ϸ�޸�
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
<%
String id = getStr( request.getParameter("id") );
String tzpolling_id = "";
String gpstpye="";
String cai_no="";
String sim_no = "";
String import_date="";
String province = "";
String city = "";
String address="";
String state = "";
String cusname = "";
String branch_company = "";
ResultSet rs;
String sqlstr = "select * from vi_tzexamine_details where tzexamine_details='" + id + "'"; 
rs = db.executeQuery(sqlstr); 
if (rs.next()){
  tzpolling_id = getDBStr( rs.getString("tzpolling_id") );
  gpstpye = getDBStr( rs.getString("gpstpye") );	
  cai_no = getDBStr( rs.getString("cai_no") );
  sim_no = getDBStr( rs.getString("sim_no") );	
  import_date = getDBDateStr( rs.getString("import_date") );		
  province = getDBStr( rs.getString("province") );
  city = getDBStr( rs.getString("city") );
  state = getDBStr( rs.getString("state") );
  cusname = getDBStr( rs.getString("cusname") );
  branch_company = getDBStr( rs.getString("branch_company") );
}
rs.close();
//���¶���ʡ������
/*sqlstr="selcet  , ,   from   ";
rs = db.executeQuery(sqlstr); 
if (rs.next()){
	//������������
}
rs.close();*/
db.close();
%>
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="id" value="<%=id %>">
<input type="hidden" name="tzpolling_id" value="<%=tzpolling_id%>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
  <td>SIM����</td>
   <td><input name="sim_no" type="text"  value="<%=sim_no%>" readonly></td>
   <td>�ͻ�����</td>
   <td><input name="cusname" type="text"  value="<%=cusname%>" readonly></td>	
  </tr>
    <tr>  
    <td>�ֹ�˾</td>
   <td><input name="branch_company" type="text"  value="<%=branch_company%>" readonly></td>
   <td scope="row">GPS�ͺ�</td>
	<td><input name="gpstpye" type="text"  value="<%=gpstpye%>"></td>
  </tr>
  <tr>
   <td>���ƺ�</td>
  <td><input name="cai_no" type="text"  value="<%=cai_no%>"></td>
    <td>Ѳ������</td>
   <td><input name="import_date" type="text"  value="<%=import_date%>"><img  onClick="openCalendar(import_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
  <tr>
  <td>ʡ </td>
   <td><input type="text" name="province"  Require="ture" value="<%=province%>"><!--<input type="hidden" name="province" value="" onPropertychange="form1.csdata.value='';form1.city.value='';"> <img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','ʡ��','jb_ssxx','sfmc','id','sfmc','sfmc','asc','form1.sfdata','form1.province');">--></td>
    <td>��</td>
   <td><input type="text" name="city" readonly Require="ture" value="<%=city%>"><!--<input type="hidden" name="city" value="" > <img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('form1.province','ʡ��','sfid','string','����','jb_csxx','csmc','id','csmc','csmc','asc','form1.csdata','form1.city');">--></td>
  </tr>
  <tr>
  <td>�� </td>
   <td><input name="address" type="text"  value="<%=address%>"></td>
    <td>״̬</td>
   <td><select name="state">
        <script>w(mSetOpt('<%=state%>',"����|�ػ�"));</script>
        </select></td>
  </tr>
</table>
</div>
</div>

    </form>
</body>
</html>
