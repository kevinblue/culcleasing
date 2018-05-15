<%@ page contentType="text/html; charset=gbk" language="java"%>

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
//	保险相关信息的增删改查

String dqczy = (String) session.getAttribute("czyid");
String stype = getStr( request.getParameter("savetype") );

String insurer_name = getStr( request.getParameter("insurer_name") );
String simple_name = getStr( request.getParameter("simple_name") );

String  insurer_code= getStr( request.getParameter("kid") );

String sqlstr;
ResultSet rs;
String datestr = getSystemDate(0); //获取系统时间

if ( stype.equals("add") ){        //添加操作
		sqlstr = "select insurer_name from insurer_info where insurer_name='" + insurer_name + "'";
		rs = db.executeQuery(sqlstr); 
		if ( rs.next() ) {
		%>
			<script type="text/javascript">
			window.history.back();
			alert("所填保险公司名称与现有名称重复");
			</script>
		<%
		} else {
				int i = 0;
				rs = db.executeQuery("select Max(id) from insurer_info");
				if(rs.next()){
					i = rs.getInt(1);
					System.out.print("哈哈哈哈哈哈哈哈哈i"+i);
				}
				i++;
				String code = "INSURER"+i;
			sqlstr = "insert into insurer_info(id,insurer_code,insurer_name,create_date,creator,modify_date,simple_name) values ('" + i + "','" + code + "','" + insurer_name  + "','" + datestr  + "','" + dqczy + "','" + datestr + "','" + simple_name + "')";
			System.out.print(sqlstr);
			db.executeUpdate(sqlstr); 
			
			%>
			<script type="text/javascript">
				window.close();
				opener.alert("添加成功!");
				opener.location.reload();
			</script>
			<%
		}
}else if ( stype.equals("mod") ){      //修改操作

	sqlstr = "update insurer_info set insurer_name='" + insurer_name  + "',simple_name='" + simple_name  + "',modify_date='" + datestr + "',creator='" + dqczy + "' where insurer_code='" + insurer_code + "'";
	System.out.print(sqlstr);
	db.executeUpdate(sqlstr);
	%>
	<script type="text/javascript">
		window.close();
		opener.alert("修改成功!");
		opener.location.reload();
	</script>
	<%
}else if ( stype.equals("del") ){         //删除操作
	sqlstr = "delete from insurer_info where insurer_code='" + insurer_code + "'";
	System.out.print("删除的sql语句为+++++++" + sqlstr + "------");
	db.executeUpdate(sqlstr);
%>
	<script type="text/javascript">
		window.close();
		opener.alert("删除成功!");
		opener.location.reload();
	</script>
<%			
}
db.close();
%>
</BODY>
</HTML>
