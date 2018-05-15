<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>

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
String sql_bh_ids = getStr( request.getParameter("sql_bh_ids") );

String sqlstr="";
int flag=0;
String message="";
String stype =  getStr( request.getParameter("savetype") );

if ( stype.equals("del") ){ 
	sqlstr=" delete apply_info where  id in ("+sql_bh_ids+") ";
	sqlstr+=" delete apply_info_detail where  apply_id in ("+sql_bh_ids+") ";

	System.out.println("sqlstr:"+sqlstr);
	flag += db.executeUpdate(sqlstr);

	message="删除代理公司首期付款";
} else if ( stype.equals("sub") ){ 
	sqlstr=" update apply_info set is_sub='已提交',status='未核销' where  id in ("+sql_bh_ids+") ";
	//sqlstr+=" delete apply_info_detail where  apply_id in ("+sql_bh_ids+") ";

	System.out.println("sqlstr:"+sqlstr);
	flag += db.executeUpdate(sqlstr);

	message="提交代理公司首期付款";
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
</body>
</html>