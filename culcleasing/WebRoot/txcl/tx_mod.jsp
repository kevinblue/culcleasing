<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common_simple.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��Ϣ���� - �޸ĵ�Ϣ��¼</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>

<body onload="fun_winMax();">
<form name="form1" method="post" action="tx_save.jsp" onSubmit="return Validator.Validate(this,3);">
<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
��Ϣ���� &gt; �޸ĵ�Ϣ��¼
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
	    	
<BUTTON class="btn_2" name="btnSave" value="����"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">����</button>
<BUTTON class="btn_2" name="btnReset" value="ȡ��" onclick="window.close();">
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">�޸���Ϣ</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<%
String dqczy=(String) session.getAttribute("czyid");
//--------����ΪȨ�޿���-----------------------------

	String czid = getStr( request.getParameter("czid") );
	String sqlstr = "select base_adjust_interest.* from base_adjust_interest where base_adjust_interest.id='" + czid + "'"; 
	//System.out.println("sqlstr======================"+sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 

	String	base_rate = "";
	String	base_adjust_rate = "";
	String	base_date = "";
	String	start_date = "";
	String	rate_limit = "";
	String	adjust_flag = "";
	String	yh_adjust_rate = "";
	String	nx = "";

	if ( rs.next() ) {
		base_rate = getDBStr( rs.getString("base_rate") );
		base_adjust_rate = getDBStr( rs.getString("base_adjust_rate") );
		base_date = getDBDateStr( rs.getString("base_date") );
		start_date = getDBDateStr( rs.getString("start_date") );
		rate_limit = getDBStr( rs.getString("rate_limit") );
		adjust_flag = getDBStr( rs.getString("adjust_flag") );
		yh_adjust_rate = getDBStr( rs.getString("yh_adjust_rate") );
		nx = getDBStr( rs.getString("nx") );
	}
	rs.close(); 
	db.close();
%>


<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="czid" value="<%= czid %>">
<table class="tab_table_title" border="0" cellspacing="0" cellpadding="0" width="100%">
  <tr>
    <td>���л�������</td>
    <td><input name="base_rate" value="<%=base_rate %>" type="text" size="10" maxB="50" dataType="Rate" Require="true">%
	<span class="biTian">*</span></td>
	<td>���޹�˾��������</td>
    <td><input name="base_adjust_rate" value="<%=base_adjust_rate %>" type="text" size="10" maxB="50" dataType="Rate" Require="true">%
	<span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>�������ʵ�������</td>
    <td><input name="base_date" value="<%=base_date %>" type="text" size="10" readonly maxlength="10" dataType="Date" Require="ture"> <img  onClick="openCalendar(base_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	<span class="biTian">*</span></td>
	<td>ϵͳ�����ִ������</td>
    <td><input name="start_date" value="<%=start_date %>" type="text" size="10" readonly maxlength="10" dataType="Date" Require="ture"> <img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	<span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>���е���������</td>
    <td><input name="yh_adjust_rate" value="<%=yh_adjust_rate %>" type="text" size="10" maxB="50" dataType="Rate" Require="true">%
	<span class="biTian">*</span></td>
    <td>����</td>
    <td><input name="nx" value="<%=nx %>" type="text" size="10" maxB="50" dataType="Rate" Require="true">
	<span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>���ʲ�����</td>
    <td><input name="rate_limit" value="<%=rate_limit %>" type="text" size="10" maxB="50" dataType="Rate" Require="true">%
	<span class="biTian">*</span></td>
	<td>�Ƿ��Ϣ��</td>
	<td><select name="adjust_flag"><script>w(mSetOpt("<%=adjust_flag %>",'��|��'));</script></select></td>
  </tr>
 
</table>

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
