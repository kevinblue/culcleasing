<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>������ά��</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

<script type="text/javascript">

//��������ʽ�ƻ�
function addNew(){
	document.addNewFundForm.submit();
}
</script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<%
//��ȡ����contract_id
String drawings_id = getStr( request.getParameter("drawings_id") );
%>

<body onLoad="public_onload(0)" style="overflow: auto;">
<!-- ���Ѽƻ����� -->
<div style="margin-top: 0px;">
<div id="fund_plan" style="margin-top: 10px;">
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<td>
			<!-- �������Ѽƻ� -->
			<BUTTON class="btn_2" type="button" onclick="addNew();">
			<img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="����(Alt+N)">&nbsp;����������</button>
			<form action="factorage_add.jsp" name="addNewFundForm" method="post" target="_blank">
				<input name="drawings_id" type="hidden" value="<%=drawings_id %>">
			</form>
		</td>
		<!-- ��ҳ���� -->
		<td align="right" width="100%">
		</td><!-- ��ҳ���� -->
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;height:50%;" id="mydiv">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>����������</th>
     <th>�����ѽ��</th>
     <th>����</th>
     <th>֧����ʽ</th>
     <th>����������</th>
     <th>������</th>
     <th>��ע</th>
     <th>����</th>
   </tr>
   <tbody id="data">
<%
String col_str="*,(select name from base_user where id=financing_drawings_factorage.modifactor) modifactor_name ";

sqlstr = "select "+col_str+" from financing_drawings_factorage where drawings_id='"+drawings_id+"' order by drawings_id";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
     	<td align="center"><%=getDBStr(rs.getString("factorage_type")) %></td>
     	<td align="center"><%=CurrencyUtil.convertFinance(rs.getString("factorage_money")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("currency")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("factorage_paytype")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("factorage_date")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("modifactor_name")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("factorage_remark")) %></td>
     	
     	<td align="center">
		<%
		if(rs.getString("doc_id")==null){
		%>
     	<a href='factorage_upd.jsp?item_id=<%=getDBStr(rs.getString("id"))%>' target="_blank">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">�޸�</a>
     	|
     	<!-- ɾ����� -->
	    <script type="text/javascript">
			function delItem(obj){
				if(confirm("ȷ��ɾ���������ѣ�")){
					window.open('factorage_save.jsp?type=del&item_id='+obj );
				}
			}
		</script>
	    <a href="Javascript: delItem('<%=getDBStr(rs.getString("id"))%>')">
	    <img src="../../images/sbtn_del.gif" align="bottom" border="0">ɾ��</a>
		<%}else{%>
			<a href='factorage_upd.jsp?item_id=<%=getDBStr(rs.getString("id"))%>' target="_blank">
	   		<img src="../../images/btn_edit.gif" align="bottom" border="0">�޸�</a>
		<%}%>
     	</td>
		
     </tr>
<%}
rs.close();
%>     
     </tbody>
</table>
</div>
</div>
</div><!-- �����ʽ�ƻ�div -->
</body>
</html>
<%if(null != db){db.close();}%>