<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common_simple.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ϸ - ��Ŀ���</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">

<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>


<body onload="public_onload(0);">
<form name="form1" action="opinion_save.jsp" target="new" onSubmit="return Validator.Validate(this,3);">
<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
��ϸ - ��Ŀ���
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
<BUTTON class="btn_2" name="btnReset" value="�ر�" onclick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">�ر�</button>
	    </td>
	    <!-- 
		 <td>
<BUTTON class="btn_2" name="btnExport" value="����"  type="submit"  onclick="return isExport();" >
<img src="../../images/save.gif" align="absmiddle" border="0">����</button>
	    </td>
	     -->
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">��ϸ��Ϣ</td>
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;overflow:auto;">
<div id="TD_tab_0">

<%
String sqlstr="";
ResultSet rs = null;
String oper = getStr( request.getParameter("oper") );
String proj_id = getStr( request.getParameter("proj_id") );

sqlstr = "select * from vi_proj_opinion_state where proj_id='"+proj_id+"'";
String proj_name="";
String opinion_amount="";
 
rs=db.executeQuery(sqlstr); 
if (rs.next()) { 
	proj_name=getDBStr(rs.getString("project_name"));
	opinion_amount=getDBStr(rs.getString("opinion_amount"));
}
rs.close();
%>

<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
 <tr>
    <td>��Ŀ���:&nbsp;&nbsp;<b style="color:#E46344;"><%=proj_id %></b></td>
    <td>&nbsp;</td>
    <td>��Ŀ����:&nbsp;&nbsp;<b style="color:#E46344;"><%=proj_name %></b></td>
    <td>&nbsp;</td>
	<td>�������:&nbsp;&nbsp;<b style="color:#E46344;"><%=CurrencyUtil.convertIntAmount(opinion_amount) %></b></td>
  </tr>
</table>
<br><br>
<!-- ����start -->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;height:80%;" id="mydiv">
	<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"
		class="maintab_content_table">
	<tr class="maintab_content_table_title">
		<th>�����</th>
		<th>������ʵ��</th>
     	<th>���ʱ��</th>
 		<th>���</th>
		<th>ִ�в���</th>
	 	<th>����</th>
	 	
	 	<th>�Ƿ����</th>
	    <th>ִ�н��</th>
	    <th>������</th>
	    <th>���ʱ��</th>
	    <th>�Ǽ���</th>
	    <th>�Ǽ�ʱ��</th>
	    <% if(oper!=null && !"".equals(oper)) {%>
	    <th>����</th>
	    <%} %>
	</tr>
<tbody id="data">
<%
sqlstr="select oe.*,cjz=dbo.GETUSERNAME(oe.creator) from opinion_execution oe where proj_id='"+proj_id+"'";
rs = db.executeQuery(sqlstr); 
while (rs.next()){
%>
	<tr>
		<td align="left"><%=getDBStr(rs.getString("raiser"))%></td>
		<td align="left"><%=getDBStr(rs.getString("dutier"))%></td>
		<td align="center"><%=getDBDateStr(rs.getString("raiser_date")) %></td>
		<td align="left" class="autoNewLine" width="280px"><%=getDBStr(rs.getString("idea")) %></td>
		<td><%=getDBStr(rs.getString("operation_dept")) %></td>
		<td><%=getDBStr(rs.getString("flow")) %></td>
    				
		<td align="center"><%=rs.getInt("status")==0?"��":"��" %></td>
		
		<td><%=getDBStr(rs.getString("result")) %></td>
		<td><%=getDBStr(rs.getString("remark")) %></td>
		<td align="center"><%=getDBDateStr(rs.getString("end_time")) %></td>
		<td><%=getDBStr(rs.getString("cjz")) %></td>
		<td align="center"><%=getDBDateStr(rs.getString("create_date")) %></td>
		
		<% if(oper!=null && !"".equals(oper) && "del".equals(oper)) {%>
	    <td>
	      <script type="text/javascript">
			function delItem(texVal){
				if(confirm("ȷ��Ҫɾ���������")){
					window.open('opinion_save.jsp?savetype=del&item_id='+texVal);
				}
			}
		</script>
	    <a href='Javascript: delItem(<%=getDBStr(rs.getString("id"))%>)'>
        <img src="../../images/sbtn_del.gif" align="bottom" border="0">ɾ��</a>
        </td>
	    <%}else if(oper!=null && !"".equals(oper) && "update".equals(oper)) {%>
	    <td>
	      <script type="text/javascript">
			function updItem(texVal){
				if(confirm("ȷ��Ҫ�޸ĸ������")){
					window.open('opinion_mod.jsp?savetype=mod&item_id='+texVal);
				}
			}
		</script>
	    <a href='Javascript: updItem(<%=getDBStr(rs.getString("id"))%>)'>
        <img src="../../images/sbtn_mod.bak.gif" align="bottom" border="0">�޸�</a>
        </td>
	    <%} %>
	    
	</tr>
<%
} %>
</tbody>
</table>
</div>
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
<!--��ӽ���-->
<%
rs.close(); 
db.close();
%>
</form>
<!-- end cwMain -->
</body>
</html>
