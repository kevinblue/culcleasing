<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");
String czid = getStr( request.getParameter("czid") );
String curr_date = getSystemDate(0);
String stype = getStr( request.getParameter("savetype") );

String	contract_id = getStr( request.getParameter("contract_id") );
String	equip_guarantee_type = getStr( request.getParameter("equip_guarantee_type") );
String	eqip_name = getStr( request.getParameter("eqip_name") );
String	equip_num = getStr( request.getParameter("equip_num") );
String	total_price = getStr( request.getParameter("total_price") );
String	equip_place = getStr( request.getParameter("equip_place") );
String	equip_sn = getStr( request.getParameter("equip_sn") );
String	ownership_document = getStr( request.getParameter("ownership_document") );
String	guarantor = getStr( request.getParameter("guarantor") );
String	second_hand_market = getStr( request.getParameter("second_hand_market") );
String	memo = getStr( request.getParameter("memo") );
String	equip_status = getStr( request.getParameter("equip_status") );
String	status_date = getStr( request.getParameter("status_date") );

String sqlstr;
ResultSet rs;
int flag=0;
String message="";

if ( stype.equals("add") ){ 
	sqlstr="insert into contract_guarantee_equip (contract_id ,equip_guarantee_type ,eqip_name ,equip_num ,total_price ,equip_place ,equip_sn ,ownership_document ,guarantor ,second_hand_market ,memo ,equip_status ,status_date,creator,create_date) values('"+contract_id+"','"+equip_guarantee_type+"','"+eqip_name+"',"+equip_num+","+total_price+",'"+equip_place+"','"+equip_sn+"','"+ownership_document+"','"+guarantor+"','"+second_hand_market+"','"+memo+"','"+equip_status+"','"+status_date+"','"+dqczy+"','"+curr_date+"')";
	System.out.println("sqlstr00======================"+sqlstr);
	flag = db.executeUpdate(sqlstr);
	message="添加合同抵押物件";
}
if ( stype.equals("mod") ){ 
		sqlstr="update contract_guarantee_equip set contract_id='"+contract_id+"',equip_guarantee_type='"+equip_guarantee_type+"',eqip_name='"+eqip_name+"',equip_num="+equip_num+",total_price="+total_price+",equip_place='"+equip_place+"',equip_sn='"+equip_sn+"',ownership_document='"+ownership_document+"',guarantor='"+guarantor+"',second_hand_market='"+second_hand_market+"',memo='"+memo+"',equip_status='"+equip_status+"',status_date='"+status_date+"',modificator='"+dqczy+"',modify_date='"+curr_date+"' where id='"+czid+"'";
		System.out.println("sqlstr11======================"+sqlstr);
		flag = db.executeUpdate(sqlstr);
		message="修改合同抵押物件";
}
if ( stype.equals("del") ){ 
	sqlstr="delete from contract_guarantee_equip where  id='"+czid+"'";
	flag = db.executeUpdate(sqlstr);
	message="删除合同抵押物件";
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
<%}db.close();%>