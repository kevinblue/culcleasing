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
if (right.CheckRight("gps-tzxj-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>GPSѲ��- GPS����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>
<%
	String id = getStr( request.getParameter("id") );
	String sqlstr = "select * from vi_tzexamine_info where tzpolling_id='" + id + "'"; //SQL��ѯ���
	System.out.println(sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 
	String tzpolling_id="";
	String polling_date="";
	String right_num="";
	String fall_num="";
	String import_date="";
	String importer="";

	if ( rs.next() ) {
		tzpolling_id=getDBStr( rs.getString("tzpolling_id") );
		polling_date=getDBDateStr( rs.getString("polling_date") );
		right_num=getDBStr( rs.getString("right_num") );
		fall_num=getDBStr( rs.getString("fall_num") );
		import_date=getDBDateStr( rs.getString("import_date") );
		importer=getDBStr( rs.getString("importer") );		
	}
	rs.close(); 
	db.close();
%>
<body onLoad="setDivHeight('divH',-55);fun_winMax();">
<form name="form1" method="post" action="gps_tzxj_save.jsp" onSubmit="return checkdata(this);">	

<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
Ѳ�챨��
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
		<td><a href="gps_tzxj_mod.jsp?id=<%= id %>"  accesskey="m" title="�޸�(Alt+M)" class="fontcolor">
		<img src="../../images/sbtn_mod.gif" width="19" height="19" align="absmiddle" >�޸�</a></td>
		<td><a href="#" onClick="window.close();;opener.location.reload();"  accesskey="m" title="�ر�" class="fontcolor">
		<img src="../../images/sbtn_close.gif" width="19" height="19" align="absmiddle" >�ر�</a></td>
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
    <td scope="row" nowrap width="20%">Ѳ�챨��id��</td>
    <td><%= tzpolling_id %></td>

    <td scope="row" nowrap width="20%">Ѳ�����ڣ�</td>
    <td><%= polling_date %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">��������:  </td>
    <td><%= right_num %></td>
    <td scope="row" nowrap width="20%">Ѳ��ʧ�ܳ���:  </td>
    <td><%= fall_num %></td>
  </tr>
   <tr>
    <td scope="row" nowrap width="20%">�������ڣ�</td>
    <td><%= import_date %></td>

    <td scope="row" nowrap width="20%">�����ˣ�</td>
    <td><%=importer%></td>
  </tr>
</table>
<br>
<div style="text-align:left;width:98%">
<table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_s_tab_0" class="Form_tab" width=100 align=center onClick="chgTabSub()"  valign="middle">Ѳ����ϸ����</td>
 </tr>
 </table>
<table border="0" cellspacing="0" cellpadding="0" width="100%"><tr><td bgcolor="#8DB2E3" width="100%"><img height="1" width="1"></td></tr></table>
<div id="TD_s_tab_0">
<iframe style="funny:expression(autoResize())" id="UserBody0" frameborder="0" width="100%" src="../gps_tzxjmx/gps_tzxjmx_list.jsp?tzpolling_id=<%=tzpolling_id%>" align="center"></iframe>
</div>
</div>




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
ShowTabN(0);
ShowTabSub(0);
reinitIframe();
//�ⲿdiv�߶�����Ӧ
function reinitIframe(){
var divH = document.getElementById("divH");
var reinitIframe_resize=function(){
divH.style.height=window.document.body.clientHeight-100;
}
reinitIframe_resize();
window.onresize=reinitIframe_resize;
}
//�ڲ�Iframe�߶�����Ӧ
function autoResize()
{
	try
	{
		document.all["UserBody0"].style.height=UserBody0.document.body.scrollHeight
	}
	catch(e)
	{}
}
</script>
</form>
<!-- end cwMain -->
</body>
</html>
