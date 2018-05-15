<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.culc.util.OperationUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>客户信息 - 自然人客户信息</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript" src="../../js/table.js"></script>  

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function subFlow(){
	//判断是否有选中
	var priId = $(":input[name='itemselect']:checked").val();
	var flag = $(":input[name='itemselect']:checked").attr("flag");
	var custType = $(":input[name='itemselect']:checked").attr("custType");
	
	if(	priId==undefined || priId==""){
		alert("请选择你要提交审核的客户！");
	}else if(flag>0){
		alert("该客户正在流程审核中，请选择其他客户！");
	}else{
		window.open("http://domino.culc.com/ELeasing/ProjectWF/ProjectDFund.nsf/OSNewWorkFlowFromZJCD?openagent&priId="+priId+"&custType="+custType);
	}
}
</script>
</head>
		
<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->
 
<%
wherestr = " ";

String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );
String create_start_date = getStr( request.getParameter("create_start_date") );
String create_end_date = getStr( request.getParameter("create_end_date") );

String searchFld_tmp = "";
if( searchFld.equals("客户名称") ) {
	searchFld_tmp = "cust_name";
}else if( searchFld.equals("客户编号") ) {
	searchFld_tmp = "cust_id";
}else if( searchFld.equals("登记人") ) {
	searchFld_tmp = "dbo.GETUSERNAME(creator)";
}else{
	searchFld_tmp = "";
}

if ( !searchFld.equals("") && !searchKey.equals("") ) {

	wherestr = wherestr + " and " + searchFld_tmp + " like '%" + searchKey + "%'";
}
if(create_start_date!=null&&!create_start_date.equals("")){
	wherestr+=" and convert(varchar(10),create_date,21)>='"+create_start_date+"' ";
}
if(create_end_date!=null&&!create_end_date.equals("")){
	wherestr+=" and convert(varchar(10),create_date,21)<='"+create_end_date+"' ";
}

//权限判断
wherestr = OperationUtil.getCustEwlpInfoSelectSql(dqczy, wherestr);

countSql = "select count(cust_id) as amount from vi_cust_ewlp_info where 1=1 "+wherestr;

%>
		
<body onLoad="public_onload(0);">
<form action="khzrxx_list.jsp" name="dataNav" onSubmit="return goPage()">	
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		客户信息 &gt; 自然人客户信息</td>
	</tr>
</table>
<!--标题结束-->

