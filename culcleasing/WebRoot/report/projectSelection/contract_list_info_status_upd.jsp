<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %> 
<%@ page import="com.tenwa.log.LogWriter"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@ page import="com.tenwa.log.LogWriter"%>
<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
//===========================================
	//��Ŀ����״̬�޸�
//===========================================

//��ȡ��������contract_id
String contract_status= getStr( request.getParameter("contract_status") );
String[] ids = request.getParameterValues("list");
//String recycle_id = dqczy;	������

int flag = 0;//������
int length =0;//���鳤��
if(ids == null){
	length = 0;
}else{
	length = ids.length;
}
for(int i = 0; i < length; i++) {
	sqlstr = "update contract_list_info " 
			+ " set contract_status = '"+contract_status+"'";
	sqlstr+= " where id='"+ids[i]+"'";
	flag += db.executeUpdate(sqlstr); 
}
db.close();
	String msg = length + "�ݺ�ͬ״̬�޸�Ϊ"+contract_status; 

//3�����ж�
if(flag == length){%>
	<script type="text/javascript">
		window.close();
		window.opener.alert("<%=msg %>�ɹ�!");
		window.opener.location.reload();
	</script>	
<%}else{
%>
	<script type="text/javascript">
		window.close();
		window.opener.alert("<%=msg %>ʧ��!");
		window.opener.location.reload();
	</script>
	
<%} 

%>
</BODY>
</HTML>
