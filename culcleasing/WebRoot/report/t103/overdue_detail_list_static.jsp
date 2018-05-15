<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/headImport.jsp"%>
<!-- 05.002 -->
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>租金管理- 逾期明细表</title>
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
	<script src="../../js/delitem.js"></script>

	<script Language="Javascript" src="../../js/jquery.js"></script>
	<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
	<script type="text/javascript" src="../../js/stleasing_function.js"></script>
	<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
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
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<!-- 下拉值 -->
<%@ include file="../../public/selectData.jsp"%>
<!-- 下拉值 -->

<!-- 租赁公司、代理商的判断 -->
<%@ include file="../../public/pageRight.jsp"%>
<!-- 租赁公司、代理商的判断 -->

<body onload="public_onload(0);">
<form action="overdue_detail_list.jsp" name="dataNav" onSubmit="return goPage()">
	<!--标题开始-->
	<table border="0" width="100%" cellspacing="0" cellpadding="0"
		height="25">
		<tr class="tree_title_txt">
			<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				租金管理&gt; 逾期明细表
			</td>
		</tr>
	</table>
<!--标题结束-->
<%String yq_amount_str = "|逾期1期|逾期2期|逾期3期|3期以上"; %>
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>代理商</td>
<td><input name="dld_name" type="text" size="11" ></td>
<td>项目编号</td>
<td><input name="proj_id" type="text" size="11" ></td>
<td>租赁物类型</td>
<td><select name="prod_id" style="width:90px;">
     <script>w(mSetOpt('',"<%= prod_id_str%>"));</script>
     </select>
</td>

<td>起租确认日</td>
<td><input name="start_date" type="text" size="10" readonly dataType="Date" ><img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">&nbsp;至
<input name="end_date" type="text" size="10" readonly dataType="Date" ><img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td><input type="button" onclick="waitSub()" value="查询"></td>
</tr>

<tr>
<td>制造商</td>
<td><select name="zzs" style="width:90px;">
     <script>w(mSetOpt('',"<%=zzs_str%>"));</script>
     </select></td>
<td>客户名称</td>
<td><input name="cust_name" type="text" size="11" ></td>
<td>逾期&nbsp;&nbsp;期数</td><td><select name="yq_amount" style="width:90px;">
     <script>w(mSetOpt('',"<%= yq_amount_str%>"));</script>
     </select>
</td>

<td>逾期&nbsp;&nbsp;天数</td>
<td><input name="overdue_day_start" type="text" size="10" >&nbsp;&nbsp;至&nbsp;&nbsp;
<input name="overdue_day_end" type="text" size="10">
</td>
<td><input type="button" onclick="clearQuery()" value="清空"></td>
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
				<!--
				<td>
				<BUTTON class="btn_2"  type="button" onclick="return validata_data_exp()">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出PDF</button>
				</td>
				-->
				 <td>
				<img src="../../images/sbtn_split.gif" width="2" height="14">
				</td>
				<td nowrap>
					<input name="ck_all" style="border:none;" type="checkbox">&nbsp;页面全选
					<input name="data_ck_all" style="border:none;" type="checkbox">&nbsp;数据全选
				</td><!--操作按钮结束-->
			</tr>
		</table><!--操作按钮结束-->
		</td>
	</tr>
</table>

<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">

	<table border="0" style="border-collapse:collapse;" align="center"
		cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
		<tr class="maintab_content_table_title">
		<th width="1%"></th> 						
        <th>序号</th>
        <th>区域</th>
		<th>代理店</th>
        <th>分支机构</th>
        <th>项目编号</th>
        <th>客户名称</th>
		<th>制造商</th>
		<th>租赁物类型</th>
        <th>机型</th>
        <th>出厂编号</th>
        
		<th>起租日期</th>
		<th>租赁期限</th>
		<th>计划还款日期</th>

		<th>租赁物购买价款</th>
        
		<th>租金总额</th>
		<th>已付期数</th>
		<th>已付租金</th>

		<th>未付期数</th>
		<th>未付租金</th>
        
		<th>逾期期数</th>
		<th>累计逾期</th>
        <th>逾期天数</th>
        <th>逾期租金金额</th>
        
	</tr>
</table>
<div id="firstload">
<!-- 友好提示 -->
<center><div style="margin-top:40px">
<font color=#808080>
&nbsp;&nbsp;您好，首次载入请点击查询...</font></div></center>
<!-- 友好提示结束 -->
</div>

<div id="waitload" style="display:none;">
<!-- 友好提示 -->
<center><div style="margin-top:40px">
<img src="../../images/loading.gif" align="center">
<font color=#808080>
&nbsp;&nbsp;报表载入中，请稍候...</font></div></center>
<!-- 友好提示结束 -->
</div>

</div><!--报表结束-->
</form>
</body>
</html>

