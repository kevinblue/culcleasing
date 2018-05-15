<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../public/headImport.jsp"%>

<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!-- 05.002 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>项目台帐-租金统计-网银扣款</title>
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
	<style type="text/css">
	tr.maintab_content_table_title2 {
		/*background-image:url(../images/pageleft_topbg_1.gif);*/
		background-color:#ffffff;
		height:25px!important;
		color:#15428B;
		text-align:center;
		border-top:1px solid #FF0000;
		position:relative;
	}
	tr.maintab_content_table_title2 th {
		background-color:#D8E6F6;
		font-weight:normal;white-space: nowrap;border:0px solid #FF0000;
	}
	.tbodyStyle {
		color:#10418C;
		font-weight:500;
		background-color: #CCFFFF;
	}
	tfoot tr td {
		color:#E74100;
		font-weight:550;
	}
	</style>
	
	<script src="../../js/comm.js"></script>
	<script src="../../js/delitem.js"></script>

	<script Language="Javascript" src="../../js/jquery.js"></script>
	<script type="text/javascript" src="../../js/stleasing_function.js"></script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">
<form action="netpay_rs_report.jsp" name="dataNav">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		  租金统计&gt; 网银扣款
		</td>
	</tr>
</table><!--标题结束-->
<%

int year = getInt(request.getParameter("cho_year"), getCurrentDatePart(1));
int month = getInt(request.getParameter("cho_month"), getCurrentDatePart(2));

%>
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="1" cellpadding="0">
<tr>
<td>选择年份：&nbsp;
<select name="cho_year" onblur="selectToNow()">
<option value="0"></option>
<script type="text/javascript">
for(var i=<%=getCurrentDatePart(1) %>;i><%=getCurrentDatePart(1)-5 %>;i--){
	document.write("<option value='"+i+"'>"+i+"</option>");
}
</script>
</select>
</td>
<td>选择月份：&nbsp;
<select name="cho_month" onblur="selectToNow()">
<option value="0"></option>
<script type="text/javascript">
for(var i=1;i<=12;i++){
	document.write("<option value='"+i+"'>"+i+"</option>");
}
</script>
</select>
</td>

<td colspan="2">
<input type="button" onclick="dataNav.submit()" value="查询">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" onclick="clearQuery()" value="清空"></td>
</tr>
</table>
</fieldset>
<script type="text/javascript">
$("select[name='cho_year']").val(<%=year %>);
$("select[name='cho_month']").val(<%=month %>);
</script>
</div><!-- 查询条件结束 -->

<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
		<td align="left" width="1%">
		<!--操作按钮开始-->
		<table border="0" cellspacing="0" cellpadding="0" >    
			<tr class="maintab">
<!-- 
				<td>
				<BUTTON class="btn_2"  type="button" onclick="javascript: alert('不好意思，开发中，无法操作！');">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>
				</td>
				
				<td>
				<BUTTON class="btn_2"  type="button" onclick="return validata_data_exp();">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出PDF</button>
				</td>
				-->
				 <td>
				<img src="../../images/sbtn_split.gif" width="2" height="14">
				</td>
				
			</tr>
		</table><!--操作按钮结束-->
		</td>
		<td align="right" width="90%">
		</td>
	</tr>
</table>
 
<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" style="border-collapse:collapse;" align="center"
	cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
<tr class="maintab_content_table_title">
        <th colspan="2">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </th>
        
		<th colspan="2" style="font-weight: bold;">5日扣款</th>
		<th colspan="4" style="font-weight: bold;">5日</th>
		<th colspan="4" style="font-weight: bold;">10日</th>
		<th colspan="4" style="font-weight: bold;">15日</th>
		<!-- 
		<th colspan="6" style="font-weight: bold;">月底统计</th>
		 -->
	</tr>
	<tr class="maintab_content_table_title">
		<th colspan="2">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </th>
	    <th align="center">笔数</th>
	    <th align="center">金额</th>
	    <th align="center">成功笔数</th>
	    <th align="center">成功金额</th>
	    <th align="center">未成功笔数</th>
	    <th align="center">未成功金额</th>
	    <th align="center">成功笔数</th>
	    <th align="center">成功金额</th>
	    <th align="center">未成功笔数</th>
	    <th align="center">未成功金额</th>
	    <th align="center">成功笔数</th>
	    <th align="center">成功金额</th>
	    <th align="center">未成功笔数</th>
	    <th align="center">未成功金额</th>
	    <!-- 
	    <th align="center">成功笔数</th>
	    <th align="center">成功金额</th>
	    <th align="center">未成功笔数</th>
	    <th align="center">未成功金额</th>
	    <th align="center">未成功笔数%</th>
	    <th align="center">未成功金额%</th>
	     -->
	</tr>
<tbody>
<%
//=======定义变量区======
String partSql = "";
//-扣款笔数-
int rent_CCB_kkbs = 0;//建行租金扣款比数（以项目的开户银行决定）
int rent_ABC_kkbs = 0;//农行租金扣款比数

int penalty_CCB_kkbs = 0;//建行罚息扣款比数（以项目的开户银行决定）
int penalty_ABC_kkbs = 0;//农行罚息扣款比数
//-扣款金额-
double rent_CCB_kkje = 0f;//租金扣款金额
double rent_ABC_kkje = 0f;//租金扣款金额

double penalty_CCB_kkje = 0f;//罚息扣款金额
double penalty_ABC_kkje = 0f;//罚息扣款金额

//-建行每阶段扣款情况-
int rent_CCB_5cgbs = 0;//5日租金成功比数
double rent_CCB_5cgje = 0f;//5日租金成功金额
int rent_CCB_5sbbs = 0;//5日租金失败比数
double rent_CCB_5sbje = 0f;//5日租金失败金额

int penalty_CCB_5cgbs = 0;//5日违约金成功比数
double penalty_CCB_5cgje = 0f;//5日违约金成功金额
int penalty_CCB_5sbbs = 0;//5日违约金失败比数
double penalty_CCB_5sbje = 0f;//5日违约金失败金额
//-10日-
int rent_CCB_10cgbs = 0;//10日租金成功比数
double rent_CCB_10cgje = 0f;//10日租金成功金额
int rent_CCB_10sbbs = 0;//10日租金失败比数
double rent_CCB_10sbje = 0f;//10日租金失败金额

int penalty_CCB_10cgbs = 0;//10日违约金成功比数
double penalty_CCB_10cgje = 0f;//10日违约金成功金额
int penalty_CCB_10sbbs = 0;//10日违约金失败比数
double penalty_CCB_10sbje = 0f;//10日违约金失败金额
//-15日-
int rent_CCB_15cgbs = 0;//15日租金成功比数
double rent_CCB_15cgje = 0f;//15日租金成功金额
int rent_CCB_15sbbs = 0;//15日租金失败比数
double rent_CCB_15sbje = 0f;//15日租金失败金额

