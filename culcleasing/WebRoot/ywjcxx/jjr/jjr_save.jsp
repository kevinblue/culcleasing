<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 09.01.05 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>
<BODY>
<%
String sqlstr;
ResultSet rs;
String czy_name="";
String czy=(String) session.getAttribute("czyid");
sqlstr=" select xm from jb_yhxx where id='"+czy+"' ";
rs=db.executeQuery(sqlstr); 
if(rs.next()) 
{
	czy_name=getDBStr(rs.getString("xm"));
}
int i;
String czid;
String date;
String ishr;
String notes;
String returnStr1="";
String num="";
//��ȡϵͳʱ��
String datestr=getSystemDate(1);
//try {
    if (request.getParameter("savetype")!=null)
    {
        String stype=request.getParameter("savetype");
        if (stype.indexOf("add")>=0)     //��������
       {
            date=getStr(request.getParameter("date"));
            ishr=getStr(request.getParameter("ishr"));
            notes=getStr(request.getParameter("notes"));
            sqlstr="select count(*) as num from hr_jjr where date='"+date+"'";
            rs=db.executeQuery(sqlstr);
            if(rs.next())
           {
                 num = getDBStr(rs.getString("num"));
           }
                 if (num=="1"){
				returnStr1 ="�����Ѵ���,�޷����";
				 }
            else
		   {
            sqlstr="insert into hr_jjr(date,ishr,notes) values ('"+date+"','"+ishr+"','"+notes+"')";
            i=db.executeUpdate(sqlstr); 
               returnStr1 ="��ӳɹ�!";
           }
			%>
				<script>
                window.close();
                opener.alert("<%=returnStr1%>");
				opener.location.reload();
				</script>
            <%           
       }
       if (stype.indexOf("mod")>=0)      //�޸Ĳ���
       {
       		czid=getStr(request.getParameter("kid"));
            date=getStr(request.getParameter("date"));
            ishr=getStr(request.getParameter("ishr"));
            notes=getStr(request.getParameter("notes"));
           
            
            sqlstr="update hr_jjr set date='"+date+"',ishr='"+ishr+"',notes='"+notes+"'where id='"+czid+"'";
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
            sqlstr="delete from hr_jjr where id='"+czid+"'";
            i=db.executeUpdate(sqlstr);
			%>
				<script>
                window.close();
                opener.alert("ɾ���ɹ�!");
				opener.location.reload();
				</script>
			<%
       }   
%>
<%
}
db.close();
%>
</BODY>
</HTML>