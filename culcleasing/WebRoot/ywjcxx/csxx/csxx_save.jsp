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
String csmc;
String sfid;
ResultSet rs;

//��ȡϵͳʱ��
String datestr=getSystemDate(1); 


    if (request.getParameter("savetype")!=null)
    {
        String stype=request.getParameter("savetype");
        if (stype.indexOf("add")>=0)     //��������
       {
            id=getStr(request.getParameter("id"));
            csmc=getStr(request.getParameter("csmc"));
	    sfid=getStr(request.getParameter("sfid"));
		
			sqlstr = "select * from jb_csxx where id='"+id+"'";
                        rs = db.executeQuery(sqlstr); 
			if ( rs.next() ) {
			%>
				<script>
				window.history.back();
				alert("������Ҵ��������д����ظ�");
				</script>
			<%
			}
			else
			{
				sqlstr="insert into jb_csxx(id,csmc,sfid,gxrq,czy) values ('"+id+"','"+csmc+"','"+sfid+"',"+datestr+",'"+czy+"')";
				System.out.println("sqlstradd============"+sqlstr);
				i=db.executeUpdate(sqlstr); 
			}
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
            csmc=getStr(request.getParameter("csmc"));
			sfid=getStr(request.getParameter("sfid"));
			String kid = getStr( request.getParameter("kid") );
	if ( kid.equals(id) ) {
		sqlstr = "update jb_csxx set sfid='"+sfid+"' ,csmc='" + csmc  + "',gxrq=" + datestr + ",czy='" + czy + "' where id='" + id + "'";
		System.out.println("sqlstrsqlstr=="+sqlstr);
		db.executeUpdate(sqlstr);
		%>
		<script>
			window.close();
			opener.alert("�޸ĳɹ�!");
			opener.location.reload();
		</script>
		<%
	} else {
		sqlstr = "select * from jb_gjxx where id='" + id + "'";
		rs = db.executeQuery(sqlstr); 
		if ( rs.next() ) {
		%>
			<script>
			window.history.back();
			alert("������Ҵ��������д����ظ�");
			</script>
		<%
		} else {
			sqlstr = "update jb_csxx set id='" + id  + "',csmc='" + csmc  + "',sfid='"+sfid+"',gxrq=" + datestr + ",czy='" + czy + "' where id='" + kid + "'";
			System.out.println("sqlstrsqlstr=="+sqlstr);
			db.executeUpdate(sqlstr);	
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
            sqlstr="delete from jb_csxx where id='"+id+"'";
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
