<%@ page contentType="text/html; charset=gbk" language="java"%>

<%@ page import="java.sql.*"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>代理商-首期付款列表</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

<script type="text/javascript">	
//删除时
function validate_del() {
	//是否有选中的付款单号
	var names=document.getElementsByName("list");
	var flag_bh=0;
	var str_bh="";//保存所要删除的付款单号
	var sql_bh_ids="";
	for(i=0;i<names.length;i++){
		if (names[i].checked){
			flag_bh++;
			var fid= names[i].value;
			str_bh+=fid+",";
			sql_bh_ids+="'"+fid+"',";
		}
	}
	
	str_bh=str_bh.substring(0,str_bh.length-1);
	sql_bh_ids=sql_bh_ids.substring(0,sql_bh_ids.length-1);
	//alert(sql_bh_ids);
	if (flag_bh==0) {
		alert("请选择您要删除的付款单号!");
		return false;
	}else {
		if (confirm("您是否确认删除付款单(付款单号:'"+str_bh+"')?")) {
			document.getElementById("savetype").value="del";
			document.getElementById("sql_bh_ids").value=sql_bh_ids;
			document.dataNav.action="apply_save_del.jsp";
			document.dataNav.target="_blank";
			document.dataNav.submit();
			document.dataNav.action="apply_list.jsp";
			document.dataNav.target="_self";
		}
	}
}
	
//提交时
function validate_sub() {
	//是否有选中的付款单号
	var names=document.getElementsByName("list");
	var flag_bh=0;
	var str_bh="";//保存所要提交的付款单号
	var sql_bh_ids="";
	for(i=0;i<names.length;i++){
		if (names[i].checked){
			flag_bh++;
			var fid= names[i].value;
			str_bh+=fid+",";
			sql_bh_ids+="'"+fid+"',";
		}
	}
	
	str_bh=str_bh.substring(0,str_bh.length-1);
	sql_bh_ids=sql_bh_ids.substring(0,sql_bh_ids.length-1);
	if (flag_bh==0) {
		alert("请选择您要提交的付款单号!");
		return false;
	}else {
		if (confirm("您是否确认提交付款单(付款单号:'"+str_bh+"')?")) {
			document.getElementById("savetype").value="sub";
			document.getElementById("sql_bh_ids").value=sql_bh_ids;
			document.dataNav.action="apply_save_del.jsp";
			document.dataNav.target="_blank";
			document.dataNav.submit();
			document.dataNav.action="apply_list.jsp";
			document.dataNav.target="_self";
		}
	}
}
</script>		
</head>

<body onload="public_onload(0);">
<form action="apply_list.jsp" name="dataNav" onSubmit="return goPage()">
<input name="savetype" id="savetype" type="hidden" value="del">
<input name="sql_bh_ids" id="sql_bh_ids" type="hidden">
	
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
			首期付款列表
		</td>
	</tr>
</table><!--标题结束-->

<%
String dqczy=(String) session.getAttribute("czyid");

String sqlstr="";
ResultSet rs=null;
String wherestr=" where 1=1 and apply_info.status<>'已核销' and pay_type='资金' and isnull(is_sub,'')<>'已提交' ";

//判断代理商还是租赁公司
String filterAgent = "";
String loginBmbh = "";//登录用户的部门编号
sqlstr="select bmbh from jb_yhxx where id='"+ dqczy +"'";
//执行查询
rs = db.executeQuery(sqlstr);
if (rs.next()){
	loginBmbh = rs.getString("bmbh");
	try{
		Integer.parseInt(loginBmbh);
		filterAgent = " and creator in ('')";	
	}catch(Exception e){//代理商
		filterAgent = " and creator in (select jb_yhxx.id from jb_yhxx where jb_yhxx.bmbh = '"+loginBmbh+"' )";	
	}
	if( "".equals(loginBmbh) ){//租赁物公司部门编号为数字或""
		//filterAgent = " and creator in ('')";	
		filterAgent = "";	
	}
}else {//错误操作
	System.out.println("++++权限丢失++++"); %>
	<script language="javascript">
	window.parent.parent.location.replace("http://online.strongflc.com/names.nsf?logout");
	</script> 
<%	}

sqlstr = "select apply_info.* from apply_info  "+wherestr+filterAgent+" order by create_date desc"; 
%>

<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
	<td align="left" width="1%">
		<!--操作按钮开始-->
		<table border="0" cellspacing="0" cellpadding="0">
		<tr class="maintab">
			<td nowrap>
				<BUTTON class="btn_2" name="btnAdd" value="新增"  type="button" onclick="dataHander('add','apply_add.jsp',dataNav.itemselect);">
				<img src="../../images/sbtn_new.gif" align="absmiddle" border="0">&nbsp;新增</button>
			</td>
			<td>
				<BUTTON class="btn_2" name="btndel" value="删除"  type="button" onclick="validate_del();">
				<img src="../../images/sbtn_del.gif" align="absmiddle" border="0">&nbsp;删除</button>
			</td>
			<td>
				<BUTTON class="btn_2" name="btndel" value="提交"  type="button" onclick="validate_sub();">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;提交</button>
			</td>
			<td>
				<img src="../../images/sbtn_split.gif" width="2" height="14">
			</td>
			<td nowrap>
				<input name="ck_all" type="checkbox">全选
				<input name="inverse_ck_all" type="checkbox">反选
			</td>
		</tr>
		</table>
		<!--操作按钮结束-->
	</td>
	<td align="right" width="90%">
	<!--翻页控制开始-->
	<%@ include file="../../public/pageSplitNoCode.jsp"%>
	</td><!--翻页控制结束-->	
	</tr>
</table>

<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
	<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"
		class="maintab_content_table">
		<tr class="maintab_content_table_title">
			 <th width="1%"></th> 			 						
			 <th>付款单号</th>
			 <th width='80'>付款金额</th>
			 <th>付款日期</th>
			 <th>确认状态</th>
		</tr>
<tbody id="data">
<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
		<tr>
			<td><input type="checkbox" name="list" value="<%=getDBStr(rs.getString("id"))%>"></td>	
			<td align="center"><a href="apply.jsp?czid=<%=getDBStr(rs.getString("id"))%>" target="_blank"><%=getDBStr(rs.getString("id"))%></a></td>
			<td align="center"><%=CurrencyUtil.convertFinance(rs.getDouble("pay_amt")) %></td>
			<td align="center"><%=getDBDateStr(rs.getString("pay_date")) %></td>
			<td align="center"><%=getDBStr(rs.getString("status")) %></td>
		</tr>
<%
		rs.next();
		i++;
	}
}
rs.close(); 
db.close();
%>
	</tbody></table>
</div><!--报表结束-->
</form>
</body>
</html>

