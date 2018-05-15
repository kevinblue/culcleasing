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
	String invoice_remark="";
	String kj=getStr(request.getParameter("kj"));//开具
	System.out.println("aaaaakj"+kj);
	String zckj=getStr(request.getParameter("zckj"));//正常开具
		System.out.println("aaaaazckj"+zckj);
	String updsql=getStr(request.getParameter("updsql"));//sql语句\
	System.out.println("updsql  :"+  updsql);

	if( (kj!=null && !"".equals(kj)) || (zckj!=null && !"".equals(zckj)) ){
		//System.out.println("SSS000");
		ResultSet rs1 = null;
		rs1=db1.executeQuery(updsql);
		invoice_is = kj.equals("开具")?"是":"否";
		invoice_normal = zckj.equals("正常开具")?"是":"否";
	
		while(rs1.next()){
			begin_id = rs1.getString("begin_id");
			rent_list = rs1.getString("rent_list");
			
			sqlstr="select id from invoice_rent_detail where begin_id='"+begin_id+"' and rent_list='"+rent_list+"'";
			rs=db.executeQuery(sqlstr);
			if(rs.next()){
				sqlstr = "update invoice_rent_detail set invoice_is='"+invoice_is+"' , invoice_remark='"+invoice_remark+"'";
				sqlstr+= ",modificator='"+dqczy+"',modify_date=getdate(),invoice_normal='"+invoice_normal+"'";
				sqlstr+= " where begin_id='"+begin_id+"' and rent_list='"+rent_list+"'";
				flag += db.executeUpdate(sqlstr);
			}else{
				sqlstr="insert into invoice_rent_detail values('"+begin_id+"','"+rent_list+"','"+invoice_is+"','"+invoice_normal+"','"+invoice_remark+"','"+dqczy+"',getdate(),'"+dqczy+"',getdate())";
				flag = db.executeUpdate(sqlstr);
			}
		}
	}

	//注意操作 都为空的情况
	if((kj==null || "".equals(kj)) && (zckj==null || "".equals(zckj))){//非全选操作
		for(int i=0;i<item.length;i++){
			if(item[i]==null || "".equals(item[i]) || "|".equals(item[i])){
				continue;
			}
			
			LogWriter.logDebug(request, "sqlstr:"+item.length+"----------dogcat-----"+item[i]);
			LogWriter.logDebug(request, "我要的begin_id"+begin_id);	
	
			itemId = getStr(request.getParameter("item_"+item[i]));
			begin_id=getStr(request.getParameter("begin_id_"+item[i]));
			rent_list=getStr(request.getParameter("rent_list_"+item[i]));
			invoice_is = getStr(request.getParameter("invoice_is_"+item[i]));
			invoice_normal = getStr(request.getParameter("invoice_normal_"+item[i]));
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
	
				sqlstr="insert into invoice_rent_detail values('"+begin_id+"','"+rent_list+"','"+invoice_is+"','"+invoice_normal+"','"+invoice_remark+"','"+dqczy+"',getdate(),'"+dqczy+"',getdate())";
				LogWriter.logDebug(request, "我要的sql"+sqlstr);
				flag = db.executeUpdate(sqlstr);
			}
		}
	}
	
	LogWriter.logDebug(request, "租金发票管理 确认");
	msg = "租金发票管理确认";
}

db.close();
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
<%} %>
</BODY>
</HTML>
<%if(null != db1){db1.close();}%>