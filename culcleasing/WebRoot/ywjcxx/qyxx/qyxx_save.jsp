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
        if (stype.indexOf("add")>=0)     //��������
       {
            qyid=getStr(request.getParameter("qyid"));
            qymc=getStr(request.getParameter("qymc"));
		gjid=getStr(request.getParameter("gjid"));
            //�ж������Ƿ��ظ�
            sqlstr="select * from jb_qyxx where qyid='"+qyid+"'";
            rs=db.executeQuery(sqlstr); 
            if (rs.next())
            {
			%>
				<script>
                window.history.back();
                alert("����������������д����ظ�");
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
                opener.alert("��ӳɹ�!");
				opener.location.reload();
				</script>
            <%

       }
       if (stype.indexOf("mod")>=0)      //�޸Ĳ���
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
                opener.alert("�޸ĳɹ�!");
				opener.location.reload();
				</script>
			<%
			}
			else
			{
			//�ж������Ƿ��ظ�
			int tempFlag = 1;
			
			sqlstr="select * from jb_qyxx where qyid='"+id+"'";
			rs=db.executeQuery(sqlstr); 
			if (rs.next())
			{
				tempFlag = 0;
			%>
				<script>
                window.history.back();
                alert("����������������д����ظ�");
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
                opener.alert("�޸ĳɹ�!");
				opener.location.reload();
				</script>
			<%
            }


			}

       }
       if (stype.indexOf("del")>=0)         //ɾ������
       {
            id=getStr(request.getParameter("id"));
            sqlstr="delete from jb_qyxx where id="+id;
            i=db.executeUpdate(sqlstr); 

			%>
				<script>
                window.close();
                opener.alert("ɾ���ɹ�!");
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
