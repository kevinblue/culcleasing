<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/headImport.jsp"%>

<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!-- 05.002 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>项目台帐-扣款未成功明细表</title>
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
	<script src="../../js/delitem.js"></script>

	<script type="text/javascript" src="../../js/jquery.js"></script>
	<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
	<script type="text/javascript" src="../../js/stleasing_function.js"></script>
	<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<!-- 下拉值 -->
<%@ include file="../../public/selectData.jsp"%>
<!-- 下拉值 -->

<!-- 租赁公司、代理商的判断 -->
<%@ include file="../../public/pageRight.jsp"%>
<!-- 租赁公司、代理商的判断 -->

<body onload="public_onload(0);">
<form action="super_rent_report.jsp" name="dataNav" onSubmit="return goPage()">
	<%-- 隐藏字段设置 --%>
	<input type="hidden" name="export_data_id" id="export_data_id">

	<!--标题开始-->
	<table border="0" width="100%" cellspacing="0" cellpadding="0"
		height="25">
		<tr class="tree_title_txt">
			<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				项目台帐&gt; 扣款未成功明细表
			</td>
		</tr>
	</table>
<%
ResultSet rs1 = null;
wherestr=" and 1=1 ";

String curr_date = getSystemDate(0);
String dld_name = getStr(request.getParameter("dld_name"));
String zzs = getStr(request.getParameter("zzs"));
String cust_name = getStr(request.getParameter("cust_name"));
String prod_id = getStr(request.getParameter("prod_id"));
String proj_id = getStr(request.getParameter("proj_id"));
String equip_sn = getStr(request.getParameter("equip_sn"));
String is_fk = getStr(request.getParameter("is_fk"));
String proj_state = getStr(request.getParameter("proj_state"));

String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));


if(dld_name!=null && !"".equals(dld_name)){
	wherestr+=" and dld like '%"+dld_name+"%'";
}
if(cust_name!=null && !"".equals(cust_name)){
	wherestr+=" and khmc like '%"+cust_name+"%'";
}
if(proj_id!=null && !"".equals(proj_id)){
	wherestr+=" and proj_id like '%"+proj_id+"%'";
}
if(zzs!=null && !"".equals(zzs)){
	wherestr+=" and manufacturer = '"+zzs+"'";
}
if(prod_id!=null && !"".equals(prod_id)){
	wherestr+=" and prod_id = '"+prod_id+"'";
}
if(equip_sn!=null && !"".equals(equip_sn)){
	wherestr+=" and equip_sn like '%"+equip_sn+"%'";
}
if(is_fk!=null && !"".equals(is_fk)){
	if( "未放款".equals(is_fk) ){
		wherestr+=" and zlw_fk_fact_date is null ";
	}else{
		wherestr+=" and zlw_fk_fact_date is not null ";
	}
}
if(proj_state!=null && !"".equals(proj_state)){
	wherestr+=" and status_name = '"+proj_state+"'";
}

if(start_date!=null && !"".equals(start_date)){
	wherestr+=" and convert(varchar(10),qz_date,21)>='"+start_date+"' ";
}
if(end_date!=null && !"".equals(end_date)){
	wherestr+=" and convert(varchar(10),qz_date,21)<='"+end_date+"' ";
}
 
countSql = "select count(*) as amount from vi_report_super_rent where 1=1 "+filterAgent+wherestr;

%>	
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="1" cellpadding="0">
<tr>
<td>代理商</td>
<td><input name="dld_name" type="text" size="11" value="<%=dld_name %>"></td>
<td>项目编号</td>
<td><input name="proj_id" type="text" size="11" value="<%=proj_id %>"></td>
<td>租赁物类型</td>
<td><select name="prod_id" style="width:90px;">
     <script>w(mSetOpt('<%=prod_id%>',"<%=prod_id_str %>"));</script>
     </select>
</td>

<td>起租日期</td>
<td> <input name="start_date" type="text" size="10" readonly dataType="Date" value="<%=start_date %>"><img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
<td>&nbsp;至</td>
<td>
<input name="end_date" type="text" size="10" readonly dataType="Date" value="<%=end_date %>"><img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td><input type="button" onclick="dataNav.submit()" value="查询"></td>
</tr>

<tr>
<td>制造商</td>
<td>
<select name="zzs" style="width:90px;">
 <script>w(mSetOpt('<%=zzs%>',"<%=zzs_str%>"));</script>
</select>
</td>
<td>客户名称</td>
<td><input name="cust_name" type="text" size="11" value="<%=cust_name %>"></td>
<td>出厂&nbsp;&nbsp;编号</td>
<td><input name="equip_sn" type="text" size="11" value="<%=equip_sn %>"></td>

<td>是否放款</td>
<td>
<select name="is_fk" style="width:100px;">
 <script>w(mSetOpt('<%=is_fk%>',"|已放款|未放款"));</script>
