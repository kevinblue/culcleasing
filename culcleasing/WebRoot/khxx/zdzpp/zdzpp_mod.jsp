<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�޸Ŀͻ���Ƭ��Ϣ��Ϣ - �޸��ܶ��ܿͻ�����Ʒ��</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>



<body>
<form name="form1" method="post" action="zdzpp_save.jsp" onSubmit="return Validator.Validate(this,3);">
<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
�ͻ���Ϣ���� &gt; �޸��ܶ��ܿͻ�����Ʒ��
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
}
int canmod=0;


	String czid = getStr( request.getParameter("czid") );
	String sqlstr = "select * from cust_brand left outer join vi_cust_all_info on cust_brand.cust_id = vi_cust_all_info.cust_id where brand_id=" + czid ; 
	ResultSet rs = db.executeQuery(sqlstr); 

	String	cust_id = "";
	String	cust_name = "";
	String	brand_id = "";
	String	brand_name = "";
	String	brand_type = "";
	String	brand_attribute = "";


	if ( rs.next() ) {
		
		cust_name = getDBStr( rs.getString("cust_name") );
		brand_id = getDBStr( rs.getString("brand_id") );
		cust_id = getDBStr( rs.getString("cust_id") );
		brand_name = getDBStr( rs.getString("brand_name") );
		brand_type = getDBStr( rs.getString("brand_type") );
		brand_attribute = getDBStr( rs.getString("brand_attribute") );
		

	}
	rs.close(); 
	db.close();




%>


<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="czid" value="<%= czid %>">
<table class="tab_table_title" border="0" cellspacing="0" cellpadding="0" width="100%">
  <tr>
    <td>�ͻ�����</td>
    <td><%=cust_name %><input type="hidden" name="cust_id"  value="<%=cust_id %>">
	<span class="biTian">*</span></td>

    <td>Ʒ������</td>
    <td><input name="brand_name" type="text" size="40" maxB="25" Require="true" value="<%=brand_name %>"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>��Ʒ����</td>
    <td><textarea name="brand_type" rows="4" maxB="100"><%=brand_type %></textarea>
	<span class="biTian">*</span></td>

    <td>��Ʒ����</td>
    <td><textarea name="brand_attribute" rows="4" maxB="100"><%=brand_attribute %></textarea></td>
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
<!--���ӽ���-->

<!--����ѡ�񿨺�����iframe�ĸ߶���Ӧ����-->

</form>








<!-- end cwMain -->
</body>
</html>