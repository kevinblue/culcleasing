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

String equip_type="";
String model_name="";

String message  ="";
String sqlstr;
ResultSet rs=null;

int fag=0;
String id = getStr( request.getParameter("czid") );
model_name = getStr( request.getParameter("model_name") );
equip_type = getStr( request.getParameter("equip_type") );
    if(savetype.equals("add")){	
		sqlstr="select model_name from equip_model where equip_type='"+equip_type+"' and model_name='"+model_name+"'";
		System.out.println(sqlstr);
		rs=db.executeQuery(sqlstr); 
		if(rs.next()){
			message="ͬ�豸�������ͺŲ����ظ�!���";
			fag=0;
			rs.close();
		}else{
	    message="����豸";
		sqlstr="insert into equip_model( equip_type,model_name) values ('"+equip_type+"','"+model_name+"')";
		fag=db.executeUpdate(sqlstr);
		db.close();
		}
    }else if(savetype.equals("mod")){
		sqlstr="select model_name from equip_model where equip_type='"+equip_type+"' and model_name='"+model_name+"'";
		rs=db.executeQuery(sqlstr); 
		if(rs.next()){
			message="ͬ�豸�������ͺŲ����ظ�!�޸�";
			fag=0;
			rs.close();
		}else{
		message="�޸��豸";
	   sqlstr="update equip_model set  model_name='"+model_name+"',equip_type='"+equip_type+"' where model_id='"+id+"'";
		fag=db.executeUpdate(sqlstr);
		db.close();
		}
    }else if(savetype.equals("del")){
		message="ɾ���豸";
	    sqlstr="delete from equip_model where  model_id='"+id+"'";
	    fag = db.executeUpdate(sqlstr);
		db.close();
    }
	if(fag==0){
		%>
        <script>
		alert("<%=message%>ʧ��!");
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
		alert("<%=message%>�ɹ�!");
		this.close();
		</script>
		<%
		}else if(savetype.equals("mod")){
		%>
        <script>
		window.location.href = "sbwh.jsp?id=<%=id%>";
		alert("<%=message%>�ɹ�!");
		opener.location.reload();
		</script>
		<%
		}else{
			%>
          <script>
		  alert("<%=message%>�ɹ�!");
		  opener.location.reload();
		  this.close();
		   </script>
		<%
		}
	}
%>