</select>
</td>
<td>项目状态</td>
<td>
<select name="proj_state" style="width:100px;">
     <script>w(mSetOpt('<%=proj_state%>',"<%=proj_state_str %>"));</script>
</select>
</td>
<td><input type="button" onclick="clearQuery()" value="清空"></td>
</tr>

</table>
</fieldset>
</div><!-- 查询条件结束 -->

<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
		<td align="left" width="1%">		
		<!--操作按钮开始-->
		<table border="0" cellspacing="0" cellpadding="0" >    
			<tr class="maintab">
				<td>
				<input name="expsqlstr" type="hidden">
				<BUTTON class="btn_2"  type="button" onclick="return validata_data_exp_big('super_rent_export.jsp')">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>
				</td>
				<!--
				<td>
				<BUTTON class="btn_2"  type="button" onclick="return validata_data_exp()">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出PDF</button>
				</td>
				-->
				 <td>
				<img src="../../images/sbtn_split.gif" width="2" height="14">
				</td>
				<td nowrap>
					<input name="ck_all" style="border:none;" type="checkbox">&nbsp;页面全选
					<input name="data_ck_all" style="border:none;" type="checkbox">&nbsp;数据全选
				</td><!--操作按钮结束-->
			</tr>
		</table><!--操作按钮结束-->
		</td>

		<td align="right" width="90%">
		<!-- 翻页控制开始 -->
		<%@ include file="../../public/pageSplit.jsp"%>
		<!--翻页控制结束-->	 			
		</td>
	</tr>
</table>

<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">

	<table border="0" style="border-collapse:collapse;" align="center"
		cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
		<tr class="maintab_content_table_title">
		<th width="1%"></th> 						
        <th>序号</th>
		<th>代理商</th>
        <th>项目编号</th>
		<th>客户名称</th>
		
		<th>项目类型</th>
		<th>租赁物类型</th>
		<th>制造商</th>
		<th>机型</th>
		<th>出厂编号</th>

		<th>款项内容</th>
		<th>期次</th>
		<th>应收日期</th>
		<th>应收金额</th>

		<th>扣款日期</th>
		<th>未成功原因</th>
		<th>余额</th>
		
		<th>逾期原因</th>
		<th>逾期说明</th>
		<th>详细描述</th>
	</tr>
	<tbody id="data">
<%	  
sqlstr = "select top "+ intPageSize +" * from vi_report_super_rent where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_report_super_rent where 1=1 "+filterAgent+wherestr+" order by dld,proj_id,id  ) "+filterAgent+wherestr;
sqlstr +=" order by dld,proj_id,id ";

