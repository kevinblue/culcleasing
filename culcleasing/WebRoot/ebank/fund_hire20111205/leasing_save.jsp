<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

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
String systemDate = getSystemDate(0);

String sqlstr="";
int flag=0;
String message="";

String stype =  getStr( request.getParameter("savetype") );
//��ӵ���ʵ�Ľ��׽ṹ��
if ( stype.equals("bh") ){  //����ʱ
	//�õ��տ�ŵļ���
	String sql_bh_ids = getStr( request.getParameter("sql_bh_ids") );
	sqlstr=" update apply_info set status='�Ѳ���',is_sub='δ�ύ' where glide_id in ("+sql_bh_ids+") ";
	flag=db.executeUpdate(sqlstr);
	message="���������ʽ��տ�";
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
<%}db.close();%>
</body></html>
