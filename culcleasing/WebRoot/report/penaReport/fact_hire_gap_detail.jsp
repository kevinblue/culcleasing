<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>逾期时长项目明细表</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function waitSub(){
	//判断必填项是否填写
	dataNav.submit();
}
</script>
</head>


<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">

<form action="fact_hire_gap_detail.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		逾期时长项目明细表</td>
	</tr>
</table>
<!--标题结束-->

<%
wherestr = "";

//本页查询参数
String project_name = getStr( request.getParameter("project_name") );
String cust_name = getStr( request.getParameter("cust_name") );
String board_name = getStr( request.getParameter("board_name") );
String manage_name = getStr( request.getParameter("manage_name") );
String dept_name = getStr( request.getParameter("dept_name") );

String min_ljqs=getStr( request.getParameter("min_ljqs") );
String max_ljqs=getStr( request.getParameter("max_ljqs") );
String min_ljts=getStr( request.getParameter("min_ljts") );
String max_ljts=getStr( request.getParameter("max_ljts") );

String min_zzqs=getStr( request.getParameter("min_zzqs") );
String max_zzqs=getStr( request.getParameter("max_zzqs") );
String min_zzts=getStr( request.getParameter("min_zzts") );
String max_zzts=getStr( request.getParameter("max_zzts") );




//拼接查询
if(project_name!=null && !"".equals(project_name)){
	wherestr+=" and project_name like '%"+project_name+"%'";
}
if(cust_name!=null && !"".equals(cust_name)){
	wherestr+=" and cust_name like '%"+cust_name+"%'";
}
if(board_name!=null && !"".equals(board_name)){
	wherestr+=" and board_name like '%"+board_name+"%'";
}
if(manage_name!=null && !"".equals(manage_name)){
	wherestr+=" and manage_name like '%"+manage_name+"%'";
}
if(dept_name!=null && !"".equals(dept_name)){
	wherestr+=" and dept_name like '%"+dept_name+"%'";
}

if(min_ljqs!=null && !"".equals(min_ljqs) && max_ljqs!=null && !"".equals(max_ljqs)){
	wherestr+=" and ljqs>="+min_ljqs+" and ljqs<="+max_ljqs;
}
if(min_ljts!=null && !"".equals(min_ljts) && max_ljts!=null && !"".equals(max_ljts)){
	wherestr+=" and ljts>="+min_ljts+" and ljts<="+max_ljts;
}
if(min_zzqs!=null && !"".equals(min_zzqs) && max_zzqs!=null && !"".equals(max_zzqs)){
	wherestr+=" and zzqs>="+min_zzqs+" and zzts<="+max_zzqs;
}
if(min_zzts!=null && !"".equals(min_zzts) && max_zzts!=null && !"".equals(max_zzts)){
	wherestr+=" and zzts>="+min_zzts+" and zzts<="+max_zzts;
}

//列出所有项目不受时间影响
wherestr += " and exists(select id from fund_rent_income where begin_id=vi_report_penal_gap_d.begin_id)";

sqlstr = "Select * from vi_report_penal_gap_d where 1=1 "+wherestr;

System.out.println("11111"+sqlstr);
%>

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>项目名称:&nbsp;<input name="project_name"  type="text" size="15" value="<%=project_name %>"></td>
<td>累计逾期天数:&nbsp;<input name="min_ljts"  type="text" size="5" value="<%=min_ljts %>"> 到
	<input name="max_ljts"  type="text" size="5" value="<%=max_ljts %>">
</td>

<td>目前正在逾期的累计天数:&nbsp;<input name="min_zzts" type="text" size="5" value="<%=min_zzts %>"> 到
	<input name="max_zzts"  type="text" size="5" value="<%=max_zzts %>">
</td>
<td><input type="button" value="查询" onclick="waitSub()"></td>

</tr>

<tr>
<td>项目经理:&nbsp;<input name="manage_name"  type="text" size="15" value="<%=manage_name %>"></td>
<td>累计逾期期数:&nbsp;<input name="min_ljqs"  type="text" size="5" value="<%=min_ljqs %>"> 到
	<input name="max_ljqs" type="text" size="5" value="<%=max_ljqs %>">
</td>

<td>目前正在逾期的累计期数:&nbsp;<input name="min_zzqs"  type="text" size="5" value="<%=min_zzqs %>"> 到
	<input name="max_zzqs"  type="text" size="5" value="<%=max_zzqs %>">
</td>

<td><input type="button" value="清空" onclick="clearQuery();" ></td>
</tr>

<tr>
<td>
版块名称:&nbsp;<select name="board_name" style="width:115px;">
  <script type="text/javascript">
   	w(mSetOpt('<%=board_name %>',"|医疗事业|船舶|教育|机械|其他","|医疗事业|船舶|教育|机械|其他"));
  </script>
