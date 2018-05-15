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
SimpleDateFormat formater=new SimpleDateFormat("yyyy年MM月dd日");
//request.setCharacterEncoding("gbk");
String remark =java.net.URLDecoder.decode(getStr(request.getParameter("remark")),"UTF-8");//备注java.net.URLDecoder.decode(getStr(request.getParameter("remark")),"UTF-8");
String isEd=getStr(request.getParameter("isEd"));//是否可编辑
String docId=getStr(request.getParameter("DocID"));
String ProjectFromDept=getStr(request.getParameter("ProjectFromDept"));//出单部门
String Xmzb=getStr(request.getParameter("Xmzb"));//项目经理
String ProjectNo=getStr(request.getParameter("ProjectNo"));//项目编号
String ProjectName=getStr(request.getParameter("ProjectName"));//项目名称
String EquipTypeS=getStr(request.getParameter("EquipType"));//内部行业
String HRentList=getStr(request.getParameter("HRentList"));//逾期租金期次
String HRent=getStr(request.getParameter("HRent"));//逾期租金
String HDates=getStr(request.getParameter("HDates"));//逾期天数
String HPenaltyCut=getStr(request.getParameter("HPenaltyCut"));//申请减免罚息



String url="docId="+docId+"&ProjectFromDept="+ProjectFromDept+"&Xmzb="+Xmzb+"&ProjectNo="+ProjectNo+"&Xmzb="+Xmzb+"&ProjectName="+ProjectName+"&EquipTypeS="+EquipTypeS;
url=url+"&HRentList="+HRentList+"&HRent="+HRent+"&HDates="+HDates+"&HDates="+HDates+"&HPenaltyCut="+HPenaltyCut;

String sqlstr="SELECT pri_id FROM project_penalty_print WHERE doc_id='"+docId+"'";
ResultSet rs=db.executeQuery(sqlstr);
if(rs.next()){
sqlstr="update project_penalty_print set print_remark='"+remark+"' where  doc_id='"+docId+"'";
flag+=db.executeUpdate(sqlstr);
msg="编辑";
} else {
sqlstr="insert into project_penalty_print(pri_id,print_remark,doc_id) values('"+ProjectNo+"','"+remark+"','"+docId+"')";
flag+=db.executeUpdate(sqlstr);
msg="编辑";
}
if(flag>0){%>
	<script type="text/javascript">
		alert("<%=msg %>成功!");
		window.location.href='project_penalty.jsp?<%=url%>';
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