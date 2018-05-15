<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.culc.util.OperationUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>客户信息 - 客户移交</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function yijiao(){
	var theArrBox=document.getElementsByName("itemselect");
	var tempStr="where (1=0)";
	for(i=0;i<theArrBox.length;i++){
		if(theArrBox[i].checked) { 
			tempStr+=" or (cust_id='"+theArrBox[i].value+"')"; 
			break; 
		}
	}
	if(tempStr=="where (1=0)"){
		alert("请选择要移交的项目！");
		return false;
	}
	document.getElementsByName("khstr")[0].value=tempStr;
	list.submit();
}
</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">

<form name="list" action="khyj.jsp" method="post" target="_blank">
<input type="hidden" name="khstr" id="khstr" value="">
</form>

<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
  <tr class="tree_title_txt">
    <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">客户信息 &gt; 客户移交</td>
  </tr>
</table>
<!--标题结束-->

<%
wherestr = "";

String cust_id = getStr( request.getParameter("cust_id") );
String cust_name = getStr( request.getParameter("cust_name") );
String creator = getStr( request.getParameter("creator") );

if ( cust_id!=null && !cust_id.equals("") ) {
	wherestr = wherestr + " and cust_id like '%" + cust_id + "%'";
}
if ( cust_name!=null && !cust_name.equals("") ) {
	wherestr = wherestr + " and cust_name like '%" + cust_name + "%'";
}
if ( creator!=null && !creator.equals("") ) {
	wherestr = wherestr + " and GETUSERNAME(creator) like '%" + creator + "%'";
}
//权限判断
wherestr = OperationUtil.getCustSelectSql(dqczy, wherestr);

countSql = "select count(cust_id) as amount from vi_cust_all_info_t where 1=1 "+wherestr;

%>

<form action="khyj_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>客户编号:&nbsp;<input name="cust_id"  type="text" size="13" value="<%=cust_id %>"></td>
<td>客户名称:&nbsp;<input name="cust_name" type="text"  size="13" value="<%=cust_name %>"></td>
<td>项目经理:&nbsp;<input name="creator"  type="text" size="13" value="<%=creator %>" /></td>
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
        <td align="left" width="1%"><!--操作按钮开始-->
	        <table border="0" cellspacing="0" cellpadding="0" >
	        	<tr class="maintab">
				<%if(right.CheckRight("khyj",dqczy)>0){%> 
		         <td align="left">
		          <a href="#"  accesskey="y" onClick="yijiao();">
		          <img src="../../images/sbtn_yijiao.gif" alt="移交(Alt+Y)" border="0" align="absmiddle"></a>
		          </td>
		         <%}%>
		         </tr>
	        </table>
        </td>
        <!--操作按钮结束-->
        
        <td align="right" width="95%"><!--翻页控制开始-->
		<!-- 翻页控制开始 -->
		<%@ include file="../../public/pageSplitReport.jsp"%>
		<!--翻页控制结束-->	
		</td>
	</tr>
</table>

  <!--报表开始-->
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px" id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"  class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
	    <th>客户编号</th>
	    <th>客户类别</th>
	    <th>客户名称</th>
		<th>行业门类</th>
		<th>类别大类</th>
		<th>所属部门</th>

		<th>项目经理</th>
		<th>登记时间</th>
      </tr>
      <tbody id="data">
<%
String col_str="cust_id,cust_name,cust_code,parent_company,lbdlmc,hymlmc,create_date,modify_date,dept_name,dengjiren=dbo.GETUSERNAME(creator_code),xiugairen=dbo.GETUSERNAME(modificator_code)";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_cust_all_info_t where cust_id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" cust_id from vi_cust_all_info_t where 1=1 "+wherestr+" order by cust_id ) "+wherestr ;
sqlstr +=" order by cust_id ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
        <td align="center"><input class="rd" type="radio" name="itemselect" value="<%=getDBStr( rs.getString("cust_id") )%>"></td>
        <td align="center"><a href="mingxi.jsp?custId=<%=getDBStr( rs.getString("cust_id"))%>&cust_code=<%= getDBStr( rs.getString("cust_code") ) %>" target="_blank"><%=getDBStr( rs.getString("cust_id") )  %></a></td>
		<td align="center"><%= getDBStr( rs.getString("cust_code") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("cust_name") ) %></td>
	    <td><%= getDBStr( rs.getString("hymlmc") ) %></td>
		<td><%= getDBStr( rs.getString("lbdlmc") ) %></td>
		<td><%= getDBStr( rs.getString("dept_name") ) %></td>
	
		<td><%= getDBStr( rs.getString("dengjiren") ) %></td>
		<td><%= getDBDateStr( rs.getString("create_date") ) %></td>
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
