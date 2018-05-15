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
	String kj=getStr(request.getParameter("kj"));//开具
	System.out.println("aaaaakj"+kj);
	String updsql=getStr(request.getParameter("updsql"));//sql语句\
	String invoice_date=getStr(request.getParameter("invoice_date"));//开票日期
	System.out.println("updsql  :"+  updsql);
	String invoice_date_str = " ";
	/**
	if( (invoice_date!=null && !"".equals(invoice_date))  ){
		
		ResultSet rs1 = null;
		rs1=db1.executeQuery(updsql);
		
	
		while(rs1.next()){
			contract_id = rs1.getString("contract_id");
			fee_name = rs1.getString("fee_name");
			fee_num = rs1.getString("fee_num");
			pri_id=rs1.getString("id");

			
			System.out.println("测试:"+fee_num);
			sqlstr="select id from invoice_fund_detail where contract_id='"+contract_id+"' and fee_name='"+fee_name+"' and fee_num='"+fee_num+"' and pri_id="+pri_id;
			rs=db.executeQuery(sqlstr);
			if(rs.next()){
				sqlstr = "update invoice_fund_detail set invoice_date='"+invoice_date+"', invoice_remark='"+invoice_remark+"'";
				sqlstr+= ",modificator='"+dqczy+"',modify_date=getdate() ";
				sqlstr+= " where contract_id='"+contract_id+"' and fee_name='"+fee_name+"' and fee_num='"+fee_num+"' and pri_id="+pri_id;
				
				flag += db.executeUpdate(sqlstr);
			}else{
				sqlstr = "insert into invoice_fund_detail( contract_id,pri_id,fee_name,fee_num,invoice_is,invoice_remark,invoice_date,creator,create_date,modificator,modify_date) ";
				sqlstr+="values('"+contract_id+"',"+pri_id+",'"+fee_name+"','"+fee_num+"','"+invoice_is+"','"+invoice_remark+"','"+invoice_date+"','"+dqczy+"',getdate(),'"+dqczy+"',getdate())";
				System.out.println("aaabb11111:"+sqlstr);
				flag = db.executeUpdate(sqlstr);
			}
		}
	}
*/
	if( (invoice_date!=null && !"".equals(invoice_date))  ){
		invoice_date_str = ",invoice_date='"+invoice_date+"'";
		
	}
