<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ʲ�����-���չ���</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>

</head>

<% 
	String id = getStr( request.getParameter("id"));
	System.out.println(id+"**");

	String sqlstr = "select*,dengjiren=dbo.GETUSERNAME(contract_insurance.creator),xiugairen=dbo.GETUSERNAME(contract_insurance.modificator) from contract_insurance left join contract_info on contract_insurance.contract_id=contract_info.contract_id where id='"+id+"'"; 
	ResultSet rs = db.executeQuery(sqlstr);
	System.out.println("sqlstr="+sqlstr);
	String contract_id="";
    String colleaction_date="";
	String insurance_type="";
	String payments="";
	String pay_date="";
	String buy_insuranceself="";
	String period_insurance="";
	String insurance_id="";
	String insurance_my="";
	String proj_id="";
	String cust_id="";
	String cust_name="";
	String project_name="";
	String out_dept="";
	String creator="";
	String create_date="";
	String modificator="";
	String modify_date="";
	if(rs.next()){
	 creator=getDBStr(rs.getString("dengjiren"));
	 create_date=getDBStr(rs.getString("create_date"));
	 modificator=getDBStr(rs.getString("xiugairen"));
	 modify_date=getDBStr(rs.getString("modify_date"));
	
	
	 out_dept=getDBStr(rs.getString("out_dept"));
	 project_name=getDBStr(rs.getString("project_name"));
	 cust_name=getDBStr(rs.getString("cust_name"));
	 cust_id=getDBStr(rs.getString("cust_id"));
	 proj_id=getDBStr(rs.getString("proj_id"));
	 contract_id=getDBStr(rs.getString("contract_id"));
	   insurance_my=getDBStr(rs.getString("insurance_my"));
		insurance_id=getDBStr(rs.getString("insurance_id"));
		buy_insuranceself=getDBStr(rs.getString("buy_insuranceself"));
		period_insurance=getDBStr(rs.getString("period_insurance"));
		colleaction_date=getDBStr(rs.getString("colleaction_date"));
	    insurance_type=getDBStr(rs.getString("insurance_type"));
	    pay_date=getDBStr(rs.getString("pay_date"));
	    payments=getDBStr(rs.getString("payments"));
	}
	rs.close(); 
	db.close();
%>

<body onLoad="public_onload(12)">
<form name="form1" method="post" action="bx_save.jsp" onSubmit="return checkdata(this);">	

<div id=bgDiv>

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
�ʲ�����&gt; ������ϸ
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
		<td><a href="bx_mod.jsp?id=<%= id %>"  accesskey="m" title="�޸�(Alt+M)" class="fontcolor">
		<img src="../../images/btn_edit.gif" align="absmiddle" >�޸�</a></td>
	  	<td>&nbsp;&nbsp;<a href="#" onClick="window.close();;opener.location.reload();"  accesskey="m" title="�ر�" class="fontcolor">
		<img src="../../images/quit.gif" align="absmiddle" >�ر�</a></td>
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

<div id="mydiv" class="linetype" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
	<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
	 <tr>
	 <td>��ͬ���</td>
	 <td><%=contract_id %></td>
	  <td width="130px">�Ƿ��Ƿ���˾������</td>
	    <td><%=insurance_my %></td>
	 </tr>
	  <tr>
	   <td width="130px">��������</td>
	    <td><%=period_insurance %></td>
	   <td>��˾��ȡ���ڣ�</td>
	    <td><%=getDBDateStr(colleaction_date)%></td>
	  </tr>
	  <tr>
	     <td>���֣�</td>
	    <td><%=insurance_type %></td>
	    <td width="130px">֧�����չ�˾����</td>
	    <td><%=getDBDateStr(pay_date) %></td>
	  </tr>
	  <tr>
		<td>֧����</td>
	    <td><%=formatNumberDoubleTwo(payments)%></td>
	     <td width="130px">���յ���</td>
	    <td><%=insurance_id %></td>
	  </tr>
	  
	</table>
<br>
<div style="text-align:left;width:98%">


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

</form>
<!-- end cwMain -->
<script language="javascript">
ShowTabN(0);
</script>
</body>
</html>
