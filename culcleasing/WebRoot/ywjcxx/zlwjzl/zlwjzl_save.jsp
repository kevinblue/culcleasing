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
String lxmc;
String hy;
ResultSet rs;

//��ȡϵͳʱ��
String datestr=getSystemDate(1); 


    if (request.getParameter("savetype")!=null)
    {
        String stype=request.getParameter("savetype");
        if (stype.indexOf("add")>=0)     //��������
       {
            id=getStr(request.getParameter("id"));
            lxmc=getStr(request.getParameter("lxmc"));
            hy=getStr(request.getParameter("hy"));
            //�ж������Ƿ��ظ�
            sqlstr="select * from jb_zlwjlb where id='"+id+"'";
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
            sqlstr="insert into jb_zlwjlb(id,lxmc,hy,gxrq,czy) values ('"+id+"','"+lxmc+"','"+hy+"',"+datestr+",'"+czy+"')";
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
            czid=getStr(request.getParameter("czid"));
            id=getStr(request.getParameter("id"));
            lxmc=getStr(request.getParameter("lxmc"));
            hy=getStr(request.getParameter("hy"));
            String kid=getStr(request.getParameter("kid"));

			
			//�ж������Ƿ��ظ�
			int tempFlag = 1;
		//	if (kid!=hydldm)
		if (kid.equals(id))
		{}
		else
			{
				sqlstr="select * from jb_zlwjlb where id='"+id+"'";
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
				}
                                rs.close(); 
			}
            if (tempFlag!=0){
                sqlstr="update jb_zlwjlb set id='"+id+"',lxmc='"+lxmc +"',hy='"+hy +"',gxrq="+datestr+",czy='"+czy+"' where id='"+kid+"'";
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
       if (stype.indexOf("del")>=0)         //ɾ������
       {
            czid=getStr(request.getParameter("id"));
            sqlstr="delete from jb_zlwjlb where id='"+czid+"'";
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
