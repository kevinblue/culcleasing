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
String czid="";
String hymlbh="";
String hymlmc="";
ResultSet rs;

//��ȡϵͳʱ��
String datestr=getSystemDate(1); 

    if (request.getParameter("savetype")!=null)
    {
        String stype=request.getParameter("savetype");
        if (stype.indexOf("add")>=0)     //��������
       {
            hymlbh=getStr(request.getParameter("hymlbh"));
            hymlmc=getStr(request.getParameter("hymlmc"));
            //�ж������Ƿ��ظ�
            sqlstr="select * from kh_hyml_gb where hymlbh='"+hymlbh+"'";
            rs=db.executeQuery(sqlstr); 
            if (rs.next())
            {

			%>
				<script>
                window.history.back();
                alert("����ͻ���ҵ������������д����ظ�");
				</script>
			<%

            }
            else
            {
            sqlstr="insert into kh_hyml_gb(hymlbh,hymlmc,gxrq,czy) values ('"+hymlbh+"','"+hymlmc+"',"+datestr+",'"+czy+"')";
            i=db.executeUpdate(sqlstr); 

			%>
				<script>
                window.close();
                opener.alert("��ӳɹ�!");
				opener.location.reload();
				</script>
            <%

            }
            rs.close(); 
       }
       if (stype.indexOf("mod")>=0)      //�޸Ĳ���
       {
            czid=getStr(request.getParameter("czid"));
            hymlbh=getStr(request.getParameter("hymlbh"));
            hymlmc=getStr(request.getParameter("hymlmc"));
            String kid=getStr(request.getParameter("kid"));

			
			//�ж������Ƿ��ظ�
			int tempFlag = 1;
		//	if (kid!=hydldm)
		if (kid.equals(hymlbh))
		{}
		else
			{
				sqlstr="select * from kh_hyml_gb where hymlbh='"+hymlbh+"'";
				rs=db.executeQuery(sqlstr); 
				if (rs.next())
				{
					tempFlag = 0;
				

			%>
				<script>
                window.history.back();
                alert("����ͻ���ҵ������������д����ظ�");
				</script>
            <%


				}
                                rs.close(); 

			}
            if (tempFlag!=0){
                sqlstr="update kh_hyml_gb set hymlbh='"+hymlbh+"',hymlmc='"+hymlmc +"',gxrq="+datestr+",czy='"+czy+"' where hymlbh='"+kid+"'";
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
            sqlstr="delete from kh_hyml_gb where hymlbh='"+czid+"'";
          
            i=db.executeUpdate(sqlstr); 
			

			%>
				<script>
                window.close();
                opener.alert("ɾ���ɹ�!");
				opener.location.reload();
				</script>
			<%			
       }
   
   
}
db.close();
%>


</BODY>
</HTML>
