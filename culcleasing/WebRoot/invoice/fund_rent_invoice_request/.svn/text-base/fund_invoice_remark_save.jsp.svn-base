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
String type = getStr( request.getParameter("type") );

//基本变量
dqczy = (String) session.getAttribute("czyid");//当前登陆人
String datestr = getSystemDate(0); //获取系统时间

int flag = 0;
String msg = "";
 
if("updStatus".equals(type)){
	//修改状态
	String items = request.getParameter("itemStr");
	System.out.println("---"+items);
	String[] item = items.split("\\|");
	String invoice_is = "";
	String itemId = "";
	String contract_id="";
	String fee_name="";
	String fee_num="";
	String pri_id="";
	String invoice_remark="";
	String updsql=getStr(request.getParameter("updsql"));//sql语句\
	String invoice_date=getStr(request.getParameter("invoice_date"));//开票日期
	System.out.println("updsql  :"+  updsql);
	
		for(int i=0;i<item.length;i++){
			if(item[i]==null || "".equals(item[i]) || "|".equals(item[i])){
				continue;
			}		
			LogWriter.logDebug(request, "sqlstr8888:"+item.length+"----------dogcat-----"+item[i]);
			itemId = getStr(request.getParameter("item_"+item[i]));
			contract_id=getStr(request.getParameter("contract_id_"+item[i]));
			fee_name=getStr(request.getParameter("fee_name_"+item[i]));
			fee_num=getStr(request.getParameter("fee_num_"+item[i]));
			//System.out.println("测试:"+fee_num);
			invoice_is = getStr(request.getParameter("invoice_is_"+item[i]));
			invoice_remark=getStr(request.getParameter("invoice_remark_"+item[i]));
			pri_id=request.getParameter("pri_id_"+item[i]);
			
			int t=0;	
			ResultSet rs1 = null;
			rs1=db1.executeQuery(updsql);
			if(rs1.next()){

				String sqlstr2 = "update invoice_fund_detail set invoice_is='"+invoice_is+"' , invoice_remark='"+invoice_remark+"'";
					   sqlstr2+= ",modificator='"+dqczy+"',modify_date=getdate()";
				       sqlstr2+= " where contract_id='"+contract_id+"' and fee_name='"+fee_name+"' and fee_num='"+fee_num+"' and pri_id='"+pri_id+"'";
				flag += db.executeUpdate(sqlstr2);
			}else{
	
				String sqlstr3="insert into invoice_fund_detail ( contract_id,pri_id,fee_name,fee_num,invoice_remark,creator,create_date,modificator,modify_date) values('"+contract_id+"',"+pri_id+",'"+fee_name+"','"+fee_num+"','"+invoice_remark+"','"+dqczy+"',getdate(),'"+dqczy+"',getdate())";
				flag = db.executeUpdate(sqlstr3);
			}
			rs1.close();
		}
	

}

db.close();
db1.close();
//3返回判断
if(flag>0){%>
	<script type="text/javascript">
		window.opener.location.reload();window.alert("备注维护成功！");
		window.opener = null;
		window.open("","_self");
		window.close();
		
	</script>	
<%}else{
%>
	<script type="text/javascript">
		window.opener.location.reload();window.alert("备注维护失败！");
		window.opener = null;
		window.open("","_self");
		window.close();
	</script>
<%} %>
</BODY>
</HTML>
