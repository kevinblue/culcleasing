<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.culc.util.OperationUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>客户信息 - 自然人客户信息</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
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
	var custName = $(":input[name='itemselect']:checked").attr("custName");
	
	if(	priId==undefined || priId==""){
		alert("请选择你要提交审核的客户！");
	}else if(flag==2){
		alert("该客户正在流程审核中，请选择其他客户！");
	}else if(flag==0){
		alert("该客户已审核通过，请选择其他客户！");
	}else{
		window.open("http://domino.culc.com/ELeasing/ProjectWF/CustApply.nsf/OSNewWorkFlowFromCustZR?openagent&cust_id="+priId+"&custType="+custType+"&custName="+custName);
	}
}
</script>
</head>
		
<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->
 
<!-- 下拉值 -->
<%@ include file="../../public/selectData.jsp"%>
<!-- 下拉值 -->

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

<%
wherestr = "";

String cust_id = getStr( request.getParameter("cust_id") );
String cust_name = getStr( request.getParameter("cust_name") );
String creator = getStr( request.getParameter("creator") );
String custType=getStr(request.getParameter("custType"));
String create_start_date = getStr( request.getParameter("create_start_date") );
String create_end_date = getStr( request.getParameter("create_end_date") );


if(cust_id!=null && !"".equals(cust_id)){
	wherestr+= " and cust_id like '%" + cust_id + "%'";
}
if(cust_name!=null && !"".equals(cust_name)){
	wherestr+= " and cust_name like '%" + cust_name + "%'";
}
if(creator!=null && !"".equals(creator)){
	wherestr+= " and dbo.GETUSERNAME(creator) like '%" + creator + "%'";
}

if(custType!=null && !"".equals(custType)){
	wherestr+= " and lbdlmc like '%" + custType + "%'";
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

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;">  
<legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
	<table border="0" width="100%" cellspacing="5" cellpadding="0">
	<tr>
	<td>               
		客户编号&nbsp;<input name="cust_id" type="text" size="15" value="<%=cust_id %>">
	</td>
	<td>
		客户名称&nbsp;<input name="cust_name" type="text" size="15" value="<%=cust_name %>">
	</td>	
	<td>
		添加日期<input name="create_start_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_start_date %>"> 
		<img  onClick="openCalendar(create_start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		至<input name="create_end_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_end_date %>"> 
		<img  onClick="openCalendar(create_end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
    </td>
	</tr>
	<tr>
		<td>登 记 人&nbsp;<input name="creator" type="text" size="15" value="<%=creator %>"></td>
		<td>客户类别&nbsp;<select name="custType" style="width:113px;">
	     <script>w(mSetOpt('<%= custType%>',"<%=cust_type_str %>"));</script>
	     </select>
	    </td>
		<td>
		<input type="button" value="查询" onclick="dataNav.submit();">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="清空" onclick="clearQuery();" >
		</td>
	</tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;" >
	<tr class="maintab">
		<!-- <%if(right.CheckRight("khxx_zrrkh_add",dqczy)>0){%><td><a href="#" accesskey="n" onClick="dataHander('add','khzrxx_add.jsp',dataNav.itemselect);"><img   src="../../images/sbtn_new.gif" alt="新增(Alt+N)" align="absmiddle">新&nbsp;增</a></td><%}%> -->
		<td align="left" width="80%">
		<!--操作按钮开始-->
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
        <th>南北编码</th>
		<th>登记人</th>
		<th>登记时间</th>
		
      </tr>
      	<tbody id="data">
<%
String col_str="cust_id,cust_name,gjmc,flag,qymc,sfmc,csmc,lbdlmc,finance_code,create_date,modify_date,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator),deptname=dbo.GetDeptName(creator_dept)";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_cust_ewlp_info where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_cust_ewlp_info where 1=1 "+wherestr+" order by id,create_date desc ) "+wherestr ;
sqlstr += " order by create_date desc ";

LogWriter.logDebug(request, "自热人客户信息界面###"+sqlstr);

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
   <tr>
	    <td><input class="rd" type="radio" name="itemselect" value="<%= getDBStr( rs.getString("cust_id") ) %>" 
	    flag="<%=getDBStr( rs.getString("flag") ) %>" custType="<%=getDBStr( rs.getString("lbdlmc") ) %>"
	    custName="<%=getDBStr( rs.getString("cust_name") ) %>"></td>
	    <td align="left"><a href="khzrxx.jsp?custId=<%= getDBStr( rs.getString("cust_id") ) %>" target="_blank">
	    <%= getDBStr(rs.getString("cust_id") ) %></a></td>
		<td><%= getDBStr( rs.getString("cust_name") ) %></td> 
		<td><%= getDBStr( rs.getString("gjmc") ) %></td> 
		<td><%= getDBStr( rs.getString("qymc") ) %></td>	 	
		<td><%= getDBStr( rs.getString("sfmc") ) %></td>
		<td><%= getDBStr( rs.getString("csmc") ) %></td>
		<td><%= getDBStr( rs.getString("lbdlmc") ) %></td>
		
		<td align="center"><%= getDBStr( rs.getString("deptname") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("finance_code") ) %></td>
		<td><%= getDBStr( rs.getString("dengjiren") ) %></td>
		<td><%= getDBDateStr( rs.getString("create_date") ) %></td>
		
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
