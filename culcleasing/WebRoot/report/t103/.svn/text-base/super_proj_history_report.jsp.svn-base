<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/headImport.jsp"%>

<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!-- 05.002 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>项目超级表-历史查询</title>
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
<form action="super_proj_history_report.jsp" name="dataNav" onSubmit="return goPage()">
<input type="hidden" id="choiceType" name="choiceType">
<input type="hidden" id="sqldata" name="sqldata"><!-- sqldata主键 -->

<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0"
	height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
			项目超级表&gt; 历史查询
		</td>
	</tr>
</table><!--标题结束-->
<%
ResultSet rs1 = null;
wherestr="";

String dld_name = getStr(request.getParameter("dld_name"));
String cust_name = getStr(request.getParameter("cust_name"));
String proj_id = getStr(request.getParameter("proj_id"));
String zzs = getStr(request.getParameter("zzs"));
String equip_sn = getStr(request.getParameter("equip_sn"));
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
if(equip_sn!=null && !"".equals(equip_sn)){
	wherestr+=" and equip_sn like '%"+equip_sn+"%'";
}
if(zzs!=null && !"".equals(zzs)){
	wherestr+=" and manufacturer = '"+zzs+"'";
}

if(end_date!=null && !"".equals(end_date)){
	wherestr+=" and convert(varchar(10),lx_date,21)<='"+end_date+"' ";
}else{
	end_date = getSystemDate(0);
	wherestr+=" and convert(varchar(10),lx_date,21)<='"+end_date+"' ";
}
 
countSql = "select count(id) as amount from vi_sup_proj_his_base where 1=1 "+filterAgent+wherestr;

//导出sql
String datasqlstr = filterAgent+wherestr;

%>	
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="1" cellpadding="0">
<tr>
<td>代&nbsp;理&nbsp;商</td>
<td><input name="dld_name" type="text" size="13" value="<%=dld_name %>"></td>
<td>项目编号</td>
<td><input name="proj_id" type="text" size="13" value="<%=proj_id %>"></td>

<td>查询日期&nbsp;
<input name="end_date" type="text" size="12" readonly dataType="Date" value="<%=end_date %>"><img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td><input type="button" onclick="dataNav.submit()" value="查询"></td>
</tr>

<tr>
<td>客户名称</td>
<td><input name="cust_name" type="text" size="13" value="<%=cust_name %>"></td>
<td>出厂编号</td>
<td><input name="equip_sn" type="text" size="13" value="<%=equip_sn %>"></td>
<td>制 造 商&nbsp;
<select name="zzs" style="width:100px;">
 <script>w(mSetOpt('<%=zzs%>',"<%=zzs_str%>"));</script>
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
				<input type="hidden" name="datasqlstr" value="<%=datasqlstr %>"> 
				<BUTTON class="btn_2"  type="button" onclick="return validata_report_data_exp('super_proj_history_export_save.jsp','super_proj_history_report.jsp');">
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
</table><!--副标题和操作区结束-->

<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" style="border-collapse:collapse;" align="center"
cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
<tr class="maintab_content_table_title">
	<th width="1%"></th>
    <th>序号</th>
	<th>区域</th>
	<th>代理商</th>
    <th>项目编号</th>
	<th>客户名称</th>
	
	<th>租赁物类型</th>
	<th>制造商</th>
	<th>机型</th>
	<th>出厂编号</th>
	<th>车架号</th>
	<th>台量</th>

	<th>申请日期</th>
	<th>验收日期</th>
	<th>起租确认日期</th>
		
	<th>租赁期限</th>
    <th>租赁物购买价款</th>
    <th>融资租赁额</th>
    <th>起租比例</th>
    <th>首期付款</th>

	<th>租金总额</th>
	<th>已还租期数</th>
	<th>已还租金</th>
	<th>剩余租金期数</th>
	<th>租金余额</th>
	<th>剩余本金</th>
	<th>逾期租金</th>
	<th>逾期天数</th>

	<th>违约金合计</th>
	<th>已收违约金</th>
	<th>未收违约金</th>
	<th>逾期期数</th>
	<th>累计逾期</th>
	<!-- 
	<th>状态</th>
	 -->
