<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String czy=(String) session.getAttribute("czyid");


String sqlstr;
int i;
String czid;
String zzsmc;

ResultSet rs;

//��ȡϵͳʱ��
String datestr=getSystemDate(1); 

//try {
    if (request.getParameter("savetype")!=null)
    {
        String stype=request.getParameter("savetype");
        if (stype.indexOf("add")>=0)     //��������
       {
            zzsmc=getStr(request.getParameter("zzsmc"));
            
            sqlstr="insert into jb_zlwjzzs(zzsmc,gxrq,czy) values ('"+zzsmc+"',"+datestr+",'"+czy+"')";
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
            czid=getStr(request.getParameter("kid"));
            zzsmc=getStr(request.getParameter("zzsmc"));
			
	
                sqlstr="update jb_zlwjzzs set zzsmc='"+zzsmc+"' where id='"+czid+"'";
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
            czid=getStr(request.getParameter("id"));
            sqlstr="delete from jb_zlwjzzs where id='"+czid+"'";
            i=db.executeUpdate(sqlstr); 


			%>
				<script>
                window.close();
                opener.alert("ɾ���ɹ�!");
				opener.location.reload();
				</script>
			<%       }
   
   
}
db.close();
%>


</BODY>
</HTML>
