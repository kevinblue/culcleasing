<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ͬ�������뵥����</title>
</head>


<%
int flag = 0;
String msg = "";
//request.setCharacterEncoding("gbk");
String conId=getDBStr(request.getParameter("conId"));//��ͬ���
String remark =java.net.URLDecoder.decode(getStr(request.getParameter("remark")),"UTF-8");//��עjava.net.URLDecoder.decode(getStr(request.getParameter("remark")),"UTF-8");
String docId=getStr(request.getParameter("docId"));
String Contractid=getStr(request.getParameter("Contractid"));
String ProjectFromDept=getStr(request.getParameter("ProjectFromDept"));//��������
String Xmzb=getStr(request.getParameter("Xmzb"));//��Ŀ����
String ProjectName=getStr(request.getParameter("ProjectName"));//��Ŀ����
String NRealMoney=getStr(request.getParameter("NRealMoney"));//Ӧ����ǰ�����
String NActionMoney=getStr(request.getParameter("NActionMoney"));//ʵ�ʵ�����ǰ�����
String NActionDif=getStr(request.getParameter("NActionDif"));//�˻����
String CustomerName=getStr(request.getParameter("CustomerName"));//�տ���
String JQCustBankName=getStr(request.getParameter("JQCustBankName"));//�տ�������
String JQCustBankNum=getStr(request.getParameter("JQCustBankNum"));//�տ����˺�


System.out.println("custname========================"+CustomerName);
String url="docId="+docId+"&Contractid="+Contractid+"&ProjectFromDept="+ProjectFromDept+"&Xmzb="+Xmzb+"&ProjectName="+ProjectName+"&NRealMoney="+NRealMoney;
url=url+"&NActionMoney="+NActionMoney+"&NActionDif="+NActionDif+"&CustomerName123="+CustomerName+"&JQCustBankName="+JQCustBankName+"&JQCustBankNum="+JQCustBankNum;

String sqlstr="SELECT contract_id FROM contract_end_print WHERE doc_id='"+docId+"'";
ResultSet rs=db.executeQuery(sqlstr);
if(rs.next()){
sqlstr="update contract_end_print set print_remark='"+remark+"' where  doc_id='"+docId+"'";
flag+=db.executeUpdate(sqlstr);
msg="�༭";
} else {
sqlstr="insert into contract_end_print(contract_id,print_remark,doc_id) values('"+Contractid+"','"+remark+"','"+docId+"')";
flag+=db.executeUpdate(sqlstr);
msg="�༭";
}
if(flag>0){%>
	<script type="text/javascript">
		alert("<%=msg %>�ɹ�!");
		window.location.href='contract_end.jsp?<%=url%>';
		window.reload();
	</script>	
<%}else{
%>
	<script type="text/javascript">
		//window.close();
		opener.alert("<%=msg %>ʧ��!");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}			
	</script>
<%} %>

</html>
<%if(null != db){db.close();}%>