int penalty_CCB_15cgbs = 0;//15日违约金成功比数
double penalty_CCB_15cgje = 0f;//15日违约金成功金额
int penalty_CCB_15sbbs = 0;//15日违约金失败比数
double penalty_CCB_15sbje = 0f;//15日违约金失败金额
//-20日-
int rent_CCB_20cgbs = 0;//20日租金成功比数
double rent_CCB_20cgje = 0f;//20日租金成功金额
int rent_CCB_20sbbs = 0;//20日租金失败比数
double rent_CCB_20sbje = 0f;//20日租金失败金额

int penalty_CCB_20cgbs = 0;//20日违约金成功比数
double penalty_CCB_20cgje = 0f;//20日违约金成功金额
int penalty_CCB_20sbbs = 0;//20日违约金失败比数
double penalty_CCB_20sbje = 0f;//20日违约金失败金额
//-25日-
int rent_CCB_25cgbs = 0;//25日租金成功比数
double rent_CCB_25cgje = 0f;//25日租金成功金额
int rent_CCB_25sbbs = 0;//25日租金失败比数
double rent_CCB_25sbje = 0f;//25日租金失败金额

int penalty_CCB_25cgbs = 0;//25日违约金成功比数
double penalty_CCB_25cgje = 0f;//25日违约金成功金额
int penalty_CCB_25sbbs = 0;//25日违约金失败比数
double penalty_CCB_25sbje = 0f;//25日违约金失败金额
//-30日-
int rent_CCB_30cgbs = 0;//30日租金成功比数
double rent_CCB_30cgje = 0f;//30日租金成功金额
int rent_CCB_30sbbs = 0;//30日租金失败比数
double rent_CCB_30sbje = 0f;//30日租金失败金额

int penalty_CCB_30cgbs = 0;//30日违约金成功比数
double penalty_CCB_30cgje = 0f;//30日违约金成功金额
int penalty_CCB_30sbbs = 0;//30日违约金失败比数
double penalty_CCB_30sbje = 0f;//30日违约金失败金额


//-农行每阶段扣款情况-
int rent_ABC_5cgbs = 0;//5日租金成功比数
double rent_ABC_5cgje = 0f;//5日租金成功金额
int rent_ABC_5sbbs = 0;//5日租金失败比数
double rent_ABC_5sbje = 0f;//5日租金失败金额

int penalty_ABC_5cgbs = 0;//5日违约金成功比数
double penalty_ABC_5cgje = 0f;//5日违约金成功金额
int penalty_ABC_5sbbs = 0;//5日违约金失败比数
double penalty_ABC_5sbje = 0f;//5日违约金失败金额
//-10日-
int rent_ABC_10cgbs = 0;//10日租金成功比数
double rent_ABC_10cgje = 0f;//10日租金成功金额
int rent_ABC_10sbbs = 0;//10日租金失败比数
double rent_ABC_10sbje = 0f;//10日租金失败金额

int penalty_ABC_10cgbs = 0;//10日违约金成功比数
double penalty_ABC_10cgje = 0f;//10日违约金成功金额
int penalty_ABC_10sbbs = 0;//10日违约金失败比数
double penalty_ABC_10sbje = 0f;//10日违约金失败金额
//-15日-
int rent_ABC_15cgbs = 0;//15日租金成功比数
double rent_ABC_15cgje = 0f;//15日租金成功金额
int rent_ABC_15sbbs = 0;//15日租金失败比数
double rent_ABC_15sbje = 0f;//15日租金失败金额

int penalty_ABC_15cgbs = 0;//15日违约金成功比数
double penalty_ABC_15cgje = 0f;//15日违约金成功金额
int penalty_ABC_15sbbs = 0;//15日违约金失败比数
double penalty_ABC_15sbje = 0f;//15日违约金失败金额
//-20日-
int rent_ABC_20cgbs = 0;//20日租金成功比数
double rent_ABC_20cgje = 0f;//20日租金成功金额
int rent_ABC_20sbbs = 0;//20日租金失败比数
double rent_ABC_20sbje = 0f;//20日租金失败金额

int penalty_ABC_20cgbs = 0;//20日违约金成功比数
double penalty_ABC_20cgje = 0f;//20日违约金成功金额
int penalty_ABC_20sbbs = 0;//20日违约金失败比数
double penalty_ABC_20sbje = 0f;//20日违约金失败金额
//-25日-
int rent_ABC_25cgbs = 0;//25日租金成功比数
double rent_ABC_25cgje = 0f;//25日租金成功金额
int rent_ABC_25sbbs = 0;//25日租金失败比数
double rent_ABC_25sbje = 0f;//25日租金失败金额

int penalty_ABC_25cgbs = 0;//25日违约金成功比数
double penalty_ABC_25cgje = 0f;//25日违约金成功金额
int penalty_ABC_25sbbs = 0;//25日违约金失败比数
double penalty_ABC_25sbje = 0f;//25日违约金失败金额
//-30日-
int rent_ABC_30cgbs = 0;//30日租金成功比数
double rent_ABC_30cgje = 0f;//30日租金成功金额
int rent_ABC_30sbbs = 0;//30日租金失败比数
double rent_ABC_30sbje = 0f;//30日租金失败金额

int penalty_ABC_30cgbs = 0;//30日违约金成功比数
double penalty_ABC_30cgje = 0f;//30日违约金成功金额
int penalty_ABC_30sbbs = 0;//30日违约金失败比数
double penalty_ABC_30sbje = 0f;//30日违约金失败金额


//-小计-
int rent_kkbs_xj = 0;//扣款比数小计（分扣款银行）
double rent_kkje_xj = 0f;//扣款金额小计
//-5日-
int rent_5cgbs_xj = 0;//5日成功小计
double rent_5cgje_xj = 0;//5日成功小计
int rent_5sbbs_xj = 0;//5日未成功小计
double rent_5sbje_xj = 0;//5日未成功小计
//-10日-
int rent_10cgbs_xj = 0;//10日成功小计
double rent_10cgje_xj = 0;//10日成功小计
int rent_10sbbs_xj = 0;//10日未成功小计
double rent_10sbje_xj = 0;//10日未成功小计
//-15日-
int rent_15cgbs_xj = 0;//15日成功小计
double rent_15cgje_xj = 0;//15日成功小计
int rent_15sbbs_xj = 0;//15日未成功小计
double rent_15sbje_xj = 0;//15日未成功小计
//-20日-
int rent_20cgbs_xj = 0;//20日成功小计
double rent_20cgje_xj = 0;//20日成功小计
int rent_20sbbs_xj = 0;//20日未成功小计
double rent_20sbje_xj = 0;//20日未成功小计
//-25日-
int rent_25cgbs_xj = 0;//25日成功小计
double rent_25cgje_xj = 0;//25日成功小计
int rent_25sbbs_xj = 0;//25日未成功小计
double rent_25sbje_xj = 0;//25日未成功小计
//-30日-
int rent_30cgbs_xj = 0;//30日成功小计
double rent_30cgje_xj = 0;//30日成功小计
int rent_30sbbs_xj = 0;//30日未成功小计
double rent_30sbje_xj = 0;//30日未成功小计

