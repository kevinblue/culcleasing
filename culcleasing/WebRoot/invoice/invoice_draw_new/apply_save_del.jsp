<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@page import="com.tenwa.log.LogWriter"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");//������
String sql_ids = getStr( request.getParameter("sql_ids") );

int flag=0;
String sqlstr="";
String message="";
String stype =  getStr( request.getParameter("savetype") );
if ( stype.equals("del") ){ 
	
	sqlstr="delete invoice_draw_info where glide_id='"+sql_ids+"'";
	flag += db.executeUpdate(sqlstr);

	sqlstr="delete invoice_draw_detail where apply_id='"+sql_ids+"'";
	flag += db.executeUpdate(sqlstr);
	
	//��־����
	String sqlLog = LogWriter.getSqlIntoDB(request, "��Ʊ��ȡ", "������Ʊ��ȡ", dqczy+"ɾ����Ʊ���,"+sql_ids, sqlstr);
	db.executeUpdate(sqlLog);
	
	message="ɾ����Ʊ��ȡ";
} else if ( stype.equals("sub") ){ 
	sqlstr="Update invoice_draw_info set is_sub='���ύ',status='������' where glide_id in ('"+sql_ids+"') ";
	flag += db.executeUpdate(sqlstr);
	message="�ύ��Ʊ��ȡ";
}
if(flag!=0){
%>
<script>
<% if (stype.equals("sub") ){%>
//���Ի���
window.open("http://test.eleasing.com.cn/ELeasing/ProjectWF/ProjectEHire.nsf/OSNewWorkFlowFromFPLQ?openagent&priId=<%=sql_ids %>");
//������ʽ����
//window.open("http://culc.eleasing.com.cn/ELeasing/ProjectWF/ProjectEHire.nsf/OSNewWorkFlowFromFPLQ?openagent&priId=<%=sql_ids %>");
//�����ʽ����
//window.open("http://culctj.eleasing.com.cn/ELeasing/ProjectWF/ProjectEHire.nsf/OSNewWorkFlowFromFPLQ?openagent&priId=<%=sql_ids %>");
<% }%>	
	window.close();
	opener.alert("<%=message%>�ɹ�!");
	opener.location.reload();
</script>
<%
}else{
%>
<script>
	window.close();
	opener.alert("<%=message%>ʧ��!");
	opener.location.reload();
</script>
<%}
db.close();%>
</body>
</html>