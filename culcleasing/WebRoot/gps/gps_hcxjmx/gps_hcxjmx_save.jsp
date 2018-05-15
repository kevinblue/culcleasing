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

String hcexamine_details = "";
String hcpolling_id = "";
String cai_no="";
String sim_no = "";
String agents="";
String polling_date = "";
String longitude = "";
String latitude="";
String speed = "";
String worktime = "";
String state = "";
String lock_state = "";
String fixed_state = "";
String online_time = "";
String services_endtime = "";

String message  ="";
String sqlstr;
ResultSet rs=null;

	int fag=0;
	hcexamine_details = getStr( request.getParameter("id") );
	hcpolling_id = getStr( request.getParameter("hcpolling_id") );
	cai_no = getStr( request.getParameter("cai_no") );
	sim_no = getStr( request.getParameter("sim_no") );
	agents = getStr( request.getParameter("agents") );
	polling_date = getStr( request.getParameter("polling_date") );
	longitude = getStr( request.getParameter("longitude") );
	latitude = getStr( request.getParameter("latitude") );
	speed = getStr( request.getParameter("speed") );
	worktime = getStr( request.getParameter("worktime") );
	state = getStr( request.getParameter("state") );
	lock_state = getStr( request.getParameter("lock_state") );
	fixed_state = getStr( request.getParameter("fixed_state") );
	online_time = getStr( request.getParameter("online_time") );
	services_endtime = getStr( request.getParameter("services_endtime") );
    if(savetype.equals("add")){	
	    message="添加GPS巡检报告明细";
		sqlstr="insert into hcexamine_details( hcpolling_id,cai_no,sim_no,agents,polling_date,longitude,latitude,speed,worktime,state,lock_state,fixed_state,online_time,services_endtime) values ('"+hcpolling_id+"','"+cai_no+"','"+sim_no+"','"+agents+"','"+polling_date+"','"+longitude+"','"+latitude+"','"+speed+"','"+worktime+"','"+state+"','"+lock_state+"','"+fixed_state+"','"+online_time+"','"+services_endtime+"');";
		fag=db.executeUpdate(sqlstr);
		db.close();
    }else if(savetype.equals("mod")){
		message="修改GPS巡检报告明细";
	   sqlstr="update hcexamine_details set  state='"+state+"',cai_no='"+cai_no+"',sim_no='"+sim_no+"',agents='"+agents+"',polling_date='"+polling_date+"',longitude='"+longitude+"',latitude='"+latitude+"',speed='"+speed+"',lock_state='"+lock_state+"',fixed_state='"+fixed_state+"' where  hcexamine_details='"+hcexamine_details+"'";
		fag=db.executeUpdate(sqlstr);
		db.close();
    }else if(savetype.equals("del")){
		message="删除GPS";
	    sqlstr="delete from hcexamine_details where  hcexamine_details='"+hcexamine_details+"'";
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
		  alert("<%=message%>成功!");
		  opener.location.reload();
		  this.close();
		   </script>
		<%
	}	

%>