<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %> 
<%@ page import="com.tenwa.log.LogWriter"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@ page import="com.tenwa.log.LogWriter"%>
<jsp:useBean id="db1" class="dbconn.Conn"></jsp:useBean>

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

//��ȡ��������

dqczy=(String) session.getAttribute("czyid");
if(dqczy==null || "".equals(dqczy)){
	dqczy = "ADMN-WUSESSION";
}

String up_status= getStr(request.getParameter("up_status"));
String material_type= getStr(request.getParameter("material_type"));
String materialRD_date= getStr(request.getParameter("materialRD_date"));

String[] ids=request.getParameterValues("list");
String msg="";

int flag = 0;//������
int length =0;//���鳤��

int flag1=0;

if(ids == null){
	length = 0;
}else{
	length = ids.length;
}

/*if("callback".equals(up_status)){
	for(int i = 0; i < length; i++){
		sqlstr = "update contract_4material set material_status = '�ѻ���'";
		sqlstr += ",materialRD_date='"+materialRD_date+"',materialRD_name=(select name from base_user where id='"+dqczy+"')";
		sqlstr+= " where material_type<>'ֻ����'and id='"+ids[i]+"'";
		flag += db.executeUpdate(sqlstr); //���в��ǡ�ֻ���¡��ĺ͡�
		sqlstr+="  and material_type='ֻ����'";
		flag1 += db.executeUpdate(sqlstr);//ֻ���յ�����
	}
}
else if("seal_callback".equals(up_status)){
	for(int i = 0; i < length; i++){
		sqlstr = "update contract_4material set material_status = '�Ѹ����ѻ���'";
		sqlstr += ",materialRD_date='"+materialRD_date+"',materialRD_name=(select name from base_user where id='"+dqczy+"')";
		sqlstr+= " where material_type<>'ֻ����',id='"+ids[i]+"'";
		flag += db.executeUpdate(sqlstr); 
	}
}*/

if("callback".equals(up_status)){
	for(int i = 0; i < length; i++){
		String sqlstr1temp="";
		String sqlstr1="";

		sqlstr = "update contract_4material set material_status = '�ѻ���'";
		sqlstr1 = "update contract_4material set material_status = '�Ѹ����ѻ���'";

		if (materialRD_date.equals("")){
		sqlstr1temp= ",materialRD_date=getdate(),materialRD_name=(select name from base_user where id='"+dqczy+"')";
		}else{
		sqlstr1temp= ",materialRD_date='"+materialRD_date+"',materialRD_name=(select name from base_user where id='"+dqczy+"')";
		}
		sqlstr1temp+= " where material_type<>'ֻ����'and id='"+ids[i]+"'";

		sqlstr=sqlstr+sqlstr1temp;
		flag += db.executeUpdate(sqlstr); //���в��ǡ�ֻ���¡��ĺ͡�
		sqlstr1temp+="  and material_type<>'ֻ����'";
		sqlstr1=sqlstr1+sqlstr1temp;
		flag1 += db.executeUpdate(sqlstr1);//����+���յ�����
	}
}else if("nocallback".equals(up_status)){
	for(int i = 0; i < length; i++){
		String sqlstr1temp="";
		String sqlstr1="";

		sqlstr = "update contract_4material set material_status = 'δ����'";
		sqlstr1 = "update contract_4material set material_status = '�Ѹ���δ����'";

		sqlstr1temp= ",materialRD_date='',materialRD_name=(select name from base_user where id='"+dqczy+"')";
		sqlstr1temp+= " where material_type<>'ֻ����'and id='"+ids[i]+"'";

		sqlstr=sqlstr+sqlstr1temp;
		flag += db.executeUpdate(sqlstr); //���в��ǡ�ֻ���¡��ĺ͡�
		sqlstr1temp+="  and material_type<>'ֻ����'";
		sqlstr1=sqlstr1+sqlstr1temp;
		flag1 += db.executeUpdate(sqlstr1);//����+���յ�����
	}
}


db.close();
if((length-flag==0)){
msg = length + "�ݲ����Ѵ�������ֻ���յ���"+(flag-flag1)+"��������+���յ���"+flag1+"����ִ��"; 
}else{
msg = length + "�ݲ����Ѵ�������ֻ���յ���"+(flag-flag1)+"��������+���յ���"+flag1+"����ֻ���µ�������"+(length-flag)+"����ִ��"; 
}
	

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


