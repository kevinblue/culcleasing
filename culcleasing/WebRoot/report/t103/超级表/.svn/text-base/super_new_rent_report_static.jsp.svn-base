<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<!-- 05.002 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>项目台帐-项目超级表</title>
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
	<script src="../../js/delitem.js"></script>

	<script type="text/javascript" src="../../js/jquery.js"></script>
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

<!-- 下拉值 -->
<%@ include file="../../public/selectStaticData.jsp"%>
<!-- 下拉值 -->

<body onload="public_onload(0);">
<form action="super_new_rent_report.jsp" name="dataNav">
<%-- 隐藏字段设置 --%>
<input type="hidden" name="export_data_id" id="export_data_id">

<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0"
	height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
			项目台帐&gt; 项目超级表
		</td>
	</tr>
</table>
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="1" cellpadding="0">
<tr>
<td>代理商</td>
<td><input name="dld_name" type="text" size="11"></td>
<td>项目编号</td>
<td><input name="proj_id" type="text" size="11"></td>
<td>租赁物类型</td>
<td><select name="prod_id" style="width:100px;">
     <script>w(mSetOpt('',"<%=prod_id_str %>"));</script>
     </select>
</td>

<td>起租确认日</td>
<td> <input name="start_date" type="text" size="10" readonly dataType="Date"><img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
<td>&nbsp;至</td>
<td>
<input name="end_date" type="text" size="10" readonly dataType="Date"><img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td><input type="button" onclick="waitSub()" value="查询"></td>
</tr>

<tr>
<td>制造商</td>
<td>
<select name="zzs" style="width:90px;">
 <script>w(mSetOpt('',"<%=zzs_str%>"));</script>
</select>
</td>
<td>客户名称</td>
<td><input name="cust_name" type="text" size="11"></td>
<td>结束&nbsp;&nbsp;方式</td>
<td>
<select name="js_method" style="width:100px;">
<script>w(mSetOpt('',"|提前还租|设备回购|项目撤销|正常结清"));</script>
</select>
</td>

<td>规则&nbsp;&nbsp;付款</td>
<td>
<select name="is_method" style="width:100px;">
 <script>w(mSetOpt('',"|规则|不规则"));</script>
</select>
</td>
<td>项目状态</td>
<td>
<select name="proj_state" style="width:100px;">
     <script>w(mSetOpt('',"<%=proj_state_str %>"));</script>
</select>
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
				<input name="expsqlstr" type="hidden">
				<BUTTON class="btn_2"  type="button" onclick="return validata_data_exp_big('super_rent_export.jsp')">
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
		<th>代理商</th>
		<th>分支机构</th>
        <th>项目编号</th>
		<th>客户名称</th>
		<th>客户编号</th>
		<th>身份证号</th>
		<th>联系方式</th>
		
		<th>租赁物类型</th>
		<th>制造商</th>
		<th>规则付款</th>
		<th>机型</th>
		<th>出厂编号</th>
		<th>台量</th>

		<th>申请日期</th>
		<th>信审批准日期</th>
		<th>签约日期</th>
		<th>验收日期</th>
		<th>起租确认日期</th>
		<th>租赁期限</th>
		<th>租赁到期日</th>
		<th>交货地点</th>

		<th>是否放款</th>
		<th>计划放款日期</th>
		<th>实际放款日期</th>

        <th>租赁物购买价款</th>
        <th>融资租赁额</th>
		<th>租赁期限</th>
        <th>起租比例</th>
        <th>融资金额</th>

        <th>1起租租金</th>
		<th>2保证金</th>
		<th>3第一期租金</th>
		<th>4保险费</th>
		<th>5手续费</th>
		<th>6担保费</th>
		<th>7留购价款</th>
		<th>首期付款合计</th>

		<th>8DB保证金</th>
		<th>9管理服务费</th>
		<th>首付方式</th>
		<th>租金方式</th>
		<th>计划首期付款日</th>
		<th>实际首期付款日</th>

		<th>租金总额</th>
		<th>利息总计</th>
		<th>已还租期数</th>
		<th>已还租金</th>
		<th>剩余租金期数</th>
		<th>租金余额</th>
		<th>剩余本金</th>
		<th>剩余利息</th>
		<th>逾期租金</th>
		<th>逾期天数</th>

		<th>违约金合计</th>
		<th>已收违约金</th>
		<th>未收违约金</th>
		<th>免除违约金</th>
		<th>违约金处理</th>
		<th>逾期期数</th>
		<th>累计逾期数</th>
		<th>开户银行</th>
		<th>开户账号</th>
		<th>结束方式</th>
		<th>状态</th>
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