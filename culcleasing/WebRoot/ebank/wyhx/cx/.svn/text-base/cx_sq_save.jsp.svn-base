<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@page import="com.jspsmart.upload.SmartUpload"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");//新增人
String sql_bh_ids = getStr( request.getParameter("sql_bh_ids") );//选中的主键ids
String systemDate = getSystemDate(0);

String sqlstr="";
String message="";
int flag=0;

String stype =  getStr( request.getParameter("savetype") );

if ( stype.equals("add") ){ 
	//创建su对象
	SmartUpload su = new SmartUpload();
	su.initialize(pageContext);
	su.upload();
	//读取 request 参数
	String applier = su.getRequest().getParameter("applier");
	String hire_bank = su.getRequest().getParameter("hire_bank");
	String fact_date = su.getRequest().getParameter("fact_date");
	String remark = su.getRequest().getParameter("remark");
	//上传文件对象
	com.jspsmart.upload.File file = su.getFiles().getFile(0);
	
	String fileNameUUID = fact_date+"_"+UUID.randomUUID()+"."+file.getFileExt();
	//先插入数据到 fund_rent_cx 
	sqlstr ="insert into fund_rent_cx(applier,apply_date,hire_bank,file_name,remark,";
	sqlstr+=" tj_status,cx_status,creator,create_date) values('"+applier+"','"+fact_date+"',";
	sqlstr+=" '"+hire_bank+"','"+fileNameUUID+"','"+remark+"',0,0,'"+dqczy+"','"+systemDate+"')";
	System.out.println("fund_rent_cx插入sql"+sqlstr);
	//执行语句
	flag = db.executeUpdate(sqlstr);
	//上传文件到服务器 rent_cx_upload 目录下指定文件名称
	if(flag>0){
		// 若文件不存在则继续
	    if (file.isMissing()){
	    	System.out.println("源文件目录已不存在");
	    }else{
	    	file.saveAs("/rent_cx_upload/" + fileNameUUID,su.SAVE_VIRTUAL);
	    }
	}
	
	message="添加租金撤销";
}else if ( stype.equals("del") ){ 
	sqlstr="delete from fund_rent_cx where id in("+sql_bh_ids+")";
	System.out.println("删除租金撤销申请sqlstr:"+sqlstr);
	flag = db.executeUpdate(sqlstr);

	message="删除租金撤销申请";
}else if ( stype.equals("sub") ){ 
	sqlstr="update fund_rent_cx set tj_status=1,modifycator='"+dqczy+"',modify_date='"+systemDate+"' where id in("+sql_bh_ids+")";
	System.out.println("提交租金撤销申请sqlstr:"+sqlstr);
	flag = db.executeUpdate(sqlstr);

	message="提交租金撤销申请";
}else if ( stype.equals("bh") ){ 
	sqlstr="update fund_rent_cx set tj_status=0,modifycator='"+dqczy+"',modify_date='"+systemDate+"' where id in("+sql_bh_ids+")";
	System.out.println("驳回租金撤销申请sqlstr:"+sqlstr);
	flag = db.executeUpdate(sqlstr);

	message="驳回租金撤销申请";
}

if(flag!=0){
%>
<script>
 	window.close();
   	opener.alert("<%=message%>成功!");
	opener.location.reload();
</script>
<%
}else{
%>
<script>
	window.close();
	opener.alert("<%=message%>失败!");
	opener.location.reload();
</script>
<%}
db.close();%>