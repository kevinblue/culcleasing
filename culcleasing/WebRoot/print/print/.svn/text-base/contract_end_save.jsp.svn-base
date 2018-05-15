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
String docId=getStr(request.getParameter("docId"));
String Contractid=getStr(request.getParameter("Contractid"));
String ProjectFromDept=getStr(request.getParameter("ProjectFromDept"));//出单部门
String Xmzb=getStr(request.getParameter("Xmzb"));//项目经理
String ProjectName=getStr(request.getParameter("ProjectName"));//项目名称
String NRealMoney=getStr(request.getParameter("NRealMoney"));//应收提前结清款
String NActionMoney=getStr(request.getParameter("NActionMoney"));//实际到账提前结清款
String NActionDif=getStr(request.getParameter("NActionDif"));//退还金额
String CustomerName=getStr(request.getParameter("CustomerName"));//收款人
String JQCustBankName=getStr(request.getParameter("JQCustBankName"));//收款人银行
String JQCustBankNum=getStr(request.getParameter("JQCustBankNum"));//收款人账号


System.out.println("custname========================"+CustomerName);
String url="docId="+docId+"&Contractid="+Contractid+"&ProjectFromDept="+ProjectFromDept+"&Xmzb="+Xmzb+"&ProjectName="+ProjectName+"&NRealMoney="+NRealMoney;
url=url+"&NActionMoney="+NActionMoney+"&NActionDif="+NActionDif+"&CustomerName123="+CustomerName+"&JQCustBankName="+JQCustBankName+"&JQCustBankNum="+JQCustBankNum;

String sqlstr="SELECT contract_id FROM contract_end_print WHERE doc_id='"+docId+"'";
ResultSet rs=db.executeQuery(sqlstr);
if(rs.next()){
sqlstr="update contract_end_print set print_remark='"+remark+"' where  doc_id='"+docId+"'";
flag+=db.executeUpdate(sqlstr);
msg="编辑";
} else {
sqlstr="insert into contract_end_print(contract_id,print_remark,doc_id) values('"+Contractid+"','"+remark+"','"+docId+"')";
flag+=db.executeUpdate(sqlstr);
msg="编辑";
}
if(flag>0){%>
	<script type="text/javascript">
		alert("<%=msg %>成功!");
		window.location.href='contract_end.jsp?<%=url%>';
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