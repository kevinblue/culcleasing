<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ͻ��ڲ�������ϸ��Ϣ - �ͻ���Ϣ����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>



<body>

<%String id = getStr( request.getParameter("czid") ); %>
<form name="form1" method="post" action="khxydj_mod.jsp" onSubmit="return Validator.Validate(this,3);">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
�ͻ���Ϣ���� &gt; �ͻ��ڲ�������ϸ��Ϣ
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
<a href="khnbpj_mod.jsp?czid=<%= id %>"  accesskey="m" title="�޸�(Alt+M)" class="fontcolor">
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
<!-- end cwTop -->







<!-- end cwCellTop -->

<%
	
	String cust_name = "";
	String cust_id = "";
	String credit_rank = "";
	String credit_rank_name = "";
	String change_date = "";
	String memo = "";
	String creator = "";
	String create_date = "";
	String modificator = "";
	String modify_date = "";
	ResultSet rs;
	String sqlstr = "select * from vi_cust_rank where id='" + id + "'"; 

	rs = db.executeQuery(sqlstr); 
	if (rs.next()){
		cust_name = getDBStr( rs.getString("cust_name") );
		cust_id = getDBStr( rs.getString("cust_id") );
		credit_rank = getDBStr( rs.getString("rank") );
		credit_rank_name = getDBStr( rs.getString("rank_name") );
		change_date = getDBDateStr( rs.getString("change_date") );
		memo = getDBStr( rs.getString("memo") );
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

<input type="hidden" name="savetype" value="del">
<input type="hidden" name="czid" value="<%=id %>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <th scope="row">�ͻ�����</th>
    <td><%= cust_name %>
	</td>

    <th>���õȼ�</th>
    <td><%=credit_rank_name %></td>
  </tr>
  <tr>
	<th scope="row">�䶯����</th>
	<td><%=change_date %></td>
  
    <th>��ע</th>
    <td><%=memo %></td>
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
</div>

    </form>

</body>
</html>
