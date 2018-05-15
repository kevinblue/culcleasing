<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
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

	<script Language="Javascript" src="../../js/jquery.js"></script>
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

<body onload="public_onload(0);">
<form action="netpay_5result_report.jsp" name="dataNav">
<%
wherestr=" and 1=1 ";

int year = getInt(request.getParameter("cho_year"), getCurrentDatePart(1));
int month = getInt(request.getParameter("cho_month"), getCurrentDatePart(2));
	
sqlstr = " select distinct dld,agent_id,manufacturer from v_zzs_dld_stat ";
sqlstr+= " where proj_id in( ";
sqlstr+= " select proj_id from fund_rent_plan ";
sqlstr+= " where year(plan_date)="+year+" and month(plan_date)="+month+" ";
sqlstr+= " and day(plan_date)=5 and rent_list<>1 ";
sqlstr+= " )union ";
sqlstr+= " select '' as dld,'0' as agent_id,zzsmc as manufacturer from jb_zlwjzzs ";
sqlstr+= " order by manufacturer ";

%>

<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		  租金统计&gt;<font color="color:red;"><%=year %>年<%=month %>月</font>&gt;5日扣款结果
		</td>
	</tr>
</table><!--标题结束-->

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="1" cellpadding="0">
<tr>
<td>选择年份：&nbsp;
<select name="cho_year" onblur="selectToNow()">
<option value="0"></option>
<script type="text/javascript">
for(var i=<%=getCurrentDatePart(1) %>;i><%=getCurrentDatePart(1)-5 %>;i--){
	document.write("<option value='"+i+"'>"+i+"</option>");
}
</script>
</select>
</td>
<td>选择月份：&nbsp;
<select name="cho_month" onblur="selectToNow()">
<option value="0"></option>
<script type="text/javascript">
for(var i=1;i<=12;i++){
	document.write("<option value='"+i+"'>"+i+"</option>");
}
</script>
</select>
</td>

<td colspan="2">
<input type="button" onclick="dataNav.submit()" value="查询">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" onclick="clearQuery()" value="清空"></td>
</tr>
</table>
</fieldset>
<script type="text/javascript">
$("select[name='cho_year']").val(<%=year %>);
$("select[name='cho_month']").val(<%=month %>);
</script>
</div><!-- 查询条件结束 -->

<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
		<td align="left" width="1%">
		<!--操作按钮开始-->
		<table border="0" cellspacing="0" cellpadding="0" >    
			<tr class="maintab">
				<td>
				<BUTTON class="btn_2"  type="button" onclick="exportData();">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>
				</td>
				<!-- 
				<td>
				<BUTTON class="btn_2"  type="button" onclick="return validata_data_exp();">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出PDF</button>
				</td>
				-->
				 <td>
				<img src="../../images/sbtn_split.gif" width="2" height="14">
				</td>
				<td nowrap>
				</td><!--操作按钮结束-->
			</tr>
		</table><!--操作按钮结束-->
		</td>
		<td align="right" width="90%">
		<!-- 翻页控制开始 -->
		<%@ include file="../../public/pageSplitNoCode.jsp"%>
		<!--翻页控制结束-->	
		</td>
	</tr>
</table>
 
<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" style="border-collapse:collapse;" align="center"
	cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
	<tr class="maintab_content_table_title">
        <th>序号</th>
		<th>代理商</th>
        <th>款项内容</th>
		
		<th colspan="4" style="font-weight: bold;">5日扣款结果</th>
		<th colspan="3" style="font-weight: bold;">10日扣款结果</th>
		<th colspan="3" style="font-weight: bold;">15日扣款结果</th>
	</tr>
	<tr class="maintab_content_table_title">
	    <th></th>
		<th></th>
        <th></th>
		<th colspan="4" style="font-weight: bold;color: blue;">扣款笔数</th>
		<th colspan="3" style="font-weight: bold;color: blue;">扣款笔数</th>
		<th colspan="3" style="font-weight: bold;color: blue;">扣款笔数</th>
	</tr>
	<tr class="maintab_content_table_title">
		<th></th>
		<th></th>
        <th></th>
		<th>应扣</th>
		<th>成功</th>
		<th>失败</th>
		<th>失败比率(%)</th>
		
		<th>成功</th>
		<th>失败</th>
		<th>失败比率(%)</th>
		
		<th>成功</th>
		<th>失败</th>
		<th>失败比率(%)</th>
	</tr>
