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
//plan_id,id,
//dld_id,dld_name,pay_method,
///pay_date,pay_amt,proj_number,effe_date,
//status
//��������Ϣ
String dld_name = getStr( request.getParameter("dld_name") );
String dld_id = getStr( request.getParameter("dld_id") );
//������Ϣ
String pay_method = getStr( request.getParameter("pay_method") );
String pay_date = getStr( request.getParameter("pay_date") );
String pay_amt = getStr( request.getParameter("pay_amt") );
String proj_number = getStr( request.getParameter("proj_number") );
String effe_date = getStr( request.getParameter("effe_date") );
	
String sqlstr="";
ResultSet rs = null;
int flag=0;
String message="";

String stype =  getStr( request.getParameter("savetype") );

if( "addHeadPay".equals(stype) ){//����׸���
	//����������Ϣ
	sqlstr="insert into apply_info (dld_id,dld_name,pay_method,pay_date,pay_amt,proj_number,effe_date,pay_type,status,creator,create_date) ";
	sqlstr+="values(";
	//dld_id,dld_name,pay_method,pay_date,pay_amt,proj_number,effe_date
	sqlstr+="'"+dld_id+"','"+dld_name+"','"+pay_method+"','"+pay_date+"','"+pay_amt+"','"+proj_number+"','"+effe_date+"',";
	sqlstr+="'�ʽ�','δ����','"+dqczy+"','"+systemDate+"') ";

	LogWriter.logDebug(request, "���������"+sqlstr);
	//ִ�����
	flag = db.executeUpdate(sqlstr);
	LogWriter.operationLog(request, "����ҵ��>�ʽ�ƻ�>�������׸���>��Ӹ��", flag, sqlstr);

	//��ѯ����������id
	int maxid=0;
	String s="select max(id) as maxid from apply_info where dld_name='"+dld_name+"'";
	rs = db.executeQuery(s);
	if (rs.next()) {
		maxid=rs.getInt("maxid");
	}rs.close();

	//�����ϸ���¼
	String sql =" insert into apply_info_detail(plan_id,apply_id,creator,create_date,proj_id) ";
	sql+=" select id,"+maxid+",'"+dqczy+"','"+systemDate+"',proj_id from fund_fund_charge_plan ";
	sql+=" where funds_mode='�տ�' and funds_type<>'��������' and funds_type<>'DB��֤��' ";
	sql+=" and proj_id in("+sqlIds+") ";
	//ִ�����
	flag = db.executeUpdate(sql);

	message="��Ӵ���˾���ڸ���";
}else if ( stype.equals("del") ){ 
	sqlstr="delete apply_info where  id='"+czid+"'";
	System.out.println("sqlstr:"+sqlstr);
	flag += db.executeUpdate(sqlstr);

	sqlstr="delete apply_info_detail where  apply_id='"+czid+"'";
	System.out.println("sqlstr:"+sqlstr);
	flag += db.executeUpdate(sqlstr);

	message="ɾ������˾���ڸ���";
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