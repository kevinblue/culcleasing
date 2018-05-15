<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %> 
<%@ page import="com.tenwa.log.LogWriter"%>
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
//===========================================
	//��Ŀ�����嵥
//===========================================

//��ȡ��������
String type = getStr( request.getParameter("type") );

//��������
String sqlstr;
String dqczy = (String) session.getAttribute("czyid");//��ǰ��½��
String datestr = getSystemDate(0); //��ȡϵͳʱ��

int flag = 0;
String msg = "";
 
if("save".equals(type)){//��Ӹ���ǰ��
	String proj_id = getStr( request.getParameter("proj_id") );
	String doc_id = getStr( request.getParameter("doc_id") );

	String[] mater_id = request.getParameterValues("list"); 

	//2.1��ɾ������ǰ��
	sqlstr = "delete from proj_document where proj_id='"+proj_id+"' and doc_id='"+doc_id+"'";
	db.executeUpdate(sqlstr);

	//2.2�����µĸ���ǰ��
	sqlstr = "";
	for(int i=0;i<mater_id.length;i++){
		sqlstr += " insert into proj_document(proj_id,doc_id,document_id,status,remark)";
		sqlstr += " select '"+proj_id+"','"+doc_id+"','"+mater_id[i]+"','δ��',''";
	}
	flag = db.executeUpdate(sqlstr);
	
	LogWriter.logDebug(request, "������Ŀ����");
	
	msg = "������Ŀ����";
}else if("del".equals(type)){//ɾ��ĳ��Ŀ����
	String item_id = getStr( request.getParameter("item_id") );
	sqlstr = "delete from proj_document where id='"+item_id+"'";
	flag = db.executeUpdate(sqlstr);
	
	LogWriter.logDebug(request, "ɾ����Ŀ���ϣ�"+item_id);
	
	msg = "ɾ������Ŀ����";
}

//3�����ж�
if(flag>0){%>
<script type="text/javascript">
	window.close();
	opener.alert("<%=msg %>�ɹ�!");
	opener.location.reload();
</script>	
<%}else{
%>
	<script type="text/javascript">
		window.close();
		opener.alert("<%=msg %>ʧ��!");
		opener.location.reload();
	</script>
<%} %>
</BODY>
</HTML>
