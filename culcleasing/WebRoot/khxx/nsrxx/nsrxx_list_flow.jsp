<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��˰����Ϣ</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<%
//��ȡ����contract_id,proj_id,doc_id
String proj_id = getStr( request.getParameter("proj_id") );
//ģ�⸳ֵ
//if("".equals(proj_id)){
	//proj_id = "11D0711359";
//}

%>

<body onLoad="public_onload(0)" style="overflow: auto;">


<div style="margin-top: 20px;">

<div id="tabletit" class="tabtitexp" style="height: 25px;vertical-align: middle;">&nbsp; 
	��˰����Ϣ&nbsp;
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
	style="cursor:hand" title="��ʾ/��������">				 
</div> 

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;margin-top: 10px;height:100%;">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>�ͻ����</th>
	 <th>�ͻ����</th>
     <th>�ͻ�����</th>
     <th>��˰������</th>

	 <th>��˰��ʶ���</th>
	 <th>�Ƿ���Խ���ֿ�</th>
     <th>��ֵ˰��Ʊ����</th>
     <th>��ַ</th>
     <th>�绰</th>
     <th>����������</th>
     <th>�˺�</th>
	 <th>����</th>
   </tr>
   <tbody id="data">
<%
String col_str=" * ";

sqlstr = "select "+col_str+" from vi_nsrxx where proj_id='"+proj_id+"'";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
     	
     	<td align="center"><%=getDBStr(rs.getString("lbdlmc")) %></td>
		<td align="left"><%=getDBStr(rs.getString("provider_id")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("provider")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("tax_payer_type")) %></td>

		<td align="center"><%=getDBStr(rs.getString("tax_payer_no")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("is_dk")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("tax_type_invoice")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("address")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("tel")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("bank_name")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("bank_no")) %></td>
		<td align="center"><img src="../../images/sbtn_mod.gif" align="absmiddle" border="0">
		<a href="nsrxx_flow_upd.jsp?cust_id=<%=rs.getString("provider_id")%>&proj_id=<%=proj_id%>">�޸�</a></td>
     </tr>
<%}
rs.close();
%>     
     </tbody>
</table>
</div>

</div>

</body>
</html>
<%if(null != db){db.close();}%>