<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@ page import="com.tenwa.log.LogWriter" %> 
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
String czid = getStr( request.getParameter("czid") );//id
String systemDate = getSystemDate(0);

String sqlIds = getStr( request.getParameter("sqlIds") );//ѡ����

//�տ��Ϣ
String amt = getStr( request.getParameter("amt") );//�տ���
String amount = getStr( request.getParameter("amount") );//����
String method = "11";//���㷽ʽ
	
String sqlstr="";
ResultSet rs = null;
int flag=0;
String message="";

String stype =  getStr( request.getParameter("savetype") );

if( "addEbankRent".equals(stype) ){//����׸���
	//�����տ��
	String glide_id="";
	sqlstr="select isnull(max(cast(no as int)),1)+1 as glide_id from GENERATE_NO where generate_type='��������տ�'";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		glide_id=getDBStr( rs.getString("glide_id") );
	}rs.close();
	sqlstr="insert into generate_no select '��������տ�','"+systemDate+"','"+glide_id+"'";
	db.executeUpdate(sqlstr);
	glide_id = "EF"+systemDate+"-"+glide_id;
		
	//����������Ϣ - �����ʽ��տ�
	sqlstr="insert into apply_info (glide_id,type,is_sub,flow_status,status,amt,amount,plan_date,pay_method,creator,create_date) ";
	sqlstr+="values(";
	sqlstr+="'"+glide_id+"','��������տ�','δ�ύ','δͨ��','δ����','"+amt+"','"+amount+"','"+systemDate+"',";
	sqlstr+="'"+method+"','"+dqczy+"','"+systemDate+"') ";
	LogWriter.logDebug(request, "�����տ��"+sqlstr);
	//ִ�����
	flag += db.executeUpdate(sqlstr);

	//�����ϸ���¼
	sqlstr =" insert into apply_info_detail(plan_id,apply_id,contract_id,creator,create_date) ";
	sqlstr+=" select id,'"+glide_id+"',contract_id,'"+dqczy+"','"+systemDate+"' from vi_ebank_rent_hire ";
	sqlstr+=" where id in("+sqlIds+") ";
	flag += db.executeUpdate(sqlstr);
	//�޸����ƻ���flag�ֶ�ֵΪ2  -- 2��ʾ�������
	sqlstr = "  Update fund_rent_plan set state=2 where cast(id as varchar(50)) in("+sqlIds+")";
	//sqlstr += " Update fund_penalty_plan set state=2 where uuid in("+sqlIds+")";
	flag += db.executeUpdate(sqlstr);
	
	//��־����
	String sqlLog = LogWriter.getSqlIntoDB(request, "���Ͷ�Ź���", "��������տ�", dqczy+"�û�������������տ�տ���:"+amt+", ����������"+amount, sqlstr);
	db.executeUpdate(sqlLog);
	
	message="�����������տ�";
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
</BODY>
</HTML>