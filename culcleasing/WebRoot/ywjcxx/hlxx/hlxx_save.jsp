<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String czy=(String) session.getAttribute("czyid");


String sqlstr;
int i;
String czid;
String bzid;
String hl;
String ksrq;
String jsrq;
ResultSet rs;

//��ȡϵͳʱ��
String datestr=getSystemDate(1); 

//try {
    if (request.getParameter("savetype")!=null)
    {
        String stype=request.getParameter("savetype");
        if (stype.indexOf("add")>=0)     //��������
       {
            bzid=getStr(request.getParameter("bzid"));
            hl=getStr(request.getParameter("hl"));
            ksrq=getStr(request.getParameter("ksrq"));
            jsrq=getStr(request.getParameter("jsrq"));
            if ((jsrq==null) || (jsrq.equals("")))
            {
            jsrq="null";
            }
            else
            {
            jsrq="'"+jsrq+"'";
            }
            sqlstr="insert into jb_hlxx(bzid,hl,ksrq,jsrq,gxrq,czy) values ('"+bzid+"','"+hl+"','"+ksrq+"',"+jsrq+","+datestr+",'"+czy+"')";
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
            bzid=getStr(request.getParameter("bzid"));
            hl=getStr(request.getParameter("hl"));
            ksrq=getStr(request.getParameter("ksrq"));
            jsrq=getStr(request.getParameter("jsrq"));
            if ((jsrq==null) || (jsrq.equals("")))
            {
            jsrq="null";
            }
            else
            {
            jsrq="'"+jsrq+"'";
            }			
	
                sqlstr="update jb_hlxx set bzid='"+bzid+"',hl='"+hl+"',ksrq='"+ksrq+"',jsrq="+jsrq+",gxrq="+datestr+",czy='"+czy+"' where id='"+czid+"'";
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
            sqlstr="delete from jb_hlxx where id='"+czid+"'";
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
