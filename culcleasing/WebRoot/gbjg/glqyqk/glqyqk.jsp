<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ͻ���Ϣ���� - ��Ӧ�̹�����ҵ����֧���������ϸ��Ϣ</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>

</head>
<body>
<form name="form1" method="post" action="glqyqk_save.jsp" onSubmit="return Validator.Validate(this,3);">
<style type="text/css">
body {overflow:hidden;}
</style>
<div id=bgDiv>
	
<%String czid = getStr( request.getParameter("czid") ); %>

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
��Ӧ�̹�����ҵ����֧���������ϸ��Ϣ &gt; �ͻ���Ϣ����
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
<a href="glqyqk_mod.jsp?czid=<%= czid %>"  accesskey="m" title="�޸�(Alt+M)" class="fontcolor">
		<img src="../../images/sbtn_mod.gif" width="19" height="19" align="absmiddle" >�޸�</a>
<BUTTON class="btn_2" name="btnReset" value="ȡ��" onclick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">ȡ��</button>

    	
<!--  	
    	<a href="" class="fontcolor" type="submit" name="btnSave"><img align="absmiddle" src="../../images/save.gif" border="0" alt="����"> ����</a>
    	<a href="" class="fontcolor" type="reset"><img align="absmiddle" src="../../images/hg.gif" border="0" alt="����"> ����</a>
    	
    	<input class="btn" name="btnSave" value="����" type="submit">
    	<input class="btn" name="btnReset" value="����" type="reset">
    	-->
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">��ϸ��Ϣ</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
	dqczy="����֤";
}
int canmod=0;


	
	String sqlstr = "select * from vi_mproj_vndr_affiliatedco  where id=" + czid ; 
	ResultSet rs = db.executeQuery(sqlstr); 

	String	cust_id = "";
	String	cust_name = "";
	String	affiliatedco = "";
	String	individual_flag = "";
	String	id_number = "";
	String  relationship = "";
	String	primary_business = "";
	String  address = "";
	String  legal_representative= "";
	String  registered_capital = "";
	String  equity_ratio = "";
	String  creator = "";
	String  create_date = "";
	String  modificator = "";
	String  modify_date = "";


	if ( rs.next() ) {
		cust_id = getDBStr( rs.getString("vndr_id") );
		cust_name = getDBStr( rs.getString("vndr_name") );
		affiliatedco = getDBStr( rs.getString("affiliatedco") );
		individual_flag = getDBStr( rs.getString("individual_flag") );
		id_number = getDBStr( rs.getString("id_number") );
		relationship = getDBStr( rs.getString("relationship") );
		primary_business = getDBStr( rs.getString("primary_business") );
		address = getDBStr( rs.getString("address") );
		legal_representative = getDBStr( rs.getString("legal_representative") );
		registered_capital = getDBStr( rs.getString("registered_capital") );
		equity_ratio = getDBStr( rs.getString("equity_ratio") );
		creator = getDBStr( rs.getString("creator") );
		create_date = getDBDateStr( rs.getString("create_date") );
		modificator = getDBStr( rs.getString("modificator") );
		modify_date = getDBDateStr( rs.getString("modify_date") );

	}
	rs.close(); 
	db.close();




%>
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<input type="hidden" name="savetype" value="add">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td>��Ӧ��</td>
    <td><%=cust_name %></td>

    <td>������ҵ</td>
    <td><%=affiliatedco %></td>
  </tr>
  <tr>
    <td>����/����</td>
    <td><%=individual_flag.equals("0")?"����":"����" %></td>

    <td>��֯��������/���֤��</td>
    <td><%=id_number %></td>
  </tr>
  <tr>
  	<td>������ϵ</td>
    <td><%=relationship %></td>
    <td>��Ӫҵ��</td>
    <td><%=primary_business %></td>
  </tr>
  <tr>
    <td>��ַ</td>
    <td><%=address %></td>
  
    <td>���˴���</td>
    <td><%=legal_representative %></td>
  </tr>
  <tr>
    <td>ע���ʱ�</td>
    <td><%=registered_capital %></td>
  
    <td>�ֹɱ���</td>
    <td><%=equity_ratio %></td>
  </tr>
  <tr>
   <th>�Ǽ���</th>
    <td ><%=creator%>&nbsp;</td>
  
    <th>�Ǽ�����</th>
    <td ><%=create_date%>&nbsp;</td>
  </tr>
  <tr>
    <th>������</th>
    <td ><%=modificator%>&nbsp;</td>
  
    <th>��������</th>
    <td ><%=modify_date%>&nbsp;</td>
  </tr>
</table>
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

</form>

<!-- end cwMain -->
</body>
</html>
