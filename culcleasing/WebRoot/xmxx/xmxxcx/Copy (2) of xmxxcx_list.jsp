<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>项目信息 - 项目查询</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT Language="Javascript" SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT Language="Javascript" SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>



<%
String dqczy=(String) session.getAttribute("czyid");
//----------以上为权限控制--------
String sqlstr;
String sqlstr1;
ResultSet rs;
ResultSet rs1;
boolean isExit1 = false;		//用于判断用户是否存在，存在为true,否则为false

sqlstr1="SELECT * FROM base_group_user_relation   WHERE group_id in ('ADMR-84RHXY','ADMR-83WDU6') and user_id= '"+dqczy+"' ";	//SQL语句
System.out.println("sqlstr============================================="+sqlstr1);

rs1 = db.executeQuery(sqlstr1);
rs1.previous();
if( rs1.next() ) {
	isExit1 = true;
}

rs1.close();

String wherestr = " where 1=1";



String proj_id = getStr( request.getParameter("proj_id") );
String proj_name = getStr( request.getParameter("proj_name") );
String cust_name = getStr( request.getParameter("cust_name") );
String manage_name = getStr( request.getParameter("manage_name") );
String status_name = getStr( request.getParameter("status_name") );
String industry_name = getStr( request.getParameter("industry_name") );
String equip_name = getStr( request.getParameter("equip_name") );
String branch = getStr( request.getParameter("branch") );
if(!proj_id.equals("")){
	wherestr+=" and vi_proj_info.proj_id like '%"+proj_id+"%'";
}
if(!proj_name.equals("")){
	wherestr+=" and vi_proj_info.project_name like '%"+proj_name+"%'";
}
if(!cust_name.equals("")){
	wherestr+=" and vi_proj_info.vi_cust like '%"+cust_name+"%'";
}
if(!manage_name.equals("")){
	wherestr+=" and vi_proj_info.vprojname like '%"+manage_name+"%'";
}
if(!status_name.equals("")){
	wherestr+=" and vi_proj_info.status_name like '%"+status_name+"%'";
}
if(!industry_name.equals("")){
	wherestr+=" and vi_proj_info.industry_typename='"+industry_name+"'";
}
if(!equip_name.equals("")){
	wherestr+=" and vi_proj_info.equip_type_title='"+equip_name+"'";
}
if(!branch.equals("")){
	wherestr+=" and vi_proj_info.vdeptname='"+branch+"'";
}
//分公司经理能看全部销售行政只能看自己的where条件
if ( isExit1 ) {
wherestr+="and (proj_manage in (select id from base_user where department in(select id from base_department where charIndex(vi_proj_info.vdeptname,dept_name)>0 and dept_manager='"+dqczy+"'))or proj_work='"+dqczy+"' )";}
else {wherestr+="and  1=1 ";}

sqlstr = "select * from vi_proj_info " + wherestr + " order by vi_proj_info.proj_id"; 
System.out.println("sqlstr============================================="+sqlstr);
%>
<body onLoad="public_onload(0);">
<form name="dataNav" action="xmxxcx_list.jsp">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				项目信息 &gt; 项目查询</td>
			</tr>
</table>
<!--标题结束-->

<!--可折叠查询开始-->
<div style="width:100%;">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;高级操作
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onClick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">

<tr>
<td>项目编号<input name="proj_id" size=15 type="text" value="<%=proj_id %>"></td>
<td>项目名称<input name="proj_name" size=15 type="text" value="<%=proj_name %>"></td>
<td>承租客户<input name="cust_name" size=15 type="text" value="<%=cust_name %>"></td>
<td>项目负责人<input name="manage_name" size=15 type="text" value="<%=manage_name %>"></td>
</tr>
<tr>
<td>项目状态<input name="status_name" type="text" size="15" value="<%=status_name %>" readonly><input type="hidden" name="status"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','合同状态','base_contractstatus','status_name','status_code','status_name','status_name','asc','dataNav.status_name','dataNav.status');"></td>
<td>内部行业<select name="industry_name"></select>
<script language="javascript">dict_list("industry_name","hapindustry","<%=industry_name%>","title");</script></td>
<td>分 公 司<select name="branch"></select>
<script language="javascript">dict_list("branch","branch","<%=branch%>","title");</script></td>
<td><input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="dataNav.submit();"></td>
</tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->

<!--副标题和操作区开始-->

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
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
String strsql;

ResultSet res;

boolean isExit = false;		//用于判断用户是否存在，存在为true,否则为false

strsql="SELECT * FROM base_group_user_relation   WHERE group_id='ADMR-84RGL8' and user_id= '"+dqczy+"' ";	//SQL语句
System.out.println("sqlstr============================================="+strsql);

res = db.executeQuery(strsql);
res.previous();
if( res.next() ) {
	isExit = true;
}

res.close();
%>


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

   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th>项目编号</th>
        <th>项目名称</th>
        <th>项目负责人</th>
        <th>承租客户</th>
        <th>分公司</th>
        <th>项目状态</th>
        <th>项目行业</th>
<%
	if( isExit )
	{
%>
       <th>项目信息</th>
<%
	}
%>
      </tr>
  

<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr>
        <td><%= getDBStr( rs.getString("proj_id") ) %></td>
		<td><%= getDBStr( rs.getString("project_name") ) %></td>
		<td><%= getDBStr( rs.getString("vprojname") ) %></td>
		<td><%= getDBStr( rs.getString("vi_cust") ) %></td>
        <td><%= getDBStr( rs.getString("vdeptname") ) %></td>
		<td><%= getDBStr( rs.getString("status_name") ) %></td>
		<td><%= getDBStr( rs.getString("industry_typename") ) %></td>
<%
	if( isExit )
	{
%>
		  <td><a href="<%= getDBStr( rs.getString("docurl") ) %>" target="_blank">查看</a></td>
<%
	}
%>
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

<!--报表结束-->
</form>
</body>
</html>
