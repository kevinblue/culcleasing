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
String sqlIds = getStr( request.getParameter("sqlIds") );//ѡ����
System.out.println("dddddddd"+sqlIds);	
String stype = "mod";
String wh_status ="��ȷ��";
Map<String,String> param=new HashMap<String,String>();
					param.put("wh_status" ,"��ȷ��");
String sqlstr="";
ResultSet rs;
String datestr = getSystemDate(1); //��ȡϵͳʱ��

if ( stype.equals("mod") ){      //�޸Ĳ���	
	 String column="";
		for(String key:param.keySet()){
		    if(column.length()>0){column+=",";}
	         column+=key+"='"+param.get(key)+"'";
	    }
		sqlstr="update base_taxPayer  set "+column+" where id in ("+sqlIds+")";
         System.out.println("sqlstrsqlstr=="+sqlstr);		
		int i=0;
		i=db.executeUpdate(sqlstr); 
		if(i!=0){
%>
		<script>			
		window.close();
		opener.alert("ȷ�ϳɹ�!");
		opener.location.reload();
		</script>
<%
		}else{
%>
		<script>
			window.alert("ȷ��ʧ��!");
			window.history.go(-1);
		</script>
<%
		}
}
db.close();
%>


</BODY>
</HTML>
