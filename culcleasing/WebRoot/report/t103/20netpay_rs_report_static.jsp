<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ include file="../../func/common_simple.jsp"%>

<!-- 05.002 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>项目台帐-租金统计-20日网银扣款</title>
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
	<script src="../../js/delitem.js"></script>

	<script Language="Javascript" src="../../js/jquery.js"></script>
	<script language="javascript">
	function clearQuery(){
	$("#queryArea input").not(":button").val("");
		$("#queryArea select").val("");
	}

	function waitSub(){
		$("#firstload").css("display","none");
		$("#waitload").css("display","block");

		dataNav.submit();
	}
	</script>
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
	</style>
</head>

<body onload="public_onload(0);">
<form action="20netpay_rs_report.jsp" name="dataNav">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		  租金统计&gt; 20日网银扣款
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
<input type="button" onclick="waitSub()" value="查询">
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
				<BUTTON class="btn_2"  type="button" onclick="javascript: alert('对不起，暂无数据，无法操作！');">
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
        
		<th colspan="2" style="font-weight: bold;">20日扣款</th>
		<th colspan="4" style="font-weight: bold;">20日</th>
		<th colspan="4" style="font-weight: bold;">25日</th>
		<th colspan="4" style="font-weight: bold;">30日</th>
		<th colspan="6" style="font-weight: bold;">月底统计</th>
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
	  	<th align="center">成功笔数</th>
	    <th align="center">成功金额</th>
	    <th align="center">未成功笔数</th>
	    <th align="center">未成功金额</th>
	    <th align="center">未成功笔数%</th>
	    <th align="center">未成功金额%</th>
	</tr>
<tbody>
	<tr>
		<td rowspan="3">建行</td>
		<td align="center" nowrap="nowrap">租金</td>
		<script type="text/javascript">
			for(var i=0;i<20;i++){
				document.write("<td></td>");
			}
		</script>
	</tr>
	<tr>
		<td align="center" nowrap="nowrap">罚息</td>
		<script type="text/javascript">
			for(var i=0;i<20;i++){
				document.write("<td></td>");
			}
		</script>
	</tr>
	<tr bgcolor="#CCFFFF;">
		<td align="center">小计</td>
		<script type="text/javascript">
			for(var i=0;i<20;i++){
				document.write("<td></td>");
			}
		</script>
	</tr>
	<tr>
		<td rowspan="3">农行</td>
		<td align="center" nowrap="nowrap">租金</td>
		<script type="text/javascript">
			for(var i=0;i<20;i++){
				document.write("<td></td>");
			}
		</script>
	</tr>
	<tr>
		<td align="center" nowrap="nowrap">罚息</td>
		<script type="text/javascript">
			for(var i=0;i<20;i++){
				document.write("<td></td>");
			}
		</script>
	</tr>
	<tr>
		<td align="center" bgcolor="#CCFFFF;" nowrap="nowrap">小计</td>
		<script type="text/javascript">
			for(var i=0;i<20;i++){
				document.write('<td  bgcolor="#CCFFFF;"></td>');
			}
		</script>
	</tr>	
	<tr><td colspan="22">
	<div id="firstload">
	<!-- 友好提示 -->
	<center><div style="margin-top:10px">
	<font color=#808080>
	&nbsp;&nbsp;您好，首次载入请点击查询...</font></div></center>
	<!-- 友好提示结束 -->
	</div>
	<div id="waitload" style="display:none;">
	<!-- 友好提示 -->
	<center><div style="margin-top:10px">
	<img src="../../images/loading.gif" align="center">
	<font color=#808080>
	&nbsp;&nbsp;报表载入中，请稍候...</font></div></center>
	<!-- 友好提示结束 -->
	</div>
	</td></tr>
</tbody>

</table>
</div><!--报表结束-->
</form>
</body>
</html>