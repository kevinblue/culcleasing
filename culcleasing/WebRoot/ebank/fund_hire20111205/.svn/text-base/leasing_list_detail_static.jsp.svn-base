<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/headImport.jsp"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" /> 

<!-- 05.002 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>租赁公司收款列表(首付款)</title>
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
	<script src="../../js/delitem.js"></script>
	<script src="../../js/calend.js"></script>

	<script Language="Javascript" src="../../js/jquery.js"></script>
	<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
	<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="../../js/stleasing_function.js"></script>
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
<body  onload="public_onload(0);">
<form action="leasing_list_detail_search.jsp" name="dataNav" onSubmit="return goPage()">		
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
   <tr>
	<td>代理商:<input name="dls" type="text" size="10" value="" /></td>
	<td>项目&nbsp;&nbsp;编号: <input name="xmbh" type="text" size="10" value="" /></td>
	<td>客户名称:&nbsp;<input name="khmc" type="text" size="10" value=""></td>
	<td>计划日期:
	<input name="yf_date_start" type="text"  size="10"   value=""   readonly  dataType="Date">
     <img  onClick="openCalendar(yf_date_start);return false" style="cursor:pointer; " 
     src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
     -
    <input name="yf_date_end" type="text"  size="10"   value=""   readonly  dataType="Date">
     <img  onClick="openCalendar(yf_date_end);return false" style="cursor:pointer; " 
     src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	 </td>
	 <td>
	 <input type="button" value="查询" onclick="waitSub()"> 
	 </td>
   </tr>

   <tr>
	<td>出厂编号:&nbsp;<input name="equip_sn" type="text" size="10" value=""></td>
	<td>到账日期:
	<input name="dz_date_start" type="text"  size="10"   value=""   readonly  dataType="Date">
     <img  onClick="openCalendar(dz_date_start);return false" style="cursor:pointer; " 
     src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
     -
    <input name="dz_date_end" type="text"  size="10"   value=""   readonly  dataType="Date">
     <img  onClick="openCalendar(dz_date_end);return false" style="cursor:pointer; " 
     src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	</td>
	<td>
	 <input type="button" value="清空" onclick="clearQuery();">
	</td>
	</tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
	<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		租赁公司收款列表（首期付款）
	</td>
	</tr>
</table>
<!--标题结束-->
<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;height:100%" id="mydiv">
<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"
class="maintab_content_table">
	<tr class="maintab_content_table_title">							
      	 <th>项目编号</th>
		 <th>客户名称</th>
		 
		 <th>租赁物类型</th>
		 <th>制造商</th>
		 <th>机型</th>
		 <th>出厂编号</th>
		 <th>租赁物购买价款</th>
			 
		 <th>1起租租金</th>
		 <th>2保证金</th>
		 <th>3第一期租金</th>
		 <th>4保险费</th>
		 <th>5手续费</th>
		 <th>6担保费</th>
		 <th>7留购价款</th>
		 <th>首期付款合计</th>
		 <th>计划日期</th>
		 <th>到帐日期</th>
		 <th>付款单号</th>
	</tr>
</table>
<div id="firstload">
<!-- 友好提示 -->
<center><div style="margin-top:60px">
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


