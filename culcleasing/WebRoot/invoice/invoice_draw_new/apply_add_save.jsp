<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@page import="com.tenwa.log.LogWriter"%>
<%@ page import="java.sql.*" %>
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

int flag=0;
String sqlstr="";
ResultSet rs = null;

//��������֮�󣬲������뵥
String systemDate = getSystemDate(0);
String glide_id="";
sqlstr="select isnull(max(cast(no as int)),1)+1 as glide_id from GENERATE_NO where generate_type='��ֵ˰��Ʊ��ȡ'";
rs=db.executeQuery(sqlstr);
if(rs.next()){
	glide_id=getDBStr( rs.getString("glide_id") );
}rs.close();
sqlstr="insert into generate_no select '��ֵ˰��Ʊ��ȡ','"+systemDate+"','"+glide_id+"'";
db.executeUpdate(sqlstr);
glide_id = "FP"+systemDate+"-"+glide_id;
	
//����������Ϣ 
sqlstr="insert into invoice_draw_info (glide_id,type,is_sub,flow_status,status,amt,amount_t,plan_date,creator,create_date) ";
sqlstr+="values(";
sqlstr+="'"+glide_id+"','��ֵ˰��Ʊ��ȡ','δ�ύ','δͨ��','δ��ȡ','0','0','"+systemDate+"',";
sqlstr+="'"+dqczy+"','"+systemDate+"') ";
LogWriter.logDebug(request, "��ֵ˰��Ʊ��ȡ��"+sqlstr);
//ִ�����
flag = db.executeUpdate(sqlstr);

if(flag!=0){
%>
<script>
	window.close();
	opener.alert("��ֵ˰��Ʊ��ȡ�����ɹ�����ѡ�����뵥[<%=glide_id %>]ά����ѡ���ʽ𡢷�Ϣ����Ϣ!");
	opener.location.reload();
</script>
<%
}else{
%>
<script>
	window.close();
	opener.alert("��ֵ˰��Ʊ��ȡ����ʧ��!");
	opener.location.reload();
</script>
<%}
db.close();%>
</body>
</html>