<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*"%>
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>租金撤销 - 申请列表</title>
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
	//是否有选中的数据
	var names=document.getElementsByName("list");
	var flag_bh=0;
	var sql_bh_ids="";//保存所要删除的id
	for(i=0;i<names.length;i++){
		if (names[i].checked){
			flag_bh++;
			var fid= names[i].value;
			sql_bh_ids+="'"+fid+"',";
		}
	}
		
	sql_bh_ids=sql_bh_ids.substring(0,sql_bh_ids.length-1);
	//alert(sql_bh_ids);
	if (flag_bh==0) {
		alert("请选择您要删除的申请数据!");
		return false;
	}else {
		if (confirm("您是否确认要删除?")) {
			document.getElementById("savetype").value="del";
			document.getElementById("sql_bh_ids").value=sql_bh_ids;
			document.dataNav.action="cx_sq_save.jsp";
			document.dataNav.target="_blank";
			document.dataNav.submit();
			document.dataNav.action="cx_sq_list.jsp";
			document.dataNav.target="_self";
		}
	}
}		
//提交时
function validate_sub() {
	//是否有选中数据
	var names=document.getElementsByName("list");
	var flag_bh=0;
	var sql_bh_ids="";//选中数据Id
	for(i=0;i<names.length;i++){
		if (names[i].checked){
			flag_bh++;
			var fid= names[i].value;
			sql_bh_ids+="'"+fid+"',";
		}
	}

	sql_bh_ids=sql_bh_ids.substring(0,sql_bh_ids.length-1);
	if (flag_bh==0) {
		alert("请选择您要提交的申请!");
		return false;
	}else {
		if (confirm("您是否确认提交您选中的申请?")) {
			document.getElementById("savetype").value="sub";
			document.getElementById("sql_bh_ids").value=sql_bh_ids;
			document.dataNav.action="cx_sq_save.jsp";
			document.dataNav.target="_blank";
			document.dataNav.submit();
			document.dataNav.action="cx_sq_list.jsp";
			document.dataNav.target="_self";
		}
	}
}
</script>
</head>

<body onload="public_onload(0);">
<form action="cx_sq_list.jsp" name="dataNav" onSubmit="return goPage()" >	
<input name="savetype" id="savetype" type="hidden">
<input name="sql_bh_ids" id="sql_bh_ids" type="hidden">
	
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
<tr class="tree_title_txt">
	<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		租金撤销-申请列表
	</td>
</tr>
</table>
<!--标题结束-->

<%
String dqczy=(String) session.getAttribute("czyid");

String sqlstr="";
ResultSet rs=null;
String wherestr=" where isnull(tj_status,0)=0 and isnull(cx_status,0)=0 ";

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
		//filterAgent = " and apply_info.creator='' ";
	}catch(Exception e){//代理商
		filterAgent = " and apply_info.creator in (select jb_yhxx.id from jb_yhxx where jb_yhxx.bmbh = '"+loginBmbh+"' )";	
	}
	if( "".equals(loginBmbh) ){//租赁物公司部门编号为数字或""
		//filterAgent = " and creator='' ";	
		filterAgent = "";
	}
}else {//错误操作
	System.out.println("++++权限丢失++++"); %>
	<script language="javascript">
	window.parent.parent.location.replace("http://test.strongflc.com/names.nsf?logout");
	</script> 
<%	}

sqlstr = "select frc.* from fund_rent_cx frc  "+wherestr+filterAgent+" order by frc.id "; 
%>

<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
	<td align="left" width="1%">
		<!--操作按钮开始-->
		<table border="0" cellspacing="0" cellpadding="0">
		<tr class="maintab">
			<td nowrap>
				<BUTTON class="btn_2" name="btnAdd" value="新增"  type="button" onclick="dataHander('add','cx_sq_add.jsp',dataNav.itemselect);">
				<img src="../../images/sbtn_new.gif" align="absmiddle" border="0">&nbsp;新增</button>
			</td>
			<td>
			   <BUTTON class="btn_2" name="btndel" value="删除"  type="button" onclick="validate_del();">
			   <img src="../../images/sbtn_del.gif" align="absmiddle" border="0"> &nbsp;删除</button>
			</td>
			<td>
			   <BUTTON class="btn_2" name="btnsub" value="提交"  type="button" onclick="validate_sub();">
			   <img src="../../images/save.gif" align="absmiddle" border="0"> &nbsp;提交</button>
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
<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" 
 cellspacing="1" width="100%" class="maintab_content_table">
	<tr class="maintab_content_table_title">
	    <th width="1%"></th> 	 							
        <th>序号</th>
        <th>申请人</th>
        <th>扣划失败银行</th>
        <th>申请日期</th>
        <th>备注</th>
	</tr>
<tbody id="data">
<%	  
int startIndex = 1;
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
	<tr>
		<td><input type="checkbox" name="list" value="<%=getDBStr(rs.getString("id"))%>"></td>	
        <td align="center"><%=startIndex++ %></td>
        <td align="center"><%=getDBStr(rs.getString("applier")) %></td>
        <td align="center"><%=getDBStr(rs.getString("hire_bank")) %></td>
        <td align="center"><%=getDBDateStr(rs.getString("apply_date")) %></td>
        <td align="center"><%=getDBStr(rs.getString("remark")) %></td>
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

