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
String id =getStr( request.getParameter("czid") );
String gpsinfo_id =getStr( request.getParameter("gpsinfo_id") );
String track_date = "";
String fixed_state="";
String track_state="";
String track_memo = "";
String creator=(String)session.getAttribute("czyid");

String message  ="";
String sqlstr;
ResultSet rs=null;

	int fag=0;
	track_date = getStr( request.getParameter("track_date") );
	fixed_state = getStr( request.getParameter("fixed_state") );
	track_state = getStr( request.getParameter("track_state") );
	track_memo = getStr( request.getParameter("track_memo") );
	
    if(savetype.equals("add")){	
	    message="添加GPS不正常跟踪明细";
		sqlstr="insert into gps_abnormal_track_detail(gpsinfo_id,track_date,fixed_state,track_memo,creator) values ('"+gpsinfo_id+"','"+track_date+"','"+fixed_state+"','"+track_memo+"','"+creator+"');";
		fag=db.executeUpdate(sqlstr);
		db.close();
    }else if(savetype.equals("mod")){
		message="修改GPS不正常跟踪明细";
	   sqlstr="update gps_abnormal_track_detail set  track_date='"+track_date+"',fixed_state='"+fixed_state+"',track_memo='"+track_memo+"',creator='"+creator+"' where  id='"+id+"'";
		fag=db.executeUpdate(sqlstr);
		db.close();
    }else if(savetype.equals("del")){
		message="删除GPS不正常跟踪明细";
	    sqlstr="delete from gps_abnormal_track_detail where  id='"+id+"'";
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