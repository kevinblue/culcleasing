<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>利息计税(营业税)查询</title>
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
<form action="lxjsYY_list.jsp" name="dataNav">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		 利息计税（营业税）查询
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

<!-- <td>
付款方式:&nbsp;<select name="period_type" style="width:115px;">
  <script type="text/javascript">
   	w(mSetOpt('',"|期初|期末","|期初|期末","|期初|期末","|期初|期末"));
  </script>
</select>
</td>
<td>
是否第一期:&nbsp;<select name="is_first" style="width:115px;">
  <script type="text/javascript">
   	w(mSetOpt('',"|是|否","|是|否"));
  </script>
</select>
</td> -->

<td>日期查询:&nbsp;<input name="start_date" type="text" size="10" readonly dataType="Date"><span class="biTian">*</span>
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
&nbsp;至&nbsp;
<input name="end_date" type="text" size="10" readonly dataType="Date"><span class="biTian">*</span>
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td>项目名称:&nbsp;<input name="project_name" type="text" size="10" ></td>
<td><input type="button" value="查询" onclick="waitSub()"></td>
<td><input type="button" value="清空" onclick="clearQuery();" ></td>
</tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->

 
<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
	<table border="0" style="border-collapse:collapse;" align="center"
		cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
	
	 <tr class="maintab_content_table_title">
		<th>项目编号</th>
		<th>合同编号</th>
		<th>起租编号</th>
		<th>项目名称</th>
        <th>项目部门</th>
        <th>大区</th>
        <th>承租客户</th>

		<th>板块名称</th>
		<th>项目经理</th>
		<th>租赁类型</th>
		<th>租金期次</th>
        <th>计划日期</th>
        <th>实收日期</th>
        <th>租金</th>
		

		<th>剩余租金</th>
		<th>租金差异</th>
		<th>本金</th>
		<th>剩余本金</th>
        <th>利息</th>
        <th>剩余利息</th>
        <th>状态</th>
        

		<th>税种</th>
		<th>计划银行</th>
		<th>是否保理</th>
		<!-- <th>是否导入</th> -->
        
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
	
	
	<tr><td colspan="25">
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