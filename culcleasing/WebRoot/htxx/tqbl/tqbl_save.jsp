<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<%@ page import="com.*" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
	<script src="../../js/calend.js"></script>

</head>

<BODY>
<%
String sqlstr;
int i;

String fiveclass;//����
String scale;//��ǰ����
String native_resi;
String sd;


String czy=(String) session.getAttribute("czyid");

String id=getStr(request.getParameter("id"));

//��ȡϵͳʱ��
String datestr=getSystemDate(1); 

    if (request.getParameter("savetype")!=null)
    {
        String stype=request.getParameter("savetype");
        if (stype.indexOf("add")>=0)     //��������
       {          
		  
   
            fiveclass=getStr(request.getParameter("fiveclass"));  
            scale=getStr(request.getParameter("scale"));
            native_resi=getStr(request.getParameter("native_resi"));
            sd=getStr(getStr(request.getParameter("sd")));
            sqlstr="insert into base_extractscale(fiveclass,scale)";
            sqlstr+=" values ('"+fiveclass+"','"+scale+"')";
			System.out.println("ttt"+sqlstr);
            i=db.executeUpdate(sqlstr); 

%>
	<script>
                window.close();
                opener.alert("��ӳɹ�!");
		opener.location.reload();
	</script>
<%
       }
       if (stype.indexOf("mod")>=0)      //�޸Ĳ���
       {
            id=getStr(request.getParameter("id"));
           
                  
          fiveclass=getStr(request.getParameter("fiveclass"));
          scale=getStr(request.getParameter("scale"));
              // scale=getStr(request.getParameter("scale"));
          native_resi=getStr(request.getParameter("native_resi"));  
           // amout=getStr(request.getParameter("amout"));
            
         
            
            sqlstr="update base_extractscale set fiveclass='"+native_resi+"',scale='"+scale+"'";
			sqlstr+=" where id="+id;
			System.out.println(sqlstr);
            i=db.executeUpdate(sqlstr);
%>
	<script>
                window.close();
                opener.alert("�޸ĳɹ�!");
		opener.location.reload();
	</script>
<%

       }
       if (stype.indexOf("del")>=0)         //ɾ������
       {
            czy=getStr(request.getParameter("id"));
            sqlstr="delete from base_extractscale where id="+id;
            i=db.executeUpdate(sqlstr); 
			

%>
	<script>
                window.close();
                opener.alert("ɾ���ɹ�!");
		opener.location.reload();
	</script>
<%			
       }
}
db.close();
%>


</BODY>
</HTML>
