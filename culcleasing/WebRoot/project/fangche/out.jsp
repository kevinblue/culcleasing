<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("project-fangche-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>������Ϣ - �ų�����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>
<%
	String czid = getStr( request.getParameter("czid") );
	String sqlstr = "select info.contract_id,equip.id,info.proj_id,dbo.getcustname(info.cust_id) as cust_name,dbo.GETmodelbyid(equip.device_type) as model,equip.equip_sn,equip.out_time,dbo.getusername(equip.out_people) as out_people,dbo.fk_getname(stock_place) as stock_place from contract_info info left join contract_equip equip on(info.contract_id=equip.contract_id) where info.contract_id='" + czid + "'"; 
	System.out.println("test"+sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 

	String	proj_id = "";
	String	cust_name = "";
	String	model = "";
	String	equip_sn = "";
	String	out_time = "";
	String	out_people = "";
String	stock_place = "";

	if ( rs.next() ) {
		stock_place = getDBStr( rs.getString("stock_place") );
		proj_id = getDBStr( rs.getString("proj_id") );
		cust_name = getDBStr( rs.getString("cust_name") );
		model = getDBStr( rs.getString("model") );
		equip_sn = getDBStr( rs.getString("equip_sn") );
		out_time = getDBDateStr( rs.getString("out_time") );
		out_people = getDBStr( rs.getString("out_people") );
	}
	rs.close(); 
	db.close();
%>
<body onLoad="fun_winMax();">

<form name="form1" method="post" action="out_save.jsp" onSubmit="return checkdata(this);">	
<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
���۹��� &gt; �ų�����
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--������ť��ʼ-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
		<td><a href="out_add.jsp?czid=<%= czid %>"  accesskey="m" title="����(Alt+M)" class="fontcolor">
		<img src="../../images/sbtn_mod.gif" width="19" height="19" align="absmiddle" >�޸�</a>
	  	<BUTTON class="btn_2" name="btnReset" value="ȡ��" onClick="window.close();">
		<img src="../../images/hg.gif" align="absmiddle" border="0">ȡ��</button></td>
	  </tr>
</table>
<!--������ť����-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">�� ϸ</td>
  
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
    <td>��Ŀ���</td>
    <td><input name="proj_id" type="text" value="<%= czid %>" size="20" maxB="50" readonly ></td>
    <td>�ͻ�����</td>
    <td><input name="cust_id" type="text" value="<%= cust_name %>" size="20" maxB="50" readonly></td>
     </tr>
     <tr>
    <td>�豸����</td>
    <td><input name="model" type="text" size="20" value="<%= model %>" maxB="50" readonly></td>
    <td>�����</td>
    <td><input name="equip_sn" type="text" size="20" value="<%= equip_sn %>" maxB="50" readonly></td>
     </tr>
    <tr>
    <td>���</td>
    <td><input name="stock_place" type="text" value="<%= stock_place %>" size="20" maxB="50" readonly></td>
    <td>�ų�ʱ��</td>
    <td><input name="out_time" type="text" value="<%= out_time %>" size="15" readonly maxlength="10" dataType="Date" Require="ture"></td>
  </tr>
    <td>ά��Ա</td>
    <td><input name="out_people" type="text" value="<%= out_people %>" size="20" maxB="50" readonly></td>
    <td></td>
    <td></td>
  <tr>
  </tr>
</table>
<br>

<div id="TD_tab_1" style="display:none;"> 
  ѡ���е�����2
</div>
<div id="TD_tab_2" style="display:none;"> 
  ѡ���е�����3

ѡ���п��ܰ����������ݣ�


ע��HTMLBody������ѡ���е����ݣ������Ҫ�����ó����������

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
<!--��ӽ���-->

<!--����ѡ�񿨺�����iframe�ĸ߶���Ӧ����-->
<script language="javascript">

</script>
</form>
<!-- end cwMain -->
</body>
</html>