<tbody id="data">
<%
ResultSet rs1 = null;
//=======定义变量区======
String partSql = "";
String agent_id = "";
String zzsmc = "";
//-扣款笔数-
int rent_yk = 0;//租金应扣
int rent_succ = 0;//租金扣款成功
int rent_fail = 0;//租金扣款失败
double rent_fail_ratio = 0f;//租金扣款失败比率

int penalty_yk = 0;//违约金应扣 = 未核销+核销日期介于当月20与下月5号之间
int penalty_succ = 0;//违约金扣款成功
int penalty_fail = 0;//违约金扣款失败
double penalty_fail_ratio = 0f;//违约金扣款失败比率

//-失败台量-
int equip_fail = 0;//失败 = 失败导致项目的租赁物总台量
int equip_fail_1 = 0;//导致一期逾期
int equip_fail_2 = 0;//导致二期逾期
int equip_fail_3 = 0;//导致三期逾期
int equip_fail_up3 = 0;//导致超三期逾期

//----------------

//=======定义变量区======
int startIndex = (intPage-1)*intPageSize+1;
if ( intRowCount!=0) {
	while( i < intPageSize && !rs.isAfterLast() ) {
	agent_id = getDBStr(rs.getString("agent_id"));
	zzsmc = getDBStr(rs.getString("manufacturer"));
%>
	<tr>
		<% if("0".equals(agent_id)){ %>
		<!-- 制造商小计 -->
		<td colspan="2" rowspan="2" align="center" valign="center" style="color:#10418C;font-weight:bold;"><%=zzsmc %>合计</td>
		<% }else { %>
		<td align="center" rowspan="2" align="center" valign="center"><%=startIndex++ %></td>
		<td align="center" rowspan="2" align="center" valign="center"><%=getDBStr(rs.getString("dld")) %></td>
		<% } %>
		<!-- 租金 扣款比数 -->
		<td align="center">租金</td>	
		<%
			//当月应扣
			partSql = "select dbo.t103_rent_netpay_5result("+year+","+month+",'"+agent_id+"','"+zzsmc+"',1) as amount ";
			rs1 = db1.executeQuery(partSql);
			if(rs1.next()){
				rent_yk = rs1.getInt("amount");
			} 
			rs1.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_yk+"") %></td>
		<%
			//成功
			partSql = "select dbo.t103_rent_netpay_5result("+year+","+month+",'"+agent_id+"','"+zzsmc+"',2) as amount ";
			rs1 = db1.executeQuery(partSql);
			if(rs1.next()){
				rent_succ = rs1.getInt("amount");
			} 
			rs1.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_succ+"") %></td>
		<%
			//失败
			rent_fail = rent_yk - rent_succ;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_fail+"") %></td>
		<%
			//失败比率=失败/应扣
			if(rent_yk!=0){
				rent_fail_ratio = rent_fail*100.00/rent_yk;
			}else{
				rent_fail_ratio = 0f;			
			}
		%>
        <td align="center"><%=CurrencyUtil.convertFinance(rent_fail_ratio) %></td>
        
        <!-- ################### 10日扣款结果 #################### -->
        <%
			//成功
			partSql = "select dbo.t103_rent_netpay_10result("+year+","+month+",'"+agent_id+"','"+zzsmc+"',1) as amount ";
			rs1 = db1.executeQuery(partSql);
			if(rs1.next()){
				rent_succ = rs1.getInt("amount");
			} 
			rs1.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_succ+"") %></td>
		<%
			//失败
			rent_fail = rent_fail - rent_succ;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_fail+"") %></td>
		<%
			//失败比率=失败/应扣
			if(rent_yk!=0){
				rent_fail_ratio = rent_fail*100.00/rent_yk;
			}else{
				rent_fail_ratio=0f;
			}
		%>
        <td align="center"><%=CurrencyUtil.convertFinance(rent_fail_ratio) %></td>
		
		<!-- ################### 15日扣款结果 #################### -->
		<%
			//成功
			partSql = "select dbo.t103_rent_netpay_15result("+year+","+month+",'"+agent_id+"','"+zzsmc+"',1) as amount ";
			rs1 = db1.executeQuery(partSql);
			if(rs1.next()){
				rent_succ = rs1.getInt("amount");
			} 
			rs1.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_succ+"") %></td>
		<%
			//失败
			rent_fail = rent_fail - rent_succ;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_fail+"") %></td>
		<%
			//失败比率=失败/应扣
			if(rent_yk!=0){
				rent_fail_ratio = rent_fail*100.00/rent_yk;
			}else{
				rent_fail_ratio=0f;
			}
		%>
        <td align="center"><%=CurrencyUtil.convertFinance(rent_fail_ratio) %></td>
	</tr>
	<tr>
		<!-- 罚息 扣款比数 -->
		<td align="center">罚息</td>	
		<%
			//应扣
			partSql = "select dbo.t103_penalty_netpay_5result("+year+","+month+",'"+agent_id+"','"+zzsmc+"',1) as amount ";
			rs1 = db1.executeQuery(partSql);
			if(rs1.next()){
				penalty_yk = rs1.getInt("amount");
			} 
			rs1.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_yk+"") %></td>
		<%
			//成功
			partSql = "select dbo.t103_penalty_netpay_5result("+year+","+month+",'"+agent_id+"','"+zzsmc+"',2) as amount ";
			rs1 = db1.executeQuery(partSql);
			if(rs1.next()){
				penalty_succ = rs1.getInt("amount");
			} 
			rs1.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_succ+"") %></td>
		<%
			//失败
			penalty_fail = penalty_yk - penalty_succ;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_fail+"") %></td>
		<%
			//失败比率=失败/应扣
			if(penalty_yk!=0){
				penalty_fail_ratio = penalty_fail*100.00/penalty_yk;
			}else{
				penalty_fail_ratio=0f;
			}
		%>
        <td align="center"><%=CurrencyUtil.convertFinance(penalty_fail_ratio) %></td>
        
        <!-- $$$$$$$$$$$$$$$$$$$$$ 10日扣款结果 $$$$$$$$$$$$$$$$$$$$$$ -->
		<%
			//成功
			partSql = "select dbo.t103_penalty_netpay_10result("+year+","+month+",'"+agent_id+"','"+zzsmc+"',1) as amount ";
			rs1 = db1.executeQuery(partSql);
			if(rs1.next()){
				penalty_succ = rs1.getInt("amount");
			} 
			rs1.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_succ+"") %></td>
		<%
			//失败
			penalty_fail = penalty_fail - penalty_succ;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_fail+"") %></td>
		<%
			//失败比率=失败/应扣
			if(penalty_yk!=0){
				penalty_fail_ratio = penalty_fail*100.00/penalty_yk;
			}else{
				penalty_fail_ratio=0f;
			}
		%>
        <td align="center"><%=CurrencyUtil.convertFinance(penalty_fail_ratio) %></td>

        <!-- $$$$$$$$$$$$$$$$$$$$$ 15日扣款结果 $$$$$$$$$$$$$$$$$$$$$$ -->
		<%
			//成功
			partSql = "select dbo.t103_penalty_netpay_15result("+year+","+month+",'"+agent_id+"','"+zzsmc+"',1) as amount ";
			rs1 = db1.executeQuery(partSql);
			if(rs1.next()){
				penalty_succ = rs1.getInt("amount");
			} 
			rs1.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_succ+"") %></td>
		<%
			//失败
			penalty_fail = penalty_fail - penalty_succ;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_fail+"") %></td>
		<%
			//失败比率=失败/应扣
			if(penalty_yk!=0){
				penalty_fail_ratio = penalty_fail*100.00/penalty_yk;
			}else{
				penalty_fail_ratio=0f;
			}
		%>
        <td align="center"><%=CurrencyUtil.convertFinance(penalty_fail_ratio) %></td>
	</tr>
<%
	rs.next();
	i++;
}}
rs.close(); 
db.close();
%>
</tbody>	
</table>
</div><!--报表结束-->
</form>
</body>
<script type="text/javascript">
 function exportData(){
 	if(confirm("是否确定导出excel?")){
 		dataNav.action="netpay_5result_export_save.jsp";
 		dataNav.target="_black";
 		dataNav.submit();
 		dataNav.action="netpay_5result_report.jsp";
 		dataNav.target="_self";
 	}
 }
</script>
</html>