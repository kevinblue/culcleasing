<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>������Ϣ���� - ɾ�����ֱ�׼</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>


<%
String id = getStr( request.getParameter("czid") );
	
	String item_id = "";
	String item_name = "";
	String order_number = "";
	String standard = "";
	String disp_name = "";
	String value = "";
	String veto_flag = "";
	String his_flag = "";
	String creator = "";
	String create_date = "";
	String modificator = "";
	String modify_date = "";
	ResultSet rs;
	String sqlstr = "select * from vi_base_evaluation_standard where standard_id='" + id + "'"; 

	rs = db.executeQuery(sqlstr); 
	if (rs.next()){
		item_id = getDBStr( rs.getString("item_id") );
		item_name = getDBStr( rs.getString("item_name") );
		order_number = getDBStr( rs.getString("order_number") );
		standard = getDBStr( rs.getString("standard") );
		disp_name = getDBStr( rs.getString("disp_name") );
		value = getDBStr( rs.getString("value") );
		veto_flag = getDBStr( rs.getString("veto_flag") );
		his_flag = getDBStr( rs.getString("his_flag") );
		creator = getDBStr( rs.getString("creator") );
		create_date = getDBDateStr( rs.getString("create_date") );
		modificator = getDBStr( rs.getString("modificator") );
		modify_date = getDBDateStr( rs.getString("modify_date") );
	}
	rs.close();
	db.close();
%>
<body  onload="setDivHeight('divH',-55);fun_winMax();">


<form name="form1" method="post" action="pfbz_save.jsp" onSubmit="return Validator.Validate(this,3);">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
ɾ�����ֱ�׼ &gt; ������Ϣ����
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
<BUTTON class="btn_2" name="btnSave" value="ɾ��"  type="submit" >
<img src="../../images/sbtn_del.gif" align="absmiddle" border="0">ɾ��</button>
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">ɾ ��</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<!-- end cwTop -->







<!-- end cwCellTop -->

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="del">
<input type="hidden" name="czid" value="<%=id%>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
  	<th scope="row">��ʾ����</th>
    <td><%=disp_name%>
	</td>
    <th scope="row">ģ�ͱ��</th>
    <td><%=item_name%></td>
  </tr>
  <tr>
  	<th scope="row">���</th>
    <td><%=order_number%>
	</td>
	<th  scope="row">���ֱ�׼</th>
	<td><%=standard%></td>
  </tr>	
  <tr>
  	<th scope="row">��ֵ</th>
    <td><%=value%>
	</td>
	<th  scope="row">һƱ���</th>
	<td><%=veto_flag.equals("-1")?"����":"�ر�"%></td>
  </tr>
   <tr>
  	<th scope="row">״̬</th>
    <td><%=his_flag.equals("0")?"����":"�ر�"%>
	</td>
	<th>�Ǽ���</th>
    <td ><%=creator%>&nbsp;</td>
  </tr>	
 <tr>
    <th>�Ǽ�����</th>
    <td ><%=create_date%>&nbsp;</td>
  
    <th>������</th>
    <td ><%=modificator%>&nbsp;</td>
  </tr>
  <tr>
    <th>��������</th>
    <td ><%=modify_date%>&nbsp;</td>
    <th></th>
    <td></td>
  </tr>
</table>


</div>
</div>

    </form>

</body>
</html>