</tr>
<tbody id="data">
<%	  
String col_str = " id,qymc,dld,agent_id,proj_id,khmc,prod_id,model_id,equip_sn,bodyno,equip_amount";
col_str+=" ,manufacturer,lease_term,equip_amt,lease_zl_money,status_name";
col_str+=" ,head_ratio,first_payment,total_amt,lx_date,check_date,qz_date";

sqlstr = "select top "+ intPageSize+ col_str +" from vi_sup_proj_his_base where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_sup_proj_his_base where 1=1 "+filterAgent+wherestr+" order by dld,id ) "+filterAgent+wherestr;
sqlstr += " order by dld,id ";

rs = db.executeQuery(sqlstr);
//=========变量定义区=======
String partSql = "";
//========================
String item_id = "";
String projId = "";
String yhqs = "0";//已还租期数
String yhzj = "0";//已还租金
String syzjqs = "0";//剩余租金期数
String syzj = "0";//租金余额
String sybj = "0";//租金本金
String yqzj = "0";//逾期租金
String yqts = "0";//逾期天数
String wyjhj = "0";//违约金合计
String yswyj = "0";//已收违约金
String wswyj = "0";//未收违约金
String yqqs = "0";//逾期期数
String ljyq = "0";//累计逾期
//==========
int startIndex = (intPage-1)*intPageSize+1;
while ( rs.next() ) {
	item_id = getDBStr( rs.getString("id") );
	projId = getDBStr( rs.getString("proj_id") );
%>
<tr>
	<td><input type="checkbox" name="list" item_id="<%=item_id %>"></td>
	<td align="center"><%=startIndex++ %></td>
	<td align="center"><%=getDBStr(rs.getString("qymc"))%></td>
	<td align="center"><%=getDBStr(rs.getString("dld"))%></td>
	<td align="center">
	<%-- --%>
	<a href="http://online.strongflc.com/Eleasing/PMAgent.nsf/OSShowProjectInfo?openagent&proj_id=<%=projId %>" target="_blank">
	</a>
	<%=projId %>
	</td>
	<td align="center"><%=getDBStr(rs.getString("khmc")) %></td>
	
	<!-- 租赁物信息 -->
	<td align="center"><%=getDBStr(rs.getString("prod_id")) %></td>
	<td align="center"><%=getDBStr(rs.getString("manufacturer"))%></td>
	<td align="center"><%=getDBStr(rs.getString("model_id")) %></td>
	<td align="center"><%=getDBStr(rs.getString("equip_sn")) %></td>
	<td align="center"><%=getDBStr(rs.getString("bodyno")) %></td>
	<td align="center"><%=getDBStr(rs.getString("equip_amount"))%></td>

	<!-- 项目流程日期 -->
	<td align="center"><%=getDBDateStr(rs.getString("lx_date")) %></td>
	<td align="center"><%=getDBDateStr(rs.getString("check_date")) %></td>
	<td align="center"><%=getDBDateStr(rs.getString("qz_date")) %></td>
	<td align="center">&gt;&gt;<%=getDBStr(rs.getString("lease_term")) %></td>
	
	<!-- 项目金额 -->
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("equip_amt")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("lease_zl_money")) %></td>
	<td align="center"><%=CurrencyUtil.convertFinance(rs.getDouble("head_ratio"))%></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("first_payment")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("total_amt")) %></td>
	
	<!-- 租金还租情况 -->
	<%
		//已还租期数
		partSql = " select dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','yhqs') as r";
		rs1 = db1.executeQuery(partSql);
		if(rs1.next()){
			yhqs = getDBStr( rs1.getString("r") );
		}else {yhqs = "0";}
		rs1.close();
	%>
	<td align="center"><%=yhqs %></td>
	<%
		//已还租金
		partSql = " select dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','yhzj') as r";
		rs1 = db1.executeQuery(partSql);
		if(rs1.next()){
			yhzj = getDBStr( rs1.getString("r") );
		}else{yhzj = "0";}
		rs1.close();
	%>
	<td align="center"><%=CurrencyUtil.convertFinance(yhzj) %></td>
	<%
		//剩余租金期数
		partSql = " select dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','syzjqs') as r";
		rs1 = db1.executeQuery(partSql);
		if(rs1.next()){
			syzjqs = getDBStr( rs1.getString("r") );
		}else{syzjqs = "0";}
		rs1.close();
	%>
	<td align="center"><%=syzjqs %></td>
	<%
		//剩余租金
		partSql = " select dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','syzj') as r";
		rs1 = db1.executeQuery(partSql);
		if(rs1.next()){
			syzj = getDBStr( rs1.getString("r") );
		}else{syzj = "0";}
		rs1.close();
	%>
	<td align="center"><%=CurrencyUtil.convertFinance(syzj) %></td>
	<%
		//剩余本金
		partSql = " select dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','sybj') as r";
		rs1 = db1.executeQuery(partSql);
		if(rs1.next()){
			sybj = getDBStr( rs1.getString("r") );
		}else{sybj = "0";}
		rs1.close();
	%>
	<td align="center"><%=CurrencyUtil.convertFinance(sybj) %></td>
	<%
		//逾期租金
		partSql = " select dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','yqzj') as r";
		rs1 = db1.executeQuery(partSql);
		if(rs1.next()){
			yqzj = getDBStr( rs1.getString("r") );
		}else{yqzj = "0";}
		rs1.close();
	%>
	<td align="center"><%=CurrencyUtil.convertFinance(yqzj) %></td>
	<%
		//逾期天数
		partSql = " select dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','yqts') as r";
		rs1 = db1.executeQuery(partSql);
		if(rs1.next()){
			yqts = getDBStr( rs1.getString("r") );
		}else{yqts = "0";}
		rs1.close();
	%>
	<td align="center"><%=yqts %></td>
	<%
		//违约金合计
		partSql = " select dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','wyjhj') as r";
		rs1 = db1.executeQuery(partSql);
		if(rs1.next()){
			wyjhj = getDBStr( rs1.getString("r") );
		}else{wyjhj = "0";}
		rs1.close();
	%>
	<td align="center"><%=CurrencyUtil.convertFinance(wyjhj) %></td>
	<%
		//已收违约金
		partSql = " select dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','yswyj') as r";
		rs1 = db1.executeQuery(partSql);
		if(rs1.next()){
			yswyj = getDBStr( rs1.getString("r") );
		}else{yswyj = "0";}
		rs1.close();
	%>
	<td align="center"><%=CurrencyUtil.convertFinance(yswyj) %></td>
	<%
		//未收违约金
		if(wyjhj==null || "".equals(wyjhj)){
			wyjhj = "0";
		}
		if(yswyj==null || "".equals(yswyj)){
			yswyj = "0";
		}
		wswyj = String.valueOf(Double.parseDouble(wyjhj)-Double.parseDouble(yswyj));
	%>
	<td align="center"><%=wswyj %></td>
	<%
		//逾期期数
		partSql = " select dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','yqqs') as r";
		rs1 = db1.executeQuery(partSql);
		if(rs1.next()){
			yqqs = getDBStr( rs1.getString("r") );
		}else{yqqs = "0";}
		rs1.close();
	%>
	<td align="center"><%=yqqs %></td>
	<%
		//累计逾期
		partSql = " select dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','ljyq') as r";
		rs1 = db1.executeQuery(partSql);
		if(rs1.next()){
			ljyq = getDBStr( rs1.getString("r") );
		}else{ljyq = "0";}
		rs1.close();
	%>
	<td align="center"><%=ljyq %></td>
</tr>
<% }
rs.close(); 
db.close();
db1.close();
%>  
</tbody></table>
</div><!--报表结束-->
</form>
</body>
</html>
