<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ͬ��Ϣ - ��Ʊ����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("htxx-fpgl-del",dqczy)>0) canedit=1;
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
	String sqlstr = "select contract_equip_invoice.*,vi_contract_info.cust_name,vi_open_contract.contract_name from contract_equip_invoice left join vi_contract_info on contract_equip_invoice.contract_id=vi_contract_info.contract_id left join vi_open_contract on contract_equip_invoice.contract_id=vi_open_contract.contract_id where contract_equip_invoice.id='" + czid + "'"; 
	//System.out.println("sqlstr======================"+sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 

	String	contract_id = "";
	String	contract_name = "";
	String	invoice_number = "";
	String	invoice_date = "";
	String	invoice_amt = "";
	String	all_flag = "";


	if ( rs.next() ) {
		contract_id = getDBStr( rs.getString("contract_id") );
		contract_name = getDBStr( rs.getString("contract_name") );
		invoice_number = getDBStr( rs.getString("invoice_number") );
		invoice_date = getDBDateStr( rs.getString("invoice_date") );
		invoice_amt = formatNumberStr(getDBStr( rs.getString("invoice_amt") ),"#,##0.00");
		all_flag = getDBStr( rs.getString("all_flag") );
	}
	rs.close(); 
	db.close();
%>
<body onload="fun_winMax();">

<form name="form1" method="post" action="fpgl_save.jsp" onSubmit="return checkdata(this);">	
<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
��Ʊ������ϸ
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">�� ϸ</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<input type="hidden" name="savetype" value="del">
<input type="hidden" name="czid" value="<%= czid %>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td scope="row" nowrap width="20%">��ͬ��ţ�</td>
    <td><%=contract_id %></td>

    <td scope="row" nowrap width="20%">��Ʊ�ţ�</td>
    <td><%=invoice_number %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">��Ʊ���ڣ�</td>
    <td><%=invoice_date %></td>

    <td scope="row" nowrap width="20%">��Ʊ��</td>
    <td><%=invoice_amt %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">�Ƿ����յ�ȫ�Ʊ��</td>
    <td colspan="3"><%=all_flag %></td>
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
</script>
</form>
<!-- end cwMain -->
</body>
</html>