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
String systemDate = getSystemDate(0);

int flag=0;
String sqlstr="";
String message="";
String stype =  getStr( request.getParameter("savetype") );


if ( stype.equals("del") ){ 
	//��ȡ����
	String glide_id= getStr( request.getParameter("glide_id") );
	String[] priIdS=request.getParameterValues("list");
	//ɾ��detail��
	for(int i = 0; i < priIdS.length; i++) {
		sqlstr = "Delete from invoice_draw_detail where pri_id='"+priIdS[i]+"' and invoice_type='��Ϣ' ";
		flag += db.executeUpdate(sqlstr);
	}
	
	//����apply_info��
	sqlstr="Update invoice_draw_info set amount_t=isnull(amount_t,0)-"+priIdS.length+",amount_fx=isnull(amount_fx,0)-"+priIdS.length+" where glide_id ='"+glide_id+"' ";
	flag += db.executeUpdate(sqlstr);
	
	message="ɾ����Ϣ��ֵ˰��Ʊ";
} else if ( stype.equals("add") ){ 
	//��ȡ����
	String glide_id= getStr( request.getParameter("glide_id") );
	String[] priIdS=request.getParameterValues("list");
	//����detail��
	for(int i = 0; i < priIdS.length; i++) {
		sqlstr = "Insert into invoice_draw_detail(begin_id,apply_id,pri_id,invoice_type,draw_flag,creator,create_date)";
		sqlstr += "Select begin_id,'"+glide_id+"',id,'��Ϣ','0','"+dqczy+"','"+systemDate+"' from vi_func_penalty_manage_draw where id='"+priIdS[i]+"'";
		flag += db.executeUpdate(sqlstr);
	}
	
	//����apply_info��
	sqlstr="Update invoice_draw_info set amount_t=isnull(amount_t,0)+"+priIdS.length+",amount_fx=isnull(amount_fx,0)+"+priIdS.length+" where glide_id ='"+glide_id+"' ";
	flag += db.executeUpdate(sqlstr);
	message="������Ϣ��ֵ˰��Ʊ";
}
if(flag!=0){
%>
<script>
	opener.alert("<%=message%>�ɹ�!");
	opener.location.reload();
	
	if(window.opener){
		window.opener=null;window.open('','_self');
		window.close();} 
	 else{history.back()}
</script>
<%
}else{
%>
<script>
	opener.alert("<%=message%>ʧ��!");
	opener.location.reload();
	
	if(window.opener){
		window.opener=null;window.open('','_self');
		window.close();} 
	 else{history.back()}
</script>
<%}
db.close();%>
</body>
</html>