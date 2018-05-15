<%@ page contentType="text/html; charset=gbk" language="java"%>
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
String sqlstr;
String returnStr="";
String returnStr1="";
String num="";

ResultSet rs;
String czy_name="";
String feetype_number="";
String finance_code="";
String paytype="";
String czy=(String) session.getAttribute("czyid");
int i;
String czid;
String feetype_name;


String datestr = getSystemDate(0); //获取系统时间
if (request.getParameter("savetype")!=null)
    {
        String stype=request.getParameter("savetype");
	if ( stype.equals("add") ){        //添加操作
			feetype_number=getStr(request.getParameter("feetype_number"));
			finance_code=getStr(request.getParameter("finance_code"));
            feetype_name=getStr(request.getParameter("feetype_name"));
            paytype=getStr(request.getParameter("paytype"));
            sqlstr="select * from base_feetype where feetype_number='"+feetype_number+"'";
		rs = db.executeQuery(sqlstr); 
		if ( rs.next() ) {
		%>
			<script>
			window.history.back();
			alert("登记注册类型编码已存在,无法添加");
			</script>
		<%
		} else {
			sqlstr = "insert into base_feetype(feetype_number, finance_code, feetype_name, paytype,creator, create_date, modificator, modify_date) values ('"+feetype_number+"','"+finance_code+"','"+feetype_name+"','"+paytype+"','"+czy+"',getdate(),'"+czy+"',getdate())";
			//System.out.println("sqlstrsqlstr=="+sqlstr);
			db.executeUpdate(sqlstr); 
			%>
			<script>
				window.close();
				opener.alert("添加成功!");
				opener.location.reload();
			</script>
			<%
		}
}
if ( stype.equals("mod") ){      //修改操作
		czid=getStr(request.getParameter("id"));
			finance_code=getStr(request.getParameter("finance_code"));
            feetype_number=getStr(request.getParameter("feetype_number"));
            feetype_name=getStr(request.getParameter("feetype_name"));
            paytype=getStr(request.getParameter("paytype"));
	if ( czid.equals(feetype_number) ) {
		sqlstr="update base_feetype set paytype='"+paytype+"',feetype_number='"+feetype_number+"',finance_code='"+finance_code+"', feetype_name='"+feetype_name+"', modificator='"+czy+"', modify_date=getdate() where feetype_number='"+czid+"'";
		//System.out.println("sqlstrsqlstr=="+sqlstr);
		db.executeUpdate(sqlstr);
		%>
		<script>
			window.close();
			opener.alert("修改成功!");
			opener.location.reload();
		</script>
		<%
	} else {
		sqlstr = "select * from base_feetype where feetype_number='"+feetype_number+"'";
		rs = db.executeQuery(sqlstr); 
		if ( rs.next() ) {
		%>
			<script>
			window.history.back();
			alert("登记注册类型编码已存在,无法修改");
			</script>
		<%
		} else {
			sqlstr="update base_feetype set paytype='"+paytype+"',feetype_number='"+feetype_number+"',finance_code='"+finance_code+"', feetype_name='"+feetype_name+"', modificator='"+czy+"', modify_date=getdate() where feetype_number='"+czid+"'";
			//System.out.println("sqlstrsqlstr=="+sqlstr);
			db.executeUpdate(sqlstr);	
			%>
			<script>
				window.close();
				opener.alert("修改成功!");
				opener.location.reload();
			</script>
			<%
		}
	}
}
if ( stype.equals("del") ){         //删除操作
	czid=getStr(request.getParameter("id"));
            sqlstr="delete from base_feetype where feetype_number='"+czid+"'";
	db.executeUpdate(sqlstr);
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