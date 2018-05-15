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

dqczy=(String) session.getAttribute("czyid");
if(dqczy==null || "".equals(dqczy)){
	dqczy = "ADMN-WUSESSION";
}

String up_status= getStr(request.getParameter("up_status"));
String material_type= getStr(request.getParameter("material_type"));
String materialRD_date= getStr(request.getParameter("materialRD_date"));

String[] ids=request.getParameterValues("list");
String msg="";

int flag = 0;//计数器
int length =0;//数组长度

int flag1=0;

if(ids == null){
	length = 0;
}else{
	length = ids.length;
}

/*if("callback".equals(up_status)){
	for(int i = 0; i < length; i++){
		sqlstr = "update contract_4material set material_status = '已回收'";
		sqlstr += ",materialRD_date='"+materialRD_date+"',materialRD_name=(select name from base_user where id='"+dqczy+"')";
		sqlstr+= " where material_type<>'只盖章'and id='"+ids[i]+"'";
		flag += db.executeUpdate(sqlstr); //所有不是”只盖章“的和。
		sqlstr+="  and material_type='只回收'";
		flag1 += db.executeUpdate(sqlstr);//只回收的条数
	}
}
else if("seal_callback".equals(up_status)){
	for(int i = 0; i < length; i++){
		sqlstr = "update contract_4material set material_status = '已盖章已回收'";
		sqlstr += ",materialRD_date='"+materialRD_date+"',materialRD_name=(select name from base_user where id='"+dqczy+"')";
		sqlstr+= " where material_type<>'只盖章',id='"+ids[i]+"'";
		flag += db.executeUpdate(sqlstr); 
	}
}*/

if("callback".equals(up_status)){
	for(int i = 0; i < length; i++){
		String sqlstr1temp="";
		String sqlstr1="";

		sqlstr = "update contract_4material set material_status = '已回收'";
		sqlstr1 = "update contract_4material set material_status = '已盖章已回收'";

		if (materialRD_date.equals("")){
		sqlstr1temp= ",materialRD_date=getdate(),materialRD_name=(select name from base_user where id='"+dqczy+"')";
		}else{
		sqlstr1temp= ",materialRD_date='"+materialRD_date+"',materialRD_name=(select name from base_user where id='"+dqczy+"')";
		}
		sqlstr1temp+= " where material_type<>'只盖章'and id='"+ids[i]+"'";

		sqlstr=sqlstr+sqlstr1temp;
		flag += db.executeUpdate(sqlstr); //所有不是”只盖章“的和。
		sqlstr1temp+="  and material_type<>'只回收'";
		sqlstr1=sqlstr1+sqlstr1temp;
		flag1 += db.executeUpdate(sqlstr1);//盖章+回收的条数
	}
}else if("nocallback".equals(up_status)){
	for(int i = 0; i < length; i++){
		String sqlstr1temp="";
		String sqlstr1="";

		sqlstr = "update contract_4material set material_status = '未回收'";
		sqlstr1 = "update contract_4material set material_status = '已盖章未回收'";

		sqlstr1temp= ",materialRD_date='',materialRD_name=(select name from base_user where id='"+dqczy+"')";
		sqlstr1temp+= " where material_type<>'只盖章'and id='"+ids[i]+"'";

		sqlstr=sqlstr+sqlstr1temp;
		flag += db.executeUpdate(sqlstr); //所有不是”只盖章“的和。
		sqlstr1temp+="  and material_type<>'只回收'";
		sqlstr1=sqlstr1+sqlstr1temp;
		flag1 += db.executeUpdate(sqlstr1);//盖章+回收的条数
	}
}


db.close();
if((length-flag==0)){
msg = length + "份材料已处理，其中只回收的是"+(flag-flag1)+"条，盖章+回收的是"+flag1+"条。执行"; 
}else{
msg = length + "份材料已处理，其中只回收的是"+(flag-flag1)+"条，盖章+回收的是"+flag1+"条，只盖章的数据是"+(length-flag)+"条，执行"; 
}
	

//3返回判断
if(flag == length){%>
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


