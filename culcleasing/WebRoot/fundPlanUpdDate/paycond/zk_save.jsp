<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage="/public/pageError.jsp"%>

<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>
<BODY>
		<%

	
//��ȡ��������
String item_id = getStr( request.getParameter("item_id") );//����
String zk_fee_name_val = getStr( request.getParameter("zk_fee_name_val") );//����
String doc_id = getStr( request.getParameter("doc_id") );//����
//��������
String sqlstr;
String sqlstr1="";
String dqczy = (String) session.getAttribute("czyid");//��ǰ��½��
String datestr = getSystemDate(0); //��ȡϵͳʱ��
String sqlstr2="";
String sqlstr3="";
sqlstr3="update contract_fund_fund_charge_ZK set flag=2 where fund_uuid='"+item_id+"' and doc_id<>'"+doc_id+"'";
	db.executeUpdate(sqlstr3);

int flag = 0;
sqlstr1="delete from contract_fund_fund_charge_ZK where fund_uuid='"+item_id+"' and doc_id='"+doc_id+"'";
flag = db.executeUpdate(sqlstr1);
sqlstr = "insert into contract_fund_fund_charge_ZK (fund_uuid,fund_zkuuid,doc_id)";
sqlstr+="select '"+item_id+"','"+zk_fee_name_val+"','"+doc_id+"'";
flag += db.executeUpdate(sqlstr);

db.close();
if(flag>0){%>
	<script type="text/javascript">
	opener.alert("���۳ɹ�!");
	opener.location.reload();
	if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
	else{history.back()}
	</script>
<%
	} else {
%>
	<script type="text/javascript">
	opener.alert("����ʧ��!");
	opener.location.reload();
	if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
	else{history.back()}
	</script>
<%
	}
%>
</BODY>
</HTML>
