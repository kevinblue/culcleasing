<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>����Э�� - ����Э���޸�</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
</head>

<body>


<form name="form" method="post" action="quotation_save.jsp" onSubmit="return Validator.Validate(this,3);">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
������Э�� &gt; ����Э���޸�
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
<BUTTON class="btn_2" name="btnReset" value="ȡ��" onclick="window.close();">
<img src="../../images/btn_close.gif" align="absmiddle" border="0">�ر�</button>

    	
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
 </table>
  <script language="javascript">
ShowTabN(0);
</script> 
 </td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<!-- end cwCellTop -->
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<%

	String czid = getStr( request.getParameter("custId") );
	String sqlstr =  "select * from mproj_quotation_info where id=" + czid; 
System.out.println("sql==============="+sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 

String proj_id="";
String contract_id="";
String type ="";
String pay_type="";
String plan_bj ="";
String plan_bjirr="";
String plan_year="";
String equip_return="";
String memo="";


	if ( rs.next() ) {
	//	cust_name = getDBStr( rs.getString("cust_name") );
		proj_id = getDBStr( rs.getString("proj_id") );
		contract_id = getDBStr( rs.getString("contract_id") );
		type = getDBStr( rs.getString("type") );
		pay_type = getDBStr( rs.getString("pay_type") );
		plan_bj = getDBStr( rs.getString("plan_bj") );
		plan_bjirr = getDBStr( rs.getString("plan_bjirr") );
		plan_year = getDBStr( rs.getString("plan_year") );
		equip_return=getDBStr( rs.getString("equip_return") );
		memo = getDBStr( rs.getString("memo") );
	}
	rs.close(); 
	db.close();
%>
<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="id" value="<%= czid %>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
   
   <tr>
   <td scope="row" nowrap>����Ŀ���:</td>
   <td><%= proj_id%></td>
   <td scope="row" nowrap>����ͬ���:</td>
   <td><%= contract_id%></td>
   </tr>
      <tr>
    <td scope="row" nowrap>�������ͣ�</td>
    <td><select class="text" name="type" ><script>w(mSetOpt("<%= type%>","|��ĩ|�ڳ�"));</script></select></td>
  <td scope="row" nowrap>���ⷽʽ��</td>
    <td>
    	<select class="text" name="pay_type" Require="true" ></select>
<script language="javascript" class="text">dict_list("pay_type","PayMode","<%= pay_type%>","title");</script>
    	</td>
   </tr>
  <tr>
    <td scope="row" nowrap>���������ʣ�</td>
    <td>
    <input type="text" id="plan_bj" name="plan_bj" size="25" value="<%= plan_bj%> ">
    </td>
  <td scope="row" nowrap>����IRR��</td>
    <td>
    <input type="text" id="plan_bjirr" name="plan_bjirr" size="25" value="<%= plan_bjirr%>">
    	</td>
  </tr>
    <tr>
    <td scope="row" nowrap>�������ޣ�</td>
    <td><%= plan_year%></td>
  <td scope="row" nowrap>�豸�˻���</td>
    <td>
    	<select class="text" name="equip_return" ><script>w(mSetOpt("<%= equip_return%>","|��|��"));</script></select>
    	</td>
  </tr>
  <tr>
    <td>��ע��</td>
  	<td>
  	<textarea class="text" name="memo"  maxB="300" rows="15"><%=  memo%></textarea>
  	</td>
  </tr>
</table>
</div>
</div>

</form>

<!-- end cwMain -->
</body>
</html>


