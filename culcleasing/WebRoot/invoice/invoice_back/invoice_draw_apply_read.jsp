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
<title>票据管理 - 票据已退回列表</title>
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
	var fpId = $(":radio[name='list']:checked").val();
	if(fpId==undefined){
		alert("请选择您要删除的发票退回申请单!");
		return false;
	}else{
		if (confirm("您是否确认删除发票退回申请单(申请单号:'"+fpId+"')?")) {
			window.open("apply_save_del.jsp?savetype=del&sql_ids="+fpId);
		}
	}
}

//修改时
function validate_mod() {
	//是否有选中的付款单号
	var fpId = $(":radio[name='list']:checked").val();
	if(fpId==undefined){
		alert("请选择申请单号进行操作！");
		return false;
	}else{
		window.open("apply_mod.jsp?fpId="+fpId);
	}
	
}
	
//提交时
function validate_sub() {
	//是否有选中的付款单号
	var fpId = $(":radio[name='list']:checked").val();
	var fpAmount = $(":radio[name='list']:checked").attr("fpAmount");
	
	if(fpId==undefined){
		alert("请选择您要提交的发票退回申请单!");
		return false;
	}else{
		if(fpAmount==0){
			alert("您要提交的发票退回申请单发票项目数量为0，请修改后提交！");
			return false;
		}
		if (confirm("您是否确认提交发票退回申请单(申请单号:'"+fpId+"')?")) {
			window.open("apply_save_del.jsp?savetype=sub&sql_ids="+fpId);
		}
	}
}
</script>		
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">
<form action="invoice_draw_apply.jsp" name="dataNav" onSubmit="return goPage()">

<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
			票据管理 - 发票退回列表
		</td>
	</tr>
</table><!--标题结束-->

<%
if ( dqczy.equals("ADMN-WUSESSION") )
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}

wherestr=" and status in('已退回') and type='发票退回' and isnull(is_sub,'')='已提交' and creator='"+dqczy+"' ";

countSql = "select count(id) as amount from invoice_draw_info_t where 1=1 "+wherestr;

//LogWriter.logDebug("Sql-----apply_list.jsp--"+sqlstr);
%>

<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
	<td align="left" width="1%">
		<!--操作按钮开始
		
		<table border="0" cellspacing="0" cellpadding="0">
		<tr class="maintab">
			<td nowrap>
				<BUTTON class="btn_2" name="btnAdd" value="新增"  type="button" onclick="dataHander('add','apply_add_save.jsp',dataNav.itemselect);">
				<img src="../../images/sbtn_new.gif" align="absmiddle" border="0">&nbsp;申请</button>
			</td>
			
			<td>
				<BUTTON class="btn_2" name="btnmod" value="修改"  type="button" onclick="validate_mod();">
				<img src="../../images/sbtn_mod.gif" align="absmiddle" border="0">&nbsp;修改</button>
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
		</table>-->
		<!--操作按钮结束-->
	</td>
	<td align="right" width="90%">
	<!--翻页控制开始-->
	<%@ include file="../../public/pageSplit.jsp"%>
	</td><!--翻页控制结束-->	
	</tr>
</table>

<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
	<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"
		class="maintab_content_table">
		<tr class="maintab_content_table_title">
			 <th width="1%"></th> 			 						
			 <th>申请单号</th>
			 <th>退回发票数量</th>
			 <th>资金发票</th>
			 <th>罚息发票</th>
			 <th>租金利息发票</th>
			 
			 <th>申请人</th>
			 <th>提交日期</th>
			 <th>确认状态</th>
		</tr>
<tbody id="data">
<%	  

String col_str=" ci.*,apply_p=dbo.getUserName(ci.creator) ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from invoice_draw_info_t ci where ci.id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from invoice_draw_info_t where 1=1 "+wherestr+" order by create_date desc ) "+wherestr ;
sqlstr += " order by create_date desc ";

LogWriter.logDebug(request, "####公共资料界面#####"+sqlstr);
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
		<tr>
			<td><input type="radio" name="list" style="border: none;" value="<%=getDBStr(rs.getString("glide_id"))%>" 
			fpAmount="<%=getDBStr(rs.getString("amount_t"))%>"></td>	
			<td align="center">
			<a href="apply.jsp?fpId=<%=getDBStr(rs.getString("glide_id"))%>" target="_blank">
			<%=getDBStr(rs.getString("glide_id"))%></a>
			</td>
			<td align="center"><%=CurrencyUtil.convertIntAmount(rs.getDouble("amount_t")) %></td>
			<td align="center"><%=CurrencyUtil.convertIntAmount(rs.getDouble("amount_zj")) %></td>
			<td align="center"><%=CurrencyUtil.convertIntAmount(rs.getDouble("amount_fx")) %></td>
			<td align="center"><%=CurrencyUtil.convertIntAmount(rs.getDouble("amount_lx")) %></td>
			<td align="center"><%=getDBStr(rs.getString("apply_p")) %></td>
			
			<td align="center"><%=getDBDateStr(rs.getString("plan_date")) %></td>
			<td align="center"><%=getDBStr(rs.getString("status")) %></td>
		</tr>
<%
}
rs.close(); 
db.close();
%>
	</tbody></table>
</div><!--报表结束-->

</form>
</body>
</html>

