<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>付款前提 - 资金计划</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
$(document).ready(function(){
		$("tbody[id='dataNew']>tr").each(function(i){
			//给td加 row\col属性
			$(this).children("td").each(function(j){
				$(this).addClass("noNewLine");//强制不换行  break-all自动换行
			});
		});
}
</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onLoad="public_onload(0)">
<!-- text="#000000" bgcolor="#FFFFFF" topmargin=0 leftmargin=0 class=menu style='border:1px solid #8DB2E3;margin:0px;' -->

<!-- 项目基本信息 -->
<div style="margin: 0px;">
<div id="cwTop">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
		<tr class="tree_title_txt">
			<td nowrap width="100%" class="tree_title_txt" valign="middle">
			项目基础信息</td>
		</tr>
</table> 
</div>
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td scope="row">项目编号</td>
    <td scope="row">CULCD100000022</td>
    <td scope="row">项目名称</td>
    <td scope="row">安徽**医院直租项目</td>
  </tr>
  
  <tr>
    <td scope="row">承租人</td>
    <td scope="row">安徽***医院</td>
    <td scope="row">行业</td>
    <td scope="row">医疗事业</td>
  </tr>
</table>
</div>

<!-- 自动生成、重新生成按钮 -->
<div style="margin-top: 10px;text-align: left;">
	<button name="btnAutoIn" type="button" onclick="">
	<img src="../../images/btn_rename.gif" align="bottom" border="0">自动生成资金计划</button>
	&nbsp;&nbsp;&nbsp;
	<button name="btnAgain" type="button" onclick="">
	<img src="../../images/btn_refresh.gif" align="bottom" border="0">重新生成资金计划</button>
</div>


<!-- 资金计划数据 -->
<div style="margin-top: 20px;">

<div id="cwTop">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
		<tr class="tree_title_txt">
			<td nowrap width="100%" class="tree_title_txt" valign="middle">
			资金计划</td>
		</tr>
</table> 
</div>
<!-- end cwTop -->

<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">

		<td><a href="#" accesskey="n" onClick="dataHander('add','basetrade_add.jsp',dataNav.itemselect);">
		<img align="absmiddle" src="../../images/sbtn_new.gif" alt="新增(Alt+N)"></a>

		<td><a href="#"  accesskey="m" onClick="dataHander('mod','basetrade_mod.jsp?czid=',dataNav.itemselect);">
		<img align="absmiddle" src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" width="19" height="19" align="absmiddle" ></a></td>

        <td><a href="#" accesskey="d" onClick="dataHander('del','basetrade_del.jsp?czid=',dataNav.itemselect);">
		<img align="absmiddle" src="../../images/sbtn_del.gif" alt="删除(Alt+D)" ></a></td>
		
		<!-- 翻页控制 -->
		<td align="right" width="100%">
		</td><!-- 翻页结束 -->
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>款项方式</th>
     <th>款项内容</th>
     <th>序号</th>
     <th>收/付款人</th>
     <th>收/付款人账号</th>
     <th>收支时间</th>
     <th>币种</th>
     <th>收/付款金额</th>
     <th>结算方式</th>
     <th>备注</th>
     <th>操作</th>
     
     <th>款项方式</th>
     <th>款项内容</th>
     <th>序号</th>
     <th>收/付款人</th>
     <th>收/付款人账号</th>
     <th>收支时间</th>
     <th>币种</th>
     <th>收/付款金额</th>
     <th>结算方式</th>
     <th>备注</th>
     <th>操作</th>
     
     <th>款项方式</th>
     <th>款项内容</th>
     <th>序号</th>
     <th>收/付款人</th>
     <th>收/付款人账号</th>
     <th>收支时间</th>
     <th>币种</th>
     <th>收/付款金额</th>
     <th>结算方式</th>
     <th>备注</th>
     <th>操作</th>
   </tr>
   <tbody id="dataNew">
     <tr>
     	<td>收款</td>
     	<td>首付款</td>
     	<td>1</td>
     	<td>张三</td>
     	<td>3423478787878</td>
     	<td>2011-06-12</td>
     	<td>人民币</td>
     	<td>450,33</td>
     	<td>电汇</td>
     	<td>无</td>
     	<td>修改|删除</td>
     	
     	<td>收款</td>
     	<td>首付款</td>
     	<td>1</td>
     	<td>张三</td>
     	<td>3423478787878</td>
     	<td>2011-06-12</td>
     	<td>人民币</td>
     	<td>450,33</td>
     	<td>电汇</td>
     	<td>无</td>
     	<td>修改|删除</td>
     	
     	
     	<td>收款</td>
     	<td>首付款</td>
     	<td>1</td>
     	<td>张三</td>
     	<td>3423478787878</td>
     	<td>2011-06-12</td>
     	<td>人民币</td>
     	<td>450,33</td>
     	<td>电汇</td>
     	<td>无</td>
     	<td>修改|删除</td>
     </tr>
     <tr>
     	<td>收款</td>
     	<td>手续费</td>
     	<td>1</td>
     	<td>张三</td>
     	<td>3423478787878</td>
     	<td>2011-06-12</td>
     	<td>人民币</td>
     	<td>440,33</td>
     	<td>电汇</td>
     	<td>无</td>
     	<td>修改|删除</td>
     </tr>
     <tr>
     	<td>付款</td>
     	<td>设备金额</td>
     	<td>1</td>
     	<td>环球租赁</td>
     	<td>38773434444787878</td>
     	<td>2011-09-12</td>
     	<td>人民币</td>
     	<td>12,450,33</td>
     	<td>电汇</td>
     	<td>无</td>
     	<td>修改|删除</td>
     </tr>
     </tbody>
</table>
</div>

</div><!-- 结束资金计划div -->

<!-- 资金付款前提 -->
<div style="margin-top: 50px;">

<div id="cwTop">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
		<tr class="tree_title_txt">
			<td nowrap width="100%" class="tree_title_txt" valign="middle">
			资金付款前提</td>
		</tr>
</table> 
</div>
<!-- end cwTop -->

<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">

		<td><a href="#" accesskey="n" onClick="dataHander('add','basetrade_add.jsp',dataNav.itemselect);">
		<img align="absmiddle" src="../../images/sbtn_new.gif" alt="新增(Alt+N)"></a>

		<td><a href="#"  accesskey="m" onClick="dataHander('mod','basetrade_mod.jsp?czid=',dataNav.itemselect);">
		<img align="absmiddle" src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" width="19" height="19" align="absmiddle" ></a></td>

        <td><a href="#" accesskey="d" onClick="dataHander('del','basetrade_del.jsp?czid=',dataNav.itemselect);">
		<img align="absmiddle" src="../../images/sbtn_del.gif" alt="删除(Alt+D)" ></a></td>
		
		<!-- 翻页控制 -->
		<td align="right" width="100%">
		</td><!-- 翻页结束 -->
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>款项内容</th>
     <th>序号</th>
     <th>收支时间</th>
     <th>币种</th>
     <th>付款金额</th>
     <th>结算方式</th>
     <th>备注</th>
     <th>付款前提</th>
     <th>操作</th>
   </tr>
     <tr>
     	<td>设备金额</td>
     	<td>1</td>
     	<td>2011-09-12</td>
     	<td>人民币</td>
     	<td>12,450,33</td>
     	<td>电汇</td>
     	<td>无</td>
     	<td>
     	发票类<br>
     	资金收款收据&nbsp;&nbsp;
     	<input class="rd" type="radio" name="sfsd" value="已收">已收
     	<input class="rd" type="radio" name="sfsd" value="未收">未收
     	<input class="rd" type="radio" name="sfsd" value="收不到">收不到
     	<br>
     	</td>
     	<td>修改|删除</td>
     </tr>
</table>
</div>

</div><!-- 结束资金付款前提div -->

</body>
</html>
