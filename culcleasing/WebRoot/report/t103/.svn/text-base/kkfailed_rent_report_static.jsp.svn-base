<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<!-- 05.002 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<meta http-equiv="Expires" content="3600"><!-- 缓存1小时 -->	
	<title>租金管理 - 扣款未成功明细表</title>
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
</head>

<!-- 下拉值 -->
<%@ include file="../../public/selectStaticData.jsp"%>
<!-- 下拉值 -->

<body onload="public_onload(0);">
<form action="kkfailed_rent_report.jsp" name="dataNav">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
			租金管理 &gt; 扣款未成功明细表
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
<td>代理商</td>
<td><input name="dld_name" type="text" size="11"></td>
<td>项目编号</td>
<td><input name="proj_id" type="text" size="11"></td>
<td>租赁物类型</td>
<td><select name="prod_id" style="width:88px;">
     <script>w(mSetOpt('',"<%=prod_id_str %>"));</script>
     </select>
</td>

<td>应收日期</td>
<td><input name="start_date" type="text" size="9" readonly dataType="Date">
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
<td>&nbsp;&nbsp;至&nbsp;</td>
<td>
<input name="end_date" type="text" size="9" readonly dataType="Date">
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td>开户银行</td>
<td><select name="bank" style="width:90px;">
     <script>w(mSetOpt('',"<%=bank_str %>"));</script>
     </select></td>

</tr>

<tr>
<td>制造商</td>
<td>
<select name="zzs" style="width:88px;">
 <script>w(mSetOpt('',"<%=zzs_str%>"));</script>
</select>
</td>
<td>客户名称</td>
<td><input name="cust_name" type="text" size="11"></td>
<td>出厂&nbsp;&nbsp;编号</td>
<td><input name="equip_sn" type="text" size="11"></td>

<td>资金状态</td>
<td>
<select name="zj_status" style="width:100px;">
 <script>w(mSetOpt('',"|逾期|正常"));</script>
</select>
</td>
<td>款项内容</td>
<td>
<select name="fee_type" style="width:100px;">
 <script>w(mSetOpt('',"|租金|违约金"));</script>
</select>
</td>
<td align="left"><input type="button" onclick="waitSub()" value="查询"></td>
<td align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" onclick="clearQuery()" value="清空"></td>
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
				<BUTTON class="btn_2"  type="button" onclick="return validata_data_exp();">
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
		<th>代理商</th>
        <th>项目编号</th>
		<th>客户名称</th>
		
		<th>规则付款</th>
		<th>租赁物类型</th>
		<th>制造商</th>
		<th>机型</th>
		<th>出厂编号</th>

		<th>款项内容</th>
		<th>期次</th>
		<th>扣款方式</th>
		<th>应收日期</th>
		<th>应收金额</th>

		<th>扣款日期</th>
		<th>未成功原因</th>
		<!--
		<th>余额</th>
		-->
		
		<th>逾期原因</th>
		<th>逾期说明</th>
		<th>详细描述</th>
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