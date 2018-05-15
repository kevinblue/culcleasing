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
String czyid=(String)session.getAttribute("czyid");
String savetype =getStr( request.getParameter("savetype") );

String track_state="";
String gpsinfo_id="";

String message  ="";
String sqlstr;
ResultSet rs=null;

	int fag=0;
	track_state = getStr( request.getParameter("track_state") );
	gpsinfo_id = getStr( request.getParameter("gpsinfo_id") );
	
    if(savetype.equals("add")){	
		sqlstr="select gpsinfo_id from gps_abnormal_track where gpsinfo_id='"+gpsinfo_id+"'";
		rs=db.executeQuery(sqlstr); 
		if(rs.next()){
			message="该GPS已经在不正常跟踪里,不能重复添加,操作";
			fag=0;
		}else{
	    message="添加GPS不正常跟踪";
		sqlstr="insert into gps_abnormal_track( gpsinfo_id,track_state) values ('"+gpsinfo_id+"','"+track_state+"')";
		fag=db.executeUpdate(sqlstr);
		db.close();
		}
    }else if(savetype.equals("del")){
		message="删除GPS不正常跟踪";
	    sqlstr="delete from gps_abnormal_track where  gpsinfo_id='"+gpsinfo_id+"'";
	    fag = db.executeUpdate(sqlstr);
		sqlstr="delete from gps_abnormal_track_detail where  gpsinfo_id='"+gpsinfo_id+"'";
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
		opener.window.location.href = "gps_abnormal_list.jsp";
		alert("<%=message%>成功!");
		this.close();
		</script>
		<%
	}
%>