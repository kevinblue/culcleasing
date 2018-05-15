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
			String id=getStr(request.getParameter("id"));
			ResultSet rs;
int flag=0;
String message="";
String sqlstr="";
String invoice_number= getStr( request.getParameter("invoice_number") );
String invoice_total= getStr( request.getParameter("invoice_total") );
String invoice_date = getStr( request.getParameter("invoice_date") );
			String stype = getStr(request.getParameter("savetype"));
String contract_id="";
String rent_list="";
List c_list = new ArrayList();
List l_list = new ArrayList();
			if (stype.equals("del")) {
				sqlstr = "select contract_id,rent_list from proj_invoice_detail where proj_invoice_id='"+id+"'"; 
				 rs = db.executeQuery(sqlstr);
				 while(rs.next()){
				 contract_id = getDBStr(rs.getString("contract_id"));
				 rent_list = getDBStr(rs.getString("rent_list"));
				 c_list.add(contract_id);
				 l_list.add(rent_list);
				 }
				 rs.close();
				
				 sqlstr = "delete from dbo.proj_invoice where id='" + id+ "'";
				System.out.println(sqlstr);
				flag = db.executeUpdate(sqlstr);
				//更新租金计划表状态
				sqlstr="";
				for(int i=0;i<c_list.size();i++){
				sqlstr += "update fund_rent_plan set is_fp='否' where contract_id='"+c_list.get(i)+"' and rent_list='"+l_list.get(i)+"'";
				}
				System.out.println(sqlstr);
				flag += db.executeUpdate(sqlstr);
				db.close();
				 message = "删除客户信息";
			}
		if(flag>0){
		String hrefStr="";
		if(stype.equals("del")){
%>
        <script>
		opener.window.location.href = "fpgl_list.jsp";
		alert("<%=message%>成功!");
		this.close();
		</script>
<%
		}else{
		%>
        <script>
		//window.location.href = "fpgl_list.jsp";
		//alert("<%=message%>成功!");
		//opener.location.reload();
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