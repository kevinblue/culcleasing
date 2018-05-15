<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同信息 - 合同查询</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT Language="Javascript" SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT Language="Javascript" SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>
<%
String sqlstr;
ResultSet rs;
String wherestr = " where 1=1";

String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );

String industry_name = getStr( request.getParameter("industry_name") );
String equip_name = getStr( request.getParameter("equip_name") );
String contract_id = getStr( request.getParameter("contract_id") );
String cust_name = getStr( request.getParameter("cust_name") );
String proj_manage_name = getStr( request.getParameter("proj_manage_name") );
String status_name = getStr( request.getParameter("status_name") );
String start_date = getStr( request.getParameter("start_date") );
String end_date = getStr( request.getParameter("end_date") );

if(!industry_name.equals("")){
	wherestr+=" and ifelc_conf_dictionary.title like '%"+industry_name+"%'";
}
if(!equip_name.equals("")){
	wherestr+=" and ifelc_conf_dictionary2.title like '%"+equip_name+"%'";
}
if(!contract_id.equals("")){
	wherestr+=" and vi_contract_info.contract_id like '%"+contract_id+"%'";
}
if(!cust_name.equals("")){
	wherestr+=" and vi_contract_info.cust_name like '%"+cust_name+"%'";
}
if(!proj_manage_name.equals("")){
	wherestr+=" and vi_contract_info.proj_manage_name like '%"+proj_manage_name+"%'";
}
if(!status_name.equals("")){
	wherestr+=" and vi_contract_info.status_name like '%"+status_name+"%'";
}
if(!start_date.equals("")){
	wherestr+=" and vi_contract_info.actual_start_date >= '"+start_date+"'";
}
if(!end_date.equals("")){
	wherestr+=" and vi_contract_info.actual_start_date <= '"+end_date+"'";
}
sqlstr = "select vi_contract_info.contract_id,vi_contract_info.cust_name,ifelc_conf_dictionary.title as industry_name, ifelc_conf_dictionary2.title as equip_name, vi_contract_info.actual_start_date,vi_contract_info.status_name,vi_contract_info.proj_manage_name, vi_contract_info.equip_amt ,vi_contract_info.docurl from vi_contract_info left join ifelc_conf_dictionary on vi_contract_info.industry_type=ifelc_conf_dictionary.name left join ifelc_conf_dictionary ifelc_conf_dictionary2 on vi_contract_info.equip_type=ifelc_conf_dictionary2.name" + wherestr; 
System.out.println("sqlstr============================================="+sqlstr);
%>
<body onload="public_onload(0)">

<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle">
				合同信息 &gt; 合同查询</td>
			</tr>
</table>
<!--标题结束-->

<!--可折叠查询开始-->
<div style="width:100%;">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;高级操作
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<form name="searchbar" action="htxxcx_list.jsp">
<tr><td>内部行业<select name="industry_name"></select>
<script language="javascript">dict_list("industry_name","industry_type","<%=industry_name%>","title");</script></td>
<td>设备类型<select name="equip_name"></select>
<script language="javascript">dict_list("equip_name","equipment_type","<%=equip_name%>","title");</script></td>
<td>合同编号<input name="contract_id" type="text" value="<%=contract_id %>"></td>
<td>承租客户<input name="cust_name" type="text" value="<%=cust_name %>"></td>
</tr>
<tr>
<td>项目负责人<input name="proj_manage_name" type="text" value="<%=proj_manage_name %>"></td>
<td>合同状态<input name="status_name" type="text" size="20" value="<%=status_name %>" readonly><input type="hidden" name="status"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="OpenDataWindow('','','','','合同状态','base_contractstatus','status_name','status_code','status_name','status_name','asc','searchbar.status_name','searchbar.status');"></td>
<td>开始日期<input name="start_date" type="text" size="15" readonly dataType="Date" value="<%=start_date %>"><img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
<td>结束日期<input name="end_date" type="text" size="15" readonly dataType="Date" value="<%=end_date %>"><img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();"></td>
</tr>

</form></table>
</fieldset>
</div>
<!--可折叠查询结束-->



<!--副标题和操作区开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="1%">

<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		
		
    </tr>
</table>
<!--操作按钮结束-->
</td>
					 <td align="right" width="90%">
					 	
					 	
<!--翻页控制开始-->


