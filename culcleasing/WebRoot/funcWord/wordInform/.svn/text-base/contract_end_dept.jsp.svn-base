<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同结清 - 通知书</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function endInform(obj,objType){
	//1)标准  2)标准有租金差异无逾期  3)标准有罚息无差异  4)标准有罚息又差异
	if( objType=="1" ){
	window.open("http://domino.culc.com/eleasing/PMAgent.nsf/CreateClearPayNotice01?openagent&id="+obj,
	"","status=no,scrollbars=no,location=no,menubar=yes,resizable=yes");
	}else if( objType=="2" ){
	window.open("http://domino.culc.com/eleasing/PMAgent.nsf/CreateClearPayNotice02?openagent&id="+obj,
	"","status=no,scrollbars=no,location=no,menubar=yes,resizable=yes");
		
	}else if( objType=="3" ){
	window.open("http://domino.culc.com/eleasing/PMAgent.nsf/CreateClearPayNotice03?openagent&id="+obj,
	"","status=no,scrollbars=no,location=no,menubar=yes,resizable=yes");
	}else if( objType=="4" ){
	window.open("http://domino.culc.com/eleasing/PMAgent.nsf/CreateClearPayNotice04?openagent&id="+obj,
	"","status=no,scrollbars=no,location=no,menubar=yes,resizable=yes");
	}
}
</script>
</head>


<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">

<form action="rent_modify_dept.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		合同结清 &gt; 通知书
		</td>
	</tr>
</table>
<!--标题结束-->

<%
wherestr = "";//合同结清项目

//传递参数，出单部门
String deptId = getStr(request.getParameter("deptId"));

//本页查询参数
String project_name = getStr( request.getParameter("project_name") );

if ( deptId!=null && !"".equals(deptId) ) {
	wherestr += " and proj_dept = '" + deptId + "'";
}else{
	//不显示
	wherestr += " and 1=2";
}
if ( project_name!=null && !"".equals(project_name) ) {
	wherestr += " and project_name like '%" + project_name + "%'";
}


countSql = "select count(id) as amount from vi_doc_inform_jq where 1=1 "+wherestr;

%>
<input type="hidden" value="<%=deptId %>" name="deptId"/>
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>项目名称:&nbsp;<input name="project_name"  type="text" size="20" value="<%=project_name %>"></td>

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
		    <td></td>
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
		<th>项目名称</th>
        <th>合同编号</th>
        <th>项目经理</th>
        <th>板块</th>
        <th>部门</th>
          
        <th>退款余额(残值收入+保证金返还)</th>
        <th>剩余租金</th>
        <th>剩余本金</th>
        <th>剩余利息</th>
        
        <th>结清期次</th>
        <th>结清日期</th>
        <th>操作</th>
      </tr>
      <tbody id="data">
<%
String col_str=" * ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_doc_inform_jq where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_doc_inform_jq where 1=1 "+wherestr+" order by id ) "+wherestr ;
sqlstr += " order by id ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
		<td align="left"><%=getDBStr( rs.getString("project_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("contract_id")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("proj_manage_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("board_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("dept_name")) %></td>	

		<td align="left"><%= CurrencyUtil.convertFinance( rs.getString("sum_bzj_money" )) %></td>	
		<td align="left"><%= CurrencyUtil.convertFinance( rs.getString("sum_curr_rent" )) %></td>	
		<td align="left"><%= CurrencyUtil.convertFinance( rs.getString("sum_curr_corpus" )) %></td>	
		<td align="left"><%= CurrencyUtil.convertFinance( rs.getString("sum_curr_interest" )) %></td>	

		<td align="center"><%=getDBStr( rs.getString("hire_rent_list")) %></td>	
		<td align="center"><%=getDBDateStr( rs.getString("hire_plan_date")) %></td>	
				
		<td>
			<a onclick="Javascript:endInform('<%=getDBStr( rs.getString("begin_id")) %>','<%=rs.getString("in_type") %>')" target="_blank" title="点击下载通知书">
			<b style="color:#E46344;">《下载合同结清通知书》</b></a>
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
