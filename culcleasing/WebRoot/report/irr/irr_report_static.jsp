<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>动态IRR</title>
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
<form action="irr_report.jsp" name="dataNav" method="get">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		动态IRR
		</td>
	</tr>
</table><!--标题结束-->

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" 
onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="1" cellpadding="0">
<tr>
<td scope="row">
项目编号:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
<input style="width:150px;" name="proj_id" id="proj_id" type="text">
</td>


<td>项目名称:&nbsp;
<input style="width:150px;" name="project_name" id="project_name" type="text">
</td>	

<td>客户名称:&nbsp;&nbsp;
<input style="width:150px;" name="cust_name" id="cust_name" type="text">
</td>	
<td colspan="2" align="left">
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
		<th align="center" style="font-weight: bold;">项目编号</th>
	    <th align="center" style="font-weight: bold;">合同编号</th>
	    <th align="center" style="font-weight: bold;">项目名称</th>
	    <th align="center" style="font-weight: bold;">客户名称</th>
	    <th align="center" style="font-weight: bold;">计划IRR</th>
	    <th align="center" style="font-weight: bold;">实际IRR</th>
	</tr>
<tbody>
	
	
	
	<tr><td colspan="6">
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