//-合计-
int rent_kkbs_hj = 0;//扣款比数合计
double rent_kkje_hj = 0f;//扣款金额合计
//-失败、成功合计-
int rent_cgbs1_hj = 0;//成功合计1
double rent_cgje1_hj = 0;//成功金额合计1
int rent_sbbs1_hj = 0;//未成功合计1
double rent_sbje1_hj = 0;//未成功金额合计1

int rent_cgbs2_hj = 0;//成功合计2
double rent_cgje2_hj = 0;//成功金额合计2
int rent_sbbs2_hj = 0;//未成功合计2
double rent_sbje2_hj = 0;//未成功金额合计2

int rent_cgbs3_hj = 0;//成功合计3
double rent_cgje3_hj = 0;//成功金额合计3
int rent_sbbs3_hj = 0;//未成功合计3
double rent_sbje3_hj = 0;//未成功金额合计3

//=======定义变量区======
%>
	<tr>
		<td rowspan="3">建行</td>
		<td align="center" nowrap="nowrap">租金</td>
		<%
			//建行5日扣款应扣租金比数 = 建行5日扣款租金比数+建行5日扣款逾期租金比数
			partSql = "select dbo.t103_netpay_rent_kkbs("+year+","+month+",'CCB',5) as amount";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_kkbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_CCB_kkbs+"") %></td>
        <%
     		//建行5日扣款租金金额
			partSql = "select dbo.t103_netpay_rent_kkje("+year+","+month+",'CCB',5) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_kkje = rs.getDouble("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_CCB_kkje) %></td>
        <!-- &&&&&&&&&&&&5日扣款&&&&&&&&&&&&& -->
        <%
     		//租金成功
			partSql = "select dbo.t103_netpay_rent_cgbs("+year+","+month+",'CCB',5) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_5cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_CCB_5cgbs+"") %></td>
        <%
     		//租金成功金额
			partSql = "select dbo.t103_netpay_rent_cgje("+year+","+month+",'CCB',5) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_5cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_CCB_5cgje) %></td>
         <%
     		//租金未成功
			partSql = "select dbo.t103_netpay_rent_sbbs("+year+","+month+",'CCB',5) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_5sbbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_CCB_5sbbs+"") %></td>
        <%
     		//租金未成功金额
			partSql = "select dbo.t103_netpay_rent_sbje("+year+","+month+",'CCB',5) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_5sbje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_CCB_5sbje) %></td>
        
        <!-- &&&&&******&&&&10日扣款&&&******&&&& -->
        <%
     		//租金成功
			partSql = "select dbo.t103_netpay_rent_cgbs("+year+","+month+",'CCB',10) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_10cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_CCB_10cgbs+"") %></td>
        <%
     		//租金成功金额
			partSql = "select dbo.t103_netpay_rent_cgje("+year+","+month+",'CCB',10) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_10cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_CCB_10cgje) %></td>
         <%
     		//租金未成功
			partSql = "select dbo.t103_netpay_rent_sbbs("+year+","+month+",'CCB',10) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_10sbbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_CCB_5sbbs+"") %></td>
        <%
     		//租金未成功金额
			partSql = "select dbo.t103_netpay_rent_sbje("+year+","+month+",'CCB',10) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_10sbje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_CCB_10sbje) %></td>
        
        <!-- &&&&%%%%%%%&&15日扣款&&&%%%%%%%%%&&& -->
        <%
     		//租金成功
			partSql = "select dbo.t103_netpay_rent_cgbs("+year+","+month+",'CCB',15) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_15cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_CCB_15cgbs+"") %></td>
        <%
     		//租金成功金额
			partSql = "select dbo.t103_netpay_rent_cgje("+year+","+month+",'CCB',15) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_15cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_CCB_15cgje) %></td>
         <%
     		//租金未成功
			partSql = "select dbo.t103_netpay_rent_sbbs("+year+","+month+",'CCB',15) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_15sbbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_CCB_15sbbs+"") %></td>
        <%
     		//租金未成功金额
			partSql = "select dbo.t103_netpay_rent_sbje("+year+","+month+",'CCB',15) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_15sbje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_CCB_15sbje) %></td>
	</tr>
	<tr>
		<td align="right" nowrap="nowrap">罚息</td>
		<%
			//建行5日罚息扣款比数
			partSql = "select dbo.t103_netpay_penalty_kkbs("+year+","+month+",'CCB',5) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_kkbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_CCB_kkbs+"") %></td>
        <%
     		//建行5日扣款罚息金额
			partSql = "select dbo.t103_netpay_penalty_kkje("+year+","+month+",'CCB',5) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_kkje = rs.getDouble("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_CCB_kkje) %></td>
        <!-- $$$$$$$$$$-5日扣款-$$$$$$$ -->
        <%
     		//违约金成功
			partSql = "select dbo.t103_netpay_penalty_cgbs("+year+","+month+",'CCB',5) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_5cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_CCB_5cgbs+"") %></td>
        <%
     		//违约金成功金额
			partSql = "select dbo.t103_netpay_penalty_cgje("+year+","+month+",'CCB',5) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_5cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_CCB_5cgje) %></td>
         <%
     		//违约金未成功
			partSql = "select dbo.t103_netpay_penalty_sbbs("+year+","+month+",'CCB',5) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_5sbbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_CCB_5sbbs+"") %></td>
        <%
     		//违约金未成功金额
			partSql = "select dbo.t103_netpay_penalty_sbje("+year+","+month+",'CCB',5) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_5sbje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_CCB_5sbje) %></td>
        
        <!-- $$########$$-10日扣款-$#########$ -->
        <%
     		//违约金成功
			partSql = "select dbo.t103_netpay_penalty_cgbs("+year+","+month+",'CCB',10) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_10cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_CCB_10cgbs+"") %></td>
        <%
     		//违约金成功金额
			partSql = "select dbo.t103_netpay_penalty_cgje("+year+","+month+",'CCB',10) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_10cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_CCB_10cgje) %></td>
         <%
     		//违约金未成功
			partSql = "select dbo.t103_netpay_penalty_sbbs("+year+","+month+",'CCB',10) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_10sbbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_CCB_10sbbs+"") %></td>
        <%
     		//违约金未成功金额
			partSql = "select dbo.t103_netpay_penalty_sbje("+year+","+month+",'CCB',10) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_10sbje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_CCB_10sbje) %></td>
        
        <!-- $$########$$-15日扣款-$#########$ -->
        <%
     		//违约金成功
			partSql = "select dbo.t103_netpay_penalty_cgbs("+year+","+month+",'CCB',15) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_15cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_CCB_15cgbs+"") %></td>
        <%
     		//违约金成功金额
			partSql = "select dbo.t103_netpay_penalty_cgje("+year+","+month+",'CCB',15) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_15cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_CCB_15cgje) %></td>
         <%
     		//违约金未成功
			partSql = "select dbo.t103_netpay_penalty_sbbs("+year+","+month+",'CCB',15) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_15sbbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_CCB_15sbbs+"") %></td>
        <%
     		//违约金未成功金额
			partSql = "select dbo.t103_netpay_penalty_sbje("+year+","+month+",'CCB',15) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_15sbje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_CCB_15sbje) %></td>
	</tr>
	<tr class="tbodyStyle">
		<td align="right">小计</td>
		<%
			//建行租金扣款小计
			rent_kkbs_xj = rent_CCB_kkbs+penalty_CCB_kkbs;
			rent_kkbs_hj = rent_kkbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_kkbs_xj+"") %></td>
		<%
			//建行扣款金额小计
			rent_kkje_xj = rent_CCB_kkje+penalty_CCB_kkje;
			rent_kkje_hj = rent_kkje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_kkje_xj) %></td>
		<!-- %%%%%%%5日扣款合计%%%%%%%% -->
		<%
			//成功比数小计
			rent_5cgbs_xj = rent_CCB_5cgbs + penalty_CCB_5cgbs;
			rent_cgbs1_hj = rent_5cgbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_5cgbs_xj+"") %></td>
		<%
			//成功金额小计
			rent_5cgje_xj = rent_CCB_5cgje + penalty_CCB_5cgje;
			rent_cgje1_hj = rent_5cgje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_5cgje_xj) %></td>
		<%
			//未成功比数小计
			rent_5sbbs_xj = rent_CCB_5sbbs + penalty_CCB_5sbbs;
			rent_sbbs1_hj = rent_5sbbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_5sbbs_xj+"") %></td>
		<%
			//成功金额小计
			rent_5sbje_xj = rent_CCB_5sbje + penalty_CCB_5sbje;
			rent_sbje1_hj = rent_5sbje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_5sbje_xj) %></td>
		
		<!-- %%%%%%%10日扣款合计%%%%%%%% -->
		<%
			//成功比数小计
			rent_10cgbs_xj = rent_CCB_10cgbs + penalty_CCB_10cgbs;
			rent_cgbs2_hj = rent_10cgbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_10cgbs_xj+"") %></td>
		<%
			//成功金额小计
			rent_10cgje_xj = rent_CCB_10cgje + penalty_CCB_10cgje;
			rent_cgje2_hj = rent_10cgje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_10cgje_xj) %></td>
		<%
			//未成功比数小计
			rent_10sbbs_xj = rent_CCB_10sbbs + penalty_CCB_10sbbs;
			rent_sbbs2_hj = rent_10sbbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_10sbbs_xj+"") %></td>
		<%
			//成功金额小计
			rent_10sbje_xj = rent_CCB_10sbje + penalty_CCB_10sbje;
			rent_sbje2_hj = rent_10sbje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_10sbje_xj) %></td>
		
		<!-- %%%%%%%15日扣款合计%%%%%%%% -->
		<%
			//成功比数小计
			rent_15cgbs_xj = rent_CCB_15cgbs + penalty_CCB_15cgbs;
			rent_cgbs3_hj = rent_15cgbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_15cgbs_xj+"") %></td>
		<%
			//成功金额小计
			rent_15cgje_xj = rent_CCB_15cgje + penalty_CCB_15cgje;
			rent_cgje3_hj = rent_15cgje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_15cgje_xj) %></td>
		<%
			//未成功比数小计
			rent_15sbbs_xj = rent_CCB_15sbbs + penalty_CCB_15sbbs;
			rent_sbbs3_hj = rent_15sbbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_15sbbs_xj+"") %></td>
		<%
			//成功金额小计
			rent_15sbje_xj = rent_CCB_15sbje + penalty_CCB_15sbje;
			rent_sbje3_hj = rent_15sbje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_15sbje_xj) %></td>
	</tr>
	<tr>
		<td rowspan="3">农行</td>
		<td align="right" nowrap="nowrap">租金</td>
		<%
			//农行扣款租金比数
			partSql = "select dbo.t103_netpay_rent_kkbs("+year+","+month+",'ABC',5) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_kkbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_ABC_kkbs+"") %></td>
        <%
     		//农行5日扣款租金金额
			partSql = "select dbo.t103_netpay_rent_kkje("+year+","+month+",'ABC',5) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_kkje = rs.getDouble("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_ABC_kkje) %></td>
        
        <!-- %%%%%%%%5日扣款%%%%%%%%%%% -->
        <%
     		//成功
			partSql = "select dbo.t103_netpay_rent_cgbs("+year+","+month+",'ABC',5) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_5cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_ABC_5cgbs+"") %></td>
        <%
     		//成功金额
			partSql = "select dbo.t103_netpay_rent_cgje("+year+","+month+",'ABC',5) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_5cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_ABC_5cgje) %></td>
         <%
     		//未成功
			partSql = "select dbo.t103_netpay_rent_sbbs("+year+","+month+",'ABC',5) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_5sbbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_ABC_5sbbs+"") %></td>
        <%
     		//未成功金额
			partSql = "select dbo.t103_netpay_rent_sbje("+year+","+month+",'ABC',5) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_5sbje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_ABC_5sbje) %></td>
        
        <!-- %#########10日扣款#########% -->
        <%
     		//成功
			partSql = "select dbo.t103_netpay_rent_cgbs("+year+","+month+",'ABC',10) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_10cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_ABC_10cgbs+"") %></td>
        <%
     		//成功金额
			partSql = "select dbo.t103_netpay_rent_cgje("+year+","+month+",'ABC',10) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_10cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_ABC_10cgje) %></td>
         <%
     		//未成功
			partSql = "select dbo.t103_netpay_rent_sbbs("+year+","+month+",'ABC',10) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_10sbbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_ABC_10sbbs+"") %></td>
        <%
     		//未成功金额
			partSql = "select dbo.t103_netpay_rent_sbje("+year+","+month+",'ABC',10) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_10sbje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_ABC_10sbje) %></td>
        
        <!-- %#########15日扣款#########% -->
        <%
     		//成功
			partSql = "select dbo.t103_netpay_rent_cgbs("+year+","+month+",'ABC',15) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_15cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_ABC_15cgbs+"") %></td>
        <%
     		//成功金额
			partSql = "select dbo.t103_netpay_rent_cgje("+year+","+month+",'ABC',15) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_15cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_ABC_15cgje) %></td>
         <%
     		//未成功
			partSql = "select dbo.t103_netpay_rent_sbbs("+year+","+month+",'ABC',15) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_15sbbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_ABC_15sbbs+"") %></td>
        <%
     		//未成功金额
			partSql = "select dbo.t103_netpay_rent_sbje("+year+","+month+",'ABC',15) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_15sbje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_ABC_15sbje) %></td>
	</tr>
	<tr>
		<td align="right" nowrap="nowrap">罚息</td>
		<%
			//农行5日罚息扣款比数
			partSql = "select dbo.t103_netpay_penalty_kkbs("+year+","+month+",'ABC',5) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_kkbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_ABC_kkbs+"") %></td>
        <%
     		//农行5日扣款罚息金额
			partSql = "select dbo.t103_netpay_penalty_kkje("+year+","+month+",'ABC',5) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_kkje = rs.getDouble("amount");
			} 
			rs.close();
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(penalty_ABC_kkje) %></td>
		
		<!-- $###############5日扣款##################$ -->
		<%
     		//违约金成功
			partSql = "select dbo.t103_netpay_penalty_cgbs("+year+","+month+",'ABC',5) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_5cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_ABC_5cgbs+"") %></td>
        <%
     		//违约金成功金额
			partSql = "select dbo.t103_netpay_penalty_cgje("+year+","+month+",'ABC',5) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_5cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_ABC_5cgje) %></td>
         <%
     		//违约金未成功
			partSql = "select dbo.t103_netpay_penalty_sbbs("+year+","+month+",'ABC',5) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_5sbbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_ABC_5sbbs+"") %></td>
        <%
     		//违约金未成功金额
			partSql = "select dbo.t103_netpay_penalty_sbje("+year+","+month+",'ABC',5) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_5sbje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_ABC_5sbje) %></td>
        
        <!-- $#####***####10日扣款########***#####$ -->
		<%
     		//违约金成功
			partSql = "select dbo.t103_netpay_penalty_cgbs("+year+","+month+",'ABC',10) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_10cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_ABC_10cgbs+"") %></td>
        <%
     		//违约金成功金额
			partSql = "select dbo.t103_netpay_penalty_cgje("+year+","+month+",'ABC',10) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_10cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_ABC_10cgje) %></td>
         <%
     		//违约金未成功
			partSql = "select dbo.t103_netpay_penalty_sbbs("+year+","+month+",'ABC',10) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_10sbbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_ABC_10sbbs+"") %></td>
        <%
     		//违约金未成功金额
			partSql = "select dbo.t103_netpay_penalty_sbje("+year+","+month+",'ABC',10) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_10sbje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_ABC_10sbje) %></td>
        
        <!-- $#####***####15日扣款########***#####$ -->
		<%
     		//违约金成功
			partSql = "select dbo.t103_netpay_penalty_cgbs("+year+","+month+",'ABC',15) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_15cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_ABC_15cgbs+"") %></td>
        <%
     		//违约金成功金额
			partSql = "select dbo.t103_netpay_penalty_cgje("+year+","+month+",'ABC',15) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_15cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_ABC_15cgje) %></td>
         <%
     		//违约金未成功
			partSql = "select dbo.t103_netpay_penalty_sbbs("+year+","+month+",'ABC',15) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_15sbbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_ABC_15sbbs+"") %></td>
        <%
     		//违约金未成功金额
			partSql = "select dbo.t103_netpay_penalty_sbje("+year+","+month+",'ABC',15) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_15sbje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_ABC_15sbje) %></td>
	</tr>
	<tr class="tbodyStyle">
		<td align="right">小计</td>
		<%
			//农行租金扣款小计
			rent_kkbs_xj = rent_ABC_kkbs+penalty_ABC_kkbs;
			rent_kkbs_hj += rent_kkbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_kkbs_xj+"") %></td>
		<%
			//农行扣款金额小计
			rent_kkje_xj = rent_ABC_kkje+penalty_ABC_kkje;
			rent_kkje_hj += rent_kkje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_kkje_xj) %></td>
		<!-- &&&&&&&-5日-&&&&&& -->
		<%
			//成功比数小计
			rent_5cgbs_xj = rent_ABC_5cgbs + penalty_ABC_5cgbs;
			rent_cgbs1_hj+= rent_5cgbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_5cgbs_xj+"") %></td>
		<%
			//成功金额小计
			rent_5cgje_xj = rent_ABC_5cgje + penalty_ABC_5cgje;
			rent_cgje1_hj+= rent_5cgje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_5cgje_xj) %></td>
		<%
			//未成功比数小计
			rent_5sbbs_xj = rent_ABC_5sbbs + penalty_ABC_5sbbs;
			rent_sbbs1_hj+= rent_5sbbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_5sbbs_xj+"") %></td>
		<%
			//成功金额小计
			rent_5sbje_xj = rent_ABC_5sbje + penalty_ABC_5sbje;
			rent_sbje1_hj+= rent_5sbje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_5sbje_xj) %></td>
		
		<!-- &&&&&&&-10日-&&&&&& -->
		<%
			//成功比数小计
			rent_10cgbs_xj = rent_ABC_10cgbs + penalty_ABC_10cgbs;
			rent_cgbs2_hj+= rent_10cgbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_10cgbs_xj+"") %></td>
		<%
			//成功金额小计
			rent_10cgje_xj = rent_ABC_10cgje + penalty_ABC_10cgje;
			rent_cgje2_hj+= rent_10cgje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_10cgje_xj) %></td>
		<%
			//未成功比数小计
			rent_10sbbs_xj = rent_ABC_10sbbs + penalty_ABC_10sbbs;
			rent_sbbs2_hj+= rent_10sbbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_10sbbs_xj+"") %></td>
		<%
			//成功金额小计
			rent_10sbje_xj = rent_ABC_10sbje + penalty_ABC_10sbje;
			rent_sbje2_hj+= rent_10sbje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_10sbje_xj) %></td>
		
		<!-- &&&&&&&-15日-&&&&&& -->
		<%
			//成功比数小计
			rent_15cgbs_xj = rent_ABC_15cgbs + penalty_ABC_15cgbs;
			rent_cgbs3_hj+= rent_15cgbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_15cgbs_xj+"") %></td>
		<%
			//成功金额小计
			rent_15cgje_xj = rent_ABC_15cgje + penalty_ABC_15cgje;
			rent_cgje3_hj+= rent_15cgje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_15cgje_xj) %></td>
		<%
			//未成功比数小计
			rent_15sbbs_xj = rent_ABC_15sbbs + penalty_ABC_15sbbs;
			rent_sbbs3_hj+= rent_15sbbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_15sbbs_xj+"") %></td>
		<%
			//成功金额小计
			rent_10sbje_xj = rent_ABC_15sbje + penalty_ABC_15sbje;
			rent_sbje3_hj+= rent_15sbje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_15sbje_xj) %></td>
	</tr>	
	<tr><td colspan="26">
	</td></tr>
