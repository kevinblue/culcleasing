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
String id;
String gjid;
String qyid;
String sfmc;
String gxrq;
ResultSet rs;

//获取系统时间
String datestr=getSystemDate(1); 

//try {
    if (request.getParameter("savetype")!=null)
    {
        String stype=request.getParameter("savetype");
        if (stype.indexOf("add")>=0)     //新增操作
       {
            id=getStr(request.getParameter("id"));
			qyid=getStr(request.getParameter("qyid"));
			sfmc=getStr(request.getParameter("sfmc"));
            //判断主键是否重复
            sqlstr="select * from jb_ssxx where id='"+id+"'";
            rs=db.executeQuery(sqlstr); 
            if (rs.next())
            {
			%>
				<script>
                window.history.back();
                alert("所填省份代码与现有代码重复");
				</script>
			<%

            }
            else
            {
            sqlstr="insert into jb_ssxx (id,qyid,sfmc,czy,gxrq) values ('"+id+"','"+qyid+"','"+sfmc+"',"+czy+",getdate())";
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
            czid=getStr(request.getParameter("czid")); 
            qyid=getStr(request.getParameter("qyid"));
            sfmc=getStr(request.getParameter("sfmc"));
            String kid=getStr(request.getParameter("kid"));

			
			//判断主键是否重复
			int tempFlag = 1;
		if (kid.equals(id))
		{}
		else
			{
				sqlstr="select * from jb_ssxx where id='"+id+"'";
				rs=db.executeQuery(sqlstr); 
				if (rs.next())
				{
					tempFlag = 0;
			%>
				<script>
                window.history.back();
                alert("所填省份代码与现有代码重复");
				</script>
            <%
				}
                                rs.close(); 



			}
            if (tempFlag!=0){
                sqlstr="update jb_ssxx set id='"+id+"',qyid='"+qyid+"',sfmc='"+sfmc+"',gxrq="+datestr+",czy='"+czy+"' where id='"+kid+"'";
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
       if (stype.indexOf("del")>=0)         //删除操作
       {
            czid=getStr(request.getParameter("id"));
            sqlstr="delete from jb_ssxx where id='"+czid+"'";
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
