<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />  
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ͬ��Ϣ - ��ͬ����</title>
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
if (right.CheckRight("htxx-htgf-view",dqczy)>0) canedit=1;
%>
<script>
if (<%=canedit%>==0){
	window.close();
	opener.alert("��û�в���Ȩ�ޣ�");
}

</script>
<%

	String czid = getStr( request.getParameter("czid") );
	String sqlstr = "select contract_signatory.client_email, contract_signatory.contract_id, contract_signatory.lessor, vi_cust_all_info.cust_name as lessor_name, contract_signatory.leaseconsigner, contract_signatory.lease_acc_number, cust_account.bank_name as lease_bank_name, cust_account.account as lease_account, contract_signatory.client, vi_cust_all_info2.cust_name as client_name, contract_signatory.clientconsigner, contract_signatory.client_acc_number, cust_account2.bank_name as client_bank_name, cust_account2.account as client_account, contract_signatory.client_postcode, contract_signatory.client_address, contract_signatory.client_linkman, contract_signatory.client_mobile_number, contract_signatory.client_tel, contract_signatory.client_fax from contract_signatory left join vi_cust_all_info on contract_signatory.lessor=vi_cust_all_info.cust_id left join vi_cust_all_info vi_cust_all_info2 on contract_signatory.client=vi_cust_all_info2.cust_id left join cust_account on contract_signatory.lease_acc_number=cust_account.acc_number left join cust_account cust_account2 on contract_signatory.client_acc_number=cust_account2.acc_number where contract_signatory.contract_id='"+czid+"'" ; 
	//System.out.println("sqlstr======================"+sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 

	
	String	lessor = "";
	String	lessor_name = "";
	String	leaseconsigner = "";
	String	lease_acc_number = "";
	String	lease_bank_name = "";
	String	lease_account = "";
	String	client = "";
	String	client_name = "";
	String	clientconsigner = "";
	String	client_acc_number = "";
	String	client_bank_name = "";
	String	client_account = "";
	String	client_linkman = "";
	String	client_postcode = "";
	String	client_address = "";
	String	client_mobile_number = "";
	String	client_tel = "";
	String	client_fax = "";
	String	client_email = "";


	if ( rs.next() ) {
		lessor = getDBStr( rs.getString("lessor") );
		lessor_name = getDBStr( rs.getString("lessor_name") );
		leaseconsigner = getDBStr( rs.getString("leaseconsigner") );
		lease_acc_number = getDBStr( rs.getString("lease_acc_number") );
		lease_bank_name = getDBStr( rs.getString("lease_bank_name") );
		lease_account = getDBStr( rs.getString("lease_account") );
		client = getDBStr( rs.getString("client") );
		client_name = getDBStr( rs.getString("client_name") );
		clientconsigner = getDBStr( rs.getString("clientconsigner") );
		client_acc_number = getDBStr( rs.getString("client_acc_number") );
		client_bank_name = getDBStr( rs.getString("client_bank_name") );
		client_account = getDBStr( rs.getString("client_account") );
		client_linkman = getDBStr( rs.getString("client_linkman") );
		client_postcode = getDBStr( rs.getString("client_postcode") );
		client_address = getDBStr( rs.getString("client_address") );
		client_mobile_number = getDBStr( rs.getString("client_mobile_number") );
		client_tel = getDBStr( rs.getString("client_tel") );
		client_fax = getDBStr( rs.getString("client_fax") );
		client_email = getDBStr( rs.getString("client_email") );
	}
	rs.close(); 
	db.close();
%>
<body onload="fun_winMax();">

<form name="form1" method="post" action="htgf_save.jsp" onSubmit="return checkdata(this);">	
<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
��ͬ������ϸ
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
		<%
    		if (right.CheckRight("htxx-htgf-mod",dqczy)>0){
    	 %>
		<a href="htgf_mod.jsp?czid=<%= czid %>"  accesskey="m" title="�޸�(Alt+M)" class="fontcolor">
		<img src="../../images/sbtn_mod.gif" width="19" height="19" align="absmiddle" >�޸�</a>
		<%} %>
	  	<BUTTON class="btn_2" name="btnReset" value="ȡ��" onclick="window.close();">
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
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td scope="row" nowrap width="20%">��ͬ��ţ�</td>
    <td><%=czid %></td>
    <td scope="row" nowrap width="20%">�׷���</td>
    <td><%=lessor_name %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">ί�д����ˣ��׷�����</td>
    <td><%=leaseconsigner %></td>
	<td scope="row" nowrap width="20%">�����ʺţ��׷�����</td>
    <td><%=lease_acc_number %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">�������У��׷�����</td>
    <td><%=lease_bank_name %></td>
	<td scope="row" nowrap width="20%">�����������׷�����</td>
    <td><%=lease_account %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">�ҷ���</td>
    <td><%=client_name %></td>
	<td scope="row" nowrap width="20%">ί�д����ˣ��ҷ�����</td>
    <td><%=clientconsigner %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">�����ʺţ��ҷ�����</td>
    <td><%=client_acc_number %></td>
	<td scope="row" nowrap width="20%">�������У��ҷ�����</td>
    <td><%=client_bank_name %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">�����������ҷ�����</td>
    <td><%=client_account %></td>
	<td scope="row" nowrap width="20%">������ϵ�ˣ�</td>
    <td><%=client_linkman %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">�������루�ҷ�����</td>
    <td><%=client_postcode %></td>
	<td scope="row" nowrap width="20%">��ַ���ҷ�����</td>
    <td><%=client_address %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">������ϵ�ֻ��ţ�</td>
    <td><%=client_mobile_number %></td>
	<td scope="row" nowrap width="20%">�绰���ҷ�����</td>
    <td><%=client_tel %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">���棨�ҷ�����</td>
    <td><%=client_fax %></td>
    <td scope="row" nowrap width="20%">�ҷ���ϵ��Email</td>
    <td><%=client_email %></td>
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
