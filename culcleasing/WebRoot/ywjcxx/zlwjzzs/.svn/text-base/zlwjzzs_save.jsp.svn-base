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

//获取系统时间
String datestr=getSystemDate(1); 

//try {
    if (request.getParameter("savetype")!=null)
    {
        String stype=request.getParameter("savetype");
        if (stype.indexOf("add")>=0)     //新增操作
       {
            zzsmc=getStr(request.getParameter("zzsmc"));
            
            sqlstr="insert into jb_zlwjzzs(zzsmc,gxrq,czy) values ('"+zzsmc+"',"+datestr+",'"+czy+"')";
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
            zzsmc=getStr(request.getParameter("zzsmc"));
			
	
                sqlstr="update jb_zlwjzzs set zzsmc='"+zzsmc+"' where id='"+czid+"'";
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
            sqlstr="delete from jb_zlwjzzs where id='"+czid+"'";
            i=db.executeUpdate(sqlstr); 


			%>
				<script>
                window.close();
                opener.alert("删除成功!");
				opener.location.reload();
				</script>
			<%       }
   
   
}
db.close();
%>


</BODY>
</HTML>
