<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*"%>
<%@ page import="com.tenwa.log.LogWriter"%>
<%@page import="com.OperationUtil"%>
<%@page import="java.util.Date"%>
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title>客户项目信息 - 客户纳税人信息保存</title>
	<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
	<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
	<script src="../../js/calend.js"></script>
</head>
<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->
<BODY>
		<%
			String datestr = getSystemDate(0); //获取系统时间

			String cust_id = getStr( request.getParameter("cust_id") );
			String id = getStr( request.getParameter("id") );
			String tax_payer_type=getStr( request.getParameter("tax_payer_type") );
			String tax_payer_no=getStr( request.getParameter("tax_payer_no") );
			String is_dk=getStr( request.getParameter("is_dk") );
			String tax_type_invoice=getStr( request.getParameter("tax_type_invoice") );
			String address=getStr( request.getParameter("address") );
			String tel=getStr( request.getParameter("tel") );
			String bank_name=getStr( request.getParameter("bank_name") );
			String bank_no=getStr( request.getParameter("bank_no") );
	
			

			String uid="";
			int flag=0;
			String sqlstr1="select id from base_taxPayer where id='"+id+"' and cust_id='"+cust_id+"'";
			ResultSet rs1=null;
			rs1=db.executeQuery(sqlstr1);
			if(rs1.next()){
				uid=rs1.getString("id");
			}
			if(uid!=""){
				sqlstr="update base_taxPayer set tax_payer_type='"+tax_payer_type+"',tax_payer_no='"+tax_payer_no+"',is_dk='"+is_dk+"',tax_type_invoice='"+tax_type_invoice+"',address='"+address+"',tel='"+tel+"',bank_name='"+bank_name+"',bank_no='"+bank_no+"' where cust_id='"+cust_id+"' and id="+id;
				flag=db.executeUpdate(sqlstr);
				System.out.println("测试数据"+sqlstr);
				System.out.println("flag:"+flag);
				
			}else{
				sqlstr="insert into base_taxPayer(cust_id,tax_payer_type,tax_payer_no,is_dk,tax_type_invoice,address,tel,bank_name,bank_no,createor,create_date,modificator,modify_date) select '"+cust_id+"','"+tax_payer_type+"','"+tax_payer_no+"','"+is_dk+"','"+tax_type_invoice+"','"+address+"','"+tel+"','"+bank_name+"','"+bank_no+"','"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"'";
				flag=db.executeUpdate(sqlstr);
				System.out.println("测试数据"+sqlstr);
				System.out.println("flag:"+flag);
			}
	
			
			db.close();
if (flag > 0) {
System.out.println("成功！！！！！");
%>
<script type="text/javascript">
window.location.href = "nsrxx_list.jsp?cust_id=<%=cust_id%>";
alert("纳税人信息更新成功!");
this.close();
</script>
<%
} else {
%>
<script type="text/javascript">
alert("纳税人信息更新失败!");
window.location.href = "nsrxx_upd.jsp?cust_id=<%=cust_id%>";
</script>
<%}%>
</BODY>
</html>
