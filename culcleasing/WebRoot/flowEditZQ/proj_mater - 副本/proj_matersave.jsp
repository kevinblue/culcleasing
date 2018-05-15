<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %> 
<%@ page import="com.tenwa.log.LogWriter"%>
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
//===========================================
	//项目资料清单
//===========================================

//获取基础参数
String type = getStr( request.getParameter("type") );

//基本变量
String sqlstr;
String dqczy = (String) session.getAttribute("czyid");//当前登陆人
String datestr = getSystemDate(0); //获取系统时间

String proj_id = getStr( request.getParameter("proj_id") );
String doc_id = getStr( request.getParameter("doc_id") );

int flag = 0;
String msg = "";
 
if("save".equals(type)){//添加项目资料

	String[] mater_id = request.getParameterValues("list"); 
	String ckAmount = getStr( request.getParameter("ckAmount") );
	
	//2.1先删除付款前提
	sqlstr = "delete from proj_document_temp where proj_id='"+proj_id+"' and doc_id='"+doc_id+"'";
	db.executeUpdate(sqlstr);

	//2.2插入新的付款前提
	//System.out.println(mater_id.length+"___"+mater_id[0]);
	
	if("0".equals(ckAmount)){
		sqlstr = "";
		flag = 111111;
	}else{
		sqlstr = "";
		for(int i=0;i<mater_id.length;i++){
			sqlstr += " insert into proj_document_temp(proj_id,doc_id,document_id,text_status,electron_status,remark)";
			sqlstr += " select '"+proj_id+"','"+doc_id+"','"+mater_id[i]+"','否','否',''";
		}
		flag = db.executeUpdate(sqlstr);
	}

	LogWriter.logDebug(request, "设置项目资料");
	
	msg = "设置项目资料";
}else if("del".equals(type)){//删除某项目资料
	String item_id = getStr( request.getParameter("item_id") );
	sqlstr = "delete from proj_document_temp where id='"+item_id+"'";
	flag = db.executeUpdate(sqlstr);
	
	LogWriter.logDebug(request, "删除项目资料："+item_id);
	
	msg = "删除该项目资料";
}

//3返回判断
if(flag>0){%>
	<script type="text/javascript">
	   // window.opener=null;
       // window.open('', '_self', ''); 
		window.close();
		window.opener.alert("<%=msg %>成功!");
		window.opener.location.reload();
		
		//window.opener.parent.opener.alert("sss");
		//window.parent.opener.location.reload();
		//window.parent.parent.parent.location.replace("proj_mater_list.jsp?proj_id=<%=proj_id %>&doc_id=<%=doc_id %>");
		//window.parent.parent.location.reload();
		//window.opener.parent.location.reload();
		//opener.parent.alert("<%=msg %>成功!");
		//opener.parent.location.reload();
	</script>	
<%}else{
%>
	<script type="text/javascript">
		window.close();
		window.opener.alert("<%=msg %>成功!");
		window.opener.location.reload();
		
		//window.parent.parent.location.replace("http://test.strongflc.com/names.nsf?logout");
		//window.parent.opener.location.reload();
		//window.parent.parent.location.reload();
		//window.parent.parent.location.replace("proj_mater_list.jsp?proj_id=<%=proj_id %>&doc_id=<%=doc_id %>");
		//window.opener.parent.location.reload();
		//window.opener.parent.alert("<%=msg %>失败!");
		//opener.parent.location.reload();
	</script>
<%} %>
</BODY>
</HTML>
<%if(null != db){db.close();}%>