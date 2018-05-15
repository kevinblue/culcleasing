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
String hyxldm,hyxlmc,ssdl;
ResultSet rs;

//获取系统时间
String datestr=getSystemDate(1); 

//try {
    if (request.getParameter("savetype")!=null)
    {
        String stype=request.getParameter("savetype");
        if (stype.indexOf("add")>=0)     //新增操作
       {
            hyxldm=getStr(request.getParameter("hyxldm"));
            hyxlmc=getStr(request.getParameter("hyxlmc"));
            ssdl=getStr(request.getParameter("ssdl"));
            //判断主键是否重复
            sqlstr="select * from kh_hyxl_gb where hyxlbh='"+hyxldm+"'";
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
            sqlstr="insert into kh_hyxl_gb(hyxlbh,hyxlmc,gxrq,czy) values ('"+hyxldm+"','"+hyxlmc+"',"+datestr+",'"+czy+"')";
            i=db.executeUpdate(sqlstr); 

			%>
				<script>
                window.close();
                opener.alert("添加成功!");
				opener.location.reload();
				</script>
            <%

            }
            rs.close(); 

       }
       if (stype.indexOf("mod")>=0)      //修改操作
       {
            czid=getStr(request.getParameter("czid"));
            hyxldm=getStr(request.getParameter("hyxldm"));
            hyxlmc=getStr(request.getParameter("hyxlmc"));

            String kid=getStr(request.getParameter("kid"));

			
			//判断主键是否重复
			int tempFlag = 1;
		if (kid.equals(hyxldm))
		{}
		else
			{
				sqlstr="select * from kh_hyxl_gb where hyxlbh='"+hyxldm+"'";
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
				}
				rs.close(); 

			}
            if (tempFlag!=0){
                sqlstr="update kh_hyxl_gb set hyxlbh='"+hyxldm+"',hyxlmc='"+hyxlmc+"',gxrq="+datestr+",czy='"+czy+"' where hyxlbh='"+kid+"'";
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
            sqlstr="delete from kh_hyxl_gb where hyxlbh='"+czid+"'";
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
