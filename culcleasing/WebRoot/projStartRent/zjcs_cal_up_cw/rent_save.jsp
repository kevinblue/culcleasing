<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %> 
<%@ page import="com.tenwa.log.LogWriter"%>
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" /> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>
<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->
<BODY>
<%
	//0.基础参数

	
	String datestr = getSystemDate(0); //获取系统时间

	int flag = 0;

	String invoice_is=getStr(request.getParameter("invoice_is"));
	String begin_id=getStr(request.getParameter("begin_id"));
	String invoice_date=getStr(request.getParameter("invoice_date"));
	String drawing_doc_id = getStr(request.getParameter("drawing_doc_id"));
	String drawing_is = getStr(request.getParameter("drawing_is"));
	sqlstr="select id from invoice_rent_detail where begin_id='"+begin_id+"' and rent_list=1";
	rs=db.executeQuery(sqlstr);
		if(rs.next()){
				sqlstr = "update invoice_rent_detail set invoice_is='"+invoice_is+"',invoice_date='"+invoice_date+"',modificator='"+dqczy+"',modify_date=getdate() ";
				sqlstr+= " where begin_id='"+begin_id+"' and rent_list=1";
				
				flag = db.executeUpdate(sqlstr);
		}else{
				sqlstr = "insert into invoice_rent_detail( begin_id,rent_list,invoice_is,invoice_normal,invoice_remark,creator,create_date,modificator,modify_date,invoice_date) ";
				sqlstr+="values('"+begin_id+"',1,'"+invoice_is+"',null,null,'"+dqczy+"',getdate(),'"+dqczy+"',getdate(),'"+invoice_date+"')";
				System.out.println("测试:"+sqlstr);
				flag = db.executeUpdate(sqlstr);
		}
	
		ResultSet rs2 = null;
		String sqlstr2 ="select *  from invoice_draw_detail where begin_id='"+begin_id+"' and rent_list=1 ";
		rs2 = db1.executeQuery(sqlstr2);
		if(rs2.next()){
			if("1".equals(drawing_is)){
			sqlstr2 = "update invoice_draw_detail set draw_flag='"+drawing_is+"',modify_date=getdate() where begin_id='"+begin_id+"' and rent_list=1 ";
			}else{
			sqlstr2 = "delete from invoice_draw_detail where  begin_id='"+begin_id+"' and rent_list=1 ";
			}
			db1.executeUpdate(sqlstr2);
		}else{
			if("1".equals(drawing_is)){
			sqlstr2 = "insert into invoice_draw_detail (begin_id,apply_id,rent_list,pri_id,invoice_type,draw_flag,draw_date,creator,create_date) ";
			sqlstr2 +="select '"+begin_id+"','"+drawing_doc_id+"',1,null,'租金','"+drawing_is+"',getdate(),'"+dqczy+"',getdate()";
			db1.executeUpdate(sqlstr2);
			}
		}
			System.out.println("起租是否领取操作SQL="+sqlstr2);
		rs2.close();
		db1.close();
	db.close();

//所有操作成功
if(flag>0){
%>
    <script type="text/javascript">
		alert("第一期租金开具确认成功!");
		window.parent.location.reload();
	    window.close();
	</script>
<%
}else{
%>
    <script type="text/javascript">
		alert("数据更新失败!");
		window.parent.location.reload();
		this.close();
	</script>
<%	
}
%>
