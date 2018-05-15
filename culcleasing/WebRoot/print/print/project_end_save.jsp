<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同结清申请单保存</title>
</head>


<%
int flag = 0;
String msg = "";
//request.setCharacterEncoding("gbk");
String conId=getDBStr(request.getParameter("conId"));//合同编号
String remark =java.net.URLDecoder.decode(getStr(request.getParameter("remark")),"UTF-8");//备注java.net.URLDecoder.decode(getStr(request.getParameter("remark")),"UTF-8");
System.out.println("wwwwww"+remark);
String money1 =getDBStr(request.getParameter("my1"));//未偿还租金
String money2=getDBStr(request.getParameter("my2")) ;//罚息金额
String money3 =getDBStr(request.getParameter("my3"));//残值
String money4=getDBStr(request.getParameter("my4")) ;//保证金余额
String money5 =getDBStr(request.getParameter("my5"));//结清款
String money6=getDBStr(request.getParameter("my6"));//租金差异
String bankName=getStr(request.getParameter("bName"));//银行
String bankAccount=getStr(request.getParameter("bAcco"));//账号
String custname=getStr(request.getParameter("custName123"));
System.out.println("custname========================"+custname);
String sqlstr="SELECT contract_id FROM contract_end_print WHERE contract_id='"+conId+"'";
ResultSet rs=db.executeQuery(sqlstr);
if(rs.next()){
sqlstr="update contract_end_print set print_remark='"+remark+"' where contract_id='"+conId+"'";
flag+=db.executeUpdate(sqlstr);
msg="编辑";
} else {
sqlstr="insert into contract_end_print(contract_id,print_remark) values('"+conId+"','"+remark+"')";
flag+=db.executeUpdate(sqlstr);
msg="编辑";
}
if(flag>0){%>
	<script type="text/javascript">
		//window.close();
		//alert("sssss");
		alert("<%=msg %>成功!");
		window.location.href='project_end.jsp?conId=<%=conId %>&my1=<%=money1 %>&my2=<%=money2 %>&my3=<%=money3 %>&my4=<%=money4 %>&my5=<%=money5 %>&my6=<%=money6 %>&custName123=<%=custname%>&bName=<%=bankName %>&bAcco=<%=bankAccount %>';
		window.reload();
	</script>	
<%}else{
%>
	<script type="text/javascript">
		//window.close();
		opener.alert("<%=msg %>失败!");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}			
	</script>
<%} %>

</html>
<%if(null != db){db.close();}%>