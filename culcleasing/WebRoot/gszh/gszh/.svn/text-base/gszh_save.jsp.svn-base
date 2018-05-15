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
String yhid;
String zhmc;
String khzh;
String zhlx;
String zhbz;
String zhxz;
String wydz;
String dhyhdh;
String dhyhdl;
String lxr;
String lxrdh;
String zhzt;
String edqsrq;
String edzzrq;
String sxed;

//获取系统时间
String datestr=getSystemDate(1); 

//try {
    if (request.getParameter("savetype")!=null)
    {
        String stype=request.getParameter("savetype");
        if (stype.indexOf("add")>=0)     //新增操作
       {
            yhid=getStr(request.getParameter("yhid"));
	    zhmc=getStr(request.getParameter("zhmc"));
 	    khzh=getStr(request.getParameter("khzh"));
 	    zhbz=getStr(request.getParameter("zhbz"));
		zhxz=getStr(request.getParameter("zhxz"));
            zhlx=getStr(request.getParameter("zhlx"));
            wydz=getStr(request.getParameter("wydz"));
	    dhyhdh=getStr(request.getParameter("dhyhdh"));
	    dhyhdl=getStr(request.getParameter("dhyhdl"));
   	    lxr=getStr(request.getParameter("lxr"));
	    lxrdh=getStr(request.getParameter("lxrdh"));		
            zhzt=getStr(request.getParameter("zhzt"));
            edqsrq=getStr(request.getParameter("edqsrq"));
	    edzzrq=getStr(request.getParameter("edzzrq"));
	    sxed=getStr(request.getParameter("sxed")); 	
	    
	    if (edqsrq.equals("")) {edqsrq="null";} else{edqsrq="'"+edqsrq+"'";}
	    if (edzzrq.equals("")) {edzzrq="null";} else{edzzrq="'"+edzzrq+"'";}
	    if (sxed.equals("")) sxed="null";	
	   
            sqlstr="insert into jb_nbzhxx(yhid,zhmc,khzh,zhbz,zhlx,wydz,dhyhdh,dhyhdl,lxr,lxrdh,zhzt,gxrq,czy,edqsrq,edzzrq,sxed,zhxz) values ('"+yhid+"','"+zhmc+"','"+khzh+"','"+zhbz+"','"+zhlx+"','"+wydz+"','"+dhyhdh+"','"+dhyhdl+"','"+lxr+"','"+lxrdh+"','"+zhzt+"',"+datestr+",'"+czy+"',"+edqsrq+","+edzzrq+","+sxed+",'"+zhxz+"')";
            i=db.executeUpdate(sqlstr); 
            //out.print(sqlstr);
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
            zhbz=getStr(request.getParameter("zhbz"));	
			zhmc=getStr(request.getParameter("zhmc"));
				zhxz=getStr(request.getParameter("zhxz"));
            zhlx=getStr(request.getParameter("zhlx"));
            wydz=getStr(request.getParameter("wydz"));
	    dhyhdh=getStr(request.getParameter("dhyhdh"));
	    dhyhdl=getStr(request.getParameter("dhyhdl"));
   	    lxr=getStr(request.getParameter("lxr"));
	    lxrdh=getStr(request.getParameter("lxrdh"));		
            zhzt=getStr(request.getParameter("zhzt"));
	    edqsrq=getStr(request.getParameter("edqsrq"));
	    edzzrq=getStr(request.getParameter("edzzrq"));
	    sxed=getStr(request.getParameter("sxed")); 	
	    
	    if (edqsrq.equals("")) {edqsrq="null";} else{edqsrq="'"+edqsrq+"'";}
	    if (edzzrq.equals("")) {edzzrq="null";} else{edzzrq="'"+edzzrq+"'";}
	    if (sxed.equals("")) sxed="null";			
		
            sqlstr="update jb_nbzhxx set     zhbz='"+zhbz+"',zhlx='"+zhlx+"',wydz='"+wydz+"',dhyhdh='"+dhyhdh+"',dhyhdl='"+dhyhdl+"',lxr='"+lxr+"',lxrdh='"+lxrdh+"',zhmc='"+zhmc+"',zhxz='"+zhxz+"',zhzt='"+zhzt+"',gxrq="+datestr+",czy='"+czy+"',edqsrq="+edqsrq+",edzzrq="+edzzrq+",sxed="+sxed+" where id='"+czid+"'";
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
            sqlstr="delete from jb_nbzhxx where id='"+czid+"'";
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
