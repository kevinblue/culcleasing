<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<%
String czy = (String) session.getAttribute("czyid");

//获取系统时间
String datestr=getSystemDate(0); 
String czid = getStr(request.getParameter("czid"));
String gnbh = getStr(request.getParameter("gnbh"));
String savetype = getStr(request.getParameter("savetype"));
String sql = "";
String message = "";
if(savetype.equals("export")){
	sql  = "update inter_evidence_download set export_flag='";
	message = "财务配置记录设置为";
	if(gnbh.equals("已导出")){
		sql+="未导出";
		message+="未导出";
	}else{
		sql+="已导出";
		message+="已导出";
	}
	sql+="' where id="+czid;
	message +="成功";
}
if(savetype.equals("delete")){
	sql  = "update inter_evidence_download set delete_flag='";
	message = "财务配置记录设置为";
	if(gnbh.equals("有效")){
		sql+="废止";
		message+="废止";
	}else{
		sql+="有效";
		message+="有效";
	}
	sql+="' where id="+czid;
	message +="成功";
}
System.out.println(sql);
db.executeUpdate(sql);
%>
<script>
			window.close();
			opener.alert("<%=message%>");
			opener.location.reload();
		</script>
<%
db.close();
%>