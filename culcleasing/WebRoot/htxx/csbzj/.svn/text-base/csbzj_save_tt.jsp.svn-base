<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
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
	        System.out.print("join@2"+dqczy);
			
	
			
			
             String systemDate = getSystemDate(0); //获取系统时间

			String id = getStr(request.getParameter("id"));
			System.out.println("^^取的是add页面的id^^^^^$$$$$$id号为^^"+id);
			
			String manuf_name = getStr(request.getParameter("manuf_name"));
			//System.out.println(manuf_name+"manuf_name***************");
			String margin_per = getStr(request.getParameter("margin_per"));
            String initial_margin = getStr(request.getParameter("initial_margin"));
			String creator = getStr(request.getParameter("creator"));
			String create_date = getStr(request.getParameter("create_date"));
			String modificator = getStr(request.getParameter("modificator"));
			String modify_date = getStr(request.getParameter("modify_date"));
	
			String sqlstr;
			ResultSet rs;
			int flag = 0;
			String message = "";
			String stype = getStr(request.getParameter("savetype"));
			//System.out.pringln("^^^^^^^^^^^^^^^^^^");
			if (stype.equals("add")) {
				sqlstr = "insert into contract_manuf(manuf_name,margin_per,initial_margin,creator,create_date,modificator,modify_date) values('"+manuf_name+"','"+margin_per+"','"+initial_margin+"','"+dqczy+"','"+systemDate+"','"+dqczy+"','"+systemDate+"')";
				System.out.println(sqlstr+"增加信息sql语句");
				flag = db.executeUpdate(sqlstr);
				db.close();
				message = "添加客户信息";
			}
			if (stype.equals("mod")) {
				sqlstr="update contract_manuf set manuf_name='"+manuf_name+"',margin_per='"+margin_per+"',initial_margin='"+initial_margin+"', creator='"+dqczy+"',create_date='"+systemDate+"',modificator='"+dqczy+"',modify_date='"+systemDate+"' where id='"+id+"'";
				System.out.println(sqlstr+"&&&&&&&&&&&&&&&&&&&&&&&");
				flag = db.executeUpdate(sqlstr);
				db.close();
				message = "修改客户信息";
			}
			if (stype.equals("del")) {
				sqlstr = "delete from contract_manuf where id='" + id+ "'";
				System.out.println(sqlstr);
				flag = db.executeUpdate(sqlstr);
				
				db.close();
				message = "删除客户信息";
			}
		if(flag>0){
		String hrefStr="";
		if(stype.equals("del")){
%>
        <script>
		opener.window.location.href = "csbzj_list_tt.jsp";
		alert("<%=message%>成功!");
		this.close();
		</script>
<%
		}else{
		%>
        <script>
		//window.location.href = "csbzj_tt.jsp?id=<%=id%>";
		//alert("<%=message%>成功!");
		//opener.location.reload();
opener.window.location.href = "csbzj_list_tt.jsp";
		alert("<%=message%>成功!");
		this.close();
		</script>
<%
		}
	}else{
%>
        <script>
		alert("<%=message%>失败!");
		opener.location.reload();
		this.close();
		</script>
<%	
	}
	db.close();
%>