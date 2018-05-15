<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资金收付计划单个同步</title>
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

<form action="people_transfer_zjjh_to_yy.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		资金收付计划单个同步</td>
	</tr>
</table>
<!--标题结束-->

<%
wherestr = "";

//本页查询参数
String project_name = getStr( request.getParameter("project_name") );

if ( project_name!=null && !"".equals(project_name) ) {
	wherestr += " and vfp.pcode like '%" + project_name + "%'";
}

String proj_id = getStr( request.getParameter("proj_id") );

if ( proj_id!=null && !"".equals(proj_id) ) {
	wherestr += " and vfp.picode like '%" + proj_id + "%'";
}

String start_date = getStr(request.getParameter("start_date"));//必填字段
String end_date = getStr(request.getParameter("end_date"));//必填字段
if(start_date!=null && !"".equals(start_date) && end_date!=null && !"".equals(end_date)){
	wherestr += " and convert(varchar(10),vfp.odate,21)>='"+start_date+"'";
	wherestr += " and convert(varchar(10),vfp.odate,21)<='"+end_date+"'";
	System.out.println("start_date测试" + start_date);
}
countSql = "select count(vfp.id) as amount from vi_INTERFACE_fina_global_fundplan_nc vfp where 1=1 and vfp.odate>='2017-07-01' "+wherestr;
//剩余金额>0
%>

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<td>项目名称:&nbsp;<input name="project_name"  type="text" size="30" value="<%=project_name %>"></td>
<td>项目编号:&nbsp;<input name="proj_id"  type="text" size="30" value="<%=proj_id %>"></td>

<td>日期查询:&nbsp;<input name="start_date" type="text" size="10" readonly dataType="Date"><span class="biTian">*</span>
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
&nbsp;至&nbsp;
<input name="end_date" type="text" size="10" readonly dataType="Date"><span class="biTian">*</span>
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td>
<input type="button" value="查询" onclick="dataNav.submit();">
&nbsp;&nbsp;
<input type="button" value="清空" onclick="clearQuery();" >
</td>
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
	    <th>序号</th>
        <th>项目编号</th>	 	
	 	<th>合同号</th>
	 	<th>项目名称</th>
	 	 <th>租赁类型</th>
	    <th>承租客户</th>
	    <th>收/付款人</th>
	    <th>款项内容</th>
	    <th>税种</th>
		<th>金额</th>
		<th>计划日期</th>
		<th>同步</th>             
      </tr>
      <tbody id="data">
<%
String col_str="id,ccodetrust,picode,ccode,remark,bcode,leas_type,remark_o,pcode,ordcode,rmb,odate,nccode,nc_deptno";
int i=1;
sqlstr = "SELECT top "+ intPageSize +" "+col_str+" FROM vi_INTERFACE_fina_global_fundplan_nc vfp WHERE vfp.odate>='2017-07-01' and  vfp.id not in(select top "+ (intPage-1)*intPageSize +" vfp.id from vi_INTERFACE_fina_global_fundplan_nc vfp  where 1=1 and vfp.odate>='2017-07-01' "+wherestr+"  )  ";
sqlstr += "and isnull(invcode,'')<>'' AND isnull(ccode,'')<>'' AND isnull(ccodetrust,'')<>''  and isnull(bcode,'')<>'' and isnull(invtype,'')<>'' and ccodetrust<>'null'"+wherestr;
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
        <td align="center"><%=i%></td>
         <td align="left"><%=getDBStr(rs.getString("picode"))%></td>
         <td align="left"><%=getDBStr(rs.getString("ordcode"))%></td>
         <td align="left"><%=getDBStr(rs.getString("pcode"))%></td>	
         <td align="left"><%=getDBStr(rs.getString("leas_type"))%></td>	
         <td align="left"><%=getDBStr(rs.getString("ccodetrust"))%></td>
		 <td align="left"><%=getDBStr(rs.getString("bcode"))%></td>	
         <td align="left"><%=getDBStr(rs.getString("remark"))%></td>
         <td align="left"><%=getDBStr(rs.getString("remark_o"))%></td>        			
		 <td align="left"><%=getDBStr(rs.getString("rmb"))%></td>
		 <td align="left"><%=getDBStr(rs.getString("odate"))%></td>
		 <td align="left">
			<a href='fundplan_info_add.jsp?proj_id=<%=getDBStr(rs.getString("picode"))%>&id=<%=getDBStr(rs.getString("id"))%>' target="_blank">
	    <img src="../../images/sbtn_quick_up.gif" align="bottom" border="0">单个执行同步</a>
     	<a href=""></a>
		 </td>
      </tr>
<%
i++;
}
rs.close(); 
db.close();
%>
</tbody></table>
</div><!--报表结束-->

</form>
</body>
</html>
