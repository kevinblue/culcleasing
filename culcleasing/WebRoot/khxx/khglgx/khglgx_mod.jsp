<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�޸Ŀͻ���� - �ͻ���Ϣ����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>

<body>


<form name="form1" method="post" action="khglgx_save.jsp" onSubmit="return Validator.Validate(this,3);">



<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
�ͻ���Ϣ���� &gt; �޸Ŀͻ����
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
<BUTTON class="btn_2" name="btnSave" value="�޸�"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">�޸�</button>
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">�� ��</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<!-- end cwCellTop -->
<%

	String czid = getStr( request.getParameter("czid") );
	String sqlstr = "select vi_cust_use_info.*,inter_cust_info.cust_id as inter_cust_id,inter_cust_info.cust_name as inter_cust_name,inter_cust_info.short_name as inter_short_name from vi_cust_use_info left outer join inter_custid_join on vi_cust_use_info.cust_id=inter_custid_join.cust_id_b left outer join inter_cust_info on inter_custid_join.cust_id_f=inter_cust_info.cust_id where vi_cust_use_info.cust_id='" + czid+"'"; 
	System.out.println(sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 

	String cust_id = "";
	String cust_name = "";
	String info_flag = "";
	String nbhydata ="";
	String lbdldata = "";
	String creator_dept = "";
	String org_code = "";
	
	String inter_cust_id = "";
	String inter_cust_name = "";
	String inter_short_name = "";
	if ( rs.next() ) {
		info_flag = getDBStr( rs.getString("info_flag") );
		cust_name = getDBStr( rs.getString("cust_name") );
		cust_id = getDBStr( rs.getString("cust_id") );
		inter_cust_id = getDBStr( rs.getString("inter_cust_id") );
		inter_cust_name = getDBStr( rs.getString("inter_cust_name") );
		inter_short_name = getDBStr( rs.getString("inter_short_name") );
		nbhydata = getDBStr( rs.getString("industry_name") );
		lbdldata = getDBStr( rs.getString("lbdlmc") );
		creator_dept = getDBStr( rs.getString("creator_dept") );
		org_code = getDBStr( rs.getString("id_card_no") );
	}
	rs.close(); 
	db.close();
%>

<div id="myDiv" class="tabBody" style="background:#ffffff;width:96%;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" value="mod" name="savetype">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <th scope="row">�ͻ�����</th>
    <td><input name="cust_id" type="hidden" value="<%=cust_id %>"><%=cust_name %></td>
    <th scope="row">��֯�ṹ����</th>
    <td><%=org_code %></td>
  </tr>
  <tr>
    <th scope="row">�ڲ���ҵ</th>
    <td><%=nbhydata %></td>
    <th scope="row">�ͻ����</th>
    <td><%=lbdldata %></td>
  </tr>
  <tr>
    <th scope="row">��������</th>
    <td><%=creator_dept %></td>
    <th scope="row">��Ϣ״̬</th>
    <td><%=info_flag %></td>
  </tr>
  <tr>
  	<th scope="row">����ϵͳ�ͻ�</th>
    <td><input name="inter_cust_name" type="text" size="15" value="<%=inter_cust_name %>" readonly><input type="hidden" name="inter_cust_id"  value="<%=inter_cust_id %>"><img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="OpenDataWindow('','','','','����ϵͳ�ͻ�','inter_cust_info','cust_name','cust_id','cust_name','cust_name','asc','form1.inter_cust_name','form1.inter_cust_id');"></td>
    <th scope="row"></th>
    <td></td>
  </tr>
</table>


</div>

</div>

    </form>

<!-- end cwMain -->
</body>
</html>
