<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
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
if (right.CheckRight("duning-record-del",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>ɾ�����ռ�¼ - ������</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>
<body>


<form name="form1" method="post" action="record_save.jsp" onSubmit="return Validator.Validate(this,3);">

<table  class="title_top" width=100% height=100% align="center" cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
 ������ &gt; ɾ�����ռ�¼
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
<BUTTON class="btn_2" name="btnSave" value="����"  type="submit" >
<img src="../../images/sbtn_del.gif" align="absmiddle" border="0">ɾ��</button>
<BUTTON class="btn_2" name="btnReset" value="ȡ��" onClick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">ȡ��</button>


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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">ɾ ��</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<!-- end cwTop -->

<!-- end cwCellTop -->

<%
	String id = getStr( request.getParameter("czid") );
	String cust_name = "";
	String liaison_date = "";
	String liaison_way = "";
	String liaisoner = "";
	String nextliaison_date = "";
	String pay_money = "";
	String pay_date = "";
	String liaison_info = "";
	
	ResultSet rs;
	String sqlstr = "select dbo.getcustname(cust_id)as cust_name,liaison_date,nextliaison_date,pay_date,liaison_way,liaisoner,pay_money,liaison_info from dunning_record where dunningrecord_id='" + id + "'"; 

	rs = db.executeQuery(sqlstr); 
	if (rs.next()){
		cust_name = getDBStr( rs.getString("cust_name") );
		liaison_date = getDBDateStr( rs.getString("liaison_date") );
		nextliaison_date = getDBDateStr( rs.getString("nextliaison_date") );
		pay_date = getDBDateStr( rs.getString("pay_date") );
		liaison_way = getDBStr( rs.getString("liaison_way") );
		liaisoner = getDBStr( rs.getString("liaisoner") );
		pay_money = getDBStr( rs.getString("pay_money") );
		liaison_info = getDBStr( rs.getString("liaison_info") );
	}
	rs.close();
	sqlstr="select name from base_user where id='"+liaisoner+"'";
	rs = db.executeQuery(sqlstr); 
	if (rs.next()){
		liaisoner = getDBStr( rs.getString("name") );
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
    <td scope="row" nowrap width="20%">�ͻ�����</td>
    <td><%= cust_name %>
	</td>
    <td scope="row" nowrap width="20%">�߿�Ա</td>
    <td ><%=liaisoner%></td>
  </tr>
  <tr>
  <td scope="row" nowrap width="20%">��ϵ��ʽ</td>
    <td><%=liaison_way %></td>
    <td scope="row" nowrap width="20%">��ϵ����</td>
    <td ><%=liaison_date%></td>
  </tr>
  <tr>
  <td scope="row" nowrap width="20%">��ŵ������</td>
    <td ><%=pay_money%></td>
    <td scope="row" nowrap width="20%">��ŵ������</td>
    <td ><%=pay_money%></td>
  </tr>
   <tr>
  <td scope="row" nowrap width="20%">�´���ϵ����</td>
    <td ><%=nextliaison_date%></td>
    <td scope="row" nowrap width="20%"></td>
    <td ></td>
  </tr>
   <tr>
  <td scope="row" nowrap width="20%">��ϵ���</td>
    <td ><%=liaison_info%></td>
    <td scope="row" nowrap width="20%"></td>
    <td ></td>
  </tr>
</table>
</div>
</div></td></tr></table>
    </form>
</body>
</html>
