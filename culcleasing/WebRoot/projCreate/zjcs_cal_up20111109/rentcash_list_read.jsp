<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>������ - �ֽ����б�</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript"></script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<%
	//��ȡ��ѯ����
	String proj_id = getStr(request.getParameter("proj_id"));
	String doc_id = getStr(request.getParameter("doc_id")); 
	//�г��ֽ���
	sqlstr = " select plan_date,follow_in,follow_in_detail,follow_out,follow_out_detail,net_follow";
	sqlstr +=" from fund_proj_plan_mark_temp where proj_id='"+proj_id+"' and doc_id='"+doc_id+"' order by plan_date"; 
	System.out.println("��ͬ�ֽ��� -- sqlstr��ѯsql���==>> "+sqlstr);
	rs = db.executeQuery(sqlstr);
%>
<body onLoad="public_onload(0)">
<form name="form1" action="rentcash_list_read.jsp"  onSubmit="return goPage()">
<div style="vertical-align:top;width:100%; overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
<div id="TD_tab_0">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
    height="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <!-- 
	    <th>��ͬ���/��Ŀ���</th>
	    <th>�ĵ����</th>
	     -->
	    <th>����</th>
	    <th>����</th>
		<th>������</th>
		<th>�������嵥</th>
		<th>������</th>
		<th>�������嵥</th>
		<th>������</th>
      </tr>
<%	  
	int i = 1;
	while(rs.next()) {
%>
      <tr>
       <%--  
		<td nowrap align="center"><%=getDBStr(rs.getString("proj_id"))%></td>
		<td nowrap align="center"><%=getDBStr(rs.getString("doc_id"))%></td>
       --%>
      	<td nowrap align="center"><%=i%></td>
      	<td nowrap align="center"><%=getDBDateStr(rs.getString("plan_date")).substring(0,7)%></td>
		<td nowrap align="center"><%=formatNumberStr(getDBStr(rs.getString("follow_in")),"#,##0.00")%></td>
		<td align="center"><%=getDBStr(rs.getString("follow_in_detail"))%></td>
		<td nowrap align="center"><%=formatNumberStr(getDBStr(rs.getString("follow_out")),"#,##0.00")%></td>
		<td align="center"><%=getDBStr(rs.getString("follow_out_detail"))%></td>
		<td nowrap align="center"><%=formatNumberStr(getDBStr(rs.getString("net_follow")),"#,##0.00")%></td>				
      </tr>
      
<%
		i++;
	}
rs.close(); 
db.close();
%>
	  <tr>
	  	<td nowrap align="left" colspan="7">
	  	<font color="red">
	  		��Ŀ���Ϊ:<%=proj_id%>&nbsp;|&nbsp;�ĵ����Ϊ:<%=doc_id%>&nbsp;
	  	</font>
	  	</td>
	  </tr>
    </table>
  </div>
  </div>
  
</form>
</body>
</html>
