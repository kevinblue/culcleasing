<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="com.tenwa.log.LogWriter"%>
<%@ include file="../../func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>网银资金收款列表</title>
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
	if (flag_bh==0) {
		alert("请选择您要删除的收款单号!");
		return false;
	}else {
		if (confirm("您是否确认删除收款单(收款单号:'"+str_bh+"')?")) {
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
		alert("请选择您要提交的收款单号!");
		return false;
	}else {
		if (confirm("您是否确认提交收款单(收款单号:'"+str_bh+"')?")) {
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
<input name="savetype" id="savetype" type="hidden" value="add">
<input name="sql_bh_ids" id="sql_bh_ids" type="hidden">
	
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
			网银资金收款列表
		</td>
	</tr>
</table><!--标题结束-->

<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}

String sqlstr="";
ResultSet rs=null;
String wherestr=" where apply_info.status in('未核销','已驳回') and type='网银资金收款' and isnull(is_sub,'')<>'已提交' and creator='"+dqczy+"' ";

sqlstr = "select apply_info.* from apply_info  "+wherestr+" order by create_date desc"; 
//LogWriter.logDebug("Sql-----apply_list.jsp--"+sqlstr);
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
			 <th>收款单号</th>
			 <th>数量</th>
			 <th width='80'>收款金额</th>
			 <th>提交日期</th>
			 <th>确认状态</th>
		</tr>
<tbody id="data">
<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
		<tr>
			<td><input type="radio" name="list" style="border: none;" value="<%=getDBStr(rs.getString("glide_id"))%>"></td>	
			<td align="center">
			<a href="apply.jsp?czid=<%=getDBStr(rs.getString("glide_id"))%>" target="_blank">
			<%=getDBStr(rs.getString("glide_id"))%></a>
			</td>
			<td align="center"><%=CurrencyUtil.convertIntAmount(rs.getDouble("amount")) %></td>
			<td align="center"><%=CurrencyUtil.convertFinance(rs.getDouble("amt")) %></td>
			<td align="center"><%=getDBDateStr(rs.getString("plan_date")) %></td>
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

