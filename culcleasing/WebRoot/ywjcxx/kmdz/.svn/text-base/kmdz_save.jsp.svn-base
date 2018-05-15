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
System.out.println(czy+"122222222222222");
sqlstr="select name from base_user where id='"+czy+"' ";
//sqlstr=" select xm from jb_yhxx where id='"+czy+"' ";
rs=db.executeQuery(sqlstr); 
if(rs.next()) 
{
	//czy_name=getDBStr(rs.getString("xm"));
          czy_name=getDBStr(rs.getString("name"));
}
int i;
String czid;
String subject_num;
String subject_name;

String modify_date;
String modificator;
			subject_num=getStr(request.getParameter("subject_num"));
            subject_name=getStr(request.getParameter("subject_name"));
		

//获取系统时间
String datestr=getSystemDate(1);
//try {
    if (request.getParameter("savetype")!=null)
    {
        String stype=request.getParameter("savetype");
        if (stype.indexOf("add")>=0)     //新增操作
       {	

			
           
            sqlstr="insert into inter_subject_info(subject_num,subject_name,modify_date,modificator) values ('"+subject_num+"','"+subject_name+"',"+datestr+",'"+czy_name+"')";
            System.out.println("======="+sqlstr);
            i=db.executeUpdate(sqlstr); 
			%>
				<script>
                window.close();
                opener.alert("添加成功!");
				opener.location.reload();
				</script>
            <%           
       }
       if (stype.indexOf("mod")>=0)      //修改操作
       {
       			czid=getStr(request.getParameter("kid"));
 
            sqlstr="update inter_subject_info set subject_num='"+subject_num+"',subject_name='"+subject_name+"',modify_date="+datestr+",modificator='"+czy_name+"' where id='"+czid+"'";
            i=db.executeUpdate(sqlstr);
			%>
				<script>
                window.close();
                opener.alert("修改成功!");
				opener.location.reload();
				</script>
			<%
       }
       if (stype.indexOf("del")>=0)         //删除操作
       {
            czid=getStr(request.getParameter("id"));
            sqlstr="delete from inter_subject_info where id='"+czid+"'";
            i=db.executeUpdate(sqlstr);
			%>
				<script>
                window.close();
                opener.alert("删除成功!");
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