<% 
	int intPageSize = 15;   //一页显示的记录数
	int intRowCount = 0;   //记录总数
	int intPageCount = 1; //总页数
	int intPage;       //待显示页码
	String strPage = getStr( request.getParameter("page") );          //取得待显示页码
	if( strPage.equals("") ){                                         //表明在QueryString中没有page这一个参数，此时显示第一页数据
	   intPage = 1;
	}else{
	   intPage = java.lang.Integer.parseInt(strPage);
	   if(intPage<1) intPage = 1;
	} 


rs = db.executeQuery(sqlstr); 


	rs.last();                                                  //获取记录总数
	intRowCount = rs.getRow();
	intPageCount = ( intRowCount + intPageSize - 1) / intPageSize;   //记算总页数
	if( intPage > intPageCount ) intPage = intPageCount;            //调整待显示的页码
	if( intPageCount > 0 )
	   rs.absolute( ( intPage-1 ) * intPageSize + 1 );              //将记录指针定位到待显示页的第一条记录上
	int i = 0;
	
%>

<form action="htxxcx_list.jsp" name="dataNav" onSubmit="return goPage()">
<input name="searchKey" type="hidden" value="<%= searchKey %>">
<input name="searchFld" type="hidden" value="<%= searchFld %>">

<input name="industry_name" type="hidden" value="<%= industry_name %>">
<input name="equip_name" type="hidden" value="<%= equip_name %>">
<input name="contract_id" type="hidden" value="<%= contract_id %>">
<input name="cust_name" type="hidden" value="<%= cust_name %>">
<input name="proj_manage_name" type="hidden" value="<%= proj_manage_name %>">
<input name="status_name" type="hidden" value="<%= status_name %>">
<input name="start_date" type="hidden" value="<%= start_date %>">
<input name="end_date" type="hidden" value="<%= end_date %>">
<table border="0" cellspacing="0" cellpadding="0">
  <tr class="maintab">
	<script>
		var cp = <%= intPage %>;
		var lp = <%= intPageCount %>;
		var nf = document.dataNav;
	</script>
    <td nowrap>共 <%=intRowCount%> 条 / <%=intPageCount%> 页 
	<%if(intPage>1){%>	<img align="absmiddle" style="cursor:pointer; " onClick="goPage('first')" src="../../images/ico_first.gif" alt="第一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('prev')" src="../../images/ico_prev.gif" alt="上一页"    border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_first.gif" alt="第一页"  border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_prev.gif" alt="上一页" border="0"><% } %>
	第 <font color="red"><%=intPage%></font> 页	
	<%if(intPage<intPageCount){%> <img align="absmiddle" style="cursor:pointer; " onClick="goPage('next')" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('last')" src="../../images/ico_last.gif" alt="最后页" border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_last.gif" alt="最后页" border="0"><% } %></td>
	
    <td nowrap><img align="absmiddle" src="../../images/sbtn_split.gif"></td>
    
    <td nowrap>转到 <input name="page" type="text" size="2" value="1"> 页 <img align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="执行" border="0" align="absmiddle"></td>
 </tr>
</table>

</td>
</tr>
</table>

<!--翻页控制结束-->


<!--报表开始-->

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv";>

   <table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th>合同号</th>
        <th>承租客户</th>
        <th>内部行业</th>
        <th>设备类型</th>
        <th>日期</th>
        <th>合同状态</th>
        <th>设备金额</th>
      </tr>
  

<%	
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr onmouseover="fn_changeTrColor()" onmouseout="fn_changeTrColor()">
		<td><a href="<%= getDBStr( rs.getString("docurl") ) %>" target="_blank"><%= getDBStr( rs.getString("contract_id") ) %></a></td>
		<td><%= getDBStr( rs.getString("cust_name") ) %></td>
		<td><%= getDBStr( rs.getString("industry_name") ) %></td>
		<td><%= getDBStr( rs.getString("equip_name") ) %></td>
		<td><%= getDBDateStr( rs.getString("actual_start_date") ) %></td>
		<td><%= getDBStr( rs.getString("status_name") ) %></td>
		<td><%= formatNumberStr(getDBStr( rs.getString("equip_amt") ),"#,##0.00") %></td>
      </tr>
<%
		rs.next();
		i++;
	}
}
rs.close(); 
db.close();
%>
    </table>
</div>
</form>

<!--报表结束-->

</body>
</html>
