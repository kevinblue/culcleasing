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
	String invoice_normal="";
	String itemId = "";
	String begin_id="";
	String rent_list="";
	String invoice_remark=request.getParameter("invoice_remark");;
	String updsql=getStr(request.getParameter("updsql"));//sql语句\
	System.out.println("updsql  :"+  updsql);
	String invoice_date_str = " ";
		ResultSet rs1 = null;
		rs1=db1.executeQuery(updsql);
		for(int i=0;i<item.length;i++){
			if(item[i]==null || "".equals(item[i]) || "|".equals(item[i])){
				continue;
			}
			
			LogWriter.logDebug(request, "sqlstr:"+item.length+"----------dogcat-----"+item[i]);
			itemId = getStr(request.getParameter("item_"+item[i]));
			begin_id=getStr(request.getParameter("begin_id_"+item[i]));
			rent_list=getStr(request.getParameter("rent_list_"+item[i]));
			invoice_remark=getStr(request.getParameter("invoice_remark_"+item[i]));
			int t=0;			
			sqlstr="select id from invoice_rent_detail where begin_id='"+begin_id+"' and rent_list='"+rent_list+"'";
			rs=db.executeQuery(sqlstr);
			if(rs.next()){
				sqlstr = "update invoice_rent_detail set invoice_is='"+invoice_is+"' , invoice_remark='"+invoice_remark+"'";
				sqlstr+= ",modificator='"+dqczy+"',modify_date=getdate(),invoice_normal='"+invoice_normal+"'";
				sqlstr+= " where begin_id='"+begin_id+"' and rent_list='"+rent_list+"'";
				LogWriter.logDebug(request, "我要的sqlstr"+sqlstr);	
				flag += db.executeUpdate(sqlstr);
			}else{
	
				sqlstr="insert into invoice_rent_detail (begin_id,rent_list,invoice_is,invoice_normal,invoice_remark,creator,create_date,modificator,modify_date) values('"+begin_id+"','"+rent_list+"','"+invoice_is+"','"+invoice_normal+"','"+invoice_remark+"','"+dqczy+"',getdate(),'"+dqczy+"',getdate())";
				LogWriter.logDebug(request, "我要的sql"+sqlstr);
				flag = db.executeUpdate(sqlstr);
			}
		}

	LogWriter.logDebug(request, "租金发票备注维护");
	msg = "修改备注";
}

db.close();
//3返回判断
if(flag>0){%>
	<script type="text/javascript">
		window.close();
		opener.alert("维护成功!");
		opener.location.reload();
	</script>	
<%}else{
%>
	<script type="text/javascript">
	window.close();
	opener.alert("维护失败!");
	opener.location.reload();
	</script>
<%} %>
</BODY>
</HTML>
<%if(null != db1){db1.close();}
if(null != db){db.close();}
%>