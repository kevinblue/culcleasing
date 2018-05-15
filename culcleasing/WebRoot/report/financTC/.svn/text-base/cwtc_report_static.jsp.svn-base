<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>资金计划及差异 - 头寸预测表</title>
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
<form action="cwtc_report.jsp" name="dataNav" method="get">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		资金计划及差异&gt; 头寸预测表
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

<td width="600">资金计划开始日:&nbsp;
<input name="start_date" type="text" size="15" readonly dataType="Date">
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
&nbsp;&nbsp;
结束日期:
<input name="end_date" type="text" size="15" readonly dataType="Date">
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>

<td>
是否核销:&nbsp;&nbsp;
<select name="if_hire" id="if_hire" style="width: 115px;" Require="true">
<script type="text/javascript">
 w(mSetOpt('',"|已核销|未核销","|1|0"));
</script>
</td>

<td colspan="2" align="left">
<input type="button" onclick="waitSub()" value="查询">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" onclick="clearQuery()" value="清空"></td>
</tr>

<tr>
<td scope="row">
出单部门:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
<input style="width:150px;" name="dept_no" id="dept_no" type="hidden" readonly="readonly">
<input style="width:115px;" name="dept_name" id="dept_name" type="text" readonly="readonly">
<img src="../../images/fdmo_65.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onClick="OpenDataWindow('','','','','出单部门','base_department','dept_name','dept_name|id','id','id','asc','dataNav.dept_name','dataNav.dept_name|dataNav.dept_no');">  
</td>


<td>项目经理:&nbsp;
<input style="width:150px;" name="proj_manage" id="proj_manage" type="hidden" readonly="readonly">
<input style="width:115px;" name="manage_name" id="manage_name" type="text" readonly="readonly">
<img src="../../images/fdmo_65.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onClick="OpenDataWindow('','','','','项目经理','base_user','name','name|id','id','id','asc','dataNav.manage_name','dataNav.manage_name|dataNav.proj_manage');">  
</td>	

<td>版块:&nbsp;&nbsp;
<input style="width:150px;" name="proj_industry" id="proj_industry" type="hidden" readonly="readonly">
<input style="width:115px;" name="code" id="code" type="text" readonly="readonly">
<img src="../../images/fdmo_65.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onClick="OpenDataWindow('','','','','板块','base_trade','board_name','board_name|code','code','code','asc','dataNav.code','dataNav.code|dataNav.proj_industry');"> 
</td>	
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
		<td nowrap align="center">
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
		<th colspan="2" style="font-weight: bold;width: 40%;">项目</th>
	    <th align="center" style="font-weight: bold;">流入</th>
	    <th align="center" style="font-weight: bold;">流出</th>
	</tr>
<tbody>
	
	<!-- 现金收入 -->
	<tr>
		<td rowspan="3">现金流入</td>
		<td align="center" nowrap="nowrap">租金流入</td>
		<td></td>
		<td></td>
	</tr>
	
	<tr>
		<td align="center" nowrap="nowrap">其中保理租金流入</td>
		<td></td>
		<td></td>
	</tr>
	
	<tr>
		<td align="center" nowrap="nowrap">扣除保理的租金流入</td>
		<td></td>
		<td></td>
	</tr>
	
	<tr>
		<td rowspan="5">资金收入</td>
		<td align="center" nowrap="nowrap">其他经营活动现金流入</td>
		<td></td>
		<td></td>
	</tr>
		
	<tr>
		<td align="center" nowrap="nowrap">银行借款资金流入</td>
		<td></td>
		<td></td>
	</tr>	
		
	<tr>
		<td align="center" nowrap="nowrap">非银行机构借款现金流入</td>
		<td></td>
		<td></td>
	</tr>	
	
	<tr>
		<td align="center" nowrap="nowrap">集团内部借款现金流入</td>
		<td></td>
		<td></td>
	</tr>
		
	<tr>
		<td align="center" nowrap="nowrap">其他流入</td>
		<td></td>
		<td></td>
	</tr>					
					
	<tr style="background-color: #CCFFFF;">
		<td colspan="2" align="center">合计</td>
		<td></td>
		<td></td>
	</tr>
	
	
	<!-- 现金支出 -->
	<tr>
		<td rowspan="5">现金流出</td>
		<td align="center" nowrap="nowrap">经营活动现金流出</td>
		<td></td>
		<td></td>
	</tr>
	
	<tr>
		<td align="center" nowrap="nowrap">偿还贷款本金（非保理）</td>
		<td></td>
		<td></td>
	</tr>
	
	<tr>
		<td align="center" nowrap="nowrap">偿还贷款利息（非保理）</td>
		<td></td>
		<td></td>
	</tr>		

	<tr>
		<td align="center" nowrap="nowrap">手续费流出</td>
		<td></td>
		<td></td>
	</tr>	

	<tr>
		<td align="center" nowrap="nowrap">其他流出</td>
		<td></td>
		<td></td>
	</tr>
		
	<tr style="background-color: #CCFFFF;">
		<td colspan="2" align="center">合计</td>
		<td></td>
		<td></td>
	</tr>
	
	<tr style="background-color: green;">
		<td colspan="2" align="center"><font style="font-weight: bold;">头寸</font></td>
		<td></td>
		<td></td>
	</tr>
	
	

	
<table border="0" style="border-collapse:collapse;" align="center"
		cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
	 <tr class="maintab_content_table_title">
		<th style="font-weight: bold;">项目名称</th>
	    <th align="center" style="font-weight: bold;">付款</th>
	    <th align="center" style="font-weight: bold;">收款</th>
		<th align="center" style="font-weight: bold;">计划日期</th>
	    <th align="center" style="font-weight: bold;">实际日期</th>
	 </tr>
	 
</table>
	
</tbody>

</table>
</div><!--报表结束-->
</form>
</body>
</html>