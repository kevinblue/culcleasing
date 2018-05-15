<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>管理费划转信息统计表 </title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">


</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">
<form action="proj_manage_fee_transfer_list.jsp" name="dataNav" onSubmit="return goPage()" method="post">

<input type="hidden" name="type" value="updStatus">
<input type="hidden" name="itemStr">
<input type="hidden" name="itemIdStr">
<!-- 资金计划数据 -->

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		管理费划转信息统计表（合并）</td>
	</tr>
</table> 

<%
wherestr = "";
String sqlstrCou="";
String proj_name = getStr( request.getParameter("proj_name") );
String proj_id = getStr( request.getParameter("proj_id") );
String tranfer_date_start = getStr( request.getParameter("tranfer_date_start") );
String tranfer_date_end = getStr( request.getParameter("tranfer_date_end") );

if ( proj_id!=null && !proj_id.equals("") ) {
	wherestr += " and proj_id like '%" + proj_id + "%'";
}
if ( proj_name!=null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}

if(tranfer_date_start!=null && !"".equals(tranfer_date_start) && tranfer_date_end!=null && !"".equals(tranfer_date_end)){
	wherestr +=" and tranfer_date >= '"+tranfer_date_start+"' and tranfer_date<='"+tranfer_date_end+"'";
}
if(tranfer_date_start!=null && !"".equals(tranfer_date_start) && "".equals(tranfer_date_end)){
	wherestr +=" and tranfer_date >= '"+tranfer_date_start+"'";
}
if("".equals(tranfer_date_start) && tranfer_date_end!=null && !"".equals(tranfer_date_end)){
	wherestr +=" and tranfer_date <='"+tranfer_date_end+"'";
}

//2013-08-02新增查询条件
countSql = "select count(proj_id) as amount from vi_management_tranfer_info_comb where 1=1 "+wherestr;

//导出类型2--数据导出

	String expsqlstr = "select proj_id as '项目编号' "
	+" , project_name as '项目名称' ,dept as '部门'"
	+" , region as '大区' ,project_manager as '项目经理'"
	+",cast(round(management_fee,2) as numeric(20,2)) as '管理费'"
	+",tranfer_date as '划转日期' "
	+" from vi_management_tranfer_info_comb  where 1=1 "+ wherestr+" order by tranfer_date";
	

String updSql="select proj_id from vi_management_tranfer_info_comb where 1=1 "+ wherestr;

%>
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>项目名称：&nbsp;<input name="proj_name"  type="text" size="15" value="<%=proj_name %>"></td>
<td>项目编号：&nbsp;<input name="proj_id"  type="text" size="15" value="<%=proj_id %>"></td>
<td scope="row">管理费划转日期：
晚于<input type="text" id="tranfer_date_start" name="tranfer_date_start"
	 readonly="readonly" 
	 value="<%=tranfer_date_start %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
 早于<input type="text" id="tranfer_date_end" name="tranfer_date_end"
	 readonly="readonly" 
	value="<%=tranfer_date_end %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
</td>


</tr>

<tr>




</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td align="right"> <input type="button" value="查询" onclick="dataNav.submit();">
<input type="button" value="清空" onclick="clearQuery();" ></td>
</tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->
<!--可折叠查询开始-->

<!-- end cwTop -->
<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
		
		<td>
		<!--操作按钮开始-->
		<!--<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
		<input name="updsql" type="hidden" value="<%=updSql %>">
		<input name="excel_name" type="hidden" value="ProjBeforeMeeting">
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','proj_before_meet_list.jsp');">
		<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>
		-->
	   <!--操作按钮结束-->
	    </td>		

		<!-- 翻页控制 -->
		<td width="60%" align="right"><!--翻页控制开始-->
		<!-- 翻页控制开始 -->
		<%@ include file="../../public/pageSplit.jsp"%>
		<!--翻页控制结束-->
		</td><!-- 翻页结束 -->

		
</tr>
</table>

<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	  <th align="center">序号</th>
	    
	    <th>项目编号</th>
	    <th>项目名称</th>
	    <th>部门</th>
	    <th>大区</th>
	 	<th>项目经理</th>
		<th>管理费</th>
	 	<th>划转日期</th>
      </tr>
   <tbody id="data">
<%

String col_str="*"; 
sqlstr ="select top  "+ intPageSize +" * from vi_management_tranfer_info_comb where id not in(select top  "+ (intPage-1)*intPageSize +" id from vi_management_tranfer_info_comb ";
sqlstr += " where 1=1 "+wherestr+"  order by  tranfer_date )"+wherestr ;  
sqlstr +=" order by tranfer_date";





rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
index_no++;
%>   
     <tr class="materTr_<%=index_no %>">
		<td><%=index_no %></td>
        <td align="left"><%=getDBStr(rs.getString("proj_id"))%></td>
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("dept"))%></td>
		<td align="left"><%=getDBStr(rs.getString("region"))%></td>
	    <td align="left"><%=getDBStr(rs.getString("project_manager"))%></td>		
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("management_fee"))%></td>	
		<td align="left"><%=getDBDateStr(rs.getString("tranfer_date"))%></td>				
      </tr>
<%}

sqlstrCou ="select top "+ intPageSize +" sum(management_fee) summanagement_fee from vi_management_tranfer_info_comb where id not in(select top "+ (intPage-1)*intPageSize +" id from ";
sqlstrCou += "vi_management_tranfer_info_comb where 1=1 "+wherestr+"  )"+wherestr ;  



rs = db.executeQuery(sqlstrCou);

	while ( rs.next() ) {
				index_no++;	
			%>
		 <tr class="materTr_<%=index_no %>"  bgcolor="#FF0000">
		<td></td>
        <td align="left">总计：</td>
        <td align="left"></td>
        <td align="left"></td>
		<td align="left"></td>
	    <td align="left"></td>
		<td align="left">总计：<%=CurrencyUtil.convertFinance(rs.getString("summanagement_fee"))%></td>
		<td align="left"></td>		
      </tr>	
	 
			<%
	}		
			System.out.println("test=========="+index_no);
rs.close();
db.close();
%>     
     </tbody>
</table>
</div>
</form>

</body>
</html>
