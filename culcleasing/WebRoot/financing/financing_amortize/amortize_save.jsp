<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@page import="com.tenwa.log.LogWriter"%>
<%@page import="java.util.regex.Pattern"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<jsp:useBean id="execlBean" scope="page" class="com.UploadExecl" />
<%@ include file="../../func/common_simple.jsp"%>

<%
//����ƻ��ϴ�����
int flag = 0;
String drawings_id = getStr( request.getParameter("drawings_id") );
String sqlstr = ""; 
//��ɾ��֮ǰ���������
sqlstr="delete from financing_amortize where drawings_id='"+drawings_id+"'";
db.executeUpdate(sqlstr);
LogWriter.logDebug(request, "����̯����ϸǰ��ɾ��ԭ̯����ϸ��"+sqlstr);
//����������
sqlstr = "Insert into financing_amortize ";
sqlstr +=" (drawings_id,amortize_date,amortize_money,Non_amortization_balance,amortize_method,creator,create_date,amortize_list,amortize_type) ";
sqlstr +=" select ";
sqlstr +=" drawings_id,amortize_date,amortize_money,Non_amortization_balance,amortize_method,creator,create_date,amortize_list,amortize_type ";
sqlstr +=" from financing_amortize_temp ";
sqlstr +=" where drawings_id='"+drawings_id+"'";
flag=db.executeUpdate(sqlstr);
String sqlLog = LogWriter.getSqlIntoDB(request, "��̯��ϸ����", "���ݱ���", "��̯��ϸ����", sqlstr);
db.close();
if(flag>0){
%>
<script type="text/javascript">
	window.close();
	window.opener.alert("��̯��ϸ����ɹ���");
	window.opener.location.reload();
</script>
<%
}else{
%>
<script type="text/javascript">
	window.close();
	window.opener.alert("��̯��ϸ����ʧ�ܣ������ݿɹ����棡");
	window.opener.location.reload();
</script>
<%
}%>