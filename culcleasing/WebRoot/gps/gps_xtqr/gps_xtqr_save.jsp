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

String yes_date="";
String fixed_state="";
String province="";
String city="";
String address="";
String memo="";
String gpsinfo_id="";
String sim_no="";
String message  ="";
String sqlstr;
ResultSet rs;

int fag=0;
String id = getStr( request.getParameter("czid") );
yes_date = getStr( request.getParameter("yes_date") );
fixed_state = getStr( request.getParameter("fixed_state") );
province = getStr( request.getParameter("province") );
city = getStr( request.getParameter("city") );
address = getStr( request.getParameter("address") );
memo = getStr( request.getParameter("memo") );
gpsinfo_id = getStr( request.getParameter("gpsinfo_id") );
sim_no = getStr( request.getParameter("sim_no") );
    if(savetype.equals("add")){	
		sqlstr="select id from gps_sure where gpsinfo_id='"+gpsinfo_id+"'";
		rs=db.executeQuery(sqlstr); 
		if(rs.next()){
			%>
        <script>
		alert("卡号<%=sim_no%>已经添加过一次!");
		opener.location.reload();
		this.close();
		</script>
			<%
		}else{
	    message="添加GPS入系统前确认信息";
		sqlstr="insert into gps_sure( gpsinfo_id,yes_date,fixed_state,province,city,address,memo) values ('"+gpsinfo_id+"','"+yes_date+"','"+fixed_state+"','"+province+"','"+city+"','"+address+"','"+memo+"')";
		fag=db.executeUpdate(sqlstr);
		db.close();
		}
    }else if(savetype.equals("mod")){
		sqlstr="select * from gps_sure where gpsinfo_id='"+id+"'";
		rs=db.executeQuery(sqlstr); 
		if(rs.next()){
			message="修改GPS入系统前确认信息";
	  	    sqlstr="update gps_sure set  yes_date='"+yes_date+"',fixed_state='"+fixed_state+"',province='"+province+"',city='"+city+"',address='"+address+"',memo='"+memo+"' where gpsinfo_id='"+id+"'";
			fag=db.executeUpdate(sqlstr);
			db.close();
		}else{
		    message="添加GPS入系统前确认信息";
		    sqlstr="insert into gps_sure( gpsinfo_id,yes_date,fixed_state,province,city,address,memo) values ('"+id+"','"+yes_date+"','"+fixed_state+"','"+province+"','"+city+"','"+address+"','"+memo+"')";
		    fag=db.executeUpdate(sqlstr);
		    db.close();
		}
    }else if(savetype.equals("del")){
		message="删除GPS入系统前确认信息";
	    sqlstr="delete from gps_sure where  id='"+id+"'";
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
		String hrefStr="";
		if(savetype.equals("del")){
			%>
        <script>
		opener.location.reload();
		alert("<%=message%>成功!");
		this.close();
		</script>
		<%
		}else if(savetype.equals("mod")){
		%>
        <script>
		window.location.href = "gps_xtqr.jsp?id=<%=id%>";
		alert("<%=message%>成功!");
		opener.location.reload();
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
	}
%>