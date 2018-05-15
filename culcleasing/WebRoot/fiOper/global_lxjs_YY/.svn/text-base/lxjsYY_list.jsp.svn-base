<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>利息计税（营业税）查询</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function waitSub(){
	//判断必填项是否填写
	var sD = $(":input[name='start_date']").val();
	var eD = $(":input[name='end_date']").val();
	
	if(sD=="" || eD==""){
		alert("查询时间段必须填写！！");
		return false;
	}else{
		dataNav.submit();
	}
}
//是否全选
function SelectAll(){
	var checkboxs=document.getElementsByName("list");
	var all=document.getElementsByName("all");
	all.checked=!all.checked;
	for (var i=0;i<checkboxs.length;i++) {
	var e=checkboxs[i];
	e.checked=!e.checked;
 }
	}
//导入
function  getList(){
	//得到复选框的集合
	var sqlIds="";
 	//var check_amount=0;//选中行的数量
	$("input[name^='list']:checked").each(function(){
		var id = $(this).attr("value");
		sqlIds += "'"+ id +"',";

		

		
	});
	//alert(sqlIds);
	$("#sqlIds").val(sqlIds.substring(0,sqlIds.length-1));
	dataNav.action="data_sync.jsp";
			dataNav.target="_blank"
			dataNav.submit();
			//dataNav.action="bjjs_list.jsp";
			//dataNav.target="_self"
}
</script>
</head>


<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">

<form action="lxjsYY_list.jsp" name="dataNav" onSubmit="return goPage()" method="post">
<input id="sqlIds" name="sqlIds" type="hidden" >
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		利息计税（营业税）查询</td>
	</tr>
</table>
<!--标题结束-->

<%
wherestr = " ";

//本页查询参数
String project_name = getStr( request.getParameter("project_name") );
//String is_first = getStr( request.getParameter("is_first") );
//System.out.println("is_first：" + is_first);
String start_date = getStr(request.getParameter("start_date"));//必填字段
String end_date = getStr(request.getParameter("end_date"));//必填字段
//拼接查询
if(project_name!=null && !"".equals(project_name)){
	wherestr+=" and project_name like '%"+project_name+"%' ";
}
//if(is_first!=null && !"".equals(is_first) && is_first.equals("是")){
//	wherestr+=" and rent_list=1";
//}

//查询时间段是否影响显示的数据 - 列出所有项目不受时间影响

if(start_date!=null && !"".equals(start_date) && end_date!=null && !"".equals(end_date)){
	wherestr += " and convert(varchar(10),plan_date,21)>='"+start_date+"'";
	wherestr += " and convert(varchar(10),plan_date,21)<='"+end_date+"'";
	System.out.println("start_date测试" + start_date);
}
countSql = "select count(id) as amount from vi_INTERFACE_fina_global_lxjs_YY_nc where 1=1 "+ wherestr;

%>

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>

<%-- <td>
付款方式:&nbsp;<select name="period_type" style="width:115px;">
  <script type="text/javascript">
   	w(mSetOpt('<%=period_type%>',"|期初|期末","|期初|期末"));
  </script>
</select>
</td>
<td>
是否第一期:&nbsp;<select name="is_first" style="width:115px;">
  <script type="text/javascript">
   	w(mSetOpt('<%=is_first%>',"|是|否","|是|否"));
  </script>
</select>
</td> --%>

<td>日期查询:&nbsp;<input name="start_date" type="text" size="10" readonly dataType="Date" value="<%=start_date%>"><span class="biTian">*</span>
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
&nbsp;至&nbsp;
<input name="end_date" type="text" size="10" readonly dataType="Date" value="<%=end_date%>"><span class="biTian">*</span>
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td>项目名称:&nbsp;<input name="project_name" type="text" size="10" value="<%=project_name %>" ></td>
<td><input type="button" value="查询" onclick="waitSub()"></td>
<td><input type="button" value="清空" onclick="clearQuery();" ></td>
</tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->

<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
<td align="left" width="20%">
	<!--操作按钮开始-->
	<table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
		    <td><a href="#" accesskey="n" onClick="getList();">
			<img align="absmiddle"  src="../../images/sbtn_quick_up.gif" alt="执行同步" align="absmiddle">执行同步</a></td>
	    </tr>
	</table>
	<!--操作按钮结束-->
	</td>
	<td align="right" width="60%">
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
		<th align="center"><input type="checkbox" name="all" id="all" style="border:0px;" checked="checked"  onclick="SelectAll()">全/反选</th>
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
		<th>付款方式</th>
		<!-- <th>是否导入</th> -->
		 </tr>
      <tbody id="data">
	<%

	sqlstr = "select top "+ intPageSize +" * from vi_INTERFACE_fina_global_lxjs_YY_nc where id not in( ";
	sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_INTERFACE_fina_global_lxjs_YY_nc where 1=1 "+wherestr+" order by contract_id )  "+wherestr ;
	sqlstr += " order by contract_id ";
	System.out.println("222"+sqlstr);
	%>
	<%-- <tr><td colspan="100"><%=sqlstr %></td></tr> --%>
	<%
	rs = db.executeQuery(sqlstr);
	while(rs.next()){
	%>
		
     
      <tr>
		<td  align="center"><input type="checkbox" name="list" value="<%=rs.getInt("id")%>" style="border:0px;" checked="checked"></td>	
		<td align="left"><%=getDBStr( rs.getString("proj_id")) %></td>	
		<td align="left"><%=getDBStr( rs.getString("contract_id")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("begin_id")) %></td>	
		<td align="left"><%=getDBStr( rs.getString("project_name")) %></td>	
		<td align="left"><%=getDBStr( rs.getString("parent_deptname")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("dept_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("cust_name")) %></td>	

		<td align="center"><%=getDBStr( rs.getString("board_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("proj_manage_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("leas_type")) %></td>	
		<td align="center"><%= getDBStr( rs.getString("rent_list" )) %></td>	
		<td align="center"><%=getDBDateStr( rs.getString("plan_date")) %></td>	
		<td align="center"><%= getDBDateStr( rs.getString("hire_date" )) %></td>
		<td align="center"><%=getDBStr( rs.getString("rent")) %></td>	

		<td align="center"><%=getDBStr( rs.getString("curr_rent")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("rent_diff")) %></td>
		<td align="center"><%=getDBStr( rs.getString("corpus")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("curr_corpus")) %></td>	
		<td align="center"><%= getDBStr( rs.getString("interest" )) %></td>	
		<td align="center"><%=getDBStr( rs.getString("curr_interest")) %></td>	
		<td align="center"><%= getDBStr( rs.getString("plan_status" )) %></td>

		<td align="center"><%=getDBStr( rs.getString("tax_type")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("plan_bank_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("factoring")) %></td>	
		<td align="center"><%= getDBStr( rs.getString("period_type" )) %></td>	
		

		
      </tr>
<%
		
	
}
rs.close(); 
db.close();
System.out.println("lxjsYY_list.jsp");
%> 
</tbody></table>
</div><!--报表结束-->

</form>
</body>

</html>
