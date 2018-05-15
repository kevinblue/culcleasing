<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="/public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>国内收款单同步数据-新增</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>


<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">

<form action="equip_data_sync.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		国内收款单同步数据 - 新增</td>
	</tr>
</table>
<!--标题结束-->

<%
String oper_id = getStr(request.getParameter("oper_id"));

//查询同步信息
String oper_name = "";
String oper_date = "";
String partSql = "select oper_id,oper_type,oper_name,oper_remark,oper_date,update_amount,insert_amount from CRM_ERP_DATA_SYNC_LOG";
partSql+=" where oper_id='"+oper_id+"' ";
rs = db.executeQuery(partSql);
if(rs.next()){
	oper_name = getDBStr(rs.getString("oper_name"));
	oper_date = getDBDateStr(rs.getString("oper_date"));
}
rs.close();

//同步数据信息
wherestr = "";

countSql = "Select count(id) as amount from Equip_Machine_Industry_Library where oper_id='"+oper_id+"' and equip_id in( ";
countSql+= "select pri_id from dbo.CRM_ERP_DATA_SYNC_INFO where oper_id='"+oper_id+"') "+wherestr;

%>
<br><br>
<!--可折叠查询开始-->
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
 <tr>
    <td style="font-size: 14px;">操作名称:&nbsp;&nbsp;<b style="color:#E46344;"><%=oper_name %></b></td>
    <td>&nbsp;</td>
    <td style="font-size: 14px;">操作时间:&nbsp;&nbsp;<b style="color:#E46344;"><%=oper_date %></b></td>
  </tr>
</table>
<br>
<!--可折叠查询结束-->

<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
	<td align="left" width="20%">
	<!--操作按钮开始-->
	<!--操作按钮结束-->
	</td>
	<td align="right" width="60%"><!--翻页控制开始-->
	<!-- 翻页控制开始 -->
	<%@ include file="../../public/pageSplit.jsp"%>
	<!--翻页控制结束-->	
	</td>		 	
 </tr>
</table>


<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th>设备Id</th>
        <th>设备中文简称</th>
        <th>设备英文简称</th>
        <th>设备名称</th>
        <th>设备型号</th>
        <th>生产商</th>
        <th>产地</th>
        <th>注册到期日</th>
      </tr>
      <tbody id="data">
<%
String col_str="id,equip_id,equip_short_zhcn_name,equip_short_eng_name,equip_name,equip_model,equip_manufacturer,equip_producing_area,equip_register_date,equip_expire_date,equip_remark,";
col_str+= "equip_flag,oper_id,creator,create_date,modificator,modify_date";

wherestr = " and oper_id='"+oper_id+"' and equip_id in( select pri_id from dbo.CRM_ERP_DATA_SYNC_INFO where oper_id='"+oper_id+"') "+wherestr;

sqlstr = "select top "+ intPageSize +" "+col_str+" from Equip_Machine_Industry_Library where 1=1 and id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from CRM_ERP_DATA_SYNC_LOG where 1=1 "+wherestr+" order by id ) "+wherestr ;
sqlstr += " order by id ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
		<td align="left"><%=getDBStr( rs.getString("equip_id")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("equip_short_zhcn_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("equip_short_eng_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("equip_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("equip_model")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("equip_manufacturer")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("equip_producing_area")) %></td>	
		<td align="center"><%=getDBDateStr( rs.getString("equip_expire_date")) %></td>	
      </tr>
<%
}
rs.close(); 
db.close();
%>
</tbody></table>
</div><!--报表结束-->

</form>
</body>
</html>
