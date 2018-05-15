<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.culc.util.OperationUtil"%>
<%@page import="com.tenwa.culc.calc.zjcs.XIrrCal"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>报表 - 动态IRR</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript" src="../../js/table.js"></script> 

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
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
wherestr = OperationUtil.getCustInfoSelectSql(dqczy, wherestr);

countSql = "select count(contract_id) as amount from contract_info where proj_status>=40  "+wherestr;

%>
<!--<body onLoad="public_onload(0); style="border:1px solid #8DB2E3;overflow:auto""-->

<body onLoad="public_onload(0);">
<form action="contract_irr.jsp" name="dataNav">
  <!--标题开始-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="30">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      报表 &gt; 动态IRR</td>
    </tr>
  </table>
  <!--标题结束-->
  <!--副标题和操作区开始-->
    <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:3px;" >
	<tr class="maintab">
	<td align="left" colspan="4">               
		&nbsp;按&nbsp;<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|客户编号|客户名称|登记人"));</script></select>&nbsp;查询&nbsp;<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">
		添加日期<input name="create_start_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_start_date %>"> <img  onClick="openCalendar(create_start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		-<input name="create_end_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_end_date %>"> <img  onClick="openCalendar(create_end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="dataNav.submit();">
                </td>
			</tr>
    <tr class="maintab">
      <td align="left" width="3%" rowspan="2"><!--操作按钮开始-->
        <table border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<%-- 
				<%if(right.CheckRight("khxx_frkh_add",dqczy)>0){%><td><a href="#" accesskey="n" onClick="dataHander('add','frkh_add.jsp',dataNav.itemselect);"><img   src="../../images/sbtn_new.gif" alt="新增(Alt+N)" align="absmiddle"></a>&nbsp;</td><%}%>
				<%if(right.CheckRight("khxx_frkh_mod",dqczy)>0){%><td><a href="#" accesskey="m" onClick="dataHander('mod','frkh_mod.jsp?custId=',dataNav.itemselect);"><img   src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" align="absmiddle" ></a>&nbsp;</td><%}%>
				<%if(right.CheckRight("khxx_frkh_del",dqczy)>0){%><td><a href="#" accesskey="d" onClick="dataHander('del','frkh_del.jsp?custId=',dataNav.itemselect);"><img src="../../images/sbtn_del.gif" alt="删除(Alt+D)" align="absmiddle" ></a>&nbsp;</td><%}%>
				<%--if(right.CheckRight("khxx_frkh_add",dqczy)>0){--%>
				<td><a href="#" accesskey="d" onClick="dataHander('add','do_download.jsp?custId=',dataNav.itemselect);">
				<img src="../../images/fdmo_70.gif"  width="19" height="19" alt="下载导入模板" align="absmiddle" ></a>&nbsp;</td>
				<%--}--%>																
				<%--if(right.CheckRight("khxx_frkh_add",dqczy)>0){--%>
				<%-- 
				<td><a href="#" accesskey="d" onClick="dataHander('add','frkh_upload.jsp?custId=',dataNav.itemselect);">
				<img src="../../images/fdmo_36.gif"  width="19" height="19" alt="供应商导入" align="absmiddle" ></a>&nbsp;</td>
				--%>
				<%--}--%>																
			  </tr>
		</table>
        <!--操作按钮结束--></td>
        <td align="right" width="90%" colspan="2"><!--翻页控制开始-->
		<%@ include file="../../public/pageSplit.jsp"%>
        </td>
    </tr>
  </table>
  <!--翻页控制结束-->
  
  <!--报表开始-->
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th>项目编号</th>
	    <th>合同编号</th>
	    <th>项目名称</th>
	    <th>计划IRR</th>
	    <th>实际IRR</th>
      </tr>
      <tbody id="data">
<%
String col_str="ci.contract_id,proj_id,project_name,plan_irr ";
double XIRR=0.00;
sqlstr = "select top "+ intPageSize +" "+col_str+" from contract_info ci left join contract_condition cc on ci.contract_id=cc.contract_id where proj_status>=40  and ci.contract_id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" ci.contract_id from contract_info ci left join contract_condition cc on ci.contract_id=cc.contract_id where proj_status>=40 "+wherestr+" order by ci.contract_id desc ) "+wherestr ;
sqlstr += " order by ci.contract_id ";

LogWriter.logDebug(request, "动态IRR###"+sqlstr);
XIrrCal xirr = new XIrrCal();
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
XIRR = Double.parseDouble(xirr.getXIrrByContractId(getDBStr(rs.getString("contract_id"))))*100;
%>

      <tr>
		<td align="center"><%=getDBStr( rs.getString("proj_id") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("contract_id") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("project_name") ) %></td>
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("plan_irr") ) %>%</td>
		<td align="center"><%=CurrencyUtil.convertFinance(String.valueOf(XIRR)) %>%</td>
      </tr>
<%}
rs.close(); 
db.close();
%>
</tbody>
</table>
</div>
<!-- 报表结束 -->

</form>
</body>
</html>
