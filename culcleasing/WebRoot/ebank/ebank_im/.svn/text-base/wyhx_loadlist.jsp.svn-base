<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>网银挂账 - 网银数据上传</title>
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

<form action="wyhx_loadlist.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		网银挂账 &gt; 网银数据上传</td>
	</tr>
</table>
<!--标题结束-->

<%
wherestr = "";

String uploader = getStr( request.getParameter("uploader") );
String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));

if ( uploader!=null && !uploader.equals("") ) {
	wherestr += " and dbo.GETUSERNAME(creator) like '%" + uploader + "%'";
}
if(start_date!=null && !"".equals(start_date)){
	wherestr+=" and convert(varchar(10),upload_time,21)>='"+start_date+"' ";
}
if(end_date!=null && !"".equals(end_date)){
	wherestr+=" and convert(varchar(10),upload_time,21)<='"+end_date+"' ";
}

countSql = "select count(id) as amount from fund_ebank_imp where 1=1 "+wherestr;

%>

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>上传人:&nbsp;<input name="uploader"  type="text" size="15" value="<%=uploader %>"></td>
<td>上传日期:&nbsp;
<input name="start_date" type="text" size="10" readonly dataType="Date" value="<%=start_date %>">
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
&nbsp;至&nbsp;
<input name="end_date" type="text" size="10" readonly dataType="Date" value="<%=end_date %>">
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
	<table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
			<td ><a href="#" accesskey="n" onClick="dataHander('add_modal','wyhx_upload.jsp',dataNav.itemselect);">
			<img align="absmiddle"  src="../../images/sbtn_quick_up.gif" alt="上传网银文件" align="absmiddle">上传网银数据</a></td>
			<%-- 
			<td><a href="#" accesskey="n" onClick="dataHander('add_modal','../ebank/ebankHl/ebankHl_save.jsp',dataNav.itemselect);">
			<img align="absmiddle"  src="../../images/sbtn_new.gif" alt="生成财务凭证" align="absmiddle">生成财务凭证</a></td>
			--%>
	    </tr>
	</table>
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
	    <th>上传编号</th>
	    <th>上传日期</th>
	    <th>文件</th>
	    <th>上传总金额</th>
	    <th>上传总记录数</th>
	    <th>上传人</th>
	    <th>操作</th>
	    <th>状态</th>
      </tr>
      <tbody id="data">
<%
String col_str="id,up_id,upload_time,file_name,file_path,sum_fact_money,count_fact_imp,creator_name=dbo.GETUSERNAME(creator),create_date,modificator_name=dbo.GETUSERNAME(modificator),modify_date,flag";

sqlstr = "select top "+ intPageSize +" "+col_str+" from fund_ebank_imp where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from fund_ebank_imp where 1=1 "+wherestr+" order by upload_time desc ) "+wherestr ;
sqlstr +=" order by upload_time desc ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
		<td align="center"><%= getDBStr( rs.getString("up_id")) %></td>	
		<td align="center"><%= getDBDateStr( rs.getString("upload_time")) %></td>	
		<td align="center">
		<a target="_self" href="../ebank_data/ebank_data_list.jsp?up_id=<%=getDBStr( rs.getString("up_id")) %>">察看网银数据</a></td> 
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("sum_fact_money" )) %></td>	
		<td align="center"><%= CurrencyUtil.convertIntAmount( rs.getString("count_fact_imp" )) %></td>	
		<td align="center"><%= getDBStr( rs.getString("creator_name")) %></td>	
		<td align="center">
		<a target="_blank" href="file_download.jsp?file_path=<%=getDBStr(rs.getString("file_path")) %>&file_name=<%=getDBStr(rs.getString("file_name"))%>">
		下载文件</a></td>
		<td>

		<%
		String flag=getDBStr( rs.getString("flag"));
			if("".equals(flag)){
				%>
					<a href="wyhx_upflag.jsp?id=<%= getDBStr( rs.getString("id")) %>" target="_blank">操作结束</a>
				<%
			}else{
				%>
					已完成
				<%
			}
		 %>
		</td>
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
