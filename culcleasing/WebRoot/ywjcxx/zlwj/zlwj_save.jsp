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
String wjmc;
String wjlb;
String wjlx;
String jjdw;
String ckj;
String wjgg;
String zzs;
String cd;
String kd;
String gd;
String nbcpbm;
String zt;
String cptx;
String wjdqr;
String wjcd;
String scssscsx;
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
            //判断主键是否重复
            sqlstr="select * from jb_zlwjxx where id='"+id+"'";
            rs=db.executeQuery(sqlstr); 
            if (rs.next())
            {
			%>
				<script>
                window.history.back();
                alert("所填租赁物件代码与现有代码重复");
				</script>
            <%
			}
            else
            {



            wjmc=getStr(request.getParameter("wjmc"));
            wjlb=getStr(request.getParameter("wjlb"));
            wjlx=getStr(request.getParameter("wjlx"));
            jjdw=getStr(request.getParameter("jjdw"));
            
            ckj=getStr(request.getParameter("ckj"));
            wjgg=getStr(request.getParameter("wjgg"));
            zzs=getStr(request.getParameter("zzs"));
            cd=getStr(request.getParameter("cd"));
            
            kd=getStr(request.getParameter("kd"));
            gd=getStr(request.getParameter("gd"));
            nbcpbm=getStr(request.getParameter("nbcpbm"));
            zt=getStr(request.getParameter("zt"));
 
            cptx=getStr(request.getParameter("cptx"));
            wjdqr=getStr(request.getParameter("wjdqr"));
            wjcd=getStr(request.getParameter("wjcd"));
            
            sqlstr="insert into jb_zlwjxx(id,wjmc,wjlb,wjlx,jjdw,ckj,wjgg,zzs,cd,kd,gd,nbcpbm,zt,gxrq,czy,cptx,wjdqr,wjcd) values ('"+id+"','"+wjmc+"','"+wjlb+"','"+wjlx+"','"+jjdw+"','"+ckj+"','"+wjgg+"','"+zzs+"','"+cd+"','"+kd+"','"+gd+"','"+nbcpbm+"','"+zt+"',"+datestr+",'"+czy+"','"+cptx+"','"+wjdqr+"','"+wjcd+"')";
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
            czid=getStr(request.getParameter("kid"));
            wjmc=getStr(request.getParameter("wjmc"));
            wjlb=getStr(request.getParameter("wjlb"));
            wjlx=getStr(request.getParameter("wjlx"));
            jjdw=getStr(request.getParameter("jjdw"));
            
            ckj=getStr(request.getParameter("ckj"));
            wjgg=getStr(request.getParameter("wjgg"));
            zzs=getStr(request.getParameter("zzs"));
            cd=getStr(request.getParameter("cd"));
            
            kd=getStr(request.getParameter("kd"));
            gd=getStr(request.getParameter("gd"));
            nbcpbm=getStr(request.getParameter("nbcpbm"));
            zt=getStr(request.getParameter("zt"));
			
            cptx=getStr(request.getParameter("cptx"));
            wjdqr=getStr(request.getParameter("wjdqr"));
            wjcd=getStr(request.getParameter("wjcd"));
            scssscsx=getStr(request.getParameter("scssscsx"));
	
                sqlstr="update jb_zlwjxx set jjdw='"+jjdw+"',ckj='"+ckj+"',wjgg='"+wjgg+"',zzs='"+zzs+"',cd='"+cd+"',kd='"+kd+"',gd='"+gd+"',nbcpbm='"+nbcpbm+"',zt='"+zt+"',gxrq="+datestr+",czy='"+czy+"',cptx='"+cptx+"',wjdqr='"+wjdqr+"',wjcd='"+wjcd+"',scssscsx='"+scssscsx+"' where id='"+czid+"'";
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
            sqlstr="delete from jb_zlwjxx where id='"+czid+"'";
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
