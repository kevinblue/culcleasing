<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");
String czid = getStr( request.getParameter("czid") );
System.out.println("czid&&&&&&&&&&&&&&&&&&&&&&"+czid);
String stype = getStr( request.getParameter("savetype") );
System.out.println(">>>>>>>>>>>>><<<<<<<<<<<<<<"+stype);
String sqlstr;
ResultSet rs;
String datestr = getSystemDate(1); //��ȡϵͳʱ��

//if ( stype.equals("mod") ){      //�޸Ĳ���
String l_id=getStr(request.getParameter("l_id"));

System.out.println("l_id^^^^^^^^^^^^^^^^^^^^^"+l_id);
int flag=0;
int flagt=0;

String [] sid = l_id.split(",");
System.out.println("sid++"+sid[0]);
System.out.println("sid++"+sid.length);
//�õ�Ҫִ�е�sql���
String sql="";
String corpus="";
String factoring="";
String  interest="";
String id="";
for (int i=0;i<sid.length;i++) {
String sqls="select * from fund_rent_plan where id='"+sid[i]+"'";
 rs = db.executeQuery(sqls); 
 System.out.println("%%%%%%%%%%%%%%"+sqls);
if(rs.next()){
	id=getDBStr(rs.getString("id"));
	System.out.println("~~~~~~~"+id);
	factoring=getDBStr(rs.getString("factoring"));
	System.out.println("dfdfdfd"+factoring);
corpus=getDBStr(rs.getString("corpus"));
interest=getDBStr(rs.getString("interest"));
System.out.println("@@@@@@"+corpus);
System.out.println("@@@@@@"+interest);


sql="update fund_rent_plan set factoring='��',factoring_pringcipal='"+corpus+"',factoring_rantal='"+interest+"' where id='"+id+"' ";
flag = db.executeUpdate(sql);
System.out.println("flag&********"+sql);
System.out.println("flag&********"+flag);
//String sqlt="update fund_rent_plan set factoring='��',factoring_pringcipal='0',factoring_rantal='0' where id='"+id+"' and factoring='��'";
//flagt=db.executeUpdate(sqlt);
}
}

%>
		<%	

db.close();
%>

		<script>
        opener.window.location.href = "factoring.jsp";
		alert("�޸ĳɹ�!");
		this.close();  
		</script>
</BODY>
</HTML>

