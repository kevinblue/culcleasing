<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>资金头寸报表 - 资金期限结构统计表</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

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
.maintab_content_table_title2 {
/*background-image:url(../images/pageleft_topbg_1.gif);*/
background-color:#ffffff;
color:#15428B;
text-align:center;
border-top:1px solid #FF0000;
position:relative;
}
</style>
</head>

<body onload="public_onload(0);">
<form action="zjqxjg_report.jsp" name="dataNav">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		 资金头寸报表&gt; 资金期限结构统计表
		</td>
	</tr>
</table><!--标题结束-->

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="1" cellpadding="0">
<tr>

<td>选择开始日期：&nbsp;&nbsp;
<input name="start_date" type="text" size="15" readonly dataType="Date">
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>

<td colspan="2">
<input type="button" onclick="waitSub()" value="查询">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" onclick="clearQuery()" value="清空"></td>
</tr>
</table>
</fieldset>
</div><!-- 查询条件结束 -->

<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
	<td align="left" width="1%">
	<!--操作按钮开始-->
	<table border="0" cellspacing="0" cellpadding="0" >    
	<tr class="maintab">
		<td>
			<BUTTON class="btn_2"  type="button" onclick="javascript: alert('对不起，暂无数据，无法操作！');">
			<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>
		</td>
			
		<td>
			<img src="../../images/sbtn_split.gif" width="2" height="14">
		</td>
		<td nowrap>
		</td><!--操作按钮结束-->
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
		<th colspan="2" style="font-weight: bold;">项目</th>
	    <th align="center" style="font-weight: bold;">1个月内</th>
	    <th align="center" style="font-weight: bold;">1-3个月</th>
	    <th align="center" style="font-weight: bold;">3-6个月</th>
	    <th align="center" style="font-weight: bold;">6-12个月</th>
   	    <th align="center" style="font-weight: bold;">1-2年</th>
   	    <th align="center" style="font-weight: bold;">2-3年</th>	    
   	    <th align="center" style="font-weight: bold;">3年+</th>	      	    
	</tr>
<tbody>
	
	<!-- 现金收入 -->
	<tr>
		<td rowspan="5">现金收入</td>
		<td align="center" nowrap="nowrap">租赁利息</td>
		<script type="text/javascript">
			for(var i=0;i<7;i++){
				document.write("<td></td>");
			}
		</script>
	</tr>
	
	<tr>
		<td align="center" nowrap="nowrap">租赁本金</td>
		<script type="text/javascript">
			for(var i=0;i<7;i++){
				document.write("<td></td>");
			}
		</script>
	</tr>
	
	<tr>
		<td align="center" nowrap="nowrap">保证金</td>
		<script type="text/javascript">
			for(var i=0;i<7;i++){
				document.write("<td></td>");
			}
		</script>
	</tr>
	
	<tr>
		<td align="center" nowrap="nowrap">其他</td>
		<script type="text/javascript">
			for(var i=0;i<7;i++){
				document.write("<td></td>");
			}
		</script>
	</tr>
		
	<tr style="background-color: #CCFFFF;">
		<td align="center">小计</td>
		<script type="text/javascript">
			for(var i=0;i<7;i++){
				document.write("<td></td>");
			}
		</script>
	</tr>
	
	<!-- 现金支出 -->
	<tr>
		<td rowspan="6">现金支出</td>
		<td align="center" nowrap="nowrap">银行利息</td>
		<script type="text/javascript">
			for(var i=0;i<7;i++){
				document.write("<td></td>");
			}
		</script>
	</tr>
	
	<tr>
		<td align="center" nowrap="nowrap">银行本金</td>
		<script type="text/javascript">
			for(var i=0;i<7;i++){
				document.write("<td></td>");
			}
		</script>
	</tr>
	
	<tr>
		<td align="center" nowrap="nowrap">保证金返还</td>
		<script type="text/javascript">
			for(var i=0;i<7;i++){
				document.write("<td></td>");
			}
		</script>
	</tr>
	
	<tr>
		<td align="center" nowrap="nowrap">设备款</td>
		<script type="text/javascript">
			for(var i=0;i<7;i++){
				document.write("<td></td>");
			}
		</script>
	</tr>

	<tr>
		<td align="center" nowrap="nowrap">其他</td>
		<script type="text/javascript">
			for(var i=0;i<7;i++){
				document.write("<td></td>");
			}
		</script>
	</tr>
		
	<tr style="background-color: #CCFFFF;">
		<td align="center">小计</td>
		<script type="text/javascript">
			for(var i=0;i<7;i++){
				document.write("<td></td>");
			}
		</script>
	</tr>
	
	<tr style="background-color: green;">
		<td colspan="2" align="center"><font style="font-weight: bold;">资金缺口</font></td>
		<script type="text/javascript">
			for(var i=0;i<7;i++){
				document.write("<td></td>");
			}
		</script>
	</tr>
	
	
	<tr><td colspan="9">
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
		<img src="../../images/loading.gif" style="text-align: center;">
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