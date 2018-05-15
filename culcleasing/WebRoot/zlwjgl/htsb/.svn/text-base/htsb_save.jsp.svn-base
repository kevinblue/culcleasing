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
String	eqip_name = getStr( request.getParameter("eqip_name") );
String	brand = getStr( request.getParameter("brand") );
String	model = getStr( request.getParameter("model") );
String	equip_sn = getStr( request.getParameter("equip_sn") );
String	equip_price = getStr( request.getParameter("equip_price") );
String	equip_num = getStr( request.getParameter("equip_num") );
String	total_price = getStr( request.getParameter("total_price") );
String	manufacturer = getStr( request.getParameter("manufacturer") );
String	distributor = getStr( request.getParameter("distributor") );
String	equip_delivery_place = getStr( request.getParameter("equip_delivery_place") );
String	equip_status = getStr( request.getParameter("equip_status") );
String	status_date = getStr( request.getParameter("status_date") );

String	equip_place = getStr( request.getParameter("equip_place") );
String	equip_delivery_date = getStr( request.getParameter("equip_delivery_date") );
String	shelf_life = getStr( request.getParameter("shelf_life") );
String	tax_flag = getStr( request.getParameter("tax_flag") );

String sqlstr;
ResultSet rs;
int flag=0;
String message="";

if ( stype.equals("add") ){ 
	sqlstr="insert into contract_equip (contract_id,eqip_name,brand,model,equip_sn,equip_price,equip_num,total_price,manufacturer,distributor,equip_delivery_place,equip_status,status_date,creator,create_date,equip_place,equip_delivery_date,shelf_life,tax_flag) values('"+contract_id+"','"+eqip_name+"','"+brand+"','"+model+"','"+equip_sn+"',"+equip_price+","+equip_num+","+total_price+",'"+manufacturer+"','"+distributor+"','"+equip_delivery_place+"','"+equip_status+"','"+status_date+"','"+dqczy+"','"+curr_date+"','"+equip_place+"','"+equip_delivery_date+"','"+shelf_life+"','"+tax_flag+"')";
	System.out.println("sqlstr00======================"+sqlstr);
	flag = db.executeUpdate(sqlstr);
	message="添加合同设备维护";
}
if ( stype.equals("mod") ){ 
		sqlstr="update contract_equip set contract_id='"+contract_id+"',eqip_name='"+eqip_name+"',brand='"+brand+"',model='"+model+"',equip_sn='"+equip_sn+"',equip_price="+equip_price+",equip_num="+equip_num+",total_price="+total_price+",manufacturer='"+manufacturer+"',distributor='"+distributor+"',equip_delivery_place='"+equip_delivery_place+"',equip_status='"+equip_status+"',status_date='"+status_date+"',equip_place='"+equip_place+"',equip_delivery_date='"+equip_delivery_date+"',shelf_life='"+shelf_life+"',tax_flag='"+tax_flag+"',modificator='"+dqczy+"',modify_date='"+curr_date+"' where id='"+czid+"'";
		System.out.println("sqlstr11======================"+sqlstr);
		flag = db.executeUpdate(sqlstr);
		message="修改合同设备维护";
}
if ( stype.equals("del") ){ 
	sqlstr="delete from contract_equip where  id='"+czid+"'";
	flag = db.executeUpdate(sqlstr);
	message="删除合同设备维护";
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