</tbody>	
	<tr class="maintab_content_table_title2">
      	<th colspan="2">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </th>
        
		<th colspan="2" style="font-weight: bold;">20日扣款</th>
		<th colspan="4" style="font-weight: bold;">20日</th>
		<th colspan="4" style="font-weight: bold;">25日</th>
		<th colspan="4" style="font-weight: bold;">30日</th>
		<!-- 
		<th colspan="6" style="font-weight: bold;">月底统计</th>
		 -->
	</tr>
	<tr class="maintab_content_table_title2">
		<th colspan="2">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </th>
	    <th align="right">笔数</th>
	    <th align="right">金额</th>
	    <th align="right">成功笔数</th>
	    <th align="right">成功金额</th>
	    <th align="right">未成功笔数</th>
	    <th align="right">未成功金额</th>
	    <th align="right">成功笔数</th>
	    <th align="right">成功金额</th>
	    <th align="right">未成功笔数</th>
	    <th align="right">未成功金额</th>
	    <th align="right">成功笔数</th>
	    <th align="right">成功金额</th>
	    <th align="right">未成功笔数</th>
	    <th align="right">未成功金额</th>
	    <!-- 
	    <th align="right">成功笔数</th>
	    <th align="right">成功金额</th>
	    <th align="right">未成功笔数</th>
	    <th align="right">未成功金额</th>
	    <th align="right">未成功笔数%</th>
	    <th align="right">未成功金额%</th>
	     -->
	</tr>
