<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<jsp:useBean id="db2" scope="page" class="dbconn.Conn" />
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
//String projId = getStr( request.getParameter("projId") );
String projectName = getStr( request.getParameter("projectName") );
String projManageName = getStr( request.getParameter("projManageName") );
String deptName = getStr( request.getParameter("deptName") );
String begindate = getStr( request.getParameter("begindate") );
String enddate = getStr( request.getParameter("enddate") );
String rentstartdate = getStr( request.getParameter("rentstartdate") );

if(projectName!=null&&!projectName.equals("")){
	wherestr +=" and ci.project_name='"+projectName+"'";
}
if(projManageName!=null&&!projManageName.equals("")){
	wherestr +=" and bu.name='"+projManageName+"'";
}
if(deptName!=null&&!deptName.equals("")){
	wherestr +=" and bd.dept_name='"+deptName+"'";
}
if(rentstartdate!=null&&!rentstartdate.equals("")){
	wherestr +=" and convert(varchar(10),bi.rent_start_date,21)<='"+rentstartdate+"'";
}
countSql = "select count(bi.id) as amount from begin_info bi "+
"left join contract_info ci on ci.contract_id = bi.contract_id "+
"left join base_user bu on bu.id = ci.proj_manage "+
"left join base_department bd on bd.id = ci.proj_dept where 1=1 " + wherestr;
System.out.println(countSql);

String base_month_conditon = "";
if(begindate!=null&&!begindate.equals("")){
	base_month_conditon += " and convert(varchar(7),year_month,21)>='"+begindate.substring(0,7)+"'";
}
if(enddate!=null&&!enddate.equals("")){
	base_month_conditon += " and convert(varchar(7),year_month,21)<='"+enddate.substring(0,7)+"'";
}
String base_month = "select year_month from base_month where 1=1" + base_month_conditon;

%>

<body onLoad="public_onload(0);">
<form action="irr_report_irr.jsp" name="dataNav">
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
节点:&nbsp;&nbsp;
<!-- 时间控件 -->
<input style="width:150px;" name="rentstartdate" id="rentstartdate" type="text" readonly="readonly" value="<%=rentstartdate%>" />
<img  onClick="openCalendar(rentstartdate);return false" style="cursor:pointer; " 
	src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td scope="row">
查询时间范围:&nbsp;&nbsp;
<!-- 时间控件 -->
<input style="width:150px;" name="begindate" id="begindate" type="text" readonly="readonly" value="<%=begindate%>" />
<img  onClick="openCalendar(begindate);return false" style="cursor:pointer; " 
	src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
至
<input style="width:150px;" name="enddate" id="enddate" type="text" readonly="readonly" value="<%=enddate%>" />
<img  onClick="openCalendar(enddate);return false" style="cursor:pointer; " 
	src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>	
<td>项目名称:&nbsp;&nbsp;
<input style="width:150px;" name="projectName" id="projectName" type="text" value="<%=projectName%>"> 
</td>
</tr>
<tr>
<td scope="row">部门名称:&nbsp;&nbsp;
<input style="width:150px;" name="deptName" id="deptName" type="text"  value="<%=deptName%>">
</td>
<td>项目经理名称:&nbsp;&nbsp;
<input style="width:150px;" name="projManageName" id="projManageName" type="text" value="<%=projManageName%>">
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
			<input name="query_sql" type="hidden" value="<%=base_month%>">                      
			<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('report_irr_export.jsp','');">
			<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>
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

 <%
    List xlmcList = new ArrayList();
 	ResultSet rs2 = null;
	rs2 = db2.executeQuery(base_month);
	System.out.println(base_month);
 %> 
  <!--报表开始-->
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th>项目名称</th>
	    <th>签约IRR</th>
		<%
		if(begindate!=null&&!begindate.equals("")&&enddate!=null&&!enddate.equals("")){
		    while ( rs2.next() ) {
		    	xlmcList.add(rs2.getString("year_month"));
				%>
				<th><%=getDBStr( rs2.getString("year_month") ) %></th>
				<% 
			}
		}
		%>
      </tr>
      <tbody id="data">
<%
	String partSql = "";
	String xlmc = "";
	String sql_str = "select top "+ intPageSize +" ci.project_name project_name,cc.irr irr,ci.contract_id contract_id from begin_info bi "+
 	"left join contract_info ci on ci.contract_id = bi.contract_id "+
 	"left join contract_condition cc on cc.contract_id = ci.contract_id "+
 	"left join base_user bu on bu.id = ci.proj_manage "+
 	"left join base_department bd on bd.id = ci.proj_dept " 
 	+" where bi.id not in( select top "+ (intPage-1)*intPageSize +" id from begin_info bi where 1=1 "+wherestr+" order by contract_id desc) "+wherestr+" order by bi.contract_id desc";
	rs = db.executeQuery(sql_str);
	System.out.println(sql_str);
	while ( rs.next() ) {
%>

      <tr>
		<td align="center"><%=getDBStr( rs.getString("project_name") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("irr") ) %></td>
		<%
	    for(int j=0;j<xlmcList.size();j++){
	    	xlmc = xlmcList.get(j)+"";
	    	partSql = "select month_irr*100 month_irr from repot_contract_month_irr where contract_id='"+getDBStr( rs.getString("contract_id") )+"' and convert(varchar(7),year_month,21)='"+xlmc+"'";
	    	rs2 = db2.executeQuery(partSql);
	    	if(rs2.next()){ 
				%>
			<td align="center"><%=getDBStr( rs2.getString("month_irr")) %></td>
				<%
			}else{
				%>
				<td align="center" nowrap>0.00</td>
				<%
			}
	    }
	    %>
      </tr>
<%}
rs.close(); 
rs2.close();
db.close();
db2.close();
%>
</tbody>
</table>
</div>
<!-- 报表结束 -->
<input name="query_sql2" type="hidden" value="<%=sql_str%>">
</form>
</body>
</html>
