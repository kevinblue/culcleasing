<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.log.LogWriter"%>
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String stype =getStr(request.getParameter("savetype"));
//LogWriter.logDebug(request,"����Ҫ��savetype:"+stype);
String id =getStr(request.getParameter("id"));
//LogWriter.logDebug(request,"����Ҫ��base_user_id:"+id);
String name =getStr(request.getParameter("name"));
//LogWriter.logDebug(request,"����Ҫ��name:"+name);
String dept_name =getStr(request.getParameter("dept_name"));
String phone =getStr(request.getParameter("phone"));
String code =getStr(request.getParameter("code"));

String area =getStr(request.getParameter("qymc"));
String provice =getStr(request.getParameter("sfmc"));
String city =getStr(request.getParameter("csmc"));


int flag=0;
String sqlstr;
ResultSet rs;

String datestr = getSystemDate(0); //��ȡϵͳʱ��


	 if ( stype.equals("mod") ){        //��Ӳ���
		//���ж����ݿ����Ƿ����
		String Sid="";
		String sql = "select id from base_user_responsible where base_user_id='"+id+"'";
		//LogWriter.logDebug(request,"����Ҫ��sql:"+sql);
		rs = db.executeQuery(sql);
		if(rs.next()){
				Sid =getDBStr(rs.getString("id"));
		}
		LogWriter.logDebug(request,"����Ҫ��Sid:"+Sid);
		rs.close();
		if(Sid!=""){
			sqlstr = "update base_user_responsible set area='"+area+"',provice='"+provice+"',";
				sqlstr+= "city='"+city+ "' where base_user_id='"+id+"'";
			LogWriter.logDebug(request,"11111111111111111����Ҫ��sqlstr:"+sqlstr);
				flag = db.executeUpdate(sqlstr);
		}else{
			sqlstr ="insert into base_user_responsible (base_user_id,area,provice,city)values('"+id+"','"+area+"','"+provice+"','"+city+"')";
			flag=db.executeUpdate(sqlstr);
			LogWriter.logDebug(request,"22222222222222222����Ҫ��sqlstr:"+sqlstr);
		}
	
		
	%>
	<script type="text/javascript">
		window.close();
		opener.alert("�޸ĳɹ�!");
		opener.location.reload();
	</script>
	<%
	
	}
	db.close();
	%>
</BODY>
</HTML>
