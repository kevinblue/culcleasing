<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String sqlstr;
int i;
String czid;
String tmid;
String pfyj;
String fz;
String xh;
String his;
ResultSet rs;

String czy=(String) session.getAttribute("czyid");

//获取系统时间
String datestr=getSystemDate(1); 


    if (request.getParameter("savetype")!=null)
    {
        String stype=request.getParameter("savetype");
        if (stype.indexOf("add")>=0)     //新增操作
       {
            tmid=getStr(request.getParameter("tmid"));
            pfyj=getStr(request.getParameter("pfyj"));
            fz=getStr(request.getParameter("fz"));
            xh=getStr(request.getParameter("xh"));
            his=getStr(request.getParameter("his"));            

            
            sqlstr="insert into jb_pgmx_tmpfbz (tmid,pfyj,fz,xh,his,djr, djrq, gxr, gxrq)";
            sqlstr=sqlstr+" values ("+tmid+",'"+pfyj+"','"+fz+"',"+xh+","+his+",'"+czy+"',"+datestr+",'"+czy+"',"+datestr+")";
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
            czid=getStr(request.getParameter("id"));
            tmid=getStr(request.getParameter("tmid"));
            pfyj=getStr(request.getParameter("pfyj"));
            fz=getStr(request.getParameter("fz"));
            xh=getStr(request.getParameter("xh"));
            his=getStr(request.getParameter("his"));            

	
            sqlstr="update jb_pgmx_tmpfbz set tmid='"+tmid+"',pfyj='"+pfyj+"',fz='"+fz+"',xh="+xh+",his="+his;
            sqlstr+=",gxr='"+czy+"',gxrq="+datestr+" where id="+czid;
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
            sqlstr="delete from jb_pgmx_tmpfbz where id="+czid;
            i=db.executeUpdate(sqlstr); 
			
%>
	<script>
                window.close();
                opener.alert("删除成功!");
		opener.location.reload();
	</script>
<%			
       }
}
db.close();
%>


</BODY>
</HTML>
