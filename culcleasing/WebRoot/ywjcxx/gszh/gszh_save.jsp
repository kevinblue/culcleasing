<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 09.01.05 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>
<BODY>
<%
String sqlstr;
ResultSet rs;
String czy_name="";
String czy=(String) session.getAttribute("czyid");
System.out.println(czy+"122222222222222");
sqlstr="select name from base_user where id='"+czy+"' ";
//sqlstr=" select xm from jb_yhxx where id='"+czy+"' ";
rs=db.executeQuery(sqlstr); 
if(rs.next()) 
{
	//czy_name=getDBStr(rs.getString("xm"));
          czy_name=getDBStr(rs.getString("name"));
}
int i;
String czid;
String bank_name;
String acc_number;
String account;
String money;
String modify_date;
String modificator;
String subject_no;
String ncbank_code;
//获取系统时间
String datestr=getSystemDate(1);
//try {
    if (request.getParameter("savetype")!=null)
    {
        String stype=request.getParameter("savetype");
        if (stype.indexOf("add")>=0)     //新增操作
       {
            bank_name=getStr(request.getParameter("bank_name"));
            acc_number=getStr(request.getParameter("acc_number"));
            account=getStr(request.getParameter("account"));
			money=getMoneyStr(request.getParameter("bank_money"));
            subject_no=getStr(request.getParameter("subject_no"));
            ncbank_code=getStr(request.getParameter("ncbank_code"));
            ncbank_code=getStr(request.getParameter("ncbank_code"));
            sqlstr="insert into base_account(bank_name,bank_money,acc_number,account,subject_no,modify_date,modificator,ncbank_code) values ('"+bank_name+"',"+money+",'"+acc_number+"','"+account+"','"+subject_no+"',"+datestr+",'"+czy_name+"','"+ncbank_code+"')";
            System.out.println("======="+sqlstr);
            i=db.executeUpdate(sqlstr); 
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
            bank_name=getStr(request.getParameter("bank_name"));
            acc_number=getStr(request.getParameter("acc_number"));
            account=getStr(request.getParameter("account"));
			money=getMoneyStr(request.getParameter("bank_money"));
            subject_no=getStr(request.getParameter("subject_no"));
            ncbank_code=getStr(request.getParameter("ncbank_code"));
            sqlstr="update base_account set bank_name='"+bank_name+"',bank_money="+money+",acc_number='"+acc_number+"',account='"+account+"',modify_date="+datestr+",subject_no='"+subject_no+"',modificator='"+czy_name+"',ncbank_code='"+ncbank_code+"'  where id='"+czid+"'";
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
            sqlstr="delete from base_account where id='"+czid+"'";
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