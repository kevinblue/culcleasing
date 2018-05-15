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

<script type="text/javascript">
function waitSub(){
	dataNav.submit();
}
</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
wherestr = " ";

String proj_id = getStr( request.getParameter("proj_id") );
String project_name = getStr( request.getParameter("project_name") );
String cust_name = getStr( request.getParameter("cust_name") );
System.out.println("测试客户名称"+cust_name);



if ( !proj_id.equals("") && !proj_id.equals("") ) {

	wherestr = wherestr + " and proj_id like '%" + proj_id + "%'";
}
if(project_name!=null && !project_name.equals("")){
	wherestr+=" and project_name like '%"+project_name+"%' ";
}
if(cust_name!=null && !cust_name.equals("")){
	wherestr+=" and cust_name like '%"+cust_name+"%' ";
}

//权限判断
wherestr = OperationUtil.getCustInfoSelectSql(dqczy, wherestr);

countSql = "select count(contract_id) as amount from contract_info ci LEFT JOIN cust_info cif ON cif.cust_id=ci.cust_id where proj_status>=40  "+wherestr;

%>
<!--<body onLoad="public_onload(0); style="border:1px solid #8DB2E3;overflow:auto""-->

<body onLoad="public_onload(0);">
<form action="irr_report.jsp" name="dataNav">
  <!--标题开始-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="30">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      报表 &gt; 动态IRR</td>
    </tr>
  </table>
  
  <div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" 
onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="1" cellpadding="0">
<tr>
<td scope="row">
项目编号:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
<input style="width:150px;" name="proj_id" id="proj_id" type="text" value="<%=proj_id %>">
</td>


<td>项目名称:&nbsp;
<input style="width:150px;" name="project_name" id="project_name" type="text" value="<%=project_name %>"> 
</td>	

<td>客户名称:&nbsp;&nbsp;
<input style="width:150px;" name="cust_name" id="cust_name" type="text" value="<%=cust_name %>">
</td>	
<td colspan="2" align="left">
<input type="button" onclick="waitSub()" value="查询">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" onclick="clearQuery()" value="清空"></td>
</tr>
</table>
</fieldset>
</div><!-- 查询条件结束 -->
  <!--标题结束-->
  <!--副标题和操作区开始-->
   <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:3px;" >
	<tr class="maintab">
	<td align="left" colspan="4">               
		
                </td>
			</tr>
    <tr class="maintab">
      <td align="left" width="3%" rowspan="2"><!--操作按钮开始-->
        <table border="0" cellspacing="0" cellpadding="0" >
			<tr>
				
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
	    <th>客户名称</th>
	    <th>计划IRR</th>
	    <th>实际IRR</th>
      </tr>
      <tbody id="data">
<%
String col_str="ci.contract_id,proj_id,project_name,plan_irr,cif.cust_name ";
double XIRR=0.00;
sqlstr = "select top "+ intPageSize +" "+col_str+" from contract_info ci left join contract_condition cc on ci.contract_id=cc.contract_id LEFT JOIN cust_info cif ON cif.cust_id=ci.cust_id where proj_status>=40  and ci.contract_id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" ci.contract_id from contract_info ci left join contract_condition cc on ci.contract_id=cc.contract_id LEFT JOIN cust_info cif ON cif.cust_id=ci.cust_id where proj_status>=40 "+wherestr+" order by ci.contract_id desc ) "+wherestr ;
sqlstr += " order by ci.contract_id ";

LogWriter.logDebug(request, "动态IRR###"+sqlstr);
XIrrCal xirr = new XIrrCal();
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
XIRR = Double.parseDouble(xirr.getXIrrByContractId(getDBStr(rs.getString("contract_id"))))*100;
if(XIRR>=100){
	XIRR=0.00;
};
%>

      <tr>
		<td align="center"><%=getDBStr( rs.getString("proj_id") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("contract_id") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("project_name") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("cust_name") ) %></td>
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