<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;" >
	<tr class="maintab">
		<td align="left" colspan="2">               
			&nbsp;按&nbsp;<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|客户编号|客户名称|登记人"));</script></select>&nbsp;查询&nbsp;<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">
			添加日期<input name="create_start_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_start_date %>"> <img  onClick="openCalendar(create_start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
			-<input name="create_end_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_end_date %>"> <img  onClick="openCalendar(create_end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
			<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
	     </td>
	</tr>
         
	<tr class="maintab">
		<td align="left" width="1%">
		<!--操作按钮开始-->
		<table border="0" cellspacing="0" cellpadding="0" >    
		    <tr class="maintab">		
			<%if(right.CheckRight("khxx_zrrkh_add",dqczy)>0){%><td><a href="#" accesskey="n" onClick="dataHander('add','khzrxx_add.jsp',dataNav.itemselect);"><img   src="../../images/sbtn_new.gif" alt="新增(Alt+N)" align="absmiddle"></a></td><%}%>
			<%if(right.CheckRight("khxx_zrrkh_mod",dqczy)>0){%><td><a href="#" accesskey="m" onClick="dataHander('mod','khzrxx_mod.jsp?custId=',dataNav.itemselect);"><img   src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" align="absmiddle" ></a></td><%}%>
			<%if(right.CheckRight("khxx_zrrkh_del",dqczy)>0){%><td><a href="#" accesskey="d" onClick="dataHander('del','khzrxx_del.jsp?custId=',dataNav.itemselect);"><img src="../../images/sbtn_del.gif" alt="删除(Alt+D)" align="absmiddle" ></a></td><%}%>
			
			
			<td><a href="#" accesskey="l" onClick="return subFlow();">
			<img src="../../images/sbtn_detail.gif" alt="提交审核(Alt+L)" align="absmiddle">提交审核</a>&nbsp;
			</td>
			<%--if(right.CheckRight("khxx_zrrkh_add",dqczy)>0){--%>
			<%-- 
			<td><a href="#" accesskey="d" onClick="dataHander('add','do_download.jsp?custId=',dataNav.itemselect);">
			<img src="../../images/fdmo_70.gif"  width="19" height="19" alt="下载导入模板" align="absmiddle" ></a>&nbsp;</td>
			--%>
			<%--}--%>																
			<%--if(right.CheckRight("khxx_zrrkh_add",dqczy)>0){--%>
			<%-- 
			<td><a href="#" accesskey="d" onClick="dataHander('add','khzrxx_upload.jsp?custId=',dataNav.itemselect);">
			<img src="../../images/fdmo_36.gif"  width="19" height="19" alt="供应商导入" align="absmiddle" ></a>&nbsp;</td>
			--%>
			<%--}--%>	
		    </tr>
		</table>
		<!--操作按钮结束-->
		</td>
	 	<td align="right" width="90%" colspan="2"><!--翻页控制开始-->
		<%@ include file="../../public/pageSplit.jsp"%>
        </td>
	</tr>
</table>

<!--翻页控制结束-->


<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" onmousedown=init() onmouseup=end() onmousemove=drag()>
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
	    <th>客户编号</th>
		<th>客户名称</th>
        <th>国家</th>
        <th>区域</th>  
        <th>省份</th>
        <th>城市</th>
        
        <th>客户类别大类</th>
        <th>所属部门</th>
		<th>登记人</th>
		<th>登记时间</th>
		<th>状态</th>
      </tr>
      	<tbody id="data">
<%
String col_str="cust_id,cust_name,gjmc,flag,qymc,sfmc,csmc,lbdlmc,create_date,modify_date,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator),deptname=dbo.GetDeptName(creator_dept)";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_cust_ewlp_info where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_cust_ewlp_info where 1=1 "+wherestr+" order by id,create_date desc ) "+wherestr ;
sqlstr += " order by create_date desc ";

LogWriter.logDebug(request, "自热人客户信息界面###"+sqlstr);

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
   <tr>
	    <td><input class="rd" type="radio" name="itemselect" value="<%= getDBStr( rs.getString("cust_id") ) %>" 
	    flag="<%=getDBStr( rs.getString("flag") ) %>" custType="<%=getDBStr( rs.getString("lbdlmc") ) %>"></td>
	    <td align="left"><a href="khzrxx.jsp?custId=<%= getDBStr( rs.getString("cust_id") ) %>" target="_blank">
	    <%= getDBStr(rs.getString("cust_id") ) %></a></td>
		<td><%= getDBStr( rs.getString("cust_name") ) %></td> 
		<td><%= getDBStr( rs.getString("gjmc") ) %></td> 
		<td><%= getDBStr( rs.getString("qymc") ) %></td>	 	
		<td><%= getDBStr( rs.getString("sfmc") ) %></td>
		<td><%= getDBStr( rs.getString("csmc") ) %></td>
		<td><%= getDBStr( rs.getString("lbdlmc") ) %></td>
		
		<td align="center"><%= getDBStr( rs.getString("deptname") ) %></td>
		<td><%= getDBStr( rs.getString("dengjiren") ) %></td>
		<td><%= getDBDateStr( rs.getString("create_date") ) %></td>
		<td align="center"><b style="color: blue;"><%=(rs.getInt("flag"))==1?"未审核":((rs.getInt("flag")==0)?"审核通过":"流程审核中") %></b></td>
	</tr>
<% }
rs.close(); 
db.close();
%>
</tbody></table>
</div><!--报表结束-->
</form>
</body>
</html>
