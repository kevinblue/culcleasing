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
if (right.CheckRight("duning-record-mod",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�޸Ĵ��ռ�¼ -  ������</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>



<body>


<form name="form1" method="post" action="record_save.jsp" onSubmit="return Validator.Validate(this,3);">

<table  class="title_top" width=100% height=100% align="center" cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
 ������ &gt; �޸Ĵ��ռ�¼
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
<img src="../../images/save.gif" align="absmiddle" border="0">����</button>
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">�� ��</td>
  
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

<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="czid" value="<%=id %>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
  <td scope="row" nowrap width="20%">�ͻ�����</td>
    <td><input name="cust_id"  value="<%= cust_name %>" readonly>
    <td scope="row">�߿�Ա</td>
    <td><input name="liaisoner"  value="<%= liaisoner %>" readonly></td>
  </tr>
  <tr>
  <td>��ϵ����</td>
    <td><input name="liaison_date" type="text" readonly value="<%=liaison_date%>"><img  onClick="openCalendar(liaison_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
    <td>��ϵ��ʽ</td>
    <td><select name="liaison_way" width="80px" Require="true">
    	<script language="javascript">
			dict_list("liaison_way","liaisonWay","<%=liaison_way%>","name");
		</script>	
    </select></td>
  </tr>
    <tr>
  <td scope="row" nowrap width="20%">��ŵ������</td>
    <td><input name="pay_money"  value="<%=pay_money%>" ></td>
    <td scope="row">��ŵ������</td>
    <td><input name="pay_date"  value="<%=pay_date%>"><img  onClick="openCalendar(pay_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
    <tr>
  <td scope="row" nowrap width="20%">�´���ϵ����</td>
    <td><input name="nextliaison_date"  value="<%=nextliaison_date%>" ><img  onClick="openCalendar(nextliaison_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
    <td scope="row"></td>
    <td></td>
  </tr>
  <td scope="row" nowrap width="20%">��ϵ���</td>
    <td><textarea name="liaison_info" cols="40" rows="5"><%=liaison_info%></textarea>
    <td scope="row"></td>
    <td></td>
  </tr>
</table>
</div>
</div>
    </form>
</body>
</html>