<tbody>
	<tr>
		<td rowspan="3">建行</td>
		<td align="right" nowrap="nowrap">租金</td>
		<%
			//建行20日扣款应扣租金比数 = 建行20日扣款租金比数+建行20日扣款逾期租金比数
			partSql = "select dbo.t103_netpay_rent_kkbs("+year+","+month+",'CCB',20) as amount";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_kkbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_CCB_kkbs+"") %></td>
        <%
     		//建行20日扣款租金金额
			partSql = "select dbo.t103_netpay_rent_kkje("+year+","+month+",'CCB',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_kkje = rs.getDouble("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_CCB_kkje) %></td>
        <!-- &&&&&&&&&&&&20日扣款&&&&&&&&&&&&& -->
        <%
     		//租金成功
			partSql = "select dbo.t103_netpay_rent_cgbs("+year+","+month+",'CCB',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_20cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_CCB_20cgbs+"") %></td>
        <%
     		//租金成功金额
			partSql = "select dbo.t103_netpay_rent_cgje("+year+","+month+",'CCB',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_20cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_CCB_20cgje) %></td>
         <%
     		//租金未成功
			partSql = "select dbo.t103_netpay_rent_sbbs("+year+","+month+",'CCB',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_20sbbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_CCB_20sbbs+"") %></td>
        <%
     		//租金未成功金额
			partSql = "select dbo.t103_netpay_rent_sbje("+year+","+month+",'CCB',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_20sbje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_CCB_20sbje) %></td>
        
        <!-- &&&####&&&&25日扣款&&&&###&&&&&& -->
        <%
     		//租金成功
			partSql = "select dbo.t103_netpay_rent_cgbs("+year+","+month+",'CCB',25) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_25cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_CCB_25cgbs+"") %></td>
        <%
     		//租金成功金额
			partSql = "select dbo.t103_netpay_rent_cgje("+year+","+month+",'CCB',25) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_25cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_CCB_25cgje) %></td>
         <%
     		//租金未成功
			partSql = "select dbo.t103_netpay_rent_sbbs("+year+","+month+",'CCB',25) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_25sbbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_CCB_25sbbs+"") %></td>
        <%
     		//租金未成功金额
			partSql = "select dbo.t103_netpay_rent_sbje("+year+","+month+",'CCB',25) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_25sbje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_CCB_25sbje) %></td>
        
        <!-- &&&####&&&&30日扣款&&&&###&&&&&& -->
        <%
     		//租金成功
			partSql = "select dbo.t103_netpay_rent_cgbs("+year+","+month+",'CCB',30) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_30cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_CCB_30cgbs+"") %></td>
        <%
     		//租金成功金额
			partSql = "select dbo.t103_netpay_rent_cgje("+year+","+month+",'CCB',30) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_30cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_CCB_30cgje) %></td>
         <%
     		//租金未成功
			partSql = "select dbo.t103_netpay_rent_sbbs("+year+","+month+",'CCB',30) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_30sbbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_CCB_30sbbs+"") %></td>
        <%
     		//租金未成功金额
			partSql = "select dbo.t103_netpay_rent_sbje("+year+","+month+",'CCB',30) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_30sbje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_CCB_30sbje) %></td>
	</tr>
	<tr>
		<td align="right" nowrap="nowrap">罚息</td>
		<%
			//建行5日罚息扣款比数
			partSql = "select dbo.t103_netpay_penalty_kkbs("+year+","+month+",'CCB',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_kkbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_CCB_kkbs+"") %></td>
        <%
     		//农行5日扣款罚息金额
			partSql = "select dbo.t103_netpay_penalty_kkje("+year+","+month+",'CCB',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_kkje = rs.getDouble("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_CCB_kkje) %></td>
        
        <!-- $$$$$$$$$$-20日扣款-$$$$$$$ -->
        <%
     		//违约金成功
			partSql = "select dbo.t103_netpay_penalty_cgbs("+year+","+month+",'CCB',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_20cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_CCB_20cgbs+"") %></td>
        <%
     		//违约金成功金额
			partSql = "select dbo.t103_netpay_penalty_cgje("+year+","+month+",'CCB',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_20cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_CCB_20cgje) %></td>
         <%
     		//违约金未成功
			partSql = "select dbo.t103_netpay_penalty_sbbs("+year+","+month+",'CCB',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_20sbbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_CCB_20sbbs+"") %></td>
        <%
     		//违约金未成功金额
			partSql = "select dbo.t103_netpay_penalty_sbje("+year+","+month+",'CCB',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_20sbje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_CCB_20sbje) %></td>
        
        <!-- $$$@@@@@@$$-25日扣款-$$#######$$ -->
        <%
     		//违约金成功
			partSql = "select dbo.t103_netpay_penalty_cgbs("+year+","+month+",'CCB',25) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_25cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_CCB_25cgbs+"") %></td>
        <%
     		//违约金成功金额
			partSql = "select dbo.t103_netpay_penalty_cgje("+year+","+month+",'CCB',25) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_25cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_CCB_25cgje) %></td>
         <%
     		//违约金未成功
			partSql = "select dbo.t103_netpay_penalty_sbbs("+year+","+month+",'CCB',25) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_25sbbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_CCB_25sbbs+"") %></td>
        <%
     		//违约金未成功金额
			partSql = "select dbo.t103_netpay_penalty_sbje("+year+","+month+",'CCB',25) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_25sbje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_CCB_25sbje) %></td>
        
        <!-- $$$@@@@@@$$-30日扣款-$$#######$$ -->
        <%
     		//违约金成功
			partSql = "select dbo.t103_netpay_penalty_cgbs("+year+","+month+",'CCB',30) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_30cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_CCB_30cgbs+"") %></td>
        <%
     		//违约金成功金额
			partSql = "select dbo.t103_netpay_penalty_cgje("+year+","+month+",'CCB',30) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_30cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_CCB_30cgje) %></td>
         <%
     		//违约金未成功
			partSql = "select dbo.t103_netpay_penalty_sbbs("+year+","+month+",'CCB',30) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_30sbbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_CCB_30sbbs+"") %></td>
        <%
     		//违约金未成功金额
			partSql = "select dbo.t103_netpay_penalty_sbje("+year+","+month+",'CCB',30) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_30sbje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_CCB_30sbje) %></td>
	</tr>
	<tr class="tbodyStyle">
		<td align="right">小计</td>
		<%
			//农行租金扣款小计
			rent_kkbs_xj = rent_CCB_kkbs+penalty_CCB_kkbs;
			rent_kkbs_hj += rent_kkbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_kkbs_xj+"") %></td>
		<%
			//农行扣款金额小计
			rent_kkje_xj = rent_CCB_kkje+penalty_CCB_kkje;
			rent_kkje_hj += rent_kkje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_kkje_xj) %></td>
		
		<!-- &&&&&&&-20日-&&&&&& -->
		<%
			//成功比数小计
			rent_20cgbs_xj = rent_CCB_20cgbs + penalty_CCB_20cgbs;
			rent_cgbs1_hj+= rent_20cgbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_20cgbs_xj+"") %></td>
		<%
			//成功金额小计
			rent_20cgje_xj = rent_CCB_20cgje + penalty_CCB_20cgje;
			rent_cgje1_hj+= rent_20cgje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_20cgje_xj) %></td>
		<%
			//未成功比数小计
			rent_20sbbs_xj = rent_CCB_20sbbs + penalty_CCB_20sbbs;
			rent_sbbs1_hj+= rent_20sbbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_20sbbs_xj+"") %></td>
		<%
			//成功金额小计
			rent_10sbje_xj = rent_CCB_20sbje + penalty_CCB_20sbje;
			rent_sbje1_hj+= rent_20sbje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_20sbje_xj) %></td>
		
		<!-- &&&&&&&-25日-&&&&&& -->
		<%
			//成功比数小计
			rent_25cgbs_xj = rent_CCB_25cgbs + penalty_CCB_25cgbs;
			rent_cgbs2_hj+= rent_25cgbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_25cgbs_xj+"") %></td>
		<%
			//成功金额小计
			rent_25cgje_xj = rent_CCB_25cgje + penalty_CCB_25cgje;
			rent_cgje2_hj+= rent_25cgje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_25cgje_xj) %></td>
		<%
			//未成功比数小计
			rent_25sbbs_xj = rent_CCB_25sbbs + penalty_CCB_25sbbs;
			rent_sbbs2_hj+= rent_25sbbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_25sbbs_xj+"") %></td>
		<%
			//成功金额小计
			rent_10sbje_xj = rent_CCB_25sbje + penalty_CCB_25sbje;
			rent_sbje2_hj+= rent_25sbje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_25sbje_xj) %></td>
		
		<!-- &&&&&&&-30日-&&&&&& -->
		<%
			//成功比数小计
			rent_30cgbs_xj = rent_CCB_30cgbs + penalty_CCB_30cgbs;
			rent_cgbs3_hj+= rent_30cgbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_30cgbs_xj+"") %></td>
		<%
			//成功金额小计
			rent_30cgje_xj = rent_CCB_30cgje + penalty_CCB_30cgje;
			rent_cgje3_hj+= rent_30cgje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_30cgje_xj) %></td>
		<%
			//未成功比数小计
			rent_30sbbs_xj = rent_CCB_30sbbs + penalty_CCB_30sbbs;
			rent_sbbs3_hj+= rent_30sbbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_30sbbs_xj+"") %></td>
		<%
			//成功金额小计
			rent_10sbje_xj = rent_CCB_30sbje + penalty_CCB_30sbje;
			rent_sbje3_hj+= rent_30sbje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_30sbje_xj) %></td>
	</tr>
	<tr>
		<td rowspan="3">农行</td>
		<td align="right" nowrap="nowrap">租金</td>
		<%
			//建行扣款租金比数
			partSql = "select dbo.t103_netpay_rent_kkbs("+year+","+month+",'ABC',20) as amount";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_kkbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_ABC_kkbs+"") %></td>
        <%
     		//农行5日扣款租金金额
			partSql = "select dbo.t103_netpay_rent_kkje("+year+","+month+",'ABC',20) as amount";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_kkje = rs.getDouble("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_ABC_kkje) %></td>
        
        <!-- %#########20日扣款#########% -->
        <%
     		//成功
			partSql = "select dbo.t103_netpay_rent_cgbs("+year+","+month+",'ABC',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_20cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_ABC_20cgbs+"") %></td>
        <%
     		//成功金额
			partSql = "select dbo.t103_netpay_rent_cgje("+year+","+month+",'ABC',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_20cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_ABC_20cgje) %></td>
         <%
     		//未成功
			partSql = "select dbo.t103_netpay_rent_sbbs("+year+","+month+",'ABC',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_20sbbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_ABC_20sbbs+"") %></td>
        <%
     		//未成功金额
			partSql = "select dbo.t103_netpay_rent_sbje("+year+","+month+",'ABC',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_20sbje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_ABC_20sbje) %></td>
        
        <!-- %#########25日扣款#########% -->
        <%
     		//成功
			partSql = "select dbo.t103_netpay_rent_cgbs("+year+","+month+",'ABC',25) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_25cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_ABC_25cgbs+"") %></td>
        <%
     		//成功金额
			partSql = "select dbo.t103_netpay_rent_cgje("+year+","+month+",'ABC',25) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_25cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_ABC_25cgje) %></td>
         <%
     		//未成功
			partSql = "select dbo.t103_netpay_rent_sbbs("+year+","+month+",'ABC',25) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_25sbbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_ABC_25sbbs+"") %></td>
        <%
     		//未成功金额
			partSql = "select dbo.t103_netpay_rent_sbje("+year+","+month+",'ABC',25) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_25sbje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_ABC_25sbje) %></td>
        
        <!-- %#########30日扣款#########% -->
        <%
     		//成功
			partSql = "select dbo.t103_netpay_rent_cgbs("+year+","+month+",'ABC',30) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_30cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_ABC_30cgbs+"") %></td>
        <%
     		//成功金额
			partSql = "select dbo.t103_netpay_rent_cgje("+year+","+month+",'ABC',30) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_30cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_ABC_30cgje) %></td>
         <%
     		//未成功
			partSql = "select dbo.t103_netpay_rent_sbbs("+year+","+month+",'ABC',30) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_30sbbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_ABC_30sbbs+"") %></td>
        <%
     		//未成功金额
			partSql = "select dbo.t103_netpay_rent_sbje("+year+","+month+",'ABC',30) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_30sbje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_ABC_30sbje) %></td>
	</tr>
	<tr>
		<td align="right" nowrap="nowrap">罚息</td>
		<%
			//农行5日罚息扣款比数
			partSql = "select dbo.t103_netpay_penalty_kkbs("+year+","+month+",'ABC',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_kkbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_ABC_kkbs+"") %></td>
        <%
     		//农行20日扣款罚息金额
			partSql = "select dbo.t103_netpay_penalty_kkje("+year+","+month+",'ABC',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_kkje = rs.getDouble("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_ABC_kkje) %></td>
        
        <!-- $###############20日扣款##################$ -->
		<%
     		//违约金成功
			partSql = "select dbo.t103_netpay_penalty_cgbs("+year+","+month+",'ABC',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_20cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_ABC_20cgbs+"") %></td>
        <%
     		//违约金成功金额
			partSql = "select dbo.t103_netpay_penalty_cgje("+year+","+month+",'ABC',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_20cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_ABC_20cgje) %></td>
         <%
     		//违约金未成功
			partSql = "select dbo.t103_netpay_penalty_sbbs("+year+","+month+",'ABC',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_20sbbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_ABC_20sbbs+"") %></td>
        <%
     		//违约金未成功金额
			partSql = "select dbo.t103_netpay_penalty_sbje("+year+","+month+",'ABC',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_20sbje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_ABC_20sbje) %></td>
        
        <!-- $###############25日扣款##################$ -->
		<%
     		//违约金成功
			partSql = "select dbo.t103_netpay_penalty_cgbs("+year+","+month+",'ABC',25) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_25cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_ABC_25cgbs+"") %></td>
        <%
     		//违约金成功金额
			partSql = "select dbo.t103_netpay_penalty_cgje("+year+","+month+",'ABC',25) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_25cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_ABC_25cgje) %></td>
         <%
     		//违约金未成功
			partSql = "select dbo.t103_netpay_penalty_sbbs("+year+","+month+",'ABC',25) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_25sbbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_ABC_25sbbs+"") %></td>
        <%
     		//违约金未成功金额
			partSql = "select dbo.t103_netpay_penalty_sbje("+year+","+month+",'ABC',25) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_25sbje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_ABC_25sbje) %></td>
        
        <!-- $###############30日扣款##################$ -->
		<%
     		//违约金成功
			partSql = "select dbo.t103_netpay_penalty_cgbs("+year+","+month+",'ABC',30) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_30cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_ABC_30cgbs+"") %></td>
        <%
     		//违约金成功金额
			partSql = "select dbo.t103_netpay_penalty_cgje("+year+","+month+",'ABC',30) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_30cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_ABC_30cgje) %></td>
         <%
     		//违约金未成功
			partSql = "select dbo.t103_netpay_penalty_sbbs("+year+","+month+",'ABC',30) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_30sbbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_ABC_30sbbs+"") %></td>
        <%
     		//违约金未成功金额
			partSql = "select dbo.t103_netpay_penalty_sbje("+year+","+month+",'ABC',30) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_30sbje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_ABC_30sbje) %></td>
	</tr>
	<tr class="tbodyStyle">
		<td align="right">小计</td>
		<%
			//农行租金扣款小计
			rent_kkbs_xj = rent_ABC_kkbs+penalty_ABC_kkbs;
			rent_kkbs_hj += rent_kkbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_kkbs_xj+"") %></td>
		<%
			//农行扣款金额小计
			rent_kkje_xj = rent_ABC_kkje+penalty_ABC_kkje;
			rent_kkje_hj += rent_kkje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_kkje_xj) %></td>
		
		<!-- &&&&&&&-20日-&&&&&& -->
		<%
			//成功比数小计
			rent_20cgbs_xj = rent_ABC_20cgbs + penalty_ABC_20cgbs;
			rent_cgbs1_hj+= rent_20cgbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_20cgbs_xj+"") %></td>
		<%
			//成功金额小计
			rent_20cgje_xj = rent_ABC_20cgje + penalty_ABC_20cgje;
			rent_cgje1_hj+= rent_20cgje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_20cgje_xj) %></td>
		<%
			//未成功比数小计
			rent_20sbbs_xj = rent_ABC_20sbbs + penalty_ABC_20sbbs;
			rent_sbbs1_hj+= rent_20sbbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_20sbbs_xj+"") %></td>
		<%
			//成功金额小计
			rent_10sbje_xj = rent_ABC_20sbje + penalty_ABC_20sbje;
			rent_sbje1_hj+= rent_20sbje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_20sbje_xj) %></td>
		
		<!-- &&&&&&&-25日-&&&&&& -->
		<%
			//成功比数小计
			rent_25cgbs_xj = rent_ABC_25cgbs + penalty_ABC_25cgbs;
			rent_cgbs2_hj+= rent_25cgbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_25cgbs_xj+"") %></td>
		<%
			//成功金额小计
			rent_25cgje_xj = rent_ABC_25cgje + penalty_ABC_25cgje;
			rent_cgje2_hj+= rent_25cgje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_25cgje_xj) %></td>
		<%
			//未成功比数小计
			rent_25sbbs_xj = rent_ABC_25sbbs + penalty_ABC_25sbbs;
			rent_sbbs2_hj+= rent_25sbbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_25sbbs_xj+"") %></td>
		<%
			//成功金额小计
			rent_10sbje_xj = rent_ABC_25sbje + penalty_ABC_25sbje;
			rent_sbje2_hj+= rent_25sbje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_25sbje_xj) %></td>
		
		<!-- &&&&&&&-30日-&&&&&& -->
		<%
			//成功比数小计
			rent_30cgbs_xj = rent_ABC_30cgbs + penalty_ABC_30cgbs;
			rent_cgbs3_hj+= rent_30cgbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_30cgbs_xj+"") %></td>
		<%
			//成功金额小计
			rent_30cgje_xj = rent_ABC_30cgje + penalty_ABC_30cgje;
			rent_cgje3_hj+= rent_30cgje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_30cgje_xj) %></td>
		<%
			//未成功比数小计
			rent_30sbbs_xj = rent_ABC_30sbbs + penalty_ABC_30sbbs;
			rent_sbbs3_hj+= rent_30sbbs_xj;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_30sbbs_xj+"") %></td>
		<%
			//成功金额小计
			rent_10sbje_xj = rent_ABC_30sbje + penalty_ABC_30sbje;
			rent_sbje3_hj+= rent_30sbje_xj;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_30sbje_xj) %></td>
	</tr>	
	<tr><td colspan="26">
	</td></tr>
</tbody>		

<tfoot>
	<tr background="#CCFFFF;">
		<td align="right" colspan="2" style="color:#10418C;font-weight:bold;">合计</td>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_kkbs_hj+"") %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_kkje_hj) %></td>
		<!-- 1合计 -->
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_cgbs1_hj+"") %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_cgje1_hj) %></td>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_sbbs1_hj+"") %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_sbje1_hj) %></td>
		<!-- 2合计 -->
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_cgbs2_hj+"") %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_cgje2_hj) %></td>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_sbbs2_hj+"") %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_sbje2_hj) %></td>
		<!-- 3合计 -->
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_cgbs3_hj+"") %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_cgje3_hj) %></td>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_sbbs3_hj+"") %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_sbje3_hj) %></td>
	</tr>	
</tfoot>
</table>

</div><!--报表结束-->
</form>
</body>
</html>