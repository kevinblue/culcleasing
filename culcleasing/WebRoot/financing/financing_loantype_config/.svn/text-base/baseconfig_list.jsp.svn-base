<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>贷款类型 - 融资基础信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->


<body onLoad="public_onload(0)">

<form action="baseconfig_list.jsp" name="dataNav" onSubmit="return goPage()">
<div id="cwTop">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
		<tr class="tree_title_txt">
			<td nowrap width="100%" class="tree_title_txt" valign="middle">
			融资基础信息管理&gt;贷款类型</td>
		</tr>
</table> 
</div>
<!-- end cwTop -->

<%
wherestr="";
String searchKey=getStr(request.getParameter("searchKey"));


if ( searchKey!=null && !"".equals(searchKey) ) {
	wherestr += " and loan_name like '%" + searchKey + "%'";
}
%>

<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<td nowrap>类型名称：
              <input name="searchKey" accesskey="s" type="text" size="15" value="<%=searchKey %>">
              <input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle" onclick="dataNav.submit();">
          </td>

		<td><a href="#" accesskey="n" onClick="dataHander('add','baseconfig_add.jsp',dataNav.itemselect);">
		<img align="absmiddle" src="../../images/sbtn_new.gif" alt="新增(Alt+N)"></a></td>

		<td><a href="#"  accesskey="m" onClick="dataHander('mod','baseconfig_mod.jsp?czid=',dataNav.itemselect);">
		<img align="absmiddle" src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" width="19" height="19" align="absmiddle" ></a></td>

        <td><a href="#" accesskey="d" onClick="dataHander('del','baseconfig_del.jsp?czid=',dataNav.itemselect);">
		<img align="absmiddle" src="../../images/sbtn_del.gif" alt="删除(Alt+D)" ></a></td>
		
		<!-- 翻页控制 -->
		<td align="right" width="100%">
		<%
			sqlstr = "Select financing_config_loantype.*,dbo.GETUSERNAME(creator) as oper_name from financing_config_loantype where 1=1 "+wherestr+"order by id asc"; 
			LogWriter.logDebug(request, "输出sql:"+sqlstr);
		%>
		
		<%@ include file="../../public/pageSplitNoCode.jsp"%>
		</td><!-- 翻页结束 -->
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th width="1%"></th>
     <th>贷款类型编号</th>
     <th>贷款类型名称</th>
     <th>还款方式</th>
     <th>最后更新日期</th>
     <th>操作员</th>
   </tr>
   <tbody id="data">
<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
     <tr>
      <td><input class="rd" type="radio" name="itemselect" value="<%=getDBStr(rs.getString("id"))%>"></td>
	  <td align="center"><%=getDBStr(rs.getString("code"))%></td>
	  <td align="center"><%=getDBStr(rs.getString("loan_name"))%></td>
      <td align="center">
	      <a href="baseconfig.jsp?czid=<%=getDBStr(rs.getString("code"))%>" target="_blank">
	      查看</a>
      </td>
      <td align="center"><%=getDBDateStr(rs.getString("modify_date"))%></td>
      <td align="center"><%=getDBStr(rs.getString("oper_name"))%></td>
    </tr>
<%
		rs.next();
		i++;
	}
}
rs.close(); 
db.close();
%>
</tbody>
</table>
</div>

</form>
</body>
</html>
