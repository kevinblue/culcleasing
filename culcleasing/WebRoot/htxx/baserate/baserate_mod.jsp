<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>������Ϣ - ���л�׼����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>



<body onload="fun_winMax();">
<form name="form1" method="post" action="baserate_save.jsp" onSubmit="return Validator.Validate(this,3);">
<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
������Ϣ &gt; ���л�׼����
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
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("htxx-baserate-mod",dqczy)>0) canedit=1;
%>
<script>
if (<%=canedit%>==0){
	window.close();
	opener.alert("��û�в���Ȩ�ޣ�");
}

</script>
<%
//--------����ΪȨ�޿���-----------------------------


	String czid = getStr( request.getParameter("czid") );
	
	String sqlstr = "select fund_standard_interest.id,fund_standard_interest.start_date,fund_standard_interest.rate_half,fund_standard_interest.rate_one,fund_standard_interest.rate_three,fund_standard_interest.rate_five,fund_standard_interest.rate_abovefive,fund_standard_interest.base_rate_half,fund_standard_interest.base_rate_one,fund_standard_interest.base_rate_three,fund_standard_interest.base_rate_five,fund_standard_interest.base_rate_abovefive from fund_standard_interest where fund_standard_interest.id='"+czid+"'"; 
	//System.out.println("sqlstr======================"+sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 

	String	start_date = "";
	String	rate_half = "";
	String	rate_one = "";
	String	rate_three = "";
	String	rate_five = "";
	
	String	rate_abovefive = "";
	String	base_rate_half = "";
	String	base_rate_one = "";
	String	base_rate_three = "";
	String	base_rate_five = "";
	String	base_rate_abovefive = "";


	if ( rs.next() ) {
		start_date = getDBDateStr( rs.getString("start_date") );
		rate_half = getDBDecStr( rs.getBigDecimal("rate_half",4) ).toString();
		rate_one = getDBDecStr( rs.getBigDecimal("rate_one",4) ).toString();
		rate_three = getDBDecStr( rs.getBigDecimal("rate_three",4) ).toString();
		rate_five = getDBDecStr( rs.getBigDecimal("rate_five",4) ).toString();
		rate_abovefive = getDBDecStr( rs.getBigDecimal("rate_abovefive",4) ).toString();
		base_rate_half = getDBDecStr( rs.getBigDecimal("base_rate_half",4) ).toString();
		base_rate_one = getDBDecStr( rs.getBigDecimal("base_rate_one",4) ).toString();
		base_rate_three = getDBDecStr( rs.getBigDecimal("base_rate_three",4) ).toString();
		base_rate_five = getDBDecStr( rs.getBigDecimal("base_rate_five",4) ).toString();
		base_rate_abovefive = getDBDecStr( rs.getBigDecimal("base_rate_abovefive",4) ).toString();
	}
	rs.close(); 
	db.close();




%>


<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="czid" value="<%= czid %>">
<table class="tab_table_title" border="0" cellspacing="0" cellpadding="0" width="100%">
  <tr>
    <td>���ʿ�ʼִ������</td>
    <td colspan="3"><input name="start_date" type="text" size="15" readonly maxlength="10" dataType="Date" Require="ture" value="<%=start_date %>"> <img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	<span class="biTian">*</span></td>

    
  </tr>
  <tr>
    <td>��Ϣ���л�׼_����</td>
    <td><input name="base_rate_half" type="text" size="20" maxB="25" Require="true" dataType="Double" value="<%=base_rate_half %>">%<span class="biTian">*</span></td>
    <td>��Ϣ��������_����</td>
    <td><input name="rate_half" type="text" size="20" maxB="25" Require="true" dataType="Double" value="<%=rate_half %>">%<span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>��Ϣ���л�׼_1��</td>
    <td><input name="base_rate_one" type="text" size="20" maxB="25" Require="true" dataType="Double" value="<%=base_rate_one %>">%<span class="biTian">*</span></td>
    <td>��Ϣ��������_1��</td>
    <td><input name="rate_one" type="text" size="20" maxB="25" Require="true" dataType="Double" value="<%=rate_one %>">%<span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>��Ϣ���л�׼_3��</td>
    <td><input name="base_rate_three" type="text" size="20" maxB="25" Require="true" dataType="Double" value="<%=base_rate_three %>">%<span class="biTian">*</span></td>
    <td>��Ϣ��������_3��</td>
    <td><input name="rate_three" type="text" size="20" maxB="25" Require="true" dataType="Double" value="<%=rate_three %>">%<span class="biTian">*</span></td>
  </tr>
  
  <tr>
    <td>��Ϣ���л�׼_5��</td>
    <td><input name="base_rate_five" type="text" size="20" maxB="25" Require="true" dataType="Double" value="<%=base_rate_five %>">%<span class="biTian">*</span></td>
    <td>��Ϣ��������_5��</td>
    <td><input name="rate_five" type="text" size="20" maxB="25" Require="true" dataType="Double" value="<%=rate_five %>">%<span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>��Ϣ���л�׼_5������</td>
    <td><input name="base_rate_abovefive" type="text" size="20" maxB="25" Require="true" dataType="Double" value="<%=base_rate_abovefive %>">%<span class="biTian">*</span></td>
    <td>��Ϣ��������_5������</td>
    <td><input name="rate_abovefive" type="text" size="20" maxB="25" Require="true" dataType="Double" value="<%=rate_abovefive %>">%<span class="biTian">*</span></td>
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
