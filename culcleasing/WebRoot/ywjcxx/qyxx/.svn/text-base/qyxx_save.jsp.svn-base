<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
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
String gjid;
String qyid;
String id;
String mid;
String qymc;
ResultSet rs;


    if (request.getParameter("savetype")!=null)
    {
        String stype=request.getParameter("savetype");
        if (stype.indexOf("add")>=0)     //新增操作
       {
            qyid=getStr(request.getParameter("qyid"));
            qymc=getStr(request.getParameter("qymc"));
		gjid=getStr(request.getParameter("gjid"));
            //判断主键是否重复
            sqlstr="select * from jb_qyxx where qyid='"+qyid+"'";
            rs=db.executeQuery(sqlstr); 
            if (rs.next())
            {
			%>
				<script>
                window.history.back();
                alert("所填区域代码与现有代码重复");
				</script>
            <%
			}
            else
            {
            sqlstr="insert into dbo.jb_qyxx(qyid, gjid, qymc, gxrq, czy) values ('"+qyid+"','"+gjid+"','"+qymc+"',getdate(),'"+czy+"')";
            i=db.executeUpdate(sqlstr); 
            }
            rs.close(); 
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
		    id=getStr(request.getParameter("id"));
            gjid=getStr(request.getParameter("gjid"));
            qymc=getStr(request.getParameter("qymc"));
		mid=getStr(request.getParameter("mid"));
			
			String kid = getStr(request.getParameter(("kid")));
			if(mid.equals(id))
			{
				sqlstr = "update jb_qyxx set gjid='"+gjid+"', qymc='"+qymc+"', gxrq=getdate(), czy='"+czy+"' where qyid='"+mid+"'";
i=db.executeUpdate(sqlstr); 
			%>
				<script>
                window.close();
                opener.alert("修改成功!");
				opener.location.reload();
				</script>
			<%
			}
			else
			{
			//判断主键是否重复
			int tempFlag = 1;
			
			sqlstr="select * from jb_qyxx where qyid='"+id+"'";
			rs=db.executeQuery(sqlstr); 
			if (rs.next())
			{
				tempFlag = 0;
			%>
				<script>
                window.history.back();
                alert("所填区域代码与现有代码重复");
				</script>
            <%
                                rs.close(); 
			}
            if (tempFlag!=0){
                sqlstr="update dbo.jb_qyxx set qyid='"+id+"', gjid='"+gjid+"', qymc='"+qymc+"', gxrq=getdate(), czy='"+czy+"' where id="+kid;
                i=db.executeUpdate(sqlstr); 
			%>
				<script>
                window.close();
                opener.alert("修改成功!");
				opener.location.reload();
				</script>
			<%
            }


			}

       }
       if (stype.indexOf("del")>=0)         //删除操作
       {
            id=getStr(request.getParameter("id"));
            sqlstr="delete from jb_qyxx where id="+id;
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
