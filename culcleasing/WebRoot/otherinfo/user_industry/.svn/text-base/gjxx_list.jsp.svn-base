<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>行业区域维护</title>
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

<%
wherestr = "";
String searchKey = getStr(request.getParameter("searchKey"));
if ( searchKey!=null && !"".equals(searchKey))
{
   wherestr += " and b.board_name like '%"+searchKey+"%' "; 
}

%>

<body onLoad="public_onload(0)">
<!-- text="#000000" bgcolor="#FFFFFF" topmargin=0 leftmargin=0 class=menu style='border:1px solid #8DB2E3;margin:0px;' -->

<form action="gjxx_list.jsp" name="dataNav" onSubmit="return goPage()">
<div id="cwTop">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
		<tr class="tree_title_txt">
			<td nowrap width="100%" class="tree_title_txt" valign="middle">
			行业区域维护</td>
		</tr>
</table> 
</div>
<!-- end cwTop -->

<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<td nowrap>行业名称：
              <input name="searchKey" accesskey="s" type="text" size="15" value="<%=searchKey %>">
              <input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="dataNav.submit();">
          </td>
		
		<td><a href="#" accesskey="m" onClick="dataHander('mod','gjxx_mod.jsp?id=',dataNav.itemselect);">
		<img align="absmiddle" src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" width="19" height="19" align="absmiddle" ></a></td>
		
		
		<!-- 翻页控制 -->
		<td align="right" width="100%">
		<%
		sqlstr = "select b.id,b.trade,b.board_name,b.code,v.respon_provice_title,dbo.getusername(v.modificator) as gxr,v.modify_date from base_trade b left join base_trade_respons v on b.code=v.trade_code where 1=1 "+wherestr+" order by b.code asc"; 
		LogWriter.logDebug(request, "客户行业区域维护--@@@@@@@"+sqlstr);
		%>
		
		<%@ include file="../../public/pageSplitNoCode.jsp"%>
		</td><!-- 翻页结束 -->
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th width="1%"></th>
     <th>编号</th>
     <th>行业名称</th>
     <th>负责省份</th>
     <th>维护人员</th>
     <th>更新日期</th> 
   </tr>
   <tbody id="data">
<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
     <tr>
      <td><input class="rd" type="radio" name="itemselect" value="<%=getDBStr(rs.getString("code"))%>">
      </td>
	  <td><%=getDBStr(rs.getString("code"))%></td>
      <td><%=getDBStr(rs.getString("board_name"))%></td>
      <td><%=getDBStr(rs.getString("respon_provice_title"))%></td>
      <td><%=getDBStr(rs.getString("gxr"))%></td>
      <td><%=getDBDateStr(rs.getString("modify_date"))%></td>
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
