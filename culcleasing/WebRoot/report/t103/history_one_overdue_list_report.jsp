<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/headImport.jsp"%>

<!-- 05.002 -->
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<meta http-equiv="Expires" content="3600"><!-- 缓存1小时 -->
	<title>代理商逾期统计 - 一期历史逾期</title>
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
	<script src="../../js/delitem.js"></script>

	<script Language="Javascript" src="../../js/jquery.js"></script>
	<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
	<script type="text/javascript" src="../../js/stleasing_function.js"></script>
	<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
	<style type="text/css">
	.tbodyStyle {
		color:#10418C;
		font-weight:500;
	}
	tfoot tr td {
		color:#E74100;
		font-weight:550;
	}
	</style>
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
<form action="history_one_overdue_list_report.jsp" name="dataNav" onSubmit="return goPage()">
<input type="hidden" name="excel_name" value="one_overdue">

<%
wherestr=" and 1=1 ";

String curr_date = getSystemDate(0);
String dld_name = getStr(request.getParameter("dld_name"));

if(dld_name!=null && !"".equals(dld_name)){
	wherestr+=" and khjc like '%"+dld_name+"%'";
}

int year = getInt(request.getParameter("cho_year"), getCurrentDatePart(1));
int month = getInt(request.getParameter("cho_month"), getCurrentDatePart(2)-1);

countSql = "select count(*) as amount from report_one_overdue where overdueProjAmount>0 and year(create_date)= "+year+" and month(create_date)="+month+filterAgent+wherestr;

//导出类型1
String exesqlstr1 = "select qy 区域,khmc 代理店全称,khjc 代理店简称,cast(overdueProjAmount as decimal) 一期逾期项目数量,cast(overdueEquipAmount as decimal) 一期逾期设备数量 from report_one_overdue where agent_id in ";

//导出类型2--数据导出
String exesqlstr2 = "select qy 区域,khmc 代理店全称,khjc 代理店简称,cast(overdueProjAmount as decimal) 一期逾期项目数量,cast(overdueEquipAmount as decimal) 一期逾期设备数量 from report_one_overdue where overdueProjAmount>0 and year(create_date)= "+year+" and month(create_date)="+month+filterAgent+wherestr+"order by overdueProjAmount desc,bmid";

%>	
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
			代理商逾期统计 &gt;<font color="color:red;"> <%=year %>年<%=month %>月</font>&gt; 一期逾期
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
<td><input name="dld_name" type="text" size="11" value="<%=dld_name %>"></td>
<td>选择年份</td>
<td>
<select name="cho_year">
<script type="text/javascript">
for(var i=<%=getCurrentDatePart(1) %>;i><%=getCurrentDatePart(1)-5 %>;i--){
	document.write("<option value='"+i+"'>"+i+"</option>");
}
</script>
</select>
</td>
<td>选择月份</td>
<td>
<select name="cho_month">
<script type="text/javascript">
for(var i=1;i<=12;i++){
	document.write("<option value='"+i+"'>"+i+"</option>");
}
</script>
</select>
</td>

<td>
<input type="button" onclick="dataNav.submit()" value="查询">
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" onclick="clearQuery()" value="清空"></td>
</tr>

</table>
</fieldset>
<script type="text/javascript">
$("select[name='cho_year']").val(<%=year %>);
$("select[name='cho_month']").val(<%=month %>);
</script>
</div><!-- 查询条件结束 -->


<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
		<td align="left" width="1%">		
		<!--操作按钮开始-->
		<table border="0" cellspacing="0" cellpadding="0" >    
			<tr class="maintab">
				<td>
				<input type="hidden" id="export_type1" value="<%=exesqlstr1%>">
				<input type="hidden" id="export_type2" value="<%=exesqlstr2%>">

				<input name="expsqlstr" type="hidden">
				<BUTTON class="btn_2"  type="button" onclick="return validata_data_report_exp('../../func/exp_report.jsp','history_one_overdue_list_report.jsp');">
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

		<td align="right" width="90%">
		<!-- 翻页控制开始 -->
		<%@ include file="../../public/pageSplit.jsp"%>
		<!--翻页控制结束-->	 			
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
		<th>代理商全称</th>
        <th>代理商简称</th>
        <th>一期逾期项目数量</th>
        <th>一期逾期设备数量</th>
	</tr>
	<tbody id="data">
<%
int overdueProjAmount=0;
int overdueEquipAmount=0;

String col_str="qy,khmc,khjc,agent_id,overdueProjAmount,overdueEquipAmount";	  
sqlstr = "select top "+ intPageSize +" "+col_str+" from report_one_overdue where year(create_date)= "+year+" and month(create_date)="+month+" and overdueProjAmount>0 and bmid not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" bmid from report_one_overdue where  year(create_date)= "+year+" and month(create_date)="+month+" and overdueProjAmount>0 "+filterAgent+wherestr+" order by overdueProjAmount desc,bmid  ) "+filterAgent+wherestr;
sqlstr +=" order by overdueProjAmount desc,bmid ";

rs = db.executeQuery(sqlstr);
String item_id = "";
int startIndex = (intPage-1)*intPageSize+1;
while ( rs.next() ) {
	item_id = getDBStr( rs.getString("agent_id") );
	overdueProjAmount=rs.getInt("overdueProjAmount");
	overdueEquipAmount=rs.getInt("overdueEquipAmount");
%>
<tr>
	<td><input type="checkbox" name="list" item_id="<%=item_id %>"></td>
	<td align="center"><%=startIndex++ %></td>
	<td align="center"><%=getDBStr(rs.getString("qy"))%></td>
	<td align="left"><%=getDBStr(rs.getString("khmc"))%></td>
	<td align="left">
	<%=getDBStr(rs.getString("khjc")) %></td>
	<td align="center"><%=CurrencyUtil.convertIntAmount(overdueProjAmount) %></td>
	<td align="center"><%=CurrencyUtil.convertIntAmount(overdueEquipAmount) %></td>
</tr>
<% }
rs.close(); 
db.close();
%>  
</tbody>
</table>
</div><!--报表结束-->
</form>
</body>
</html>
