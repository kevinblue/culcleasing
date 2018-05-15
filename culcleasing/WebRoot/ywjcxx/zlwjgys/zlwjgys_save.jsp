<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
String wjid;
String gysid;
String dj;
String bz;
String zt;
ResultSet rs;

//获取系统时间
String datestr=getSystemDate(1); 

//try {
    if (request.getParameter("savetype")!=null)
    {
        String stype=request.getParameter("savetype");
        if (stype.indexOf("add")>=0)     //新增操作
       {
            wjid=getStr(request.getParameter("wjid"));
            gysid=getStr(request.getParameter("gysid"));
            dj=getStr(request.getParameter("dj"));
            bz=getStr(request.getParameter("bz"));
            zt=getStr(request.getParameter("zt"));
            sqlstr="insert into jb_zlwjgys(wjid,gysid,dj,bz,zt,gxrq,czy) values ('"+wjid+"','"+gysid+"',"+dj+",'"+bz+"','"+zt+"',"+datestr+",'"+czy+"')";
            out.print(sqlstr);
            i=db.executeUpdate(sqlstr); 
           
       }
       if (stype.indexOf("mod")>=0)      //修改操作
       {    czid=getStr(request.getParameter("czid"));
            wjid=getStr(request.getParameter("wjid"));
            gysid=getStr(request.getParameter("gysid"));
            dj=getStr(request.getParameter("dj"));
            bz=getStr(request.getParameter("bz"));
            zt=getStr(request.getParameter("zt"));
	
                sqlstr="update jb_zlwjgys set wjid='"+wjid+"',gysid='"+gysid+"',dj='"+dj+"',bz='"+bz+"',zt='"+zt+"',gxrq="+datestr+",czy='"+czy+"' where id='"+czid+"'";
                out.print(sqlstr);
                i=db.executeUpdate(sqlstr); 
  

       }
       if (stype.indexOf("del")>=0)         //删除操作
       {
            czid=getStr(request.getParameter("id"));
            sqlstr="delete from jb_zlwjgys where id='"+czid+"'";
            out.print(sqlstr);
            i=db.executeUpdate(sqlstr); 
       }
   
   
%>
<table width=100% border=1 > 
<% 
String sql = "select * from jb_zlwjgys"; 
rs=db.executeQuery(sql); 
while(rs.next()) { 
out.println("<tr><td>" + rs.getString(1) + "</td><td>" + rs.getString(2) + "</td><td>" + rs.getString(3) + "</td><td>" + rs.getString(4) + "</td></tr>"); 
} 
%> 
</table> 
<% 
rs.close(); 

%> 
<%


}
//} 
//catch(SQLException ex) {
//out.print(ex.getMessage()); 
//} 
//finally
//{
db.close();
//}
%>


</BODY>
</HTML>
