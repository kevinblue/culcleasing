<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>还款实际间隔差异表</title>
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
	//判断必填项是否填写
	var sD = $(":input[name='start_date']").val();
	var eD = $(":input[name='end_date']").val();
	
	if(sD=="" || eD==""){
		alert("查询时间段必须填写！！");
		return false;
	}else{
		$("#firstload").css("display","none");
		$("#waitload").css("display","block");
	
		dataNav.submit();
	}
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
<form action="fact_hire_gap_diff.jsp" name="dataNav">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		 还款实际间隔差异表
		</td>
	</tr>
</table><!--标题结束-->

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>项目名称:&nbsp;<input name="project_name"  type="text" size="15"></td>
<td>客户名称:&nbsp;<input name="cust_name"  type="text" size="15"></td>

<td>
版块:&nbsp;<select name="board_name" style="width:115px;">
  <script type="text/javascript">
   	w(mSetOpt('',"|医疗事业|船舶|教育|机械|其他","|医疗事业|船舶|教育|机械|其他"));
  </script>
</select>
</td>

<td><input type="button" value="查询" onclick="waitSub()"></td>
</tr>

<tr>
<td>查询时间:&nbsp;<input name="start_date" type="text" size="10" readonly dataType="Date"><span class="biTian">*</span>
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
&nbsp;至&nbsp;
<input name="end_date" type="text" size="10" readonly dataType="Date"><span class="biTian">*</span>
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>

<td>项目经理:&nbsp;<input name="manage_name"  type="text" size="15"></td>
<td>部门:&nbsp;<input name="dept_name"  type="text" size="15"></td>

<td><input type="button" value="清空" onclick="clearQuery();" ></td>
</tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->

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
		<th>项目名称</th>
        <th>客户名称</th>
        <th>板块</th>
        <th>签约时间</th>
        
        <th>部门</th>
        <th>项目经理</th>
        <th>医院等级</th>
        <th>医院收入</th>
        <th>是否规则</th>
        <th>合同租赁间隔（天）</th>
        
        <th width="60px;">第1间隔差异（天）</th>
        <th width="60px;">第2间隔差异（天）</th>
        <th width="60px;">第3间隔差异（天）</th>
        <th width="60px;">......</th>
        <th width="60px;">......</th>
        <th width="60px;">第N间隔差异（天）</th>
      </tr>  
<tbody>
	
	<tr>
		<td align="left"></td>	
		<td align="left"></td>	
		<td align="left"></td>	
		<td align="left"></td>	

		<td align="left"></td>	
		<td align="left"></td>	
		<td align="left"></td>	
		<td align="left"></td>	
		<td align="left"></td>	

		<td align="left"></td>	
		<td align="left"></td>	
		<td align="left"></td>	
		<td align="left"></td>	
		<td align="left"></td>	
		<td align="left"></td>
		<td align="left"></td>		
	</tr>	
	
	
	<tr><td colspan="16">
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