</select>
</td>
<td>客户名称:&nbsp;<input name="cust_name"  type="text" size="15" value="<%=cust_name %>"></td>
<td>部门名称:&nbsp;<input name="dept_name"  type="text" size="15" value="<%=dept_name %>"></td>


</tr>
<tr>



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
		    <td>
		    <BUTTON class="btn_2"  type="button" onclick="exportData();">
			<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>
			</td>
	    </tr>
	</table>
	<!--操作按钮结束-->
	</td>
	<td align="right" width="60%"><!--翻页控制开始-->
	<!-- 翻页控制开始 -->
	<%@ include file="../../public/pageSplitNoCode.jsp"%>
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
        <th>客户名称</th>
        <th>板块</th>
        <th>签约时间</th>
        
        <th>部门</th>
        <th>项目经理</th>
        <th>医院等级</th>
        <th>医院收入</th>
        <th>是否规则</th>
        <th>合同租赁间隔（天）</th>
        <th>单个客户累计逾期期数</th>
        <th>单个客户累计逾期天数</th>
        <th>单个客户目前正在逾期的累计期数</th>
        <th>单个客户目前正在逾期的累计天数</th>
	<%
	//查询最大的核销期次
	String partSql = "";
	ResultSet rs1 = null;
	int hireAmount = 0;
	
	partSql = " SELECT max(hire_list) AS amount FROM fund_rent_income where begin_id IN( select begin_id from ("+sqlstr+") as temp )";
	System.out.println("222"+partSql);
	rs1 = db1.executeQuery(partSql);
	if(rs1.next()){
		hireAmount = rs1.getInt("amount");
	}	
	rs1.close();
	%>

	<%
	//循环显示标题
	for(int index=2;index<=hireAmount;index++){
	%>
		<th width="60px;">第<%=index-1 %>间隔差异（天）</th>
	<%	
	}
	%>	
      </tr>
      <tbody id="data">
<%	  
if ( intRowCount!=0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
      <tr>
		<td align="left"><%=getDBStr( rs.getString("project_name")) %></td>	
		<td align="left"><%=getDBStr( rs.getString("cust_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("board_name")) %></td>	
		<td align="center"><%=getDBDateStr( rs.getString("approve_date")) %></td>	

		<td align="center"><%=getDBStr( rs.getString("dept_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("manage_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("qualification_grade")) %></td>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("medical_revenue" )) %></td>	
		<td align="center"><%=getDBStr( rs.getString("role_way")) %></td>	
		<td align="center"><%= CurrencyUtil.convertIntAmount( rs.getString("leas_gap" )) %></td>	

		<%
		String ljqs="";
		String ljts="";
		String zzqs="";
		String zzts="";
			partSql="select dbo.report_getYQSC ('"+getDBStr( rs.getString("cust_id"))+"','LJQS') as ljqs,";
			partSql+="dbo.report_getYQSC ('"+getDBStr( rs.getString("cust_id"))+"','LJTS') as ljts,";
			partSql+="dbo.report_getYQSC ('"+getDBStr( rs.getString("cust_id"))+"','ZZQS') as zzqs,";
			partSql+="dbo.report_getYQSC ('"+getDBStr( rs.getString("cust_id"))+"','ZZTS') as zzts";
			rs1=db1.executeQuery(partSql);
			if(rs1.next()){
			ljqs=getDBStr( rs1.getString("ljqs"));
			ljts=getDBStr( rs1.getString("ljts"));
			zzqs=getDBStr( rs1.getString("zzqs"));
			zzts=getDBStr( rs1.getString("zzts"));
			%>
				<td align="center"><%=ljqs %></td>
				<td align="center"><%=ljts %></td>
				<td align="center"><%=zzqs %></td>
				<td align="center"><%=zzts %></td>
			<%
		}
		
		//获取值
		float hire_gap = 0;
		int leas_gap= rs.getInt("leas_gap" );
		for(int index=2;index<=hireAmount;index++){
			partSql = "Select [dbo].[Lease_BB_getHKGap]('"+getDBStr( rs.getString("begin_id"))+"',"+index+") as amount";
			rs1 = db1.executeQuery(partSql);
			if(rs1.next()){
				hire_gap = rs1.getFloat("amount")-leas_gap;
				%>
				<td align="center"><%= CurrencyUtil.convertFinance( String.valueOf(hire_gap) ) %></td>
				<%
			}
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
</tbody></table>
</div><!--报表结束-->

</form>
</body>
<script type="text/javascript">
 function exportData(){
 	if(confirm("是否确定导出excel?")){
 		dataNav.action="fact_hire_gap_detail_export_save.jsp";
 		dataNav.target="_black";
 		dataNav.submit();
 		dataNav.action="fact_hire_gap_detail.jsp";
 		dataNav.target="_self";
 	}
 }
</script>
</html>
<%if(null != db1){db1.close();}%>