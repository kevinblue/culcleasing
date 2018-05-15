<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %>
<%@ page import="dbconn.*" %>
<%@ page import="java.io.File" %>
<%@ page import="com.container.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<jsp:useBean id="execlBean" scope="page" class="com.UploadExecl" />
<%@ include file="../../func/common.jsp"%>
<%
String savetype =getStr( request.getParameter("savetype") );
//获取系统时间
String datestr=getSystemDate(0); 
boolean bflag = true;
String tzexamine_details = "";
String tzpolling_id = "";
String gpstpye="";
String cai_no="";
String sim_no = "";
String import_date="";
String province = "";
String city = "";
String address="";
String state = "";
String cusname = "";
String branch_company = "";

String message  ="";
String sqlstr;
ResultSet rs=null;

	int fag=0;
	tzexamine_details = getStr( request.getParameter("id") );
	tzpolling_id = getStr( request.getParameter("tzpolling_id") );
	gpstpye = getStr( request.getParameter("gpstpye") );
	cai_no = getStr( request.getParameter("cai_no") );
	sim_no = getStr( request.getParameter("sim_no") );
	import_date = getStr( request.getParameter("import_date") );
	province = getStr( request.getParameter("province") );
	city = getStr( request.getParameter("city") );
	address = getStr( request.getParameter("address") );
	state = getStr( request.getParameter("state") );
	cusname = getStr( request.getParameter("cust_id") );
	branch_company = getStr( request.getParameter("sale_id") );
    if(savetype.equals("add")){	
	    message="添加GPS巡检报告明细";
		sqlstr="insert into tzexamine_details( tzpolling_id,gpstpye,cai_no,sim_no,import_date,province,city,address,state,cusname,branch_company) values ('"+tzpolling_id+"','"+gpstpye+"','"+cai_no+"','"+sim_no+"','"+import_date+"','"+province+"','"+city+"','"+address+"','"+state+"','"+cusname+"','"+branch_company+"');";
		fag=db.executeUpdate(sqlstr);
		db.close();
    }else if(savetype.equals("mod")){
		message="修改GPS巡检报告明细";
	   sqlstr="update tzexamine_details set  state='"+state+"',gpstpye='"+gpstpye+"',cai_no='"+cai_no+"',sim_no='"+sim_no+"',import_date='"+import_date+"',branch_company='"+branch_company+"' where  tzexamine_details='"+tzexamine_details+"'";
		fag=db.executeUpdate(sqlstr);
		db.close();
    }else if(savetype.equals("del")){
		message="删除GPS";
	    sqlstr="delete from tzexamine_details where  tzexamine_details='"+tzexamine_details+"'";
	    fag = db.executeUpdate(sqlstr);
		db.close();
    }
	if(fag==0){
		%>
        <script>
		alert("<%=message%>失败!");
		opener.location.reload();
		this.close();
		</script>
		<%		
	}else{
			%>
        <script>
		opener.window.location.reload();
		alert("<%=message%>成功!");
		this.close();
		</script>
		<%
	}	

%>