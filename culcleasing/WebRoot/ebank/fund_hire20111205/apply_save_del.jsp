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
String sql_bh_ids = getStr( request.getParameter("sql_bh_ids") );

int flag=0;
String sqlstr="";
String message="";
String stype =  getStr( request.getParameter("savetype") );

if ( stype.equals("del") ){ 
	//�޸��ʽ�ƻ���flag�ֶ�ֵΪ0
	sqlstr = "Update contract_fund_fund_charge_plan set flag=0 where id in( select plan_id from apply_info_detail where apply_id in("+sql_bh_ids+") )";
	flag += db.executeUpdate(sqlstr);
	//ɾ��apply_info\apply_info_detail����
	sqlstr=" delete apply_info where glide_id in ("+sql_bh_ids+") ";
	sqlstr+=" delete apply_info_detail where apply_id in ("+sql_bh_ids+") ";
	flag += db.executeUpdate(sqlstr);
	
	//��־����
	String sqlLog = LogWriter.getSqlIntoDB(request, "�ʽ�Ͷ�Ź���", "�����ʽ��տ�", dqczy+"ɾ�������տ���,"+sql_bh_ids, sqlstr);
	db.executeUpdate(sqlLog);
	
	message="ɾ�������ʽ��տ�";
} else if ( stype.equals("sub") ){ 
	sqlstr="Update apply_info set is_sub='���ύ',status='δ����' where glide_id in ("+sql_bh_ids+") ";

	flag += db.executeUpdate(sqlstr);
	message="�ύ�����ʽ��տ�";
}
if(flag!=0){
%>
<script>
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