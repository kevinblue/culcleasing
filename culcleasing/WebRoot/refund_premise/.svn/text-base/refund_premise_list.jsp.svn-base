<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>付款前提补收</title>
<link href="../css/global.css" rel="stylesheet" type="text/css">
<script src="../js/comm.js"></script>
<script src="../js/calend.js"></script>
<script src="../js/delitem.js"></script>

<script Language="Javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../js/stleasing_function.js"></script>
<link href="../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

</head>

<!-- 公共变量 -->
<%@ include file="../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
wherestr = "";
String project_name = getStr( request.getParameter("project_name") );
String contract_id = getStr( request.getParameter("contract_id") );
if ( project_name!=null && !project_name.equals("") ) {
	wherestr += " and project_name like '%" + project_name + "%'";
}
if ( contract_id!=null && !contract_id.equals("") ) {
	wherestr += " and c.contract_id like '%" + contract_id + "%'";
}
countSql = "select count(id) as amount from (select * from vi_contract_info where contract_id in(select contract_id from (select contract_id,sum(num) as total_num from(select *,(select count(*) from contract_fund_fund_charge_condition where payment_id =v.payment_id and status='后期补收') as num  from contract_fund_fund_charge_plan v where  plan_status='已核销') a group by contract_id) b where total_num>0)) c where 1=1 "+wherestr;
System.out.println("==========="+countSql);

%>

<body onLoad="public_onload(0)" style="overflow: auto;">
<form action="refund_premise_list.jsp" name="dataNav" onSubmit="return goPage()">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		付款前提补收</td>
	</tr>
</table> 
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>项目名称:&nbsp;<input name="project_name"  type="text" size="15" value="<%=project_name %>"></td>
<td>合同编号:&nbsp;<input name="contract_id"  type="text" size="15" value="<%=contract_id %>"></td>
<td><input type="button" value="查询" onclick="dataNav.submit();">
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
	<%@ include file="pageSplit.jsp"%>
	<!--翻页控制结束-->	
	</td>		 	
 </tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;height:50%;" id="mydiv">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>合同编号</th>
     <th>项目名称</th>
     <th>行业</th>
     <th>承租客户</th>
     <th>项目经理</th>
     <th>租赁类型</th>
     <th>操作</th>
   </tr>
   <tbody id="data">
<%
System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
String col_str="*";
sqlstr = "select top "+intPageSize+" "+col_str+" from (select * from vi_contract_info where contract_id in(select contract_id from ("
	+"select contract_id,sum(num) as total_num from(select *,(select count(*) from contract_fund_fund_charge_condition where "
	+"payment_id = v.payment_id and status='后期补收') as num  from contract_fund_fund_charge_plan v ) a group by contract_id) b where total_num>0)) c "
	+"where c.id not in(select top "+ (intPage-1)*intPageSize +" id from (select * from vi_contract_info where contract_id in (select contract_id from (select contract_id,sum(num) as total_num from("
	+"select *,(select count(*) from contract_fund_fund_charge_condition where payment_id = v.payment_id and status='后期补收') as num from contract_fund_fund_charge_plan v "
	+") a group by contract_id) b where total_num>0)) c where 1=1 "+wherestr+" order by contract_id) "+wherestr+" order by c.contract_id";
System.out.println("-----------------"+sqlstr);
Conn db1 = new Conn();
rs = db1.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
     	<td align="center"><%=getDBStr(rs.getString("contract_id")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("project_name")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("board_name")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("cust_name")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("proj_manage_name")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("leas_type")) %></td>
     	<td align="center">
     	<a href='refund_cond_fkpt.jsp?contract_id=<%=getDBStr(rs.getString("contract_id")) %>' target="_blank">
	    <img src="../images/btn_edit.gif" align="bottom" border="0">修改</a>
     	</td>
     </tr>
<%}
rs.close();
%>     
     </tbody>
</table>
</div>
</div>
</div>

</form>
</body>
</html>
<%if(null != db1){db1.close();}%>
<%if(null != db){db.close();}%>