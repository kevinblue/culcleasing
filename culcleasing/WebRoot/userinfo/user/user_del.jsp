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
if (right.CheckRight("ywygl-ywygl-del",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>ҵ��Ա���� - ҵ��Ա��Ϣά��</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script src="/dict/js/js_dictionary.js"></script>
</head>



<body onLoad="fun_winMax();">
<form name="form1" method="post" action="user_save.jsp" onSubmit="return Validator.Validate(this,3);">
<%

if ((dqczy==null) || (dqczy.equals("")))
{
	dqczy="����֤";
}
int canmod=0;


	String id = getStr( request.getParameter("id") );
	String sqlstr = "select manage_id, dbo.FK_GETCOMPNAME(compid) compname, manage_name, manage_phone, overArea from userInfo where manage_id='"+id+"'"; 
	ResultSet rs = db.executeQuery(sqlstr); 
	String	compname = "";
	String	manage_id = "";
	String	manage_name = "";
	String	manage_phone = "";
	String	overArea = "";

	if ( rs.next() ) {
		manage_id = getDBStr( rs.getString("manage_id") );
		compname = getDBStr( rs.getString("compname") );
		manage_name = getDBStr( rs.getString("manage_name") );
		manage_phone = getDBStr( rs.getString("manage_phone") );
		overArea = getDBStr( rs.getString("overArea") );
	}
	rs.close(); 
	db.close();
%>
<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
ҵ��Ա���� &gt; ҵ��Ա��Ϣά��
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
	    <td>
		<BUTTON class="btn_2" name="btnSave" value="ɾ��"  type="submit" >
<img src="../../images/sbtn_del.gif" align="absmiddle" border="0">ɾ��</button>
	  	<BUTTON class="btn_2" name="btnReset" value="ȡ��" onClick="window.close();">
		<img src="../../images/hg.gif" align="absmiddle" border="0">ȡ��</button>
		</td>
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">�޸���Ϣ</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<input type="hidden" name="savetype" value="del">
<input type="hidden" name="manage_id" value="<%= id %>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
  	<td align="right">������</td>
    <td><%= manage_name %></td>
  </tr>
  <tr>
  	<td align="right">�����ֹ�˾��</td>
    <td><%= compname %></td>
  </tr>
  <tr>
  	<td align="right">�ֻ���</td>
    <td><%= manage_phone %></td>
  </tr>
  <tr>
  	<td align="right">��������</td>
  	<td><%= overArea %></td>
  </tr>
</table>
</div>
</div>
</center>
<!--��ӽ���-->

<!--����ѡ�񿨺�����iframe�ĸ߶���Ӧ����-->
<script language="javascript">

//�ڲ�Iframe�߶�����Ӧ
//function autoResize()
//{
//	try
//	{
//		document.all["UserBody1"].style.height=UserBody1.document.body.scrollHeight
//	}
//	catch(e)
//	{}
//}
</script>
</form>
<!-- end cwMain -->
</body>
</html>
