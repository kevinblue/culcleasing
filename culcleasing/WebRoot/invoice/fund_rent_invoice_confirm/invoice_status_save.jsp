<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/calend.js"></script>
</head>

<BODY>
<%
String czyid = (String) session.getAttribute("czyid");
String id = getStr( request.getParameter("id") );

String invoice_statues=getStr( request.getParameter("invoice_statues") );
String invoice_status="";
String stype = getStr( request.getParameter("savetype") );
if(invoice_statues.equals("δ����")){
	invoice_status="0";
}else if (invoice_statues.equals("��ȷ��")){
	invoice_status="3";
}else if (invoice_statues.equals("���˻�")){
	invoice_status="1";
}else if (invoice_statues.equals("������")){
	invoice_status="2";
}
Map<String,String> param=new HashMap<String,String>();
					param.put("invoice_status" ,invoice_status);
					param.put("modificator" ,czyid);
					param.put("modificator" ,"");
					
String sqlstr="";
ResultSet rs;
String datestr = getSystemDate(1); //��ȡϵͳʱ��

if ( stype.equals("mod") ){      //�޸Ĳ���	
	 String column="";
		for(String key:param.keySet()){
		    if(column.length()>0){column+=",";}
	         column+=key+"='"+param.get(key)+"'";
	    }
		sqlstr="update rent_invoice_info  set "+column+" where id='"+id+"'";
         System.out.println("sqlstrsqlstr=="+sqlstr);		
		int i=0;
		i=db.executeUpdate(sqlstr); 
		if(i!=0){
%>
		<script>			
		window.close();
		opener.alert("�޸ĳɹ�!");
		opener.location.reload();
		</script>
<%
		}else{
%>
		<script>
			window.alert("�޸�ʧ��!");
			window.history.go(-1);
		</script>
<%
		}
}
db.close();
%>


</BODY>
</HTML>