System.out.println("kjkjkjk"+kj);
	if( (kj!=null && !"".equals(kj))  ){
		System.out.println("SSS0004321"+ kj+" SQL="+updsql);
		ResultSet rs1 = null;
		rs1=db1.executeQuery(updsql);
		invoice_is = kj.equals("开具")?"是":"否";
	
		while(rs1.next()){
			contract_id = rs1.getString("contract_id");
			fee_name = rs1.getString("fee_name");
			fee_num = rs1.getString("fee_num");
			pri_id=rs1.getString("id");

			
			System.out.println("测试:"+fee_num);
			sqlstr="select id from invoice_fund_detail where contract_id='"+contract_id+"' and fee_name='"+fee_name+"' and fee_num='"+fee_num+"' and pri_id="+pri_id;
			rs=db.executeQuery(sqlstr);
			if(rs.next()){
				sqlstr = "update invoice_fund_detail set invoice_is='"+invoice_is+"'" ;
				sqlstr+= ",modificator='"+dqczy+"',modify_date=getdate() "+invoice_date_str;
				sqlstr+= " where contract_id='"+contract_id+"' and fee_name='"+fee_name+"' and fee_num='"+fee_num+"' and pri_id="+pri_id;
				
				flag += db.executeUpdate(sqlstr);
			}else{
				sqlstr = "insert into invoice_fund_detail( contract_id,pri_id,fee_name,fee_num,invoice_is,invoice_remark,invoice_date,creator,create_date,modificator,modify_date) ";
				sqlstr+="values('"+contract_id+"',"+pri_id+",'"+fee_name+"','"+fee_num+"','"+invoice_is+"','"+invoice_remark+"','"+invoice_date+"','"+dqczy+"',getdate(),'"+dqczy+"',getdate())";
				//System.out.println("aaabb11111:"+sqlstr);
				flag = db.executeUpdate(sqlstr);
			}
		}
	}

	
	//注意操作 都为空的情况 
	//注：当开具的checkBox为空的时候，证明操作只针对当前页，不包含其它页，如果checkBox不为空的时候，是针对查询条件下所有数据，即所有页数据
	if((kj==null || "".equals(kj))){//非全选操作
		for(int i=0;i<item.length;i++){
			if(item[i]==null || "".equals(item[i]) || "|".equals(item[i])){
				continue;
			}
			
			LogWriter.logDebug(request, "sqlstr8888:"+item.length+"----------dogcat-----"+item[i]);
			//LogWriter.logDebug(request, "我要的begin_id"+begin_id);	
	
			itemId = getStr(request.getParameter("item_"+item[i]));
			contract_id=getStr(request.getParameter("contract_id_"+item[i]));
			fee_name=getStr(request.getParameter("fee_name_"+item[i]));
			fee_num=getStr(request.getParameter("fee_num_"+item[i]));
			//System.out.println("测试:"+fee_num);
			invoice_is = getStr(request.getParameter("invoice_is_"+item[i]));
			invoice_remark=getStr(request.getParameter("invoice_remark_"+item[i]));
			pri_id=request.getParameter("pri_id_"+item[i]);
			
			int t=0;
			
			// 针对 当页数据拼接的情况下，开票日期可以这样处理。
			if( (invoice_date!=null && !"".equals(invoice_date) && "是".equals(invoice_is))  ){
				invoice_date_str = ",invoice_date='"+invoice_date+"'";
				
			}else{
				invoice_date_str = " ";
			}
			
			ResultSet rs1 = null;
			String sqlstr78="select * from invoice_fund_detail where contract_id='"+contract_id+"' and fee_name='"+fee_name+"' and fee_num='"+fee_num+"' and pri_id='"+pri_id+"'";
			//System.out.println("一共多少行6666="+sqlstr78);
			rs1=db1.executeQuery(sqlstr78);
			if(rs1.next()){

				String sqlstr2 = "update invoice_fund_detail set invoice_is='"+invoice_is+"' , invoice_remark='"+invoice_remark+"'";
					   sqlstr2+= ",modificator='"+dqczy+"',modify_date=getdate()"+invoice_date_str;
				       sqlstr2+= " where contract_id='"+contract_id+"' and fee_name='"+fee_name+"' and fee_num='"+fee_num+"' and pri_id='"+pri_id+"'";;
				//LogWriter.logDebug(request, "我要的UpdateSqlstr2"+sqlstr2);
				//System.out.println("sqlstr2==="+sqlstr2);
				flag += db.executeUpdate(sqlstr2);
			}else{
	
				String sqlstr3="insert into invoice_fund_detail ( contract_id,pri_id,fee_name,fee_num,invoice_is,invoice_remark,invoice_date,creator,create_date,modificator,modify_date) values('"+contract_id+"',"+pri_id+",'"+fee_name+"','"+fee_num+"','"+invoice_is+"','"+invoice_remark+"','"+("是".equals(invoice_is)?invoice_date:"")+"','"+dqczy+"',getdate(),'"+dqczy+"',getdate())";
				//LogWriter.logDebug(request, "我要的InsertSql3"+sqlstr3);
				//System.out.println("sqlstr3==="+sqlstr3);
				flag = db.executeUpdate(sqlstr3);
			}
			rs1.close();
		}
	}
	
	//LogWriter.logDebug(request, "资金发票管理确认");
	msg = "资金发票管理确认";
}

db.close();
db1.close();
//3返回判断
if(flag>0){%>
	<script type="text/javascript">
		//window.close();
		//window.opener.alert("<%=msg %>成功!");
		//window.opener.location.reload();
		//window.opener.location.href=window.opener.location.href;
		
		window.opener.location.reload();window.alert("<%=msg%>成功！");
		window.opener = null;
		window.open("","_self");
		window.close();
		
	</script>	
<%}else{
%>
	<script type="text/javascript">
		//window.close();
		//window.opener.alert("<%=msg %>失败!");
		//window.opener.location.reload();
		//window.opener.location.href=window.opener.location.href;
		window.opener.location.reload();window.alert("<%=msg%>失败！");
		window.opener = null;
		window.open("","_self");
		window.close();
	</script>
<%} %>
</BODY>
</HTML>