rs = db.executeQuery(sqlstr);
String item_id = "";
String projId = "";
int startIndex = (intPage-1)*intPageSize+1;
while ( rs.next() ) {
	item_id = getDBStr( rs.getString("id") );
	projId = getDBStr( rs.getString("proj_id") );
%>
<tr>
	<td><input type="checkbox" name="list" item_id="<%=item_id %>"></td>
	<td align="center"><%=startIndex++ %></td>
	<td align="left"><%=getDBStr(rs.getString("dld"))%></td>
	<td align="left"><a href="http://test.strongflc.com/Eleasing/PMAgent.nsf/OSShowProjectInfo?openagent&proj_id=<%=projId %>" target="_blank"><%=getDBStr(rs.getString("proj_id")) %></a></td>
	<td align="left"><%=getDBStr(rs.getString("khmc")) %></td>
	
	<!-- 租赁物信息 -->
	<td align="center"><%=getDBStr(rs.getString("prod_id")) %></td>
	<td align="left"><%=getDBStr(rs.getString("manufacturer"))%></td>
	<td align="center"><%=getDBStr(rs.getString("method")) %></td>
	<td align="left"><%=getDBStr(rs.getString("model_id")) %></td>
	<td align="left"><%=getDBStr(rs.getString("equip_sn")) %></td>
	<td align="center"><%=getDBStr(rs.getString("equip_amount"))%></td>

	<!-- 项目流程日期 -->
	<td align="left"><%=getDBDateStr(rs.getString("lx_date")) %></td>
	<td align="left"><%=getDBDateStr(rs.getString("proj_pz_date")) %></td>
	<td align="left"><%=getDBDateStr(rs.getString("proj_qy_date")) %></td>
	<td align="left"><%=getDBDateStr(rs.getString("proj_qzconfirm_date")) %></td>
	<td align="left"><%=getDBDateStr(rs.getString("qz_date")) %></td>
	<td align="center">&gt;&gt;<%=getDBStr(rs.getString("lease_term")) %></td>
	<td align="left"><%=getDBDateStr(rs.getString("end_leasing_date")) %></td>
	
	<td align="left"><%=getDBStr(rs.getString("delivery_place")) %></td>
	<td align="left"><%=getDBDateStr(rs.getString("delivery_date")) %></td>

	<td align="center"><%=rs.getString("zlw_fk_fact_date")==null?"否":"是" %></td>
	<td align="left"><%=getDBDateStr(rs.getString("zlw_fk_plan_date")) %></td>
	<td align="left"><%=getDBDateStr(rs.getString("zlw_fk_fact_date"))%></td>

	<!-- 项目金额 -->
	<td align="left"><%=formatNumberDoubleTwo(rs.getString("equip_amt")) %></td>
	<td align="left"><%=formatNumberDoubleTwo(rs.getString("lease_zl_money")) %></td>
	<td align="center"><%=getDBStr(rs.getString("lease_term")) %></td>
	<td align="left"><%=formatNumberDoubleTwo(rs.getString("head_ratio"))%></td>
	<td align="left"><%=formatNumberDoubleTwo(rs.getString("lease_money")) %></td>
	
	<!-- 资金计划 -->
	<td align="left"><%=formatNumberDoubleTwo(rs.getString("qzzj")) %></td>
	<td align="left"><%=formatNumberDoubleTwo(rs.getString("bzj")) %></td>
	<td align="left"><%=formatNumberDoubleTwo(rs.getString("dyqzj")) %></td>
	<td align="left"><%=formatNumberDoubleTwo(rs.getString("bxf")) %></td>
	<td align="left"><%=formatNumberDoubleTwo(rs.getString("sxf")) %></td>
	<td align="left"><%=formatNumberDoubleTwo(rs.getString("lgjk")) %></td>
	<td align="left"><%=formatNumberDoubleTwo(rs.getString("first_total_money")) %></td>
	<td align="left"><%=rs.getString("glfwf")==null?"0.00":formatNumberDoubleTwo(rs.getString("glfwf")) %></td>
    <td align="center"><%=getDBStr(rs.getString("first_paytype")) %></td>
	<td align="left"><%=getDBDateStr(rs.getString("sfk_plan_date")) %></td>
	<td align="left"><%=getDBDateStr(rs.getString("sfk_fact_date")) %></td>
		
	<!-- 租金计划 -->
	<td align="left"><%=formatNumberDoubleTwo(rs.getString("total_rent")) %></td>
	<td align="center"><%=getDBStr(rs.getString("received_amount")) %></td>
	<td align="left"><%=formatNumberDoubleTwo(rs.getString("paid_rent")) %></td>
	<td align="left"><%=rs.getInt("lease_term")-rs.getInt("received_amount") %></td>
	<td align="left"><%=formatNumberDoubleTwo(rs.getString("left_rent"))%></td>
	<td align="left"><%=formatNumberDoubleTwo(rs.getString("left_corpus")) %></td>
	<td align="left"><%=formatNumberDoubleTwo(rs.getString("overdue_sum")) %></td>

	<%
	//计算项目的逾期天数
	int yqDayAmount = 0;
	sqlstr = "select max(overdue_amount) from dbo.vi_report_overdue_invoice where proj_id='"+projId+"'";
	rs1 = db1.executeQuery(sqlstr);
	if(rs1.next()){
		yqDayAmount = rs1.getInt(1);
	}
	%>
	<!-- 逾期租金 -->
	<td align="center"><%=yqDayAmount %></td>
	<td align="left"><%=formatNumberDoubleTwo(rs.getString("total_penalty"))%></td>
	<td align="left"><%=formatNumberDoubleTwo(rs.getString("paid_penalty"))%></td>
	<td align="left"><%=formatNumberDoubleTwo(rs.getDouble("total_penalty")-rs.getDouble("paid_penalty")) %></td>
	<td align="left">违约金处理</td>

	<%
	//计算项目的连续逾期数量
	int lxyqAmount = 0;
	sqlstr = "select count(*) from dbo.vi_report_overdue_invoice where hire_status='未核销' and proj_id='"+projId+"'";
	rs1 = db1.executeQuery(sqlstr);
	if(rs1.next()){
		lxyqAmount = rs1.getInt(1);
	}
	%>
	<td align="center"><%=lxyqAmount %></td>
	<%
	//计算项目的累计逾期数量
	int ljyqAmount = 0;
	sqlstr = "select count(*) from dbo.vi_report_overdue_invoice where proj_id='"+projId+"'";
	rs1 = db1.executeQuery(sqlstr);
	if(rs1.next()){
		ljyqAmount = rs1.getInt(1);
	}
	%>
	<td align="center"><%=ljyqAmount %></td>
	<td align="center"><%=getDBStr(rs.getString("status_name")) %></td>
</tr>
<% }
if(rs1!=null){
	rs1.close();
}
rs.close(); 
db.close();
db1.close();
%>  
</tbody></table>
</div><!--报表结束-->
</form>
</body>
</html>














