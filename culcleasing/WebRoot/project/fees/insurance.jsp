<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
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
if (right.CheckRight("insurance-fees-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>������Ϣ - ���շ���ά��</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>
<%
	String czid = getStr( request.getParameter("czid") );
	String sqlstr = "select dbo.FK_GETNAME(insurer) insurer,fees_way,note,insurance_type from insurance_fees where insurance_fees='" + czid + "'"; 
	ResultSet rs = db.executeQuery(sqlstr); 

	String	insurer = "";
	String	fees_way = "";
	String	note = "";
	String insurance_type="";

	if ( rs.next() ) {
		insurance_type = getDBStr( rs.getString("insurance_type") );
		insurer = getDBStr( rs.getString("insurer") );
		fees_way = getDBStr( rs.getString("fees_way") );
		note = getDBStr( rs.getString("note") );
	}
	rs.close(); 
	db.close();
%>
<body onLoad="fun_winMax();">

<form name="form1" method="post" action="insurance_save.jsp" onSubmit="return checkdata(this);">	
<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
���۹��� &gt; ���շѼ���ά��
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
		<td><a href="insurance_update.jsp?czid=<%= czid %>"  accesskey="m" title="�޸�(Alt+M)" class="fontcolor">
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
    <td>���չ�˾</td>
    <td><%= insurer %></td>
    <td>���㷽��</td>
    <td>
    <%String fees_way_show="";
	if("1".equals(fees_way)){
		fees_way_show="��ƽ�����ռ��㷽��";
	}else if("2".equals(fees_way)){
		fees_way_show="ƽ�����ռ��㷽��";
	}else if("3".equals(fees_way)){
		fees_way_show="ƽ�����ռ��㷽��(�����걣��)";
	}
	%>
	<%= fees_way_show %></td>
     </tr>
    <tr> 
	<td>����</td>
    <td colspan="3"><%= insurance_type%></td>
    <td>��ע</td>
    <td colspan="3"><%= note%></td>
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
<!--���ӽ���-->

<!--����ѡ�񿨺�����iframe�ĸ߶���Ӧ����-->
<script language="javascript">

</script>
</form>
<!-- end cwMain -->
</body>
</html>