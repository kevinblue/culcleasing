<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %> 
<%@ page import="com.tenwa.log.LogWriter"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@ page import="com.tenwa.log.LogWriter"%>
<jsp:useBean id="db1" class="dbconn.Conn"></jsp:useBean>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
//===========================================
	//项目资料状态修改
//===========================================

//获取基础参数
String bank_str1= getStr( request.getParameter("bank_str1") );
String updsql=getStr(request.getParameter("updsql"));//sql语句
String[] contract_ids=request.getParameterValues("list");

String contract_id = "";
int flag = 0;
for(int i = 0; i < contract_ids.length; i++) {
if( (bank_str1!=null && !"".equals(bank_str1))  ){
		
		ResultSet rs1 = null;
		rs1=db1.executeQuery(updsql);
		
	
		while(rs1.next()){
			contract_id = rs1.getString("contract_id");
			
			sqlstr="select id from sys_contract_p_bank where contract_id='"+contract_ids[i]+"'";
			rs=db.executeQuery(sqlstr);
			if(rs.next()){
				sqlstr = "update sys_contract_p_bank set bank_str='"+bank_str1+"'";
				sqlstr+= " where contract_id='"+contract_ids[i]+"'";
				
				flag += db.executeUpdate(sqlstr);
			}else{
				sqlstr = "insert into sys_contract_p_bank( contract_id,bank_str) ";
				sqlstr+="values('"+contract_ids[i]+"','"+bank_str1+"')";
				System.out.println("aaabb11111:"+sqlstr);
				flag = db.executeUpdate(sqlstr);
			}
		}
	}
}

db.close();
db1.close();
	String msg = "银行修改";

//3返回判断
if(flag>0){%>
	<script type="text/javascript">
		window.close();
		window.opener.alert("<%=msg %>成功!");
		window.opener.location.reload();
	</script>	
<%}else{
%>
	<script type="text/javascript">
		window.close();
		window.opener.alert("<%=msg %>失败!");
		window.opener.location.reload();
	</script>
<%} 

%>
</BODY>
</HTML>
