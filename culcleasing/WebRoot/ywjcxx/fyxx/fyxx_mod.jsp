<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<!-- 09.01.05 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�޸Ŀͻ����ձ� - �ͻ����ձ�</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
</head>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">�ͻ���Ϣά�� &gt; �޸Ŀͻ�����</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1"  method="post" action="fyxx_save.jsp" onSubmit="return Validator.Validate(this,3);">
<!-- end cwCellTop -->
<%

String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  //dqczy="����֤";
  //response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("gszh_mod",dqczy)>0) canedit=1;
//if (canedit==0) response.sendRedirect("../../noright.jsp");

%>
<%
String sqlstr;
String czid;
String feetype_number;
String subject_number;
String cdigest;
String auxiliary_account;
String flow_name;
String handle_flag;
String modify_date;
String modificator;

ResultSet rs;
czid=getStr(request.getParameter("czid"));
sqlstr = "select ifs.*,bf.feetype_name from dbo.inter_fee_subject_join ifs left join base_feetype bf on ifs.feetype_number=bf.feetype_number where id='"+czid+"' ";  
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{	
	 handle_flag =getDBStr(rs.getString("handle_flag"));
		 if(handle_flag.equals("1")){
		 handle_flag="��";
		 }else{
		 handle_flag="��";
		 }
	auxiliary_account=getDBStr(rs.getString("auxiliary_account"));
	String a=String.valueOf(auxiliary_account.charAt(0));
	String b=String.valueOf(auxiliary_account.charAt(1));
	String c=String.valueOf(auxiliary_account.charAt(2));
	String d=String.valueOf(auxiliary_account.charAt(3));
	

%> 
<input type="hidden" name="savetype" value="mod"><input type="hidden" name="kid" value="<%=rs.getString("id")%>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr >
    <td width="120" height="30" scope="row">��������</td>
    <td height="30" >
  <input class="text" name="feetype_number" accesskey="s" type="text" size="20" style="width: 133px" value="<%=getDBStr(rs.getString("feetype_name")) %>" readonly="readonly">
<img src="../../images/fdmo_65.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onClick="OpenDataWindow('','','','','������','base_feetype','feetype_name','feetype_number','feetype_name','feetype_name','asc','form1.feetype_number','form1.feetype_number');"><span class="biTian">*</span>
	</td>
  </tr>
   <tr>
    <td height="30" scope="row">��ĿID</td>
    <td height="30"><input name="subject_number" type="text" label="��ĿID"  value="<%=getDBStr(rs.getString("subject_number")) %>"  Require="ture"><span class="biTian">*</span></td>
  </tr>
   <tr>
    <td height="30" scope="row">ժҪ</td>
    <td height="30"><input name="cdigest" type="text" label="ժҪ"  value="<%=getDBStr(rs.getString("cdigest")) %>"  Require="ture"><span class="biTian">*</span></td>
  </tr>
  
<tr>
    <td height="30" scope="row">��������</td>
    
    <td height="30">
    <input type="checkbox" name="auxiliary_account" id="auxiliary_account1" value="1" <% if(a.equals("1")){ %> checked="checked" <%} %>>���ź���
    <input type="checkbox" name="auxiliary_account" id="auxiliary_account2" value="2" <% if(b.equals("1")){ %> checked="checked" <%} %>>�ͻ�����
    <input type="checkbox" name="auxiliary_account" id="auxiliary_account3" value="3" <% if(c.equals("1")){ %> checked="checked" <%} %> onclick="check(this.id);">��Ŀ����
    <input type="checkbox" name="auxiliary_account" id="auxiliary_account4" value="4" <% if(d.equals("1")){ %> checked="checked" <%} %> onclick="check(this.id);">�ʻ�����
    </td>
  </tr>
    <tr>
    <td height="30" scope="row">������</td>
    <td height="30"><input name="flow_name" type="text"  label="������"  value="<%=getDBStr(rs.getString("flow_name")) %>"  Require="true"> <span class="biTian">*</span></td>
  </tr>
    <tr>
    <td height="30" scope="row">��/��</td>
    <td height="30">
    <select class="text" name="handle_flag" style="width: 40px"><script>w(mSetOpt("<%=handle_flag%>","|��|��"));</script></select>
     <span class="biTian">*</span></td>
  </tr>
  <tr>
    <td height="30" scope="row">����������</td>
    <td height="30"><%=getDBDateStr(rs.getString("modify_date"))%></td>
  </tr>
  <tr>
    <td height="30" scope="row"> ����Ա</td>
    <td height="30"><%=getDBStr(rs.getString("modificator"))%></td>
  </tr>

</table>
<!-- end cwDataNav -->
</div>
<!-- end cwCellContent -->
</div>
<!-- end cwCell -->
<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="����" type="submit" class="btn3_mouseout"></td>

<td>
<input name="btnClose" value="ȡ��" type="button" onClick="window.close();" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
<!-- end cwToolbar -->
    </form>
    <%
}
else
{
%>
 <center>������¼������!</center>
<div id="cwToolbar" >
<input class="btn" name="btnClose" value="�ر�" type="button" onClick="window.close()">
</div>
<%
}
rs.close(); 
db.close();
%>
</div>
<!-- end cwMain -->
</body>
</html>