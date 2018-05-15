<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
//���ŵ�λ�����Ϣ����ɾ�Ĳ�
String dqczy = (String) session.getAttribute("czyid");
String stype = getStr( request.getParameter("savetype") );
String datestr = getSystemDate(0); //��ȡϵͳʱ��

String code = getStr( request.getParameter("code") );
String loan_name = getStr( request.getParameter("loan_name") );
String loan_code = getStr( request.getParameter("loan_code") );
String refund_name = getStr( request.getParameter("refund_name") );
String priId = getStr( request.getParameter("priId") );

String sqlstr = "";
ResultSet rs = null;
int flag = 0;
String msg = "";

if ( stype.equals("add") ){        //���Ӳ���
	sqlstr = "select id from financing_config_refundtype where code='" + code + "'";
	rs = db.executeQuery(sqlstr); 
	if ( rs.next() ) {
		flag = -2;
	} else {
		sqlstr = "Insert into financing_config_refundtype(code,refund_name,loan_code,creator,create_date,modifactor,modify_date ) select top 1  '" + code + "','" + refund_name  + "','"+loan_code+"','" + dqczy + "','" + datestr  + "','" + dqczy + "','" + datestr  + "' from financing_config_loantype where loan_name='"+loan_name+"'";
		System.out.print(sqlstr);
		flag = db.executeUpdate(sqlstr); 
		msg = "���ӻ�������";
	}
}else if ( stype.equals("mod") ){      //�޸Ĳ���
	sqlstr = "Update financing_config_refundtype set code='"+code+"',refund_name='"+refund_name+ "',modifactor='"+dqczy+"',modify_date='"+datestr+"' where id='"+priId+"'";
	flag = db.executeUpdate(sqlstr);
	
	msg = "���»��������";
}else if ( stype.equals("del") ){         //ɾ������
	sqlstr = "Delete from financing_config_refundtype where id='" + priId + "'";
	flag = db.executeUpdate(sqlstr);
	
	msg = "ɾ����������";
}
db.close();

if(flag == -2){
%>
	<script type="text/javascript">
		window.history.back();
		alert("����[�������ͱ��]�����б���ظ�");
	</script>
<%	
}else if(flag>0){
%>
	<script type="text/javascript">
		window.close();
		opener.alert("<%=msg %>�ɹ�!");
		opener.location.reload();
	</script>
<%			
}else{
%>
	<script type="text/javascript">
		window.close();
		opener.alert("<%=msg %>ʧ��!");
		opener.location.reload();
	</script>
<%} %>
</BODY>
</HTML>