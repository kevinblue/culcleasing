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

String message  ="";
String sqlstr;
ResultSet rs=null;

if(!(savetype.equals("")||savetype==null)){//为非上传操作
	
}else{	//上传操作
	String czy =(String) session.getAttribute("czid");
	String errMsg ="";
	int iallcol =0;
	String uid=czy;
	String filePath;
	String fileName = "";
	//设定附件相对路径
	String path = pageContext.getServletContext().getRealPath("/");
	String allpath =path + "\\upload\\gps_list\\"+datestr+"\\";
	fileBean.setObjectPath( allpath );
	//设定上传附件总体大小限制
	fileBean.setSize(8*1024*1024);
	//设定上传附件文件类型
	fileBean.setSuffix(".xls");
	//设定上传用户ID
	if ( ( czy != null ) && ( !czy.equals("") ) ) {
	   //uid=czy.substring(7);
	}
	fileBean.setUserid(uid);
	fileBean.setSourceFile(request);//文件上传
	String [] saSourceFile = fileBean.getSourceFile();
	String [] saObjectFile = fileBean.getObjectFileName();
	String [] saDescription = fileBean.getDescription();
	int iCount = fileBean.getCount();
	String sObjectPath = fileBean.getObjectPath();
    if(saObjectFile!=null){
	  for(int j=0;j<saObjectFile.length;j++){
		if(saObjectFile[j]!=null&&!saObjectFile[j].equals("")){ 
		System.out.print(allpath+saObjectFile[j]);
			execlBean.setExecl(allpath+saObjectFile[j]);
			}
		 }
	  }
    }
    db.close();
    db1.close();
	if(bflag&&message.equals("")){
	%>
	<script>
	window.close();
	alert("数据已成功读取!本次共上传<%=iallcol%>条GPS记录!");
	<%
	if(errMsg!=""||(!errMsg.equals(""))){
		%>
		alert("但是其中某些数据出现了如下错误:<%=errMsg%>");
		<%
	}
	%>
	opener.location.reload();
	</script>
	<%
	}else{
		
		System.out.println("message:"+message);
	%>
	<script>
	window.close();
	alert("上传数据失败,execl文件<%=errMsg%>数据格式错误");
	opener.location.reload();
	</script>
	<%
	}
	%>
    <script>
		opener.window.location.href = "gps_list.jsp";
		this.close();
	</script>
	<%
}
%>