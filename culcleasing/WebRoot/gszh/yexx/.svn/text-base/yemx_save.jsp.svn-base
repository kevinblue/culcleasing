<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
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
String sqlstr;
int i;
String czid;
String zh;
String zhmc;
String szfs;
String jlrq;
String jebb;
String jewb;
String memo;
String memo2;

ResultSet rs;

String czy=(String) session.getAttribute("czyid");

//获取系统时间
String datestr=getSystemDate(1); 


    if (request.getParameter("savetype")!=null)
    {
        String stype=request.getParameter("savetype");
	
        if (stype.indexOf("add")>=0)//新增操作--------------------------------------------------
       {
        
        
            zh=getStr(request.getParameter("zh"));
            zhmc=getStr(request.getParameter("zhmc"));
            szfs=getStr(request.getParameter("szfs"));
            jlrq=getStr(request.getParameter("jlrq"));
            jebb=getStr(request.getParameter("jebb"));
            jewb=getStr(request.getParameter("jewb"));
            memo=getStr(request.getParameter("memo"));
			memo2=getStr(request.getParameter("memo2"));
           if (jebb.equals("")) jebb="null";
		   if (jewb.equals("")) jewb="null";

            sqlstr="insert into zh_xjye_mx(zh,zhmc,szfs,jlrq,lrsj,jebb,jewb,memo,memo2) values ('"+zh+"','"+zhmc+"','"+szfs+"','"+jlrq+"',"+datestr+","+jebb+","+jewb+",'"+memo+"','"+memo2+"')";
	    i=db.executeUpdate(sqlstr);
 	    // out.print(sqlstr);
  	    %>
				<script>
                window.close();
                opener.alert("添加成功!");
				opener.location.reload();
				</script>
            <%	
       }
       if (stype.indexOf("mod")>=0)//修改操作--------------------------------------------------
       {
             czid=getStr(request.getParameter("id"));
           zh=getStr(request.getParameter("zh"));
            zhmc=getStr(request.getParameter("zhmc"));
            szfs=getStr(request.getParameter("szfs"));
            jlrq=getStr(request.getParameter("jlrq"));
            jebb=getStr(request.getParameter("jebb"));
            jewb=getStr(request.getParameter("jewb"));
            memo=getStr(request.getParameter("memo"));
			 memo2=getStr(request.getParameter("memo2"));

            sqlstr="update zh_xjye_mx set zh='"+zh+"',zhmc='"+zhmc+"',szfs='"+szfs+"',jlrq='"+jlrq+"',lrsj="+datestr+",jebb="+jebb+",jewb="+jewb+",memo='"+memo+"',memo2='"+memo2+"' where id='"+czid+"'";
            i=db.executeUpdate(sqlstr);
             //   out.print(sqlstr);
			%>
				<script>
                window.close();
                opener.alert("修改成功!");
				opener.location.reload();
				</script>
			<%
       }
       if (stype.indexOf("del")>=0)//删除操作--------------------------------------------------
       {
           czid=getStr(request.getParameter("id"));//先插一同样的删除记录,再置原数据为历史记录

            sqlstr="delete from zh_xjye_mx where id='"+czid+"'";
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
