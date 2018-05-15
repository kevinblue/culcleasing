<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@page import="com.tenwa.log.LogWriter"%>

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
String systemDate = getSystemDate(0);

int flag=0;
String sqlstr="";
String message="";
String stype =  getStr( request.getParameter("savetype") );


if ( stype.equals("del") ){ 
	//获取参数
	String glide_id= getStr( request.getParameter("glide_id") );
	String[] priIdS=request.getParameterValues("list");
	//删除detail表
	for(int i = 0; i < priIdS.length; i++) {
		sqlstr = "Delete from invoice_draw_detail_t where pri_id='"+priIdS[i]+"' and invoice_type='资金' ";
		flag += db.executeUpdate(sqlstr);
	}
	
	//更新apply_info表
	sqlstr="Update invoice_draw_info_t set amount_t=isnull(amount_t,0)-"+priIdS.length+",amount_zj=isnull(amount_zj,0)-"+priIdS.length+" where glide_id ='"+glide_id+"' ";
	flag += db.executeUpdate(sqlstr);
	
	message="删除资金发票";
} else if ( stype.equals("add") ){ 
	//获取参数
	String glide_id= getStr( request.getParameter("glide_id") );
	String[] priIdS=request.getParameterValues("list");
	request.setCharacterEncoding("utf-8");
	String items = request.getParameter("itemStr");
	System.out.println("-items-"+items);
	String[] item = items.split(",");
	//插入detail表
	for(int i = 0; i < priIdS.length; i++) {
		sqlstr = "Insert into invoice_draw_detail_t(contract_id,apply_id,pri_id,invoice_type,invoice_date,invoice_no,draw_flag,creator,create_date)";
		sqlstr += "Select contract_id,'"+glide_id+"',id,'资金',invoice_date,'"+item[i]+"','0','"+dqczy+"','"+systemDate+"' from vi_func_fund_manage_back where id='"+priIdS[i]+"'";
		flag += db.executeUpdate(sqlstr);
	}
	
	//更新apply_info表
	sqlstr="Update invoice_draw_info_t set amount_t=isnull(amount_t,0)+"+priIdS.length+",amount_zj=isnull(amount_zj,0)+"+priIdS.length+" where glide_id ='"+glide_id+"' ";
	flag += db.executeUpdate(sqlstr);

	//插入detail表
	//for(int i = 0; i < priIdS.length; i++) {
	//	String remark=item[i];//退票号
		//System.out.println("changdu------------"+priIdS.length);
	//	System.out.println("beiz------------"+remark);
	//	sqlstr = "update invoice_fund_detail set remark='"+remark+"' where contract_id=(select contract_id from vi_func_fund_manage_back where id='"+priIdS[i]+"') and fee_name=(select fee_name from vi_func_fund_manage_back where id='"+priIdS[i]+"') and fee_num=(select fee_num from vi_func_fund_manage_back where id='"+priIdS[i]+"')";
		//System.out.println("ceshi-------------"+sqlstr);
	//	flag += db.executeUpdate(sqlstr);
	//}
	message="新增资金发票";
}
if(flag!=0){
%>
<script>
	opener.alert("<%=message%>成功!");
	opener.location.reload();
	
	if(window.opener){
		window.opener=null;window.open('','_self');
		window.close();} 
	 else{history.back()}
</script>
<%
}else{
%>
<script>
	opener.alert("<%=message%>失败!");
	opener.location.reload();
	
	if(window.opener){
		window.opener=null;window.open('','_self');
		window.close();} 
	 else{history.back()}
</script>
<%}
db.close();%>
</body>
</html>